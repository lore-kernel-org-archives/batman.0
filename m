Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu, 17 Jun 2010 10:44:59 +0200
References: <201006171018.47209.clemens-john@gmx.de>
In-Reply-To: <201006171018.47209.clemens-john@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1744267.7OhVRtmxf9";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201006171045.00578.sven.eckelmann@gmx.de>
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: b.a.t.m.a.n@lists.open-mesh.net

--nextPart1744267.7OhVRtmxf9
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Clemens John wrote:
> Hi,
>=20
> I have a problem to connect to the Internet. We are using Batman advanced
> 0.2.1 and IPv4 here in oldenburg. Our setup looks like this:
>=20
> Laptop-[wifi]->Fonera-[wifi]->Dir300-->OpenVPN-->
> virtual OpenWrt machine-->internet.
>=20
> The default route of the laptop goes to the virtual OpenWrt machine wich
> provides an Internet connection.
>=20
> I can acces google (wget google.de) but not heise.de or golem.de. I=B4m n=
ot
> verry familar with network configurations but I heared that this might be
> an mtu problem.
>=20
> All devices in the network (tap0, ath0, ath1, wifi0) have an mtu of 1524
> except bat0 and br-mesh which have an mtu of 1500.
>=20
> Our routers are configured to bridge connections from non batman devices
> (like the laptop) to bat0. This is done in the device "br-mesh".
>=20
> Everythink works fine, except I can=B4t connect to internet websites that=
 are
> not google.de.
>=20
> When I decrease the mtu of the wireless device of the laptop to 1476
> everything works fine.
> But I have to do this by hand and on a client this is bad.
>=20
> Does anybody know what I=B4m doing wrong?

Sounds a little bit like a device is configured wrong. Lets go through the=
=20
devices:

Laptop:
 * WiFi: MTU: 1500

=46onera:
 * Incoming (to Laptop) WiFi: MTU 1500
 * Outgoing (to Dir300) WiFi: MTU 1530
 * Bridge (has bat0 and Incoming WiFi included): MTU 1500
 * bat0 (has only Outgoing WiFi included): MTU 1500

Dir300:
 * Incoming (to Fonera) WiFi: MTU 1530
 * bat0 (only incoming device included): MTU 1500

This should work till Dir300. Now send 1500 Bytes large packets to each=20
interesting partner (fonera, dir300) and check were it drops.

This can be done using `ping -M do -s 1472 $IP`.

If it works till dir300 and drops somewhere in the openvpn/virtual=20
openwrt/internet connection then please check there. If it drops before the=
n=20
please check your configuration (running, not configuration files) and try =
to=20
summarize those devices as I tried to do above.

How exactly is openvpn your connection to the internet configured? Do they=
=20
work in an mode which adds extra headers? Do they fragment packets?

Best regards,
	Sven

--nextPart1744267.7OhVRtmxf9
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMGeCLAAoJEF2HCgfBJntGcwwQAJ7jINnCQzjQb0ctciN+pl3Q
+XhIfC2f7GtiCWZvRMRdpgUh41GP9xOG/9PK2DAmwoEhNsqA1PuEQO9QWHfx9XC8
GwPrVSxVaM8J6YQc8FtdNupyQ5hKp3ZN2IPZ/RDV8s6X7WoT86fsp5Hwf7oVU/Ti
T6XhmuTpuEzw1jn11bVGIAe5B8B20c9i7QJwscx54vZEcziws/IW7YhAzyB3EdU2
H+5QfGSnacsh7t84IxNzRigL4ykvtOKy2PKCcIQ3/aI8SkeFY6HRQxKqB4426U2c
zDgK41ppul5z/R02w3hfcV53MpvyiCx0G3c7gYU9fBUeh3CFn/9IsUFkf9itwXw1
oIisAjDGKVVfw5C/wYo9FiD6gdevFSdMkXJzJTozY40GJ9O4RSmTfnmUhHBrEBSU
hYOm19C+jOxl+CDgjNjFqDJ36DQgm+3h37BKPmvEK+E5+cJC4tQbwmm3z3pPi4K4
/uLk8O5eass7bk2QszgVlq4t4HUnlwHruWYRIXVahbMHHWSQs5EhIHtiMxzLUash
EBAo6LMYCx3my/Me0t7+RkYv4HthYHh2Rf3MkeYP21LJyyusjOFHA3DhTVWe3DfJ
hgq/H+1MKTF3QrdA4YCTmF10j6euKIm3irVAIBr+wo+gyNgGvn0zPPse4pcHQ9Hg
Ia3zn2JxQ609KChxwDiw
=f8pk
-----END PGP SIGNATURE-----

--nextPart1744267.7OhVRtmxf9--
