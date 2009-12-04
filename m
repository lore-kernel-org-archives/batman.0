Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Fri, 4 Dec 2009 14:55:02 +0100
References: <20091129200950.GA19275@pandem0nium>
	<1259842422-2566-1-git-send-email-simon.wunderlich@s2003.tu-chemnitz.de>
In-Reply-To: <1259842422-2566-1-git-send-email-simon.wunderlich@s2003.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1596597.kgHlBl8bW3";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200912041455.03240.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] [batman-adv] Removing the big batman
	lock
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
To: b.a.t.m.a.n@lists.open-mesh.net

--nextPart1596597.kgHlBl8bW3
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Simon Wunderlich wrote:
> @@ -131,9 +197,12 @@ struct orig_node *get_orig_node(uint8_t *addr)
>         INIT_LIST_HEAD(&orig_node->neigh_list);
> =20
>         memcpy(orig_node->orig, addr, ETH_ALEN);
> +
> +       orig_node->lock =3D __SPIN_LOCK_UNLOCKED(device_client->lock);
>         orig_node->router =3D NULL;
>         orig_node->batman_if =3D NULL;
>         orig_node->hna_b

The initialisation is wrong here. You must use spin_lock_init and not use t=
he=20
static initializer - because it isn't a static variable.

Best regards,
	Sven

--nextPart1596597.kgHlBl8bW3
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJLGRS2AAoJEF2HCgfBJntG59wQAJPVhmQwjKu7/hBVuoq2Q1cb
eUhH3vfohATfTgAhZYqJpSzDVsqKbgIV1gvgNbioDB1roiPX6X2pYm6TCMYCnpEP
M1HUXj1nHpZ/z6Htrx9n6qYFsPsAYqbrdRjmifaL0KyqjOIYOMjAXHGrGEHjzWZK
auv+EnVyVPcDhLVQHWdlWPSZJJDRfz0eI9SvoOcobE4WXtmQ+y6pbkBiksyXkyyT
DbkxdD7crX8RR4EVqN0UHR3CACdpcMFECMWitNJGyKqB3wYkLrLvF1FWIxwv0eYR
0c1suoNma7kwobEXqzVdz+2UFftBXBd2imzmMwxxVJXN8TINxwOYtO9nVwklK7Ve
dpRt9r3u3vKyRJjS6TICn8ChqI6ArhL0vhXN+BdkAzk5rwjhua7Yy0dU4zwBgMuC
gzodBMVTKL/Z6KpW38XuHToLJ+4EYL5WtcHyhE44vkvSiCud4btP7ZivfjRQ1fQe
zzZU4aDFHULbnvel/WRiV0RZYtLKC+U4SwbgiFIw4qnQ/yR+etVno5z9ex+/Z8DZ
+TXOURwIzrHhvBMtAAEPFumw8dN7kzNkS+0cl9XCCHjwB9+Y/e8e3G5NsqB9eCdd
pKN4GJtV5oLVHPNJHk8ILO9h/g5sN6Uqkh5cHFPzd1+i007KXiC+b08HyuQIPsTp
azb8YZXOy75L5PeUY9cb
=T6+M
-----END PGP SIGNATURE-----

--nextPart1596597.kgHlBl8bW3--
