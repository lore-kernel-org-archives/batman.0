Return-Path: <gtolon@inti.gob.ar>
Message-ID: <50182850.2020904@inti.gob.ar>
Date: Tue, 31 Jul 2012 15:47:44 -0300
From: gtolon@inti.gob.ar
MIME-Version: 1.0
References: <CAMVTf1iTYLNL9xAuXsRwiAexNAfXmf5zPXocv=qrcWYSVBmYhA@mail.gmail.com>
In-Reply-To: <CAMVTf1iTYLNL9xAuXsRwiAexNAfXmf5zPXocv=qrcWYSVBmYhA@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Problems to add Batman-adv in wlan0 Nanostation
 M5
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Hi Esteban,

I don't see in the link that you pasted that they use opkg. I think they=20
compile batman-adv before installing the image to the router, right?.=20
Maybe this thread could be useful to you:

http://www.mail-archive.com/b.a.t.m.a.n@lists.open-mesh.org/msg07566.html

After installing batman-adv you can use the file /etc/config/batman to=20
configure it.

Regards


Gabriel


El 31/07/2012 01:41 p.m., Esteban Municio escribi=F3:
> Hi all
>
> I`m working on a academic develop project for improve the networks in
> rural areas in Peru. We are doing some test with 6 Nanostation M5 for
> create a mesh network.
>
> I tried Commotion software with OLSR and all was Ok. Now, we are
> testing BATMAN, with OpenWRT and batman-adv module, but I have some
> problems.
>
> I have compiled OpenWrt Backfire r32751 (Load: 0.09 0.10 0.05) and
> installed batman-adv with opkg following this
> http://wiki.openwrt.org/inbox/mesh.batman
>
> When I put:
> lsmod | grep batman
> I get
> batman_adv             67936  0
>
> and seems to be load in the kernel
>
> But when I try to add the interface wlan0 for activate batman in it,
> the Nanostation remains locked and i need to reboot.
> I have tried this with:
>
> echo bat0 > /sys/class/net/wlan0/batman_adv/mesh_iface
>
> and
>
> batctl if add wlan0
>
> with the same bad result.
> What am i doing wrong?
>
> That are my configuration files:
>
> root@OpenWrt:~# cat /etc/config/network
> config interface loopback
> 	option ifname	lo
> 	option proto	static
> 	option ipaddr	127.0.0.1
> 	option netmask	255.0.0.0
>
> config interface lan
> 	option ifname	eth0
> 	option type	bridge
> 	option proto	static
> 	option ipaddr	192.168.1.1
> 	option netmask	255.255.255.0
>
> #config interface wan
> #	option ifname	eth1
> #	option proto	dhcp
>
>
> config interface wan
> 	option ifname	eth1
> 	option proto	static
> 	option ipaddr	"my ip public for internet access"
> 	option netmask  255.255.255.192
> 	option gateway	"my ip public gateway"
> 	option dns	8.8.8.8
> ----------------------------------------
>
> root@OpenWrt:~# cat /etc/config/wireless
>
> config 'wifi-device' 'radio0'
> 	option 'type' 'mac80211'
> 	option 'macaddr' '00:27:22:52:71:a7'
> 	option 'hwmode' '11na'
> 	option 'htmode' 'HT20'
> 	list 'ht_capab' 'SHORT-GI-40'
> 	list 'ht_capab' 'TX-STBC'
> 	list 'ht_capab' 'RX-STBC1'
> 	list 'ht_capab' 'DSSS_CCK-40'
> 	option 'channel' '161'
> 	option 'txpower' '0'
> 	option 'country' 'US'
>
> config 'wifi-iface'
> 	option 'device' 'radio0'
> 	option 'network' 'lan'
> 	option 'ssid' 'OpenWrt'
> 	option 'encryption' 'none'
> 	option 'mode' 'adhoc'
> 	option 'bssid' '00:27:22:52:71:A7'
>
> ---------------------------------------------------
> root@OpenWrt:~# iwconfig
> lo        no wireless extensions.
>
> eth0      no wireless extensions.
>
> eth1      no wireless extensions.
>
> br-lan    no wireless extensions.
>
> wlan0     IEEE 802.11an  ESSID:"OpenWrt"
>            Mode:Ad-Hoc  Frequency:5.805 GHz  Cell: 00:27:22:52:71:A7
>            Tx-Power=3D3 dBm
>            RTS thr:off   Fragment thr:off
>            Encryption key:off
>            Power Management:on
>
> -----------------------------------------------------
> root@OpenWrt:~# ifconfig
> br-lan    Link encap:Ethernet  HWaddr 00:27:22:53:71:A7
>            inet addr:192.168.1.1  Bcast:192.168.1.255  Mask:255.255.255.0
>            UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>            RX packets:9489 errors:0 dropped:0 overruns:0 frame:0
>            TX packets:9584 errors:0 dropped:0 overruns:0 carrier:0
>            collisions:0 txqueuelen:0
>            RX bytes:989861 (966.6 KiB)  TX bytes:3510637 (3.3 MiB)
>
> eth0      Link encap:Ethernet  HWaddr 00:27:22:53:71:A7
>            UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>            RX packets:9511 errors:0 dropped:0 overruns:0 frame:0
>            TX packets:9597 errors:0 dropped:0 overruns:0 carrier:0
>            collisions:0 txqueuelen:1000
>            RX bytes:1124441 (1.0 MiB)  TX bytes:3512820 (3.3 MiB)
>            Interrupt:4
>
> eth1      Link encap:Ethernet  HWaddr 00:27:22:53:71:A8
>            inet addr:"my ip public"  Bcast:"my ip broadcast broadcast"
> Mask:255.255.255.192
>            UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>            RX packets:13086 errors:0 dropped:0 overruns:0 frame:0
>            TX packets:4552 errors:0 dropped:0 overruns:0 carrier:0
>            collisions:0 txqueuelen:1000
>            RX bytes:4041054 (3.8 MiB)  TX bytes:797392 (778.7 KiB)
>            Interrupt:5
>
> lo        Link encap:Local Loopback
>            inet addr:127.0.0.1  Mask:255.0.0.0
>            UP LOOPBACK RUNNING  MTU:16436  Metric:1
>            RX packets:16 errors:0 dropped:0 overruns:0 frame:0
>            TX packets:16 errors:0 dropped:0 overruns:0 carrier:0
>            collisions:0 txqueuelen:0
>            RX bytes:1556 (1.5 KiB)  TX bytes:1556 (1.5 KiB)
>
> wlan0     Link encap:Ethernet  HWaddr 00:27:22:52:71:A7
>            UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>            RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>            TX packets:14 errors:0 dropped:0 overruns:0 carrier:0
>            collisions:0 txqueuelen:32
>            RX bytes:0 (0.0 B)  TX bytes:1526 (1.4 KiB)
>
> ------------------------
>
> I have noticed that i have not the bat0 interface created,is it normal?
> Do i need create another aditional interface like ath0?
>
> I have been following that manuals:
> http://pizza.hskflashcards.com/index.php?page=3DB.A.T.M.A.N.+Advanced+on+=
OpenWrt+How-To
>
> http://www.open-mesh.org/projects/batman-adv/wiki/Quick-start-guide
>
> Any help o comment?
> Do you recomend me to change to batmand instead?
> Do you know if there is any BATMAN implementation for a mesh network
> of Nanostation M5, easier to install and manipulate?
>
> Thanks
>
> --
> Esteban
>

