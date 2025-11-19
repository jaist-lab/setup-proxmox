#!/bin/bash
# 1.install_ceph_packages.sh (Proxmox統合Ceph版)

echo "**全ノードで実行:**"

echo "=== Installing Ceph Packages (Downgrade to pve1) ==="

# 外部リポジトリ削除
rm -f /etc/apt/sources.list.d/ceph.list
rm -f /usr/share/keyrings/ceph-archive-keyring.gpg

# パッケージリスト更新
apt-get update

echo ""
echo "Step 1: Downgrading existing packages to pve1..."

# すべてのCephパッケージをpve1にダウングレード
apt-get install -y --allow-downgrades \
    ceph-base=19.2.3-pve1 \
    ceph-common=19.2.3-pve1 \
    ceph-mon=19.2.3-pve1 \
    ceph-mds=19.2.3-pve1 \
    ceph-fuse=19.2.3-pve1 \
    libcephfs2=19.2.3-pve1 \
    librados2=19.2.3-pve1 \
    librbd1=19.2.3-pve1 \
    python3-ceph-argparse=19.2.3-pve1 \
    python3-ceph-common=19.2.3-pve1 \
    python3-cephfs=19.2.3-pve1 \
    python3-rados=19.2.3-pve1 \
    python3-rbd=19.2.3-pve1

echo ""
echo "Step 2: Installing missing packages (pve1)..."

# 不足しているパッケージをインストール
apt-get install -y \
    ceph-mgr=19.2.3-pve1 \
    ceph-osd=19.2.3-pve1 \
    ceph-volume=19.2.3-pve1 \
    libsqlite3-mod-ceph=19.2.3-pve1

echo ""
echo "Step 3: Installing optional packages..."

# オプショナルパッケージ
apt-get install -y \
    radosgw=19.2.3-pve1 \
    ceph=19.2.3-pve1 2>/dev/null || echo "⚠️  ceph metapackage skipped"

echo ""
echo "=== Final Package Status ==="
dpkg -l | grep ceph | grep ^ii

echo ""
echo "Ceph version:"
ceph --version

echo ""
echo "Critical commands check:"
which ceph-mon && echo "✓ ceph-mon available"
which ceph-mgr && echo "✓ ceph-mgr available"
which ceph-osd && echo "✓ ceph-osd available"
which ceph-volume && echo "✓ ceph-volume available"
which monmaptool && echo "✓ monmaptool available"
which ceph-authtool && echo "✓ ceph-authtool available"

echo ""
echo "=== Installation completed ==="
