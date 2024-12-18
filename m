Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27DF2E77183
	for <batman@archiver.kernel.org>; Wed, 18 Dec 2024 08:02:01 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4C56283F55
	for <batman@archiver.kernel.org>; Wed, 18 Dec 2024 09:01:59 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1734508919;
 b=eE/pWmeukNxe9jML818TW7pwJG8xQhtoeSTQL1FE1ubECpe2Dv5FefIlHeg/9yL5acHcV
 mJFyxZ5he1sUPAEQ4b7TbRsjpcX713LXgioI8JMf5blKbBqv9BnaFk0iOsnuV6h/681WWfr
 6ax+61PrTC+hIdJw/kjs70qwE4eiR78=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1734508919; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=vdpS+YQpvQZEJjtXMljjuXwu1puTYSMhBxtAqzUJg00=;
 b=psr0mgAW1GXd1A7sXcS9DDAfO3q+NHCiG14XgJigPFDOXoh++vCztBAoTFTvk1mw/ZQP8
 Ow9fQuIOQi3zhsf/vs8Hndbcr5bSPYGbFcFfo/thLTeBtsJaFVM8p0pua1J0k1KZipW9yLa
 gcK2bqXtlKtXY/pPv5NR+L6d6CUlk/E=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=unstable.cc header.i=a@unstable.cc;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=unstable.cc header.i=a@unstable.cc; arc=pass; dmarc=none
Received: from wilbur.contactoffice.com (wilbur.contactoffice.com
 [212.3.242.68])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 411B280EE9
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 18 Dec 2024 09:01:39 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1734508899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=vdpS+YQpvQZEJjtXMljjuXwu1puTYSMhBxtAqzUJg00=;
	b=f9aHTpgUlrMcKBxwKmNsKFX6EjAqp6bBYVh+EPTG/uw6UO8UN8NI70IkwiHrDBJvae9DAt
	/nP8MuYMBAQJUuwprLpUlr77CJRntKVZ775CjIWcPG4opvzDZwbQNMKTcBO/3ONKkQ/N2x
	S/FkdDGWfk/WL9UN2YJnJjaMgzoXq18=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1734508899; a=rsa-sha256;
	cv=none;
	b=Cjd0Ljv3APqhx5MoDZxc8btu0mdZsfBLY26woXUToGDvUblRqP8p7gdxbUGuJaZhdc822Q
	y+jJDCGnHsYHt2yi9OF751ZoZvPqlj4jL5tsTH935AgIE3Wjs7oSdksKCxCuOIz14+XSY+
	GWoXE9qtPBqiBPHzAz+Fi/P9lsnY+as=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=unstable.cc header.s=20220809-q8oc header.b=pKn77+bW;
	spf=pass (diktynna.open-mesh.org: domain of a@unstable.cc designates
 212.3.242.68 as permitted sender) smtp.mailfrom=a@unstable.cc;
	dmarc=none
Received: from smtpauth2.co-bxl (smtpauth2.co-bxl [10.2.0.24])
	by wilbur.contactoffice.com (Postfix) with ESMTP id 67EC04FFB;
	Wed, 18 Dec 2024 09:01:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1734508898;
	s=20220809-q8oc; d=unstable.cc; i=a@unstable.cc;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=vdpS+YQpvQZEJjtXMljjuXwu1puTYSMhBxtAqzUJg00=;
	b=pKn77+bWsewR8XmnE9N4H+JaWt4yh6gvsakhBg3tvCL0vfjLc4QHRdVSGMdirSw1
	avb0FNVT2YZnOnV63v9Du3xzL1l++lIZPiXQOpMFxv+Oa1Hl4Uto8gYTxyCWNT5Ikeo
	PoXewjTiY9O07dV0/p6CZI5oJZd75X0h35NlNCszertdR9fy80jKi1ZaL6QgQXigcqY
	ua0TQztiV6iJbgyOj/aI/AYPH1MLuvrySpEvbDlIfH07AfggEJJr9UjxhrU5Anp1vSO
	zoXMUeYnSKqyfuJ3FldZtq35QZPP1LIRjcuEjwgiWrRhRkjLALKDir9519v4wptdcut
	OpeA0dD9SA==
Received: by smtp.mailfence.com with ESMTPSA ;
 Wed, 18 Dec 2024 09:01:37 +0100 (CET)
Message-ID: <b309777f-15b0-418f-88d0-a7b8199180ff@unstable.cc>
Date: Wed, 18 Dec 2024 09:02:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] batman-adv: Map VID 0 to untagged TT VLAN
To: Sven Eckelmann <sven@narfation.org>,
 =?UTF-8?Q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>
Cc: b.a.t.m.a.n@lists.open-mesh.org
References: <20241216-no-vlan-0-v1-1-62586f97fd88@narfation.org>
 <Z2GCU5mOICMJgiwc@sellars> <2224062.Icojqenx9y@sven-l14>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: <2224062.Icojqenx9y@sven-l14>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ContactOffice-Account: com:375058688
Message-ID-Hash: BLHSK32DR3ZZEKX34HRQD76TBVK2YHVU
X-Message-ID-Hash: BLHSK32DR3ZZEKX34HRQD76TBVK2YHVU
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BLHSK32DR3ZZEKX34HRQD76TBVK2YHVU/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On 17/12/2024 17:38, Sven Eckelmann wrote:
> On Tuesday, 17 December 2024 14:53:23 CET Linus Lüssing wrote:
>> On Mon, Dec 16, 2024 at 07:37:12PM +0100, Sven Eckelmann wrote:
>>> diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
>>> index 8e0f44c71696f642d80304ec2724e8b5e56a5d93..333e947afcce7ca4128be8406f23295df723515c 100644
>>> --- a/net/batman-adv/main.c
>>> +++ b/net/batman-adv/main.c
>>> @@ -637,6 +637,13 @@ unsigned short batadv_get_vid(struct sk_buff *skb, size_t header_len)
>>>   
>>>   	vhdr = (struct vlan_ethhdr *)(skb->data + header_len);
>>>   	vid = ntohs(vhdr->h_vlan_TCI) & VLAN_VID_MASK;
>>> +
>>> +	/* VID 0 is only used to indicate "priority tag" frames which only
>>> +	 * contain priority information and no VID.
>>> +	 */
>>> +	if (vid == 0)
>>> +		return BATADV_NO_FLAGS;
>>> +
>>>   	vid |= BATADV_VLAN_HAS_TAG;
>>>   
>>>   	return vid;
>>
>> I guess with this patch all TT entries previously in
>> TT VLAN 0 would be moved to untagged/NO_FLAGS TT entries, right?
> 
> Yes, as specified by 802.1Q-2011, it is meant to transport only priority
> information and not a VID. For a switch, the PVID would be used but because
> batman-adv is here used as the lower device (for either a VLAN aware bridge or
> 8021q device), we don't have to add the PVID - the VID is simply missing
> (because it is !BATADV_VLAN_HAS_TAG) and therefore has to check for the
> "untagged" TT global entries (or add entries to the "untagged" TT local part)
> 
>> Wouldn't that technically break compatibility? Let's say someone
>> uses VLAN headers with VID 0 to be able to use priorities / QoS.
> 
> Then this person should have noticed that it broken at the moment and doesn't
> work as expected (to reach the "untagged remotes" with the priority tagged
> packets)
> 
>> What if some old nodes still announced+used VLAN 0 in batman-adv
>> while others used it after this patch, with the mapping to
>> NO_FLAGS?
> 
> Then the misbehaving old node would still misbehave. Because you should
> actually be able to talk with VID 0 to the untagged global TT entries - which
> the old node fails to do. So I could also add
> 
>    Fixes: 0ffa9e8d86d6 ("batman-adv: use vid when computing local and global TT CRC")
>    Fixes: 5d2c05b21337 ("batman-adv: add per VLAN interface attribute framework")
> 
> if you prefer and transmit it via the batadv/net queue.
> 
> But I considered VID 0 somewhat esoteric for in-Linux usage because most tools
> just use DSCP. I am only away of tools like isochron-send which just inject
> raw packets with the VLAN headers directly. And using another 8021q device
> with VID on one side is a good way to create a unidirectional communication
> (when you want a bidirectional one) because the other end will just reply
> with a vanilla, untagged packet. And because of that, things like ARP will
> not be able to "finish" because the answers are received on the non-VID0
> interface.

I am not aware of 0 being used as a sane VID.
I have seen it mostly used internally, but never truly used with 
something like "eth0.0".

Therefore I agree with Sven that this should not cause any real compat 
issue. If we truly break something, then we can probably assume that the 
scenario was already ill formed.

Regards,


-- 
Antonio Quartulli

