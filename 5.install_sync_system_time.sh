#!/bin/bash
# 5.install_sync_system_time.sh
echo "=== Sync System Time Script Started ==="
# Chronyインストール

echo "**全ノードで実行:**"

# Chronyd状態確認
systemctl status chronyd

# NTP同期状態
chronyc tracking
chronyc sources

# 全ノードの時刻を確認 (r760xs1から実行)
for i in {1..5}; do
    echo "=== r760xs$i ==="
    ssh r760xs$i "date; chronyc tracking | grep 'System time'"
done

echo "**全ノードの時刻ずれが±1秒以内であることを確認してください。**"
echo "=== Sync System Time Script Completed ==="
