Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D370DCD4F3C
	for <batman-adv@archiver.kernel.org>; Sun, 17 May 2026 21:09:15 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4A30585A1C
	for <batman-adv@archiver.kernel.org>; Sun, 17 May 2026 23:09:14 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1779052154;
 b=1ZGN1xBDNqCZNB2vnngB5eiSzUpsEVVzM11JaLUb/ExV14Yd6Bl0/EM2QKUqSDsNb83Iy
 NZ1y547jMmiE7PWRngncUUDKC1BTG5ZrTFd0gYa3UouNP5VHOsxmUBRiEQdpicNFBVlLj/V
 AYGT68OhBKW8NUJbNyKPLbJnLRNFtVE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1779052154; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=HCZedBTffng3L/uSmwsqlC9XJGWi3K7avu2lWsh/luA=;
 b=z6iwUbT4w+qvPu6qL7W1XHBDeT8Rydn6nvM4R6MOb18Yf+9seWhXAOaK0If8lqAdVM5dZ
 fqAd228sn+G7APdfoGekY7SymL8HxW+bDPCUI98ZhUhrwx20oci/ruJu2m++eUf1lzy0XAX
 9RBVtFwY03YX9TMDd+Oh17Y1f6P5cxY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de
 [IPv6:2a01:4f8:c2c:665b::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 184DD84219
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 17 May 2026 23:08:33 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1779052123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HCZedBTffng3L/uSmwsqlC9XJGWi3K7avu2lWsh/luA=;
	b=21RMs7oz7/Ysk1ZIYTKfIeCK7FPwwXrWvqu95eLjOHo6moAAzI2VHg2miGnzzbFJT39Omu
	7Skyh52iKdJlYjlgWhPmwJ8NWoMS230B/9t6yxZJ3SKwg0nzx9KGTYaJrFMz35C5NspT4J
	abktrx/EXcBEo4x63kdgSnb7pOdoSY8=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1779052123;
	b=036Y43rGxYbku+aWWlttXbadnf3Og+c/Hj/VQWdnFiVCr9EZY7onRMEomPGAnECr4kQkQ7
	x2TY7UzOYKImhWrISaqOJthnuLj2P69PE0wo5ccSQOwwiUDQOI1q3uAlOfYtg9OJ6mBdeu
	i9GNy+ZkDHAw81aRRxtndKvw9nCyAZ8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 2a01:4f8:c2c:665b::1 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue;
	dmarc=none
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 31C1E541046;
	Sun, 17 May 2026 23:08:32 +0200 (CEST)
Date: Sun, 17 May 2026 23:08:30 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH RFC batadv] batman-adv: mcast: fix use-after-free in
 orig_node RCU release
Message-ID: <agouTnSEU6CuTF5i@sellars>
References: <20260514-mcast-rcu-list-free-v1-1-0e20f24faa61@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260514-mcast-rcu-list-free-v1-1-0e20f24faa61@narfation.org>
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: OX2RKJERKFJE4ZKL2R5FKZQP5K2MDEZ4
X-Message-ID-Hash: OX2RKJERKFJE4ZKL2R5FKZQP5K2MDEZ4
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/OX2RKJERKFJE4ZKL2R5FKZQP5K2MDEZ4/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Thu, May 14, 2026 at 07:41:38PM +0200, Sven Eckelmann wrote:
> batadv_mcast_purge_orig() removes entries from RCU-protected hlists but
> does not wait for an RCU grace period before returning. Concurrent RCU
> readers may still accesses references to those entries at the point of
> removal. RCU-protected readers trying to operate on entries like
> orig->mcast_want_all_ipv6_node will then access already freed memory.
> 
> Fix this by moving batadv_mcast_purge_orig() to batadv_orig_node_release(),
> just before the call_rcu() invocation. This ensures RCU readers that were
> active at purge time have drained before the orig_node memory is reclaimed.
> 
> Fixes: 1c090349e2f6 ("batman-adv: Add IPv4 link-local/IPv6-ll-all-nodes multicast support")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Makes sense to me now and does not seem to crash on my laptop with
Debian Sid in a simple batadv/veth setup.

Acked-by: Linus Lüssing <linus.luessing@c0d3.blue>
