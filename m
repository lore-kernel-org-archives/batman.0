Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 11 Aug 2010 13:14:08 +0200
References: <mailman.1.1281002401.15834.b.a.t.m.a.n@lists.open-mesh.org>
	<4C627FCF.4090303@web.de>
In-Reply-To: <4C627FCF.4090303@web.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201008111314.09249.lindner_marek@yahoo.de>
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


Hi,

> Step6: Editing the config files using uci:
> "root@OpenWrt:~# uci delete wireless.radio0.disabled
> root@OpenWrt:~# uci delete wireless.@wifi-iface[0].network
> root@OpenWrt:~# uci set wireless. radio0.channel=1
> root@OpenWrt:~# uci set wireless.@wifi-iface[0].mode=adhoc
> root@OpenWrt:~# uci set wireless.@wifi-iface[0].ssid=mesh
> root@OpenWrt:~# uci set wireless.@wifi-iface[0].bssid=02:12:34:56:78:9A
> root@OpenWrt:~# uci set network.lan.mtu=1500
> root@OpenWrt:~# uci set network.lan.ifname="eth0.0 bat0"
> root@OpenWrt:~# uci set network.wlan0=interface
> root@OpenWrt:~# uci set network.wlan0.ifname=wlan0
> root@OpenWrt:~# uci set network.wlan0.proto=none
> root@OpenWrt:~# uci set network.wlan0.mtu=1524

You don't seem to modify the batman-adv settings. Could you post the batman-
adv config file, so that we can see whether it fits the rest of your uci 
configuration ?


> root@OpenWrt:~# uci set network.bat0=interface
> root@OpenWrt:~# uci set network.bat0.ifname=bat0
> root@OpenWrt:~# uci set network.bat0.proto=none
> root@OpenWrt:~# uci set network.bat0.mtu=1500

I'm not sure what this will do. Any reason to set these values ?


> root@OpenWrt:~# uci commit
> root@OpenWrt:~# /etc/init.d/network restart"
> 
> After restarting the network the console says: "segmentation fault" and
> freezes. When doing "reboot" instead the device also freezes and the
> power-led keeps flashing.
> I also tried only changing the config in /etc/config/wireless and
> restarted the device, with the same effect.

With "uci commit" you save these settings permanently which then get loaded at 
boot time. If these settings crash your device it is save to assume that this 
happens with each boot attempt.  :-)


> In order to make sure the error isn't related to any errors while
> compiling the image, I compiled an Image without the batman-adv package.
> After that I was able to configure the router as usual without any freezes.

Before you try the next "/etc/init.d/network restart" could you please check 
whether the batman-adv module is loaded (using 'lsmod') and whether any 
interfaces are active (using 'batctl if'). The batman-adv version would be 
also interesting to know (can be found in the system log -> 'logread').
At this point I don't see how a "network restart" is related to batman.


> As I already mentioned I'm not very used to Linux, so I have not yet
> found a way to connect to the router with serial console without
> building an JTAG-Cable. Is that right?

Yes, you will need a corresponding cable and pins on the board to connect it 
to. A WRT54GL probably does not have the pins which means you would need to 
solder it yourself.

Regards,
Marek

