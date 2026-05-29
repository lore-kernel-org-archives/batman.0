Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8E9CD6E49
	for <batman-adv@archiver.kernel.org>; Fri, 29 May 2026 19:48:03 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A646980FA2
	for <batman-adv@archiver.kernel.org>; Fri, 29 May 2026 21:48:01 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780084081;
 b=R4xAsx+OW7U3yplKeFnX2sOanXPXIwDR8ba9BYaHu01vNBK24JN9Y+CayczlFGL7WvwDT
 uUl3I3surggORtxmuANtYtxREPoPprv6UcbinUumF7kRcj0YbO8fGRWOcx0HhC2XcKQ+y+v
 yVhVpBrdDTw+4/iRpCHe0OEHYx+77RY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780084081; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=179JUm3VpbXnuI7eHWbCZCmEHffJgACXTUZAPW838js=;
 b=WnOVAlCESBgBCi8oVi5ODYXtDZS9NP1vGJlcHsPyG5g3wDvrgEGUxrR3xVcb8CdvEsMvd
 rlMYXheOMshSVIlQ+8jDcZcHET9TF2WKZR/aTCgb2LtIBgHFe8X1e7cHqpebuJEb4pjTmvE
 6zflETxgDGgLlUFfNzA5JuD5LTpBR6o=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id E61BA802BB
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 29 May 2026 21:47:21 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780084052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=179JUm3VpbXnuI7eHWbCZCmEHffJgACXTUZAPW838js=;
	b=ABnAyGwpsXQeUc9pUfL+WqRtOAx7boa+ROJOscUnJb9EIQYL/1BAmI7xKoy4mPx/aob7t6
	NxD2D99TcZEi8/yc/zsOXRtIi58Ai7bntAvM8lzKipzN8PXeMe/AoyLq4/JMOIuu/Cr+00
	ed46NDOmz78jV0mywoYyus/lTmYy1K4=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780084052;
	b=IQNa60E6rbBVKI68wjUfISMbFMqWPwSz6PdWzzTJnN/RN29LwKPciyCVBIwI3ROwPFQTcX
	6re75CsRHaoEShLpEaljSVb/K7uI8GvqwKXuU36XLA/cZI8w/qC+vjO8pnCHfUBHSCMCF/
	IGkfnAjmp0Ai8MmJcTI0fmdJL4AL6T8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ivAS6l8F;
	spf=pass (diktynna.open-mesh.org: domain of kuba@kernel.org designates
 2600:3c04:e001:324:0:1991:8:25 as permitted sender)
 smtp.mailfrom=kuba@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8FFA6601DB;
	Fri, 29 May 2026 19:47:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E99081F00893;
	Fri, 29 May 2026 19:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780084040;
	bh=179JUm3VpbXnuI7eHWbCZCmEHffJgACXTUZAPW838js=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ivAS6l8F9JZ3mbPqI5jVtLWq+a/QQCF1O+pDdRbCjggyPoWBAy3Rt1zJ223/UbDOJ
	 tdfJmq8m8GhlvrIzLDj7q+sNXwTBg3MzMjrGzkveSLKcaHChpRzCOkFt8Ak6hFzUaO
	 JoVqoWOy5PY3FZ0NqSXN5jWQFaqIMgV5j26VlQBYJbjM6vdzeRtvhsW8tQbKGowVqp
	 7/Bezd2wFqdy4nE/tjMyzyn5ZsuHN7971n2Qjc6PEK9dHTxYv1Ntoy2k464MHaFy+t
	 MfoP/5EvdSlziRi5aX3gDUhGQ9/aWn0Wngz94gciGrHaVcm54329x/J8zbg03W8X0x
	 cLep7+dxSVe2Q==
Date: Fri, 29 May 2026 12:47:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sven Eckelmann <sven@narfation.org>
Cc: Simon Wunderlich <sw@simonwunderlich.de>, netdev@vger.kernel.org, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH net-next 01/15] batman-adv: drop batman-adv specific
 version
Message-ID: <20260529124718.30eab6ba@kernel.org>
In-Reply-To: <3637868.44csPzL39Z@sven-desktop>
References: <20260528142924.329658-1-sw@simonwunderlich.de>
	<5075322.GXAFRqVoOG@ripper>
	<20260529112430.09c1a08e@kernel.org>
	<3637868.44csPzL39Z@sven-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Message-ID-Hash: JDDZT6BSF24V5IHLEYMEVOPTUOH2YMPU
X-Message-ID-Hash: JDDZT6BSF24V5IHLEYMEVOPTUOH2YMPU
X-MailFrom: kuba@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/JDDZT6BSF24V5IHLEYMEVOPTUOH2YMPU/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Fri, 29 May 2026 21:23:21 +0200 Sven Eckelmann wrote:
> On Friday, 29 May 2026 20:24:30 CEST Jakub Kicinski wrote:
>  [...] =20
> > >=20
> > > version.c and version.h are there to not recompile more parts of batm=
an-adv=20
> > > than necessary when the linux kernel version changes. Has nothing to =
do
> > > with OOT. If you consider this a no-go, I can also just place=20
> > > generated/utsrelease.h + UTS_RELEASE in the three different files. =20
> >=20
> > Ah! My bad, sorry for the accusation! =F0=9F=99=82
> >=20
> > The re-compilation thing is annoying but it's solvable.
> > Please TAL at commit 3f9ed5f5aa9ecffd2 for inspiration. =20
>=20
> Interesting, didn't knew about it. This should work for the in-function o=
nes=20
> and avoids the const batadv_version string + version.h.
>=20
> https://git.open-mesh.org/batadv.git/commit/?id=3D6f864eb5cfd8315b8f9a291=
67263282fe4593f3a
>=20
>=20
> Now we are left with version.c. MODULE_VERSION doesn't accept "dynamicall=
y=20
> generated" strings for obvious reasons. Which could be handled via:
>=20
> * MODULE_VERSION(UTS_RELEASE) in version.c (keeping it in a separate file)
> * MODULE_VERSION(UTS_RELEASE) in main.c (requires recompilation of main.c)
> * MODULE_VERSION($STATIC_STRING) in main.c (then somebody needs to come u=
p=20
>   with one)
> * something else
>=20
> What would you prefer?

No strong preference, I'd probably go with option 2 since it seems=20
the simplest. But option 1 seems okay, too, if you prefer that.
