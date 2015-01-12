Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 12 Jan 2015 16:56:03 +0100
Message-ID: <1489373.Kb2PgzetXz@prime>
In-Reply-To: <1419594103-10928-5-git-send-email-mpa@pengutronix.de>
References: <1419594103-10928-1-git-send-email-mpa@pengutronix.de>
 <1419594103-10928-5-git-send-email-mpa@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3732753.pGgGZlDoh5";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 04/26] batman-adv: iv_ogm,
	divide and round for ring buffer avg
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
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@meshcoding.com>


--nextPart3732753.pGgGZlDoh5
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Friday 26 December 2014 12:41:21 Markus Pargmann wrote:
> Instead of the normal division which looses precision, use a division
> with rounding.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

(sorry for the duplicate, sent the reply for the first patch version, so I'm 
replying another time on v2 ...)

Why do we need to have more precise rounding here? In doubt, we should rather 
always round down to avoid any spurious routing loops - the loop free property 
depends on monotonicity after all, and therefore its better to always round 
down.

I'm not convinced that this change is safe in that regard, if you think it is 
please explain further.

> ---
>  bat_iv_ogm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
> index 1458ecfa66b8..10eada270015 100644
> --- a/bat_iv_ogm.c
> +++ b/bat_iv_ogm.c
> @@ -82,7 +82,7 @@ static uint8_t batadv_ring_buffer_avg(const uint8_t
> lq_recv[]) if (count == 0)
>  		return 0;
> 
> -	return (uint8_t)(sum / count);
> +	return (uint8_t)DIV_ROUND_CLOSEST(sum, count);
>  }
> 
>  /**

--nextPart3732753.pGgGZlDoh5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlSz7pMACgkQrzg/fFk7axYyOwCfWgUFESWI1RMdCI0d+x3DZkA4
wIgAmgJzKpTn5bWkFjDIttBzQT2zdS0F
=T2hZ
-----END PGP SIGNATURE-----

--nextPart3732753.pGgGZlDoh5--

