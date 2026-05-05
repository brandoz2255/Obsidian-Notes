- Computers think only in base 2 hence binary 
- an IP address is made up of four octets 
- this means each octet is 2^7

## Subnet mask parts

-  Network Bits an identifier of the network
- Host bits represent of how many possible host can be on the network 
124 would be 233.233.233.0 
- 11111111.11111111.11111111 =network bits 
- 000000000000 = d

- remember formula for calculating hosts 
- [ (2^the number of host bits) -2 ]
- There uis two reserved networks for every network 
- network adress the first IP address
- Broadcast addres
- -the last IP address

### the purpose 
- the purpose of subnetting is to breakdown networks we do this for zero trust and 
- 10.10.20.0/24 or /25 do the math 
- 10.10.20.0-127 10.10.20.128 - 256/25 10.10.20.0 -63 
- 
