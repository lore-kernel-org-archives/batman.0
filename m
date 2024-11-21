Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6548AE64012
	for <batman-adv@archiver.kernel.org>; Thu, 21 Nov 2024 20:55:47 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id CF8C08430B
	for <batman-adv@archiver.kernel.org>; Thu, 21 Nov 2024 21:55:45 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1732222545;
 b=u6pkflXAlfD81qB7tv2KlMLFbKQ0wof+gS2ivJktFPCF/Qs4JJv3b1aCfR03gxHiHTAf0
 SyEZgzOjtH7RpNSmLWUwb31SaRQiZqyvpxfNu5pg/qHkJs9DIPxKxDX24dTyoReS6FgeIRh
 tw6nykTOqw9ZKfmhnq/vioInN64518g=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1732222545; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=A18Aij5tlT9MlIdj6OiOduv0XydeDK+AJ9/ODg+LRJg=;
 b=jfmERa4lHW7HfWiVKFJgla83YBvJtXZTop92QYGRSOXCt3+eVkHsvpbGNjjg96yGbdCmt
 /IlaLzObmm7LPYBGI0uhImqQdTAep3fJI55lxcJIMB5yCtqijmX1KLg5q5Whdm4LmwSyENP
 wH99dc8rrl6Yc6kAbCTR2fjvlL3ZMBg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=unstable.cc header.i=a@unstable.cc;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=unstable.cc header.i=a@unstable.cc; arc=pass; dmarc=none
Received: from wilbur.contactoffice.com (wilbur.contactoffice.com
 [212.3.242.68])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id E973781A4F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 21 Nov 2024 21:55:32 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1732222533; a=rsa-sha256;
	cv=none;
	b=X4uhvzzb0o6FSDKFKWvCRPH0aXhrAVPEe+YMbvQWoMi6gltD49hX3AEHLOFIwAN0l7zq6Z
	QlGhOqjYWDIixKtbOy9QxSzynfdQJTalW4K5FRCDU7aWZH03aii9dQVQZZIkyaLLb1/Jba
	S6sN3hUm208Ju1UewnksbbbMLRI/CF0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=unstable.cc header.s=20220809-q8oc header.b=oTUdRnXD;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of a@unstable.cc designates
 212.3.242.68 as permitted sender) smtp.mailfrom=a@unstable.cc
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1732222533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=A18Aij5tlT9MlIdj6OiOduv0XydeDK+AJ9/ODg+LRJg=;
	b=wvSilAkRN3ta7Yl5GPt896bnPxxB98T874+UjGRx236oEXTT8+1rnWsOrrAfvgqGn6CD2E
	4P++Ewj2xlP+/s2HHwteJpFnmjY+d5rRTfpehuKicSQDLaPuuAGdZ5KXnmKdhfqhscMcuX
	MVH3cmMIvXprmfX402qYZvgqIKIBLCQ=
Received: from smtpauth2.co-bxl (smtpauth2.co-bxl [10.2.0.24])
	by wilbur.contactoffice.com (Postfix) with ESMTP id 8239E6963;
	Thu, 21 Nov 2024 21:55:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732222532;
	s=20220809-q8oc; d=unstable.cc; i=a@unstable.cc;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=A18Aij5tlT9MlIdj6OiOduv0XydeDK+AJ9/ODg+LRJg=;
	b=oTUdRnXDdYKma5Q1hCgz4ZScrltKtQkAjVoPGnj0ZrWNVe3r2aG+T72pevqRGje4
	el4/YvglVRKXIdTI6q1nnambxfEa1wobHOZ/26yL/Qh3RJR6L22249pqznT3eoobBiS
	XK2Lc0oCOT+SZVlL6zDEtui4dHqEa8JZp20MBNlcw/BZM+q6170Q/GhbvfhNSvO3aXJ
	HTuh2ew6znOrptG41y111V+5ttJiqIOpZGBIS3thuAj2fIbceYAF8dY7SMnCUpHCI4v
	n0u0jFEiiqEtX/6Ah1u/8XFjqxzopr48mRzdhwoVJa5ZO/MEZiRgrkuVmQlgTnOKumD
	OCT2l6Pt4g==
Received: by smtp.mailfence.com with ESMTPSA ;
 Thu, 21 Nov 2024 21:55:29 +0100 (CET)
Message-ID: <b6a8d38b-6d7c-4e33-9b73-016244092263@unstable.cc>
Date: Thu, 21 Nov 2024 21:55:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] batman-adv: Remove uninitialized data in full
 table TT response
To: Sven Eckelmann <sven@narfation.org>, Remi Pommarel <repk@triplefau.lt>,
 b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>
References: <cover.1732124716.git.repk@triplefau.lt>
 <0368cc2fc6c7719a40a52eeab3c1c6458fc3ebe4.1732124716.git.repk@triplefau.lt>
 <97132b71-a5c8-42d2-be4c-5e3cf6e7cfe8@unstable.cc>
 <7877322.lvqk35OSZv@ripper>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: <7877322.lvqk35OSZv@ripper>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ContactOffice-Account: com:375058688
Message-ID-Hash: AJA7D5WL2QWRYPOLZDR6X32YBVHQLB4Q
X-Message-ID-Hash: AJA7D5WL2QWRYPOLZDR6X32YBVHQLB4Q
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/AJA7D5WL2QWRYPOLZDR6X32YBVHQLB4Q/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>



On 21/11/2024 19:20, Sven Eckelmann wrote:
> On Thursday, 21 November 2024 14:14:13 CET Antonio Quartulli wrote:
>> I am wondering if acquiring a lock around the entire section can make
>> sense. Also in this case it would cover the case where we get an ADD in
>> between.
>>
>> What do you think?
> 
> So you would change the hash with its per-bucket spinlocks to a global
> spinlock? Just imagine that I am now locking angry at you. Especially because
> I still hear the people asking for a migration from the batadv hash the
> rhashtable.

argh - true.
We have a per-bucket lock and not one lock for the entire table, hence 
my suggestion is not valid.

Ok, I take that back :)


-- 
Antonio Quartulli

