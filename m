Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 21 Oct 2009 12:00:14 +0200
References: <45f642440910200802u6864b4cfk6b52f03bed14f8fe@mail.gmail.com>
	<20091021070510.GK23663@lunn.ch>
	<45f642440910210035t5e5b8589kc676459a1470bbdb@mail.gmail.com>
In-Reply-To: <45f642440910210035t5e5b8589kc676459a1470bbdb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1542418.jKiLcpounr";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200910211200.24602.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] basic B.A.T.M.A.N-adv setup
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>
Cc: Marek Lindner <lindner_marek@yahoo.de>

--nextPart1542418.jKiLcpounr
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

=46rancesco wrote:
> Hi Andrew,
> it (obviously) worked, i got the trunk, make and make install batctl after
> batman-adv.
>=20
> Weird that:
> $batctl o
> BATMAN disabled - primary interface not active
>=20
> I just run this script:
>=20
> insmod /home/francesco/trunk/batman-adv-kernelland/batman-adv.ko
> ifconfig wlan0 down
> iwconfig wlan0 mode ad-hoc essid BATMAN_NET
> echo wlan0 > /proc/net/batman-adv/interfaces
> ifconfig wlan0 up
> ifconfig bat0 192.168.1.1 up
>=20
> What is wrong?

I think that you found a bug in batman-adv. Please add the wlan0 interface =
to=20
/proc/net/batman-adv/interfaces when wlan0 is up.

Best regards,
	Sven

--nextPart1542418.jKiLcpounr
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIbBAABCgAGBQJK3tuvAAoJEF2HCgfBJntG+NcP+L6hlZylcnX1CHZVY0rA9gpq
0RLLo/gDafpTLGOobiyjfqwOPsHvj7tFZvR0oqIWRgY2MDvuAIG7hGemeuOgH3nw
g47vStVygUDyl+t8FJI9j5w3pCbbnzi7BKRF6cQDfSIxH6T0AZbAe5Q+B3XHQG8k
BiU/0U8lTMKV4y4jfrQnM0danijjmdyTfVXaQH8LkvZtMEjCSAXAb1jnF16zYkXk
tnK4xHzjDZS5XLwPnzodMWcY2o7YAKDm5BoWPkVTnReocI/olf1BieABiC5qWd4b
pyjwqp7VsoDyinYZlpHm6hhiwEqNlWfS9TeRMmGs+7ITWw/Dtw49wvtirjcPiSxi
/YLVEYr6oFf31VAwyQauQaeAeEBbRRja7NfelE843vmhR8noIe/RcvoI7M5nhDQ/
MAR03O3wEPEBX/eGAnDGb0bvfDkwsYpFLY9mBqsMcDm8L8W+/iCV1YEALrc4zH2x
jtDhCNp4O3HtSsxYRpaFrk1m3JfSuepElDW/+7dorY7VZwsWIm6EdURqZmBghQsi
3c3d8VKmJHh013ULgd0fRrvxpnsG5goBptWIRy9LG246VoVMLA3oNZFJUn98ZSvN
hS57mtxuJnwooWuCOwValojmqwqrbt3mWwSPiSV3ohhUGf2JYhvYlH+fi+jZL/WD
iLY5KCIdkDDLzEvxjbY=
=GuZM
-----END PGP SIGNATURE-----

--nextPart1542418.jKiLcpounr--
