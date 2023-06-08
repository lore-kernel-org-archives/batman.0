Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 719B1C7EE23
	for <batman@archiver.kernel.org>; Thu,  8 Jun 2023 09:34:49 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 088DD8174B
	for <batman@archiver.kernel.org>; Thu,  8 Jun 2023 11:34:47 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1686216887;
 b=WYVuNHaRLXKqKx0Tp+lTG5VibTge6iGkjGmswwWl+v3j1KKVxQcIY5bf3JMqiXApn1L9N
 P+0vS/SODDffudg4iYR+UPBSI7YRvU1fvtUf+cF8xluwueF68k3P9JqLirznf609m7hOc34
 gV5bAYl035V3RigmNE6jI7tftlwjdh4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1686216887; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=5cIS8YowCvMN9trqKxcNeiP3Gd9Xo1k7HbnwOEbs+Mo=;
 b=H+H2TgO7SgARANsTR33fu6gVb9w6SQwxDZeKia1OG/dnoS1GOmVuFSzEx2wP+fd3ZJ7rt
 foFW5c3EthR+qanbNac6kMoZ6ju+2DkPCwwAhI639N8vXMY73u+5M60Ywshvib3idKHo4YS
 s+vD5qFGbZntFFOxBoD38iNDYmetd4w=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=ispras.ru;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=ispras.ru policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=ispras.ru; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=ispras.ru policy.dmarc=none
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 59E208045C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu,  8 Jun 2023 11:01:19 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1686214879; a=rsa-sha256;
	cv=none;
	b=cCMeAbZifGAjoFtXpKV4BMG1v0B7JrfWO2qmKprQyINtldk6NGfDSvYhfuZ/4yf4Tx8Uc7
	quo8UXcyEX/+WWic2LUE9VeEQSmqhz6spyYr9WtDaS0EOup4UnN5g+wZnDF41QWI4e9FNZ
	4XqeAUwMleSWxuRsrAN1rIQBSawRRPk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=ispras.ru header.s=default header.b=fLemU8Mz;
	spf=pass (diktynna.open-mesh.org: domain of vefanov@ispras.ru designates
 83.149.199.84 as permitted sender) smtp.mailfrom=vefanov@ispras.ru;
	dmarc=pass (policy=none) header.from=ispras.ru
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1686214879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=5cIS8YowCvMN9trqKxcNeiP3Gd9Xo1k7HbnwOEbs+Mo=;
	b=wIHrkojHh1Cd6VIN3dnOZoK1wPPkw3NGQ2MwPUeYEkLypq1JVNlBDskNhKrKpdGqhj7qsv
	25lOPAWB5eZETom6QUTEA9q6ZTZKShmcLg/GonbDSvZ3NzLq7hCDKHMw62esEwKISdRvwF
	lyfsTWnyjUfdV/gn2b+R6m9LjIbMjGs=
Received: from [10.10.2.69] (unknown [10.10.2.69])
	by mail.ispras.ru (Postfix) with ESMTPSA id AD0BF40737A7;
	Thu,  8 Jun 2023 09:01:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru AD0BF40737A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1686214875;
	bh=5cIS8YowCvMN9trqKxcNeiP3Gd9Xo1k7HbnwOEbs+Mo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fLemU8MzFc7SoqGR5AQ0KegwT/PgiD0r/hpw3lUzEYDDtOZN6kVjK5ca22La9k+2R
	 /XAl8xrjGx21GjiImmvXkGZuzQ5K8/7rQemYHTrv+oyf0uo+CJvFg1fjGSj8VP7Jyd
	 fOs0cXjPCmeku81S86W2Q+xhlS8mzKjw55x4yXmU=
Message-ID: <ff68da6a-8594-b218-c62b-4ae8e1ffae0a@ispras.ru>
Date: Thu, 8 Jun 2023 12:01:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/1] batman-adv: Broken sync while rescheduling delayed
 work
Content-Language: ru
To: "Keller, Jacob E" <jacob.e.keller@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Wunderlich <sw@simonwunderlich.de>
References: <20230607155515.548120-1-sw@simonwunderlich.de>
 <20230607155515.548120-2-sw@simonwunderlich.de>
 <20230607220126.26c6ee40@kernel.org>
 <CO1PR11MB5089F99A62265CE85CCB413CD650A@CO1PR11MB5089.namprd11.prod.outlook.com>
From: Vlad Efanov <vefanov@ispras.ru>
In-Reply-To: 
 <CO1PR11MB5089F99A62265CE85CCB413CD650A@CO1PR11MB5089.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MailFrom: vefanov@ispras.ru
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1
Message-ID-Hash: QC6N327BJG7DOVSRBI2OO5TSLGNQQHML
X-Message-ID-Hash: QC6N327BJG7DOVSRBI2OO5TSLGNQQHML
X-Mailman-Approved-At: Thu, 08 Jun 2023 11:34:39 +0200
CC: "davem@davemloft.net" <davem@davemloft.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>,
 "stable@kernel.org" <stable@kernel.org>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/QC6N327BJG7DOVSRBI2OO5TSLGNQQHML/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

As far as I found the synchronization is provided by delayed work 
subsystem. It is based on the WORK_STRUCT_PENDING_BIT in work->data field.

The cancel_delayed_work_sync() atomically sets this bit and 
queue_delayed_work() checks it before scheduling new delayed work.


The problem is caused by the INIT_DELAYED_WORK() call inside 
batadv_dat_start_timer(). This call happens before the 
queue_delayed_work() call and clears this bit.


Best regards,

Vlad


On 08.06.2023 08:24, Keller, Jacob E wrote:
>
>> -----Original Message-----
>> From: Jakub Kicinski <kuba@kernel.org>
>> Sent: Wednesday, June 7, 2023 10:01 PM
>> To: Simon Wunderlich <sw@simonwunderlich.de>
>> Cc: davem@davemloft.net; netdev@vger.kernel.org; b.a.t.m.a.n@lists.open-
>> mesh.org; Vladislav Efanov <VEfanov@ispras.ru>; stable@kernel.org; Sven
>> Eckelmann <sven@narfation.org>
>> Subject: Re: [PATCH 1/1] batman-adv: Broken sync while rescheduling delayed
>> work
>>
>> On Wed,  7 Jun 2023 17:55:15 +0200 Simon Wunderlich wrote:
>>> The reason for these issues is the lack of synchronization. Delayed
>>> work (batadv_dat_purge) schedules new timer/work while the device
>>> is being deleted. As the result new timer/delayed work is set after
>>> cancel_delayed_work_sync() was called. So after the device is freed
>>> the timer list contains pointer to already freed memory.
>> I guess this is better than status quo but is the fix really complete?
>> We're still not preventing the timer / work from getting scheduled
>> and staying alive after the netdev has been freed, right?
> Yea, I would expect some synchronization mechanism to ensure that after cancel_delayed_work_sync() you can't queue the work again.
>
> I know for timers there is recently timer_shutdown_sync() which can be used to guarantee a timer can't re-arm at all, and its intended for some situations where there is a cyclic dependency...
>
> Thanks,
> Jake
