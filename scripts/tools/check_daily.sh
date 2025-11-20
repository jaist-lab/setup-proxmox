#!/bin/bash

echo "# クラスタ健全性チェック"
ceph -s
ceph health detail
echo " "

echo "# ストレージ容量確認"
ceph df
df -h /var/lib/local-nvme
echo " "

echo "# OSD状態確認"
ceph osd tree
ceph osd df tree

echo " "
echo "# パフォーマンス確認"
ceph osd perf
