Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 584B8C55182
	for <batman-adv@archiver.kernel.org>; Tue,  4 Aug 2026 02:19:53 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5D656841C3
	for <batman-adv@archiver.kernel.org>; Tue, 04 Aug 2026 04:19:51 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785809991;
 b=ohHFD5x3BJcuxcXbil5MUihxkFqPBYDxr0npRfJ/z0Qi+bi/B/+9LKKAFID5xCTbfciRq
 2oPQ0Z+IqxaeTZ5bApPTLC20uMVCcNIeFGAsvNI5bz5/WyDllBHRv2CRg8gBsdmZKlelEOV
 1AxrnqLx0tDsHkSW6kA4PwpfaghOQGI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785809991; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=P8aSIbkK2BQvZi5dWB854YLDzCXa/yW2NZ0UbGGZBgc=;
 b=uHyKXxKpYERfWArrPDpsTclHJDDmegonJez40+W2lTOF2DVIzT3lvPlDiVQk5RFMu+8cJ
 Cd7VKVnsiNxKnWVpwRMMWKYSjHSK4toZGEHN9S0ChBgnQl56LD+nwSPHDmXe5JbR3/BW5Ws
 utEeOdxdDOFTEOBH0Irbh1JIjaL2oxc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id D980F8072F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 04 Aug 2026 04:19:23 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785809974;
	b=es3XWbJDRdIEQyFN8AqKK1L9XyLWd+y3NrqdcDhzFZNzp0wLpgQivXRXMQmKpJ0B+UKcAR
	n/ibi8qHSmdNYHa5BzZdGpIKMOfM3YheuZKdc1aIvU7AJONcVcciaRarHVUaohUteTXLtV
	N9TA4mGdcA3dBADYYo8XwbNy0G7N7kU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785809974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=P8aSIbkK2BQvZi5dWB854YLDzCXa/yW2NZ0UbGGZBgc=;
	b=cGtK1XhoP5msXSxd8Z5TRebMFxsCAz1933zPtavQSDVgCIqsEDS6uxnvswpmpuYQsK8uH1
	mDICWuP69YkxWeC52N6+gpLdfMGW05ZUXMkuy5BXpD0tJ54c1Wxt4Y1CEjx+OVmaG9or7q
	BZT0aeDHxSQz4vbY97hyME4jOnRkayY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ePBNMRCN;
	spf=pass (diktynna.open-mesh.org: domain of kuba@kernel.org designates
 2600:3c04:e001:324:0:1991:8:25 as permitted sender)
 smtp.mailfrom=kuba@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7B0EB60A59;
	Tue,  4 Aug 2026 02:19:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECAC91F00A3E;
	Tue,  4 Aug 2026 02:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785809961;
	bh=P8aSIbkK2BQvZi5dWB854YLDzCXa/yW2NZ0UbGGZBgc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ePBNMRCN9aRCa3M138IuZ0o6v0EqeQoHK67SqL8vU/tmFxT7PCABtfuc4JxKu2z+P
	 5qS2h5dY6zQ7y59IrbHhT39tVlt4c4nCBh0uVuCsBMCyt7V7f7QDeCYHOgna3Ph0Es
	 bWY2etAeQAZdBPk72gAcqSbm8eegO3/CuMPg9Bqo+8G8JQi6KYUrItUGLTjd7Li8gC
	 Se2JzSfrLv9PbujHRZtxsXeZOvzHz3kgqpBuz+GASjyVqSeMVaftySjnFgOxfg0VjO
	 GWJE3eIoBIywzEpEnMTbIg4kxhdPYZydNysiBSg68tCu/+Efb05Nl8ehTb1/nKspOD
	 9FwX4ZVpP6T4A==
Date: Mon, 3 Aug 2026 19:19:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH net-next 00/15] pull request for net-next: batman-adv
 2026-07-28
Message-ID: <20260803191920.0e6c5a2c@kernel.org>
In-Reply-To: <20260728133918.643267-1-sw@simonwunderlich.de>
References: <20260728133918.643267-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-ID-Hash: WE33FFUWCPFNYLNLKDDRE4XIX3WBSDNE
X-Message-ID-Hash: WE33FFUWCPFNYLNLKDDRE4XIX3WBSDNE
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/WE33FFUWCPFNYLNLKDDRE4XIX3WBSDNE/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Tue, 28 Jul 2026 15:39:03 +0200 Simon Wunderlich wrote:
> here is a minor bugfix/cleanup pull request of batman-adv to go into net-next.

Can you look thru the Sashiko comments here (especially Medium+
severity)?

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260728133918.643267-11-sw@simonwunderlich.de

At a glance patch 14 does not inspire confidence. I guess patch 15
removes the worst part - but is there a real reason not to use locking?
