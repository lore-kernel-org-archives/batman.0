Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80359E77188
	for <batman@archiver.kernel.org>; Sat,  4 Jan 2025 21:30:04 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id AC99D840CF
	for <batman@archiver.kernel.org>; Sat,  4 Jan 2025 22:30:02 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1736026202;
 b=cgnpyDPN5fvi927sxgj4EmR8LyYt8igyyISzmVq7vZS0TH7qYw7hSnUTU6Gsj0zy5xZ2F
 dbqdGe6S/V7iz1pbrr9Te73HM925yAA7KtXyTlOWaLO8TNESXV7teuv870ewM8m1/fX9X+0
 C+4PEKf762kbE6nnlGM1Lx1lAH0dTsY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1736026202; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=3g2q2c459RmDRPVGc6D6mH+KUBjAwUaKqj0qf5Og/eM=;
 b=ugni0h/AtHUDsBhF3tLUahTjkcabAPjRvsA0qOH8nzFALVsum7iU+wvOIXex+xk+DQcKD
 EB2m2CawCJVThym/I1mSLdU4wl4LP3R6o8fp49xyJY+SWh/TcjWQ0wAP7SHMHV1+yMljGzC
 L9DI8wZPyR01VEl0RsF36YD0haoAECg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id A500C83F00
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat,  4 Jan 2025 22:29:46 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1736026187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=3g2q2c459RmDRPVGc6D6mH+KUBjAwUaKqj0qf5Og/eM=;
	b=kqd87qJjfVyUNAWdY751R/7rc1ZJ/u7wYwuik6qTP6uI06QLcqQXzTgne55aVjUNzLVPjQ
	mq57tlwZT2zz8hWfnkbyxuVspwA/fjWUkDZ5hetoddpCQxhfmyqFKAHkcG99NgxWzkZWg9
	gs9312gbGcoADWEcttogsE2yKeM9RjE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=ny2p43qZ;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1736026187; a=rsa-sha256;
	cv=none;
	b=chIGfUrEwcveiEItxYI2MGz9BDx1uL84fT6bEJb2aUJn2UAefi7ZEDWjWpkIZh527ObP7j
	+RsFzVkJ2hNxV4i69dZkHvvKjhT96bJzTwfuHA1M3t+4ppc05+Vy44RjAOqovuAbkAKftX
	YAueSxNaHVQKXV9ND61k+2tv96pyQtU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1736026185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3g2q2c459RmDRPVGc6D6mH+KUBjAwUaKqj0qf5Og/eM=;
	b=ny2p43qZO9WgCmBA/QP5A9yvEjtFXGelacvlnDeUTu+u2KAQPoBqUlMCRLLB5sVcvIu6qt
	I4QK1+BSEClc+iiBm6HrSlyLperbkjVLcbmIVdhrE+eLEbWJBWvoJ2UBO1EdHWZjj5vspv
	ZHfLRnL80UQec4BtqkVOT0G2bV1OLec=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?UTF-8?B?TMO8c3Npbmc=?= <linus.luessing@c0d3.blue>
Subject: 
 Re: [PATCH v7 1/3] batman-adv: netlink: reduce duplicate code by returning
 interfaces
Date: Sat, 04 Jan 2025 22:29:38 +0100
Message-ID: <2132627.atdPhlSkOF@sven-l14>
In-Reply-To: <20241130005942.24497-2-linus.luessing@c0d3.blue>
References: 
 <20241130005942.24497-1-linus.luessing@c0d3.blue>
 <20241130005942.24497-2-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart47173437.fMDQidcC6G";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: BR2GNI6NEB5KIO3Z45IZ2VHY3P4UGSRF
X-Message-ID-Hash: BR2GNI6NEB5KIO3Z45IZ2VHY3P4UGSRF
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BR2GNI6NEB5KIO3Z45IZ2VHY3P4UGSRF/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart47173437.fMDQidcC6G
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?UTF-8?B?TMO8c3Npbmc=?= <linus.luessing@c0d3.blue>
Date: Sat, 04 Jan 2025 22:29:38 +0100
Message-ID: <2132627.atdPhlSkOF@sven-l14>
In-Reply-To: <20241130005942.24497-2-linus.luessing@c0d3.blue>
MIME-Version: 1.0

On Saturday, 30 November 2024 00:46:32 GMT+1 Linus L=C3=BCssing wrote:
[...]
> @@ -2233,25 +2233,16 @@ int batadv_bla_claim_dump(struct sk_buff *msg, st=
ruct netlink_callback *cb)
>  {
>  	struct batadv_hard_iface *primary_if =3D NULL;
>  	int portid =3D NETLINK_CB(cb->skb).portid;
> -	struct net *net =3D sock_net(cb->skb->sk);
>  	struct net_device *soft_iface;
>  	struct batadv_hashtable *hash;
>  	struct batadv_priv *bat_priv;
>  	int bucket =3D cb->args[0];
>  	int idx =3D cb->args[1];
> -	int ifindex;
>  	int ret =3D 0;
> =20
> -	ifindex =3D batadv_netlink_get_ifindex(cb->nlh,
> -					     BATADV_ATTR_MESH_IFINDEX);
> -	if (!ifindex)
> -		return -EINVAL;
> -
> -	soft_iface =3D dev_get_by_index(net, ifindex);
> -	if (!soft_iface || !batadv_softif_is_valid(soft_iface)) {
> -		ret =3D -ENODEV;
> -		goto out;
> -	}
> +	soft_iface =3D batadv_netlink_get_softif(cb);
> +	if (IS_ERR(soft_iface))
> +		return PTR_ERR(soft_iface);



To use these helpers, you need to "#include <linux/err.h>" in various files=
=2E=20
There are also other changes needed. Here an overview:

    diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/br=
idge_loop_avoidance.c
    index c38a1ac9..fa8a8246 100644
    --- a/net/batman-adv/bridge_loop_avoidance.c
    +++ b/net/batman-adv/bridge_loop_avoidance.c
    @@ -12,6 +12,7 @@
     #include <linux/compiler.h>
     #include <linux/container_of.h>
     #include <linux/crc16.h>
    +#include <linux/err.h>
     #include <linux/errno.h>
     #include <linux/etherdevice.h>
     #include <linux/gfp.h>
    @@ -38,7 +39,6 @@
     #include <net/arp.h>
     #include <net/genetlink.h>
     #include <net/netlink.h>
    -#include <net/sock.h>
     #include <uapi/linux/batadv_packet.h>
     #include <uapi/linux/batman_adv.h>
    =20
    @@ -47,7 +47,6 @@
     #include "log.h"
     #include "netlink.h"
     #include "originator.h"
    -#include "soft-interface.h"
     #include "translation-table.h"
    =20
     static const u8 batadv_announce_mac[4] =3D {0x43, 0x05, 0x43, 0x05};
    diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/di=
stributed-arp-table.c
    index 67bb3b17..ff660758 100644
    --- a/net/batman-adv/distributed-arp-table.c
    +++ b/net/batman-adv/distributed-arp-table.c
    @@ -11,6 +11,7 @@
     #include <linux/bitops.h>
     #include <linux/byteorder/generic.h>
     #include <linux/container_of.h>
    +#include <linux/err.h>
     #include <linux/errno.h>
     #include <linux/etherdevice.h>
     #include <linux/gfp.h>
    @@ -36,7 +37,6 @@
     #include <net/arp.h>
     #include <net/genetlink.h>
     #include <net/netlink.h>
    -#include <net/sock.h>
     #include <uapi/linux/batman_adv.h>
    =20
     #include "bridge_loop_avoidance.h"
    @@ -46,7 +46,6 @@
     #include "netlink.h"
     #include "originator.h"
     #include "send.h"
    -#include "soft-interface.h"
     #include "translation-table.h"
     #include "tvlv.h"
    =20
    diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_c=
lient.c
    index dc57b54b..8afdc711 100644
    --- a/net/batman-adv/gateway_client.c
    +++ b/net/batman-adv/gateway_client.c
    @@ -10,6 +10,7 @@
     #include <linux/atomic.h>
     #include <linux/byteorder/generic.h>
     #include <linux/container_of.h>
    +#include <linux/err.h>
     #include <linux/errno.h>
     #include <linux/etherdevice.h>
     #include <linux/gfp.h>
    @@ -31,7 +32,6 @@
     #include <linux/sprintf.h>
     #include <linux/stddef.h>
     #include <linux/udp.h>
    -#include <net/sock.h>
     #include <uapi/linux/batadv_packet.h>
     #include <uapi/linux/batman_adv.h>
    =20
    @@ -40,7 +40,6 @@
     #include "netlink.h"
     #include "originator.h"
     #include "routing.h"
    -#include "soft-interface.h"
     #include "translation-table.h"
    =20
     /* These are the offsets of the "hw type" and "hw address length" in t=
he dhcp
    diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
    index 17b302db..5b13010d 100644
    --- a/net/batman-adv/multicast.c
    +++ b/net/batman-adv/multicast.c
    @@ -12,6 +12,7 @@
     #include <linux/bug.h>
     #include <linux/byteorder/generic.h>
     #include <linux/container_of.h>
    +#include <linux/err.h>
     #include <linux/errno.h>
     #include <linux/etherdevice.h>
     #include <linux/gfp.h>
    @@ -46,7 +47,6 @@
     #include <net/ip.h>
     #include <net/ipv6.h>
     #include <net/netlink.h>
    -#include <net/sock.h>
     #include <uapi/linux/batadv_packet.h>
     #include <uapi/linux/batman_adv.h>
    =20
    @@ -56,7 +56,6 @@
     #include "log.h"
     #include "netlink.h"
     #include "send.h"
    -#include "soft-interface.h"
     #include "translation-table.h"
     #include "tvlv.h"
    =20
    diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
    index 145eb110..972003d3 100644
    --- a/net/batman-adv/originator.c
    +++ b/net/batman-adv/originator.c
    @@ -9,6 +9,7 @@
    =20
     #include <linux/atomic.h>
     #include <linux/container_of.h>
    +#include <linux/err.h>
     #include <linux/errno.h>
     #include <linux/etherdevice.h>
     #include <linux/gfp.h>
    @@ -26,9 +27,7 @@
     #include <linux/spinlock.h>
     #include <linux/stddef.h>
     #include <linux/workqueue.h>
    -#include <net/sock.h>
     #include <uapi/linux/batadv_packet.h>
    -#include <uapi/linux/batman_adv.h>
    =20
     #include "bat_algo.h"
     #include "distributed-arp-table.h"
    @@ -41,7 +40,6 @@
     #include "netlink.h"
     #include "network-coding.h"
     #include "routing.h"
    -#include "soft-interface.h"
     #include "translation-table.h"
    =20
     /* hash class keys */
    diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/transl=
ation-table.c
    index d464569e..a7680858 100644
    --- a/net/batman-adv/translation-table.c
    +++ b/net/batman-adv/translation-table.c
    @@ -15,6 +15,7 @@
     #include <linux/compiler.h>
     #include <linux/container_of.h>
     #include <linux/crc32c.h>
    +#include <linux/err.h>
     #include <linux/errno.h>
     #include <linux/etherdevice.h>
     #include <linux/gfp.h>
    @@ -39,7 +40,6 @@
     #include <linux/workqueue.h>
     #include <net/genetlink.h>
     #include <net/netlink.h>
    -#include <net/sock.h>
     #include <uapi/linux/batadv_packet.h>
     #include <uapi/linux/batman_adv.h>


[...]
> @@ -1150,23 +1137,17 @@ static int batadv_netlink_set_vlan(struct sk_buff=
 *skb, struct genl_info *info)
>  }
> =20
>  /**
> - * batadv_get_softif_from_info() - Retrieve soft interface from genl att=
ributes
> + * batadv_netlink_get_softif_from_info() - Retrieve soft interface from =
ifindex
>   * @net: the applicable net namespace
> - * @info: receiver information
> + * @ifindex: index of the soft interface
>   *
>   * Return: Pointer to soft interface (with increased refcnt) on success,=
 error
>   *  pointer on error
>   */
>  static struct net_device *
> -batadv_get_softif_from_info(struct net *net, struct genl_info *info)
> +batadv_netlink_get_softif_from_ifindex(struct net *net, int ifindex)

I think you wanted to document batadv_netlink_get_softif_from_ifindex here =
and=20
not batadv_netlink_get_softif_from_info

[...]
> @@ -1184,28 +1165,61 @@ batadv_get_softif_from_info(struct net *net, stru=
ct genl_info *info)
>  }
> =20
>  /**
> - * batadv_get_hardif_from_info() - Retrieve hardif from genl attributes
> - * @bat_priv: the bat priv with all the soft interface information
> + * batadv_get_softif_from_info() - Retrieve soft interface from genl att=
ributes
>   * @net: the applicable net namespace
>   * @info: receiver information
>   *
> + * Return: Pointer to soft interface (with increased refcnt) on success,=
 error
> + *  pointer on error
> + */
> +static struct net_device *
> +batadv_netlink_get_softif_from_info(struct net *net, struct genl_info *i=
nfo)

I think you wanted to document batadv_netlink_get_softif_from_info here and=
=20
not batadv_get_softif_from_info

[...]
> +/**
> + * batadv_netlink_get_hardif_from_info() - Retrieve hard interface from =
ifindex
> + * @bat_priv: the bat priv with all the soft interface information
> + * @net: the applicable net namespace
> + * @ifindex: index of the hard interface
> + *
>   * Return: Pointer to hard interface (with increased refcnt) on success,=
 error
>   *  pointer on error
>   */
>  static struct batadv_hard_iface *
> -batadv_get_hardif_from_info(struct batadv_priv *bat_priv, struct net *ne=
t,
> -			    struct genl_info *info)
> +batadv_netlink_get_hardif_from_ifindex(struct batadv_priv *bat_priv,
> +				       struct net *net, int ifindex)
>  {

I think you wanted to document batadv_netlink_get_hardif_from_ifindex here =
and=20
not batadv_netlink_get_hardif_from_info

[...]
> @@ -1229,6 +1243,51 @@ batadv_get_hardif_from_info(struct batadv_priv *ba=
t_priv, struct net *net,
>  	return ERR_PTR(-EINVAL);
>  }
> =20
> +/**
> + * batadv_get_hardif_from_info() - Retrieve hardif from genl attributes
> + * @bat_priv: the bat priv with all the soft interface information
> + * @net: the applicable net namespace
> + * @info: receiver information
> + *
> + * Return: Pointer to hard interface (with increased refcnt) on success,=
 error
> + *  pointer on error
> + */
> +static struct batadv_hard_iface *
> +batadv_netlink_get_hardif_from_info(struct batadv_priv *bat_priv,
> +				    struct net *net, struct genl_info *info)

I think you wanted to document batadv_netlink_get_hardif_from_info here and=
=20
not batadv_get_hardif_from_info

[...]
> diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
> index 8f6dd2c6ee41..9ee9655d9bea 100644
> --- a/net/batman-adv/originator.c
> +++ b/net/batman-adv/originator.c
> @@ -755,24 +755,15 @@ batadv_neigh_node_get_or_create(struct batadv_orig_=
node *orig_node,
>   */
>  int batadv_hardif_neigh_dump(struct sk_buff *msg, struct netlink_callbac=
k *cb)
>  {
> -	struct net *net =3D sock_net(cb->skb->sk);
>  	struct net_device *soft_iface;
> -	struct net_device *hard_iface =3D NULL;
> -	struct batadv_hard_iface *hardif =3D BATADV_IF_DEFAULT;
> +	struct batadv_hard_iface *hard_iface;

hard_iface is no longer initialized but you will use it after a goto (see=20
below).

>  	struct batadv_priv *bat_priv;
>  	struct batadv_hard_iface *primary_if =3D NULL;
>  	int ret;
> -	int ifindex, hard_ifindex;
> =20
> -	ifindex =3D batadv_netlink_get_ifindex(cb->nlh, BATADV_ATTR_MESH_IFINDE=
X);
> -	if (!ifindex)
> -		return -EINVAL;
> -
> -	soft_iface =3D dev_get_by_index(net, ifindex);
> -	if (!soft_iface || !batadv_softif_is_valid(soft_iface)) {
> -		ret =3D -ENODEV;
> -		goto out;
> -	}
> +	soft_iface =3D batadv_netlink_get_softif(cb);
> +	if (IS_ERR(soft_iface))
> +		return PTR_ERR(soft_iface);
> =20
>  	bat_priv =3D netdev_priv(soft_iface);
> =20
> @@ -782,22 +773,14 @@ int batadv_hardif_neigh_dump(struct sk_buff *msg, s=
truct netlink_callback *cb)
>  		goto out;
>  	}

The goto here seems to be rather problematic... see below for more details

> =20
> -	hard_ifindex =3D batadv_netlink_get_ifindex(cb->nlh,
> -						  BATADV_ATTR_HARD_IFINDEX);
> -	if (hard_ifindex) {
> -		hard_iface =3D dev_get_by_index(net, hard_ifindex);
> -		if (hard_iface)
> -			hardif =3D batadv_hardif_get_by_netdev(hard_iface);
> -
> -		if (!hardif) {
> -			ret =3D -ENODEV;
> +	hard_iface =3D batadv_netlink_get_hardif(bat_priv, cb);
> +	if (IS_ERR(hard_iface)) {
> +		if (PTR_ERR(hard_iface) !=3D -ENONET) {
> +			ret =3D PTR_ERR(hard_iface);
>  			goto out;
>  		}
> =20
> -		if (hardif->soft_iface !=3D soft_iface) {
> -			ret =3D -ENOENT;
> -			goto out;
> -		}
> +		hard_iface =3D BATADV_IF_DEFAULT;
>  	}
> =20
>  	if (!bat_priv->algo_ops->neigh.dump) {
> @@ -805,13 +788,12 @@ int batadv_hardif_neigh_dump(struct sk_buff *msg, s=
truct netlink_callback *cb)
>  		goto out;
>  	}
> =20
> -	bat_priv->algo_ops->neigh.dump(msg, cb, bat_priv, hardif);
> +	bat_priv->algo_ops->neigh.dump(msg, cb, bat_priv, hard_iface);
> =20
>  	ret =3D msg->len;
> =20
>   out:
> -	batadv_hardif_put(hardif);
> -	dev_put(hard_iface);
> +	batadv_hardif_put(hard_iface);
>  	batadv_hardif_put(primary_if);
>  	dev_put(soft_iface);


You will now give batadv_hardif_put an unitialized value for hard_iface whe=
n=20
following goto is used:


[...]
	primary_if =3D batadv_primary_if_get_selected(bat_priv);
	if (!primary_if || primary_if->if_status !=3D BATADV_IF_ACTIVE) {
		ret =3D -ENOENT;
		goto out;
	}

	hard_iface =3D batadv_netlink_get_hardif(bat_priv, cb);
[...]

This is also the reason why a non-descriptive, single return goto labels=20
should be avoided [1].

Kind regards,
	Sven

[1] https://www.kernel.org/doc/html/v6.12/process/coding-style.html#central=
ized-exiting-of-functions
--nextPart47173437.fMDQidcC6G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZ3moQwAKCRBND3cr0xT1
y/a+AP9a1k7mEVpj8nFbzffTxk/+995+dxY4Oow2EN1Q8+nRAAEApt+SdVUjUWuQ
XDRmxpI0xz1CSiN4mBRJ6/ApxXN95g8=
=6LpA
-----END PGP SIGNATURE-----

--nextPart47173437.fMDQidcC6G--



