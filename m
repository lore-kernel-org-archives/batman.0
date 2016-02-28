Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 28 Feb 2016 08:49:02 +0800
Message-ID: <10633463.PgZ4eD0ZeI@voltaire>
In-Reply-To: <1456505773-1059-1-git-send-email-sven@narfation.org>
References: <b.a.t.m.a.n@lists.open-mesh.org>
 <1456505773-1059-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart42842977.yXQMj7TgWy";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Check skb size before using
	encapsulated ETH+VLAN header
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

--nextPart42842977.yXQMj7TgWy
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, February 26, 2016 17:56:13 Sven Eckelmann wrote:
> --- a/net/batman-adv/soft-interface.c
> +++ b/net/batman-adv/soft-interface.c
> @@ -408,11 +408,17 @@ void batadv_interface_rx(struct net_device
> *soft_iface, */
>  	nf_reset(skb);
> 
> +	if (unlikely(!pskb_may_pull(skb, ETH_HLEN)))
> +		goto dropped;
> +
>  	vid = batadv_get_vid(skb, 0);

batadv_get_vid() also calls pskb_may_pull() and checks for VLAN_ETH_HLEN 
length. Isn't that sufficient ?

On a related note - a few lines before your check you'll find:

/* check if enough space is available for pulling, and pull */
if (!pskb_may_pull(skb, hdr_size))

In its current form that check is useless because batadv_recv_unicast_packet() 
already calls batadv_check_unicast_packet() which does the same 
pskb_may_pull(skb, hdr_size). Am I overlooking something ?


>  	switch (ntohs(ethhdr->h_proto)) {
>  	case ETH_P_8021Q:
> +		if (!pskb_may_pull(skb, VLAN_ETH_HLEN))
> +			goto dropped;

Shouldn't this memory access be covered by the earlier check inside 
batadv_get_vid() ?


>  	/* skb->dev & skb->pkt_type are set here */
> -	if (unlikely(!pskb_may_pull(skb, ETH_HLEN)))
> -		goto dropped;

Agreed that this seems unnecessary.

Cheers,
Marek

--nextPart42842977.yXQMj7TgWy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJW0kP+AAoJEFNVTo/uthzA5HQH/R05fk///SaHKQYgTOAnXo7X
T7iYxEKKLYwmnAfuORwjgmGDME+dd+zDEWPyeWA47P/Zj8PYCbdmVitICTs36x9Q
a2yMZOYhPtGvpIGMC9ASvocABHsrbwHg/aaDgxhnBakMPehXY8ekuxLwCDpb9U8x
EL1658fXBA4GuMYxNhc5MM51oQJwkRQgP8GDq5ZNuy2II1OwuphQWvHbBPCwvS3x
Gx7QrNJEr+aw2O3+lEs6tEyAOUdrmzY+8o9X49Z6PwrDV7bFA41tlZy2mskFj+uQ
kbIhEQnyXXWa9n87hKYHlhzbTQmpkkzyliYsuAEODbM7UZHEML6Zr3NfI2XuKl8=
=QsDx
-----END PGP SIGNATURE-----

--nextPart42842977.yXQMj7TgWy--

