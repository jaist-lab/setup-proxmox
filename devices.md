**結果を記録シートに記入:**

```yaml
# デバイス割り当て記録シート

r760xs1:
  local_storage: /dev/nvme0n1 (3.7TiB)
  ceph_osds:
    - /dev/nvme1n1 (3.7TiB)
    - /dev/nvme2n1 (3.7TiB)
    - /dev/nvme3n1 (3.7TiB)
    - /dev/nvme4n1 (3.7TiB)

r760xs2:
  local_storage: /dev/nvme0n1 (3.7TiB)
  ceph_osds:
    - /dev/nvme1n1 (3.7TiB)
    - /dev/nvme2n1 (3.7TiB)
    - /dev/nvme3n1 (3.7TiB)
    - /dev/nvme4n1 (3.7TiB)
    - /dev/nvme5n1 (3.7TiB)

# r760xs3-5も同様に記録
```