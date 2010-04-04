Return-Path: <clemens-john@gmx.de>
From: Clemens John <clemens-john@gmx.de>
Date: Sun, 4 Apr 2010 17:41:52 +0200
References: <201004020054.08840.clemens-john@gmx.de>
	<4BB61A71.9070702@nord-west.org>
	<201004031254.02506.lindner_marek@yahoo.de>
In-Reply-To: <201004031254.02506.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3226483.UQzxQv7vUx";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201004041741.56665.clemens-john@gmx.de>
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

--nextPart3226483.UQzxQv7vUx
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Saturday 03 April 2010 06:54:02 Marek Lindner wrote:
> Ok, since your setup is rather small I would suggest going with the easie=
st
> solution possible. I'm always a big fan of making little steps that work
> well instead of aiming for the big goal which you never reach because you
> die in the process of getting there.
>=20
> In a classical batman-adv setup the router(s) with the internet connection
> run a DHCP server and provide IPs/default route/etc for all the nodes &
> wifi- clients in range.
>=20
> To connect the VPNs I see 2 feasible approaches:
> * You run batman-adv over the VPN which will bring some overhead since the
> routing messages will be relayed over the VPN. Depending on the number of
> nodes this may or may not be an issue. To keep things simple all nodes run
> in the same IP address space.

We decided to keep it simple for testing. We changed the netmasks of all ip=
=20
adresses (VPN and Wifi) from /24 to /16 but it doesnt work.

I can see all Nodes with
# batctl o

but not with ping.

=2D------------
root@OpenWrt:~# cat /etc/config/network=20
config 'interface' 'loopback'
        option 'ifname' 'lo'
        option 'proto' 'static'
        option 'ipaddr' '127.0.0.1'
        option 'netmask' '255.0.0.0'

config 'interface' 'lan'
        option 'proto' 'dhcp'
        option 'ifname' 'eth0'

config 'interface' 'mesh'
        option 'type' 'bridge'
        option 'ifname' 'ath0 bat0'
        option 'proto' 'static'
        option 'ipaddr' '10.18.1.1'
        option 'netmask' '255.255.0.0'


=2D------------
root@OpenWrt:~# ifconfig=20
ath0      Link encap:Ethernet  HWaddr 00:24:01:17:B7:55 =20
          inet6 addr: fe80::224:1ff:fe17:b755/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:28 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0=20
          RX bytes:0 (0.0 B)  TX bytes:2324 (2.2 KiB)

ath1      Link encap:Ethernet  HWaddr 06:24:01:17:B7:55 =20
          inet6 addr: fe80::424:1ff:fe17:b755/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:580 errors:0 dropped:18 overruns:0 frame:0
          TX packets:337 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0=20
          RX bytes:18512 (18.0 KiB)  TX bytes:17574 (17.1 KiB)

bat0      Link encap:Ethernet  HWaddr 9A:14:E1:3B:F4:88 =20
          inet6 addr: fe80::9814:e1ff:fe3b:f488/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1476  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:16 errors:0 dropped:16 overruns:0 carrier:0
          collisions:0 txqueuelen:1000=20
          RX bytes:0 (0.0 B)  TX bytes:944 (944.0 B)

br-mesh   Link encap:Ethernet  HWaddr 00:24:01:17:B7:55 =20
          inet addr:10.18.1.101  Bcast:10.18.255.255  Mask:255.255.0.0
          inet6 addr: fe80::ec23:2fff:fe06:37f3/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:25 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0=20
          RX bytes:0 (0.0 B)  TX bytes:2034 (1.9 KiB)

eth0      Link encap:Ethernet  HWaddr 00:24:01:17:B7:56 =20
          inet addr:192.168.178.59  Bcast:192.168.178.255  Mask:255.255.255=
=2E0
          inet6 addr: fe80::224:1ff:fe17:b756/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:3782 errors:0 dropped:0 overruns:0 frame:0
          TX packets:791 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000=20
          RX bytes:533232 (520.7 KiB)  TX bytes:93762 (91.5 KiB)
          Interrupt:4 Base address:0x1000=20

lo        Link encap:Local Loopback =20
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:19 errors:0 dropped:0 overruns:0 frame:0
          TX packets:19 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0=20
          RX bytes:1958 (1.9 KiB)  TX bytes:1958 (1.9 KiB)

tap0      Link encap:Ethernet  HWaddr 42:49:50:CF:69:3E =20
          inet addr:10.18.0.8  Bcast:10.18.255.255  Mask:255.255.0.0
          inet6 addr: fe80::4049:50ff:fecf:693e/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:402 errors:0 dropped:0 overruns:0 frame:0
          TX packets:4 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100=20
          RX bytes:31752 (31.0 KiB)  TX bytes:368 (368.0 B)

wifi0     Link encap:UNSPEC  HWaddr 00-24-01-17-
B7-55-00-00-00-00-00-00-00-00-00-00 =20
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:5172 errors:0 dropped:0 overruns:0 frame:424
          TX packets:374 errors:1 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:195=20
          RX bytes:716632 (699.8 KiB)  TX bytes:29035 (28.3 KiB)
          Interrupt:3 Memory:b0000000-b000ffff=20

=2D------------
root@OpenWrt:~# route=20
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Ifa=
ce
192.168.178.0   *               255.255.255.0   U     0      0        0 eth0
10.18.0.0       *               255.255.0.0     U     0      0       0 br-m=
esh
10.18.0.0       *               255.255.0.0     U     0      0        0 tap0
default         192.168.178.1   0.0.0.0         UG    0      0   0 eth0

=2D------------
root@OpenWrt:~# traceroute 10.18.0.3
traceroute to 10.18.0.3 (10.18.0.3), 30 hops max, 38 byte packets
 1  10.18.1.101 (10.18.1.101)  3002.434 ms !H  3010.472 ms !H  3009.891 ms =
!H

10.18.0.3 is a vpn node (tap0) and running batman-adv but traceroute thinks=
,=20
that it can be connected on the mesh-bridge???

I can=B4t figure out his problem. Hopefully someone of you can help me.

Greetings
=46loh1111

--nextPart3226483.UQzxQv7vUx
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAku4s0EACgkQZgdHbA22lqNzMACgiT5gZhKw+ScR9shbCnQR+Psp
gAgAoN9OoBJXNSukpGIIQOx8Q06QhHi8
=yR8J
-----END PGP SIGNATURE-----

--nextPart3226483.UQzxQv7vUx--
