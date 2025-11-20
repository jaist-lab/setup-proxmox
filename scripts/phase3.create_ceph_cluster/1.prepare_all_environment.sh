#!/bin/bash

# r760xs1から全ノードで実行
for node in r760xs{1..5}; do
    echo "=== Preparing ${node} ==="
    ssh root@${node} 'bash -s' < prepare_environment.sh
done

# 全ノードで古い形式のリポジトリファイルを削除
for node in r760xs{1..5}; do
    echo "--- ${node} ---"
    ssh ${node} "rm -f /etc/apt/sources.list.d/ceph.list && echo '✓ Removed ceph.list'"
done

echo ""
echo "=== Repository cleanup completed ==="
