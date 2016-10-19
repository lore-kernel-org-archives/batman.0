Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 19 Oct 2016 11:20:56 +0200
Message-ID: <492291841.1k3llEQihP@bentobox>
In-Reply-To: <1470514996-32044-2-git-send-email-linus.luessing@c0d3.blue>
References: <1470514996-32044-2-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1560101.FlRO207iZE";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [v3,
	2/2] batman-adv: Use own timer for multicast TT and TVLV updates
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart1560101.FlRO207iZE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Samstag, 6. August 2016 22:23:16 CEST Linus L=FCssing wrote:
> Instead of latching onto the OGM period, this patch introduces a worker
> dedicated to multicast TT and TVLV updates.
>=20
> The reasoning is, that upon roaming especially the translation table
> should be updated timely to minimize connectivity issues.
>=20
> With BATMAN V, the idea is to greatly increase the OGM interval to
> reduce overhead. Unfortunately, right now this could lead to
> a bad user experience if multicast traffic is involved.
>=20
> Therefore this patch introduces a fixed 500ms update interval for
> multicast TT entries and the multicast TVLV.
>=20
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
> Reviewed-by: Sven Eckelmann <sven@narfation.org>
> ---
>=20
> Changes in v3:
> * added missing #includes
> * fixed parameter kerneldoc of batadv_mcast_mla_update()
>=20
> Changes in v2:
> * updated kerneldoc regarding bat_priv->mcast.mla_list "locking"
>=20
>  net/batman-adv/main.h              |  1 +
>  net/batman-adv/multicast.c         | 62
> ++++++++++++++++++++++++++++++++++---- net/batman-adv/multicast.h        =
 |
>  6 ----
>  net/batman-adv/translation-table.c |  4 ---
>  net/batman-adv/types.h             |  4 ++-
>  5 files changed, 60 insertions(+), 17 deletions(-)


Applied in 40b384052672ba06cd2a764e3d87f947d0fd6891 [1].

Kind regards,
        Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/40b384052672ba06cd2a764=
e3d87f947d0fd6891
--nextPart1560101.FlRO207iZE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYBzr4AAoJEF2HCgfBJntGrbIP/0dmtgpF2cAh7LAN6GvfOgx8
z8JD7o5dWsAjyLOc4QWa2kbcj0pEFYLJgiqp3b2Z1f7VPHW4gwZH9xiJwKwwiOVN
fzfXaSySqh02OoIzFnuNZ7Gl4DMrE4cZir9jg/NSRsye4jNk3aOsbnGtDo20n6ft
kFnGoux+oRp6p0hIRymJDJTogyKc23XUN9Fl/AL6xl2d8I/8lYGVEdCtsh51Zcid
msdirAG8hrRSrK3WJ3+GLQGRZVElVdkjHh0oINrfmNdVptJWwqsGDgqmURnxQzA+
YBScEYCPJxX5i7BNipw16rs0w6Z/nLVsoadbcFDwx/nPI9/OMD7sn1eo8ySA9o+S
Xe1ZU7BoQavTiRpIijPtLCuE8zu/gCv7AAGI+M/UTcpEYk7My8fBdPK8C+8kIl1H
nKCEBWFRcFiY3Mere0XGmfwR4loE0UfACSOkWGczTL8OcVT3WLcOeBjbyW7CehgF
Wq7rn+NAIZ+on8fhzAD4WaDwe5H67tvEaN2uRbK7E5ThtvqNV0BdqRDejpvI4ZCO
cbV/39qW7mHEUkqnJ0109QObX75EIUaxvcLOy6MAwq4YfHexpoSOog0cjOkTg3Gm
ru7TC7b+NpCEpV1maM+Zugrurva5jMdonDFBx5EvA0FwZblddLJ9HdrKhYR+TFAi
NiCIexPOspb+P+F10Ize
=4oOI
-----END PGP SIGNATURE-----

--nextPart1560101.FlRO207iZE--

