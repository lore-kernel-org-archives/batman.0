Return-Path: <antonio@meshcoding.com>
Message-ID: <559173F3.2030007@meshcoding.com>
Date: Mon, 29 Jun 2015 18:36:03 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1434890572-3199-1-git-send-email-sven@narfation.org>
 <1434890572-3199-4-git-send-email-sven@narfation.org>
 <55911414.90404@meshcoding.com> <43504885.6syhKky5ln@bentobox>
In-Reply-To: <43504885.6syhKky5ln@bentobox>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RKaaLk6wo4FLs9Ci8ht1PwlvPK49u4DJR"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 4/4] batman-adv: Fix gw_bandwidth
 calculation on 32 bit systems
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
To: Sven Eckelmann <sven@narfation.org>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Marek Lindner <mareklindner@neomailbox.ch>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RKaaLk6wo4FLs9Ci8ht1PwlvPK49u4DJR
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 29/06/15 18:16, Sven Eckelmann wrote:
> Only the configuration for users is not correctly stored. For example=20
> 4294967296Mbit would result in 0.1 Mbit instead of showing a failure. T=
his is=20
> hopefully not the biggest problem.

Thanks for the explanation. I don't think we should consider this as a
fix then - it looks rather uncritical and rare.

>=20
> Just tell me if you want it resubmitted against maint (Linux 4.1.x).

No, thanks. This is not required at this point.

Cheers,

--=20
Antonio Quartulli


--RKaaLk6wo4FLs9Ci8ht1PwlvPK49u4DJR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVkXP3AAoJEOb/4TMchkvfj+AP/RbQ3j2Z+SItRGQfSKNhvadZ
mkzc7xcIERlxFTI30rg1jGTC7IT44/k4TH+qhSsSTS7Dae8XPx3h+a1ldcEIbn3W
rQTf35FfqqKGkTQ2TP4Oi9a3q1Gk1t124c12NZaTaQu6WLsNmGy2H1+gCoNKqp1L
w045UZoyZTkY80R7sM0lumLDqYSdSn8k0Z8UrFKetgzFCtRP6ksimdHObEv0zLLP
c3O4ygNdR9mAtvZCCUgdz3kFLwQ2RckLC02hRm56QxNGanX+glktzcvbgXSUoqQE
/8yCZNQGI5GE9Oa+vS0e+MKTtuV0kKUg+tlxCtMT8uR8hQZXEykBZ/cXianMwYmr
ZssXKOWJ7qDivq4RYNGPo+TI6GlZS9gbHvNwjqmQF6PKBQy3E0iRH5ORcqsjEiOx
MuCAs3GhfSt9T0VT+5xbvd1j483c43Jx4qOmfnQUeCR+w4JPqIiXZB6x/KvUboKb
yw4YLPPW8uWPo4D3ZcnZ08CKnqzWgt0/P1j9PDKLGWxXR9XvM/Ar3Ry1RAW3j+M1
9WNmOZ0lDhxSL+7TpDF0c7Lv543vuCqA8VsweiC09rXfKmrhyAqk0qCT0kOvgBjL
CfoHEgP1Lpm4u5e1tNKJIaBvHWM/PT/D0or2lRyVQKZAH9Wv42fy4O8Pu4N/2C5V
umGTy9F7c8o/JYnESMvj
=wUyt
-----END PGP SIGNATURE-----

--RKaaLk6wo4FLs9Ci8ht1PwlvPK49u4DJR--
