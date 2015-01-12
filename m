Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 12 Jan 2015 16:52:22 +0100
Message-ID: <4348694.8SUG3NZNcb@prime>
In-Reply-To: <1417519009-20699-5-git-send-email-mpa@pengutronix.de>
References: <1417519009-20699-1-git-send-email-mpa@pengutronix.de>
 <1417519009-20699-5-git-send-email-mpa@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2033001.4Qumbg2dr4";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 04/31] batman-adv: iv_ogm,
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
Cc: b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@meshcoding.com>


--nextPart2033001.4Qumbg2dr4
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Tuesday 02 December 2014 12:16:22 Markus Pargmann wrote:
> Instead of the normal division which looses precision, use a division
> with rounding.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

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

--nextPart2033001.4Qumbg2dr4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlSz7b8ACgkQrzg/fFk7axY6ZACgyVzwmkIa/2a01eTsLItLwyhs
KMQAoMXJnOXJVXsJktQvZeCOi7/wgKSx
=qksw
-----END PGP SIGNATURE-----

--nextPart2033001.4Qumbg2dr4--

