Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF17D6ED28
	for <batman-adv@archiver.kernel.org>; Thu, 21 Nov 2024 13:14:03 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0ED3C842A2
	for <batman-adv@archiver.kernel.org>; Thu, 21 Nov 2024 14:14:02 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1732194842;
 b=NHLmMqvlXx3/QThOWGC1tzCxibb/j1fJfXtlylDCxB3qeQgCfGPicg5v/oX5qWEFBs7mK
 JxK02TQbVw3due0hPkctodLXzYlgHsPiyt91OUbvytDwtfPumoPBW9wjghD+Qy7OMBTuInf
 ACgG22hB46PccSkmNViVBQONNPbygv8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1732194842; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=dCoY2/G8ywaK6+nmC+/qJNYbuqiAZtCf2VgojuaqS4A=;
 b=OGJmUsP4rKsQZN7MdJ7UxwM/NjCR8ZOC4LQpKVDl3T1BvNXdwWnygd5PaCAG5gQo/Wm/A
 BqLvUZdzNJNaXtPxeaQdVlWt0j8C+whsRvm7SDA6vhlRpbY07zQt0cWMNIf9lkqcm2ctFl8
 jvSGRhBQViOZ1aryNwnGStytO2yCo6E=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=unstable.cc header.i=a@unstable.cc;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=unstable.cc header.i=a@unstable.cc; arc=pass; dmarc=none
Received: from wilbur.contactoffice.com (wilbur.contactoffice.com
 [212.3.242.68])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id CCD5E81A4F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 21 Nov 2024 14:13:47 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1732194827; a=rsa-sha256;
	cv=none;
	b=CERr1xm94W8RIUUB6J3OOCkwlppmHFRl/AavvGOcEi4kvSyVa3KgZUlDhte3F1HHdwLaDY
	6aA6UOt/8dj2CmSmA4HlY7bgpHJZC++dwSR2Qgg/2PRn3XIsFhLWHbipGR3U5UIL/rv9K8
	5AwuwNejsGPlWmuYafJ/5DdXRF2mIUs=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=unstable.cc header.s=20220809-q8oc header.b=C8LL5yBB;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of a@unstable.cc designates
 212.3.242.68 as permitted sender) smtp.mailfrom=a@unstable.cc
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1732194827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=dCoY2/G8ywaK6+nmC+/qJNYbuqiAZtCf2VgojuaqS4A=;
	b=mBnU69Wq1YZEpj495iGCLRuui7jMxnBdI5hwWMyyGblMGLKqMthM+S0weO/Kt9nLjrjRNC
	9XDUa+0qOoJmctZbhmb0UJQgc5iwfiHShmqvF1u66F6j+ZTPB/8VwLoLXeqT2vp5kd7dRJ
	0fzXqA+IkC0EzAVEw73d5L8GJCpxAqU=
Received: from smtpauth2.co-bxl (smtpauth2.co-bxl [10.2.0.24])
	by wilbur.contactoffice.com (Postfix) with ESMTP id 730F84E8D;
	Thu, 21 Nov 2024 14:13:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732194827;
	s=20220809-q8oc; d=unstable.cc; i=a@unstable.cc;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=dCoY2/G8ywaK6+nmC+/qJNYbuqiAZtCf2VgojuaqS4A=;
	b=C8LL5yBBxvPsj3g4yrLGK7feErDQw077o+NNa57CR+EBHEVLZ/pCAXnqaoNULzv5
	cgzWhE3isDwiEQ9okKKap/LlOzDf7tOtD18cSPkbDpvYFE9JKueAA8lGNjEv+2QMRr+
	GPTBE+1fVP7TDVpW7gZbzutBbhFMafyN7GKNl/dKl7BCmSImng+ghSmZTIpfkQsLT0x
	clVTZ9REHZkIxI0UO9keDu8vNeLr5udOLzxrCaUNglBwEH/DpTrgPS6UKSdYXwrJUn2
	CBkWunrr0GB7UD3hj1SozkFT1D7EB2DtcQ34ri9pqdb0GPKYRNT0Fd4I2V694hhzi0r
	zCXr3W5j7g==
Received: by smtp.mailfence.com with ESMTPSA ;
 Thu, 21 Nov 2024 14:13:45 +0100 (CET)
Message-ID: <97132b71-a5c8-42d2-be4c-5e3cf6e7cfe8@unstable.cc>
Date: Thu, 21 Nov 2024 14:14:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] batman-adv: Remove uninitialized data in full
 table TT response
To: Remi Pommarel <repk@triplefau.lt>, b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>, Sven Eckelmann <sven@narfation.org>
References: <cover.1732124716.git.repk@triplefau.lt>
 <0368cc2fc6c7719a40a52eeab3c1c6458fc3ebe4.1732124716.git.repk@triplefau.lt>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: 
 <0368cc2fc6c7719a40a52eeab3c1c6458fc3ebe4.1732124716.git.repk@triplefau.lt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ContactOffice-Account: com:375058688
Message-ID-Hash: 7RETRROZSFDRJP6CDMOBNZMSFRKQHJXQ
X-Message-ID-Hash: 7RETRROZSFDRJP6CDMOBNZMSFRKQHJXQ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/7RETRROZSFDRJP6CDMOBNZMSFRKQHJXQ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On 20/11/2024 18:47, Remi Pommarel wrote:
> The number of entries filled by batadv_tt_tvlv_generate() can be less
> than initially expected in batadv_tt_prepare_tvlv_{global,local}_data()
> (changes can be removed by batadv_tt_local_event() in ADD+DEL sequence
> in the meantime as the lock held during the whole tvlv global/local data
> generation).
> 
> Thus tvlv_len could be bigger than the actual TT entry size that need
> to be sent so full table TT_RESPONSE could hold invalid TT entries such
> as below.
> 
>   * 00:00:00:00:00:00   -1 [....] (  0) 88:12:4e:ad:7e:ba (179) (0x45845380)
>   * 00:00:00:00:78:79 4092 [.W..] (  0) 88:12:4e:ad:7e:3c (145) (0x8ebadb8b)
> 
> Remove the extra allocated space to avoid sending uninitialized entries
> for full table TT_RESPONSE in both batadv_send_other_tt_response() and
> batadv_send_my_tt_response().
> 
> Fixes: 7ea7b4a14275 ("batman-adv: make the TT CRC logic VLAN specific")
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>

I am wondering if acquiring a lock around the entire section can make 
sense. Also in this case it would cover the case where we get an ADD in 
between.

What do you think?

Regards,

-- 
Antonio Quartulli

