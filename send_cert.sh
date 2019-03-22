# 根据实际情况修改以下HOSTNAMES变量
export CONTROL_PLANE_IPS="k8s-master02 k8s-master03"

# 把证书复制到其他master节点
for host in ${CONTROL_PLANE_IPS}; do
  scp /etc/kubernetes/pki/ca.crt $host:/etc/kubernetes/pki/ca.crt
  scp /etc/kubernetes/pki/ca.key $host:/etc/kubernetes/pki/ca.key
  scp /etc/kubernetes/pki/sa.key $host:/etc/kubernetes/pki/sa.key
  scp /etc/kubernetes/pki/sa.pub $host:/etc/kubernetes/pki/sa.pub
  scp /etc/kubernetes/pki/front-proxy-ca.crt $host:/etc/kubernetes/pki/front-proxy-ca.crt
  scp /etc/kubernetes/pki/front-proxy-ca.key $host:/etc/kubernetes/pki/front-proxy-ca.key
  scp /etc/kubernetes/pki/etcd/ca.crt $host:/etc/kubernetes/pki/etcd/ca.crt
  scp /etc/kubernetes/pki/etcd/ca.key $host:/etc/kubernetes/pki/etcd/ca.key
  scp /etc/kubernetes/admin.conf $host:/etc/kubernetes/admin.conf
done
