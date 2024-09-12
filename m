Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF2DEEB591
	for <batman@archiver.kernel.org>; Thu, 12 Sep 2024 11:26:46 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3A25683E75
	for <batman@archiver.kernel.org>; Thu, 12 Sep 2024 13:26:45 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1726140405;
 b=PoFJw9rtqu6/sB/PrSWYh9umWL+viZSLorIO7nWrSmifDPZL9H+7p30W7HoFkRHRdLKy2
 vaWZBCEe9QDYvQTGU3X+gKiV1Wlc7MMkjKhSrDLxxqG/tnbD+a/ouYbJMRIHPb53aQuMSbD
 ikDgzSNb5Eh7Tw/Cac3kV5cwWGgGmTA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1726140405; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=og2veh7euJtApx2o6sd4YEkJribkz5SSzpE2t9b7zsE=;
 b=D6JutCPhmkp8FtSMUEsUVb2amWAi9Mjdge0cGkvItdnfSEX6jr8mHKd2ATo+PuhFrd/A4
 2uQOrE4QVV3t0sHSLWzuk3hxWKn0cxZVp5WkYlfL4ZQdQJr5mk37yU/2nANcFT6/S16jpD8
 tF0lphEb9a4crubBEtKq7wzlAt/jlJ4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=unstable.cc header.i=a@unstable.cc;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=unstable.cc header.i=a@unstable.cc; arc=pass; dmarc=none
Received: from wilbur.contactoffice.com (wilbur.contactoffice.com
 [212.3.242.68])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 6BBED80F2D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 12 Sep 2024 13:26:08 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1726140368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=og2veh7euJtApx2o6sd4YEkJribkz5SSzpE2t9b7zsE=;
	b=A4cVT0z62hc69i2wiN8vuvUfuI9zFfqhfWBmmTcYspRDnKmTUAbKrJNEF3vQq5icTo2wxW
	F2Jo+Lj5wgRONOJRNH0Ytg+eRc2r9gJ7CP5csNgU/ooUB/Cu+r6Tw8t9TRfSEQ47Yimapx
	GlgtlbStJh88imHOFZTl4grw17Ez8bs=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=unstable.cc header.s=20220809-q8oc header.b=B+Cd3U7+;
	spf=pass (diktynna.open-mesh.org: domain of a@unstable.cc designates
 212.3.242.68 as permitted sender) smtp.mailfrom=a@unstable.cc;
	dmarc=none
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1726140368; a=rsa-sha256;
	cv=none;
	b=RCP6hmNHsVmNs//xmVgHMJhvI/4VDJNJla6CRFUsiT8Csvw7TZ+6VGGJ2LajCxITCegh/e
	MPbc6XxqCAFPCj2UrwWMgZJSG+vjYYrPXJbThH1ZTEIkWylHrZdqgS+iJT5B8LVmUgmxa/
	rrLBD3it+kbEXTwK3/TfvzA3Jn65N9s=
Received: from smtpauth2.co-bxl (smtpauth2.co-bxl [10.2.0.24])
	by wilbur.contactoffice.com (Postfix) with ESMTP id D346A2A2E;
	Thu, 12 Sep 2024 13:26:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726140367;
	s=20220809-q8oc; d=unstable.cc; i=a@unstable.cc;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=og2veh7euJtApx2o6sd4YEkJribkz5SSzpE2t9b7zsE=;
	b=B+Cd3U7+dyuEnscfS4QzEY4RQod7jlRXi+wakZU6cecOYAmE6oKPw3btnYJnMoKz
	1TAZ3OqNZT2VSdfHTtQ6AzuaQ+NzwEQNK9CWOSuBD/f/SfnbjLeNXWFNBc4NDPyfqIK
	HADhK9khBC3Z8LtsdLygws72i3QoyC7E7xdC+VotZDmgs3n77csU8/mMh2ogfoz2wbY
	+a5FzpelsjQN5pub0qSp4m8JjGfbQwIEiMtikmkM2QKW3UYAsejXFlmR1XlnaehQbQk
	0ydCeJSgdKRkDnN96sgw+Rt/ItYmfOkQORMpqE/Sd66aiQKrfINUfvmprab+Av1T1Dl
	kHPdhhzbwg==
Received: by smtp.mailfence.com with ESMTPSA ;
 Thu, 12 Sep 2024 13:26:04 +0200 (CEST)
Message-ID: <55721542-08b7-40b0-a272-9e1f3287c32f@unstable.cc>
Date: Thu, 12 Sep 2024 13:28:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] batman-adv: split DAT cache into DAT cache and DAT
 DHT
To: =?UTF-8?Q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>
Cc: b.a.t.m.a.n@lists.open-mesh.org
References: <20240911051259.23384-1-linus.luessing@c0d3.blue>
 <20240911051259.23384-2-linus.luessing@c0d3.blue>
 <0f7c0a9f-6577-4d37-8ad3-2a6b1369b539@unstable.cc> <ZuLLkEf15zZTN5xj@sellars>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: <ZuLLkEf15zZTN5xj@sellars>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ContactOffice-Account: com:375058688
Message-ID-Hash: CCV2YFMSSK3QHN7Z2TSDQ66KIWATBACA
X-Message-ID-Hash: CCV2YFMSSK3QHN7Z2TSDQ66KIWATBACA
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/CCV2YFMSSK3QHN7Z2TSDQ66KIWATBACA/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi,

On 12/09/2024 13:08, Linus Lüssing wrote:
> Hi Antonio,
> 
> Thanks for the feedback!
> 
>> I haven't followed previous discussions, therefore my question may just
>> sound redundant, but if "cache_hash" is for ARP what is the "DAT DHT"? (the
>> A in DAT stands for ARP).
> 
> The dht_hash would just store what was pushed to it from remote nodes
> through the DAT DHT feature. So through a BATADV_P_DAT_DHT_PUT in
> a batman-adv unicast4addr packet.
> 
> And would only be used for responses to a BATADV_P_DAT_DHT_GET.
> 
> The cache_hash would store all the other cases. That is local
> additions learned through bat0. Or the responses this node got to
> a BATADV_P_DAT_DHT_GET.

Ah I see, so you're entirely splitting the DHT from the local ARP cache.
Naming indeed makes sense now.

> 
>> Moreover, it seems with this approach you are converting the DAT concept
>> into something "type specific" - am I wrong?
> 
> You mean to be able to use it for other types than ARP? Like the
> patchset we had for IPv6 a while ago? Hm, no, that at least wasn't
> the intention.

nah, I got it wrong. Your explanation above helped me clear the doubt.

> 
>>
>> Is it truly required just to have a different timeout?
>> Wouldn't a mark on entries be enough to instruct the subsystem about what
>> timeout value to use?
> 
> That would work, too, right. I just found a split simpler and less
> error-prone. With flags I'm always worried about missing potential
> race conditions when flipping it back and forth. Especially with
> the two different timeouts involved here.
> 

 From what you are saying and (what I understand) this splitting is not 
only about the timeout, but it's a clear cut between "what we have in 
the DHT" and what we are collecting locally.

So splitting data structure makes a lot of sense to me.

With a flag, you should assume that a specific entry can either have or 
not the flag set.
With two tables, the same entry could technically exists in both and 
it'll be up to you decide how to handle the situation (without ambiguity 
in this case because you know exactly where each entry is coming from).

> For instance if I had an entry through a remote node
> (BATADV_P_DAT_DHT_PUT) and therefore with a flag set. But now got an update for the same
> address/entry through bat0 (maybe the client device roamed to us?
> Or some collision / duplicate address usage?).
> Should I now always unset the flag? Or should I check if its remaining
> timeout is less than 5min and only if it is then unset the
> flag?
> 
> Should a response to a BATADV_P_DAT_DHT_GET only be to an entry
> with the flag set? Or independent to what the flag is set to?

I feel you need to answer the above questions even with two tables. No?
The difference is that with two tables you have more information and 
don't need overwrite a DHT entry with a local one (and viceversa).

> 
> .oO(Maybe a split could also be useful if one wanted to introduce
> individual limits for additions? Against remote attackers trying to
> DoS a node?)
> 
> Let me know if you'd still prefer a flag instead of a separate
> hash table and I could change that.

I think splitting is a good idea, not only because of the timeout, but 
also because it makes the state more clear.

Regards,

> 
> Regards, Linus

-- 
Antonio Quartulli
