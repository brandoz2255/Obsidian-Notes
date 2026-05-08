---
tags:
  - networking
  - opnsense
  - troubleshooting
  - homelab
created: 2026-05-09
---

# OPNsense Networking Troubleshooting "Golden Path"

## Context
Setting up OPNsense (v25.1) as a gateway for a lab environment involving Kali Linux and VyOS.
*   **OPNsense WAN:** `192.168.2.2` (Gateway via VyOS `192.168.2.100`)
*   **OPNsense LAN:** `172.31.0.2`
*   **Kali VM:** `192.168.2.10`

## Common Errors & Fixes

### 1. "No route to host" (Ping fails to Gateway)
**Cause:** OPNsense doesn't know how to reach the upstream router (VyOS) or lacks a default route.
**Fix:**
1.  **Add Default Route:** Go to **System → Routing → Routes** → Add a new route.
    *   **Destination:** `0.0.0.0/0`
    *   **Gateway:** Select your VyOS gateway (e.g., `tyt` / `192.168.2.100`).
    *   **Description:** `Default via VyOS`
2.  **Verify Gateway:** Ensure the gateway is marked as "Default GW" in **System → Routing → Gateways**.

### 2. "IPv4 address is being used by another interface or VIP"
**Cause:** OPNsense thinks your WAN IP (`192.168.2.2`) is already taken by the LAN, DNS, or a VIP.
**Fix:**
1.  **Check LAN IP:** Ensure **Interfaces → [LAN]** is NOT set to `192.168.2.2`.
2.  **Check DNS Resolver:** Go to **Services → Unbound DNS** and **Disable** it temporarily to release the IP.
3.  **Check Virtual IPs:** Go to **Firewall → Virtual IPs** and ensure no alias uses that IP.

### 3. Kali has no Internet despite Ping to Gateway working
**Cause:** OPNsense blocks private networks on WAN by default, or NAT is misconfigured.
**Fix:**
1.  **Uncheck "Block Bogon Networks":** Go to **Interfaces → [WAN]** → **Generic Configuration** → Uncheck "Block bogon networks" (since `192.168.2.x` is private).
2.  **NAT Rules:** Go to **Firewall → NAT → Outbound**. Switch mode to **Manual/Hybrid** and ensure a rule exists for `192.168.2.0/24` on the WAN interface.
3.  **Firewall Rules:** Go to **Firewall → Rules → WAN** and add a **Pass** rule for Source `192.168.2.0/24`.

## Summary Checklist
- [ ] Default Route added (`0.0.0.0/0` via VyOS)
- [ ] "Block Bogon" unchecked on WAN
- [ ] NAT Mode set to Manual/Hybrid
- [ ] WAN Firewall Rule allows `192.168.2.0/24`
- [ ] "Apply Changes" clicked after every step