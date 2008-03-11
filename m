Message-ID: <57961.70.128.180.22.1205244422.squirrel@webmail.reglue.org>
In-Reply-To: <42665.70.128.180.22.1205243784.squirrel@webmail.reglue.org>
References: <52469.70.253.200.118.1205190931.squirrel@webmail.reglue.org>
	<47D63219.3020603@gmx.net>
	<1205236803.4804.18.camel@krupskaya.is-a-geek.net.is-a-geek.net>
	<42665.70.128.180.22.1205243784.squirrel@webmail.reglue.org>
Date: Tue, 11 Mar 2008 07:07:02 -0700 (PDT)
Subject: side note Re: [B.A.T.M.A.N.] b.a.t.m.a.n. + wrt54gl + OpenWrt 
	Kamikaze +    X-wrt]
From: dondavis@reglue.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Again, many thanks.

I reread my last email and it seemed unclear.  Batman is working and I can
get to the internet by using batman to go from one router to another.

I'll need to work on using a visualization server and fine tuning now.

All the interfaces have the same mac address except for the wireless
interface.


br-lan    Link encap:Ethernet  HWaddr 00:1C:10:BC:AC:00
          inet addr:103.0.0.3  Bcast:103.0.0.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:12802 errors:0 dropped:0 overruns:0 frame:0
          TX packets:7623 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:645580 (630.4 KiB)  TX bytes:1160698 (1.1 MiB)

eth0      Link encap:Ethernet  HWaddr 00:1C:10:BC:AC:00
          inet addr:103.0.0.3  Bcast:103.255.255.255  Mask:255.0.0.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:590 errors:0 dropped:0 overruns:0 frame:0
          TX packets:18105 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:514197 (502.1 KiB)  TX bytes:1247626 (1.1 MiB)
          Interrupt:4

eth0.0    Link encap:Ethernet  HWaddr 00:1C:10:BC:AC:00
          inet addr:103.0.0.3  Bcast:103.255.255.255  Mask:255.0.0.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:17484 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:0 (0.0 B)  TX bytes:979888 (956.9 KiB)

eth0.1    Link encap:Ethernet  HWaddr 00:1C:10:BC:AC:00
          inet addr:10.0.2.122  Bcast:10.0.2.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:591 errors:0 dropped:0 overruns:0 frame:0
          TX packets:627 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:503627 (491.8 KiB)  TX bytes:124554 (121.6 KiB)

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

wl0       Link encap:Ethernet  HWaddr 00:1C:10:BC:AC:02
          inet addr:103.0.0.3  Bcast:103.255.255.255  Mask:255.0.0.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:12952 errors:0 dropped:0 overruns:0 frame:573
          TX packets:7623 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:862518 (842.3 KiB)  TX bytes:1221682 (1.1 MiB)
          Interrupt:2 Base address:0x5000



>
> This seems like a sufficient start up script. I don't know if you see any
> immediate flaws.
>
> killall batmand
> iwconfig wl0 channel 10 essid project mode Ad-Hoc
> ifconfig eth0 103.0.0.3 netmask 255.0.0.0 broadcast 103.255.255.255
> ifconfig eth0.0 103.0.0.3 netmask 255.0.0.0 broadcast 103.255.255.255
> # ifconfig eth0.1 103.0.0.3 netmask 255.0.0.0 broadcast 103.255.255.255
> ifconfig wl0 103.0.0.3 netmask 255.0.0.0 broadcast 103.255.255.255
> iptables -t filter -I INPUT 2 -p udp --dport 4305 --sport 4305 -j ACCEPT
> iptables -t filter -I INPUT 2 -p udp --dport 4306 --sport 4306 -j ACCEPT
> iptables -t filter -I INPUT 2 -p udp --dport 4307 --sport 4307 -j ACCEPT
> iptables -t filter -I OUTPUT 2 -p udp --dport 4305 --sport 4305 -j ACCEPT
> iptables -t filter -I OUTPUT 2 -p udp --dport 4306 --sport 4306 -j ACCEPT
> iptables -t filter -I OUTPUT 2 -p udp --dport 4307 --sport 4307 -j ACCEPT
> batmand br-lan &
>
>

