*Download the OpenJDK Binary:* **You can use the AdoptOpenJDK project to get the binary distribution for ARM64.** **Download the tar.gz file:** wget https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.11+9/OpenJDK11U-jdk_aarch64_linux_hotspot_11.0.11_9.tar.gz **Extract the Archive:** **Extract the downloaded tar.gz file to /opt:** sudo tar -xvf OpenJDK11U-jdk_aarch64_linux_hotspot_11.0.11_9.tar.gz -C /opt/ **Set Up Environment Variables:** **Edit your .bashrc or .profile file to set the JAVA_HOME variable and update the PATH:** nano ~/.bashrc **Add the following lines to the file:** export JAVA_HOME=/opt/jdk-11.0.11+9 export PATH=$JAVA_HOME/bin:$PATH **Save the file and apply the changes:** source ~/.bashrc **Verify the Installation:** **Check the Java version to ensure it’s correctly installed:** java -version **Install** *Download the latest version of ZAP:* wget https://github.com/zaproxy/zaproxy/releases/download/v2.15.0/ZAP_2.15.0_Crossplatform.zip **Extract the downloaded file:** unzip ZAP_2.15.0_Crossplatform.zip cd ZAP_2.15.0 **Run OWASP ZAP:** **Start ZAP:** ./zap.sh



# Installation Instructions

## Download the OpenJDK Binary
You can use the AdoptOpenJDK project to get the binary distribution for ARM64.

**Download the tar.gz file:**

```C 
wget https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.11+9/OpenJDK11U-jdk_aarch64_linux_hotspot_11.0.11_9.tar.gz`
```

## Extract the Archive

Extract the downloaded tar.gz file to `/opt`:

```C
sudo tar -xvf OpenJDK11U-jdk_aarch64_linux_hotspot_11.0.11_9.tar.gz -C /opt/

```


## Set Up Environment Variables

Edit your `.bashrc` or `.profile` file to set the `JAVA_HOME` variable and update the `PATH`:

```C
nano ~/.bashrc

```

Add the following lines to the file:

```C
export JAVA_HOME=/opt/jdk-11.0.11+9
export PATH=$JAVA_HOME/bin:$PATH

```

Save the file and apply the changes:

```C
source ~/.bashrc

```

## Verify the Installation

Check the Java version to ensure it’s correctly installed:

```C
java -version

```

## Install OWASP ZAP

**Download the latest version of ZAP:**

```C
wget https://github.com/zaproxy/zaproxy/releases/download/v2.15.0/ZAP_2.15.0_Crossplatform.zip

```

**Extract the downloaded file:**

```C
unzip ZAP_2.15.0_Crossplatform.zip
cd ZAP_2.15.0

```

**Run OWASP ZAP:** **Start ZAP:**

```C
./zap.sh

```

