Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCA7CD4F47
	for <batman-adv@archiver.kernel.org>; Sun, 17 May 2026 17:56:30 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id F3BFC85AD0
	for <batman-adv@archiver.kernel.org>; Sun, 17 May 2026 19:56:28 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1779040588;
 b=E6XiUvMw1jN8v6Dmh8/WtioWftrG9dYFVHTRyxqlX3uxw8302/Dw0ga8nEGR1i5RwFZno
 JVOEQP0GtKyFtAV2SQQJhCNUS+amNn/yhhJYxO3OszBSEQGTE3kLS6T2JENwEDYIk3VMKqO
 EzX0RC6FAdl0sNG/IwJkFYh+SXcnOWQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1779040588; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=po3qsqv1oshwVbEgw14LBMquMyJXMMhEEnRcYgQFOu0=;
 b=CEoAZbnm5/ho7ZYWznx4qdcLifBZulShxYZrEzPFrak8/xOxtLgrGO95OaQVcssQu3GmI
 PnGXtlFA7OBpYDlODM4g29gCz4bJ9S4OAyxl/s+vRzVbA2t2ek+2WVLswoMNZOnzJBgFJTC
 qYsUW+ZVvmy8anyGnvSyNVFgn9PZnMY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de
 [IPv6:2a01:4f8:c2c:665b::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 8217E84220
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 17 May 2026 19:55:58 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1779040558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=po3qsqv1oshwVbEgw14LBMquMyJXMMhEEnRcYgQFOu0=;
	b=tqjdMIbquQH9LPS85UOT/JULpwtBTRUZpMloVxR2ahjXA+RS8vaiNS5WWPTGzGyf1XSytI
	y+V+cvNKF8YTO6x+IIeHpnwfnSqj1ZOddg0ySqGbeY+0aebluhGeHaviFmRve3Aec97hID
	bE3yw5BziOxspWWyJivZPsl0MH68lwI=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1779040558;
	b=WsOANGLNsV9IMeC88SNxlv323uIMtHiv1Uf60CeNAPj8JETjb/o2TULOguc2ETa6bCf6/Q
	spcBfoZEw7H+TdpRKNgJ1ZqcnFapkvZdSxpnfaeSjcas0v8OCARxqiVi5fNGzepPx9zj1A
	tWxYn1DCgmyyhekpg0CgtyUtrzrBt0o=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 2a01:4f8:c2c:665b::1 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue;
	dmarc=none
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8304D541046;
	Sun, 17 May 2026 19:55:57 +0200 (CEST)
Date: Sun, 17 May 2026 19:55:56 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH RFC batadv] batman-adv: mcast: fix use-after-free in
 orig_node RCU release
Message-ID: <agoBLITjEyVPScvd@sellars>
References: <20260514-mcast-rcu-list-free-v1-1-0e20f24faa61@narfation.org>
 <agnvHQNOj2Sn7Thr@sellars>
 <5073295.GXAFRqVoOG@sven-l14>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5073295.GXAFRqVoOG@sven-l14>
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: JWV3T7JOTIJRMAQWOJFJ3P3UWPLYSHKU
X-Message-ID-Hash: JWV3T7JOTIJRMAQWOJFJ3P3UWPLYSHKU
X-MailFrom: linus.luessing@c0d3.blue
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/JWV3T7JOTIJRMAQWOJFJ3P3UWPLYSHKU/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Sun, May 17, 2026 at 06:54:09PM +0200, Sven Eckelmann wrote:
> But this looks super RCU-like (without locks):
> 
> static int
> batadv_mcast_forw_want_all_ipv4(struct batadv_priv *bat_priv,
> 				struct sk_buff *skb, unsigned short vid)
> {
> 	struct batadv_orig_node *orig_node;
> 	int ret = NET_XMIT_SUCCESS;
> 	struct sk_buff *newskb;
> 
> 	rcu_read_lock();
> 	hlist_for_each_entry_rcu(orig_node,
> 				 &bat_priv->mcast.want_all_ipv4_list,
> 				 mcast_want_all_ipv4_node) {
> [..]
> 	}
> 	rcu_read_unlock();
> 	return ret;
> }

Ah, no, you're absolutely right, I mixed it up!

Maybe this might make more sense as a fixes line then, though?

Fixes: 500ea14940f8 ("batman-adv: Add multicast-to-unicast support for multiple targets")


I think before that commit we only used these atomic counters in
fast path?
