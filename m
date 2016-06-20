Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 20 Jun 2016 18:55:49 +0200
Message-ID: <1634830.ALRq2khRYv@sven-edge>
In-Reply-To: <20160620164115.GD10666@prodigo>
References: <1465575241-1754-1-git-send-email-sven@narfation.org>
 <1465575241-1754-2-git-send-email-sven@narfation.org>
 <20160620164115.GD10666@prodigo>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1931350.0tmfSTMWjH";
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

--nextPart1931350.0tmfSTMWjH
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 21 June 2016 00:41:15 Antonio Quartulli wrote:
[...]
> However, how about changing the patch this way ?
> 
> --- a/net/batman-adv/tp_meter.c
> +++ b/net/batman-adv/tp_meter.c
> @@ -1206,7 +1206,7 @@ static int batadv_tp_send_ack(struct batadv_priv *bat_priv, const u8 *dst,
>  
>         /* send the ack */
>         r = batadv_send_skb_to_orig(skb, orig_node, NULL);
> -       if (r == -1)
> +       if ((r == -1) || !dev_xmit_complete(res))
>                 kfree_skb(skb);

Wouldn't this cause a double free when r != -1 and !dev_xmit_complete
is true?  dev_queue_xmit would have consumed it anyway, right?

And did you mean r and not res?

Kind regards,
	Sven
--nextPart1931350.0tmfSTMWjH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXaCAVAAoJEF2HCgfBJntGTW4QAKLtQJySmv5dvH29GJkzm/Sh
lbvBjmNis+2rAAySGobaurDEVGC8s3Pc80Hd32pviCW6915cpKUoMc7opPpcYPhL
xKv/RA3VP1RN7A1K3x+0htInGlsguLAT9uXZMVrq2pwOhBH3bR4sYalxGebJ0EFo
AcVMVc3PSPhMH+fv18SsVUdeVmcU8D6FpA3SrxvtSFb67skM4NCdq/MfPhNOXW4S
FHWtmxpZ/L5rIjLaGOYh1gMgkObMbATwTId7swnotzTquccxdIOFoZmLRBrDNPIw
ENoRJA5348TQrF9w/FDpprzmenvvIucpcPEY+8p0AtaOB6FP8ANEmsXT5SlYI7Hr
mupm5EYeM/D4xOO5G0dxjDJWsKUmqlzGasZeIq0DfdlK1/cwkcdrH3GuaXasdjib
azlRdyynIyWz3KcpplZJLRCGCq3A3mcKCB8EjQL94meNKhBA4GXERK0Ox/tY0hKL
b+LuPZnCzzen0rsmfL7UZTuKBKp8bRPsMERI/aviD28P47aqqpuaY+TOet8r3JsK
Sy6awyk1p+g95Oj7JhltmhM8sOE4fD6fh8FXtqtpZl3Wxsu+S4kgw7iYbOW5XKSA
BfQVIJCI/GXfN2X0kzuWOMFLW8SB7/3GDOQm+clU+9yIeok3da/WvGiIpHHzgjVD
attZgfiG47INsztoCKQK
=TIz1
-----END PGP SIGNATURE-----

--nextPart1931350.0tmfSTMWjH--

