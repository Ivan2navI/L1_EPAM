# 9. Docker :whale:

## 1. [Install Docker Engine on Ubuntu](https://docs.docker.com/engine/install/ubuntu/)
Before you install Docker Engine for the first time on a new host machine, you need to [set up the Docker repository](https://docs.docker.com/engine/install/ubuntu/). Afterward, you can install and update Docker from the repository.
```console
sudo docker run hello-world
> Unable to find image 'hello-world:latest' locally
> latest: Pulling from library/hello-world
> 2db29710123e: Pull complete
> Digest: sha256:c77be1d3a47d0caf71a82dd893ee61ce01f32fc758031a6ec4cf1389248bb833
> Status: Downloaded newer image for hello-world:latest

> Hello from Docker!
> This message shows that your installation appears to be working correctly.

# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
docker -v
> Docker version 20.10.21, build baeda1f
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
uname -a
> Linux ubuntu-VirtualBox 5.15.0-52-generic #58-Ubuntu SMP Thu Oct 13 08:03:55 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
cat /etc/os-release
> PRETTY_NAME="Ubuntu 22.04.1 LTS"
> NAME="Ubuntu"
> VERSION_ID="22.04"
> VERSION="22.04.1 LTS (Jammy Jellyfish)"
> VERSION_CODENAME=jammy
```

### :hammer: Optimizing Docker (OPTION) :hammer:
Docker [optimization option](https://devdotnet.org/post/ustanovka-docker-dlya-arm-i-64-bit-arm-armbian-linux/), but you can skip this step.  
While running, the container can be very active in writing data to the event log, and the size of the log file will only increase. Therefore, it is necessary to limit the size and number of log files created by creating the  `/etc/docker/daemon.json`  file .  
To publish ports outside the container, Docker creates a separate TCP or UDP proxy for each port. If there are a lot of ports, then this reduces the network exchange speed and loads the processor more. To disable userland-proxy, you need to make changes to the  `/etc/docker/daemon.json`  file .  
  
Open/create  `nano /etc/docker/daemon.json`  file:
```console
{
    "log-driver": "local" , 
    "log-opts": { 
        "max-size": "10m" , 
        "maxfile": "3"
    } ,
    "userland-proxy": false 
}
```
Description of parameters:  
    - **"log-driver": "local"** - options for local log files
    - **"max-size": "10m"** - the maximum size of one log file is 10 MB
    - **"max-file": "3"** - the maximum number of log files is 3  
Restart the Docker service for the new settings to take effect:  
`sudo systemctl restart docker`




















---

- **2 spaces** – for indentation
- **No unused variables** – this one catches tons of bugs!
- **No semicolons** – It's fine. Really!
- Never start a line with `(` , `[` , or `````
    - This is the only gotcha with omitting semicolons – automatically checked for you!
- **Space after keywords** `if (condition) { ... }`
- Always use `===` instead of `==` – but `obj == null` is allowed to check `null || undefined` .

---

The easiest way to use JavaScript Standard Style to check your code is to install it globally as a Node command line program. To do so, simply run the following command in your terminal (flag `-g` installs standard globally on your system, omit it if you want to install in the current working directory):

```bash
npm install standard -g
```

After you've done that you should be able to use the `standard` program. The simplest use case would be checking the style of all JavaScript files in the current working directory:

```bash
$ standard
Error: Use JavaScript Standard Style
 lib/torrent.js:950:11: Expected '===' and instead saw '=='.
```

This guide is based on [https://github.com/feross/standard](https://github.com/feross/standard)

# 2**. xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx**

---

- **2 spaces** – for indentation
- **No unused variables** – this one catches tons of bugs!
- **No semicolons** – It's fine. Really!
- Never start a line with `(` , `[` , or `````
    - This is the only gotcha with omitting semicolons – automatically checked for you!
- **Space after keywords** `if (condition) { ... }`
- Always use `===` instead of `==` – but `obj == null` is allowed to check `null || undefined` .

---

The easiest way to use JavaScript Standard Style to check your code is to install it globally as a Node command line program. To do so, simply run the following command in your terminal (flag `-g` installs standard globally on your system, omit it if you want to install in the current working directory):

```bash
npm install standard -g
```

After you've done that you should be able to use the `standard` program. The simplest use case would be checking the style of all JavaScript files in the current working directory:

```bash
$ standard
Error: Use JavaScript Standard Style
 lib/torrent.js:950:11: Expected '===' and instead saw '=='.
```
