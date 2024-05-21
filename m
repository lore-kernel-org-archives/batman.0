Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F29C25B75
	for <batman@archiver.kernel.org>; Tue, 21 May 2024 07:42:44 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id F10A8825DD
	for <batman@archiver.kernel.org>; Tue, 21 May 2024 09:42:42 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1716277362;
 b=niuQp/BM8u4TflgVwy4tV4TFtj8nwZqDt2Nz71pOBqcVeE4Un0v56rURXMnqJuYJPp/oK
 5bKiEHILexE1d/aQY8LA6o7q7tmEGFKwnrZrkGeWobZDpg8/OpEsTZ7WRJyMYB0RQ90riMX
 FDU/2KiLTfke16Wt0vzFzuGqz+xv8Fk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1716277362; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=bq5w2dOXUmXaYoJcODSZnEnefduxYXuMwA2eq9OQaUA=;
 b=COpMEbAqN4tHpGUlt2cu8w/GjpjTbfOJGjJDE9Nzuquva+OiSfKwRvXtCbLxZfxJ4MfpY
 XcMvi5blv/hF7lV5PrYx/QZBSbhGbbGxaMhbxO3n9H6kR2BYbCJVlyNhziQZc/YJ/Lqq1Ux
 iu2/UxsV1aZMtFPULtw3o3VT2EOynYA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=unstable.cc header.i=a@unstable.cc;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=unstable.cc header.i=a@unstable.cc; arc=pass; dmarc=none
Received: from wilbur.contactoffice.com (wilbur.contactoffice.com
 [212.3.242.68])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 6E31581A52
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 21 May 2024 09:42:32 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1716277352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=bq5w2dOXUmXaYoJcODSZnEnefduxYXuMwA2eq9OQaUA=;
	b=zXJK2y/RLu1Un6KEdcc1MTf+2EVXelZf8bBesJlvyExvkCxuDAU0inWJXecHp7Zw+jk0lb
	801cCZikx1R6kGXUpZR7w2Ipc4luGy0yj3ZE4MwEzH9k0TjatXAB/79L6l2Nnymlurt29B
	hkCEZ+NOEhz/CnQTHttjxWZQZx7LiUI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=fail ("body hash did not verify") header.d=unstable.cc
 header.s=20220809-q8oc header.b=n0Rr0caw;
	spf=pass (diktynna.open-mesh.org: domain of a@unstable.cc designates
 212.3.242.68 as permitted sender) smtp.mailfrom=a@unstable.cc;
	dmarc=none
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1716277352; a=rsa-sha256;
	cv=none;
	b=uo5ISWeJ+1DDiXe2RPfdxXu43ZTW8gt4QlypLT2zRSJY/xQFyCrqlwOX7OwB0m2x0Cf83C
	NnELeVk5ZaehKli5zBA216EE7oTwum8avUtAtbD7DBvBwmD2Yy2taJBiZXUnSsMQ82OlpZ
	WVHqYwy3NJY2GJaTZdBX1lSzrjeDYb8=
Received: from smtpauth2.co-bxl (smtpauth2.co-bxl [10.2.0.24])
	by wilbur.contactoffice.com (Postfix) with ESMTP id 1C6E662B;
	Tue, 21 May 2024 09:42:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1716277352;
	s=20220809-q8oc; d=unstable.cc; i=a@unstable.cc;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	l=806; bh=bq5w2dOXUmXaYoJcODSZnEnefduxYXuMwA2eq9OQaUA=;
	b=n0Rr0cawN+9kwK/ld4MhADhhB/ovjNsZrbSNOP/1cmqTKmB9LLbYztcKxx/iG45B
	8BItVLyL5olFXnSfgXZ/OlPPqLbm2n3lWooU97HUgdBI6twWM1pTtD/6ecg5QumlISP
	Lmkra4a2jae/+hlsnTg3RvdHCo8Vg1FjDy+jxdqhBV9QSPFQ+KQbWxnsT1VbDNg60y1
	7VsQV4ymKsGkCn+u1vgGl93f3DXaWhZp3rfzc1xeOtbgA4iEvOx1fhqqrRxWdV5Hypw
	hvI9iGdsGpg1IseQjzzHfRmHCvMafwlEVhbMYZr5bflQO/uhDvOt/GDwqkKYOuF9eOa
	98nLFdfUNw==
Received: by smtp.mailfence.com with ESMTPSA ;
 Tue, 21 May 2024 09:42:30 +0200 (CEST)
Message-ID: <cef03d6c-7be8-4527-b38b-eadca2789f9b@unstable.cc>
Date: Tue, 21 May 2024 09:43:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: cfg80211: Lock wiphy in cfg80211_get_station
To: Remi Pommarel <repk@triplefau.lt>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
 linux-kernel@vger.kernel.org
References: 
 <983b24a6a176e0800c01aedcd74480d9b551cb13.1716046653.git.repk@triplefau.lt>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: 
 <983b24a6a176e0800c01aedcd74480d9b551cb13.1716046653.git.repk@triplefau.lt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ContactOffice-Account: com:375058688
Message-ID-Hash: SSRWRXA6BBISNUKTCYC457W5FOA7TJQT
X-Message-ID-Hash: SSRWRXA6BBISNUKTCYC457W5FOA7TJQT
X-MailFrom: a@unstable.cc
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/SSRWRXA6BBISNUKTCYC457W5FOA7TJQT/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi,

On 18/05/2024 17:50, Remi Pommarel wrote:
> Wiphy should be locked before calling rdev_get_station() (see lockdep
> assert in ieee80211_get_station()).

Adding the lock is fine as nowadays it is taken in pre_doit and released 
in post_doit (with some exceptions). Therefore when invoking 
.get_station from a side path the lock should be taken too.

It was actually a05829a7222e9d10c416dd2dbbf3929fe6646b89 that introduced 
this requirement AFAICS.

> 
> This fixes the following kernel NULL dereference:

As already said by Johannes, I am not sure it truly fixes this NULL 
dereference though.

Have you checked where in ath10k_sta_statistics this is exactly 
happening? Do you think some sta was partly released and thus fields 
were NULLified?

Regards,


-- 
Antonio Quartulli
