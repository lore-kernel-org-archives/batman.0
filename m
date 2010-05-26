Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 26 May 2010 12:39:22 +0200
References: <20100525225411.GA23108@pandem0nium>
In-Reply-To: <20100525225411.GA23108@pandem0nium>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart63748367.EbFt3yW2BM";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201005261239.35972.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] Staging: batman-adv: bonding and
	interface alternating
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

--nextPart63748367.EbFt3yW2BM
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Only some non-technical comments about the patch for now:

I thought we decided that the "Staging: " part in the title will be appende=
d=20
when the stuff will be send to Greg and should be omitted inside our source=
=20
trees. Also your patch wouldn't apply in linux-next because the bonding stu=
ff=20
is in master and not in maint (only maint will be send to the kernel folks).

> This is an experimental patch and targeted for upcoming experiments at
> Wireless Battle Mesh v3 in Bracciano/Italy.
>=20
> Feedback, comments and reviews appreciated!

That part is quite interesting for the mailinglist but should not be part o=
f=20
the commit message, or am I wrong? In that situation such information shoul=
d=20
be appended after the "---". git-am or similar tools should automatically=20
ignore that parts, but the receiver can still read that comment.

> Index: a/batman-adv-kernelland/main.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/batman-adv-kernelland/main.h	(revision 1679)
> +++ a/batman-adv-kernelland/main.h	(working copy)
> @@ -63,6 +63,10 @@
>   * to be considered as bonding candidates */
>=20
>  #define BONDING_TQ_THRESHOLD	50
> +#define BONDING_NONE		0
> +#define BONDING_ROUNDROBIN 	1

You've wrote something like "space""tab""1" here. Can you please remove the=
=20
space before the tab.

Have you already painted some nice graphics or wrote some text to explain t=
he=20
modes further (yes, code is the best documentation, but a bad specification=
)?

The rest looks like it should be tested in italy :)

Best regards,
	Sven

--nextPart63748367.EbFt3yW2BM
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJL/PpbAAoJEF2HCgfBJntGtI8QALu3xlE8Chay3+OCqaSMu7vH
M5wormQsDEF17cRC2/5JTToyAaVEMIyCJL2ERJnl7n3C1DgpUCMg13Yi5657Xcjk
GGqjTShRWcPz+WkI22GJLA/zYaupcd+C2PdTQo2LUidFGSrfd4OcbtqalpQCkiTU
yHLZdDei33vdBIESUArB0EXyKJlOXovqMc6V/dbn+RxwYxNqmwlvEHZnf3T1HOWJ
2pg15AGazx8RwikpjKt7NzvfeWSLgEKI8hmdf7UVZo6Zmmzf3Ef/kFjYQcBJxv7x
veEZyDx87fGWTB83mKsephQbp+S6ftDQkAmB9bvl0HatC1NvA9XkE7uATJfVVcEy
7oIpscocRfCDACIfFEN8x6HejhuNuWmlBcSUnJzg8l53WDO0zJocauGuPEbXEoQX
g8iSK/WAHjIapsrtn2R2+4Yl0UmXvngAsZBZHK5XxAV90o39J+knmQxIeRDwBC4p
wPhggGqQSdtYmN//Zmemb4SnCK3a7GehcHkmiWGeMPMBsWip/DF9vOP7DvKj7an1
8EPBWfBZJX7+PJtCxu/Sn9F8ha4jsHUQlaXU0x9tGVwUX4GPRFcIRFNBcIHH5LjD
qDBSU3A7M5vbkYlk88aoxtxc8u8C+kqS469EHpLYIUfyVCP+EVUKNr2PPobTQf3y
WbDn7C0cNksSOsOUXlt5
=ICxW
-----END PGP SIGNATURE-----

--nextPart63748367.EbFt3yW2BM--
