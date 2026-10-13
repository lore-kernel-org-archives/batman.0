Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 281E0CA9ED2
	for <batman@archiver.kernel.org>; Tue, 13 Oct 2026 10:56:00 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4C7248454A
	for <batman@archiver.kernel.org>; Tue, 13 Oct 2026 12:55:58 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791888958;
 b=A3YlrLuq9KSC5JFmvdvRpTOzpdaPc87S6IJeab+Zcr7Z0sBt11urZZP3Y9loU3QSjmtJQ
 bWO9+DpJtxjwcLecK/ZffxWkSwrAPwU0VYj/lmsC0OLoTm9OPdxqxq0D6RAa9zxl5Zl+RV0
 nCAINAN81n7l2yZre9Ji/5PT40jN0M8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791888958; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=FNRxvbYP5e+/XQz0K8genfHVU2BKHS4xcigwcZ6LkCs=;
 b=Kn4whbjpx36Csagk3oRNNgEwU7lgF69IFW81W2/hZj/zFcYr8o2Deab57b6hN/orz+Qvu
 9BeVj/Lpc078T+jYKuaTq/ob48ov4/blHIzz9QUbEh/7nGgrUTAC1pNRF9/kagJEErlDarr
 1BLQGZ7NL/dkwG9v9WaYLAV5SDhQNG4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 23E9481725
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 13 Oct 2026 12:55:49 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791888949;
	b=GbBREP29Ak53Xx7tE73ZkEQOUyKaQY4Nj5oxnnWhfd1Rj9wlPetBRBjlti+mhsS1lRgqLK
	o1XChQoKWAC5KgSf/R1pQQ1zBIQVmjP6S05Xj1JLXWf7PGP6oTRGF0tUiuKYQwaUcsmelL
	AihsSuJQHG4qJWjxWOPT+3th3i4/iIQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791888949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FNRxvbYP5e+/XQz0K8genfHVU2BKHS4xcigwcZ6LkCs=;
	b=uZVTBRjP/LMYMNseSEt5UwnTvG6CZgL+79GGYnBAS9pfvINV6gDWy/GNUW34pvHZ0x3deQ
	cCf1OpVkejNt9jnrGhz1/H5MywISh8aGV0vBnt6grwURmsuxKnvkhsi/AO8hEoiZue/uno
	MWvAKhsHlEgACq3UU9v35GUl8ZGLUJg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 116.203.183.178 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1FB6121BD6;
	Tue, 13 Oct 2026 12:55:46 +0200 (CEST)
Date: Tue, 13 Oct 2026 12:55:45 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org,
	syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH] batman-adv: Release references to inactive interfaces
Message-ID: <as4OMcL-nlD-mRIv@sellars>
References: 
 <20250927-netlink-free-inactive-if-v1-1-8f109d2104f7@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: 
 <20250927-netlink-free-inactive-if-v1-1-8f109d2104f7@narfation.org>
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: BE2J5YPMLIRVUIC3U2CAWFU6GEP4Z2JN
X-Message-ID-Hash: BE2J5YPMLIRVUIC3U2CAWFU6GEP4Z2JN
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BE2J5YPMLIRVUIC3U2CAWFU6GEP4Z2JN/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Sat, Sep 27, 2025 at 08:01:29PM +0200, Sven Eckelmann wrote:
> Trying to dump the originators or the neighbors via netlink for a meshif
> with an inactive primary interface is not allowed. The dump functions were
> checking this correctly but they didn't handle non-existing primary
> interfaces and existing _inactive_ interfaces differently.
> 
> (Primary) batadv_hard_ifaces hold a references to a net_device. And
> accessing them is only allowed when either being in a RCU/spinlock
> protected section or when holding a valid reference to them. The netlink
> dump functions use the latter.
> 
> But because the missing specific error handling for inactive primary
> interfaces, the reference was never dropped. This reference counting error
> was only detected when the interface should have been removed from the
> system:
> 
>   unregister_netdevice: waiting for batadv_slave_0 to become free. Usage count = 2
> 
> Fixes: 50eddf397ac3 ("batman-adv: netlink: reduce duplicate code by returning interfaces")
> Reported-by: syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com
> Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---

(Not that it'd really matter a year later, after merging, but just
for the record:)

Acked-by: Linus Lüssing <linus.luessing@c0d3.blue>
