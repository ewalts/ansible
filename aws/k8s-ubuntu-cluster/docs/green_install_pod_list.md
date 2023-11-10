#Initial Build Result


This is what you should see running before any manual changes.
---


What should be running after running this.

34.212.3.73 | CHANGED | rc=0 >>

    NAMESPACE         NAME                                           READY   STATUS    RESTARTS   AGE     IP              NODE               NOMINATED NODE   READINESS GATES
    calico-system     pod/calico-kube-controllers-647cc5b474-hbrwf   1/1     Running   0          98s     10.96.159.130   ip-172-31-20-82    <none>           <none>
    calico-system     pod/calico-node-n4wvw                          1/1     Running   0          98s     172.31.20.82    ip-172-31-20-82    <none>           <none>
    calico-system     pod/calico-node-pl28c                          1/1     Running   0          61s     172.31.31.38    ip-172-31-31-38    <none>           <none>
    calico-system     pod/calico-node-vsqbf                          1/1     Running   0          62s     172.31.17.211   ip-172-31-17-211   <none>           <none>
    calico-system     pod/calico-typha-6b6df7c7b5-64p5v              1/1     Running   0          53s     172.31.17.211   ip-172-31-17-211   <none>           <none>
    calico-system     pod/calico-typha-6b6df7c7b5-zv2n2              1/1     Running   0          98s     172.31.20.82    ip-172-31-20-82    <none>           <none>
    calico-system     pod/csi-node-driver-4nwj8                      2/2     Running   0          61s     10.96.40.130    ip-172-31-31-38    <none>           <none>
    calico-system     pod/csi-node-driver-gk8vk                      2/2     Running   0          98s     10.96.159.132   ip-172-31-20-82    <none>           <none>
    calico-system     pod/csi-node-driver-mjmgv                      2/2     Running   0          61s     10.96.33.129    ip-172-31-17-211   <none>           <none>
    cert-manager      pod/cert-manager-7d75f47cc5-mbfzd              1/1     Running   0          93s     10.96.40.131    ip-172-31-31-38    <none>           <none>
    cert-manager      pod/cert-manager-cainjector-c778d44d8-6twhg    1/1     Running   0          93s     10.96.40.132    ip-172-31-31-38    <none>           <none>
    cert-manager      pod/cert-manager-webhook-55d76f97bb-tcw47      1/1     Running   0          93s     10.96.40.129    ip-172-31-31-38    <none>           <none>
    kube-system       pod/coredns-5dd5756b68-cnm76                   1/1     Running   0          7m4s    10.96.159.131   ip-172-31-20-82    <none>           <none>
    kube-system       pod/coredns-5dd5756b68-w5xjg                   1/1     Running   0          7m4s    10.96.159.129   ip-172-31-20-82    <none>           <none>
    kube-system       pod/etcd-ip-172-31-20-82                       1/1     Running   0          7m19s   172.31.20.82    ip-172-31-20-82    <none>           <none>
    kube-system       pod/kube-apiserver-ip-172-31-20-82             1/1     Running   0          7m16s   172.31.20.82    ip-172-31-20-82    <none>           <none>
    kube-system       pod/kube-controller-manager-ip-172-31-20-82    1/1     Running   0          7m16s   172.31.20.82    ip-172-31-20-82    <none>           <none>
    kube-system       pod/kube-proxy-g4nnx                           1/1     Running   0          62s     172.31.17.211   ip-172-31-17-211   <none>           <none>
    kube-system       pod/kube-proxy-mv9tl                           1/1     Running   0          61s     172.31.31.38    ip-172-31-31-38    <none>           <none>
    kube-system       pod/kube-proxy-wvp7v                           1/1     Running   0          7m4s    172.31.20.82    ip-172-31-20-82    <none>           <none>
    kube-system       pod/kube-scheduler-ip-172-31-20-82             1/1     Running   0          7m19s   172.31.20.82    ip-172-31-20-82    <none>           <none>
    tigera-operator   pod/tigera-operator-597bf4ddf6-t9ptt           1/1     Running   0          6m49s   172.31.20.82    ip-172-31-20-82    <none>           <none>
    
    NAMESPACE       NAME                                      TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                  AGE     SELECTOR
    calico-system   service/calico-kube-controllers-metrics   ClusterIP   None             <none>        9094/TCP                 47s     k8s-app=calico-kube-controllers
    calico-system   service/calico-typha                      ClusterIP   10.102.226.174   <none>        5473/TCP                 99s     k8s-app=calico-typha
    cert-manager    service/cert-manager                      ClusterIP   10.96.182.40     <none>        9402/TCP                 93s     app.kubernetes.io/component=controller,app.kubernetes.io/instance=cert-manager,app.kubernetes.io/name=cert-manager
    cert-manager    service/cert-manager-webhook              ClusterIP   10.110.204.47    <none>        443/TCP                  93s     app.kubernetes.io/component=webhook,app.kubernetes.io/instance=cert-manager,app.kubernetes.io/name=webhook
    default         service/kubernetes                        ClusterIP   10.96.0.1        <none>        443/TCP                  7m18s   <none>
    kube-system     service/kube-dns                          ClusterIP   10.96.0.10       <none>        53/UDP,53/TCP,9153/TCP   7m17s   k8s-app=kube-dns
    
    NAMESPACE       NAME                             DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE     CONTAINERS                             IMAGES                SELECTOR
    calico-system   daemonset.apps/calico-node       3         3         3       3            3           kubernetes.io/os=linux   98s     calico-node                            docker.io/calico...   k8s-app=calico-node
    calico-system   daemonset.apps/csi-node-driver   3         3         3       3            3           kubernetes.io/os=linux   98s     calico-csi,csi-node-driver-registrar   docker.io/calico...   k8s-app=csi-node-driver
    kube-system     daemonset.apps/kube-proxy        3         3         3       3            3           kubernetes.io/os=linux   7m17s   kube-proxy                             registry.k8s.io...    k8s-app=kube-proxy
    
    NAMESPACE         NAME                                      READY   UP-TO-DATE   AVAILABLE   AGE     CONTAINERS                IMAGES                                             SELECTOR
    calico-system     deployment.apps/calico-kube-controllers   1/1     1            1           99s     calico-kube-controllers   docker.io/calico/kube-controllers:v3.26.3          k8s-app=calico-kube-controllers
    calico-system     deployment.apps/calico-typha              2/2     2            2           99s     calico-typha              docker.io/calico/typha:v3.26.3                     k8s-app=calico-typha
    cert-manager      deployment.apps/cert-manager              1/1     1            1           94s     cert-manager-controller   quay.io/jetstack/cert-manager-controller:v1.13.2   app.kubernetes...
    cert-manager      deployment.apps/cert-manager-cainjector   1/1     1            1           94s     cert-manager-cainjector   quay.io/jetstack/cert-manager-cainjector:v1.13.2   app.kubernetes...
    cert-manager      deployment.apps/cert-manager-webhook      1/1     1            1           94s     cert-manager-webhook      quay.io/jetstack/cert-manager-webhook:v1.13.2      app.kubernetes....
    kube-system       deployment.apps/coredns                   2/2     2            2           7m18s   coredns                   registry.k8s.io/coredns/coredns:v1.10.1            k8s-app=kube-dns
    tigera-operator   deployment.apps/tigera-operator           1/1     1            1           6m50s   tigera-operator           quay.io/tigera/operator:v1.30.7                    name=tigera-operator
    
    NAMESPACE         NAME                                                 DESIRED   CURRENT   READY   AGE     CONTAINERS                IMAGES                                             SELECTOR
    calico-system     replicaset.apps/calico-kube-controllers-647cc5b474   1         1         1       99s     calico-kube-controllers   docker.io/calico/kube-controllers:v3.26.3          k8s-app=calico-kube-controllers,pod-template-hash=647cc5b474
    calico-system     replicaset.apps/calico-typha-6b6df7c7b5              2         2         2       99s     calico-typha              docker.io/calico/typha:v3.26.3                     k8s-app=calico-typha,pod-template-hash=6b6df7c7b5
    cert-manager      replicaset.apps/cert-manager-7d75f47cc5              1         1         1       94s     cert-manager-controller   quay.io/jetstack/cert-manager-controller:v1.13.2   app.kubernetes.io/component=controller,app.kubern...
    cert-manager      replicaset.apps/cert-manager-cainjector-c778d44d8    1         1         1       94s     cert-manager-cainjector   quay.io/jetstack/cert-manager-cainjector:v1.13.2   app.kubernetes.io/component=cainjector,app.k...
    cert-manager      replicaset.apps/cert-manager-webhook-55d76f97bb      1         1         1       94s     cert-manager-webhook      quay.io/jetstack/cert-manager-webhook:v1.13.2      app.kubernetes.io/component=webhook,ap...
    kube-system       replicaset.apps/coredns-5dd5756b68                   2         2         2       7m5s    coredns                   registry.k8s.io/coredns/coredns:v1.10.1            k8s-app=kube-dns,pod-template-hash=5dd5756b68
    tigera-operator   replicaset.apps/tigera-operator-597bf4ddf6           1         1         1       6m50s   tigera-operator           quay.io/tigera/operator:v1.30.7                    name=tigera-operator,pod-template-hash=597bf4ddf6
    
