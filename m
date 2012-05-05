Return-Path: <mschiffer@universe-factory.net>
Message-ID: <4FA54C09.6000303@universe-factory.net>
Date: Sat, 05 May 2012 17:49:29 +0200
From: Matthias Schiffer <mschiffer@universe-factory.net>
MIME-Version: 1.0
References: <33fd135ed9ad65c70bd3a509b538f1d59fa20fef.1336230279.git.mschiffer@universe-factory.net>
	<7681860.DNINY4YzOT@sven-laptop.home.narfation.org>
In-Reply-To: <7681860.DNINY4YzOT@sven-laptop.home.narfation.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0443D2FC94C2F9277B3A5199"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix visualization output
 without neighbors on the primary interface
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
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0443D2FC94C2F9277B3A5199
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Oops, sorry about that. I'll send a fixed version.

Matthias


On 05/05/2012 05:29 PM, Sven Eckelmann wrote:
> WARNING: line over 80 characters
> #102: FILE: vis.c:236:
> +                               if (compare_eth(entries[j].src, packet-=
>vis_orig))
>=20
> WARNING: line over 80 characters
> #123: FILE: vis.c:287:
> +                               if (compare_eth(entries[j].src, packet-=
>vis_orig))
>=20
> total: 0 errors, 2 warnings, 0 checks, 47 lines checked
>=20
> http://www.open-mesh.org/wiki/open-mesh/Contribute#Submitting-patches
>=20
> Thanks,
> 	Sven



--------------enig0443D2FC94C2F9277B3A5199
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+lTAkACgkQq3qIxbiQM9j3iQCglI4M5EweaYc3IcVEzu2rpmuO
7CIAnisgJshI2j3BKTjKJ+SfB0IvKiJQ
=Xuzg
-----END PGP SIGNATURE-----

--------------enig0443D2FC94C2F9277B3A5199--
