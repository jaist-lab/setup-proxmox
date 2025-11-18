#!/bin/bash
# 2.system-info-collect.sh

BACKUP_DIR="/root/storage-setup/backups"
LOG_DIR="/root/storage-setup/logs"

echo "=== System Information Collection ==="
echo "Node: $(hostname)"
echo "Date: $(date)"
echo ""

# システム情報
echo "--- OS Information ---"
cat /etc/os-release > ${BACKUP_DIR}/os-release.txt
uname -a > ${BACKUP_DIR}/uname.txt

# ネットワーク情報
echo "--- Network Information ---"
ip addr > ${BACKUP_DIR}/ip-addr.txt
ip route > ${BACKUP_DIR}/ip-route.txt
cat /etc/network/interfaces > ${BACKUP_DIR}/interfaces.txt

# ストレージ情報
echo "--- Storage Information ---"
lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINT > ${BACKUP_DIR}/lsblk.txt
lsblk -f > ${BACKUP_DIR}/lsblk-detail.txt
fdisk -l > ${BACKUP_DIR}/fdisk.txt 2>&1
df -h > ${BACKUP_DIR}/df.txt

# NVMe情報
echo "--- NVMe Devices ---"
if command -v nvme &> /dev/null; then
    nvme list > ${BACKUP_DIR}/nvme-list.txt 2>&1
else
    echo "nvme command not found, installing..."
    apt-get update && apt-get install -y nvme-cli
    nvme list > ${BACKUP_DIR}/nvme-list.txt 2>&1
fi

# PVE情報
echo "--- Proxmox VE Information ---"
pveversion > ${BACKUP_DIR}/pveversion.txt
pvecm status > ${BACKUP_DIR}/pvecm-status.txt 2>&1
pvesm status > ${BACKUP_DIR}/pvesm-status.txt 2>&1

# 既存マウント
mount > ${BACKUP_DIR}/mount.txt

# fstab バックアップ
cp /etc/fstab ${BACKUP_DIR}/fstab.backup

echo ""
echo "Information collected in: ${BACKUP_DIR}"
echo "Logs saved in: ${LOG_DIR}"