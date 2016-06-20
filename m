Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 20 Jun 2016 19:28:43 +0200
Message-ID: <6189348.B3VoAv95Jr@sven-edge>
In-Reply-To: <20160620164115.GD10666@prodigo>
References: <1465575241-1754-1-git-send-email-sven@narfation.org>
 <1465575241-1754-2-git-send-email-sven@narfation.org>
 <20160620164115.GD10666@prodigo>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4041611.hHIhlU7J2M";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
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
To: Antonio Quartulli <a@unstable.cc>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart4041611.hHIhlU7J2M
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 21 June 2016 00:41:15 Antonio Quartulli wrote:
[...]
> --- a/net/batman-adv/tp_meter.c
> +++ b/net/batman-adv/tp_meter.c
> @@ -1206,7 +1206,7 @@ static int batadv_tp_send_ack(struct batadv_priv 
*bat_priv, const u8 *dst,
>  
>         /* send the ack */
>         r = batadv_send_skb_to_orig(skb, orig_node, NULL);
> -       if (r == -1)
> +       if ((r == -1) || !dev_xmit_complete(res))
>                 kfree_skb(skb);
>  
>         if (unlikely(r < 0) || (r == NET_XMIT_DROP)) {
> 
> this is the same check we do in batadv_send_skb_unicast().

Why are we doing the check in batadv_send_skb_unicast,
batadv_recv_my_icmp_packet, batadv_recv_icmp_ttl_exceeded,
batadv_recv_icmp_packet, batadv_route_unicast_packet and
batadv_tvlv_unicast_send? The doc for this functions says that it is only for
(dev_)hard_start_xmit [1]. So it is for scheduler functions and things which
directly want to send to the hw via netdev_start_xmit.

Or did I miss something?

Kind regards,
	Sven

[1] http://lxr.free-electrons.com/source/include/linux/netdevice.h#L117
--nextPart4041611.hHIhlU7J2M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXaCfLAAoJEF2HCgfBJntGlFoQALQ4xhlUjYndiDbVyKGbJ0Nd
9Lb2fm0lXz/k4FOfqnsPsjz9KS0Hfh9M0QnUgmZpCA4bYDD0JQ03mo3nZb1ZQEV+
cnv3x7kD66jfS9KbjZ76a5n0uiEpGL2vdMxqtb5iXYg6syh4byd6qYd/73yn1oQ2
eVLLlS0h8VjgU7yqx+k/TTP0lERnmN2KaYw/eunJ2K9h5UGRiOWQHLRnvxxxfMi7
0tKTsm7PbOQs6KDmI0WYV6jNVxpYglByEyLwpzu054RybwhQ2hpigH4jfSrbsMBW
xflJ8KBTcAEBe/8RdTCZUlaOHoiTgD649PDTSIlCMr0gw/XNTY+bNZqkh6D6xMQ8
KTaRA6SSya01uri1BYhUIXQayAJNEjVJ/yW+E1CY8DwGTxZ8zZGRR4fFwlunyP+U
rE3YCNgRYJn+I/VahXOEZpHhfcX6FEDKB6LCGU+Niuw6Ki4oIF2Z/mIvrDSKX4rj
ijPKUvLf4fqHlmB9Gj9pmMIYTftWnlSWMcFoVNDaU+Os074YPiSS2f0+b8YzMChL
o53Nu4haPxF7rz07VgDpeOLf+APqm1fkRHXrwCPDv1cEZLm41CAhKvEO6mAzereG
gv61k2I6XTnaq1fhEyf6Y2EJNcRFJqVQ3DLTsDQ//cDt6jYH/px8ouo178L71InH
iLEWnlqlSkPpV4ktgP7B
=ZIGW
-----END PGP SIGNATURE-----

--nextPart4041611.hHIhlU7J2M--

