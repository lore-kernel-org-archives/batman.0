Return-Path: <Timbo2001@web.de>
Message-ID: <4C627FCF.4090303@web.de>
Date: Wed, 11 Aug 2010 12:47:43 +0200
From: Tim <Timbo2001@web.de>
MIME-Version: 1.0
References: <mailman.1.1281002401.15834.b.a.t.m.a.n@lists.open-mesh.org>
In-Reply-To: <mailman.1.1281002401.15834.b.a.t.m.a.n@lists.open-mesh.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: Timbo2001@web.de
Subject: Re: [B.A.T.M.A.N.] Problem openWRT "backfire" and "kmod-batman-adv"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Hello,

first of all I'd like to say thanks for your fast replies.
I'm not very used to using Linux so this is a little tricky to me.

First of all I'm going to show you the way I compiled an image 
containing batman-adv (that's the way it used to work before) for WRT54GL:

Step1: Check out the backfire repository:
"svn co svn://svn.openwrt.org/openwrt/branches/backfire"

Step2: Change to backfire-folder
"cd backfire"

Step3: Adding the Batman-Adv module
"./scripts/feeds update"
"./scripts/feeds install kmod-batman-adv"

Step4: Configure the Image using:
"make menuconfig"
Here I select "Broadcom BCM947xx/953xx" with 2.6 kernel as Target System 
and add the batman-package in "Image Configuration -
 > Kernel Modules -> Network Support"

Step4: Compiling the Image
Step5: Transferring the image, changing the password via telnet and the 
connecting via SSH
Step6: Editing the config files using uci:
"root@OpenWrt:~# uci delete wireless.radio0.disabled
root@OpenWrt:~# uci delete wireless.@wifi-iface[0].network
root@OpenWrt:~# uci set wireless. radio0.channel=1
root@OpenWrt:~# uci set wireless.@wifi-iface[0].mode=adhoc
root@OpenWrt:~# uci set wireless.@wifi-iface[0].ssid=mesh
root@OpenWrt:~# uci set wireless.@wifi-iface[0].bssid=02:12:34:56:78:9A
root@OpenWrt:~# uci set network.lan.mtu=1500
root@OpenWrt:~# uci set network.lan.ifname="eth0.0 bat0"
root@OpenWrt:~# uci set network.wlan0=interface
root@OpenWrt:~# uci set network.wlan0.ifname=wlan0
root@OpenWrt:~# uci set network.wlan0.proto=none
root@OpenWrt:~# uci set network.wlan0.mtu=1524
root@OpenWrt:~# uci set network.bat0=interface
root@OpenWrt:~# uci set network.bat0.ifname=bat0
root@OpenWrt:~# uci set network.bat0.proto=none
root@OpenWrt:~# uci set network.bat0.mtu=1500
root@OpenWrt:~# uci commit
root@OpenWrt:~# /etc/init.d/network restart"

After restarting the network the console says: "segmentation fault" and 
freezes. When doing "reboot" instead the device also freezes and the 
power-led keeps flashing.
I also tried only changing the config in /etc/config/wireless and 
restarted the device, with the same effect.

In order to make sure the error isn't related to any errors while 
compiling the image, I compiled an Image without the batman-adv package. 
After that I was able to configure the router as usual without any freezes.

As I already mentioned I'm not very used to Linux, so I have not yet 
found a way to connect to the router with serial console without 
building an JTAG-Cable. Is that right?

Greetings,
Tim

