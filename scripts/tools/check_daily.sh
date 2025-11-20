#!/bin/bash

# クラスタ健全性チェック
ceph -s
ceph health detail

# ストレージ容量確認
ceph df
df -h /var/lib/local-nvme

# OSD状態確認
ceph osd tree
ceph osd df tree

# パフォーマンス確認
ceph osd perf
