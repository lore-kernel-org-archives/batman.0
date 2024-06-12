Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AEF6C27C77
	for <batman-adv@archiver.kernel.org>; Wed, 12 Jun 2024 14:39:51 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C58058305C
	for <batman-adv@archiver.kernel.org>; Wed, 12 Jun 2024 16:39:49 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1718203189;
 b=c8V4xh032z944MzBPFgMcEgwdQyD0lUQR1txEB9+jWrv18Vs9E1GTxx+WlDFp4utX2nS9
 VufKa87CcVMCUg+oFMIpUuZZyXaT2kif4AnMnVmznc2HXoLxuUGsU8kgKqDuq61a758pv68
 lPZ0PIvvBVkwjObF/Yv9FMR2mafA3lo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1718203189; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=GgzLVJieNlV+N7VHsXkfisxo5WwQ0apenTv7h9jCGxE=;
 b=pUZCC4v/F/7GkY085hg/0BTgqUkzKCdUV7pp9zZyMJ9jwZz5KlAKuu5qRnMhcj9+xlCou
 NMcwKMPl356E6+yk72wslKfiohiQoNFrn4HpGV+JsenQgU3EJYHvVAWN68ywYZ8OjLONv8r
 ER8Ew+k5HgUWyOVEMLbIGTnTLXJ/yoU=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id AA10981B88
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 12 Jun 2024 16:39:17 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1718203157; a=rsa-sha256;
	cv=none;
	b=tNJXLXKc70ELsiPQuhHJrfs9I5v3VatS/oZfUQUKDlY4XV0k4cHtD2g5pH1mlJqfXc+BYo
	ohg+miNBbh9691R7LQHBHppZKy+TmeFklZqjAdAwg1Ro8/BdRYDQb8HjsTLYYE6usb3uVJ
	6hFvlxMI7a5TqeWTU1JWtjT3uEzJt0Y=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 116.203.183.178 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1718203157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GgzLVJieNlV+N7VHsXkfisxo5WwQ0apenTv7h9jCGxE=;
	b=qJVXgFPSj+bQs1gqt38l60jFy3Y4151D6U9RgRFLvKGmdEcidOdekTDK/WjMlqaZtkSIh5
	JzdxgwQwUNF0ihpyP3cP0fJHC8Vn4bOFOdkvKs9FtHCfijWujSLg3yYiAMjfgHxfxIbugp
	bvrn14J0YZt23SWtpLSU4rHuUua2B7c=
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 357533EDE0;
	Wed, 12 Jun 2024 16:39:11 +0200 (CEST)
Date: Wed, 12 Jun 2024 16:39:15 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Dmitry Antipov <dmantipov@yandex.ru>,
	netdev@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH] Revert "batman-adv: prefer kfree_rcu() over call_rcu()
 with free-only callbacks"
Message-ID: <ZmmzE6Przj0pCHek@sellars>
References: <20240612133357.2596-1-linus.luessing@c0d3.blue>
 <e36490a1-32af-4090-83a7-47563bce88bc@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e36490a1-32af-4090-83a7-47563bce88bc@paulmck-laptop>
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: AVTMRIM64CPBIAY5JBRVMT3B65KYQNV7
X-Message-ID-Hash: AVTMRIM64CPBIAY5JBRVMT3B65KYQNV7
X-MailFrom: linus.luessing@c0d3.blue
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/AVTMRIM64CPBIAY5JBRVMT3B65KYQNV7/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Wed, Jun 12, 2024 at 07:06:04AM -0700, Paul E. McKenney wrote:
> Let me make sure that I understand...
> 
> You need rcu_barrier() to wait for any memory passed to kfree_rcu()
> to actually be freed?  If so, please explain why you need this, as
> in what bad thing happens if the actual kfree() happens later.
> 
> (I could imagine something involving OOM avoidance, but I need to
> hear your code's needs rather than my imaginations.)
> 
> 							Thanx, Paul

We have allocated a kmem-cache for some objects, which are like
batman-adv's version of a bridge's FDB entry.

The very last thing we do before unloading the module is
free'ing/destroying this kmem-cache with a call to
kmem_cache_destroy().

As far as I understand before calling kmem_cache_destroy()
we need to ensure that all previously allocated objects on this
kmem-cache were free'd. At least we get this kernel splat
(from Slub?) otherwise. I'm not quite sure if any other bad things
other than this noise in dmesg would occur though. Other than a
stale, zero objects entry remaining in /proc/slabinfo maybe. Which
gets duplicated everytime we repeat loading+unloading the module.
At least these entries would be a memory leak I suppose?

```
# after insmod/rmmod'ing batman-adv 6 times:
$ cat /proc/slabinfo  | grep batadv_tl_cache
batadv_tl_cache        0     16    256   16    1 : tunables    0    0    0 : slabdata      1      1      0
batadv_tl_cache        0     16    256   16    1 : tunables    0    0    0 : slabdata      1      1      0
batadv_tl_cache        0     16    256   16    1 : tunables    0    0    0 : slabdata      1      1      0
batadv_tl_cache        0     16    256   16    1 : tunables    0    0    0 : slabdata      1      1      0
batadv_tl_cache        0     16    256   16    1 : tunables    0    0    0 : slabdata      1      1      0
batadv_tl_cache        0     16    256   16    1 : tunables    0    0    0 : slabdata      1      1      0
```

That's why we added this rcu_barrier() call on module
shutdown in the batman-adv module __exit function right before the
kmem_cache_destroy() calls. Hoping that this would wait for all
call_rcu() / kfree_rcu() callbacks and their final kfree() to finish.
This worked when we were using call_rcu() with our own callback
with a kfree(). However for kfree_rcu() this somehow does not seem
to be the case anymore (- or more likely I'm missing something else,
some other bug within the batman-adv code?).

Regards, Linus
