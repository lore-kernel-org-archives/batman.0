Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C683BCA5FB3
	for <batman-adv@archiver.kernel.org>; Thu,  1 Oct 2026 12:15:53 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 23524810DC
	for <batman-adv@archiver.kernel.org>; Thu, 01 Oct 2026 14:15:52 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1790856952;
 b=05O2EHAy1qkOOtq0eR6BvEMoqLN8sq1FgBNWlMASalZ5AOmCVtP5mSOu9XfCQzfrK5XUt
 h+h8ch6isCWAvJAAAvGEF9PmljLofRLX8GXJ+3RBOQL4UJAU/tnuzjaCSfSrVDRffbehzd/
 w43XDdkSDn2pgl/biUyKIi9AvZ6uZA0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1790856952; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=vlZGPYj1d1ZFsTdMsJcZLBSvncgKD90m2oBH2nB0+Kc=;
 b=dAXkQJCUzoetQW57nEET6AlvUHF0qRiD52iKVlEBM8VQd2mYWfWm5FVJ5zPePZVvw5DT6
 neS60/9EwExjQ0wB07Lka6V/5imq1YLVpq6nYn/CHAWwPXRpQUKroI0x69AKbxkStpidXzL
 dhHlpuTr8DHWe1nVTAK4WCvdOzGVLE0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 6F31A80406
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 01 Oct 2026 12:10:29 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1790849439;
	b=wA3rmoQ2BjfKffJIu+EHs9ezSe0oTLt8ZYD5Vm1Or2/7Oaa9a9n/u4emTvcdiDXuwIx0Y7
	B5yt3j+3GX0LRxMF0HwaGEsOwYm07v861tj1kZspEpXkKMA9qp5uRpigjeW3excKcHZkwu
	4g+mhBD4W5lNZFy6dzEElD91DzfTTTM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1790849439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=vlZGPYj1d1ZFsTdMsJcZLBSvncgKD90m2oBH2nB0+Kc=;
	b=T+MU6COmybblk0d7dzwk1qvaV4CU/vZMHDUmUqtkeTWHJJH7+vHGGALlJigqgBShEUzJpl
	CuKi+lEO0UlQSan4C9uz3dkXMjdMa1Neu7EvtkxWp197APi3yIbsh9CV7Wvy3yMRPu4Pu5
	D9fP6vKv32EnBFIvtcZe3ufu63qLeI4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eofFC4Rd;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (diktynna.open-mesh.org: domain of netdev-bot+sashiko@kernel.org
 designates 2600:3c04:e001:324:0:1991:8:25 as permitted sender)
 smtp.mailfrom=netdev-bot+sashiko@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5D8096021A;
	Thu,  1 Oct 2026 10:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F9161F000FF;
	Thu,  1 Oct 2026 10:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790849427;
	bh=vlZGPYj1d1ZFsTdMsJcZLBSvncgKD90m2oBH2nB0+Kc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eofFC4RdFUidCEZGVIf4FkUIkwKJfrBs7SsMqyEqvHmXSsI+4sGjNkdf1aQrNQ34f
	 YIk2KlDxb53p4K3NXANA7p+BNmbChmpDRGejcZhaotluDtOO2+d7eKyuqfatu2GGYL
	 JN+ZT1j7Q+oH2ed9/8b0c3LmmalQ2T82CcfktgiUTXSS1kWmdwxLcReG6fJvHD2aVP
	 3dGxHe2S5QU5t/ntvDM5vBwqAl97NLQ59DGLJ2pYgwr8I93Xaiw258hHqT3bYOTSxy
	 nCUbDXut6caHtFrEnP7WrqYoWZqJ4UyPitp79iZWZiLi+2Ngal/gQF6jNQfNtlLlw9
	 Cg3gnCi3KsE0w==
Subject: Re: [PATCH net-next 1/9] batman-adv: bla: avoid double free after
 failed backbone_hash alloc
From: netdev-bot+sashiko@kernel.org
To: sw@simonwunderlich.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org, sashiko-bot@kernel.org
Date: Thu, 01 Oct 2026 10:10:26 +0000
Message-ID: <179084942612.434549.483028329310521943@kernel.org>
In-Reply-To: <20260930094558.3723766-2-sw@simonwunderlich.de>
References: <20260930094558.3723766-2-sw@simonwunderlich.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-MailFrom: netdev-bot+sashiko@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: JY6XC5IBUFKDPDO3A3PFLJ4NAENLTTOC
X-Message-ID-Hash: JY6XC5IBUFKDPDO3A3PFLJ4NAENLTTOC
X-Mailman-Approved-At: Thu, 01 Oct 2026 14:15:11 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/JY6XC5IBUFKDPDO3A3PFLJ4NAENLTTOC/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message describes a double free that cannot happen.

--

batman-adv: bla: avoid double free after failed backbone_hash alloc

This commit sets bat_priv->bla.claim_hash to NULL after
batadv_hash_destroy() in the batadv_bla_init() error path taken when the
backbone_hash allocation fails. The commit message says that the
destructor later frees claim_hash a second time via batadv_mesh_free()
-> batadv_bla_free().

> When batadv_bla_init() fails to initialize the backbone_hash, it is freeing
> the (previously) allocated claim_hash. The initialization function will
> then return an error and the net_device initialization will stop. The
> destructor will be called instead and (indirectly via batadv_mesh_free() ->
> batadv_bla_free()) will try to free the bat_priv->bla.claim_hash again.

[Severity: Medium]

Can this sequence actually happen? batadv_bla_init() has only one
caller, batadv_mesh_init(), and when it fails that function jumps past
batadv_bla_free():

net/batman-adv/main.c:batadv_mesh_init() {
    ...
	ret = batadv_bla_init(bat_priv);
	if (ret < 0) {
		WRITE_ONCE(bat_priv->mesh_state, BATADV_MESH_DEACTIVATING);
		goto err_bla;
	}
    ...
err_dat:
	batadv_bla_free(bat_priv);
err_bla:
	batadv_v_mesh_free(bat_priv);
    ...
}

batadv_mesh_init() is only reached from batadv_meshif_init_late(), the
.ndo_init callback, which returns the error. In register_netdevice(), an
ndo_init failure skips the priv_destructor call:

net/core/dev.c:register_netdevice() {
    ...
	if (dev->netdev_ops->ndo_init) {
		ret = dev->netdev_ops->ndo_init(dev);
		if (ret) {
			if (ret > 0)
				ret = -EIO;
			goto err_free_name;
		}
	}
    ...
err_uninit:
	if (dev->netdev_ops->ndo_uninit)
		dev->netdev_ops->ndo_uninit(dev);
	if (dev->priv_destructor)
		dev->priv_destructor(dev);
err_free_name:
	netdev_name_node_free(dev->name_node);
	goto out;
}

After that, free_netdev() sees reg_state == NETREG_UNINITIALIZED and
only calls kvfree(dev). So batadv_meshif_free() -> batadv_mesh_free() ->
batadv_bla_free() does not seem to run on this path, and nothing reads
or frees the stale claim_hash pointer again.

Also, if the destructor did run here, wouldn't batadv_bla_free() call
disable_delayed_work_sync(&bat_priv->bla.work) on work that was never
set up? INIT_DELAYED_WORK() only runs after both hashes are allocated.
The patch doesn't handle that case, so the description and the fix don't
seem to match.

This makes the change look like harmless hardening rather than a
double-free fix. Could the commit message describe it that way, or show
the path where the second batadv_hash_destroy() actually happens? As
written, stable or CVE tooling may treat it as a memory-safety fix.

> diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
> index ad6ab4a50658f..a96f269da8d37 100644
> --- a/net/batman-adv/bridge_loop_avoidance.c
> +++ b/net/batman-adv/bridge_loop_avoidance.c
> @@ -1625,6 +1625,7 @@ int batadv_bla_init(struct batadv_priv *bat_priv)
>  	bat_priv->bla.backbone_hash = batadv_hash_new(32);
>  	if (!bat_priv->bla.backbone_hash) {
>  		batadv_hash_destroy(bat_priv->bla.claim_hash);
> +		bat_priv->bla.claim_hash = NULL;
>  		return -ENOMEM;
>  	}
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930094558.3723766-2-sw%40simonwunderlich.de
