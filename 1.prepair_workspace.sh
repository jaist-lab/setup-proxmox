#!/bin/bash
set -e
# 1.prepair_workspace.sh

echo "**全ノードで実行:**"

# 作業ディレクトリ作成
mkdir -p /root/storage-setup/{logs,scripts,backups}
cd /root/storage-setup

# ログファイル初期化
cat > /root/storage-setup/logs/setup.log << 'EOF'
========================================
Storage Setup Log
========================================
Node: $(hostname)
Date: $(date)
========================================
EOF

# タイムスタンプ関数
timestamp_log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a /root/storage-setup/logs/setup.log
}

timestamp_log "Storage setup started"