Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2770CDB465
	for <batman@archiver.kernel.org>; Sat, 14 Oct 2023 05:15:40 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1EB5F82E18
	for <batman@archiver.kernel.org>; Sat, 14 Oct 2023 07:15:39 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1697260539;
 b=AannyuqTCVv148MBA7AG9Y/Cc2W2bFEwQBXuDgztqZUdIxKNOTterqU9DZtjt7z4T1+3w
 sMi5J7nwS+Vks0V3UPK4ChxRsb4otLrgDvgbGOIYl52EZbvZIt0eAuH4A/DetfLaAElxYev
 Pgxt35MYbfn6PgLSmWD1OYAX7sqTwDw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1697260539; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=1uT3Iw69G4q9mNAKDxUiVMUPxSlN6kAUY17uEDd7J5A=;
 b=muC30DP1HAW/hs2IvssA9bJ4w7z8g/VlALWv9n+6gqE1EagDL7eKJUnrNRoh13aGyM09l
 iibzrPg64vLyrLdPvdTJUFQkdMlowvKMurj7iqTtmoOP2a85wCSfa3UP4AGl5IPCgNoklAL
 2tgBUKOtEpTfwgQu/nzH/WTSFteTrHo=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de
 [IPv6:2a01:4f8:c2c:665b::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 221AD8007A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 14 Oct 2023 07:15:18 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1697260518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1uT3Iw69G4q9mNAKDxUiVMUPxSlN6kAUY17uEDd7J5A=;
	b=zVQUJ9HHcjnynrw4VSkKJ+FEDJ16PegpLg+KAfutzAN/jYNDIsUeFfYbUBzMmhCuT3hG+e
	mRu3uh2dn6fkRZEFQtNih9p2kgPZVHAv8VUgGb/v0O02RAwSYfHrx8lsUgigf8RaZBb9oe
	0SyMxukDVWSDP+q4er8rfQRzgn5DEOw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 2a01:4f8:c2c:665b::1 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue;
	dmarc=none
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1697260518; a=rsa-sha256;
	cv=none;
	b=vHvktCbAYapLxbm+I9+G60wLy4Y5uZj5VL+V2PxML0egVuepnGzfovcGgei18t7eGLrf97
	Huda62+EiH4aivmVQEhROSxf1i85wcbjG0x/cdH4957hvsMzmSyrvqGhCIbkkEtzu905xj
	HWXsi916EyfLGejC7ZTbaqttesF+jnU=
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B8B0F3F039;
	Sat, 14 Oct 2023 07:15:14 +0200 (CEST)
Date: Sat, 14 Oct 2023 07:10:28 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: Remi Pommarel <repk@triplefau.lt>
Subject: Re: [PATCH RFC 2/2] batman-adv: Better half duplex penalty estimation
Message-ID: <ZSoixFsJi5vYCRxh@sellars>
References: <cover.1695904299.git.repk@triplefau.lt>
 <09c086e5e68055e52d1f92ba17d0e921084107e7.1695904299.git.repk@triplefau.lt>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: 
 <09c086e5e68055e52d1f92ba17d0e921084107e7.1695904299.git.repk@triplefau.lt>
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: 3SSHU5Z2MO4NOEYQB6CKLPPRVORXOTHL
X-Message-ID-Hash: 3SSHU5Z2MO4NOEYQB6CKLPPRVORXOTHL
X-MailFrom: linus.luessing@c0d3.blue
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: b.a.t.m.a.n@lists.open-mesh.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/3SSHU5Z2MO4NOEYQB6CKLPPRVORXOTHL/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi,

Thanks for taking your time to look into this and the detailed
explanations!

Generally, the issues both patches try to address make sense to me.


On Thu, Sep 28, 2023 at 02:39:36PM +0200, Remi Pommarel wrote:
> Let's consider the below topology
[...]
> However the following formula seems to be a more realistic approximation
> of PT_ac:
> 
> PT_ac =  PT_ab * LT_bc / (PT_ab * LT_bc)

Typo, I guess, as this would always be 1? What is actually
implemented makes more sense to me.

[...]
> -	return min_t(u32, lth, oth);
> +	/* OGM throughput was divided by two for retrocompatibility sake */
> +	oth *= 2;
> +	return oth * lth / (oth + lth);

Could we end up here with a (forged?) OGM that has both the new
half duplex flag set and a throughput value of 0? While also
having an lth of 0, therefore dividing by zero here?


In the following scenario:

+-------+  ch.1  +-------+   ch.2  +-------+   ch.2  +-------+ 
| Orig0 | <----- | Orig1 | <------ | Orig2 | <------ | Orig3 | 
+-------+   300  +-------+  30000  +-------+    110  +-------+ 
                     ^                                   |   
                     |                ch.3               | 
                     +-----------------------------------+ 
                                      100

Would the results on Orig2 to Orig1 be these?
- via Orig2: 300*110 / (300+110) = 80.5
- via Orig1: 100  <- selected

While it should have been this?
- via Orig2: 30000*110 / (30000+110) = 109.6 <- selected
- via Orig1: 100

But we can't calculate the latter on Orig3, because we don't
know the two hop neighbor link throughput? Or am I missing
something?


Also, this seems to assume that time slices are divided equally.
That's probably only be true for WiFi drivers that have airtime
fairness changes integrated? So only recent versions of mt76,
ath9k and ath10k? Has anyone verified that this works fine not
only in AP but also in 11s mode?

And a third concern, but we'd probably have this issue with both
our current and your suggestion: Would we be off again 802.11be
and its "Multi-Link Operation" in the future?

Regards, Linus
