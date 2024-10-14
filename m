Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E50C9CFC501
	for <batman@archiver.kernel.org>; Mon, 14 Oct 2024 08:00:20 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id EF7FD83AF1
	for <batman@archiver.kernel.org>; Mon, 14 Oct 2024 10:00:18 +0200 (CEST)
ARC-Seal: i=2; cv=fail; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1728892818;
 b=IQStKL6bgJpBeJ/K6imQt9/1dJeB43jS2H1UMTtoIwuMJoQXkci/KVP8vHFLoLZE+9YTa
 60MMGOKHv4ad3R4nnwBtcm9wHyt3C6+NLB7cmK2klWQZHbH+ZYm5S/myzjQJdzG/bF4oliK
 Vn9mxmZfBaZX/84BuwhjibYhRXVpJ2Q=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1728892818; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=c9HtDPVEhyEiwvhPRAQhllba1vhnHYnXgL7E/p/tRxM=;
 b=YrTPWnAW4DdSC4pZoTNBQw+JnpTR8/XfekGJA9ueOvnU69O8H6Mz0tBFKGGpLgsql6Qkv
 WaesjUWN1so32o20sqCN+WBwpFvSwrtZHAvw/NwqJPCyGeLkfONqN0s3gM4ooE4qr96PgDE
 8XGxCi8FBwy72GLQmHaY40Zi6SfOdf0=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=suse.cz;
  arc=fail (ARC-Seal[1] did not validate);
  dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=suse.cz;
 arc=fail (ARC-Seal[1] did not validate); dmarc=none
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 4263D8174C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 14 Oct 2024 09:19:58 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1728890398; a=rsa-sha256;
	cv=none;
	b=PYhJGVVWlwtOk5sYome+OZjIko6kqwTahdVlZobf9YILw7fIslT+yzKollxN0RujVUFNr7
	w5MWRLQNqTWTD4ZK9U8TirNRS0U7QNohOTRG85ENqhfOYOAPi5af0Lnv8PfNbVsEbxkAdY
	xHE1IKtYqReXL8oIhm5DhGdG82z3xIg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=x+nCZsk9;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qrMeC+MC;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=x+nCZsk9;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qrMeC+MC;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of vbabka@suse.cz designates
 2a07:de40:b251:101:10:150:64:1 as permitted sender)
 smtp.mailfrom=vbabka@suse.cz
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1728890398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature:autocrypt:autocrypt;
	bh=c9HtDPVEhyEiwvhPRAQhllba1vhnHYnXgL7E/p/tRxM=;
	b=0juRoF3DqUpJ+K571y+7ap6eSFHwTckgswoPU2iHScM6PY45w24ruk3yTf9usOqtouBTuR
	k2a8FjMs6XLhB02aCDdvJOkrym5JsZ/rPRPeNaHhqwroj3B2EYhG+Eqis+k+NOvLwVM/ay
	I+mIdJ9JsFjTfXwuRMl3In7VsYkUGN4=
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C07B121CEE;
	Mon, 14 Oct 2024 07:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_rsa;
	t=1728890397;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=c9HtDPVEhyEiwvhPRAQhllba1vhnHYnXgL7E/p/tRxM=;
	b=x+nCZsk9FOoyy6MBBUL2LLpUghLUYuJpL0iDxWQKtbgGcAspy4DWj4olTQX8ZHipspU1a6
	HmExvbxjZC6KTDesIDgWo8bqmJHjKPRWtkF04cZyShkvDnMgoR47jYkex4XjmojKhdcc6u
	Pg37i0ArT4X8VwU5dZDyCmhmP8gswLQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728890397;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=c9HtDPVEhyEiwvhPRAQhllba1vhnHYnXgL7E/p/tRxM=;
	b=qrMeC+MCbZys1aF/YA1EAlHeGrsoPiY6fruN93+xSZZuAdYIZ6+m0Uid/Dm/LmgtY52jc/
	nPTI7Iy9HPVsuXCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_rsa;
	t=1728890397;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=c9HtDPVEhyEiwvhPRAQhllba1vhnHYnXgL7E/p/tRxM=;
	b=x+nCZsk9FOoyy6MBBUL2LLpUghLUYuJpL0iDxWQKtbgGcAspy4DWj4olTQX8ZHipspU1a6
	HmExvbxjZC6KTDesIDgWo8bqmJHjKPRWtkF04cZyShkvDnMgoR47jYkex4XjmojKhdcc6u
	Pg37i0ArT4X8VwU5dZDyCmhmP8gswLQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728890397;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=c9HtDPVEhyEiwvhPRAQhllba1vhnHYnXgL7E/p/tRxM=;
	b=qrMeC+MCbZys1aF/YA1EAlHeGrsoPiY6fruN93+xSZZuAdYIZ6+m0Uid/Dm/LmgtY52jc/
	nPTI7Iy9HPVsuXCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A5BEC13A51;
	Mon, 14 Oct 2024 07:19:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id akUPKB3GDGdNWwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 14 Oct 2024 07:19:57 +0000
Message-ID: <cb49d58e-6221-4117-b0b6-bd8ded715749@suse.cz>
Date: Mon, 14 Oct 2024 09:19:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/17] batman-adv: replace call_rcu by kfree_rcu for
 simple kmem_cache_free callback
Content-Language: en-US
To: Julia Lawall <julia.lawall@inria.fr>, Sven Eckelmann <sven@narfation.org>
Cc: linus.luessing@c0d3.blue, Marek Lindner <mareklindner@neomailbox.ch>,
 kernel-janitors@vger.kernel.org, paulmck@kernel.org,
 Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241013201704.49576-1-Julia.Lawall@inria.fr>
 <20241013201704.49576-7-Julia.Lawall@inria.fr> <6091264.lOV4Wx5bFT@ripper>
 <f343355b-eda9-8527-ee2c-60f1e44e6e0@inria.fr>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <f343355b-eda9-8527-ee2c-60f1e44e6e0@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-MailFrom: vbabka@suse.cz
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: WZFZEM3S37OOV4PHUAA7HHE6Z6GJQO7F
X-Message-ID-Hash: WZFZEM3S37OOV4PHUAA7HHE6Z6GJQO7F
X-Mailman-Approved-At: Mon, 14 Oct 2024 10:00:14 +0200
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/WZFZEM3S37OOV4PHUAA7HHE6Z6GJQO7F/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On 10/14/24 09:08, Julia Lawall wrote:
> 
> 
> On Mon, 14 Oct 2024, Sven Eckelmann wrote:
> 
>> On Sunday, 13 October 2024 22:16:53 CEST Julia Lawall wrote:
>> > Since SLOB was removed and since
>> > commit 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache_destroy()"),
>> > it is not necessary to use call_rcu when the callback only performs
>> > kmem_cache_free. Use kfree_rcu() directly.
>> >
>> > The changes were made using Coccinelle.
>> >
>> > Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
>> >
>> > ---
>> >  net/batman-adv/translation-table.c |   47 ++-----------------------------------
>> >  1 file changed, 3 insertions(+), 44 deletions(-)
>>
>>
>> This was tried and we noticed that it is not safe [1]. So, I would get
>> confirmation that commit 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier()
>> from kmem_cache_destroy()") is fixing the problem which we had at that time.
>> The commit message sounds like it but I just want to be sure.
> 
> Thanks for the feedback. I think that Vlastimil Babka can help with that.

Hi, yeah the batman-adv issue was how we learned about the problem and the
series of commits leading to and including 6c6c47b063b5 was done exactly to
address the kmem_cache_destroy() on module unload issue, and unblock the
conversion to kfree_rcu().

Thanks, Vlastimil

> julia

