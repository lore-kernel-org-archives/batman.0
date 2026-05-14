Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9B9CD4F25
	for <batman@archiver.kernel.org>; Thu, 14 May 2026 09:44:21 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 903BA85BE4
	for <batman@archiver.kernel.org>; Thu, 14 May 2026 11:44:19 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778751859;
 b=26DyeH+bwG0lwGRkirEMZTEVW5DC2oPxmgqgxbCQCBqQvs6FVyO/2j9TTGs0xhOxEeL0U
 Omb4YL208kRn0n8+O0rNHulvRQxXDwDs3VNwzGfH0RNnkQwghaaMc6jb26+nNw+juEcKmvF
 qf/FdpVcU6bpGhcwIME/wsIZhetE7Xk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778751859; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=lhgII0aEXrHQCMb8rVGCV/ADRDhBE0u1uUdOTq73t3o=;
 b=O4sMnW0VjGQEkddHIOvc7deF4QNswpqNbz8XMHlMT8mnHXh2y+JB138XqFWDFf6XA5QxR
 qj2b264paha6WDQ5szLBk0TE8uT/y4sEC4g2dNzz4N8oO1gNoMNv9fL9DXZ9SFKd7ZcHsmI
 2QBDoj7cpcI75N7wDMKaoTUk+YiU+lw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 9A03C83DC9
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 14 May 2026 11:43:45 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778751835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=lhgII0aEXrHQCMb8rVGCV/ADRDhBE0u1uUdOTq73t3o=;
	b=cIEW3jJkcB8uiffC0fuuZs89Rhw8uYkbh1y4/fyyIT8Uj1q2gsUMNb8WBjmQ/2sKi+B3GL
	2m8N3tDkAdi5OL4wWrvRHK8JRnOYQjfxNUWevMPa6lU57hzvq+Vo3iVDXnSjMxEJLpyq+7
	9SxCv7SKbR/zLcBDklixCSFyzT3oBQk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=q5wVcgBZ;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778751835;
	b=icfIO7Zcz6TiO5zkWENzAaFH4DKB96yieHwghj62zhvbOlknJtTTsUUS76Nwj9UEq1+4Yn
	iPxn2JtlOaO2YRh2/CEh159s3htnWrtUnVgO4pxk2yhg1U9mreJ2YqzHKmRE1Wgkjj9tgZ
	cfHXCyXIt3D74LDvjA9BetCh90yMQKo=
Received: by dvalin.narfation.org (Postfix) id 6D866200D8;
	Thu, 14 May 2026 09:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778751823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lhgII0aEXrHQCMb8rVGCV/ADRDhBE0u1uUdOTq73t3o=;
	b=q5wVcgBZJMnBCBCX3jnnUO+IcOXB2kfxrfJhg6D0l/k68KHLloR0snQtHyBqxtmqJkWgQD
	7QgGNSAEurFTrxsPmqh+i1eOThrTBJavxciJdz4y+k0qblXaELg4i/uOTFtfA2mYUiRA1a
	65CGOXylbFdj+TE6zOG4dPZBAQrjFWg=
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 2/3] batman-adv: limit number of learned VLANs from
 bridged-in clients
From: Sven Eckelmann <sven@narfation.org>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org,
 =?utf-8?q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>
In-Reply-To: <20250221-dynamic-vlans-v6-2-fd94c9b782a7@narfation.org>
References: <20250221-dynamic-vlans-v6-0-fd94c9b782a7@narfation.org>
 <20250221-dynamic-vlans-v6-2-fd94c9b782a7@narfation.org>
Date: Thu, 14 May 2026 11:43:27 +0200
Message-Id: <177875180717.12060.11060832190640770018.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3601; i=sven@narfation.org;
 h=from:subject:message-id; bh=eNDL0F9admzlIlVnSiKa2gYKeiCUL9XTB5hUfZCMwag=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmsM121pH5G9r1NfHR/+gXJHPUjHGk6LokXrU/NupZyy
 9HcUvF7RykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAi75kYGWbGiWwqsHrZeuXB
 lNU7ZQrO/XcP2LHxyzrN3Jxfs6K1jx9jZFgtYV9xNF3R9Gjkr4K3gfkXdA3+rp+z/Mv9qYs/bVn
 EEMcOAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: FOS7VMT25GWNYHGI2VYU3POB4AT6AKJI
X-Message-ID-Hash: FOS7VMT25GWNYHGI2VYU3POB4AT6AKJI
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FOS7VMT25GWNYHGI2VYU3POB4AT6AKJI/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Fri, 21 Feb 2025 18:27:32 +0100, Sven Eckelmann <sven@narfation.org> wrote:
> diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
> index 3ca84176..5cf3a62c 100644
> --- a/net/batman-adv/mesh-interface.c
> +++ b/net/batman-adv/mesh-interface.c
> @@ -573,6 +577,19 @@ batadv_meshif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
>  		return vlan;
>  	}
>  
> +	vlan_dyn_max = bat_priv->meshif_vlan_dyn_max;

See my remark regarding the possible need for READ_ONCE.

> +	vlan_dyn_count = bat_priv->meshif_vlan_dyn_count;
> +
> +	if (vid & BATADV_VLAN_HAS_TAG && !own &&
> +	    vlan_dyn_max <= vlan_dyn_count) {
> +		spin_unlock_bh(&bat_priv->meshif_vlan_list_lock);
> +
> +		net_ratelimited_function(batadv_info, bat_priv->mesh_iface,
> +					 "not adding VLAN %d, already learned %hu VID(s)\n",
> +					 batadv_print_vid(vid), vlan_dyn_max);
> +		return NULL;
> +	}
> +
>  	vlan = kzalloc(sizeof(*vlan), GFP_ATOMIC);
>  	if (!vlan) {
>  		spin_unlock_bh(&bat_priv->meshif_vlan_list_lock);

The patch still applies at 41a3e32c2a80 ("batman-adv: add missing newlines for
log macros"). But with the new way of allocating objects, you need to rebase.
There will be a conflict which I think you need to solve via:

--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -564,9 +564,7 @@
 		return vlan;
 	}
 
-<<<<<<<
 	vlan = kzalloc_obj(*vlan, GFP_ATOMIC);
-=======
 	vlan_dyn_max = bat_priv->meshif_vlan_dyn_max;
 	vlan_dyn_count = bat_priv->meshif_vlan_dyn_count;
 
@@ -580,8 +578,7 @@
 		return NULL;
 	}
 
-	vlan = kzalloc(sizeof(*vlan), GFP_ATOMIC);
->>>>>>>
+	vlan = kzalloc_obj(*vlan, GFP_ATOMIC);
 	if (!vlan) {
 		spin_unlock_bh(&bat_priv->meshif_vlan_list_lock);
 		return NULL;

> @@ -824,6 +846,8 @@ static int batadv_meshif_init_late(struct net_device *dev)
>  	bat_priv->tt.last_changeset_len = 0;
>  	bat_priv->isolation_mark = 0;
>  	bat_priv->isolation_mark_mask = 0;
> +	bat_priv->meshif_vlan_dyn_max = 0;

Just to signify the importance of the access pattern, I usually also use
WRITE_ONCE() in the initializer. but this is not technically needed - and maybe
also not preferred by other people.

>
> diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
> index c33d2c6c..677d887e 100644
> --- a/net/batman-adv/netlink.c
> +++ b/net/batman-adv/netlink.c
> @@ -610,6 +615,16 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
>  		atomic_set(&bat_priv->orig_interval, orig_interval);
>  	}
>  
> +	if (info->attrs[BATADV_ATTR_VLAN_DYN_MAX]) {
> +		u16 vlan_dyn_max;
> +
> +		attr = info->attrs[BATADV_ATTR_VLAN_DYN_MAX];
> +		vlan_dyn_max = nla_get_u16(attr);
> +		vlan_dyn_max = min_t(u16, vlan_dyn_max, VLAN_N_VID);
> +
> +		bat_priv->meshif_vlan_dyn_max = vlan_dyn_max;

Please double check if this is under the same lock as the readers. Because your
need to otherwise use the READ_ONCE/WRITE_ONCE helpers to avoid problems like
load/store tearing, reordering, merges, reloading, .... (just look at the
memory-barriers documentation for a full list).

>
> diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
> index 0ca0fc07..5f2f467b 100644
> --- a/net/batman-adv/types.h
> +++ b/net/batman-adv/types.h
> @@ -1751,6 +1751,12 @@ struct batadv_priv {
>  	/** @meshif_vlan_list_lock: lock protecting meshif_vlan_list */
>  	spinlock_t meshif_vlan_list_lock;

I think this one is now also protecting meshif_vlan_dyn_count

-- 
Sven Eckelmann <sven@narfation.org>
