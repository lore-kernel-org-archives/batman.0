Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 31 Jan 2016 14:26:33 +0100
Message-ID: <6163814.nEZyCaGlCL@sven-edge>
In-Reply-To: <1453312110-32683-3-git-send-email-andrew@lunn.ch>
References: <1453312110-32683-1-git-send-email-andrew@lunn.ch>
 <1453312110-32683-3-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart13222177.Z55rdNFcCj";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/4] batman-adv: Create batman soft
	interfaces within correct netns.
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
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart13222177.Z55rdNFcCj
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 20 January 2016 18:48:28 Andrew Lunn wrote:
> When creating a soft interface, create it in the same netns as the
> hard interface. Replace all references to init_net with the correct
> name space for the interface being manipulated.
> 
> Suggested-by: Daniel Ehlers <danielehlers@mindeye.net>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  net/batman-adv/hard-interface.c    | 9 +++++----
>  net/batman-adv/hard-interface.h    | 2 +-
>  net/batman-adv/soft-interface.c    | 7 +++++--
>  net/batman-adv/soft-interface.h    | 2 +-
>  net/batman-adv/sysfs.c             | 3 ++-
>  net/batman-adv/translation-table.c | 3 ++-
>  6 files changed, 16 insertions(+), 10 deletions(-)


This patch doesn't apply (via git-am/git-apply; and only unclean with GNU 
patch). Can you please rebase it.

[...]
> diff --git a/net/batman-adv/hard-interface.h
> b/net/batman-adv/hard-interface.h index 5a31420..4ed737f 100644
> --- a/net/batman-adv/hard-interface.h
> +++ b/net/batman-adv/hard-interface.h

New forward declaration missing:

struct net;

> @@ -55,7 +55,7 @@ bool batadv_is_wifi_iface(int ifindex);
>  struct batadv_hard_iface*
>  batadv_hardif_get_by_netdev(const struct net_device *net_dev);
>  int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
> -				   const char *iface_name);
> +				   struct net *net, const char *iface_name);
>  void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface,
>  				     enum batadv_hard_if_cleanup autodel);
>  void batadv_hardif_remove_interfaces(void);
[...]
> diff --git a/net/batman-adv/soft-interface.h
> b/net/batman-adv/soft-interface.h index 8e82176..d616cd5 100644
> --- a/net/batman-adv/soft-interface.h
> +++ b/net/batman-adv/soft-interface.h

New forward declaration missing:

struct net;

> @@ -29,7 +29,7 @@ int batadv_skb_head_push(struct sk_buff *skb, unsigned int
> len); void batadv_interface_rx(struct net_device *soft_iface,
>  			 struct sk_buff *skb, struct batadv_hard_iface *recv_if,
>  			 int hdr_size, struct batadv_orig_node *orig_node);
> -struct net_device *batadv_softif_create(const char *name);
> +struct net_device *batadv_softif_create(struct net *net, const char *name);
> void batadv_softif_destroy_sysfs(struct net_device *soft_iface);
>  int batadv_softif_is_valid(const struct net_device *net_dev);
>  extern struct rtnl_link_ops batadv_link_ops;
[...]
> diff --git a/net/batman-adv/translation-table.c
> b/net/batman-adv/translation-table.c index 76f19ba..0dbda83 100644
> --- a/net/batman-adv/translation-table.c
> +++ b/net/batman-adv/translation-table.c

init_net is not used anymore and thus following include should be removed:

#include <net/net_namespace.h>

Kind regards,
	Sven

--nextPart13222177.Z55rdNFcCj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWrguJAAoJEF2HCgfBJntGiIMQALBFdWA1eVxBaotYq1jz4uSd
WQldn6mU4hOFYLNBoX8cP65L/BBbw8HJsrnkgmFBe0GpVCm+620x/lVnaE8UvRFP
4d9AiYYxuMivhnRVI8spqYdO0detsNQBIZshZehVegf/R7cmXUGbOabeREe+l/g4
KxhGMEWVzSnvIBqegsr/HQqLus0nQCVZR3bsvhmx3RuxHs5Bc4wyxwQz1tCGVBpm
Px2llbiO9m+AVaBDO1EU0bY8HrhTd2NJP7+5f21xEPO4NnMWTIcDS96JG+ehTC/i
bsAE+yQNYvgPJip0xElGrq9cf6v0WyNT8B+vjPuySlFrTgxz8mSaPaIpDQqqIVWg
uWepSsJhzhMoTUt/i3A19j77R9UePgSRjcf3x+ZA60dRetRx7LLf9xdvTyE9ZlHp
ZYvD9WEKGAC/Y1tKUzwGLshz0wdGFF8a5XNmcwM8Px4nKcmcZs3b8xtHOEgcJJ+X
XC5vKMmIuRQuRxbANfk5zeX3Q4EPNeq/yIfViaHfN7qfR/xnRZGL16UU9B9LWDXC
+dGMv3kaJbV7k3Lu+FTX9I8bdvfAOTd2aqUOt9/Nw27vN74zh++3JTXjP15SajuX
771EpxALybjjjBbAPn6h50orgGM/zzt7V6OlA0bIVIQnrXTbM0BZtGwCceTsgkj5
fIk75m74sL8nJ51uF4K7
=taAC
-----END PGP SIGNATURE-----

--nextPart13222177.Z55rdNFcCj--

