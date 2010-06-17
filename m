Return-Path: <clemens-john@gmx.de>
From: Clemens John <clemens-john@gmx.de>
Date: Thu, 17 Jun 2010 12:19:58 +0200
References: <201006171018.47209.clemens-john@gmx.de>
	<201006171045.00578.sven.eckelmann@gmx.de>
In-Reply-To: <201006171045.00578.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1815641.zvMrMILhVx";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201006171220.03431.clemens-john@gmx.de>
Subject: Re: [B.A.T.M.A.N.] MTU/connection problem
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
To: b.a.t.m.a.n@lists.open-mesh.net

--nextPart1815641.zvMrMILhVx
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Thursday 17 June 2010 10:44:59 Sven Eckelmann wrote:
> Sounds a little bit like a device is configured wrong. Lets go through the
> devices:
>=20
> Laptop:
>  * WiFi: MTU: 1500
>=20
> Fonera:
>  * Incoming (to Laptop) WiFi: MTU 1500
>  * Outgoing (to Dir300) WiFi: MTU 1530
>  * Bridge (has bat0 and Incoming WiFi included): MTU 1500
>  * bat0 (has only Outgoing WiFi included): MTU 1500
>=20
> Dir300:
>  * Incoming (to Fonera) WiFi: MTU 1530
>  * bat0 (only incoming device included): MTU 1500
>=20
> This should work till Dir300. Now send 1500 Bytes large packets to each
> interesting partner (fonera, dir300) and check were it drops.
>=20
> This can be done using `ping -M do -s 1472 $IP`.
>=20
> If it works till dir300 and drops somewhere in the openvpn/virtual
> openwrt/internet connection then please check there. If it drops before
> then please check your configuration (running, not configuration files)
> and try to summarize those devices as I tried to do above.
>=20
> How exactly is openvpn your connection to the internet configured? Do they
> work in an mode which adds extra headers? Do they fragment packets?
>=20
> Best regards,
> 	Sven

Sry this should have been gone to the Batman list, so here it is again:

I did this and everything works fine till I try to connect over the vpn. So=
 the=20
vpn is the problem I think.

Here is some output of what I tried connecting over vpn:

[floh1111@flohdesktop ~]$ ping -M do -s 1467 10.18.1.1
PING 10.18.1.1 (10.18.1.1) 1467(1495) bytes of data.
1475 bytes from 10.18.1.1: icmp_seq=3D1 ttl=3D64 time=3D85.6 ms
=2D-> Works fine till package size 1467 or lower
=2D---------
[floh1111@flohdesktop ~]$ ping -M do -s 1468 10.18.1.1
PING 10.18.1.1 (10.18.1.1) 1468(1496) bytes of data.
=2D-> Does not work with package size from 1468 to 1472, no error message
=2D---------
[floh1111@flohdesktop ~]$ ping -M do -s 1473 10.18.1.1
PING 10.18.1.1 (10.18.1.1) 1473(1501) bytes of data.
=46rom 10.18.0.3 icmp_seq=3D1 Frag needed and DF set (mtu =3D 1500)
=2D->  Does not work too, but I get an error message trying package size 14=
73 or=20
higher.

We are using OpenVPN in tap mode. Below is our server config:
=2D---
mode server
tls-server

port 1195
proto udp
dev tap
ca /etc/openvpn/ff/ca.crt
cert /etc/openvpn/ff/ffsrv.crt
key /etc/openvpn/ff/ffsrv.key  # This file should be kept secret
dh /etc/openvpn/dh1024.pem
client-config-dir ccd
client-to-client
keepalive 10 120
comp-lzo
max-clients 100
persist-key
persist-tun
status openvpn-status.log
verb 3
=2D----

I don=B4t know if openvpn is adding some extra headers but maybe you know?

Thanks
Clemens

--nextPart1815641.zvMrMILhVx
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkwZ9s4ACgkQZgdHbA22lqPxVgCfXm4kH1c8cfmHRfLc8abqwqK3
ZPAAoOFWIzPffA4j8tQUYufj4GdoJTBS
=5wTu
-----END PGP SIGNATURE-----

--nextPart1815641.zvMrMILhVx--
