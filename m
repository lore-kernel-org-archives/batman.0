Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B08C55ABA
	for <batman-adv@archiver.kernel.org>; Tue,  4 Aug 2026 22:15:01 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D59608404C
	for <batman-adv@archiver.kernel.org>; Wed, 05 Aug 2026 00:14:59 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785881699;
 b=C8+hPopFRpVOWb/+uPCAB2FX4/AmIipMSZUW9BboUJMjZsf1lIZzPnQLR01FC/f+rvZ30
 dkszXFGG8wCUrNpbKD/BaPUloTGrCE3cXwO0i1TDhr/rhFe/NrDpDQgpxM3J3Im4RSyJi3L
 Br9+ZsvMlgTdP9xCrWxYSjVSkeIk7xA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785881699; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Ktqovc+lxDsREFegvleHGmLzqwtF/O4V72Ce1vxAsas=;
 b=bqlyu/L1WnPcW86oAi0NSgE7ccFZeZEof1lnrw45XauYicwgn0flm0RP/EZ4E5zhcIylk
 pVWx2jnkxwi/mPqdANUbsvzPRfMM+s9JCxvIXCQeEtp6nEEHlEoVrQQ1ymdv/x87PUNOWDA
 QHHXUXpKKwRZB7VaQ2dOlg31d2++aoM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 1F9FF80A56
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 05 Aug 2026 00:14:30 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785881682;
	b=Gqxm3cSjr1zXpboSjrSrTVCEcyRxRYREZa77EITllQybX/I814umUDtSBgXusLejoSQIQd
	290FIAthc+isnxRhgJnexTS63sg/P6nId2WUs7GdnPDr5er7uauv3xND1RynOVzHFbF7Zd
	WZ+ajEvt9RQJVfmr6LaIUNmbLNZurT8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785881682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Ktqovc+lxDsREFegvleHGmLzqwtF/O4V72Ce1vxAsas=;
	b=rQW6XZmhf/N8M1U8lvSlF3ZMVHskq8mkMkxpvF3dM2kArox9A3A+/N7cBcE6Vk+k8WVbld
	dFOF848Mi8aKz6VOJEHRrvuhsBRg6KpJqwvzA9K5OYYw+IKVZUp4qU46EGBPPpSh3Ttr/R
	NSybaA2bFRhx+33MBa4gKhK+juJfLp4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=OzxZO806;
	spf=pass (diktynna.open-mesh.org: domain of kuba@kernel.org designates
 172.234.252.31 as permitted sender) smtp.mailfrom=kuba@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2D9784321F;
	Tue,  4 Aug 2026 22:14:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D471F000E9;
	Tue,  4 Aug 2026 22:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785881669;
	bh=Ktqovc+lxDsREFegvleHGmLzqwtF/O4V72Ce1vxAsas=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OzxZO806s/U8yG1THKDeyEokGM53o3vTecIFgqApjZdYCioHn9j8DBHdRWllTFwHm
	 U3RTLEUwWyp19FjdMqsXWKwVMXh89UjytFvz55wxtIJz0ERnNBx9BGQ5pLQHc/diiF
	 2MqhcEbUtsVz4sVeSMJkxYlkzI3XY/ymkKrXUT/KkzHJE527Neh4YQGTec/ngadX2A
	 b2IJ8mRB5KIAAj/x0CyQfPBUeSZZJA2fN8nKUSl4BimBa7aLsxFtu9Ahr35CxaVgpR
	 DjokoIg/bX0n146uH3vHydbs2lbtwrN8ufTvUR56urzsA4M5fVXv6ZWWqAXCUJTC0Y
	 dRHgjqV1/+CxA==
Date: Tue, 4 Aug 2026 15:14:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Sven Eckelmann <sven@narfation.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Simon Horman
 <horms@kernel.org>, b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich
 <sw@simonwunderlich.de>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 00/15] pull request for net-next: batman-adv
 2026-07-28
Message-ID: <20260804151427.48602ee8@kernel.org>
In-Reply-To: <dbd0dc17-d097-4254-b6f0-59eeb6e69579@redhat.com>
References: <20260728133918.643267-1-sw@simonwunderlich.de>
	<5248054.31r3eYUQgx@sven-desktop>
	<37153ad1-5c96-49fc-adee-2a7678414428@redhat.com>
	<4072288.fW5hKsROvD@sven-l14>
	<dbd0dc17-d097-4254-b6f0-59eeb6e69579@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-ID-Hash: W5RJACIPOF75XVU2OKTEXWT4756KSKDF
X-Message-ID-Hash: W5RJACIPOF75XVU2OKTEXWT4756KSKDF
X-MailFrom: kuba@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/W5RJACIPOF75XVU2OKTEXWT4756KSKDF/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Tue, 4 Aug 2026 20:32:21 +0200 Paolo Abeni wrote:
> > Sorry, I am lost. There is stuff for which people have actual PoC code. Afaik, 
> > nothing for an RCE but enough to locally be a minor annoyance. The things 
> > which have no "Reported-by" are things which I have problems with on my 
> > installations.
> > 
> > And about the others: The "bla: avoid CRC corruption due to parallel claim 
> > add" + "prevent CRC corruptions after claim flush" were a problems I had (next 
> > to another which was not yet posted to netdev) but has a "Reported-by: 
> > Sashiko" because it was also reported by Sashiko when posting other bla 
> > patches and I think I've stolen the example from the commit message partially 
> > from the Sashiko report.  
> 
> I'm sorry this is getting more complicated than really intended. The
> rule of thumb is that real problems actually bothering users go into the
> 'net' tree, and other stuff goes into net-next without the fixes tag.

My rule of thumb is "there is no such thing as 'worth backporting but
not worth net'". People tend to send to -next fixes they didn't bother
testing.
