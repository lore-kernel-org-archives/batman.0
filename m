Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE6ECD342C
	for <batman-adv@archiver.kernel.org>; Tue,  5 May 2026 00:11:18 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A7CF385893
	for <batman-adv@archiver.kernel.org>; Tue, 05 May 2026 02:11:16 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1777939876;
 b=LLWy8R8mzbbA35uEK0az2p7QhilU7WuAjGJBdpG9QEPcs/C0EIDXFJmb3tyRP/PplstsO
 7BWqEVp6xJ6z4IjTx40fwsjIVGwYqXS71OzQVAumrYpRugysJhEHUH3AN2PdkqNvrAKvBru
 +fnafjUS67dkghoFqALs5jVRFimSCTA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1777939876; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=/ylHvhECoQmKS/mVvR8TDKSZanF19cxrk2pYpMeYbKA=;
 b=EURnCpmoHeLog4Jc4JlDvOXWTWzHhV55GCE5wGzKX6h2E4Xf7gps2/8uTztmBH2sYtN/b
 7VF5JECC16UPJ9ZrbbnGjKA6Ak3DDhik3fMYCkNblxLOp1fD+k7pOm+NnQXjiavSxQtOgZZ
 V7US8K1FmXiGBEkpp7hL/q18k83yVW8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 7712D84B00
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 05 May 2026 02:10:59 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1777939869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=/ylHvhECoQmKS/mVvR8TDKSZanF19cxrk2pYpMeYbKA=;
	b=fFCsowqyRqKzwEySXjdTh3YY5FJWqGJtruodkp+9xygK+QGV7KPOTEwCVTLmnI13JYILJo
	c3gFjQx/ZOkJbsP9rPCvnvmJMRfTx8k41AaRJ/gx3HpW6gI5AY84OZ6I+1q0cwr2VTSrl3
	YfUchv/p+yCJxvNYxH2nTL7D0XtJlBs=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=tB+Kd711;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (diktynna.open-mesh.org: domain of kuba@kernel.org designates
 172.105.4.254 as permitted sender) smtp.mailfrom=kuba@kernel.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1777939869;
	b=rx8WUhrxZkPSAlefp+Tzu1OvT5gR/siRkZVg7zyOe1IMt4iIFJld2PP5eBEaAvb6ZCAq5a
	kzgPHmMHeFWxgRbU1ffeZUx0yzewJ7qzUndGLnJmgewhag5tpKGFa+P2+Me6Bo3dJIMzDi
	Df5q40vgEvByKkGPi0sv2Kq3Ed0rhWQ=
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6ACA2600C3;
	Tue,  5 May 2026 00:10:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF437C2BCB8;
	Tue,  5 May 2026 00:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777939858;
	bh=/ylHvhECoQmKS/mVvR8TDKSZanF19cxrk2pYpMeYbKA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tB+Kd711ScTkE9PbrY/UmMfbYhujRX8TBUgK8prEwdxpxPDvI6knQjFVzENFXDpwJ
	 vQDBYu1BE7R846ogETFlpaktEUBPPUK0vIhWY68nK9at3le9TJw+sIQdMIaiD4d8sl
	 g9QXfuH71HKKXTo8/diK9BrsLNsH5p4435N7NvyfW0qt6tB65EtvjaY1KgDJV2RfTq
	 t34QJD3Le2d7seygeEHdUvest3OTcXySrDDpVVs1itSu2aUYT90WyVCl1qIWhu+7Ak
	 d+TwOIVyj65rXS0wskPIgO8LTKd3lqmhN7RojU3qc1tZNNmPO75YHvWt36bbOnB7Ds
	 xt4u89+qqhaLQ==
Date: Mon, 4 May 2026 17:10:51 -0700
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
Message-ID: <20260504171051.2b3e47ef@kernel.org>
In-Reply-To: <20260503-fixes-followup-v1-0-4313278918d3@narfation.org>
References: <20260503-fixes-followup-v1-0-4313278918d3@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-ID-Hash: HLYUU4B62FSE3DVZBZO6WKCEDH4N5ONK
X-Message-ID-Hash: HLYUU4B62FSE3DVZBZO6WKCEDH4N5ONK
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/HLYUU4B62FSE3DVZBZO6WKCEDH4N5ONK/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Sun, 03 May 2026 14:22:33 +0200 Sven Eckelmann wrote:
> While reviewing the fixes submitted to batman-adv in the recent weeks,
> further problems in similar or adjecent code was identified. This was either
> noticed in the manual review or reported by sashiko.dev.

Are you CCing netdev to get this reviewed by Sashiko?
Please don't..
We delegate code to sub-sub-systems to lower the patch volume :(
