Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 11 Jan 2015 20:32:49 +0800
Message-ID: <8409885.k5P06c4CWh@diderot>
In-Reply-To: <1419594103-10928-5-git-send-email-mpa@pengutronix.de>
References: <1419594103-10928-1-git-send-email-mpa@pengutronix.de>
 <1419594103-10928-5-git-send-email-mpa@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6519976.ytYPFccuOp";
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Antonio Quartulli <antonio@meshcoding.com>


--nextPart6519976.ytYPFccuOp
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 26 December 2014 12:41:21 Markus Pargmann wrote:
> Instead of the normal division which looses precision, use a division
> with rounding.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
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
>                 return 0;
>  
> -       return (uint8_t)(sum / count);
> +       return (uint8_t)DIV_ROUND_CLOSEST(sum, count);
>  }

Is DIV_ROUND_CLOSEST available in 2.6.29 ? I could not find a conclusive hint 
whether or not we need compat code for the out-of-tree module ?

Cheers,
Marek

--nextPart6519976.ytYPFccuOp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJUsm11AAoJEFNVTo/uthzAj5wH/jmjAvc6Ga7i5haWXNW23QCh
GgWWxPrtyHfUkISJFtaSpi9vVZRwuA7JH0SufW2Vrig4cvkjepJt+4jfBc5tOMVN
tniW6THXOyObDEkS4YWCHkXBKM7t26yCNzWlSnXtM4typuAIBu3qKRQyzF24O+6B
YUm5nYmpK8thtEcArrO/xpaqevHFzW78+lkL0Hs+avYOZWuJxZ7/8ojleZPQK319
8PStOw8dOpti1C4KYmWWcgZP7ay2sYrWjlo6i4v/LYeq/cExjbnXWLFqa3vyiaW7
0Id9zPs+p92yoY5p0Q75LeNYewkm7L6LRBBuSgs9u3/Q8BgHU2lWhux75/fPqxc=
=1BYU
-----END PGP SIGNATURE-----

--nextPart6519976.ytYPFccuOp--

