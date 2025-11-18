#!/bin/bash
# nvme-device-assignment.sh3

echo "=== NVMe Device Assignment Plan ==="
echo "Node: $(hostname)"
echo "Date: $(date)"
echo ""

echo "--- Available NVMe Devices ---"
lsblk -d -o NAME,SIZE,MODEL,SERIAL | grep nvme

echo ""
echo "--- Recommended Assignment ---"
echo "Local Storage (etcd, logs):"
echo "  Device: /dev/nvme0n1"
lsblk -o NAME,SIZE,MODEL /dev/nvme0n1

echo ""
echo "Ceph OSD (distributed storage):"
for dev in /dev/nvme{1..10}n1; do
    if [ -b "$dev" ]; then
        echo "  Device: $dev ($(lsblk -dno SIZE $dev))"
    fi
done

echo ""
echo "--- Device Status Check ---"
for dev in /dev/nvme*n1; do
    if [ -b "$dev" ]; then
        echo "Device: $dev"
        if mount | grep -q "$dev"; then
            echo "  Status: IN USE (Mounted)"
            mount | grep "$dev"
        elif pvdisplay 2>/dev/null | grep -q "$dev"; then
            echo "  Status: IN USE (LVM PV)"
        elif wipefs "$dev" 2>/dev/null | grep -q .; then
            echo "  Status: Has filesystem signatures"
            wipefs "$dev"
        else
            echo "  Status: AVAILABLE (Clean)"
        fi
        echo ""
    fi
done
