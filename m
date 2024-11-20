Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A0DD743D1
	for <batman-adv@archiver.kernel.org>; Wed, 20 Nov 2024 20:29:24 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0856B83E3F
	for <batman-adv@archiver.kernel.org>; Wed, 20 Nov 2024 21:29:23 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1732134563;
 b=2H1sdLRS+7WeSCi+NUJ8/ClxFKYrusZkSP2DLdMFfEsDAAOzd8tqkefyeas9jiYc9dLhT
 4nWB722zxKRAPilYFUZdzpILL2u3lobqV7A2RPSN+TYT0j2+ybxCBkJhmTRcl9RS1B2Wun9
 w9NjcasXxy2fzbUxj/Sl20m71ljtCxI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1732134563; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=1ecJsEO+64EWkDF1YGNMXGAWtYwlA62ElF/ZDQ0x51c=;
 b=cMpixn7fKkSsnWzkQkTCOiwLjRjpTMMESP/xUG8Qzb4xqmsKMh624vuYAuUXSGnmgULul
 2Fb+f9RkeBom9jeBrppeAsidgLC36f3dMm8+SJkdEcOmlyugRC2pZeoO9XVEoRLRRUt50V8
 RSV2txInwTEUWdQCCe3nS/0dFf09uuY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=unstable.cc header.i=a@unstable.cc;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=unstable.cc header.i=a@unstable.cc; arc=pass; dmarc=none
Received: from wilbur.contactoffice.com (wilbur.contactoffice.com
 [212.3.242.68])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id D1BEA81F63
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 20 Nov 2024 21:29:11 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1732134551; a=rsa-sha256;
	cv=none;
	b=YdpcHpB/uVsmAGO8VaYdk3igc5vjoHqBavoxKRoB12tgkIjpoOJbIQMnSe0rcWnSSLpeCU
	VMcVVUil+ktXVg5inXiyXDYa8PAS1si803jkyYVWeGmuXUA04f4XTuhRVoja0lz9ULHGDZ
	cnZZrbF8HNUvuIe1qnfC0SWDPxFiYPg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=unstable.cc header.s=20220809-q8oc header.b=lG11SpNg;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of a@unstable.cc designates
 212.3.242.68 as permitted sender) smtp.mailfrom=a@unstable.cc
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1732134551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=1ecJsEO+64EWkDF1YGNMXGAWtYwlA62ElF/ZDQ0x51c=;
	b=eR8R3kXLLEIRdqjQ4qah4/a1h0iwB7+e/w2Ndmn9Mn7xGESl//qXARkaVa8XK+tEv5D7U0
	ITeYok5bLCKPSaAq0tYz00iyPiSMruhyGurJj8HqShG4iWJFXh3epQTEuJXoPvV/7klq5L
	8zJlz4LOcjZz0Q19QWC9n5mbuKjeI4k=
Received: from smtpauth2.co-bxl (smtpauth2.co-bxl [10.2.0.24])
	by wilbur.contactoffice.com (Postfix) with ESMTP id 50C05157D;
	Wed, 20 Nov 2024 21:29:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732134551;
	s=20220809-q8oc; d=unstable.cc; i=a@unstable.cc;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=1ecJsEO+64EWkDF1YGNMXGAWtYwlA62ElF/ZDQ0x51c=;
	b=lG11SpNg+X91y1bKGajhuL5BpNjkg/RjHMDFD1lKsN3Jy21skX8yxUtTu7X83PID
	/BfIKi2cOXGlBxHXVq1NWzBTqxbmRD/QPGuL4J1vVawOBFfkXMaWfcBPNRdW3pIxmCw
	h5z7hQO43nlxBFmUp7kfyQ5qWs2cid/rj0OfDGXij4a+JMSnr2/nu97N2Wl8snrEUSE
	mLehPVErFWXqInkql1ZZQnSKa7V1I+nkwyCvcLBqtjP4nvyGaUDOKbyFSm2jO2LuFXp
	ZoxF+dx7/mKtBrn1MCfZaDb+dL0InXDHFh0Ip12kcXOKC06LgAAxu3oRi3wvaU8425N
	+PtWc+6c0Q==
Received: by smtp.mailfence.com with ESMTPSA ;
 Wed, 20 Nov 2024 21:29:08 +0100 (CET)
Message-ID: <41b09068-f83f-4061-80ff-4e4413c9df48@unstable.cc>
Date: Wed, 20 Nov 2024 21:29:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] batman-adv: TT change events fixes and
 improvements
To: Remi Pommarel <repk@triplefau.lt>, Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org,
 Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>
References: <cover.1732124716.git.repk@triplefau.lt>
 <4969949.GXAFRqVoOG@sven-l14> <Zz4-ief3zxThRJGm@pilgrim>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: <Zz4-ief3zxThRJGm@pilgrim>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ContactOffice-Account: com:375058688
Message-ID-Hash: 4NZND4OOYLNKFL3YIAZXAMZZG3YQBMYN
X-Message-ID-Hash: 4NZND4OOYLNKFL3YIAZXAMZZG3YQBMYN
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/4NZND4OOYLNKFL3YIAZXAMZZG3YQBMYN/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>



On 20/11/2024 20:54, Remi Pommarel wrote:
> On Wed, Nov 20, 2024 at 08:46:12PM +0100, Sven Eckelmann wrote:
>> On Wednesday, 20 November 2024 18:47:13 CET Remi Pommarel wrote:
>>> The first three patches are actual fixes.
>> [...]
>>>
>>> V3:
>>>    - Fix commit message wording
>>>    - Update outdated comments
>>
>> Antonio, can you please review the patches? It is important that we get the
>> first three out early (to avoid merge conflicts when sending the second part).
>> So maybe you can have at least a look at the first three.
> 
> If it is more convenient for you, I sure can split the serie in two ?

No problem for me. I'll allocate some hours tomorrow morning.
Thanks for the ping, Sven.

Regards,

> 
> Also just saw that I forgot to remove the "a" from "a creating" in the
> commit log, sorry about that. Do you need re-spin for that ?
> 
> Thanks,
> 

-- 
Antonio Quartulli

