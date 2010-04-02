Return-Path: <linus.luessing@web.de>
Date: Fri, 2 Apr 2010 13:50:32 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100402115032.GA4984@Linus-Debian>
References: <201004020054.08840.clemens-john@gmx.de>
	<20100402065229.GA3908@Linus-Debian>
	<201004021217.05045.clemens-john@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <201004021217.05045.clemens-john@gmx.de>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] Problems connecting VPN and WLAN with Batman-adv
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


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> I use Fonera and Dlink Dir300 wich have a atheros chip inside.
Ah, great, those Dlink routers are the ones I'm using here too :).

> Yes the vpn network is created over lan.
> The VPN is created by an central openvpn server in tap mode and ping insi=
de=20
> the vpn works without batman.
> The VPN is used to connect several mesh clouds which can=C2=B4t sea each =
other=20
> wireless.
> Ping from one Mesh device to another meshdevice on the other side of the =
vpn=20
> tunnel works. I think because they are both in the 10.18.1.0/24 network.
>=20
> But the devices which are connected to the vpn network have a ip from=20
> 10.18.0.0/24 and should also be reachable from the 10.18.1.0/24 (wlan) ne=
twork=20
> and this doesnt work so far.
Yes, you're right, if a host has a /24 subnet and wants to be able
to reach another host on a different /24 subnet, then they need an
extra (default) route entry in their routing table. In your setup,
why aren't you just using a /16 subnet instead if you want them to
reach each other over direct links without any routing?
> I can ping the mac adresses inside the vpn from the wlan network with bat=
ctl=20
> but not with normal ipv4 ping.
>=20
> > From the configuration now, it looks like you're having another
> > batman-adv on the other side of the vpn as you've assigned tap0 to
> > batman. So keep in mind that the recipient on the other side of the tun=
nel
> > will get batman-adv ethernet frames only which encapsulate the
> > payload - there has to be a batman-adv on the other side to unwrap
> > the IP packets again.
> > And if there is a batman-adv on the other side of the tunnel, make
> > sure the vpn itself is transporting whole ethernet frames and not
> > only ip packets (in tinc this is "switched" mode for instance or
> > in OpenVPN having "dev tap" and not "dev tun").
>=20
> Yes the setup is like you describe it.=20
Ups, ok, sooo, you want the complex stuff :)? Just want to note,
that this has not extensively been tested yet, I had just tried it
here with a friend and this test for one tunnel worked unexpectetly
good. However, we don't know yet if there might occure some
undesired things in larger scales. But if you are up to an
adventure and want to share your experiences with this, great :).

I think I'll better write a little description and article in our
wiki about how our test setup looks like as there seem to be some more
people getting interested in it.

And I also want to point out, that establishing such vpn inter
cloud links with the routers themselves has the following
downside: With tinc + those DIR300 routers, we measured a maximum
total throughput of 300kB/s which might be or might not be what
you are looking for. This is because VPN software is copying the
data from kernel to userspace and back a couple of times. Haven't
measured anything with OpenVPN though, but as far as I know they
are also doing this copying (there is no kernel module for OpenVPN
afaik).

Cheers, Linus

>=20
> I just give you an output of my devices on a Dir300 connected to vpn and =
wlan.
> Maybe this can be usefull for you.
>=20
> root@OpenWrt:~# ifconfig=20
> ath0      Link encap:Ethernet  HWaddr 00:24:01:17:B7:55 =20
>           inet6 addr: fe80::224:1ff:fe17:b755/64 Scope:Link
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:367 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:0=20
>           RX bytes:0 (0.0 B)  TX bytes:25573 (24.9 KiB)
>=20
> ath1      Link encap:Ethernet  HWaddr 06:24:01:17:B7:55 =20
>           inet6 addr: fe80::424:1ff:fe17:b755/64 Scope:Link
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:4979 errors:0 dropped:85 overruns:0 frame:0
>           TX packets:2736 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:0=20
>           RX bytes:359248 (350.8 KiB)  TX bytes:224416 (219.1 KiB)
>=20
> bat0      Link encap:Ethernet  HWaddr 3A:53:93:D9:7D:15 =20
>           inet6 addr: fe80::3853:93ff:fed9:7d15/64 Scope:Link
>           UP BROADCAST RUNNING MULTICAST  MTU:1476  Metric:1
>           RX packets:586 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:168 errors:0 dropped:15 overruns:0 carrier:0
>           collisions:0 txqueuelen:1000=20
>           RX bytes:34784 (33.9 KiB)  TX bytes:27239 (26.6 KiB)
>=20
> br-mesh   Link encap:Ethernet  HWaddr 00:24:01:17:B7:55 =20
>           inet addr:10.18.1.101  Bcast:10.18.1.255  Mask:255.255.255.0
>           inet6 addr: fe80::bca2:f0ff:fe00:96c8/64 Scope:Link
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:586 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:176 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:0=20
>           RX bytes:34784 (33.9 KiB)  TX bytes:28219 (27.5 KiB)
>=20
> eth0      Link encap:Ethernet  HWaddr 00:24:01:17:B7:56 =20
>           inet addr:192.168.178.59  Bcast:192.168.178.255  Mask:255.255.2=
55.0
>           inet6 addr: fe80::224:1ff:fe17:b756/64 Scope:Link
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:12931 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:3442 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:1000=20
>           RX bytes:1952051 (1.8 MiB)  TX bytes:454599 (443.9 KiB)
>           Interrupt:4 Base address:0x1000=20
>=20
> lo        Link encap:Local Loopback =20
>           inet addr:127.0.0.1  Mask:255.0.0.0
>           inet6 addr: ::1/128 Scope:Host
>           UP LOOPBACK RUNNING  MTU:16436  Metric:1
>           RX packets:4 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:4 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:0=20
>           RX bytes:486 (486.0 B)  TX bytes:486 (486.0 B)
>=20
> tap0      Link encap:Ethernet  HWaddr 8E:61:AE:E8:03:4A =20
>           inet addr:10.18.0.8  Bcast:10.18.0.255  Mask:255.255.255.0
>           inet6 addr: fe80::8c61:aeff:fee8:34a/64 Scope:Link
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:11484 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:2232 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:100=20
>           RX bytes:726488 (709.4 KiB)  TX bytes:164026 (160.1 KiB)
>=20
> wifi0     Link encap:UNSPEC  HWaddr 00-24-01-17-
> B7-55-00-00-00-00-00-00-00-00-00-00 =20
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:13256 errors:0 dropped:0 overruns:0 frame:197
>           TX packets:3131 errors:8 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:195=20
>           RX bytes:1887585 (1.7 MiB)  TX bytes:321699 (314.1 KiB)
>           Interrupt:3 Memory:b0000000-b000ffff=20
>=20
> > > My configs look like this:
> > >=20
> > > ---------------
> > > /etc/conf/network
> > > ---------------
> > > config 'interface' 'loopback'
> > >=20
> > >         option 'ifname' 'lo'
> > >         option 'proto' 'static'
> > >         option 'ipaddr' '127.0.0.1'
> > >         option 'netmask' '255.0.0.0'
> > >=20
> > > config 'interface' 'lan'
> > >=20
> > >         option 'proto' 'dhcp'
> > >         option 'ifname' 'eth0'
> > >=20
> > > config 'interface' 'mesh'
> > >=20
> > >         option 'type' 'bridge'
> > >         option 'ifname' 'ath0 bat0'
> > >         option 'proto' 'static'
> > >         option 'ipaddr' '10.18.1.101'
> > >         option 'netmask' '255.255.255.0'
> > >=20
> > > config 'interface' 'vpn'
> > >=20
> > >         option 'proto' 'none'
> > >         option 'ifname' 'tap0'
> > >=20
> > > ---------------
> > > /etc/conf/wireless
> > > ---------------
> > > config wifi-device  wifi0
> > >=20
> > >         option type     atheros
> > >         option channel  6
> > >=20
> > > config wifi-iface
> > >=20
> > >         option device   wifi0
> > >         option mode     ahdemo
> > >         option bssid    02:CA:FF:EE:BA:BE
> > >=20
> > > config wifi-iface
> > >=20
> > >         option device   wifi0
> > >         option mode     ap
> > >         option ssid     oldenburg.freifunk.net
> > >=20
> > > ---------------
> > > /etc/conf/batman-adv-kernelland
> > > ---------------
> > > config batman-adv-kernelland general
> > >=20
> > >         option interface                'ath1 tap0'
> > >         option originator_interval
> > >         option log_level
> > >=20
> > > thanks
> > > Floh1111



--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJLtdoIAAoJEBKw7u43QNpfcOQQAIQdX/a/qn+fUsC2INl5kbqP
pwLif0Ocy/x1mXyXewEU/1P5xYcUWyxNVV2zpcAU/42PzcFKQbbR4+D0ztjPdFfz
BYlphBqAeKrnx7kxgWthaTgT9PgmsAuteAnkbG9sr1bqYMhYZ1i8sSj0laef7qQp
WI6rNni91j2nhXHo2jw+6TQy8W/0nGODZfof+b/3ddjOgoOIiwf5TIa3EZZTh9mY
DHl2js9Jg7AR6McbJobTSPH8ib/M6d38EaEEwxoccGmbj30StDfIvtrv+8rXjs5o
oOoND1UFwhKOKraedLPGg+lEnGDs1zlmyqzwTB4yPOWG+a2WRBjGRKIoPFWcYc3/
kJ1y+bCis4do0kdugBjmwQDYg/4DChKNjAj/eAD1zAu2Y8M7N9YCGNPoCm92xbgi
RkjwWo5hAUlb13ICoh5yK8d+dGw6jYs0uBFkJ8zh7PM2mTL54baQpcWR1tv8YlGd
VF0UW8KDQ+7k7LkmjYd75+7npYy1jM6BQwe+Zfj3p9T4wRcCzEsD57wyHAV9vaOf
QNxoZIq8KfstHzQsZJo+R6MVvg2I/khh5c6QVuIAbz/9sMYibXQJrMktPrBrFULD
YSrQdPFrPFSssTotFLbLlGGypLbz8+ICLdW5x/jHxCqgr5hQoRhEGTXcizsksIR6
U+1MUvVo/Vj4I4xgzdhx
=OUc8
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
