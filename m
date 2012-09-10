Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 10 Sep 2012 17:30:24 +0200
Message-ID: <15143492.AzxLCfTQHo@bentobox>
In-Reply-To: <CAMVTf1hKCgkmwgz_bUYwULcgFdoSraog2D1HRSZiTi46w7GcDw@mail.gmail.com>
References: <h1pf9bti26g2966o34ml5cv4.1347057546796@email.android.com>
 <CAMVTf1hKCgkmwgz_bUYwULcgFdoSraog2D1HRSZiTi46w7GcDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4699784.FkmmxmePBC";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] How to force a specific network topology
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


--nextPart4699784.FkmmxmePBC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Monday 10 September 2012 10:18:31 Esteban Municio wrote:
> Hi Sven
>=20
> I don't understand very well what are you meaning. Now I have 1 bridg=
e
> over with batman-adv:
>=20
> batctl if add wlan0
> brctl addbr mesh-bridge
> brctl addif mesh-bridge eth0
> brctl addif mesh-bridge bat0
>=20
> Then, should I add a bridge to wlan0 and after bridge it again with t=
he
> eth0?
>=20
> brctl addbr bridgeWlan
> brctl addif bridgeWlan wlan0
>=20
> batctl if add mesh-bridge
> brctl addbr mesh-bridge
> brctl addif mesh-bridge eth0
> brctl addif mesh-bridge bat0

no bridgeWlan should have been added to bat0 and not mesh-bridge. It is=
=20
necessary because ebtables can only operate on bridges.

> And then, should I install ebtables in all the nodes(now we have 9
> nodes, and only 1 have internet access to install it directly)

scp or flash it.

> It seem a little difficult for me :-)

You want to create special network topologies for tests and see changes=
 as an=20
problem...

> Could I try another method?something like set paths manually?
> In 802.11s we have a usefull comand for block links undesirables:
> iw dev INTERFACE_MESH_NAME station set MAC_ADD plink_option block
> nothing similar like that in batman-adv?

Please read the mail from Martin Hundeb=F8ll. And no, it is not include=
d by=20
default.

Kind regards,
=09Sven
--nextPart4699784.FkmmxmePBC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQTgeQAAoJEF2HCgfBJntGjZsQANAdxh4YX7+50Q2bnWRMmb7Q
ZvanKv4jE5z+wRWV9M1Fm1moGAW/0Kb3OHyGrWqVQnsOSb0kGVyidmi5TOwspQI1
b/+SBMBoxvI5bYM/BVG1pPYVGJM0Lf8qX6OzJ+3yJ+jdb7+SoeDcWdEOpTXFsZ7Y
o0TIk6t8tG+u2CU1xtrl9Juq3Atc7uCaPCY9t4+5m30EbO/yRXMXFQ7tcNlpSIsc
OeYfPzVQ2xq9UbZHNy9wleX1T+FQ42WwqhSd2EgwedH/8+ETjKg+d1aJU5MUTPRb
RSXjp6ZxnbiIQ3pTW9B5RoMeS/cqKsXxdfSVdyJLDEoLifs9owqCGZGX58/8fZxU
zQiRJUMNEzYUCznMbq+i99W6H5y2MAroBdSJu2aLkr25irsAuBO1tg7nLtNGoLsK
7yjkGHSWBLU1stNCGi1jeTK/DjTCCpivQRY8h3/aKp/vDjSKtszc79fW0mzYpqlV
QV1suH8sBvyowJH8AKKfeNSSbJx8zknkkaY9LcODqeXCv+uz0T6BkTonqfNcyLOx
NUockEY4GPOqnNzvMw2YHcJX/JfzPWV3XOHMA9Nw9PN+IThYiMKhrYHHN15L1lHI
mUIGw8c5InQe0BkWmYfG5NkQ/dUnSaJP/G/Cpy9TPv/qg1ZypsPOj4wjweP98R7c
DuNVb7j2aFfZj4/tsieN
=bQ2d
-----END PGP SIGNATURE-----

--nextPart4699784.FkmmxmePBC--

