Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A50EE64014
	for <batman-adv@archiver.kernel.org>; Thu, 21 Nov 2024 21:07:12 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id DD26084385
	for <batman-adv@archiver.kernel.org>; Thu, 21 Nov 2024 22:07:10 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1732223230;
 b=ZGoJWbTCzkjlzTwnZ9608a1EXEMasma/WDDazoVNmMstQTzWXcYglK1pOM1xXsEztfsxm
 BQd1wkRFM9F+geWodG+QX5MQdRq6o9oPSLcOFkRTt2keOSSvKqCAnO6SsbGJkFADIKfcSmA
 liA9ZuKob7cxCffOHTk9h0St58/kIAc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1732223230; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=U1v07GrLkhsabkQ3+zQyvUaJzBcGT0OFEmq8PGTnIJQ=;
 b=Z8wo0vB5L9CqYW8sNl4cOK8cSWUiCWJUXVxwW5WhZ82ZgsQJiyPIBQweorWyd6HmWnyKa
 UKJeE/GFaCrgIjZS8CsnvyKRVQhfjSKpAttqghl5AdyppoYyOqi+wTgRW+l+rBe4sjavAns
 gifHjk4GK/mL/BYUiQ7gXvUpc1Tv1mo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=unstable.cc header.i=a@unstable.cc;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=unstable.cc header.i=a@unstable.cc; arc=pass; dmarc=none
Received: from wilbur.contactoffice.com (wilbur.contactoffice.com
 [212.3.242.68])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id DCD25832B8
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 21 Nov 2024 22:06:58 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1732223219; a=rsa-sha256;
	cv=none;
	b=0oPSwXOpsR6zx0Fzmf/PlXDnb9uoysEKqTET5vNOlKMOZ1rTKBboznjv6yNCn/Aj87qxnT
	zEeWMMWtSBb/qEmUe0Q9GKIAOJF++OGBleQgdST452EKLQX43fvVCA/tOPq2QurrqplbVJ
	WlE+/QSXiLLpN6c4QSL/iqWsm4TdUv8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=unstable.cc header.s=20220809-q8oc header.b=g+jPvJG4;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of a@unstable.cc designates
 212.3.242.68 as permitted sender) smtp.mailfrom=a@unstable.cc
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1732223219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=U1v07GrLkhsabkQ3+zQyvUaJzBcGT0OFEmq8PGTnIJQ=;
	b=kWJa6aPe4pXW22ZEj8PblesEfPIUqfi9ZWmbjEx53BuoYIGpxKWuR2ouQegpuXnWR8aJAg
	0SBTe6LJ1WOAiC3NvtNRLpqr+sN3N0Q3pewSzDftnZiZhN9LO7GHWq9oAafAh3/S4T8mPq
	OSyCJir8adrmUzIhNqqY9AUA2FDFPiQ=
Received: from smtpauth2.co-bxl (smtpauth2.co-bxl [10.2.0.24])
	by wilbur.contactoffice.com (Postfix) with ESMTP id 961EC3B67;
	Thu, 21 Nov 2024 22:06:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732223218;
	s=20220809-q8oc; d=unstable.cc; i=a@unstable.cc;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=U1v07GrLkhsabkQ3+zQyvUaJzBcGT0OFEmq8PGTnIJQ=;
	b=g+jPvJG41MDNLgY9A/3sy+IdgqXpM2LQME4fD28uW1MBJoyF1JVs9PYqt9EL+/4f
	jS52khb5pfoBrXGDfkAjjhA7+WeTkw6WKlMhJgfPS2BVbZ0UvTrECKjqlX2xO8WdAOw
	CIp4BoAwqG+odSEtJAW5Bt74vQcvnSVddfQZu1ujSYRPJVUzdf4dxbxMqljKBuuVZJ8
	19lTGhhwdPmNv97+k4kGaThYBKK+ll8m0CDRbfYoTc1MfMNeTYf3sNloQZDFDJwhBMX
	pNUMtYEmTPFhXZ1DQeOwh4gTSJLbAqSfCWhQgao4qgVGo2ma0E8CTlG3jR75iz+HkEc
	vXZYus6odg==
Received: by smtp.mailfence.com with ESMTPSA ;
 Thu, 21 Nov 2024 22:06:55 +0100 (CET)
Message-ID: <d392719d-2d2d-4d1c-8867-4207dfae0d1c@unstable.cc>
Date: Thu, 21 Nov 2024 22:07:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] batman-adv: Do not send uninitialized TT changes
To: Remi Pommarel <repk@triplefau.lt>, Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org,
 Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>
References: <cover.1732124716.git.repk@triplefau.lt>
 <Zz88AYyDTv5W9gQk@pilgrim> <Zz9MrP6LBw0eY_Uv@pilgrim>
 <4345009.mogB4TqSGs@ripper> <Zz-W_3A9diBFXz79@pilgrim>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: <Zz-W_3A9diBFXz79@pilgrim>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ContactOffice-Account: com:375058688
Message-ID-Hash: HVQ2HLZU7SVLBDTTBZVGCYW3FWASMFTP
X-Message-ID-Hash: HVQ2HLZU7SVLBDTTBZVGCYW3FWASMFTP
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/HVQ2HLZU7SVLBDTTBZVGCYW3FWASMFTP/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On 21/11/2024 21:24, Remi Pommarel wrote:
> On Thu, Nov 21, 2024 at 07:02:43PM +0100, Sven Eckelmann wrote:
>> On Thursday, 21 November 2024 16:07:24 CET Remi Pommarel wrote:
>>> So the patch would be quite similar, only tt->tt.changes_list_lock will
>>> be taken sooner in batadv_tt_tvlv_container_update().
>>>
>>> That will fix the ADD between two read situation as you described
>>> though.
>>>
>>> Do you still prefer this option ?
>>
>> I can't speak for Antonio but I think I would prefer for the fix the current
>> version. The locking one would end up again with nested spinlocks and maybe
>> more refactoring. And it might be nicer for the stable backports to have less
>> noise in the patch.
> 
> I tend to second that, because if I understand correctly, even if
> tt.changes_list_lock is held sooner in batadv_tt_tvlv_container_update()
> the scenario Antonio described could still happen. Indeed if the ADD (or
> even DEL for that matter) happens between VLAN table CRC computation
> (batadv_tt_local_update_crc()) and the lock, neighbor will have CRC
> mismatch and send TT_REQUEST anyway. The race window would be smaller
> but still here.
> 
> So if I am not mistaken, the only solution to eliminate the race
> completely would be to compute CRC while holding the lock, and this I
> don't really like.

I agree with Sven, and I'd not jump into more refactoring.
Better to keep the bugfix as is.

Cheers,

> 
>>
>> Btw. just noticed that the code (not in your change - but overall) for the
>> filling of diff entries could have been something like:
>>
>> --- a/net/batman-adv/translation-table.c
>> +++ b/net/batman-adv/translation-table.c
>> @@ -980,6 +980,7 @@ static void batadv_tt_tvlv_container_update(struct
>> batadv_priv *bat_priv)
>>   	int tt_diff_entries_count = 0;
>>   	bool drop_changes = false;
>>   	size_t tt_extra_len = 0;
>> +	LIST_HEAD(tt_diffs);
>>   	u16 tvlv_len;
>>   
>>   	tt_diff_entries_num = READ_ONCE(bat_priv->tt.local_changes);
>> @@ -1011,9 +1012,10 @@ static void batadv_tt_tvlv_container_update(struct
>> batadv_priv *bat_priv)
>>   
>>   	spin_lock_bh(&bat_priv->tt.changes_list_lock);
>>   	bat_priv->tt.local_changes = 0;
>> +	list_splice_init(&bat_priv->tt.changes_list, &tt_diffs);
>> +	spin_unlock_bh(&bat_priv->tt.changes_list_lock);
>>   
>> -	list_for_each_entry_safe(entry, safe, &bat_priv->tt.changes_list,
>> -				 list) {
>> +	list_for_each_entry_safe(entry, safe, &tt_diffs, list) {
>>   		if (tt_diff_entries_count < tt_diff_entries_num) {
>>   			memcpy(tt_change + tt_diff_entries_count,
>>   			       &entry->change,
>> @@ -1023,7 +1025,6 @@ static void batadv_tt_tvlv_container_update(struct
>> batadv_priv *bat_priv)
>>   		list_del(&entry->list);
>>   		kmem_cache_free(batadv_tt_change_cache, entry);
>>   	}
>> -	spin_unlock_bh(&bat_priv->tt.changes_list_lock);
>>   
>>   	tt_extra_len = batadv_tt_len(tt_diff_entries_num -
>>   				     tt_diff_entries_count);
>>
>>
>> And then you can also move this before "tt_diff_entries_num = ..." and
>> save the corresponding bat_priv->tt.local_changes for the spliced list to the
>> inside the lock also in a local variable. And then operate on this variable
>> for the other decisions. Of course, you must still clean the local list in
>> case of an error. Which of course would slightly change the behavior in case
>> of an allocation error in batadv_tt_prepare_tvlv_local_data (which would
>> previously kept the list as it was).
>>
>> But if it would be done like this then we could also remove the READ_ONCE and
>> not introduce the WRITE_ONCE - just because local_changes is only touched
>> inside a locked area (see changes_list_lock).
>>
>> Please double check these statements - this was just a simple brain dump.
> 
> Yes that would be a much more elegant way to handle it. Unfortunately,
> if I don't miss anything, the WRITE_ONCE/READ_ONCE would still be
> needed because batadv_tt_local_commit_changes_nolock() has to load
> tt.local_changes out of the lock to check if it needs to purge client
> and recompute CRCs.
> 
> Thanks,
> 

-- 
Antonio Quartulli

