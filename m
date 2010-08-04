Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 4 Aug 2010 11:34:44 +0200
References: <4C59311F.7040500@web.de>
In-Reply-To: <4C59311F.7040500@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4137301.GrK3Wm1keP";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201008041136.02927.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Problem openWRT "backfire" and "kmod-batman-adv"
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
Cc: Tim <Timbo2001@web.de>

--nextPart4137301.GrK3Wm1keP
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Wednesday 04 August 2010 11:21:35 Tim wrote:
> Hello,
>=20
> I'm trying to build an mesh network with B.A.T.M.A.N Advanced for my
> bachelor's thesis. Building an Image used to be no problem when the
> Batman-package was called "kmod-batman-adv-kernelland". Since there is
> only "kmod-batman-adv" in the OpenWRT repositories I have the following
> problem: Compiling, transferring and connecting is no problem, but after
> I change some settings in "/etc/config/network" and
> "/etc/config/wireless" and restart the router the power led keeps
> flashing and there's no possibility to connect to the device anymore.
> Only ping is working with the ip I set it to.... When doing only a
> network restart via /etc/init.d/network restart the device shows:
> "Segmentation fault" and then freezes.
>=20
> I tried compiling an Image on either 32 and 64 bit Ubuntu / Kubuntu.
>=20
> Do you have any suggestions?

Please connect using a serial console and provide the output of dmesg.

Try to load and configure it by hand to check on which change the problem=20
appears.

Best regards,
	Sven

--nextPart4137301.GrK3Wm1keP
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMWTRQAAoJEF2HCgfBJntGXh4P/2j7ow4aKfHsMBVmox7Ljcaq
exJyBJQwvrZRjJYz2OQtheRaxSP1gINHFSlm+ys0oA+ASLu1W/lr8GFaQYjATqFx
ZOP9B7kxRtjLhtYit/SukUB48PYnmWMjoUfBe8BW70nLTaAc5iZEKt309uPsCwdR
DAbg5h8N+2ZjZu1YaR4DgjQO0iyuvEyVd+bbn59pK5koBfwYcO96JtX6GSeWZRzK
z4fy4wClITkakbTtIJYcY4TJG0AogpUhSKMUmW+JTio8JtQ5lWl8frpq0woOsNtz
vsZtewY8xDcr9broePBNKabwp234sHjAZ1AbefRSaF9QzD3N5FN16Y1JZVK1bn6A
2wi3gMzkXzBaGNpU9Gsz9uE17Jml0Xjx3gWT7b4lHNJvWgfs8A86D9tf11BGa8Ca
ZznK6Gmbq2wTBVLYcOgbT5BNJE1mGR3BfBNyaaEmFaiu6/EQjKDHOZBG4w+z9/xi
/Ok0CYZ+VcG9X0DPKA2nfNP5bES8kvwbij9i+oMTCBGXWdlS+/+51quLiDG1zJUe
d9WnpRQ5faxj5QPAWvEsDRZ5r6rUNEILVXgAmUCxM7M2UccTuaKZR6nc+MMrd/hM
bfJXdy/9pp2943XSE6PIgnp9dmqqVXNWwXu0/c20hJUI2yk09d4DhjOY1nggSlt7
/zpcmJDLVXwR+K9NAljQ
=Ve8D
-----END PGP SIGNATURE-----

--nextPart4137301.GrK3Wm1keP--
