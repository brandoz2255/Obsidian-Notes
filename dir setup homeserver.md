```bash
pi-homelab-infra/
├── ansible/
│   ├── inventory/
│   │   └── hosts.ini
│   ├── playbooks/
│   │   ├── setup-pi-headless.yaml
│   │   ├── install-docker.yaml
│   │   └── configure-wireguard.yaml
│   └── roles/
│       └── common/...
├── k8s/
│   ├── base/
│   │   └── namespace.yaml
│   ├── apps/
│   │   ├── postgres/
│   │   │   └── deployment.yaml
│   │   └── your-dashboard/
│   └── fluxcd/
│       ├── gotk-components.yaml
│       ├── github-sync.yaml
│       └── kustomization.yaml
├── docs/
│   ├── README.md
│   ├── pi-setup-guide.md
│   └── architecture-diagram.png
├── .gitlab-ci.yml
└── .gitignore
```


