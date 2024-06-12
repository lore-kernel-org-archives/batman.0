Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66504C27C53
	for <batman-adv@archiver.kernel.org>; Wed, 12 Jun 2024 18:24:20 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id ACB7C8332C
	for <batman-adv@archiver.kernel.org>; Wed, 12 Jun 2024 20:24:18 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1718216658;
 b=bOsiH7AloDpN+DSJYDdopjKGowXzHEwkl+q+xIOtrra9tabiTafUweokttOPFdF33sL/j
 sht+kKjTme8MfagsfC79NK1PnTL0eBRWDNnUukF8EP+edeOlPJkHIn8lHhg4rB2lj0x7HC5
 +3vIJK65AYFh+jO9tbiwG8GlO8V4Fn8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1718216658; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=cjViDW1ofcPI9Q3XzCSNNVOySVpdiDhgF1rEIa0r7VA=;
 b=QXRy91ktMbOZydCI9xEtwq+l8itb7Fibtgv6hz+Y06KiFO+Jg1VuNvf8eMwZ4Vxt7IW/K
 QHLpVKHt8/fu5I+5EidAs8Ql6APaRuM5uuRApS/diY33Z37pCPHjOzW7eGbfwWM2+bJIZBV
 RLMfvcaDKQGJLOGHJZ1KSoNARP/hG88=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 4C20B8015A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 12 Jun 2024 18:25:11 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1718209511; a=rsa-sha256;
	cv=none;
	b=iZ9kfug00nxiTB22yxV8TxU1gBpvFpr8S/WS+P8mpp7CXyiBSxX8dLQ/XkyePSPsJ1u4Ef
	fxW/7uzseU4UhZ6wM22BLnHIvn9J6VY/jPl1Safm8IREjng+9FkGN7QlaPEkPgTL7Xo5S4
	Q3cdoJW0HQ0JdlXOU5Bs02ecVDDkpKw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=Sf53+hTp;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (diktynna.open-mesh.org: domain of urezki@gmail.com designates
 2a00:1450:4864:20::131 as permitted sender) smtp.mailfrom=urezki@gmail.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1718209511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=cjViDW1ofcPI9Q3XzCSNNVOySVpdiDhgF1rEIa0r7VA=;
	b=f9Zn/N6N8tDxq2q8xpKQc1YevTXB2i0ksrHvwdRb31hNblOogUsyfWyM/7YuuKh6I4mklu
	niwSeu1higiW3mezCdOzqqm7SZC+yfjbsiEifu7P9dLxoLtQv2Y12+/FqRDDMQtI28fxjl
	2KvcHwQAHEf0jBAoMl2OFWVK9udZl2s=
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-52bd48cf36bso74365e87.3
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Wed, 12 Jun 2024 09:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718209510; x=1718814310;
 darn=lists.open-mesh.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cjViDW1ofcPI9Q3XzCSNNVOySVpdiDhgF1rEIa0r7VA=;
        b=Sf53+hTpnJ0cJsRVSvn52YRaKTBWSqWc8H0gQoXmvM5EkmuYhV4Ruz8hTgGzQIP85a
         zwooXRZCz0V7cFLWo4j5mMAdKs3722wjaabFTHBe3dpvHBNi14tmWydiW4cyJRyuMU1X
         6WVdilqQJ21eXFMhMPPLHoGTi9HrIOPzAieGVyTIUy40Zex5HWnHxZISfKsTQfAlu96z
         608dX5WIyjVLUZRrXB6GHIG+iaQayQVjyIkAcA3U/+hXK8ZFNuLrtMrcuAN+dGmbCi+l
         OdcXJ01J4+s5azL2md8BR6r413elOaxW/qWr2MjtVZ/OKKwD03tD9xKBcbwWQ5wWiuGa
         JrVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718209510; x=1718814310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjViDW1ofcPI9Q3XzCSNNVOySVpdiDhgF1rEIa0r7VA=;
        b=iyULZoygpbmCNrpf9YLSgvMbaA4D+1PBuTiW5snv6zwcGeMsx1nCg5LbwUe0kuCmJ7
         MaoLtUkdu7uc76eGJTxxf3Nw3o1szA2U5nVLp8gXHvYTrNntJHWPqZ54N+DFfDelhz/5
         TUiXaabAtSiNhuypxLPzZaG54NzesjP+7pb6uCrtCSdxoGOHA+JiBb9K3v/pfsY6eIHQ
         5y/2uMDiNNRpHDRz31MbBTblQDD80cnPeT/VzVEyol0rUDH3E1veZ7JwCZdA/wfmQ9LB
         z7pfWZAE9GxlKxP8JYdJln1YY05A9/f47p7wu8NfE2eudMtxSSPma0LTU2FU+f1Lslpo
         y+4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5IeBdh8BaF1rsAxVFaJ//7nWzuQXZhpGUTMU4TZQgYNf4fRcy0DZ2VtlB32WADt42D5qQCkvlAcHRfu678LpWYCrKGi90eQwSeWCijMpR
X-Gm-Message-State: AOJu0YzoMCpSCSj2HGRWjide7b8HA3YPc5itQBfIKLG5uLB3kzlUR0oo
	LVCreAQNnM6tC5wNtQ8yBIZj80TDGxHWrMMdLsgL2wZr7lNqdE+X
X-Google-Smtp-Source: 
 AGHT+IHBg4ENXu6zKpZ4W+gE4pdn4C5m09sRJi6Bz+mwDKzOLfMiJn8NxGSpgfnMNC0+xPotL9oCnA==
X-Received: by 2002:a05:6512:20c7:b0:52c:83c2:9670 with SMTP id
 2adb3069b0e04-52c9a405bbcmr1175666e87.69.1718209510177;
        Wed, 12 Jun 2024 09:25:10 -0700 (PDT)
Received: from pc636 (host-90-233-193-23.mobileonline.telia.com.
 [90.233.193.23])
        by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-52c8a3be915sm1465837e87.289.2024.06.12.09.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 09:25:09 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 12 Jun 2024 18:25:06 +0200
To: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>,
	Vlastimil Babka <vbabka@suse.cz>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Dmitry Antipov <dmantipov@yandex.ru>, netdev@vger.kernel.org,
	rcu@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH] Revert "batman-adv: prefer kfree_rcu() over call_rcu()
 with free-only callbacks"
Message-ID: <ZmnL4jkhJLIW924W@pc636>
References: <20240612133357.2596-1-linus.luessing@c0d3.blue>
 <e36490a1-32af-4090-83a7-47563bce88bc@paulmck-laptop>
 <ZmmzE6Przj0pCHek@sellars>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmmzE6Przj0pCHek@sellars>
X-MailFrom: urezki@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: AV5RG5E4YZHNPJ3MWGTFIYDU2GG7QK7Q
X-Message-ID-Hash: AV5RG5E4YZHNPJ3MWGTFIYDU2GG7QK7Q
X-Mailman-Approved-At: Wed, 12 Jun 2024 20:23:22 +0200
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/AV5RG5E4YZHNPJ3MWGTFIYDU2GG7QK7Q/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

+ Vlastimil Babka
+ Matthew Wilcox

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
> 
Some background:

Before kfree_rcu() could deal only with "internal system slab caches" which
are static and live forever. After removing SLAB allocator it become possible
to free a memory over RCU using kfree_rcu() without specifying a kmem-cache
an object belongs to because two remaining allocators are capable of convert
an object to its cache internally.

So, now, kfree_rcu() does not need to be aware of any cache and this is
something new.

In your scenario the cache is destroyed and after that kfree_rcu()
started to free objects into non-existing cache which is a problem.

I have a question to Vlastimil. Is kmem_cached_destroy() removes the
cache right away even though there are allocated objects which have
not yet been freed? If so, is that possible to destroy the cache only
when usage counter becomes zero? i.e. when all objects were returned
back to the cache.

Thank you!

--
Uladzislau Rezki
