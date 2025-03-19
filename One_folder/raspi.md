```bash
for i in {30..60}; do touch "$(date +%s%N)-$RANDOM.txt"; sleep 1; done && sudo reboot
```



