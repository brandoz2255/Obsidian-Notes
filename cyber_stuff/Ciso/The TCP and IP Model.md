 Gets theoretical very fast

## The Father Network
- In the 1960s, various groups were making network hardware, including IBM devices.
- Eventually, the ARPANET program was initiated to connect universities together.

## ARPANET
- ARPANET aimed to connect multiple universities.

## OSI Model
- OSI stands for Open System Interconnections.
- It provides communication standards for diverse machines to connect.
- Consists of seven layers.
- Layers work from those needing protection (Layer 7 to 1) to those not concerned with sausage pizza being thrown around (Layer 1 to 7).

- **PDU (Protocol Data Unit)**:
  - Physical PDU = *bits*
  - Data PDU = Frames
  - Network PDU = Packets
  - Transport = Segments

### TCP/IP Model is More Realistic Compared to the OSI Model
#### Physical Layer
- Focuses on the bits and pieces.
- Manages how bits get across a network (electrical pulses related to TCP and IP).
- Represents cabling standards and physical devices.
- Decides when sending and receiving bits start.
- Handles multiple transmissions at once.
- Real-world network topology.
- Bits flow through cables (fiber, Ethernet, etc.).
- Decides which cabling standards to use.
- Involves inserting cables into end device NICs.
- Bits need encoding methods for proper electronic flow (e.g., AMI).

#### Bits Synchronization
- To communicate, senders and receivers must decide when bits start and stop.
- Two synchronization standards:
  - Async: One-way communication using start and stop bits to control speed.
  - Sync: Bits flow at an agreed speed between sender and receiver.

## Physical Address
- In Layer 2, bits are converted into legible formatted frames.
- Two main actions in the second layer:
  - MAC (Media Access Control)
  - LLC (Logical Link Control)

### MAC
- Assigns a physical address to the stream of bits.
- Decides data transmission flow through access.

### Logical Link Layer
- Handles errors in the connections' frames.

### The Network Layer
- Takes frames with physical addressing and logical addressing (with IP).
- Uses packet switching.

### Packet Switching
- Decides forwarding decisions of a packet based on its definition.
- Switching determines the port to forward to based on the incoming port.

### Transport Layer
- Decides which networking protocol to use.
- Sits between TCP and UDP.
- Handles windowing.
- Implements buffering.

## TCP (Transmission Control Protocol)
- Reliable communication.
- Initiates a three-way handshake and has a checksum per packet.
- Each packet sent is assigned a number and replicated in case of packet failure.

## UDP (User Datagram Protocol)
- Unreliable, simply blasts out the information.
- Doesn't care if it gets from point A to point B; the main priority is to send out info.

### Windowing
- Windowing determines how much data is possible to send before receiving an acknowledgement block.
- Buffering is the buffer when a video stops and buffers due to dropped packets (taildrop).

### The Application Layer
- Provides an interface between the software running on the computer and the network.
- Handles formatting in the proper format for the kind of traffic being generated.
- Encryption encrypts the data during the session as decided by the app (e.g., SSL/TLS, SSH, PGP).

### Session
- Establishes, manages, and maintains connections between devices.
- Breaks data down into smaller segments, managing the flow of data between two devices.
- Cleanly terminates sessions.
