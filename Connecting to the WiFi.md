**View all connections**: You can see all your network connections by typing:

```CLI
nmcli con show
```

**Up and down connections**: If you want to enable (up) or disable (down) a specific network connection, you can use:

```CLI
nmcli con up <connection-name>
nmcli con down <connection-name>

```

**View device status**: To see the status of all network devices, use:

```CLI 
nmcli dev status

# Modify or edit a connection: If you need to edit settings # of a connection:

nmcli con edit <connection-name>

```


## Activating the WiFi

```C
systemctl status NetworkManager

```

```CLI 
sudo systemctl start NetworkManager
```

```CLI 
sudo systemctl enable NetworkManager
```