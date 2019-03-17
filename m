Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 17 Mar 2019 11:11:10 +0100
Message-ID: <1866651.s4yD58eI2F@sven-edge>
In-Reply-To: <20190216215050.11542-1-linus.luessing@c0d3.blue>
References: <20190216215050.11542-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2032351.kQ2x4EQmmv";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v4] batman-adv: Add multicast-to-unicast
 support for multiple targets
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
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>, David Bauer <mail@david-bauer.net>

--nextPart2032351.kQ2x4EQmmv
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

> @@ -992,6 +993,7 @@ batadv_mcast_forw_mode(struct batadv_priv *bat_priv, struct sk_buff *skb,
>  	int ret, tt_count, ip_count, unsnoop_count, total_count;
>  	bool is_unsnoopable = false;
>  	struct ethhdr *ethhdr;
> +	unsigned int mcast_fanout;

Can you try to add variable to make the this block to look more like a
reversed xmas tree.

> +static int
> +batadv_mcast_forw_tt_send(struct batadv_priv *bat_priv, struct sk_buff *skb,
> +			  unsigned short vid, unsigned int *limit)
[...]
> +static int
> +batadv_mcast_forw_want_all_ipv4_send(struct batadv_priv *bat_priv,
> +				     struct sk_buff *skb, unsigned short vid,
> +				     unsigned int *limit)
[...]
> +static int
> +batadv_mcast_forw_want_all_ipv6_send(struct batadv_priv *bat_priv,
> +				     struct sk_buff *skb, unsigned short vid,
> +				     unsigned int *limit)
[...]
> +static int
> +batadv_mcast_forw_want_all_send(struct batadv_priv *bat_priv,
> +				struct sk_buff *skb, unsigned short vid,
> +				unsigned int *limit)
[...]
> +/**
> + * batadv_mcast_forw_send() - send packet to any detected multicast recpient
> + * @bat_priv: the bat priv with all the soft interface information
> + * @skb: the multicast packet to transmit
> + * @vid: the vlan identifier
> + * @limit: number of remaining, maximum transmissions
> + *
> + * Sends copies of a frame with multicast destination to any node that signaled
> + * interest in it, that is either via the translation table or the according
> + * want-all flags. A transmission is performed via a batman-adv unicast packet
> + * for each such destination node.
> + *
> + * The given skb is consumed/freed.
> + *
> + * Return: NET_XMIT_DROP if limit was reached, on memory allocation failure
> + * or if the protocol family is neither IPv4 nor IPv6. NET_XMIT_SUCCESS
> + * otherwise.
> + */
> +int batadv_mcast_forw_send(struct batadv_priv *bat_priv, struct sk_buff *skb,
> +			   unsigned short vid)
> +{
> +	/* The previous forw mode check will try to limit to the configured
> +	 * fanout. Here, we allow a little bit of flexibility in case some
> +	 * new listeners might have joined between these function calls.
> +	 */
> +	unsigned int limit = 2 * atomic_read(&bat_priv->multicast_fanout);
> +	int ret;
> +
> +	ret = batadv_mcast_forw_tt_send(bat_priv, skb, vid, &limit);
> +	if (ret != NET_XMIT_SUCCESS) {
> +		kfree_skb(skb);
> +		return ret;
> +	}
> +
> +	ret = batadv_mcast_forw_want_all_send(bat_priv, skb, vid, &limit);
> +	if (ret != NET_XMIT_SUCCESS) {
> +		kfree_skb(skb);
> +		return ret;
> +	}
> +
> +	consume_skb(skb);
> +	return ret;
>  }

I find it confusing that the send functions are supposed to consume all skbs
but you are now introducing send functions (called here - not the function
batadv_mcast_forw_send itself) which don't do this. I understand that this
make sense for the logic of these two functions but it is still confusing
to see a send functions which doesn't behave like the other ones. Maybe you
can drop the "_send" part?

I am also not sure what in mind here for the limit? The only thing
which comes to my mind right now is that we have a fanout of something
low (16) and the precondition test succeeded because it can only find 16 
entries. And in the meantime, 100 or more new entries are added. In this 
situation, you would only send to 32 neighbors, right?

[...]
> diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
> index 26c4e249..7ec0afea 100644
> --- a/net/batman-adv/translation-table.c
> +++ b/net/batman-adv/translation-table.c
> @@ -61,6 +61,7 @@
>  #include "log.h"
>  #include "netlink.h"
>  #include "originator.h"
> +#include "send.h"
>  #include "soft-interface.h"
>  #include "tvlv.h"

There is no new code which uses send.h. So I see no reason why this should be
added. Or did I miss something?

Kind regards,
	Sven
--nextPart2032351.kQ2x4EQmmv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlyOHT4ACgkQXYcKB8Em
e0Z1aA//WAa29BY3nm6XXJOQOHOTep4My8YWgDcbMRCjmaooF1KhvCTj5Lu/QQm/
gKFJrTMfYypjwKlkdOHuxw/Zp4I8w002BDDyiwhkSxP5H0/sJQu3Hmws2koKCSWu
NhhSC7w2neFvi92rcaz6MfcM0bzPRKgegvWvT9DFwsPvBogY2huW54obAvin36ol
SJMRCK/N9YmsJC90KyoYKZv3nLeVWqxuNarOVQ93/xq80WLbqcmwwfXQHDZyjSDF
HyCgXtyWQGZ8U54XVMn3B9X9S/ler0APqFsux7v6RJttELtH4rPXdX1YgpInM1nq
c8M1+LByRHEfi7ETRgM4O27aVEybiAyqPvEeRfNKVBDTzHKshfu7QbKXtMnM3SCc
gJYZTMhXHZgqKXCOnvwXPMsr8FbsvYC0acl/favs1EVivHBstWLpOJt9qPY8OdJo
xgZoSsLYuvGL65ChUJFYQNRObIjh3MbNqNCiHeBWk6NrTSTHXLEOKxxbN5yxrrYz
HDY7I7gYGhzQ0LPIw9Cl5IYp4ncCqOJL8EqVaca9zhPsxEIluxNdZXOcnU5uWMPb
i+yhzptDLjhnxEDggGjUDhX5SwS+X3IOBJYebnaYDxZEjkLV0OWPCcJ3lvOzE2DR
wECj/IJuV6lRkve55YT9+RBloxMMnCVYPzK4pj3TEiUYzfSz508=
=L4P7
-----END PGP SIGNATURE-----

--nextPart2032351.kQ2x4EQmmv--



