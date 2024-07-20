# LAN and WAN protocols

#### LAN Protocols

**LAN (Local Area Network)** protocols are designed for small geographical areas, such as a single building or campus. They handle data transfer within these local environments.

- **Ethernet**: The most widely used LAN technology, it uses protocols like IEEE 802.3. Ethernet can operate at different speeds, including 10 Mbps, 100 Mbps (Fast Ethernet), 1 Gbps (Gigabit Ethernet), and 10 Gbps.

- **Wi-Fi**: Wireless LAN technology that uses IEEE 802.11 standards. Wi-Fi allows devices to connect wirelessly within a local area network.

- **Token Ring**: An older LAN technology that uses a token-passing method to control access to the network. It's not commonly used today but is part of the historical context of LANs.

#### WAN Protocols

**WAN (Wide Area Network)** protocols are designed to cover large geographical areas, such as cities, countries, or even continents. They handle data transfer over long distances.

- **MPLS (Multiprotocol Label Switching)**: A technique used to speed up and shape traffic flows across enterprise WANs and service provider networks.

- **Frame Relay**: An older WAN technology used for connecting *local area networks* (**LANs**) over long distances. It’s packet-switched and offers variable bandwidth.

- **ATM (Asynchronous Transfer Mode)**: A high-speed networking standard designed for voice and data communications. It uses fixed-size cells to ensure a reliable transfer.

- **PPP (Point-to-Point Protocol)**: A data link protocol commonly used for direct connections between two networking nodes. It’s often used for internet dial-up connections.

- **HDLC (High-Level Data Link Control)**: A bit-oriented code-transparent synchronous data link layer protocol developed by the*International Organization for Standardization* (**ISO**).

# CLI tools

CLI Tools: tools used in the CLI we use them all the time. 

#### Common CLI Tools

- **Cisco IOS CLI**: The primary interface for configuring Cisco devices.
- **Ping**: A tool used to test connectivity between devices on a network.
- **Traceroute**: A tool used to determine the path packets take to reach a destination.
- **Show Commands**: Various commands in Cisco IOS to display configuration, status, and statistics (e.g., `show running-config`, `show ip interface brief`).
- **Configuration Commands**: Commands used to configure devices, including setting IP addresses, routing protocols, and security settings.
- **Debug Commands**: Commands used to troubleshoot and debug network issues (e.g., `debug ip packet`).

#### Cisco IOS CLI

- **Navigating the CLI**:
    
    - Understand how to access different modes: User EXEC mode (`>`), Privileged EXEC mode (`#`), Global Configuration mode (`(config)#`), and specific configuration modes (e.g., interface, router).
    - Know how to use context-sensitive help (`?`) to get command options.
    - Command history and editing features (using arrow keys, `Ctrl+P`, `Ctrl+N`).
- **Basic Configuration Commands**:
    
    - **Hostname**: `hostname [name]`
    - **IP Address**: `interface [type/number]`, `ip address [IP address] [subnet mask]`
    - **Descriptions**: `description [text]`
    - **Banner**: `banner motd #[message]#`
- **Show Commands**:
    
    - **Show Running Configuration**: `show running-config`
    - **Show IP Interface Brief**: `show ip interface brief`
    - **Show Version**: `show version`
    - **Show Interfaces**: `show interfaces`
    - **Show VLANs**: `show vlan`
    - **Show ARP**: `show arp`
    - **Show Routes**: `show ip route`
- **Ping and Traceroute**:
    
    - **Ping**: `ping [IP address]` to test connectivity.
    - **Traceroute**: `traceroute [IP address]` to trace the path packets take to a destination.
- **Basic Debug Commands**:
    
    - **Debug IP Packet**: `debug ip packet` to troubleshoot packet flow.
    - **Debugging**: Be cautious with debug commands as they can be CPU intensive.


**Troubleshooting Network Connectivity**: This involves a systematic approach to diagnose and resolve issues that prevent devices from communicating over a network. 

- Effective troubleshooting requires understanding the OSI model, common network protocols, and tools used to diagnose network problems.


#### Steps for Troubleshooting

1. **Identify the Problem**:
    
    - **Gather Information**: Ask questions to understand the symptoms. Check for error messages or alerts.
    - **Define the Problem**: Clearly outline what is not working as expected.
2. **Establish a Theory of Probable Cause**:
    
    - **Layered Approach**: Use the OSI model to identify potential causes. Start from the Physical layer and move up.
    - **Common Issues**: Consider common problems like loose cables, misconfigurations, or software issues.
3. **Test the Theory to Determine Cause**:
    
    - Use tools and commands to test hypotheses. For example, if you suspect a cable issue, try replacing it or testing it with another device.
4. **Establish a Plan of Action and Implement the Solution**:
    
    - Once the cause is determined, plan how to resolve it. This could involve reconfiguring settings, replacing hardware, or updating software.
5. **Verify Full System Functionality**:
    
    - Ensure that the solution has restored full network functionality. Test all affected areas to confirm.
6. **Document Findings, Actions, and Outcomes**:
    
    - Keep detailed records of the problem, the steps taken to resolve it, and the final outcome. This helps in future troubleshooting efforts.

This is also known as the IT troubleshoot processes Howeve this could be used in debugging code. 