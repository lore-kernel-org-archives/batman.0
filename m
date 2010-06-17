Return-Path: <clemens-john@gmx.de>
From: Clemens John <clemens-john@gmx.de>
Date: Thu, 17 Jun 2010 10:18:40 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1318298.QiiENhNuWK";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201006171018.47209.clemens-john@gmx.de>
Subject: [B.A.T.M.A.N.] MTU/connection problem
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

--nextPart1318298.QiiENhNuWK
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I have a problem to connect to the Internet. We are using Batman advanced=20
0.2.1 and IPv4 here in oldenburg. Our setup looks like this:

Laptop-[wifi]->Fonera-[wifi]->Dir300-->OpenVPN-->
virtual OpenWrt machine-->internet.

The default route of the laptop goes to the virtual OpenWrt machine wich=20
provides an Internet connection.

I can acces google (wget google.de) but not heise.de or golem.de. I=B4m not=
=20
verry familar with network configurations but I heared that this might be a=
n=20
mtu problem.

All devices in the network (tap0, ath0, ath1, wifi0) have an mtu of 1524 ex=
cept=20
bat0 and br-mesh which have an mtu of 1500.

Our routers are configured to bridge connections from non batman devices (l=
ike=20
the laptop) to bat0. This is done in the device "br-mesh".

Everythink works fine, except I can=B4t connect to internet websites that a=
re not=20
google.de.

When I decrease the mtu of the wireless device of the laptop to 1476=20
everything works fine.
But I have to do this by hand and on a client this is bad.

Does anybody know what I=B4m doing wrong?

Greetings
Clemens

--nextPart1318298.QiiENhNuWK
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkwZ2mAACgkQZgdHbA22lqP6rwCfd4dsAQn3YEOMgOpheLAVp5af
mn8AoIobqNa22nh3Ky37zBInyUyrKPUn
=dVI2
-----END PGP SIGNATURE-----

--nextPart1318298.QiiENhNuWK--
