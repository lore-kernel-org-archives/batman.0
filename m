Return-Path: <antonio@meshcoding.com>
References: <1440170118-10876-1-git-send-email-sw@simonwunderlich.de>
 <1440170118-10876-3-git-send-email-sw@simonwunderlich.de>
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <55DC3A1D.1060800@meshcoding.com>
Date: Tue, 25 Aug 2015 11:49:17 +0200
MIME-Version: 1.0
In-Reply-To: <1440170118-10876-3-git-send-email-sw@simonwunderlich.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Ifm7p0CihgccaMxXqP8AXSx55ol8biksh"
Subject: Re: [B.A.T.M.A.N.] [PATCH-maint 2/4] batman-adv: avoid keeping
 false temporary entry
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, alessandro@mediaspot.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ifm7p0CihgccaMxXqP8AXSx55ol8biksh
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 21/08/15 17:15, Simon Wunderlich wrote:
> In the case when a temporary entry is added first and a proper tt entry=

> is added after that, the temporary tt entry is kept in the orig list.
> However the temporary flag is removed at this point, and therefore the
> purge function can not find this temporary entry anymore.
>=20
> Therefore, remove the previous temp entry before adding the new proper
> one.
>=20

[..]

>  		/* if the client was temporary added before receiving the first
> -		 * OGM announcing it, we have to clear the TEMP flag
> +		 * OGM announcing it, we have to clear the TEMP flag. Also,
> +		 * remove the previous temporary orig node and re-add it
> +		 * if required. If the orig entry changed, the new one which
> +		 * is a non-temporary entry is preferred.
>  		 */
> -		common->flags &=3D ~BATADV_TT_CLIENT_TEMP;
> +		if (common->flags & BATADV_TT_CLIENT_TEMP) {
> +			batadv_tt_global_del_orig_list(tt_global_entry);
> +			common->flags &=3D ~BATADV_TT_CLIENT_TEMP;
> +		}

mh...interesting..and nice catch. Have you tested this with a client
roaming from A to B during the "speedy join" period?


Cheers,


--=20
Antonio Quartulli


--Ifm7p0CihgccaMxXqP8AXSx55ol8biksh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV3DohAAoJEOb/4TMchkvf6V4QAIxlSK1ZZhoGbSU45qOO7A15
JU6LhWODSow4dIgE2HZfXy9uBlIJeqXvN6LkIauUCyPfBIB0eYQJhPk0JL+jHoR8
lHhxao3XNbpoZPs32RFnZ3jkX1s0WyeSucfoJNSUl110ErXQuY4aEtjb/8fS1YHe
J91hDuW/HTSxMhY/V1jo8OLluNdEIEuXNsGr70imgQi7aUNK+o+otYknyhhL98nF
H7KdOI5d+FTXNXJ68sMyvP05SkoJeFjvTcP5pLO2iulFf6IMeLvdkgyZttUieupm
Q6cejFfaD80mKmcjFhU6CAXia1XfU8REPf5+tND0RTfsD6NGb4MloLSEXqzYnKNe
I+XstZdYdcoCei/WXvand/hsSEqBMKRGnzH4sW7n6Z6QIvmQ7mkBzZqufYYBEx4l
Q0u4O7MHNcizAI4WcgbW2MWVPZ6Y9G2OUChUaA4Yaky2TW/hxTrnQFHMrblDBv/g
I5ZCjNR7BqmdpkAHei3r0MzQ9EEN2ebOOacz5+sO55/KWP/abxfe9bj8AB9hcDud
VUykC0zjs7qXMg64URl+pNpjrupsDCzC+kg1+8jmaGc4Cyv1XalG0jceSXijYgM8
FdbsNa/ErQTTZ8//WiXoBqdze3c46+4nSubf2KhSsRVMA+I8qJ8+xSZObxrmJG4o
7PHn34JUfgWfHGGM8/XU
=Ukig
-----END PGP SIGNATURE-----

--Ifm7p0CihgccaMxXqP8AXSx55ol8biksh--
