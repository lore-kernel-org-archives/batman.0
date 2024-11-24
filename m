Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A74F6E668A1
	for <batman-adv@archiver.kernel.org>; Sun, 24 Nov 2024 10:00:57 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 132108301E
	for <batman-adv@archiver.kernel.org>; Sun, 24 Nov 2024 11:00:56 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1732442456;
 b=LVygHkGcG2TLfjdwqGhj9fdFOZFhdEaeOHUR/c5suOPuxIaWBCtwruwdWcP8lu/XtI4r4
 HKYlZ5F2ye5Ma3tx9W13mZgUuWw9Iv4scRfLGv2uxokya6nU8+iR0RVBhQARfbuSe9YjskV
 XVL/gP14EdhAi2/EddasgQ7+in+wz4k=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1732442456; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Bf/kMpUy+4kgd553HBHN6zXPOV60SQr7wfnb0x/Hnjk=;
 b=jcUcn866pS7Nr21V2p2zYtinAqHVWm1PSmlXF0qMp2f0drG1jPbc8KjZqGleAhiXXGp6F
 enj3+dLjZQD/0jQqE8mx4dchfQNvRq8eNndjZcrAx96qiekbbdiIVF0nBerL9YHSxOVmtTX
 tDJIbz6ItZMgiTu7yMq1BWOseutNJyc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id CBE348301E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 24 Nov 2024 11:00:43 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1732442443; a=rsa-sha256;
	cv=none;
	b=fro9rLwFyIJCsAWeTTGN8n8Mo5r5dFUEtjvwpmI2lxVWgTeL9dVI4TJ1Q8LSoJeW5m18WL
	GLdllAq3Ya+LJr4ShEnVYs7D7kMeiTl1m3DA4iN8Nwcbuan4RXx/xbk6d5Pp4rjUQfyM+m
	XXyGcF8QyEzO47lngN+fjxu1FQfZ0gk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=aw+mDcxX;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1732442443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Bf/kMpUy+4kgd553HBHN6zXPOV60SQr7wfnb0x/Hnjk=;
	b=wGuILXqzjsfiJg3qhhJxeHniNxTp+mRp+c49cqTMEOJ8QeOa4POrAXsVhJs4D+vHu0jPNJ
	P4cfMsULaysf6A0nlVukYOmUl4bEE16VJJlZpeVV3Wrex7Afk6S2adRS5EXsR4u+CxqMm7
	SlgnJapbhlckh3eGfTlfKddRUctdq8E=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1732442443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bf/kMpUy+4kgd553HBHN6zXPOV60SQr7wfnb0x/Hnjk=;
	b=aw+mDcxXw4NRc6BvQ7vYw8K3I7IhG++n4ZP9n2CnLO2VvyxxqqZV0TzojiZdSarUBQpxFR
	xjk+6b0hA75aGG1JXoFAuPV/c9cpw9K/quW4YuAi5pV8juOg7F5y091vCeQRUspEQfBTBb
	VRzwgwtZMGTAtNp++V7Gn7yrSSGbUww=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org, Remi Pommarel <repk@triplefau.lt>
Cc: Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>,
 Remi Pommarel <repk@triplefau.lt>
Subject: Re: [PATCH v4 5/5] batman-adv: Don't keep redundant TT change events
Date: Sun, 24 Nov 2024 11:00:40 +0100
Message-ID: <115531263.nniJfEyVGO@sven-l14>
In-Reply-To: 
 <3ffeca62cb1808f3d5fd3d1e0937c1e812cf16c2.1732290614.git.repk@triplefau.lt>
References: 
 <cover.1732290614.git.repk@triplefau.lt>
 <3ffeca62cb1808f3d5fd3d1e0937c1e812cf16c2.1732290614.git.repk@triplefau.lt>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Message-ID-Hash: 3PBBFLBNX7KQIHDA23HWBQTM4SEKEY2E
X-Message-ID-Hash: 3PBBFLBNX7KQIHDA23HWBQTM4SEKEY2E
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/3PBBFLBNX7KQIHDA23HWBQTM4SEKEY2E/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Friday, 22 November 2024 16:52:52 CET Remi Pommarel wrote:
> -               del_op_entry = entry->change.flags & BATADV_TT_CLIENT_DEL;
> 

This line must not be dropped. Just checked my PoC change and it seems like I 
already dropped it. I thought I've spotted and fixed this before. But most 
likely, I've just changed it in the editor and then forgot to copy it back to 
the mail client.

It is also called "Co-Developed-by: " and needs a SoB directly after that 
(which I didn't give at that specific point - but now did in batadv/net-next).

I have now changed this directly the batadv/net-next branch. But in case there 
needs to be a v6, please also change this locally on your end.

We will still wait for Antonio before I consider it really as accepted (and 
then try to send it to the netdev maintainers).

Kind regards,
	Sven


