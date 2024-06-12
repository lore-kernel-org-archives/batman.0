Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA86EC27C53
	for <batman-adv@archiver.kernel.org>; Wed, 12 Jun 2024 15:02:31 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1783383138
	for <batman-adv@archiver.kernel.org>; Wed, 12 Jun 2024 17:02:30 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1718204550;
 b=PXR1nGQP3tGYkS4LknyAHoeVwmsS0M2zAxNOLqvYVQpsA6+nhUgqDyLlFX7y8VG67UWqK
 OmMgIZYjJgk8x0R4tbpEU+s7DD9UFZ6rfVMX/rGUG6W7QAuObhcav4Ji1rfKe8j+UKNwMYR
 OzpxpBRzE9naMFgVP+J7JEwgBVw6zQM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1718204550; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=RLjmirzzabbAiN3P04LO3cv+TCbxEj/bM8XZsFMsVqE=;
 b=XnoLvUtKKxdd8U5oCYjNYjqTT24mFwxnxHaRc0OnUBdModGA34soFvPFhM2ZWK7yO92Ok
 zY+PWTrum1zIsXRDwRZt3qcUZUTuDnQG2z0cw+GX8bHTiyyHCbk5zjUVV4PLn+rI//nR9fC
 KWrh1qLO/SZfYBjyqF6+ZJJLYgNCWGg=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=kernel.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=kernel.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=none
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 6DFD281B88
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 12 Jun 2024 17:01:55 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1718204515; a=rsa-sha256;
	cv=none;
	b=eWK23hPzABIgYomkKBasYm7N83d6UdahSBy09boGvg/dFShPcbcedSh+Cref9wqVxYnrzY
	Ar87RG3y9my4TB3YOqvJ6uSMdE8Xir2KywVrn6tmrMpAXRea9rjBly9pDwRzDDqXXUTWb0
	bijeUIKA7VXdm3/aXIgeXNLylpQwiI8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=oLU7p+h2;
	dmarc=pass (policy=none) header.from=kernel.org;
	spf=pass (diktynna.open-mesh.org: domain of
 "SRS0=Q+OH=NO=paulmck-ThinkPad-P17-Gen-1.home=paulmck@kernel.org" designates
 139.178.84.217 as permitted sender)
 smtp.mailfrom="SRS0=Q+OH=NO=paulmck-ThinkPad-P17-Gen-1.home=paulmck@kernel.org"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1718204515;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=RLjmirzzabbAiN3P04LO3cv+TCbxEj/bM8XZsFMsVqE=;
	b=vOfg7lQsQu1haNSq7lRUDudrNAeStHUFpWm0mowQ2Lm6I0P2X42l0LBRytOt2NNwA+SFeQ
	iK3Ws+kU8qphJPR/dZVRqdp7LZRRmDqEF4s8czmfRC4Tq/UdIexPX/J8N5QjT1TANcg/Vj
	7cpMPmEHqFaCxLUlwW8c6btuGgg0E+w=
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3CDB7614B9;
	Wed, 12 Jun 2024 15:01:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4CEFC116B1;
	Wed, 12 Jun 2024 15:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718204513;
	bh=hcP2dRqBcbk2aluFXM7c3tT7cDtAwX+vdxiJ/oaPK6s=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=oLU7p+h2ImyCTQgWona+f9JJpHDUfaD9TF4pB4ggw0IzxK+jqxvRl6dkoGE/YTItr
	 Bnyweip+56vaNf4JZWP4c/8f/tBrbXMN6sHlOKZmtYCuNCMAJENs/rGQwb/xWIraLV
	 E+5JQPL1UekLt1RmPrkMniL1Q1xjXJMZCw91ndqWqIT5ena62y/CpVleo1mQTqIeSK
	 zwjzVrSg0/kZj9zhFzU7O/CmSsQ2zSB/mJC9J+0oqvnhCx8Z5EuRg4o5GuY34kC9f7
	 CLzsi85Ui4jMSU8Yra05krNIgP2DzCBo31dwhUEiqtFpKi7PMkRwBWr5MVMkHk8n+G
	 3prAFECVoGFUg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 79BC3CE0DEA; Wed, 12 Jun 2024 08:01:53 -0700 (PDT)
Date: Wed, 12 Jun 2024 08:01:53 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Dmitry Antipov <dmantipov@yandex.ru>,
	netdev@vger.kernel.org, rcu@vger.kernel.org, julia.lawall@inria.fr
Subject: Re: [PATCH] Revert "batman-adv: prefer kfree_rcu() over call_rcu()
 with free-only callbacks"
Message-ID: <0317ae55-4da3-415b-b03c-ae87d3603bab@paulmck-laptop>
References: <20240612133357.2596-1-linus.luessing@c0d3.blue>
 <e36490a1-32af-4090-83a7-47563bce88bc@paulmck-laptop>
 <ZmmzE6Przj0pCHek@sellars>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZmmzE6Przj0pCHek@sellars>
Message-ID-Hash: GB24F56GO5P63JLUQTKPMVXTXK6M3U6M
X-Message-ID-Hash: GB24F56GO5P63JLUQTKPMVXTXK6M3U6M
X-MailFrom: SRS0=Q+OH=NO=paulmck-ThinkPad-P17-Gen-1.home=paulmck@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
Reply-To: paulmck@kernel.org
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/GB24F56GO5P63JLUQTKPMVXTXK6M3U6M/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Wed, Jun 12, 2024 at 04:39:15PM +0200, Linus Lüssing wrote:
> On Wed, Jun 12, 2024 at 07:06:04AM -0700, Paul E. McKenney wrote:
> > Let me make sure that I understand...
> > 
> > You need rcu_barrier() to wait for any memory passed to kfree_rcu()
> > to actually be freed?  If so, please explain why you need this, as
> > in what bad thing happens if the actual kfree() happens later.
> > 
> > (I could imagine something involving OOM avoidance, but I need to
> > hear your code's needs rather than my imaginations.)
> > 
> > 							Thanx, Paul
> 
> We have allocated a kmem-cache for some objects, which are like
> batman-adv's version of a bridge's FDB entry.
> 
> The very last thing we do before unloading the module is
> free'ing/destroying this kmem-cache with a call to
> kmem_cache_destroy().
> 
> As far as I understand before calling kmem_cache_destroy()
> we need to ensure that all previously allocated objects on this
> kmem-cache were free'd. At least we get this kernel splat
> (from Slub?) otherwise. I'm not quite sure if any other bad things
> other than this noise in dmesg would occur though. Other than a
> stale, zero objects entry remaining in /proc/slabinfo maybe. Which
> gets duplicated everytime we repeat loading+unloading the module.
> At least these entries would be a memory leak I suppose?
> 
> ```
> # after insmod/rmmod'ing batman-adv 6 times:
> $ cat /proc/slabinfo  | grep batadv_tl_cache
> batadv_tl_cache        0     16    256   16    1 : tunables    0    0    0 : slabdata      1      1      0
> batadv_tl_cache        0     16    256   16    1 : tunables    0    0    0 : slabdata      1      1      0
> batadv_tl_cache        0     16    256   16    1 : tunables    0    0    0 : slabdata      1      1      0
> batadv_tl_cache        0     16    256   16    1 : tunables    0    0    0 : slabdata      1      1      0
> batadv_tl_cache        0     16    256   16    1 : tunables    0    0    0 : slabdata      1      1      0
> batadv_tl_cache        0     16    256   16    1 : tunables    0    0    0 : slabdata      1      1      0
> ```
> 
> That's why we added this rcu_barrier() call on module
> shutdown in the batman-adv module __exit function right before the
> kmem_cache_destroy() calls. Hoping that this would wait for all
> call_rcu() / kfree_rcu() callbacks and their final kfree() to finish.
> This worked when we were using call_rcu() with our own callback
> with a kfree(). However for kfree_rcu() this somehow does not seem
> to be the case anymore (- or more likely I'm missing something else,
> some other bug within the batman-adv code?).

It is quite possible that some of the recent energy-saving changes
have caused rcu_barrier() to not wait for all kfree_rcu() memory
to be freed.  Which is timely, given a bunch of recently proposed
changes that seemed like a good idea to me at the time.  ;-)

							Thanx, Paul
