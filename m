Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B79C43458
	for <batman-adv@archiver.kernel.org>; Sun,  5 Jul 2026 12:42:26 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 45E6284328
	for <batman-adv@archiver.kernel.org>; Sun, 05 Jul 2026 14:42:25 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783255345;
 b=w+2MHr5DFIrAXwwFKwAkthxjD8HonDXtsJKUyMJqm+fwsfndGjwpH7JXs4XX+c0MU2ULL
 MqyxWlEWoaw613l5gQzXzIrhmqT8E4Hipx40llKntZS+uBSAUrzNeiab1FYuajLE38TJMcj
 bhwZbqPa0ie1ueNlyrR56WfKH+u1cR0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783255345; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=WTdRdMb2dWRLgrnsx19QEh4cFpN7vxHiSHv5BclY2ys=;
 b=CeXL1NQkRIBGLqUIdB26iGMzou+PgbvqQzCT8Dsb2WsJv3vTe6jTQWTOO7Uzv+8W7+sno
 zMHdagEs0FHlmifADOjvg/d3hOMUNGHDT2KaUC3TrAu+Aal+3KVorc+HnuLrxNGthWCbTCZ
 5WbIMZBulfVXDudX3E5C1bTuf5ZRVzs=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 482AF83E1C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 05 Jul 2026 14:42:02 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783255323;
	b=VkLmzQSqRdWcPae7ivpT6hjTh8VQDR4uH3p9lqDavH4KXYHdnc7tX8DSrMJUND3mBEpzjf
	3Sou3ReqOn4IGeqN817wheXF4RoSUS2Eh6qhJApAg36XzTEzZ10ZYbH5vB0m6jg5ySiIf+
	IAHkkp/BOHyvVlghv//Zg79MLwW3mY0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783255323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=WTdRdMb2dWRLgrnsx19QEh4cFpN7vxHiSHv5BclY2ys=;
	b=RQMU4nu2YgFtSWgYnVyazWNboTltUjk2pNQ++4ZppJIx7WB6EMcCnofBQ1J+9btN9EoRW6
	ezv5nqLkTcQyS1s2BLc2mv5XkxL3kQSMmcKRIJj0c/Gm68paz47AihGdK/+MVvywJeP+Oq
	S4g8JEm60S1pqstJMISZ7Qc9OzLq3oo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=kx82PVNd;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id BB198201CF;
	Sun, 05 Jul 2026 12:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783255321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WTdRdMb2dWRLgrnsx19QEh4cFpN7vxHiSHv5BclY2ys=;
	b=kx82PVNdEx/Wk+tQokwiSqE++9bu/9kMxa3Yv+K8e0shAcDbMI46dLVkEvxy0Z6lFCLkHw
	wynrgXcjZDi+vyqyHe0cuBixa+l5W8FfVEsVgslnkN6tixXWLP19GPUx8iLkAtJMd75UCU
	tddKqYELNmlDuPY/DETL/OrqP2Rzxak=
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] batman-adv: fix throughput detection for VLAN
 interfaces
From: Sven Eckelmann <sven@narfation.org>
To: Amitesh Singh <singh.amitesh@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org, marek.lindner@mailbox.org,
 sw@simonwunderlich.de, antonio@mandelbit.com, sven@narfation.org,
 linux-kernel@vger.kernel.org, amitesh.singh@chargepoint.com
In-Reply-To: <20260705122134.62809-1-singh.amitesh@gmail.com>
References: <20260705122134.62809-1-singh.amitesh@gmail.com>
Date: Sun, 05 Jul 2026 14:41:51 +0200
Message-Id: <178325531132.27339.5219063208417341297.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2139; i=sven@narfation.org;
 h=from:subject:message-id; bh=8ggzsxkTYY0lVnQ/q+2RAGM/s7RD1Obhj1qLn96IqoA=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFlegYJLarqbshQEJlwRsVvVdWTjuQfRFxZ93W5zWbrx+
 6MNnJeSOkpZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATucvH8D9acmvNV1Xfy0ov
 DnEvf6vQWMEod33SdlHd5cEF3w6w1dszMrTElJT8z521ZqJT7N7tO4q8ZOMOrJb6r/BpwmTzWcx
 za1gB
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: LSWY6NQGBWF6DUVJVUGBXR4FRCBPOS3Y
X-Message-ID-Hash: LSWY6NQGBWF6DUVJVUGBXR4FRCBPOS3Y
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/LSWY6NQGBWF6DUVJVUGBXR4FRCBPOS3Y/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Sun, 05 Jul 2026 17:51:34 +0530, Amitesh Singh <singh.amitesh@gmail.com> wrote:
> batadv_v_elp_get_throughput() calls __ethtool_get_link_ksettings() to
> determine the link speed of an Ethernet interface. Virtual interfaces
> such as a VLAN on a bridge return success but with SPEED_UNKNOWN, so the
> function falls through to the hardcoded default even when the underlying
> physical device has a known speed.
> 
> Move rtnl_unlock() into each exit branch so the lock is still held
> after the initial query. When the speed is unknown, walk the lower
> device stack with netdev_walk_all_lower_dev() to find the first real
> device that reports a valid speed, which covers DSA ports and physical
> NICs sitting below a VLAN or bridge interface.

Has to be reviewed by someone with B.A.T.M.A.N. V expertise, but:

What makes you think that the found port is then the port something is sent 
out (towards this specific neighbor)? The neighbor could be behind a 10Mbit/
Half port and you just found a 25000Mbit/Full port and stopped
netdev_walk_all_lower_dev

>
>
> diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
> index 6ad6042a..3d4d82c5 100644
> --- a/net/batman-adv/bat_v_elp.c
> +++ b/net/batman-adv/bat_v_elp.c
> @@ -70,6 +70,32 @@ static void batadv_v_elp_start_timer(struct batadv_hard_iface *hard_iface)
> [ ... skip 23 lines ... ]
> +		return 0;
> +
> +	*(u32 *)priv->data = speed * 10;
> +	return 1;
> +}
> +

Duplex handling was not copied to this function

> @@ -177,9 +202,30 @@ static bool batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh,
> [ ... skip 14 lines ... ]
> +			struct netdev_nested_priv priv = { .data = &throughput };
> +
> +			netdev_walk_all_lower_dev(hard_iface->net_dev,
> +						  batadv_v_elp_lower_dev_throughput,
> +						  &priv);
> +		}

Why this extra scope?

> +		rtnl_unlock();
> +		if (throughput) {
> +			*pthroughput = throughput;
> +			return true;
> +		}

Sashiko review:
https://sashiko.dev/#/patchset/20260705122134.62809-1-singh.amitesh%40gmail.com

-- 
Sven Eckelmann <sven@narfation.org>
