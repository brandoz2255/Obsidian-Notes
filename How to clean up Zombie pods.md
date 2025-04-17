K8s being as robust as it is it keeps regernating a pod after updating manifests due to is high level on focusing on the availability from the CIA triad which sometimes keeps zombie pods due to broken copies 

- here is how we can wipe them 


```bash
kubectl delete pod -n default -l app=pgadmin --force --grace-period=0
```


- Replace app with the name of your corresponding  app

