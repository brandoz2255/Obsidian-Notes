Controlling the TV via http request definitely a great way to understand how IOT devices work and how they could have some vulnerabliities 

-  Key Idea is to gain Root acess of my TV with Python However the root acess just means verbaly command my TV to do shit for me 
- However this is just to set up an alarm on My tv to wake me up forcing me to get out of bed and go to laptop to stop the process 
- Will need to set up a cron job for this so remember this step here is the AI notes on this

- And it comes with sources 
### AI notes 
To run Python scripts on a TCL Roku TV 55 inch, you would need to use the Roku's External Control Protocol (ECP). However, the Roku's ECP doesn't support Python directly, so you would need to use Python to send HTTP requests to the ECP. Here's a step-by-step guide on how to accomplish this:

1. **Create a Python script to control your Roku TV**: As per the articles from Medium and Dev.to, you can create a Python script to control your Roku TV. This involves creating methods in a Python class and binding that class to a variable for easy access. This way, you can send HTTP requests to the Roku TV to perform various actions like turning on the TV, changing channels, etc. [1](https://medium.com/codex/i-created-a-python-script-to-control-my-roku-tv-d8fb0217308), [2](https://dev.to/davidfree2/i-created-a-python-script-to-control-my-roku-tv-2n40)

```Python 
class Roku:
    def __init__(self, ip, port):
        self.ip = ip
        self.port = port

    # Define methods for controlling the Roku TV
    # ...

# Bind the class to a variable
my_device = Roku('112.111.647.9', '1234')
```

- This is just a python Sample 

2. **Schedule the Python script to run at a specific time**: Once you have the Python script ready, you can schedule it to run at a specific time using a task scheduler. On Windows, you can use Task Scheduler, and on Linux, you can use cron jobs. These tools allow you to run scripts at specific times, which can be useful for setting up an alarm system.

3. **Set up an alarm system**: With the scheduled Python script, you can set up an alarm system that turns on your Roku TV and starts playing a certain channel at a specific time. You can do this by sending HTTP requests to the Roku TV using the Python script. The exact details of how to do this depend on the specific features supported by the Roku TV's ECP, which you can find in the Roku's developer documentation.

Please note that while this approach should technically work, it might require a good understanding of networking, HTTP protocols, and possibly even some reverse engineering if you want to fully understand how to interact with the Roku TV's ECP.

## We need to know
We need to know some basics of networking linking the networking notes here thank you alberto Remember to ask the homie for help if we get stuck 

- However one thing we got no help from is the TV ECP For now my guess is its like the CPU but for the TV however they different names so its gonna be different 

- Judgeing by its name external control protocol it might just been dessinged in which to allow external usage of the TV another guess is this is how the Remote controls the TV 

- Our project will be communicating with it via HTTP request 

## ECP 
Its a restful API that allows any programming language to interact with a ROKU device over a Local area network. 

- We can interact with the ECP from a ROKU device using the CURL command 

### More AI notes 
The External Control Protocol (ECP) is a feature provided by Roku that allows you to control a Roku device over a local area network. It provides several services that enable remote control of the device, such as launching apps, sending key presses, and querying device information [1](https://github.com/tispratik/docs-1/blob/master/develop/guides/remote-api-ecp.md).

ECP is a simple RESTful API that can be accessed by programs in virtually any programming environment. The easiest way to test ECP is to use the cURL command to send POST/GET requests to your network-connected Roku device [1](https://github.com/tispratik/docs-1/blob/master/develop/guides/remote-api-ecp.md).

Here are some of the commands you can use with ECP:

- `keypress/key`: Equivalent to pressing down and releasing the remote control key identified after the slash. Example: `curl -d '' http://ROKU_IP_HERE:8060/keypress/home`.

- `keydown/key`: Equivalent to pressing the remote control key identified after the slash. Example: `curl -d '' http://ROKU_IP_HERE:8060/keydown/left`.

- `keyup/key`: Equivalent to releasing the remote control key identified after the slash. Example: `curl -d '' http://ROKU_IP_HERE:8060/keyup/left`.

- `install/appID`: Exits the current channel, and launches the Channel Store details screen of the channel identified by appID. Example: `curl -d '' 'http://ROKU_IP_HERE:8060/install/8378?contentid=MV005011860000&MediaType=movie'`.

- `launch/appID`: Launches the channel identified by appID. Example: `curl -d '' 'http://ROKU_IP_HERE:8060/launch/dev?streamformat=mp4&url=http%3A%2F%2Fvideo.ted.com%2Ftalks%2Fpodcast%2FVilayanurRamachandran_2007_480.mp4'`.

- `query/device-info`: Retrieves device information similar to that returned by roDeviceInfo. Example: `curl 'http://ROKU_IP_HERE:8060/query/device-info'`.

- `query/active-app`: Returns a child element named 'app' that identifies the active application. Example: `$ curl http://ROKU_IP_HERE:8060/query/active-app`.

- `query/apps`: Returns a map of all the channels installed on the Roku device paired with their application ID. Example: `curl http://192.168.1.134:8060/query/apps`.

- `query/icon/appID`: Returns an icon corresponding to the application identified by appID. Example: `curl 'http://ROKU_IP_HERE:8060/query/icon/12'`.

- `input`: Sends custom events to the current application. Example: `curl -d '' 'http://ROKU_IP_HERE:8060/input?acceleration.x=0.0&acceleration.y=0.0&acceleration.z=9.8'` [1](https://github.com/tispratik/docs-1/blob/master/develop/guides/remote-api-ecp.md).

Remember to replace `ROKU_IP_HERE` with the actual IP address of your Roku device in all the above examples


## Test 
The test was a success we can use cURL to give commands to my ROKU TV via HTTP request by interacting with the ECP with this we can make our Python program do the same 

### More AI notes 

Yes, you can certainly use Python to send HTTP requests to your Roku TV, similar to how you would use `curl` from the command line. Python has a built-in library called `requests` that makes it easy to send HTTP requests.


Another example 
```Python 
import requests

# Replace with your Roku's IP address
roku_ip = 'http://ROKU_IP:8060'

response = requests.post(f'{roku_ip}/keypress/VolumeUp')

print(response.status_code)

```

- Keep in mind our TV Ip is 192.168.4.24 and the port number is 8060 however this can change depending on the time I think 


An example of Python opening Spotify to stream it onto my TV and  play it at a certain volume however this requieres some playing around with 


```Python
import os
import base64
import requests
import json
from roku import Roku

# Your Spotify app credentials
client_id = 'your_spotify_client_id'
client_secret = 'your_spotify_client_secret'

# Your Roku device's IP address
roku_ip = 'http://ROKU_IP:8060'

# Get access token from Spotify
auth_url = 'https://accounts.spotify.com/api/token'
auth_data = {
    'grant_type': 'client_credentials',
}
auth_headers = {
    'Content-Type': 'application/x-www-form-urlencoded',
    'Authorization': f'Basic {base64.b64encode(f"{client_id}:{client_secret}".encode()).decode()}'
}
auth_response = requests.post(auth_url, data=auth_data, headers=auth_headers)
access_token = auth_response.json().get('access_token')

# Use access token to control Spotify
spotify_url = 'https://api.spotify.com/v1/me/player'
spotify_headers = {
    'Authorization': f'Bearer {access_token}'
}
spotify_data = {
    'context_uri': 'spotify:playlist:your_playlist_id',
    'offset': {'position': 0},
    'position_ms': 0
}
spotify_response = requests.put(spotify_url, headers=spotify_headers, data=json.dumps(spotify_data))

# Control Roku device
roku = Roku(roku_ip)
roku.home()
roku.volume_up()

# Print status codes
print(spotify_response.status_code)
print(roku.query_device())
```

- this is for the API method we need an API key to do this 

However Hypothetically speaking there is a possibble other way to do this 

[[roku.py]]