Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FF0606A31A
	for <batman@archiver.kernel.org>; Sat, 31 Oct 2026 07:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=njBmvxef
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0623B80728
	for <batman@archiver.kernel.org>; Sat, 31 Oct 2026 08:12:44 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793430764;
 b=WZHTFafo1x6Yyd9Hp70qixR04tXs3v54hawSs0KMEXNLm3ceE9SFjkRoHNP7LlpZnbAiM
 U0Grx7rt1h9nWm3QIm3eZryPkrm6WxdCDF3yi05Y9+wF75S6d4kkdOmpwAVuXJZLEm4sOGG
 ZZD71KxCBv3dlu5jDc2HN6i6Tz4kMjs=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793430764; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=3wm+4897jxs8qJDci3NVM5W4mAuEoHJpzGMuVxbfiXo=;
 b=0hQNAph7a2aECtzJV7XrxoR+Q6Q24LMIcFJF5+6Brn/qStIVVLcVaL0lM3vx07FZU2AFC
 sak6/jloqrQ6Xg3BZFONCGXx4aRDEiOkW93M89u42BTl36/ra7dU8iJi4qU/T8UqPRoI/sM
 tC5R04iD5fAIU7UfqPZxNtwYv5gQmAM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=gmail.com;
 arc=pass;
 dmarc=pass header.from=gmail.com policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 6790280DED
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 31 Oct 2026 01:02:31 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793404962;
	b=Y+b4Qm8wpPQXVs0u7q/oJ7O3ydvImGmf7lIsXVyvZrEws70/5PMzhXuMbKGNZuJ+ZDW1eH
	gMM8yaeqv/ZjE7gGsScuvNqqGRI6impadwuNNejMroJCn1Tj5Bv9Ak69JgQIcmR7j6aTAw
	uozr7yR3HWdo78+C4GGDGXvnl9aPSnw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793404962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=3wm+4897jxs8qJDci3NVM5W4mAuEoHJpzGMuVxbfiXo=;
	b=2Pz5/zZJRINEPJz63GiEjcxhwOzNGvr4y2QyA94xUIAUUidp5RXiCLAbyfzijZu6zDMup9
	blPLuXbMLcya40oF/N0wE9QA9eM4eZZGsw9riMcN7CbFTqu3Kdfc93Nl27wqw0NCHsZeSe
	pRHkvDj+ULm2nZYewZz+uD7M/kiZZMw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20260707 header.b=njBmvxef;
	spf=pass (diktynna.open-mesh.org: domain of omermetekaya0@gmail.com
 designates 2a00:1450:4864:20::332 as permitted sender)
 smtp.mailfrom=omermetekaya0@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a60f9474c4so14234525e9.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Fri, 30 Oct 2026 17:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793404950; x=1794009750;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3wm+4897jxs8qJDci3NVM5W4mAuEoHJpzGMuVxbfiXo=;
        b=njBmvxefWNEBH8oCC6oef/90qbkQP5KSy9si9KO2TwdsepmB5TwkPudZzeNrXOc67u
         HPuANqXeSpmQiXh4d5DtiWfXRnl3v8tJGi9WPElk67UPrsx4Hqy/fqvpzH903QtMO9AL
         6BVNGHkLN4l97kAtyrL12e8qafhlmVDLD0PRMuzmHUxgUuWt79l6++GM89QNAhJ5ZJKx
         D1YLndezDUD6ggrC0Mp0UeFDfFyjxvmXwbl3FaC0Gar7WU4djpZ1GQYcpfHTSMRuAHDI
         mRHPUOZMWfRxnVqrchJZ93R3SsavkJl0Db4+yJHuVdzzsyGSEvuQayzo1PrRVQY0lKwE
         UTwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793404950; x=1794009750;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3wm+4897jxs8qJDci3NVM5W4mAuEoHJpzGMuVxbfiXo=;
        b=dg+CaV8PcdbdOus2aGebe2NQIzPhwJ/ZsW8S7taWh/I+jHwpjGAOSFER5CTZTYNu4v
         XJCGH8YfCJkOSaYQ3gpXJ8lSLMUfpUL/DS2rtQ4A/WOmrJkuYDawkOo/BGqaZCegk2+p
         2d56Cb0uP7OtJuhpQAJWH7fECJbqKvQtzpctHNVHRcCMQIDHL0T7hIBwqERbcpIHQreR
         1R/ClM0FD2GotBq9Kz7daxnz8uGPGIWPXXq3OK/n82Rx0ZrqdQ0N43sm37jzvrwDZm7e
         O+jcgicM0eJ1vaP4v6pTieb07LokKNxQ6AGnbFeyb7V40yN+SOQBSPhJ+dfIGbCaxTqi
         FbYg==
X-Forwarded-Encrypted: i=1;
 AKwUvBznZm4Opwg4Vaq9NAbitG4epg27DH2Te64ItThhD3lfbjFYd5H34VIGqNfWFVxYqlFOr271yhkWlwFLLA==@lists.open-mesh.org
X-Gm-Message-State: AFq9FYLkHXetlvL0FTLhycme+fRs50mrRzR8loydfBDhEter7ZNAXJ6Y
	1gAGkU2nRkVhpsRslyKr5WpSYfxtesjhAh/X9zVNA2+sysB2SbTcmahO
X-Gm-Gg: AYBFou1/eg2uufgZeEuvVHAZHVY7qoMaoa+/QS4SZzTGFc8UxO/otNRiersgoFgPp14
	GO0kP4T7QERBMrForOEwxAeyhWphS8YMlgsEPAE3MXRnlj6wNUMg3LvDybx7VubPfWDgqzJl6Gc
	Vp0dUXoxnoH3vkRuCvEZTR//aduFro+3oYG8lSCdHChrKaY1OShF+ya+7vUpMF2/l2U08o4tOeG
	OCslY/QLhORRIbMk33m6RMY8CdcNNv8BxCmv9OPeFhewVTSobQHjqWk8/+9H/5iqk13Ss9vQUHS
	kw9Uv+4AJZN3bBuGMjpURlmYuTUn/3NxP4aC+qYn7syJXDUrCZmDivTGscJV6ouIYBIdczm4LCi
	UlcxMfEm853Z4EaHV+g3irwDN+lNvpqC24GcGl4VQpwwpmMteZwnXVFe4toZUyawweF+T6Gpwgx
	oTvN2B5TOLJeei3Z+Isn059YfdH8HB5amcr+Sn0qUO58jMKb6DQbpHMFwTJ63xsfd2PSGO1nnKL
	d5BH8ogoARxNOXpq3UjZTlcRkzQaJOUEtCXug1cH8J5OcL80wVu882PbFaBm3JXXK5tkiH3YG1J
	DiSiNGoxvYnJ2qpBX5v07vAJn2egUxHtu/YGJX9v
X-Received: by 2002:a05:600c:310e:b0:4a2:10f9:37ce with SMTP id
 5b1f17b1804b1-4ac1709ae70mr84014525e9.15.1793404950201;
        Fri, 30 Oct 2026 17:02:30 -0700 (PDT)
Received: from [192.168.18.21] ([46.197.185.71])
        by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abe7706516sm59948335e9.0.2026.10.30.17.02.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 17:02:29 -0700 (PDT)
Message-ID: <48b23995-4f67-4f3b-8988-78546cc23ecd@gmail.com>
Date: Sat, 31 Oct 2026 03:02:27 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] batman-adv: reduce softirq drain in tt_purge loops
To: Sven Eckelmann <sven@narfation.org>, marek.lindner@mailbox.org,
 sw@simonwunderlich.de, antonio@mandelbit.com
Cc: davem@davemloft.net, b.a.t.m.a.n@lists.open-mesh.org,
 linux-kernel@vger.kernel.org,
 syzbot+61b202fdc410840f0198@syzkaller.appspotmail.com
References: <20261030000222.286935-1-omermetekaya0@gmail.com>
 <5221322.cEBGB3zze1@ripper>
Content-Language: en-US
From: =?UTF-8?Q?=C3=96mer_Mete_Kaya?= <omermetekaya0@gmail.com>
In-Reply-To: <5221322.cEBGB3zze1@ripper>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MailFrom: omermetekaya0@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: BA4A2BTF5GJJ566DRJL2L5O4NLBVISNS
X-Message-ID-Hash: BA4A2BTF5GJJ566DRJL2L5O4NLBVISNS
X-Mailman-Approved-At: Sat, 31 Oct 2026 08:11:57 +0100
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BA4A2BTF5GJJ566DRJL2L5O4NLBVISNS/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_NONE,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/30/26 11:25, Sven Eckelmann wrote:
> On Friday, 30 October 2026 00:59:51 CET Ömer Mete Kaya wrote:
>> Replace per-bucket spin_lock_bh()/spin_unlock_bh() with outer
>> local_bh_disable()/enable() and periodic drain every 64 buckets
>> to avoid excessive softirq processing during TT purge.
> 
> I would prefer if there is paragraph explaining what the actual problem is 
> instead of "avoid excessive softirq processing during TT purge." - I would not 
> know what is going on or if it is a critical problem just from these couple of 
> words.

Sorry, I should explain the problem more clearly.
The TT purge functions call spin_unlock_bh() after each hash bucket.
Under sustained network load, this can cause the purge worker to spend a
significant amount of time processing pending softirqs between buckets,
delaying the actual purge work.
Batching the BH re-enable points allows the worker to process more
buckets between them. This does not reduce the total packet-processing
work, but it reduces the time the purge worker spends handling softirqs
inline.

>> Add may_sleep parameter to batadv_tt_local_purge() since it is
>> called both from workqueue context (where cond_resched is safe)
>> and under commit_lock spinlock in batadv_tt_local_resize_to_mtu()
>> (where sleeping is not allowed).
> 
> But what was the intention to have the potential sleeps in the first place. It 
> is most likely good to have them but it is not explained here at all.
> 
> And if there is a good reason to have it - would there be any bigger problems when it runs under batadv_tt_local_purge() without it?

cond_resched() lets other tasks run between batches on kernels without
full preemption. Without it, the worker can keep running through the
purge on the same CPU.

The resize path still scans all buckets, but it holds commit_lock, so
it cannot use the rescheduling point. may_sleep=false skips it there.

>> Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
>> Reported-by: syzbot+61b202fdc410840f0198@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=61b202fdc410840f0198
>> Signed-off-by: Ömer Mete Kaya <omermetekaya0@gmail.com>
>> ---
>>  net/batman-adv/translation-table.c | 30 +++++++++++++++++++++++-------
>>  1 file changed, 23 insertions(+), 7 deletions(-)
> 
> 
> This is not going through net (or net-next). So please don't mark it like it. 
> The target would be the batadv tree.

True, sorry about that.

> Is there a good reason to have this sent through a non-next tree and get it 
> backported to various stable trees? For me, it looks just like the system has 
> a loop ("bridge0: received packet on bridge_slave_1 with own address as source 
> address") and therefore the system is under heavy load. Due to this problem, 
> some other tasks will take longer - like the workqueue task from batadv. And 
> you are now trying to remove the kernel splat
> "BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=-20 stuck for 32s!"
> 
> For the moment, I don't understand why this has to be handled like some 
> critical fix in batman-adv. It is just a bystander which suffers from the 
> current system state. If you think that you can optimize the situation for 
> batman-adv - fine. But this is then something for batadv-next and not a fix 
> which needs to enter net + needs to be backported.

You are right, I targeted net because it was a "BUG" in syzbot but its
actually optimization. No need to be backported.

> But maybe I am misunderstanding the problem here - please describe it better, 
> so I can also understand what the problem+idea is behind your change. And I am 
> not talking about just putting in a lot of text like these LLMs are generating 
> nowadays. I am talking about a simple to follow explanation which result in me 
> thinking "hey, this is good to have in following tree/branch".

In short, each spin_unlock_bh() can drain pending softirqs inline.
With 1024 buckets, the purge worker can spend more time in softirq
processing than in its actual purge work when the system is under
network load. Batching the re-enable points lets the purge complete
without being repeatedly pulled into softirq handling, so the purge loop
completes with fewer interruptions from softirq processing. Similar to
how ctnetlink_dump_table() batches its BH window when walking the
conntrack hash.

> 
> Btw. it doesn't apply in the batadv tree (shown here):
> 
> $ ./scripts/get_maintainer.pl --scm ./20261030000222.286935-1-omermetekaya0@gmail.com.mbx
> [...]
> git https://git.open-mesh.org/batadv.git
> [...]
> 
> 
> There is a conflict in batadv_tt_local_resize_to_mtu() due to the commit 
> 48d05a984683 ("batman-adv: tt: limit local table to single TVLV response 
> size"). It is only a small context conflict:
> 
> @@ net/batman-adv/translation-table.c: static void batadv_tt_purge(struct work_stru
>   	batadv_tt_req_purge(bat_priv);
>   	batadv_tt_roam_purge(bat_priv);
>  @@ net/batman-adv/translation-table.c: void batadv_tt_local_resize_to_mtu(struct net_device *mesh_iface)
> - 		if (packet_size_max >= table_size)
> + 		if (size_max >= table_size)
>   			break;
>   
>  -		batadv_tt_local_purge(bat_priv, timeout);

Okay I will rebase.

> 
>> diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
>> index 68f79853032e..915f5589e056 100644
>> --- a/net/batman-adv/translation-table.c
>> +++ b/net/batman-adv/translation-table.c
>> @@ -1386,21 +1386,29 @@ static void batadv_tt_local_purge_list(struct batadv_priv *bat_priv,
>>   *  inactive or not
>>   */
>>  static void batadv_tt_local_purge(struct batadv_priv *bat_priv,
>> -				  int timeout)
>> +				  int timeout, bool may_sleep)
> 
> New parameter is not documented.
Yes I noticed late unfortunately.

>>  {
>>  	spinlock_t *list_lock; /* protects write access to the hash lists */
>>  	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
>>  	struct hlist_head *head;
>>  	u32 i;
>>
>> +	local_bh_disable();
>>  	for (i = 0; i < hash->size; i++) {
>>  		head = &hash->table[i];
>>  		list_lock = &hash->list_locks[i];
>>
>> -		spin_lock_bh(list_lock);
>> +		spin_lock(list_lock);
>>  		batadv_tt_local_purge_list(bat_priv, head, timeout);
>> -		spin_unlock_bh(list_lock);
>> +		spin_unlock(list_lock);
>> +
>> +		if (may_sleep && (i & 63) == 63) {
>> +			local_bh_enable();
>> +			cond_resched();
> 
> You are missing the include for this function:
> #include <linux/sched.h>

Yes I should add it.

>> +			local_bh_disable();
>> +		}
>>  	}
>> +	local_bh_enable();
>>  }
> 
> This looks like a workaround for a problem which isn't described very well. 
> Are there any precedents in the Linux kernel?
> 
> I know of things like ctnetlink_dump_table() with the large local_bh_disable() 
> and inner spinlocks. But I know of nothing with the cond_resched. But since I 
> don't know why it was added in the first place, I would a better explanation 
> of the problem and the reasoning why it was tried to be fixed like you did.

ctnetlink_dump_table() in net/netfilter/nf_conntrack_netlink.c uses
an outer local_bh_disable() with inner spin_lock()/
spin_unlock() calls on per-bucket locks.

nf_ct_iterate_cleanup() also uses cond_resched() while walking the
conntrack hash, although it re-enables BHs at a different granularity.
> 
> For me, it looks like you intended to cut the worker->softirq switches from 
> 1024 to 16. But it is unclear why this would help here because there seems to 
> be quite some heavy (pending) load on the system which will then still run 
> when local_bh_enable() is called (on this CONFIG_PREEMPT kernel).

The total packet work is not reduced. But each BH re-enable point is a
potential softirq drain, when softirqs are pending, the kernel processes
them inline before returning to the caller. Under sustained load, most
of these re-enable points will trigger a drain. Reducing the number of
re-enable points from 1024 to 16 means the worker is pulled into inline
softirq processing less often, so the purge completes sooner.

> 
>>  static void batadv_tt_local_purge(struct batadv_priv *bat_priv,
>> -				  int timeout)
>> +				  int timeout, bool may_sleep)
> [...]
>> @@ -2363,11 +2371,12 @@ static void batadv_tt_global_purge(struct batadv_priv *bat_priv)
> 
> 
> I see changes in batadv_tt_local_purge + batadv_tt_global_purge but where is 
> the change for batadv_tt_local_purge_pending_clients, 
> batadv_tt_global_del_orig, batadv_tt_local_transition_new? I think  
> batadv_tt_global_table_free and batadv_tt_local_table_free are not running in 
> the right context, so let us ignore them for now.

Agreed, I should convert the others too.

> 
> And to finish the list, here is the Sashiko output. Please deal with them 
> directly - I hate to write rebuttals for these things when sending it to 
> the next maintainer(s).
> 
> 
> Findings:
>   Critical: 0  High: 0  Medium: 1  Low: 2
> 
>   --- Patch [1] batman-adv: reduce softirq drain in tt_purge loops ---
>   [Low] batman-adv: batadv_tt_local_purge() kernel-doc missing new @may_sleep param
>   [Low] batman-adv: tt purge loops hold BH disabled across 64 buckets instead of 1
>   [Medium] batman-adv: commit message claims softirq reduction; patch only defers it
> 
> 
> Inline Review:
> commit ae1b9a789b6f70e3fdb116868b75058b32b7b764
> Author: Ömer Mete Kaya <omermetekaya0@gmail.com>
> 
> batman-adv: reduce softirq drain in tt_purge loops
> 
> This commit replaces the per-bucket spin_lock_bh()/spin_unlock_bh() calls
> in batadv_tt_local_purge() and batadv_tt_global_purge() with an outer
> local_bh_disable() section. That section is briefly re-enabled, with a
> cond_resched(), every 64 buckets. A may_sleep parameter is added so that
> batadv_tt_local_resize_to_mtu(), which holds commit_lock, skips the
> rescheduling point.
> 
> Closes: https://syzkaller.appspot.com/bug?extid=61b202fdc410840f0198
> 
>>     batman-adv: reduce softirq drain in tt_purge loops
>>
>>     Replace per-bucket spin_lock_bh()/spin_unlock_bh() with outer
>>     local_bh_disable()/enable() and periodic drain every 64 buckets
>>     to avoid excessive softirq processing during TT purge.
>>
>>     Add may_sleep parameter to batadv_tt_local_purge() since it is
>>     called both from workqueue context (where cond_resched is safe)
>>     and under commit_lock spinlock in batadv_tt_local_resize_to_mtu()
>>     (where sleeping is not allowed).
>>
>>     Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
>>     Reported-by: syzbot+61b202fdc410840f0198@syzkaller.appspotmail.com
>>     Closes: https://syzkaller.appspot.com/bug?extid=61b202fdc410840f0198
>>     Signed-off-by: Ömer Mete Kaya <omermetekaya0@gmail.com>
>>     Signed-off-by: Sven Eckelmann <sven@narfation.org>
> 
> [Severity: Medium]
> Does this patch reduce the softirq work, or only defer it?
> 
> Every 64 buckets the loop does:
> 
>     local_bh_enable();
>     cond_resched();
>     local_bh_disable();
> 
> local_bh_enable() still runs all pending softirqs, so the total softirq
> work looks coalesced rather than reduced. The new behaviour seems to be
> the cond_resched() in workqueue context. The message doesn't present that
> as the fix, and it doesn't explain how it addresses the syzbot report.

You are right that the total packet processing isn't reduced. The change
reduces the number of BH re-enable points, so the purge worker is less
often pulled into inline softirq processing. I'll make the commit
message describe that rather than claiming less packet work.

> The resize path is also unchanged in practice.
> batadv_tt_local_resize_to_mtu() holds
> spin_lock_bh(&bat_priv->tt.commit_lock) and passes may_sleep=false:
> 
>     batadv_tt_local_purge(bat_priv, timeout, false);
>     batadv_tt_local_purge_pending_clients(bat_priv);
> 
> batadv_tt_local_purge_pending_clients() is called right after, in the same
> loop. It also walks every bucket of the local hash, and it still uses
> per-bucket spin_lock_bh()/spin_unlock_bh().
> 
> Should it be converted too, so that the tt_purge loops are handled
> consistently?

Yes it should be.

> The Fixes: tag points at c6c8fea29769, the initial batman-adv import. Is
> there a more specific commit that introduced the problem syzbot reported?

I didnt have a more specific commit to point to. I'll drop
the Fixes: tag and send this as a batadv-next optimization.

>> diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
>> index 46304069b3b75..f64f31e25c6b0 100644
>> --- a/net/batman-adv/translation-table.c
>> +++ b/net/batman-adv/translation-table.c
>> @@ -1832,21 +1832,29 @@ static void batadv_tt_local_purge_list(struct batadv_priv *bat_priv,
>>   *  inactive or not
>>   */
>>  static void batadv_tt_local_purge(struct batadv_priv *bat_priv,
>> -                               int timeout)
>> +                               int timeout, bool may_sleep)
> 
> [Severity: Low]
> The kernel-doc block above batadv_tt_local_purge() still documents only
> @bat_priv and @timeout. Should an @may_sleep line be added?

Yes.

> scripts/kernel-doc will warn that may_sleep is not described. The new
> parameter also has a contract worth documenting: it must be false when
> the caller holds a spinlock such as tt.commit_lock.
> 
>>  {
>>       spinlock_t *list_lock; /* protects write access to the hash lists */
>>       struct batadv_hashtable *hash = bat_priv->tt.local_hash;
>>       struct hlist_head *head;
>>       u32 i;
>>  
>> +     local_bh_disable();
>>       for (i = 0; i < hash->size; i++) {
>>               head = &hash->table[i];
>>               list_lock = &hash->list_locks[i];
>>  
>> -             spin_lock_bh(list_lock);
>> +             spin_lock(list_lock);
>>               batadv_tt_local_purge_list(bat_priv, head, timeout);
>> -             spin_unlock_bh(list_lock);
>> +             spin_unlock(list_lock);
>> +
>> +             if (may_sleep && (i & 63) == 63) {
>> +                     local_bh_enable();
>> +                     cond_resched();
>> +                     local_bh_disable();
>> +             }
> 
> [Severity: Low]
> With the outer local_bh_disable(), bottom halves now stay disabled for up
> to 64 buckets of the hash instead of one.
> 
> Before this patch, each spin_unlock_bh() let pending softirqs such as
> NET_RX_SOFTIRQ, NET_TX_SOFTIRQ and timers run between buckets. On
> preemptible kernels it also allowed the worker to be preempted there.
> 
> Could this increase softirq latency on the CPU running batadv_tt_purge()?
> On PREEMPT_RT, local_bh_disable() also holds the per-CPU softirq lock for
> the whole 64-bucket window.

Intentional tradeoff. Softirq latency on that CPU increases for the
duration of 64 bucket iterations. Each iteration takes and releases a
per-bucket spinlock around a list walk. The actual latency depends on
how many entries are in those buckets. On PREEMPT_RT, local_bh_disable()
maps to migrate_disable() and does not hold the per-CPU softirq lock.
Softirqs run in their own kthread on RT, so they are not blocked by
local_bh_disable(). The latency concern applies mainly to non-RT kernels.

> batadv_tt_global_purge() gets the same wider window, and there the
> re-enable runs unconditionally.

batadv_tt_global_purge() is only called from the workqueue
worker, so the drain + cond_resched() runs unconditionally there
without needing may_sleep.


> Would it work to keep the per-bucket spin_lock_bh() and only add the
> cond_resched() every 64 buckets? That would give the same scheduling
> point without the longer windows or the new may_sleep parameter.

That would add a scheduling point, but it would still re-enable BHs
after every bucket. The worker could still be pulled into pending
softirq processing at each of those points.
The batching is intended to reduce how often that happens. cond_resched()
alone would not address that part of the problem.

> Regards,
> 	Sven

Thanks for the review,

I think keeping the batching approach is the better option since
cond_resched() alone does not reduce the number of inline softirq
drains. But if you prefer the simpler per-bucket spin_lock_bh()
with only cond_resched(), I will go that route for v2.

Thanks,
Ömer
