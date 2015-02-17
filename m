Return-Path: <antonio@meshcoding.com>
Message-ID: <54E330F3.7030602@meshcoding.com>
Date: Tue, 17 Feb 2015 13:15:47 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1424136699.8287.10.camel@perches.com>
In-Reply-To: <1424136699.8287.10.camel@perches.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Hua2GoXgDPv89FdQt8o2giUhOKxdOXGjo"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Remove uses of return value
	of seq_printf
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
To: Joe Perches <joe@perches.com>, Marek Lindner <mareklindner@neomailbox.ch>
Cc: netdev <netdev@vger.kernel.org>, "b.a.t.m.a.n" <b.a.t.m.a.n@lists.open-mesh.org>, LKML <linux-kernel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Hua2GoXgDPv89FdQt8o2giUhOKxdOXGjo
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Joe,

thank you very much for this patch.

On 17/02/15 02:31, Joe Perches wrote:
> This function is soon going to return void so remove the
> return value use.
>=20
> Convert the return value to test seq_has_overflowed() instead.
>=20
> Signed-off-by: Joe Perches <joe@perches.com>


Acked-by: Antonio Quartulli <antonio@meshcoding.com>


--=20
Antonio Quartulli


--Hua2GoXgDPv89FdQt8o2giUhOKxdOXGjo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJU4zD3AAoJEJgn97Bh2u9ejZMP/2auH6FTeHEdEEPnUl0e+6Zg
gWsTCft0qbwhHyMBDaqrMYNprohYHSeceyq8+1Oa9JTOGrfHhItBht3UjUKmwXgV
dppsks9MfsZfqtXKQkc5BUj+ho21fYkHL4Tnvu0ASPekIO/zhcKJELBRcvq3ECCu
dUINtvv+qMNhZRottD4g5nhxSM7fjr0ioogOVTg6bLBfCPgUVwFeZpfB5CohpsbA
AsZY3+YNbdGuzOchXnhV9+FUkezGBhLVNaq4wXhodIANWpzRCE1l0WsCXcEn8XnY
Fck70SjSIUEGHdSPvk4zh2nl1ecjp5mIL7oe1b7dATQ1tIajBGc/NmCJwXYBvBWW
mfkfDGwhorAdFRnT9fOqaFeO4RCUaxI2ddc5Pg9k/uEsIHp8Tur5A6IdpGg99WTY
DrZKA7WReS/ZMSlSvGVhqSFQXLf+6oHvyEbKZ+nZfkmKgcUTHsHluWusB8F86TaM
JQVtE4PvKA5ehb66Lx2g+JyEt1wnLGidba8ojqI6zLNMUowaIb0K72SbB5DEM5mo
iLFCGCEZ6hk7lpv1FFaqqE8+t2U2PyE65kK0TmAM4Exddc92AsgYdUtdM0N1DAFO
BlQEyCxmij+POIimnVcI8Af5KjVyG0x1JT49jNuW5dlg2ssSpeLQatpc/HOFMWE1
rmT/VWCvkzrvC2Vpqx5F
=h/ly
-----END PGP SIGNATURE-----

--Hua2GoXgDPv89FdQt8o2giUhOKxdOXGjo--
