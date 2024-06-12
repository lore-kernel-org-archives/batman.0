Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE7E4C27C53
	for <batman-adv@archiver.kernel.org>; Wed, 12 Jun 2024 16:07:02 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2D07683231
	for <batman-adv@archiver.kernel.org>; Wed, 12 Jun 2024 18:07:01 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1718208421;
 b=SFKIMOMZpw0AGFjekzcFfqaxV7nsfOgx/kpAzcGZvKeEagPA3r75VVF+ittAnJdaGICAJ
 cPhgYql6Hy4pMZ4kxS8JQqOIQj4cmB+eGcV+3JM1p2afh7oBX/0riPC3kEG2kZSDTh73SeG
 FIzULE+Vlxxe9AZG0KdhtG2Ynp/J3jA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1718208421; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=OPiftIHhyHe2391+OBLGJ24ma9TXk6jDk6Rj0yYovhM=;
 b=rMMyqookNLcTtUMXZnZi0E89H9xZ4B6bFlBDuwLlgB34Dj/4KqYrIyT8VTWqsg7tfTzih
 MgSCollbsUxycb91P/dk1PYp7fqUx1JKlM3dyFRwcQ6juY3Q6lqg1QyAU/O5oi0cOj8U/FN
 dL+rRNeWabENfUtf/lPQnsgd0nXa5R0=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=kernel.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=kernel.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=none
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id E55B881F32
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 12 Jun 2024 18:06:27 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1718208388; a=rsa-sha256;
	cv=none;
	b=XX7Rpn9qHBFjMIHtVft5qHokkyqUaPirkZI+ROCI0iUAJstUNugaMP1TLo255+gGo+2PHk
	txZq0ijfyzwD9XKJhgW47UX8zDMUbLCFbLRc8Lu9H9hFaEm7xWggxDG9iKm8yH6Jh1Noyi
	kb1GxkfubzPsfW4W2glN3tvmybZk0Iw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=ji18+OB0;
	dmarc=pass (policy=none) header.from=kernel.org;
	spf=pass (diktynna.open-mesh.org: domain of
 "SRS0=Q+OH=NO=paulmck-ThinkPad-P17-Gen-1.home=paulmck@kernel.org" designates
 2604:1380:4641:c500::1 as permitted sender)
 smtp.mailfrom="SRS0=Q+OH=NO=paulmck-ThinkPad-P17-Gen-1.home=paulmck@kernel.org"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1718208388;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=OPiftIHhyHe2391+OBLGJ24ma9TXk6jDk6Rj0yYovhM=;
	b=ORb7EKNAdOYKkrA4HWyYrH98XJ0goqmHwft9NPW9mUFeuD7iK0AfxX7ViEh7rsOcRSBYPe
	S8dil3xPOqY+c8X4h7j47At0Ty29C/obKeL3wbhDygpH2YFNmhVyZDW37H7WHwY6RjtasQ
	iX9xHpCeYyBYczBp20TRLk0RW0cJJpg=
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id AF210614D8;
	Wed, 12 Jun 2024 16:06:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658AAC32786;
	Wed, 12 Jun 2024 16:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718208386;
	bh=KfoVhQGh1ffGN+Vv/trt9qEbjqFsRTAgAAT6pA2n4y8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ji18+OB0ffeaYYoh2I/BYqePx0vozflXX5LIjRAzhqTtR0WDQyoQBTeQPkQSbIIsi
	 IWrMtYhs8EMKIJHLxyb4pB8O4MOYJukaZZtLizdNvzEFaM4M47VMSiV4eZaGRFNPkL
	 fFZuYzvxgF5Ah0OeZyTMue88PLY1QUyiZM3aNn60YjOp9YllKbTMBjmjlaaGLXJ87N
	 SA/P15Dz1Ofy9c494GHGSXsSoqHe+8nMu8sl5DZve0wDKNngbjO3ZjhgE1PyM/WJUc
	 gTa6k30o/w+z4CI59g9ixPbvXR/0miPVhP7TsfqAho4NfDJyC7ULNptufK8GruQqXz
	 xJt+qsOLEELAw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 027C1CE0DEA; Wed, 12 Jun 2024 09:06:25 -0700 (PDT)
Date: Wed, 12 Jun 2024 09:06:25 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Dmitry Antipov <dmantipov@yandex.ru>,
	netdev@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH] Revert "batman-adv: prefer kfree_rcu() over call_rcu()
 with free-only callbacks"
Message-ID: <020489fa-26a3-422c-8924-7dc71f23422c@paulmck-laptop>
References: <20240612133357.2596-1-linus.luessing@c0d3.blue>
 <e36490a1-32af-4090-83a7-47563bce88bc@paulmck-laptop>
 <ZmmzE6Przj0pCHek@sellars>
 <Zmm2uTHTge-i3eCM@sellars>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zmm2uTHTge-i3eCM@sellars>
Message-ID-Hash: PJTUQIBFQM2NGYLL3A6DLWOFLQB4JF4M
X-Message-ID-Hash: PJTUQIBFQM2NGYLL3A6DLWOFLQB4JF4M
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/PJTUQIBFQM2NGYLL3A6DLWOFLQB4JF4M/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Wed, Jun 12, 2024 at 04:54:49PM +0200, Linus Lüssing wrote:
> On Wed, Jun 12, 2024 at 04:39:15PM +0200, Linus Lüssing wrote:
> > On Wed, Jun 12, 2024 at 07:06:04AM -0700, Paul E. McKenney wrote:
> > > Let me make sure that I understand...
> > > 
> > > You need rcu_barrier() to wait for any memory passed to kfree_rcu()
> > > to actually be freed?  If so, please explain why you need this, as
> > > in what bad thing happens if the actual kfree() happens later.
> > > 
> > > (I could imagine something involving OOM avoidance, but I need to
> > > hear your code's needs rather than my imaginations.)
> > > 
> > > 							Thanx, Paul
> > [...]
> > As far as I understand before calling kmem_cache_destroy()
> > we need to ensure that all previously allocated objects on this
> > kmem-cache were free'd. At least we get this kernel splat
> > (from Slub?) otherwise. I'm not quite sure if any other bad things
> > other than this noise in dmesg would occur though. Other than a
> > [...]
> 
> I guess, without knowing the details of RCU and Slub, that at
> least nothing super serious, like a segfault, can happen when
> the remaining execution is just a kfree(), which won't need
> access to batman-adv internal functions anymore.

We are looking into nice ways of solving this, but in the meantime,
yes, if you are RCU-freeing slab objects into a slab that is destroyed
at module-unload time, you currently need to stick with call_rcu()
and rcu_barrier().

We do have some potential solutions to allow use of kfree_rcu() with
this sort of slab, but they are still strictly potential.

Apologies for my having failed to foresee this particular trap!

							Thanx, Paul
