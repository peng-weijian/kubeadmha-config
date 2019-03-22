# 设置相关hostname变量
export HOST1=k8s-master01
export HOST2=k8s-master02
export HOST3=k8s-master03

# 把kubeadm配置文件放到各个master节点的/root/目录
scp -r config/$HOST1/kubeadm-config.yaml $HOST1:/root/
scp -r config/$HOST2/kubeadm-config.yaml $HOST2:/root/
scp -r config/$HOST3/kubeadm-config.yaml $HOST3:/root/

# 把keepalived配置文件放到各个master节点的/etc/keepalived/目录
scp -r config/$HOST1/keepalived/* $HOST1:/etc/keepalived/
scp -r config/$HOST2/keepalived/* $HOST2:/etc/keepalived/
scp -r config/$HOST3/keepalived/* $HOST2:/etc/keepalived/

# 把nginx负载均衡配置文件放到各个master节点的/etc/kubernetes/目录
scp -r config/$HOST1/nginx-lb/nginx-lb.conf $HOST1:/etc/kubernetes/
scp -r config/$HOST2/nginx-lb/nginx-lb.conf $HOST2:/etc/kubernetes/
scp -r config/$HOST3/nginx-lb/nginx-lb.conf $HOST3:/etc/kubernetes/

# 把nginx负载均衡部署文件放到各个master节点的/etc/kubernetes/manifests/目录
scp -r config/$HOST1/nginx-lb/nginx-lb.yaml $HOST1:/etc/kubernetes/manifests/
scp -r config/$HOST2/nginx-lb/nginx-lb.yaml $HOST2:/etc/kubernetes/manifests/
scp -r config/$HOST3/nginx-lb/nginx-lb.yaml $HOST3:/etc/kubernetes/manifests/
