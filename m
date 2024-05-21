Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF1F5C25B74
	for <batman@archiver.kernel.org>; Tue, 21 May 2024 14:50:43 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D8AA882600
	for <batman@archiver.kernel.org>; Tue, 21 May 2024 16:50:41 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1716303041;
 b=Gd7WJWtj6cT2K87QAjM+Iahku/wdmN4otF87mpaNRNgFSvr3oRapYcGDnNOIYc9kClooN
 JNIIj53o/7tQzu7wjPFOqNv3G5NiiQEpa4sry3H9DJVVshcLm2C3nsSWIf4TjN3xTALUZX5
 8drXux4ttbhsQAIHcBX81gpmzKwOtVc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1716303041; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=MTWDyIfN1nMlCSjPE8NjqxUc6JP4iiU+F5dmQzZPITE=;
 b=FeUWjfzBR/tsSiNqir4RfYxAo3dIVG98TApYQf06QgxYLFgavfSodtqlPA9ewpOA/GRWh
 GvRtSkzow6lYDyH5awUPUduewNt9ylelFaFDBAX62BsGGNTjv1Oxgoyhysxabwu3CIfVPBg
 ufTOY81a3sTo4UtuuG/7iNJRKFVUbQ0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=unstable.cc header.i=a@unstable.cc;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=unstable.cc header.i=a@unstable.cc; arc=pass; dmarc=none
Received: from wilbur.contactoffice.com (wilbur.contactoffice.com
 [212.3.242.68])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 467F78190A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 21 May 2024 16:50:29 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1716303029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=MTWDyIfN1nMlCSjPE8NjqxUc6JP4iiU+F5dmQzZPITE=;
	b=MedeWfoPcZerrj6z/BcMGMrDCWmCk25qWPci3qcysogWybVcs7XeWv56IWp76f+uvtjo5u
	091eAW3SAZCn79zLLb57zULcOrFXslDWZQ0rTBVbrH9/TByjRwuk/4qhDHn2hOYWgsEfMa
	6T7Ic93f+drjexYyzdljm2BmthQtJHU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=fail ("body hash did not verify") header.d=unstable.cc
 header.s=20220809-q8oc header.b=g1r8ZGJC;
	spf=pass (diktynna.open-mesh.org: domain of a@unstable.cc designates
 212.3.242.68 as permitted sender) smtp.mailfrom=a@unstable.cc;
	dmarc=none
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1716303029; a=rsa-sha256;
	cv=none;
	b=QmzLw20H1+LHqIIHhIj/bInakPeYtdmJghhBj+EEkAr7UQ26GA8Ko/Jf12++7FaGZM4xMN
	N5YmEpOn+GWNnwgi02Y5mQ0yKAq2o/e6SEFHW/5glDDKAYosSKMbQ4Xb4oHGRPGPeNKQE7
	ppHj1Jc03tUMrO6cxwcEYtXWZHQQUns=
Received: from smtpauth2.co-bxl (smtpauth2.co-bxl [10.2.0.24])
	by wilbur.contactoffice.com (Postfix) with ESMTP id 085FC8BB;
	Tue, 21 May 2024 16:50:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1716303029;
	s=20220809-q8oc; d=unstable.cc; i=a@unstable.cc;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	l=2420; bh=MTWDyIfN1nMlCSjPE8NjqxUc6JP4iiU+F5dmQzZPITE=;
	b=g1r8ZGJCvPKEJVDzNsmbjEr/8t9llqk4+N4hhyd59SoskJ/tnKd4gw9bnZX1W6hg
	cPhrz8+vGFbnC35LOKEaLPQKAWyhQgt7BfFJXtR0KmBaq7gQKcGwni4OWTnc58Apppv
	IbRZkeccQZZNu3+5fcK2mC6sInP0giNjk3KIv03+uwMRRzzZg4lhbFezthDktl4QDXo
	abDSwkVIRsKI0HcfHKtVobpCTvf6QgXBJzR4/XatSr93KNA7NvZduB9/mBvhaN5ps0x
	Deod4iTikmSVuIUxgWdW1A5lTTJxiW9fL6HfHUibzLyWMfGEDJhhORiZRm1LRGW2QgG
	/aLeLJILNQ==
Received: by smtp.mailfence.com with ESMTPSA ;
 Tue, 21 May 2024 16:50:26 +0200 (CEST)
Message-ID: <e9a67bc5-4abe-4a91-b2ca-26e64e2abac3@unstable.cc>
Date: Tue, 21 May 2024 16:51:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: cfg80211: Lock wiphy in cfg80211_get_station
To: Remi Pommarel <repk@triplefau.lt>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
 linux-kernel@vger.kernel.org
References: 
 <983b24a6a176e0800c01aedcd74480d9b551cb13.1716046653.git.repk@triplefau.lt>
 <cef03d6c-7be8-4527-b38b-eadca2789f9b@unstable.cc> <ZkyQfL6JjJBTHtwN@pilgrim>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: <ZkyQfL6JjJBTHtwN@pilgrim>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ContactOffice-Account: com:375058688
Message-ID-Hash: 5HFO2BQM7YTZOFCEWRVO2GVJWJ7KHCRT
X-Message-ID-Hash: 5HFO2BQM7YTZOFCEWRVO2GVJWJ7KHCRT
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/5HFO2BQM7YTZOFCEWRVO2GVJWJ7KHCRT/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi,

On 21/05/2024 14:15, Remi Pommarel wrote:
> On Tue, May 21, 2024 at 09:43:56AM +0200, Antonio Quartulli wrote:
>> Hi,
>>
>> On 18/05/2024 17:50, Remi Pommarel wrote:
>>> Wiphy should be locked before calling rdev_get_station() (see lockdep
>>> assert in ieee80211_get_station()).
>>
>> Adding the lock is fine as nowadays it is taken in pre_doit and released in
>> post_doit (with some exceptions). Therefore when invoking .get_station from
>> a side path the lock should be taken too.
>>
>> It was actually a05829a7222e9d10c416dd2dbbf3929fe6646b89 that introduced
>> this requirement AFAICS.
> 
> IIUC lock requirement was already there before this commit, only it was on
> rtnl lock to be taken instead of wiphy one.

You're right.

> 
>>
>>>
>>> This fixes the following kernel NULL dereference:
>>
>> As already said by Johannes, I am not sure it truly fixes this NULL
>> dereference though.
>>
>> Have you checked where in ath10k_sta_statistics this is exactly happening?
>> Do you think some sta was partly released and thus fields were NULLified?
> 
> ath10k_sta_statistics+0x10 is associated with the arsta->arvif->ar
> statement. It crashes because arsta->arvif is NULL.
> 
> Here is a scenario that explains the crash where the same sta
> disconnects then reconnects quickly (e.g. OPEN network):
> 
> 
> CPU0:                                       CPU1:
> 
> batadv_v_elp_periodic_work()
>   queue_work(batadv_v_elp_get_throughput)
> 
>                                              ieee80211_del_station()
>                                              ieee80211_add_station()
>                                               sta_info_insert()
>                                                list_add_tail_rcu()
>                                                ath10k_sta_state()
>                                                 memset(arsta, 0, sizeof(arsta))
> batadv_v_elp_get_throughput()
>   cfg80211_get_station()
>    ieee80211_get_station() <-- Find sta with its MAC in list
>     ath10k_sta_statistics()
>      arsta->arvif->ar <-- arsta is still zeroed
> 
> 
> In other words if the same sta has enough time to disconnect then
> reconnect before batadv_v_elp_get_throughput get scheduled, sta could be
> partially initialized when ath10k_sta_statistics() is called. Locking
> the wiphy ensure sta is fully initialized if found.
> 

We were just wondering how you could get the arvif being NULL and your 
explanation makes sense.

This said, holding the lock is required when invoking get_station via 
netlink, therefore it's meaningful to hold it even when side invoking it 
from another module.

Acked-by: Antonio Quartulli <a@unstable.cc>


-- 
Antonio Quartulli
