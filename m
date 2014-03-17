Return-Path: <martin@hundeboll.net>
Message-ID: <5327209D.2060707@hundeboll.net>
Date: Mon, 17 Mar 2014 09:19:41 -0700
From: =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>
MIME-Version: 1.0
References: <1395062574-28291-1-git-send-email-antonio@meshcoding.com>
 <1395062574-28291-10-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1395062574-28291-10-git-send-email-antonio@meshcoding.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="B8J1RAJOvfx5UcXLj2Dppd5rS23d6E41L"
Subject: Re: [B.A.T.M.A.N.] [PATCH next 10/11] batman-adv: fix more code
	style
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--B8J1RAJOvfx5UcXLj2Dppd5rS23d6E41L
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2014-03-17 06:22, Antonio Quartulli wrote:
> - keep variable declarations in ascendant line length order
> - use common iteration style pattern when looking up an
>   object

Do you mean descending line length?

// Martin

> Introduced by 86cb16e5ec1e2d75821006e8f4abbec66fb741ac
> ("batman-adv: Add IPv4 link-local/IPv6-ll-all-nodes multicast support")=

>=20
> Cc: Linux L=C3=BCssing <linus.luessing@web.de>
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
>  multicast.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/multicast.c b/multicast.c
> index 5a39fc1..166d0a3 100644
> --- a/multicast.c
> +++ b/multicast.c
> @@ -493,20 +493,20 @@ batadv_mcast_forw_ip_node_get(struct batadv_priv =
*bat_priv,
>  static struct batadv_orig_node *
>  batadv_mcast_forw_unsnoop_node_get(struct batadv_priv *bat_priv)
>  {
> -	struct batadv_orig_node *orig_node;
> +	struct batadv_orig_node *tmp_orig_node, *orig_node =3D NULL;
> =20
>  	rcu_read_lock();
> -	hlist_for_each_entry_rcu(orig_node,
> +	hlist_for_each_entry_rcu(tmp_orig_node,
>  				 &bat_priv->mcast.want_all_unsnoopables_list,
>  				 mcast_want_all_unsnoopables_node) {
> -		if (atomic_inc_not_zero(&orig_node->refcount))
> -			goto unlock;
> -	}
> -
> -	orig_node =3D NULL;
> +		if (!atomic_inc_not_zero(&orig_node->refcount))
> +			continue;
> =20
> -unlock:
> +		orig_node =3D tmp_orig_node;
> +		break;
> +	}
>  	rcu_read_unlock();
> +
>  	return orig_node;
>  }
> =20
> @@ -524,9 +524,9 @@ enum batadv_forw_mode
>  batadv_mcast_forw_mode(struct batadv_priv *bat_priv, struct sk_buff *s=
kb,
>  		       struct batadv_orig_node **orig)
>  {
> -	struct ethhdr *ethhdr;
> -	bool is_unsnoopable =3D false;
>  	int ret, tt_count, ip_count, unsnoop_count, total_count;
> +	bool is_unsnoopable =3D false;
> +	struct ethhdr *ethhdr;
> =20
>  	ret =3D batadv_mcast_forw_mode_check(bat_priv, skb, &is_unsnoopable);=

>  	if (ret =3D=3D -ENOMEM)
>=20


--=20
Kind Regards
Martin Hundeb=C3=B8ll
Frederiks All=C3=A9 99, 1.th
8000 Aarhus C
Denmark

+45 61 65 54 61
martin@hundeboll.net


--B8J1RAJOvfx5UcXLj2Dppd5rS23d6E41L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCgAGBQJTJyCdAAoJEI7EM4tTnYEZ0rUP/3/zG62CZIH3NdyhLqSOkccO
3CizLNS+xrxTRk0frA8Sf+D43+AGM28cMaalskkMB1zp9Y15gFZNSCYmKhivd96N
Qnxa8IqvUXdTy7aEeTEsNmFb39ywl5xduFimVkykL72tFxp8FlBCayfnwQuDlzB1
/We0SBbDKmNSk6xTCZ0dFYxa6s58rSqPvSerwm3ZyLPf4pFwDDCZA1+uGR2HYaHf
Pl9U6KefPY3M21ueZqYS6IcJ3FgPmQ0GFsBWqOrIeJYuZJ8EFVwLC6dBal8riMKt
p2LPbkPGz+Y4KthlnXxfIPkXv0/v04VHH8hsp8Ytg1ZuYOLXuNCHf487ehVO4fQ6
m/EXAwzev21IDHI05+gv8fhz1eKCfcqLRsR5gxrzI5nToGTfqQw7PyCZo68EM4o4
gQ67yEQklynt2kCQEP4qA2Zza7o4tY3T51WTOJDlQLFaaokpCwPUPVJMQUCB0KiT
MmxFx7OIiFu8K9sTGlQ93/lNddX/c+sPRFXrfDFUthiVgIuAmArXolPZrC17/rbk
PBbVeKnjGSnPG14861letg+IzKrBufWPlWu4KLKQ3fJwAD5ZOGwK8FSnqQ7X53SD
ZuAUZqLa+h2BKM7RraGD/ylJj7njgDuefEfwikaADm9DIn7PCAysgP62LJyWzwSU
8iCFyB1inrQ8aReTTIEP
=18UB
-----END PGP SIGNATURE-----

--B8J1RAJOvfx5UcXLj2Dppd5rS23d6E41L--
