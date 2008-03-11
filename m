Message-ID: <42665.70.128.180.22.1205243784.squirrel@webmail.reglue.org>
In-Reply-To: <1205236803.4804.18.camel@krupskaya.is-a-geek.net.is-a-geek.net>
References: <52469.70.253.200.118.1205190931.squirrel@webmail.reglue.org>
	<47D63219.3020603@gmx.net>
	<1205236803.4804.18.camel@krupskaya.is-a-geek.net.is-a-geek.net>
Date: Tue, 11 Mar 2008 06:56:24 -0700 (PDT)
Subject: Re: [B.A.T.M.A.N.] b.a.t.m.a.n. + wrt54gl + OpenWrt Kamikaze +   
	X-wrt]
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

Okay.  I went through and changed all the interfaces to separate ip's.
That didn't work.  I'm going to play around with changing individual
interface IP addresses but for right now  I did get the network up and
running with network connectivity.  (eth0.1 is the port the internet comes
in from.  I'm not changing its ip.)


This seems like a sufficient start up script. I don't know if you see any
immediate flaws.

killall batmand
iwconfig wl0 channel 10 essid project mode Ad-Hoc
ifconfig eth0 103.0.0.3 netmask 255.0.0.0 broadcast 103.255.255.255
ifconfig eth0.0 103.0.0.3 netmask 255.0.0.0 broadcast 103.255.255.255
# ifconfig eth0.1 103.0.0.3 netmask 255.0.0.0 broadcast 103.255.255.255
ifconfig wl0 103.0.0.3 netmask 255.0.0.0 broadcast 103.255.255.255
iptables -t filter -I INPUT 2 -p udp --dport 4305 --sport 4305 -j ACCEPT
iptables -t filter -I INPUT 2 -p udp --dport 4306 --sport 4306 -j ACCEPT
iptables -t filter -I INPUT 2 -p udp --dport 4307 --sport 4307 -j ACCEPT
iptables -t filter -I OUTPUT 2 -p udp --dport 4305 --sport 4305 -j ACCEPT
iptables -t filter -I OUTPUT 2 -p udp --dport 4306 --sport 4306 -j ACCEPT
iptables -t filter -I OUTPUT 2 -p udp --dport 4307 --sport 4307 -j ACCEPT
batmand br-lan &


netstat -rn from the gateway router returns:

Destination     Gateway         Genmask         Flags   MSS Window  irtt
Iface
103.0.0.4       0.0.0.0         255.255.255.255 UH        0 0          0
br-lan
103.0.0.5       0.0.0.0         255.255.255.255 UH        0 0          0
br-lan
10.0.2.0        0.0.0.0         255.255.255.0   U         0 0          0
eth0.1
103.0.0.0       0.0.0.0         255.255.255.0   U         0 0          0
br-lan
103.0.0.0       0.0.0.0         255.0.0.0       U         0 0          0 eth0
103.0.0.0       0.0.0.0         255.0.0.0       U         0 0          0
eth0.0
103.0.0.0       0.0.0.0         255.0.0.0       U         0 0          0 wl0
0.0.0.0         10.0.2.1        0.0.0.0         UG        0 0          0
eth0.1


The browser tells me (I've only got 3 routers up now):
BATMAN node	Gateway	Through
Originator 	(#/128): 	routers...
[B.A.T.M.A.N.
0.2,
MainIF/IP:
br-lan
103.0.0.3,
UT:
0d
0h24m]

103.0.0.4 	(125): 	(125)
103.0.0.5
(
3)

103.0.0.5 	(119): 	(119)
103.0.0.4
(
7)

cheers and thank you.



