Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 11 May 2016 08:21:27 +0200
Message-ID: <5949161.ptvGUENbB7@bentobox>
In-Reply-To: <1462817016-17867-2-git-send-email-andrew@lunn.ch>
References: <1462817016-17867-1-git-send-email-andrew@lunn.ch>
 <1462817016-17867-2-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart34024259.xtYHHCdGBU";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Set skb priority in
	fragments
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

--nextPart34024259.xtYHHCdGBU
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 09 May 2016 20:03:35 Andrew Lunn wrote:
> BATMAN will set the skb->priority based on the IP precedence or 802.1q
> tag. However, if it needs to fragment the frame, it currently leaves
> the fragment skb with the default priority and actually overwrites the
> priority in the unfragmented frame. Fix this.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  net/batman-adv/fragmentation.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
> index 65536db..a3fefbd 100644
> --- a/net/batman-adv/fragmentation.c
> +++ b/net/batman-adv/fragmentation.c
> @@ -414,7 +414,7 @@ static struct sk_buff *batadv_frag_create(struct sk_buff *skb,
>  	if (!skb_fragment)
>  		goto err;
>  
> -	skb->priority = TC_PRIO_CONTROL;
> +	skb_fragment->priority = skb->priority;
>  
>  	/* Eat the last mtu-bytes of the skb */
>  	skb_reserve(skb_fragment, header_size + ETH_HLEN);
> 

Please remove linux/pkt_sched.h in fragmentation.c because it is only
used for TC_PRIO_CONTROL in master.

Kind regards,
	Sven
--nextPart34024259.xtYHHCdGBU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXMs9nAAoJEF2HCgfBJntGVMsP/jp9rBB7RnD9gzDEt0C0MMeH
1+cFcnVJGR2FLejI8s7xMZ1ssuv+rLHmrYzxiEi41j0/aN8AeOGGxAqpi2kCIBYX
+vL/y8oedjMR8z133s9xbbJUvqrFEw+66pG+hLimBaV62R4fpfSS/woI2vzL0O5d
AsYCQMBWbi7KEMfVoh7eAmuSB5oOALX9UrYAIA1czHg61ewH/SpixCOSQRXDSBp5
FgdBZDljoE/BSSLwzT6Y6qqe9UA8l4CblOECvM7KV9WncuFcq2g2/ZRv2epkbIHh
ULIAqzi6CjgdRAImPh7+LJPBHAK9bA1tM0xlnEsBeJG5cvXSDbRWXCOneAR55uxu
Tw8gIAzoKPBV9uqc+JqcOSKrDi06UTyqbzyLFnDsErKncC0UAzblTqdVM5G/Q0Lc
5wRA2Xvx0fvhdnYLDpUPr2MDwaRWcyeCELNzz1MmfSB/PoHfPPulATg3rrNhC2mr
gZ0rH1XdUCDzB+I9Adu5cS51R9KcDK0KMSxcUb3/EH4HKgblmr/5gs890ZGyEcp4
LgATdIvOkAv6ymYT1nMccxS0XPaTIF2y+VyQFs2xbZqNvJF/jMF9zTnqJt22jx+y
ORKZ+Mx4wljUertj7Hgb9jnX+4eG1HK3BYCJsASQtMTqddo/eGyqAkhWYoHKRaBs
Byt+8bQpwN5jFudCWweC
=vAUe
-----END PGP SIGNATURE-----

--nextPart34024259.xtYHHCdGBU--

