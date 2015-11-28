Return-Path: <antonio@meshcoding.com>
References: <1448305042-5806-1-git-send-email-sw@simonwunderlich.de>
 <1448305042-5806-2-git-send-email-sw@simonwunderlich.de>
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <56591657.6070401@meshcoding.com>
Date: Sat, 28 Nov 2015 10:49:59 +0800
MIME-Version: 1.0
In-Reply-To: <1448305042-5806-2-git-send-email-sw@simonwunderlich.de>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="TkFpI2h3im08J9iwEtLSnfA0GHQjT46nx"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: fix lockdep splat when
 doing mcast_free
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>
Cc: Simon Wunderlich <simon@open-mesh.com>, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TkFpI2h3im08J9iwEtLSnfA0GHQjT46nx
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



Simon Wunderlich:
> From: Simon Wunderlich <simon@open-mesh.com>
>=20
> Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
> ---
>  net/batman-adv/multicast.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
> index 8abf488..d984eee 100644
> --- a/net/batman-adv/multicast.c
> +++ b/net/batman-adv/multicast.c
> @@ -801,7 +801,9 @@ void batadv_mcast_free(struct batadv_priv *bat_priv=
)
>  	batadv_tvlv_container_unregister(bat_priv, BATADV_TVLV_MCAST, 1);
>  	batadv_tvlv_handler_unregister(bat_priv, BATADV_TVLV_MCAST, 1);
> =20
> +	spin_lock_bh(&bat_priv->tt.commit_lock);
>  	batadv_mcast_mla_tt_retract(bat_priv, NULL);
> +	spin_unlock_bh(&bat_priv->tt.commit_lock);

Linus,

can you please comment as of why batadv_mcast_mla_tt_retract() requires
to hold the tt.commit_lock ?


I see it calls batadv_tt_local_remove() but this does not really
requires the lock. Maybe you wanted to perform *all* the removes before
TT could do a commit ? Or is there any other reason?

Cheers,

--=20
Antonio Quartulli


--TkFpI2h3im08J9iwEtLSnfA0GHQjT46nx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJWWRZaAAoJENpFlCjNi1MRiVYP/3QHnJMzZSUyJNUFiayiaKIR
OdsS1TObNn8VbgpGmT4tG4Q+Erc3FArE02Nrlw6BizbbvJArTQqSPuavQrOuf5ml
5tpvNXhYTvOwMuitfdtpg41HEbqxWde/kGBFmGkvrJNxAgjW3NnF8pNQcs/xJmtP
61fPs2sU1rM+E1GQ8j23z12WddbFqL5nSGVc30UmW75ao2Um8eee4S0w6HeDOYkA
XImeIEG+YqrWIYqMSYaF9X/cNEfJMUoLd96/s4PgTUIJnR9JXlCJCyO6237p6F6m
eCDuz7QSHEwi/tw49O/Ckf1v00eBAZG1vfEDilu1LyO/ENPwo1o4z8VfpfC168Wn
vUp90mrJZUV4ZKaHKv4O5q3iDnyiuUUXL7K/q5/NZoTQ88bcVoS4IJsxCRgPybyB
lu/M3JwdX35Uy3O28ALZRiqkixZdcLN5tjW/Kp/d2JcWIyf+H/hD1iH9xCPon5D1
7k7tnJgzg2hnUI3npetnr4n6ZNAE0CstFeZ/ewILyTZWNQLejmVRiyGbVaMth96U
9uBdhGnqFo7Qf58/jrIKDgOiA12aTKJYmurA6RQLq9kl6k68q4Cuio9FER1YY4jp
25oaZyn72nPDdRCb5DziZBmvbWOO3zSpJRDV/PpC1qDc5kNtbCdDFZnnQ2kwrJDS
hgS+012qBJII4B0eHJga
=tI+1
-----END PGP SIGNATURE-----

--TkFpI2h3im08J9iwEtLSnfA0GHQjT46nx--
