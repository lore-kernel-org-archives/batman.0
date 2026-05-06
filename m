Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D818BFF8855
	for <batman-adv@archiver.kernel.org>; Wed,  6 May 2026 00:20:40 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2638480743
	for <batman-adv@archiver.kernel.org>; Wed, 06 May 2026 02:20:39 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778026839;
 b=mdXtvZxqrpq0Ukzx2bZgp9dp8kcZ3gcs70qDAMNvnkAhp19OzuG1cCDlrmDJqt4wM+auG
 DZymfKifWiq6fSMpekEwF7s/EIzMHjgFG8GAPY9/6c5lIkEQ8FiiSPlTqIvAbS7EDcOHdIe
 3u8C0+WrRGEVDDWRStOjAqFjf/DzSR8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778026839; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=E2NFx2jQ1Z0U8+1i8TRf9c2ntA2Yo8yOzbYfTfdNQJM=;
 b=YNF9Fg3pi0VxrVFNjYglMzCpYoNLGRRJsujoFUhG5+0WL1smAmczowNjlRkeAOY5fpa71
 klTbcOXFPwT9Q5ehVT4qneItrDEt2g0aSsjiG4snZV4W2NgaFSS2pIcLqXI36IAZZkXGeCJ
 mi2IKm9AwrEp0gAk1Or8w84x5c5HfW8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 27723805A5
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 06 May 2026 02:20:20 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778026831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=E2NFx2jQ1Z0U8+1i8TRf9c2ntA2Yo8yOzbYfTfdNQJM=;
	b=di2pfHcmsM1fjntEXioegT2//b1WBh9lfonlmR8mGac+yKjuYaujPAobD8tvsfTSORDKBk
	yKfPuCQYIBTFhUwuPcwdaDxWlKsPonVSP4PevBB1E+FF6Tgl57YpfThOzOLzxEoXVqwe8E
	TsHL1HjJOIahw2vI7nS2olnp9AtmFFM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=YhP8M1a+;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (diktynna.open-mesh.org: domain of kuba@kernel.org designates
 172.105.4.254 as permitted sender) smtp.mailfrom=kuba@kernel.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778026831;
	b=HPNiaqqM4pQzs3ME/nYPFBGP9NKLt5VEOfOQp2VQNWkDXXnZRMVfBc6fEntROWBcoUtAvf
	oiw2wQcqF6Lmwuhs4pjX/q1U71LmnVuqmTWTkZZ+6AE4Tn0IDRgl4XBSDcxa2C070nNcLR
	+RpdLu5O4//l0vxuXyatWcZSdoq+u6E=
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8690E60123;
	Wed,  6 May 2026 00:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669EAC2BCB4;
	Wed,  6 May 2026 00:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778026819;
	bh=vYax8JSZ0er4C7oSsAtrxOvM9sWuGJ0NNDFrdh9Hbq4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YhP8M1a+9928xQWiO3gXJPrLYm1pVeIm8DDYtGoQ5ASM2eo6NKiow1lTV/0wiEmx8
	 VZz5MPes/YaBH3ocnwoygvkFPL8aYKLlOmNgF0r4TyVsjOH+bvxE2Ivp4hPF+jEj6k
	 g68a4S2L6kvAC24YZfsq1wrz1keViHAipbOmf+BKxRAP7G8b/5hPceWPVs/G97L13V
	 EbdPHN6oG0PpHwiWYlftk1A9xQEDHx8sss6Qjev8DCo3FN5rcj75S56hXVBUC8UMN9
	 0H+pCH7NCNnCeTYlDnr7A5yk07GCqdpe4ikABvD2/iz5uxbsbsSms468z9X1/L/1K+
	 +HuzmhVNllnbQ==
Date: Tue, 5 May 2026 17:20:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sven Eckelmann <sven@narfation.org>
Cc: Marek Lindner <marek.lindner@mailbox.org>, Simon Wunderlich
 <sw@simonwunderlich.de>, Antonio Quartulli <antonio@mandelbit.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ao Zhou <n05ec@lzu.edu.cn>, Haoze Xie
 <royenheart@gmail.com>, Jiexun Wang <wangjiexun2025@gmail.com>, Juefei Pu
 <tomapufckgml@gmail.com>, Luxing Yin <tr0jan@lzu.edu.cn>, Ruide Cao
 <caoruide123@gmail.com>, Xin Liu <bird@lzu.edu.cn>, Yifan Wu
 <yifanwucs@gmail.com>, Yuan Tan <yuantan098@gmail.com>, stable@kernel.org
Subject: Re: [PATCH batadv 0/8] batman-adv: follow up fixes
Message-ID: <20260505172017.6caf7347@kernel.org>
In-Reply-To: <5990011.DvuYhMxLoT@sven-l14>
References: <20260503-fixes-followup-v1-0-4313278918d3@narfation.org>
	<20260504171051.2b3e47ef@kernel.org>
	<5990011.DvuYhMxLoT@sven-l14>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-ID-Hash: BPDGVYFP7QYZKU4SCJSN37IIHCAUCD7P
X-Message-ID-Hash: BPDGVYFP7QYZKU4SCJSN37IIHCAUCD7P
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BPDGVYFP7QYZKU4SCJSN37IIHCAUCD7P/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Tue, 05 May 2026 06:46:11 +0200 Sven Eckelmann wrote:
> On Tuesday, 5 May 2026 02:10:51 CEST Jakub Kicinski wrote:
> > On Sun, 03 May 2026 14:22:33 +0200 Sven Eckelmann wrote:  
> > > While reviewing the fixes submitted to batman-adv in the recent weeks,
> > > further problems in similar or adjecent code was identified. This was either
> > > noticed in the manual review or reported by sashiko.dev.  
> > 
> > Are you CCing netdev to get this reviewed by Sashiko?
> > Please don't..
> > We delegate code to sub-sub-systems to lower the patch volume :(
> 
> Because of `b4 prep --auto-to-cc`. Will now manually remove you.

Ah, I see. I was asking because I don't recall us getting much batadv
patches CCed to netdev. Maybe it's simply because there wasn't that
many of them to begin with.

If the rate keeps up let's add an X: to MAINTAINERS to avoid
netdev@ being CCed. IDK if that's what X is supposed to be used for 
but we use it for wireless and bluetooth already. The PRs still
flow thru networking tree, but there's no need for netdev to be CCed
on 99% of the patch submissions.
