Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7BB606A321
	for <batman@archiver.kernel.org>; Tue, 24 Nov 2026 17:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aOsFhM4I
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4FF16830AF
	for <batman@archiver.kernel.org>; Tue, 24 Nov 2026 18:25:49 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795541149;
 b=UNbrk8qu8drqX1zSlHKgWe0kpRWUbBxMaz5PM/0qRIhNg5y/dTvk29zPpFxpP/q2Z/a7k
 Hhq6qbTR4FFFctkdaw6CwKLCQs8ygu61priPnt2zwd+6C1QDy0maNdWGqnv37XPMKA3kWlZ
 rONFqLnT4MgSjBlrbxJ0hh5AEkFayJE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795541149; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=FUK8eWr2NDwVWOIiPWW2mhsPXB2tXYeP2xK491Ae/Us=;
 b=p5c+uuzO5FdxTRLm+7Y06ziwtyBZ3kuwpo080Chvqn81qo73dPTgr0MfLWvvi0UN3qpRo
 ukJ9vz7ioiVYNHD1gvgJemWyb3PTU7vdzebARhXPdKE1apLbJF7WiYM1GuofWRTU1CFXwMd
 JS3GJwgLH7DeVxS0RZgwYmtTIL2PYlU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 2B6F380B6E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 24 Nov 2026 18:20:41 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795540851;
	b=3hrRjuMLbvyrFfA0JVfaTo2AEaaSsRhchAgpm4GI1A5RDJXSJ9OTvkmHvQM+RnMj8+zVML
	eaB3CsnemzOsSrA3PChKcZXLhYvg4bOdc1z0gxC5QEf5G7OOwXzCSFfssgjrBxu6weH2Ke
	iuBPDAuNeiSV/aohVOTpp7ExhkXskNE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795540851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=FUK8eWr2NDwVWOIiPWW2mhsPXB2tXYeP2xK491Ae/Us=;
	b=WFr3xnOIIUP932zUG19UI8l2Dh390ed84yHJ4gTvyx/BrDt73zmJ9Yj733n4ry/0l4dlh8
	/tIxzOuOSsOjUTiUwEr7ST9MkDtCETL1D8qQflJKELdqdNIZyhB+/5bfHPOCyy3w4MWOqb
	LW/lM4xWClaBiCUv21xnzkPVopJX9X4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=aOsFhM4I;
	spf=pass (diktynna.open-mesh.org: domain of netdev-bot+sashiko@kernel.org
 designates 172.234.252.31 as permitted sender)
 smtp.mailfrom=netdev-bot+sashiko@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 94E7B429CA;
	Tue, 24 Nov 2026 17:20:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E83E71F000D2;
	Tue, 24 Nov 2026 17:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795540839;
	bh=FUK8eWr2NDwVWOIiPWW2mhsPXB2tXYeP2xK491Ae/Us=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aOsFhM4IzJ/6vH5lymBfEfHvbRwNjxJ9y7HK+CRJ1dFcu/bP9p2hWaq4r/YCx4F3+
	 u7qu12tcuWPd/H41TbsLiousWPl7hUoqFW1IQhM49qkL994Z+uxlxartH4MGCJOA2j
	 97bNJ25PUWbU1l0sfIbW+DHwsER8eXv6HySxNamQ0VVitotkFTER66BpGoTEwDYi1/
	 IGHn9ZH31hBeqG/yYTlnVdMrKg8cHIoIiW2a4mjFwPOvUsVdsdZY1g5270Sto09Rn7
	 BidzR1OxLsZ2X6aoQ1AJOWivIN89y/p1bqrIgnD2llz6ygQC9Pldnl8aS0hh+AfhKA
	 ygzrrNNljLRZw==
Subject: Re: [PATCH net-next 04/15] batman-adv: bla: register own backbone gw
 when claiming for local node
From: netdev-bot+sashiko@kernel.org
To: sw@simonwunderlich.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org
Date: Tue, 24 Nov 2026 17:20:38 +0000
Message-ID: <179554083850.3135.5611010478427382077@kernel.org>
In-Reply-To: <20261123171827.3294525-5-sw@simonwunderlich.de>
References: <20261123171827.3294525-5-sw@simonwunderlich.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MailFrom: netdev-bot+sashiko@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: OP5XLTYBDBNBNBMHIB3Q25EXUOGJJ7ZG
X-Message-ID-Hash: OP5XLTYBDBNBNBMHIB3Q25EXUOGJJ7ZG
X-Mailman-Approved-At: Tue, 24 Nov 2026 18:25:24 +0100
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/OP5XLTYBDBNBNBMHIB3Q25EXUOGJJ7ZG/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit fixes a real BLA bug that users can see on the LAN,
  but it has no Fixes: tag.
- [Low] The commit message says the own backbone gateway entry may be
  missing "for example due to an earlier error".

--

batman-adv: bla: register own backbone gw when claiming for local node

With this patch, batadv_handle_claim() passes own_backbone=true to
batadv_bla_get_backbone_gw() when the backbone address is the primary
interface address. Before, an own backbone gateway entry created on the
rx claim path was set up like a foreign one. No initial announcement was
sent and the UNSYNCED grace period was skipped.

Closes: https://sashiko.dev/#/bug/linux-dba9d95d-5eeb-40fd-abf4-e054aee1f735

> When no backbone gateway entry for the local node exists yet on this VLAN
> (for example due to an earlier error), the entry is therefore created like
> a foreign backbone gateway.

[Severity: Low]
Is "for example due to an earlier error" the usual way to reach this state?

In batadv_bla_rx(), batadv_handle_claim() is called with the primary
interface address before batadv_bla_update_own_backbone_gw() runs at the
allow label:

net/batman-adv/bridge_loop_avoidance.c:batadv_bla_rx() {
    ...
		batadv_handle_claim(bat_priv, primary_if,
				    primary_if->net_dev->dev_addr,
				    ethhdr->h_source, vid);
		goto allow;
    ...
allow:
	batadv_bla_update_own_backbone_gw(bat_priv, primary_if, vid);
    ...
}

batadv_bla_update_orig_address() also purges every backbone entry when
there is no old primary interface or BLA is disabled:

net/batman-adv/bridge_loop_avoidance.c:batadv_bla_update_orig_address() {
    ...
	if (!oldif) {
		batadv_bla_purge_claims(bat_priv, NULL, 1);
		batadv_bla_purge_backbone_gw(bat_priv, 1);
		return;
	}
    ...
}

This runs when the primary interface is selected and when BLA is toggled
through batadv_bla_status_update().

After bring-up or a BLA toggle, the first frame on a VLAN received from
the mesh with an unclaimed source (or a unicast source claimed by a
foreign gateway) seems to create the own entry through
batadv_handle_claim(). That happens in normal operation, without any
earlier error.

Could the commit message say that this is the normal startup path? Stable
maintainers would then have an accurate picture of how often the bug
occurs.

> diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
> index 68ff2f94cf49d..3da070a087da6 100644
> --- a/net/batman-adv/bridge_loop_avoidance.c
> +++ b/net/batman-adv/bridge_loop_avoidance.c
> @@ -986,18 +986,22 @@ static bool batadv_handle_claim(struct batadv_priv *bat_priv,
>  				unsigned short vid)
>  {
>  	struct batadv_bla_backbone_gw *backbone_gw;
> +	bool own_backbone;
> +
> +	own_backbone = batadv_compare_eth(backbone_addr,
> +					  primary_if->net_dev->dev_addr);
>  
>  	/* register the gateway if not yet available, and add the claim. */
>  
>  	backbone_gw = batadv_bla_get_backbone_gw(bat_priv, backbone_addr, vid,
> -						 false);
> +						 own_backbone);

[Severity: Low]
Should this patch have a Fixes: tag?

The false argument replaced here came from commit 52aebd6a9fe4
("batman-adv: send announcement when backbone gw is registered"). That
commit's message says the announcement should go out as soon as a
backbone gw is added, for example when "a packet passes the rx or tx
path". This rx call site never passed own_backbone=true, though.

Commit d807f2728708 later added the UNSYNCED/num_requests hold-back. It
sits in the same if (own_backbone) block in batadv_bla_get_backbone_gw(),
so this call site skipped it too.

Would something like this work?

Fixes: 52aebd6a9fe4 ("batman-adv: send announcement when backbone gw is registered")

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261123171827.3294525-2-sw%40simonwunderlich.de
