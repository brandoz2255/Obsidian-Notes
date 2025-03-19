- A more simpler method for `Grafana` 
- for `grafana` make sure that these `yaml` manifests are located on your control node for example my control node is my main  `PC`
- Then in the same directory `kubectl apply -f grafana/`
	- or whatever name you gave your `grafana` folder with all the `yaml` manifests

then to access it you can use the `ip` from the output in this command 

```bash
kubectl get svc grafana -n monitoring
```

- it will be in cluster `ip`

if that does not work like in my case you can `portforward` to more accessible location like `localhost`

```bash
kubectl port-forward -n monitoring svc/grafana 3000:3000
```

