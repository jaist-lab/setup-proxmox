#!/bin/bash
# 設定ファイルが正しく共有されているか確認
cat /etc/ceph/ceph.conf

echo " "
echo "# 他ノードでも同じ内容が見えるか確認"
for node in r760xs{2..5}; do
    echo "=== ${node} ==="
    ssh ${node} "cat /etc/pve/ceph.conf 2>/dev/null | head -5"
    echo ""
done
