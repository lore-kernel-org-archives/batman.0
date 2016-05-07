Return-Path: <a@unstable.cc>
Date: Sat, 7 May 2016 17:33:57 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160507093357.GD3907@prodigo.lan>
References: <1462566429-26709-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="SWTRyWv/ijrBap1m"
Content-Disposition: inline
In-Reply-To: <1462566429-26709-1-git-send-email-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Fix double
 neigh_node_put in batadv_v_ogm_route_update
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Marek Lindner <mareklindner@neomailbox.ch>


--SWTRyWv/ijrBap1m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 06, 2016 at 10:27:09PM +0200, Sven Eckelmann wrote:
> The router is put down twice when it was non-NULL and either orig_ifinfo =
is
> NULL afterwards or batman-adv receives a packet with the same sequence
> number. This will end up in a use-after-free when the batadv_neigh_node is
> removed because the reference counter ended up too early at 0.
>=20
> Fixes: 667996ebeab4 ("batman-adv: OGMv2 - implement originators logic")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Tested-by: Antonio Quartulli <a@unstable.cc>

it fixes the crash reported in "Kernel panic by BATMAN_V @WBMv9" for me.

@Marek: can you also test this patch in your environment to see if you stil=
l see
the crash?

Cheers,

--=20
Antonio Quartulli

--SWTRyWv/ijrBap1m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXLbaFAAoJEJ4aZjxxc6bKiSIP/3GWtneD2f/GQcyx4aYG82UT
oP7O+1Ov+Rydgs7g6Irljd0ED5m/g7SiiOmDpNXV99Rf+cfVzbMq3qg1qv7c67QL
27Z/6jpJB3VdwNs6XY1DKFa1K47Akg6OkqnuyTMmIlJxomwT4XyRrj5imqomaDHi
JuRDEMH0BQiQFV8Blw9xc0j2iyx9XPGqq2+QyL3D9etpTGE9702B6TyoWffnqLM1
JiOYKungBWUCPbibUe2/Z6k4xnqXjXjB6y//QrDwh7ouJxZvJN3B4Ubqg2oGL6Zn
U4Nkun/Y/+35FOpX7OuY7V+CHIjO5yDXYraqMffuX20Cepxn/GzVr8wCiRIoFB7Q
CkNB8/HY3Da8nxwjmvIJWUKa7EJeajLqFgzp2ppN0zhVHpvrB4LmLTtNq1MPRKfV
l0V8iNNaq+wcLBv9onk46yETF+d++ASsn5NERVynl3IeOcYEOWpcnDbZZEO4BmDM
zWjRlliEnGmFqDgPB7B27xhSixf7mb6mjxqXVod1CTf+i2mcfv+3ui0OkczmmWR5
Jk6cRzBSx0+FypMf48lLF1ORrLHC+ARXlkZDd90DpZoWCQ5R8Uc7AaaTbPG9rafb
rnfMEsQjchCjzbMFMqfI/OEL/ewEPPanjisuovTYQ5VLN+7FoYZ7OH6TT7yuUpZp
0ySnu52mwuK6LPEOhTLb
=5ZaR
-----END PGP SIGNATURE-----

--SWTRyWv/ijrBap1m--
