Return-Path: <clemens-john@gmx.de>
From: Clemens John <clemens-john@gmx.de>
Date: Fri, 2 Apr 2010 12:17:01 +0200
References: <201004020054.08840.clemens-john@gmx.de>
	<20100402065229.GA3908@Linus-Debian>
In-Reply-To: <20100402065229.GA3908@Linus-Debian>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4759446.4i3yXAeLnn";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201004021217.05045.clemens-john@gmx.de>
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

--nextPart4759446.4i3yXAeLnn
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Friday 02 April 2010 08:52:29 Linus L=FCssing wrote:
> Hi Floh1111,
>=20
> Welcome to the B.A.T.M.A.N. mailing list :).

Thank you :)

> On Fri, Apr 02, 2010 at 12:54:02AM +0200, Clemens John wrote:
> > Hi,
> >=20
> > I use batman advanced ("# batctl o" says "B.A.T.M.A.N. adv 0.2.1-beta
> > r1578") on OpenWrt trunk and I have the following problem:
> >=20
> > I have a wlan meshnetwork in ahdemo mode which uses batman. The
> > meshnetwork is used by clients without batman and therefore I have
> > another network on the same wifi device in ad mode which is bridged with
> > bat0.
> > The bridge is in the network 10.18.1.0/24.
> >=20
> > I think its like described in
> > http://www.open-mesh.org/wiki/batman-adv-quick- start-guide
>=20
> Yes, this configuration looks quite good already if I didn't miss
> anything and if you're having wifi cards with an atheros chip.
> What kind of devices are you using?

I use Fonera and Dlink Dir300 wich have a atheros chip inside.

> > The problem is, that I have a vpn network on tap0 (10.18.0.0/24) and I
> > dont know how I can link this two networks/interfaces to each other with
> > batman. I tried to assign tap0 to batman, but this doesnt work.
> >=20
> > I want to be able to ping hosts that uses batman in the vpn and in the
> > wlan network. How can I do this?
>=20
> Ok, now I have some more questions already :). What do you want to
> gain with this vpn exactly, merging a couple of mesh clouds or
> getting the network behind the vpn into the mesh? What is
> creating this vpn right now, how are the two sites connected with
> each other (over network identified with 'lan' I guess?).
> Does pinging inside of the vpn itself without any mesh work?

Yes the vpn network is created over lan.
The VPN is created by an central openvpn server in tap mode and ping inside=
=20
the vpn works without batman.
The VPN is used to connect several mesh clouds which can=B4t sea each other=
=20
wireless.
Ping from one Mesh device to another meshdevice on the other side of the vp=
n=20
tunnel works. I think because they are both in the 10.18.1.0/24 network.

But the devices which are connected to the vpn network have a ip from=20
10.18.0.0/24 and should also be reachable from the 10.18.1.0/24 (wlan) netw=
ork=20
and this doesnt work so far.
I can ping the mac adresses inside the vpn from the wlan network with batct=
l=20
but not with normal ipv4 ping.

> From the configuration now, it looks like you're having another
> batman-adv on the other side of the vpn as you've assigned tap0 to
> batman. So keep in mind that the recipient on the other side of the tunnel
> will get batman-adv ethernet frames only which encapsulate the
> payload - there has to be a batman-adv on the other side to unwrap
> the IP packets again.
> And if there is a batman-adv on the other side of the tunnel, make
> sure the vpn itself is transporting whole ethernet frames and not
> only ip packets (in tinc this is "switched" mode for instance or
> in OpenVPN having "dev tap" and not "dev tun").

Yes the setup is like you describe it.=20

I just give you an output of my devices on a Dir300 connected to vpn and wl=
an.
Maybe this can be usefull for you.

root@OpenWrt:~# ifconfig=20
ath0      Link encap:Ethernet  HWaddr 00:24:01:17:B7:55 =20
          inet6 addr: fe80::224:1ff:fe17:b755/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:367 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0=20
          RX bytes:0 (0.0 B)  TX bytes:25573 (24.9 KiB)

ath1      Link encap:Ethernet  HWaddr 06:24:01:17:B7:55 =20
          inet6 addr: fe80::424:1ff:fe17:b755/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:4979 errors:0 dropped:85 overruns:0 frame:0
          TX packets:2736 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0=20
          RX bytes:359248 (350.8 KiB)  TX bytes:224416 (219.1 KiB)

bat0      Link encap:Ethernet  HWaddr 3A:53:93:D9:7D:15 =20
          inet6 addr: fe80::3853:93ff:fed9:7d15/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1476  Metric:1
          RX packets:586 errors:0 dropped:0 overruns:0 frame:0
          TX packets:168 errors:0 dropped:15 overruns:0 carrier:0
          collisions:0 txqueuelen:1000=20
          RX bytes:34784 (33.9 KiB)  TX bytes:27239 (26.6 KiB)

br-mesh   Link encap:Ethernet  HWaddr 00:24:01:17:B7:55 =20
          inet addr:10.18.1.101  Bcast:10.18.1.255  Mask:255.255.255.0
          inet6 addr: fe80::bca2:f0ff:fe00:96c8/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:586 errors:0 dropped:0 overruns:0 frame:0
          TX packets:176 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0=20
          RX bytes:34784 (33.9 KiB)  TX bytes:28219 (27.5 KiB)

eth0      Link encap:Ethernet  HWaddr 00:24:01:17:B7:56 =20
          inet addr:192.168.178.59  Bcast:192.168.178.255  Mask:255.255.255=
=2E0
          inet6 addr: fe80::224:1ff:fe17:b756/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:12931 errors:0 dropped:0 overruns:0 frame:0
          TX packets:3442 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000=20
          RX bytes:1952051 (1.8 MiB)  TX bytes:454599 (443.9 KiB)
          Interrupt:4 Base address:0x1000=20

lo        Link encap:Local Loopback =20
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:4 errors:0 dropped:0 overruns:0 frame:0
          TX packets:4 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0=20
          RX bytes:486 (486.0 B)  TX bytes:486 (486.0 B)

tap0      Link encap:Ethernet  HWaddr 8E:61:AE:E8:03:4A =20
          inet addr:10.18.0.8  Bcast:10.18.0.255  Mask:255.255.255.0
          inet6 addr: fe80::8c61:aeff:fee8:34a/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:11484 errors:0 dropped:0 overruns:0 frame:0
          TX packets:2232 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100=20
          RX bytes:726488 (709.4 KiB)  TX bytes:164026 (160.1 KiB)

wifi0     Link encap:UNSPEC  HWaddr 00-24-01-17-
B7-55-00-00-00-00-00-00-00-00-00-00 =20
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:13256 errors:0 dropped:0 overruns:0 frame:197
          TX packets:3131 errors:8 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:195=20
          RX bytes:1887585 (1.7 MiB)  TX bytes:321699 (314.1 KiB)
          Interrupt:3 Memory:b0000000-b000ffff=20

> > My configs look like this:
> >=20
> > ---------------
> > /etc/conf/network
> > ---------------
> > config 'interface' 'loopback'
> >=20
> >         option 'ifname' 'lo'
> >         option 'proto' 'static'
> >         option 'ipaddr' '127.0.0.1'
> >         option 'netmask' '255.0.0.0'
> >=20
> > config 'interface' 'lan'
> >=20
> >         option 'proto' 'dhcp'
> >         option 'ifname' 'eth0'
> >=20
> > config 'interface' 'mesh'
> >=20
> >         option 'type' 'bridge'
> >         option 'ifname' 'ath0 bat0'
> >         option 'proto' 'static'
> >         option 'ipaddr' '10.18.1.101'
> >         option 'netmask' '255.255.255.0'
> >=20
> > config 'interface' 'vpn'
> >=20
> >         option 'proto' 'none'
> >         option 'ifname' 'tap0'
> >=20
> > ---------------
> > /etc/conf/wireless
> > ---------------
> > config wifi-device  wifi0
> >=20
> >         option type     atheros
> >         option channel  6
> >=20
> > config wifi-iface
> >=20
> >         option device   wifi0
> >         option mode     ahdemo
> >         option bssid    02:CA:FF:EE:BA:BE
> >=20
> > config wifi-iface
> >=20
> >         option device   wifi0
> >         option mode     ap
> >         option ssid     oldenburg.freifunk.net
> >=20
> > ---------------
> > /etc/conf/batman-adv-kernelland
> > ---------------
> > config batman-adv-kernelland general
> >=20
> >         option interface                'ath1 tap0'
> >         option originator_interval
> >         option log_level
> >=20
> > thanks
> > Floh1111

--nextPart4759446.4i3yXAeLnn
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAku1xB0ACgkQZgdHbA22lqOHIwCgoW8ZexjPNt0dM9XN5FVCXlcS
po8An0OcmJkn//vA8uCWq0MH7o+Rv3cB
=HSPs
-----END PGP SIGNATURE-----

--nextPart4759446.4i3yXAeLnn--
