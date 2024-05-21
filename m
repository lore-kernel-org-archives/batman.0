Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 399CBC25B75
	for <batman@archiver.kernel.org>; Tue, 21 May 2024 07:12:48 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 6E857825C5
	for <batman@archiver.kernel.org>; Tue, 21 May 2024 09:12:46 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1716275566;
 b=UFnK/1CIhoeUf/UoOgYWZ1AHTZEeEo1HiqLIzz8aLPRKUXLfV4RdXOXwj4KAX/BOTJs+G
 OYdRGfVHyjIROxEQoFsuGZHsTkkREHmjFN6dzFIVsCktip8ejIDlUBtGQwV6sR6wI+JX0Qz
 RqMzjkJNygfyu9sZWLLBHeZVaquPj/k=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1716275566; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=kDc7UT5LoZBe6PeytpnUZ/gKC0Dp4tl9wAP7S5bANS0=;
 b=f72WegVBYVxBIeMpDQTIMI6zUAQYQsN07cRmTNU4dwEJIxcEsitJSH1XnEPBkLv/coxPR
 pO+c1lJiHtgWR69f/HTWgcUlZWlalKx3zXDlamDATDaaOkNH7ZsFb/3hX2guxG//1UFqU/R
 /cikPuaPEkj8DeGlmfxhrfhr8kWLY5U=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=sipsolutions.net;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=sipsolutions.net
 policy.dmarc=reject
Authentication-Results: open-mesh.org; dkim=pass header.d=sipsolutions.net;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=sipsolutions.net policy.dmarc=reject
Received: from sipsolutions.net (s3.sipsolutions.net
 [IPv6:2a01:4f8:242:246e::2])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id F102981A52
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 21 May 2024 09:12:29 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1716275554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=kDc7UT5LoZBe6PeytpnUZ/gKC0Dp4tl9wAP7S5bANS0=;
	b=HWV7T8h+jagSF1skr1HeV98VBVcXtzB/ibRHmuuODPEauXeRsmC0zDqMcVWHmxFO8nH2Uv
	Eh18rlUx7drTr827nS6DkH7O6MWYR4QaXGJ8yjmSvcG3JH7ShDCmZ+JC7eyoy9aR5Z/M1y
	ZUG8QggcvJFpX25w6HMkQcTbWCMidGU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=BdN8caZS;
	spf=pass (diktynna.open-mesh.org: domain of johannes@sipsolutions.net
 designates 2a01:4f8:242:246e::2 as permitted sender)
 smtp.mailfrom=johannes@sipsolutions.net;
	dmarc=pass (policy=none) header.from=sipsolutions.net
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1716275554; a=rsa-sha256;
	cv=none;
	b=iU3fMtV3ePAoVBHuZGgXqYEwoJzqPa3Z8jVX5auDAN/503I0w5JsJ7LyKr1ci39U9lLeGx
	ApVmhXY72vhnz5ElMNgzheKUS+T9AMp6mr3UcS83aTlIKvXIZIcp2kPQMuxeJiC9Lb5ruK
	kl8resbSNP9ocBP3JNYQI92+1uKfczw=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=kDc7UT5LoZBe6PeytpnUZ/gKC0Dp4tl9wAP7S5bANS0=;
	t=1716275549; x=1717485149; b=BdN8caZSyIu15ramIsDaOmD4mkQub2lq+LTp1BxPo5ZyBaW
	Mjnz3DnsvlLOdQrP2bg8XoJwWDr5BrhT+4hETBcAIgI78MSTjv3k/nn4rQ559LD3gsCmqq4fAgPVK
	2NpfTe47j8WVUPZ03zkAr6pbJriezmzErL1Vkpvl83FRYGH1MIuEnjbCLK/7uodahaDeokWtUdaU/
	nAomeRMqWqmNxu+u7+SPLmoVpiba5ct2Gd5ItgzItA9LfAKetDsspztW8O73v/kU4peggVskeoVdW
	tGJUCu5EKvRpOCIfC8WiRMQX8i60QQcSzP2k31JtYQ1IdcqLEapdUibtVTh0mjzQ==;
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s9Jfg-00000001uhb-32p0;
	Tue, 21 May 2024 09:12:28 +0200
Message-ID: <0f42ab000dc2cdaf7a9b781a9ca7dad9478b705f.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: cfg80211: Lock wiphy in cfg80211_get_station
From: Johannes Berg <johannes@sipsolutions.net>
To: Remi Pommarel <repk@triplefau.lt>
Cc: Antonio Quartulli <antonio@open-mesh.com>,
 linux-wireless@vger.kernel.org,  b.a.t.m.a.n@lists.open-mesh.org,
 linux-kernel@vger.kernel.org
Date: Tue, 21 May 2024 09:12:26 +0200
In-Reply-To: 
 <983b24a6a176e0800c01aedcd74480d9b551cb13.1716046653.git.repk@triplefau.lt>
References: 
	<983b24a6a176e0800c01aedcd74480d9b551cb13.1716046653.git.repk@triplefau.lt>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Message-ID-Hash: YRQCC7W4DYTZUSMTCESEJR4BAVMMX26F
X-Message-ID-Hash: YRQCC7W4DYTZUSMTCESEJR4BAVMMX26F
X-MailFrom: johannes@sipsolutions.net
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/YRQCC7W4DYTZUSMTCESEJR4BAVMMX26F/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Sat, 2024-05-18 at 17:50 +0200, Remi Pommarel wrote:
> Wiphy should be locked before calling rdev_get_station() (see lockdep
> assert in ieee80211_get_station()).
>=20
> This fixes the following kernel NULL dereference:

How do you get a NULL pointer dereference from a locking issue? Was
something else removing the station simultaneously?

johannes
