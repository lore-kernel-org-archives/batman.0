Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 31 Mar 2014 21:02:11 +0800
Message-ID: <26865236.GIsAj78OZH@diderot>
In-Reply-To: <0643725B-CC5E-4AAA-8908-C6A0EA4CE631@gmail.com>
References: <0643725B-CC5E-4AAA-8908-C6A0EA4CE631@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1428533.CWGQTMvc9n";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Batman-adv 2014.1.0 and 2014.0.0 issues with
	3.10 and 3.8 kernels
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


--nextPart1428533.CWGQTMvc9n
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Monday 31 March 2014 12:23:52 Bruno Antunes wrote:
> root@Laguna1:/etc/config# wifi
> [37620.920000] batman_adv: bat0: Interface deactivated: adhoc0
> [37621.140000] batman_adv: bat0: Removing interface: adhoc0
> [37621.250000] br-mesh: port 2(bat0) entered disabled state
> [37621.250000] device bat0 left promiscuous mode
> [37621.260000] br-mesh: port 2(bat0) entered disabled state
> [37631.340000] unregister_netdevice: waiting for adhoc0 to become fre=
e.
> Usage count =3D 1 [37641.390000] unregister_netdevice: waiting for ad=
hoc0 to
> become free. Usage count =3D 1 [37651.410000] unregister_netdevice: w=
aiting
> for adhoc0 to become free. Usage count =3D 1

This is a known 2014.1.0 regression which recently has been fixed. You =
can=20
either update your openwrt package to fetch these fixes or extract the =
patches=20
from=20our batman-adv git repository or wait for the next release.


> And only restarting is possible to get the device back to work.
>=20
> Going back to 2014.0.0 it's worst with the system being very unstable=
 and
> continuously restarting.
>=20
> After following the instructions from cmsv <cmsv@wirelesspt.net>
> and replacing the feeds.conf with
> src-git routing https://github.com/libre-mesh/openwrt-routing-package=
s

Note that this is not the official openwrt-routing repository but a for=
k=20
maintained by 'people on the internet'. If you do experience problems w=
ith the=20
code coming from this repository, please contact the people maintaining=
 this=20
fork.


Cheers,
Marek

--nextPart1428533.CWGQTMvc9n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTOWdhAAoJEFNVTo/uthzAirEIALN1ziStsyUR6QZ/f+VcDPNk
K1C4VcS+M+YPNpZM1Qs1WNS31wgmbrpYcWvsoLSgROaJtw9CKzjM+IDV0fUKMtzu
AvT8AJoj4JsIBoIfoHbiY9KOWlalnNCOJ9is/jqHFejqU3CSaARO2whTHn6ElHUD
Fl81UBw6qewVn760O5GA9DCJiiQmyx6UJqY9b6d9bo/lN0O4QqyFV67cK9Wv5qe7
+3KcsprERmxE/mOuH+kKvCAwWdP3NWGtsVW9S/eVarTzu62OST1WYDx0ga1BJwGk
wGgzClPVYzb3FPbZ1h2bA1N5EPHeCLT6SyeHduUgImWyYnAnq8SwqoGmkHgx2+Q=
=AuJy
-----END PGP SIGNATURE-----

--nextPart1428533.CWGQTMvc9n--

