Return-Path: <a@unstable.cc>
Date: Tue, 21 Jun 2016 00:41:15 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160620164115.GD10666@prodigo>
References: <1465575241-1754-1-git-send-email-sven@narfation.org>
 <1465575241-1754-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XCAWwTQADTZzNDLi"
Content-Disposition: inline
In-Reply-To: <1465575241-1754-2-git-send-email-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH next] batman-adv: Free tp_meter ack skb
 when it was not consumed
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


--XCAWwTQADTZzNDLi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 10, 2016 at 06:14:01PM +0200, Sven Eckelmann wrote:
> batadv_send_skb_to_orig can return -1 to signal that the skb was not
> consumed. tp_meter has then to free the skb to avoid a memory leak.
>=20
> Fixes: 98d7a766b645 ("batman-adv: throughput meter implementation")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> Antonio, this is not really tested. Could you please review it and tell me
> if I may have missed something.
>=20
>  net/batman-adv/tp_meter.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
> index bf6bffb..2333777 100644
> --- a/net/batman-adv/tp_meter.c
> +++ b/net/batman-adv/tp_meter.c
> @@ -1206,6 +1206,9 @@ static int batadv_tp_send_ack(struct batadv_priv *b=
at_priv, const u8 *dst,
> =20
>  	/* send the ack */
>  	r =3D batadv_send_skb_to_orig(skb, orig_node, NULL);
> +	if (r =3D=3D -1)
> +		kfree_skb(skb);
> +

Good catch, Sven !

However, how about changing the patch this way ?

--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -1206,7 +1206,7 @@ static int batadv_tp_send_ack(struct batadv_priv *bat=
_priv, const u8 *dst,
=20
        /* send the ack */
        r =3D batadv_send_skb_to_orig(skb, orig_node, NULL);
-       if (r =3D=3D -1)
+       if ((r =3D=3D -1) || !dev_xmit_complete(res))
                kfree_skb(skb);
=20
        if (unlikely(r < 0) || (r =3D=3D NET_XMIT_DROP)) {

this is the same check we do in batadv_send_skb_unicast().

Cheers,

--=20
Antonio Quartulli

--XCAWwTQADTZzNDLi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXaByrAAoJEJ4aZjxxc6bKx8sP/iVFl9KOEb/6+4PVPUvWAgsJ
0tI9sCusGOG2gDTnPonwkDiDhyHDTtV9e0p4FB9CpkkusLjyXk0yidXFWRmoyjqO
nj20z6yqR/92rH1zWUdh6p0SncSkpLuWR6uQ6Q/uFGy4DIFPkET0P3cNZvaId+Ey
QXHyZhEB91D6+rVpgb++A5v1VbyeD7dXDGSnQMqYwSmfzkvkw5fiRfYsLD70oAJ8
ewbfEc67BKUVXkVEdv3PE9UJS+rICMKoLgK+zB51iiEQtt18QaWAzS+UkqL8qfbA
rlWYgcw4AAvxXAALXJB8nf+xfjYRtko3gp/lptAesvLJJuyE3mcry9HPFX+10ZQ8
CbTJHbs+3dH1UvFJ9EefCDiekeS7F/Z3Yy0Ny/oPmmTsdjZ+s2rA06SUEt6SqW4o
FjRb6RyOiV6NV+259P83s9X9HuFA6FwEOpNcY3TLbSkDcmGnRsf0vwvCbfNxWqqT
0R0+ZBsCpP4VTROrZvwTl2XGt3KUB7Tv0P+mHIwjMP5+t8XdRXLSUh/k+I3RqXf/
+N9x7CtC5+bF2JVoMjX1hhJnuSB0nS1MVylhflwRaeZTSeneSJo506vnF8j0YGGw
lY2KklC53Z516pVwH3qmTzuG0fkpH7fgp7yp/O6TRI+eJ4tlBhOvcJnJWV9Kw9Kg
90Y9bhlcZg1StkZxybBt
=qFcG
-----END PGP SIGNATURE-----

--XCAWwTQADTZzNDLi--
