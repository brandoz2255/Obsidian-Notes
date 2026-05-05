# Finding an evil twin with wireshark 
- first things first we must identify the evil twin first we can do so in the wireless tab under the WLAN section with the filter of `(wlan.fc.type == 00) and (wlan.fc.type_subtype == 8)`
- However this is only specific to the Etwin attack on the assingment im guessing if we do this raw we must  find everything our selves so we can look for the broadcast section and there should be two the ETwin and the OG one 
- in this case we use the filter to filter out only probes that the ETwin did to our network `(wlan.bssid == F8:14:FE:4D:E6:F2)` 
- hear we must look at all the logs and find the ARP protocol with the ARP protocol  
And the victim is the source addresses 