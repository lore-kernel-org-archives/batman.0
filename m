Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABADFC27C53
	for <batman-adv@archiver.kernel.org>; Wed, 12 Jun 2024 16:32:32 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0B12F83AAE
	for <batman-adv@archiver.kernel.org>; Wed, 12 Jun 2024 18:32:31 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1718209951;
 b=HkAvJIe2in4LQk81jdUKuy8TqKdvHFnzp2j6SbQTwAzJ4ZpwgPiWpcSBXUCZIyhuuIfeR
 3t7WwWo+1+An8XLBdBUxmewSH965RCtvL3gz1O6HpIvfVM74I/ZS4fg1WFQRsw9oTEEbJNn
 +Epd1U26PBXVrs6+a5+UY1qniLVHo9k=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1718209951; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Gl/uW5z81EQ9LLKAEN0DIg2T9m786t3BMQR5oiMWySs=;
 b=I8gxRs/Yg7s8EmG8mOoB8In9ms0aSb6t8jLACiTRc2UovqokRiugJ7esMHs5ffzOQhmQM
 EYdBJz73Xo/FKKYEbR5suIzP4to3JtJBleu6LewFghTSbOs5ikoOSzgINalABBkIORu+aPH
 /IfBwIX/XSPY23x4XOT1SHf9tsuHZAM=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de
 [IPv6:2a01:4f8:c2c:665b::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 75F96821AD
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 12 Jun 2024 18:31:59 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1718209919; a=rsa-sha256;
	cv=none;
	b=eHtbjmqW0eezmqT/Bvm9NKnFHad2/Z88HFLp1EJISN8o3BlzFabdS1nRnrFpk3nssizF+7
	ivjzGucDZb3SzJuU5DL7WCqIKIXZ6KLASFs4cfnl+q3pNoh53jfoq4ZbSnNISgUgnzEzwS
	dMsMj1UoMJQq6d7IUHMPvTyVV3x74OU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 2a01:4f8:c2c:665b::1 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1718209919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gl/uW5z81EQ9LLKAEN0DIg2T9m786t3BMQR5oiMWySs=;
	b=r905FlihbvdrbpKN9LDzYO30ZOTzckHCFIDJYSw9MzJGpGMXG2MrON4HVrS7bISl4wPV6n
	oyFAfFKmF4kIPI8Pde+vFT8XtQ4eH0FR9RGJg+ZAJsRl+U3KxNrhtz2q3FW4jYnmnnQSwM
	OqpVMoiDAe6xJ2GDGoJue8Xgxb2ybuc=
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B1C193EF21;
	Wed, 12 Jun 2024 18:31:52 +0200 (CEST)
Date: Wed, 12 Jun 2024 18:31:57 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Dmitry Antipov <dmantipov@yandex.ru>,
	netdev@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH] Revert "batman-adv: prefer kfree_rcu() over call_rcu()
 with free-only callbacks"
Message-ID: <ZmnNfU44NekafjA_@sellars>
References: <20240612133357.2596-1-linus.luessing@c0d3.blue>
 <e36490a1-32af-4090-83a7-47563bce88bc@paulmck-laptop>
 <ZmmzE6Przj0pCHek@sellars>
 <Zmm2uTHTge-i3eCM@sellars>
 <020489fa-26a3-422c-8924-7dc71f23422c@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <020489fa-26a3-422c-8924-7dc71f23422c@paulmck-laptop>
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: M4NV7PYDWHYJMY3QRLML7FEJOFNTS2LR
X-Message-ID-Hash: M4NV7PYDWHYJMY3QRLML7FEJOFNTS2LR
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/M4NV7PYDWHYJMY3QRLML7FEJOFNTS2LR/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Wed, Jun 12, 2024 at 09:06:25AM -0700, Paul E. McKenney wrote:
> We are looking into nice ways of solving this, but in the meantime,
> yes, if you are RCU-freeing slab objects into a slab that is destroyed
> at module-unload time, you currently need to stick with call_rcu()
> and rcu_barrier().
> 
> We do have some potential solutions to allow use of kfree_rcu() with
> this sort of slab, but they are still strictly potential.
> 
> Apologies for my having failed to foresee this particular trap!
> 
> 							Thanx, Paul

No worries, thanks for the help and clarification! This at least
restored my sanity, was starting to doubt my understanding of RCU
and the batman-adv code the longer I tried to find the issue in
batman-adv :D.
