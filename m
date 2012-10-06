Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 06 Oct 2012 18:45:57 +0200
Message-ID: <10556116.CPovbmhTyy@sven-laptop.home.narfation.org>
In-Reply-To: <1349124808-15995-1-git-send-email-siwu@hrz.tu-chemnitz.de>
References: <1347712461-9031-1-git-send-email-ordex@autistici.org>
 <1349124808-15995-1-git-send-email-siwu@hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1445454.6uTLc6Wa5s";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: dirty hack to recompute
	mac_len in the rx path
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
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>


--nextPart1445454.6uTLc6Wa5s
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Monday 01 October 2012 22:53:28 Simon Wunderlich wrote:
> It is possible that the mac_len is not properly exported because of
> strange device configuration (this behaviour has been observed when
> using batman-adv on top of a vlan interface). Therefore it is needed to
> explicitly recompute it at the very beginning of the rx path.
> 
> This is done by appending the recompute function to the skb_share_mac()
> function, hence the "dirty hack" in the subject. We expect this problem to
> be fixed in linux 3.8 and above.
> 
> Reported-by: Antonio Quartulli <ordex@autistici.org>
> Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> ---
> 
> this is a rewrite of Antonios patch
> "batman-adv: recompute mac_len at the beginning of the rx path". It is
> intended to fix the issue for out-of-kernel releases, without hurting
> the in-kernel code too much. Obviously, this patch won't go upstream
> into the kernel.
> ---
>  compat.h |   15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/compat.h b/compat.h
> index 14969e0..dca9685 100644
> --- a/compat.h
> +++ b/compat.h
> @@ -159,4 +159,19 @@ static inline void eth_hw_addr_random(struct net_device
> *dev)
> 
>  #endif /* < KERNEL_VERSION(3, 5, 0) */
> 
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 8, 0)
> +
> +/* hack for not correctly set mac_len. This may happen for some special
> + * configurations like batman-adv on VLANs.
> + *
> + * This is pretty dirty, but we only use skb_share_check() in main.c right
> + * before mac_len is checked, and the recomputation shouldn't hurt too
> much. + */
> +#define skb_share_check(skb, b) \
> +	skb_share_check(skb, b); \
> +	if (skb) \
> +		skb_reset_mac_len(skb)
> +
> +#endif /* < KERNEL_VERSION(3, 8, 0) */
> +
>  #endif /* _NET_BATMAN_ADV_COMPAT_H_ */

Can we try a more sane solution like

#define skb_share_check(skb, b) \
	({ \
		struct sk_buff *_t_skb; \
		_t_skb = skb_share_check(skb, b); \
		if (_t_skb) \
			skb_reset_mac_len(_t_skb); \
		_t_skb; \
	})

Please test whether this thing really works and compiles. I just wrote it 
doing something else and never compiled it.

Kind regards,
	Sven
--nextPart1445454.6uTLc6Wa5s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQcGBFAAoJEF2HCgfBJntGPlEQAJHZn2Up+nXmBCXUs4mgKQtk
N49a39160RkvmesfVxwRk0K3oZuQ2TyA4GblSQf2dB4flAs5/4H3uFDGCN9jaSnU
ypFdiq2QPzcEQR0PjGAJmxQ9W3qr/XNj6OiNrsTRvMe+mdNnssocDvURelvHFYeB
LSjKTYHMNlRKrEDVvrp6/gv7cnaUB/BXvoBxFvphhW+1z7GlIw36NQvcucqGCj00
rsrjfEYs+1VRHme+Q9M2VulEECOZ3W3I2CEhq0aU5FpVpTylQvvQmN3UXO2mW4uM
ubMGlJFSPkKE1dT5VqZxKXYThEwGM42QX1b/F+Jl7mT9vaHVJBmfBmuXiDu08YfA
0OwzxBJewMoRGkP74C+1Z6gRfNU3H75U8tm0aOAaZ2gdr39+fY+RhnyzI87OZkNp
wdKv4zhUuZtD5wxBa2QK2FYpIPkJzWw2FkEBlGOwLaCOVdhSHOiUdPuupL6Ab4qb
XSihPJ2bzo1l7216OX0+rtm2wGs6/Y2PNouWUkj208t0WwDg6iRxHL62P6eyObTq
6EYTLUj8r+P/82K+N/bc3LUf1PrAHA2xUeKyeX6euwIxcFjF6wp5W1JQkFyM9y9m
v5Iqs/3r12UNNqzzsyIe9wWuthFPHWPEAamyz0nSWGPTD87w3gkN6xePa+CCcTCU
YCSkwnkMXWBm9gtG5sbS
=HJKM
-----END PGP SIGNATURE-----

--nextPart1445454.6uTLc6Wa5s--

