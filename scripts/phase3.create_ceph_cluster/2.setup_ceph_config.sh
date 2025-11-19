#!/bin/bash
# ceph-config-create.sh

echo "**r760xs1で実行 (管理ノード):**"

CEPH_CONF="/etc/ceph/ceph.conf"
CLUSTER_NAME="ceph"
FSID=$(uuidgen)

cat > ${CEPH_CONF} << EOF
[global]
# クラスタ基本設定
fsid = ${FSID}
cluster = ${CLUSTER_NAME}
mon_initial_members = r760xs1
mon_host = 172.16.200.11

# 認証設定
auth_cluster_required = cephx
auth_service_required = cephx
auth_client_required = cephx

# ネットワーク設定
public_network = 172.16.100.0/24
cluster_network = 172.16.200.0/24

# メッセージングプロトコル
ms_bind_msgr1 = true
ms_bind_msgr2 = true

# Monitor設定
mon_allow_pool_delete = false
mon_max_pg_per_osd = 300

# OSD設定
osd_pool_default_size = 3
osd_pool_default_min_size = 2
osd_pool_default_pg_num = 128
osd_pool_default_pgp_num = 128

# BlueStore設定
osd_objectstore = bluestore

[mon]
mon_data_avail_warn = 15
mon_data_avail_crit = 10

[osd]
osd_memory_target = 4294967296  # 4GB per OSD

[mgr]
mgr/dashboard/ssl = true
mgr/dashboard/ssl_server_port = 8443

[mds]
mds_cache_memory_limit = 4294967296  # 4GB
EOF

echo "Ceph configuration created: ${CEPH_CONF}"
cat ${CEPH_CONF}

# FSIDを記録
mkdir -p /root/storage-setup/logs
echo ${FSID} > /root/storage-setup/logs/ceph-fsid.txt
echo "FSID saved to: /root/storage-setup/logs/ceph-fsid.txt"
