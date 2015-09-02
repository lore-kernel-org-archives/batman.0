Return-Path: <antonio@meshcoding.com>
References: <1441217396-18043-1-git-send-email-sw@simonwunderlich.de>
 <1441217396-18043-4-git-send-email-sw@simonwunderlich.de>
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <55E73C00.6070806@meshcoding.com>
Date: Wed, 2 Sep 2015 20:12:16 +0200
MIME-Version: 1.0
In-Reply-To: <1441217396-18043-4-git-send-email-sw@simonwunderlich.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SRvXoAC00dWW1hvUx1L7rh9XMbnkxKXux"
Subject: Re: [B.A.T.M.A.N.] [PATCH-maintv3 3/3] batman-adv: detect local
 excess vlans in TT request
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SRvXoAC00dWW1hvUx1L7rh9XMbnkxKXux
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 02/09/15 20:09, Simon Wunderlich wrote:
> If the local representation of the global TT table of one originator ha=
s
> more VLAN entries than the respective TT update, there is some
> inconsistency present. By detecting and reporting this inconsistency,
> the global table gets updated and the excess VLAN will get removed in
> the process.
>=20
> Reported-by: Alessandro Bolletta <alessandro@mediaspot.net>
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>

Acked-by: Antonio Quartulli <antonio@meshcoding.com>

--=20
Antonio Quartulli


--SRvXoAC00dWW1hvUx1L7rh9XMbnkxKXux
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV5zwAAAoJEOb/4TMchkvfK7gQAIggM8kHQUhmS/w2wMiF4Xg9
8ENjhDvxboKLRA9xeXoeSgzwyDWczQCV4XNXKmp0WKUArLA3yjEOyIQKSz0Rwu7T
6uTpam88oU8Em1Yhr0dKUFoECgkxt+Dy9yPR1++MTv2J7iiF8zkhX0ab07G8huPr
EGS5cVtkQbhNysjKXWcE8yMMzkPc4zW3AomSDkpoTiWH8PR0CP3Iz+U9j5WbItby
F/t70NgpSVdvfas8CFsM+cLAcNjT7tS/kamYA2usoQAlNZ0VHaovpWNTFLZhEIQq
v4kHfEyyzNN6efVj/ijvzv0GajE8QGHe0F05QhAKqlWZSMGs81zrK8PYPZ3XLihL
v7yAE1xQlSw6KBcLUsl0r4lgaOnUiANYyLGk3UHHEyu1dNnPBB44URf9WQsvgkmR
gcSDm1bohdm4XpfdoUU2JV5zf2NX6oao4gcf8SfjHdxPOt92bZFMEPVxMU4TgxBM
rAd2KnuvmvYK67UL9HZGKCSYBLMk3wknNkVWedbuM0RiD3qyaPl5168g90oYSBwt
CPMPFEMeTk7jICUKxnOrUr54oq+u3wATiUZ/GDoJFYqiHSOS2VEpEdDva7X8Udaz
x9aQ1fP6bAty4HpT1Qw5VwH5jhFapqe/kTiWBJra8ThscHQmW6zaTKNSDTjIdE9Z
KfmEAPwugwDGUsvE5tE0
=Zb5y
-----END PGP SIGNATURE-----

--SRvXoAC00dWW1hvUx1L7rh9XMbnkxKXux--
