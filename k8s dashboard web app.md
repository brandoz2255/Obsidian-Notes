To create a Next.js/Go web UI that integrates with your containerized home services (Grafana, Prometheus, VPN, Bitwarden), use this architecture:

- [[frontend]] 
- [[backend]]
- [[Readme.dashboard]]

## Core Components

**1. Service Proxy Layer (Go Backend)**


- Route external service UIs through authenticated endpoints:
    
    - `/grafana/*` → Grafana container (port 3000)
    - `/bitwarden/*` → Bitwarden container (port 8080)
    - `/vpn/*` → VPN admin interface[](https://www.theengineeringprojects.com/2022/09/self-host-bitwarden-in-raspberry-pi-4.html)

**3. Embedded Metrics Pipeline**

| Component         | Technology   | Purpose                             |
| ----------------- | ------------ | ----------------------------------- |
| Metrics Collector | Go client-go | Kubernetes API polling (pods/nodes) |
| Stream Gateway    | WebSocket    | Real-time updates to frontend       |
| Cache Layer       |              |                                     |



## Security Implementation

**Authentication Flow**

1. VPN login grants JWT token
    
2. Token passed via HTTP headers to backend
    
3. Go middleware validates access

## Deployment Configuration

**docker-compose.yml Excerpt**

```yaml
version: '3.8'

services:
  webui:
    build: ./web-ui
    ports:
      - "80:3000"
    depends_on:
      - prometheus
      - grafana
    environment:
      GRAFANA_URL: http://grafana:3000
      BITWARDEN_URL: http://bitwarden:8080

  backend:
    build: ./go-backend
    ports:
      - "8081:8080"
    volumes:
      - kubeconfig:/root/.kube
```


## Performance Optimization

- **Next.js ISR**: Pre-render service status pages every 60s
    
- **Go Connection Pooling**: Maintain persistent connections to Kubernetes API
    
- **Edge Caching**: Cache common Prometheus queries like `sum(kube_pod_container_resource_limits{resource="cpu"})`
    

This architecture lets you view cluster metrics within the web UI while maintaining secure access to full service UIs through authenticated proxy endpoints. The Go backend handles heavy Kubernetes/Prometheus interactions, while Next.js manages the responsive dashboard interface[](https://engineering.bharatpe.com/next-js-monitoring-from-setup-to-visualisation-with-prometheus-and-grafana-03f5f0416764)

[](https://artofinfra.com/monitor-raspberry-pi-and-linux-metrics-with-grafana-prometheus-on-docker/).