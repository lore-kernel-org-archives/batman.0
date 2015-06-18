Return-Path: <antonio@meshcoding.com>
Message-ID: <55831C89.9030707@meshcoding.com>
Date: Thu, 18 Jun 2015 21:31:21 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1434596669-9597-1-git-send-email-mareklindner@neomailbox.ch>
In-Reply-To: <1434596669-9597-1-git-send-email-mareklindner@neomailbox.ch>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jTe7A58j8bSLX3cemneXlb0OS3kqMnTcR"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 maint] batman-adv: fix kernel crash due
 to missing NULL checks
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Marek Lindner <mareklindner@neomailbox.ch>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jTe7A58j8bSLX3cemneXlb0OS3kqMnTcR
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 18/06/15 05:04, Marek Lindner wrote:
> diff --git a/translation-table.c b/translation-table.c
> index e95a424..ae82f69 100644
> --- a/translation-table.c
> +++ b/translation-table.c
> @@ -575,6 +575,11 @@ bool batadv_tt_local_add(struct net_device *soft_i=
face, const uint8_t *addr,
> =20
>  	/* increase the refcounter of the related vlan */
>  	vlan =3D batadv_softif_vlan_get(bat_priv, vid);
> +	if (!vlan) {
> +		WARN(1, "adding TT local entry %pM to non-existent VLAN %d",
> +		     addr, BATADV_PRINT_VID(vid));

WARN returns the value of the expression passed as first argument,
therefore you can directly pass "!vlan" and use the whole macro
invocation as if condition.

Note: if you are going to merge this patch before Sven's one you need to
also include bug.h.

Cheers,

--=20
Antonio Quartulli


--jTe7A58j8bSLX3cemneXlb0OS3kqMnTcR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVgxyNAAoJEOb/4TMchkvfdssQALIR50H0bTkA38a4cLdWfmNk
NpenudYcT6ztUmcEqXM8jKpLU6/lVl/WgjYFYgFnNWIG6mEIOHXnEAsfmfHI7+dU
Buhxu4kkaqLfE4MEYxvsx1wer7FIZiSnYQokOkZwSfN59SnHHKip47bvzhaK5MUt
kwoCas8ft8Igt3h/bF5yURH7K3ponylnP74zl5H4tEhOi2MnY0nHZfvhSWYYuSfs
OYfFNVFsaM0HeszaYPYkTdlTSt2wAESaLav1OOfTR0ScELYwrYC/ivqXi3LHEZe7
KENbpLdClJ22lG/x4bXd0tPoWHRSxFjtfA7aV05FBzKq7AN6kpajOm+DVRe2G2AW
uG+rvye33QW68YQVur6R20oTIjycWy9PnSfxnJkQQXxMlaXEpT30nYemDNbW9XVp
vmZp9XnI81VwyyQZKu/28ogJiVIzqBXoIiR1mpL8CoWLdGCmsEE2QQXwi1kif6WR
0Tkg0gpO3qCpm+KTQwzd3T96JNUnVxaNxpv5E4NeJd7gw3flXm+UL7Lkv2w19S0d
LdiBK9Nk9jJ68ndBdrC00hue33VebAXgcoE5NGMTj2P1KAW5Rm3kLv7oL8QybyW0
bkeCseU2yzeUUAE8kz2K2otFQILbT67Z7ZL8UPkH2wCMEhhnKrP0Kg53/+uF7ZAB
9pJK3APZufwoZjPkGpeB
=BIih
-----END PGP SIGNATURE-----

--jTe7A58j8bSLX3cemneXlb0OS3kqMnTcR--
