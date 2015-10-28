Return-Path: <antonio@meshcoding.com>
References: <1445342505-31122-1-git-send-email-sven@narfation.org>
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <56309104.5080602@meshcoding.com>
Date: Wed, 28 Oct 2015 17:10:28 +0800
MIME-Version: 1.0
In-Reply-To: <1445342505-31122-1-git-send-email-sven@narfation.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3EWMtaTD6AgbOk7DnDreAQvnS2bnPjSb0"
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: Fix invalid stack access in
 batadv_dat_select_candidates
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Sven Eckelmann <sven@open-mesh.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3EWMtaTD6AgbOk7DnDreAQvnS2bnPjSb0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 20/10/15 20:01, Sven Eckelmann wrote:
> From: Sven Eckelmann <sven@open-mesh.com>
>=20
> batadv_dat_select_candidates provides an u32 to batadv_hash_dat but it
> needs a batadv_dat_entry with at least ip and vid filled in.
>=20
> Signed-off-by: Sven Eckelmann <sven@open-mesh.com>
> Cc: Antonio Quartulli <antonio@open-mesh.com>

sorry for the huge delay in replying to this :(:(

Acked-by: Antonio Quartulli <antonio@meshcoding.com>


--=20
Antonio Quartulli


--3EWMtaTD6AgbOk7DnDreAQvnS2bnPjSb0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWMJEIAAoJEOb/4TMchkvfR0QQAKkaH5SCiPxcKvTWAEmh89ud
jXnYLNON3Vi6AeST+nHTbJgevPqM49Ro1HdQSDizKK3G6Zj5q18nqXW56SRmKTSu
OqQw+GXjYv0N/WLvZWr49YqsfLiRgkKUlUKp0BZb+Coj3XirmAnduLI/FoMhXUop
8zG/I5+fFfb59tLR445Gkas+qRApz9J1S9HUnVrjY+mpCXsd+FSnggX5MNBJOIf7
uVp43iHLDRtBL5DOYPA1pzeQ8EChjBTGsD+suMIuz5yUJjUG4oxIhVnWgEASY2Mz
ZT1qI2i99ZtX4SM6YGFX0+kIf3n59vrOLw5pVdqFKKQrr86hvuw3mKEzNS8nglfh
UuVftZn7JsbMOLuYyxKuuuw34ggKa3N6H67D0rty/YigYDE/FS/oPpfxu6EMf8r0
kEEvEKg5S6ljSmLfysnBEOU442mOMKtizk4wxI2BBVHB/z/+nEvTV6N0FrlbcR6u
XU+Cs6WZ3aOQG6QPgzgNtPhTp4N+YnliVxakZAz6yOljnN0pl45Svyz33mZwZSh5
tkgyX6zpyvw8uNSnlBU5LN69ioGrxwRq6rLFuPiuKDeSEuAWHBPGQcXOAwp2epwA
NqAkRA/CbPoztnarkHLA0/Of8H8ThXHh2XwULJlVrOiyMYN0rrbbp44JjC/61Gk2
2nfnw4v9QEWEsb+Cmglp
=jjPI
-----END PGP SIGNATURE-----

--3EWMtaTD6AgbOk7DnDreAQvnS2bnPjSb0--
