# 创建相关的证书以及kubelet配置文件
kubeadm alpha phase certs all --config /root/kubeadm-config.yaml
kubeadm alpha phase kubeconfig controller-manager --config /root/kubeadm-config.yaml
kubeadm alpha phase kubeconfig scheduler --config /root/kubeadm-config.yaml
kubeadm alpha phase kubelet config write-to-disk --config /root/kubeadm-config.yaml
kubeadm alpha phase kubelet write-env-file --config /root/kubeadm-config.yaml
kubeadm alpha phase kubeconfig kubelet --config /root/kubeadm-config.yaml
systemctl restart kubelet

# 设置k8s-master01以及k8s-master02的HOSTNAME以及地址
export CP0_IP=192.168.40.189
export CP0_HOSTNAME=k8s-master01
export CP1_IP=192.168.40.190
export CP1_HOSTNAME=k8s-master02

# etcd集群添加节点
kubectl exec -n kube-system etcd-${CP0_HOSTNAME} -- etcdctl --ca-file /etc/kubernetes/pki/etcd/ca.crt --cert-file /etc/kubernetes/pki/etcd/peer.crt --key-file /etc/kubernetes/pki/etcd/peer.key --endpoints=https://${CP0_IP}:2379 member add ${CP1_HOSTNAME} https://${CP1_IP}:2380
kubeadm alpha phase etcd local --config /root/kubeadm-config.yaml

# 启动master节点
kubeadm alpha phase kubeconfig all --config /root/kubeadm-config.yaml
kubeadm alpha phase controlplane all --config /root/kubeadm-config.yaml
kubeadm alpha phase mark-master --config /root/kubeadm-config.yaml

# 修改/etc/kubernetes/admin.conf的服务地址指向本机
sed -i "s/192.168.40.189:6443/192.168.40.190:6443/g" /etc/kubernetes/admin.conf
