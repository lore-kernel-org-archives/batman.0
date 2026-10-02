Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71636CA5FDD
	for <batman@archiver.kernel.org>; Fri,  2 Oct 2026 16:35:34 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C267384432
	for <batman@archiver.kernel.org>; Fri, 02 Oct 2026 18:35:32 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1790958932;
 b=ReF+63rThwjqbid9q76aiVv6+NpejojC8ox48NadSS3r2FccYYCjNIWW/k8v5njyf6zlK
 VDuQmDywIVj2pLTQKcCFK+JIUVojnpRDEmwd/Y94IQYtW6BXOYbf2U1y1rWTqaoZgCtVUWy
 dMOpAiXdumYj8Om5DCoakQJLd96QHAU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1790958932; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=6y85JcSQIdsP9psZ4BHpBLy4jt82ixcCTEhhUoi1EaE=;
 b=l9RC0FfXe57Jm7jE6ys0k/VN1vC1Vnxrm/bbUBmDD3Y411nArNUJmWnVAI71rwWZofte6
 WyqfBWAwXianV8xGz6BEUMGunntxbjgXlvmHTUimm6cdFBHMzQQV2pmPXpclvmO1VsAuVZM
 0969rb8654HpiWQAYjX+Eqrzlp3ZjOU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 8F7F58113B
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 02 Oct 2026 18:35:23 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1790958923;
	b=y6lcZDUEAKEfsotcBfMItxd8X7ZP0OiayseJKRv/9L6vY1gulsUJJGYVrXzI2tLfEvV+5N
	Ux07l6HDKbrWofnS+dKVAlYvtxodnhS5EAmLesDADZZaP7tYZUwTAKBCMH7lHIwLDgc52d
	Pdeq4UIN7Tps5T0inOaXyGrKgw0v0ZM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1790958923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=6y85JcSQIdsP9psZ4BHpBLy4jt82ixcCTEhhUoi1EaE=;
	b=zys75Os3/GqS7kN+p/30cGxYr5dpUP1ydtyRitkGes/lijgbt0xA+xEjToZQfxQ9dM4nDs
	UKVDWBHnN/d76/UDcpfL8TUWeguyHk4bDKEnQoWeypVFtJqpsFTeR1qoDLDr/RPaKPIxcd
	YuZTjLI2z39bVmH6n9Uo71SvPKkU4zw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=nYgs5PCe;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 370EB20292;
	Fri, 02 Oct 2026 16:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1790958922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6y85JcSQIdsP9psZ4BHpBLy4jt82ixcCTEhhUoi1EaE=;
	b=nYgs5PCeh1BpwoLaOP2A+qjQtpLCf6uxZHun+h7ZL+cylw2A9YHjFKxO7LiznpmmuiVqdl
	kKe96veQfknjtNh0DulsmWcpaepoKqrIy/0rjvsXN6vC1SgBGj4CNIHQ7cFk7wTQa4jgBh
	ma2Ke3qvz7mM67xwLWerGGcw5sSGY+Y=
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de, netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 5/9] batman-adv: tt: only queue local del event
 after
 successful unlink
Date: Fri, 02 Oct 2026 18:35:19 +0200
Message-ID: <1871974.VLH7GnMWUR@sven-desktop>
In-Reply-To: <179084942832.434549.10138352246210429649@kernel.org>
References: <20260930094558.3723766-6-sw@simonwunderlich.de>
 <179084942832.434549.10138352246210429649@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8783657.NyiUUSuA9g";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: EBFCIZMZZASLUVWYJVLAY4RW36VEXSKF
X-Message-ID-Hash: EBFCIZMZZASLUVWYJVLAY4RW36VEXSKF
X-MailFrom: sven@narfation.org
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/EBFCIZMZZASLUVWYJVLAY4RW36VEXSKF/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart8783657.NyiUUSuA9g
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de, netdev-bot+sashiko@kernel.org
Date: Fri, 02 Oct 2026 18:35:19 +0200
Message-ID: <1871974.VLH7GnMWUR@sven-desktop>
In-Reply-To: <179084942832.434549.10138352246210429649@kernel.org>
MIME-Version: 1.0

On Thursday, 1 October 2026 12:10:28 CEST netdev-bot+sashiko@kernel.org wrote:
[...]
> [Severity: Low]
> 
> This isn't a runtime bug, but should this have a Fixes: tag?
> 
> The problem seems to come from bbfb0d2cf035 ("batman-adv: tt: remove only
> the entry which was looked up from the hash"). That commit changed the
> unlink in batadv_tt_local_remove() from batadv_compare_tt to
> batadv_compare_tt_entry. It kept the unconditional delete event in front
> of the unlink.

No, this is not causing the "problem" and was there since a very long time. 
And the change is not suitable for stable backports. And since it is submitted 
for net-next, I am not allowed to add Fixes: or Cc: stable@ tags.

[...] 
> [Severity: High]
> 
> Does this reordering open a new window in which a replacement entry's add
> event gets dropped?
[...]
> 
> Could the delete event instead be queued inside the same bucket list_lock
> critical section as the unlink, and only when this exact object was
> found? batadv_tt_local_set_pending() in "batman-adv: tt: queue local DEL
> event under bucket lock" already takes list_lock and then
> changes_list_lock in that order.
> 
> [ ... ]
> 
> 

Noted in https://www.open-mesh.org/issues/475 as potential further work to 
harden the code path further.

Regards,
	Sven
--nextPart8783657.NyiUUSuA9g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCar/dRwAKCRBND3cr0xT1
y2EzAQDmXdo+RAxmJzrMeTdH6auDbcFHkjbSGBnXQo4/y9ggqgD/ZHwBzUqI7/zX
mQc7ULoMCUvdgpueMxEdNM1CI4vyNwc=
=OUCj
-----END PGP SIGNATURE-----

--nextPart8783657.NyiUUSuA9g--



