Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB083CF2590
	for <batman@archiver.kernel.org>; Mon, 14 Oct 2024 06:58:28 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1A1DA83F4A
	for <batman@archiver.kernel.org>; Mon, 14 Oct 2024 08:58:26 +0200 (CEST)
ARC-Seal: i=2; cv=fail; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1728889106;
 b=WAAQWeW3krCc7JdjC3P2vxi/FJaoNjwZnub/WmM870Gjx1sgksI/xnxE7LKGug4vQ/F8m
 GZMvWV/mHDB0lN08IfsDX7GH+yl9kLncgzNsHkpkuOXZrgUY6jCHtY3/U3o1LRBATY0Tgq7
 IdzsPme3jqEwkb7j5rAUqsTjaS8col8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1728889106; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=YqtDK7QfopzOi6b82zo9ZPxlNTmjGRKlUMjxc3XnxKQ=;
 b=hhNlxYXJIJXrWz6KWPb6qMJS7CHG90UfB01PH9CMPSPfwTQHOl+EyQwjonRj8Xhl+QdbA
 9VdyHWCMGYOjZ4sEV3GijDiwZv5x1jqoTEGFK9x9gED0ks+8se59hXH6uqAEmKQr4HLefw9
 SHmuFX/3NcFuZR03X78bOvSXhtUp2Jg=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=kernel.org;
  arc=fail (ARC-Seal[1] did not validate);
  dmarc=pass (Used From Domain Record) header.from=kernel.org
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=fail (ARC-Seal[1] did not validate);
 dmarc=pass (Used From Domain Record) header.from=kernel.org
 policy.dmarc=quarantine
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 176AF80150
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 14 Oct 2024 02:31:31 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1728865892; a=rsa-sha256;
	cv=none;
	b=JyB//zwNuPTktRHvhBCoIVMNoS43pK7l7xO0rYkUL5v9AMKZJyqtWY8C4hb1zrjcocQtmY
	04CssmV072N8F9ELaKPiXRZJs5wxMSALGOISPrbw5R0C63HNc3hE2JKvPh5RSos6ueotps
	pmGDcVO7YQpImPyrfev8Qv6B6WtU9So=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=r9YqRKuw;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (diktynna.open-mesh.org: domain of
 "SRS0=BO0x=RK=paulmck-ThinkPad-P17-Gen-1.home=paulmck@kernel.org" designates
 147.75.193.91 as permitted sender)
 smtp.mailfrom="SRS0=BO0x=RK=paulmck-ThinkPad-P17-Gen-1.home=paulmck@kernel.org"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1728865892;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:
	 references:references:dkim-signature;
	bh=YqtDK7QfopzOi6b82zo9ZPxlNTmjGRKlUMjxc3XnxKQ=;
	b=EtB5L9gYM2GJhjC1CHGlVl9wNipP/6mSPVRu5m3EC9MioB4fCEbW36RSC1RWKr/lMFJRN9
	TyDHBXyUyxWW3N8sdxmn+gz3XhhVLtcLqLo4zmNDy4xGxhcRtWDIBoSz5mp3OB0PP59RMZ
	UWrlvQ+bcDb2p6FmL487UZ2aLMMRoho=
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id C8AA7A4089B;
	Mon, 14 Oct 2024 00:31:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E461C4CEC5;
	Mon, 14 Oct 2024 00:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728865890;
	bh=XvIpO0hMtyh3Po24emY82DbVHrbP5ytugA80vx/L/C4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=r9YqRKuw96RsL0f2maCvk78OVekNkjc1FC0l5peRj1xFsFUp+Wk6XpDbm8K/I8Dat
	 NtYj6Bt7tAjktwuIEYkK2pE6Nlz6suRz3IANFU3iMXWxI7B7SBdTbd2IFcE2RMqhNe
	 Gzl7d51zCrp3PEv9lrIW1gc/wLVjkJdAhHf/b8suVLDK9/64J6axNZwU42guB6nhKd
	 Bi+uaQAfSmkkbJhfVBfu3ahXZQy9cxY9cRnT2opvnrVBsZZFVpqu2kKlHbRWIQ75Yc
	 VF5aZimutRyJow22wfPFMyDIphrxGhIuf1iV5oDIrKq8jmbchhfe2c3wMu4V4yxCL9
	 zZuh3mAA+h63Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 043ABCE0D17; Sun, 13 Oct 2024 17:31:30 -0700 (PDT)
Date: Sun, 13 Oct 2024 17:31:30 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: linux-nfs@vger.kernel.org, kernel-janitors@vger.kernel.org,
	vbabka@suse.cz, Tom Talpey <tom@talpey.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>, Neil Brown <neilb@suse.de>,
	linux-can@vger.kernel.org, bridge@lists.linux.dev,
	b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org,
	wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
	ecryptfs@vger.kernel.org, linux-block@vger.kernel.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [PATCH 00/17] replace call_rcu by kfree_rcu for simple
 kmem_cache_free callback
Message-ID: <47a98e77-8bbf-48d7-bb52-50e85a5336a0@paulmck-laptop>
References: <20241013201704.49576-1-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241013201704.49576-1-Julia.Lawall@inria.fr>
X-MailFrom: SRS0=BO0x=RK=paulmck-ThinkPad-P17-Gen-1.home=paulmck@kernel.org
X-Mailman-Rule-Hits: max-recipients
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; nonmember-moderation;
 administrivia; implicit-dest; max-size; news-moderation; no-subject; digests;
 suspicious-header
Message-ID-Hash: ZCUYYB2N4MRQ4E576OUXY337GDKG424D
X-Message-ID-Hash: ZCUYYB2N4MRQ4E576OUXY337GDKG424D
X-Mailman-Approved-At: Mon, 14 Oct 2024 08:56:06 +0200
X-Mailman-Version: 3.3.8
Precedence: list
Reply-To: paulmck@kernel.org
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ZCUYYB2N4MRQ4E576OUXY337GDKG424D/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Sun, Oct 13, 2024 at 10:16:47PM +0200, Julia Lawall wrote:
> Since SLOB was removed and since
> commit 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache_destroy()"),
> it is not necessary to use call_rcu when the callback only performs
> kmem_cache_free. Use kfree_rcu() directly.
> 
> The changes were done using the following Coccinelle semantic patch.
> This semantic patch is designed to ignore cases where the callback
> function is used in another way.

For the series:

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> // <smpl>
> #spatch --all-includes --include-headers
> 
> @r@
> expression e;
> local idexpression e2;
> identifier cb,f,g;
> position p;
> @@
> 
> (
> call_rcu(...,e2)
> |
> call_rcu(&e->f,cb@p)
> |
> call_rcu(&e->f.g,cb@p)
> )
> 
> @r1@
> type T,T1;
> identifier x,r.cb;
> @@
> 
>  cb(...) {
> (
>    kmem_cache_free(...);
> |
>    T x = ...;
>    kmem_cache_free(...,(T1)x);
> |
>    T x;
>    x = ...;
>    kmem_cache_free(...,(T1)x);
> )
>  }
> 
> @s depends on r1@
> position p != r.p;
> identifier r.cb;
> @@
> 
>  cb@p
> 
> @script:ocaml@
> cb << r.cb;
> p << s.p;
> @@
> 
> Printf.eprintf "Other use of %s at %s:%d\n" cb (List.hd p).file (List.hd p).line
> 
> @depends on r1 && !s@
> expression e;
> identifier r.cb,f,g;
> position r.p;
> @@
> 
> (
> - call_rcu(&e->f,cb@p)
> + kfree_rcu(e,f)
> |
> - call_rcu(&e->f.g,cb@p)
> + kfree_rcu(e,f.g)
> )
> 
> @r1a depends on !s@
> type T,T1;
> identifier x,r.cb;
> @@
> 
> - cb(...) {
> (
> -  kmem_cache_free(...);
> |
> -  T x = ...;
> -  kmem_cache_free(...,(T1)x);
> |
> -  T x;
> -  x = ...;
> -  kmem_cache_free(...,(T1)x);
> )
> - }
> 
> @r2 depends on !r1@
> identifier r.cb;
> @@
> 
> cb(...) {
>  ...
> }
> 
> @script:ocaml depends on !r1 && !r2@
> cb << r.cb;
> @@
> 
> Printf.eprintf "need definition for %s\n" cb
> // </smpl>
> 
> ---
> 
>  arch/powerpc/kvm/book3s_mmu_hpte.c  |    8 ------
>  block/blk-ioc.c                     |    9 ------
>  drivers/net/wireguard/allowedips.c  |    9 +-----
>  fs/ecryptfs/dentry.c                |    8 ------
>  fs/nfsd/nfs4state.c                 |    9 ------
>  kernel/time/posix-timers.c          |    9 ------
>  net/batman-adv/translation-table.c  |   47 ++----------------------------------
>  net/bridge/br_fdb.c                 |    9 ------
>  net/can/gw.c                        |   13 ++-------
>  net/ipv4/fib_trie.c                 |    8 ------
>  net/ipv4/inetpeer.c                 |    9 +-----
>  net/ipv6/ip6_fib.c                  |    9 ------
>  net/ipv6/xfrm6_tunnel.c             |    8 ------
>  net/kcm/kcmsock.c                   |   10 -------
>  net/netfilter/nf_conncount.c        |   10 -------
>  net/netfilter/nf_conntrack_expect.c |   10 -------
>  net/netfilter/xt_hashlimit.c        |    9 ------
>  17 files changed, 23 insertions(+), 171 deletions(-)
