Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9504EC3600A
	for <batman@archiver.kernel.org>; Tue, 17 Sep 2024 10:29:46 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C555483D88
	for <batman@archiver.kernel.org>; Tue, 17 Sep 2024 12:29:44 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1726568984;
 b=GyvvnwWP1Zz7rzmFX3Aox3Z0SLASSJTskMSYrmSC9ScNpKk9lUY8iuKCK1A8dqmK94biP
 jC5UdaGRUQIYjARBqZrzy2LSrhSRhN3Ysj4My3SuRq1Hch068yVAhaQA5dZXZ9RUY6qkZxp
 SAVKtSZdXzlK8LuRKaeuWqVm/N70vhg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1726568984; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=tg5WtezN8nklWSI9GJgcGcKKoFag4WrlaLDl/EesRZM=;
 b=KMMwxUZHkXDV38CDBV7ffJcYwXozR6lMBuz6XPxCoZlEVALF6WLQ/Q4poIbxnGCttV425
 H3Ka7ayhCjPKV1rOySiiSd+mggnZunzQp2BBlZguE5ItJoazLacXGCK/jUsL0JqtO65RVdr
 j56mrO0cFyDUwMVypWfn4TRkCnTInKg=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de
 [IPv6:2a01:4f8:c2c:665b::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 2F03A811B1
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 17 Sep 2024 12:29:07 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1726568948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tg5WtezN8nklWSI9GJgcGcKKoFag4WrlaLDl/EesRZM=;
	b=nCmOwcnccW+1CzMz06VSb7kEBT43AU4LSiQk8jJ/OYwzr2eE55GNlOVAmOEb5ize2vjKgE
	dJw3E3dXzRKLigyooOtULFqgI1ZlOZfUVifMWDRTangm4Be5zFHFZ6LYlzf/z/aI2ijkkt
	y1q4rAAfN8WlubS8tgXmyNL12xFvbAA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 2a01:4f8:c2c:665b::1 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue;
	dmarc=none
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1726568948; a=rsa-sha256;
	cv=none;
	b=U5w28TuS0k1K7hFL488BGhPh+hGdu4VJWKVKo8AsQ6Z2P1S04u+WpBbxelizgAxnw/OGGp
	bbugRRpRePqmgcxXFR4w3ce4YSMcd/oo6eYFriG0EeBfesZwRM0DHDP9mBIQC6ImZg3GaR
	pITT/JlYEhSTxQp57rmmAkq54NPWvno=
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 169523EF9D;
	Tue, 17 Sep 2024 12:29:06 +0200 (CEST)
Date: Tue, 17 Sep 2024 12:29:04 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: Antonio Quartulli <a@unstable.cc>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH v5 1/2] batman-adv: split DAT cache into DAT cache and
 DAT DHT
Message-ID: <ZulZ8AYEcaQSOoIa@sellars>
References: <20240911051259.23384-1-linus.luessing@c0d3.blue>
 <20240911051259.23384-2-linus.luessing@c0d3.blue>
 <0f7c0a9f-6577-4d37-8ad3-2a6b1369b539@unstable.cc>
 <ZuLLkEf15zZTN5xj@sellars>
 <55721542-08b7-40b0-a272-9e1f3287c32f@unstable.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55721542-08b7-40b0-a272-9e1f3287c32f@unstable.cc>
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: VBNVEJG3TKDJ72CA65VL6BMTDOEEJS72
X-Message-ID-Hash: VBNVEJG3TKDJ72CA65VL6BMTDOEEJS72
X-MailFrom: linus.luessing@c0d3.blue
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/VBNVEJG3TKDJ72CA65VL6BMTDOEEJS72/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Thu, Sep 12, 2024 at 01:28:16PM +0200, Antonio Quartulli wrote:
> I feel you need to answer the above questions even with two tables. No?
> The difference is that with two tables you have more information and don't
> need overwrite a DHT entry with a local one (and viceversa).

Right. Though the straight-forward/easy approach differs between
the two, I guess:

Currently with the two table approach I'm not having any direct
interaction between them. So in theory a node might have a DHT
table entry which is not as up-to-date as a DAT local cache entry
on the same node?

But I'm having a hard time constructing this scenario. I guess it
would need some topology change that results in new/other DAT
candidate nodes? But then that entry wouldn't be that relevant
anymore anyway, if it's not on a DAT candidate anymore?

While the straight-forward / less lines of codes approach with
flags would be to always overwrite and flip the flag, I guess.

> I think splitting is a good idea, not only because of the timeout, but also
> because it makes the state more clear.

Right, and you can also see the two, distinct states clearly as a
user with the new "batctl dd" vs. "batctl dc".

Regards, Linus
