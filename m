Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7DDC7113E
	for <batman-adv@archiver.kernel.org>; Thu, 12 Jun 2025 05:45:40 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 40CBD84348
	for <batman-adv@archiver.kernel.org>; Thu, 12 Jun 2025 07:45:39 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1749707139;
 b=ZZb+ItC8PlC4ekz5lkzPcZZLerZXvsZozHima17xnhf3xsnBUQkz+9T1+YacprPALHYCZ
 57ofRdgoCuudIxuc2wy/aUf53DMlXRiLEEbIrID+934gEJP2L7JWJGu9QP85xKgRqHck6jA
 n3g19DESucHY21O0/eDug9k50tMJDs8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1749707139; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=do657oDjexaVXklbe7TgoFljtxh9ylKmt7+n4XApbLg=;
 b=dTZxI0T5q+lK8Rysy6n3WmQHLk3l1Lm9S7LxcQw6PU8e7/j3J/V+7dqn0QxUMQBZdNDUL
 JMjCWIC6hV/UnRbUoZDr8cIlEnvCzGJmWE356kBZRKelHPffT8sfWYuTNkLn/WRwbeXztHh
 jJNImsC1+CB6eG2j0gEQePF8QQcVnbs=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=mailbox.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=mailbox.org
 policy.dmarc=reject
Authentication-Results: open-mesh.org; dkim=pass header.d=mailbox.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=mailbox.org policy.dmarc=reject
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id BCD9281E89
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 12 Jun 2025 07:45:16 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1749707117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=do657oDjexaVXklbe7TgoFljtxh9ylKmt7+n4XApbLg=;
	b=R+Uyf28dCqGIqPKglgoVbpPZrcVbBquSFsawKdThXjzjF3o4sSxhKXkvPeK0HECvx7qX5X
	1ri2fkEX0gfj7yFvwRvwfKLVDDvckVlrxMX6jDiuabvHbxdQcR18GQNc2dWZd7T/2r9lDl
	Cd/xjNiQrQ6xJx2qELW1hZoIY7L7eqc=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1749707117; a=rsa-sha256;
	cv=none;
	b=OWZ4RTLK8Vb47Rej58qq0fH19iXTX8ge2UZXhx7nChFpTkObljgx4UALvqMzfZ4+rcK0Ow
	Q64rQ8+2il2QkybGFpJzEl39DTXh4dD7BqS1wAjj12J2dG+HI3bvCF8Cejn2oiDHVwzQsF
	def6jC1G6ck3EcDETf/DasDLG7ghrys=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=ujj5Vtf3;
	spf=pass (diktynna.open-mesh.org: domain of marek.lindner@mailbox.org
 designates 80.241.56.151 as permitted sender)
 smtp.mailfrom=marek.lindner@mailbox.org;
	dmarc=pass (policy=reject) header.from=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bHs1j3QdVz9scW
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 12 Jun 2025 07:45:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812;
	t=1749707113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=do657oDjexaVXklbe7TgoFljtxh9ylKmt7+n4XApbLg=;
	b=ujj5Vtf37390b856jzA8BK1yNfxrs41hj8tT7Ho/mPJACDqzhz9Tp5SB36G3WIvt4cbesg
	JYdS6MmMWJYJZUmv5Hx5BZEP7O2IUbxg8j9VnkLQa8hpzuloSNLjXzDb2ThgTCJdklqiRd
	O7ciZRBk4VVjvSUUnpmz3rWmWnSNPwEiB5HyZIE7fpY5bxVGoPaM+8ClmpTeoTcHKzBwN2
	TLcaVbqaMuGqzinPWLJ7vZoMW2fFlNlKgeP7qmCBtEL1RbsXr2IdBLdyXI7s3Nu4sAotQ5
	LU5+r6uJsJOh4re1u9Emyyufk2M/DSiNBySBQilx8r+5+oVHSZLRaF+qLAbstg==
From: Marek Lindner <marek.lindner@mailbox.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: suppressing warning about unavailable link speed
Date: Thu, 12 Jun 2025 07:45:12 +0200
Message-ID: <6296400.MhkbZ0Pkbq@voltaire>
In-Reply-To: 
 <CAPzS6u_U+BgkE+Unc_nmikEb45QeN7TVF7MFu=6ckAu-c44=Rw@mail.gmail.com>
References: 
 <CAPzS6u_U+BgkE+Unc_nmikEb45QeN7TVF7MFu=6ckAu-c44=Rw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-MBO-RS-META: 6tfdds1y3monj13xajg9ztj76jqzhjyp
X-MBO-RS-ID: 316b201e8b7cdac238d
Message-ID-Hash: 2ZKHLJGG5UZBTKTXOVBA37D3IQQU57L7
X-Message-ID-Hash: 2ZKHLJGG5UZBTKTXOVBA37D3IQQU57L7
X-MailFrom: marek.lindner@mailbox.org
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/2ZKHLJGG5UZBTKTXOVBA37D3IQQU57L7/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On Monday, June 9, 2025 9:08:07=E2=80=AFPM Central European Summer Time Rus=
tam wrote:
> It seems there is no way to suppress it.
>=20
> I could do `batctl hardif br0.100 to 100000` but only *after* I add the
> interface and get the above warning.

By default batman-adv attempts to determine the link speed automagically. T=
hat=20
is why you see a warning every time that magic fails.


> So here's a suggestion - maybe there could be a "default link speed"
> setting, which, when set, would also suppress the warning?
> And/or allow setting the link speed override *before* adding the interfac=
e.
> Then we could patch systemd-networkd to make it configurable.

Having a default setting for manual link speed is not a bad idea. You'd hav=
e=20
to document well whether this default speed comes into effect only when the=
=20
auto-link-speed detection has failed or always.

=46eel free to propose a patch.


> Or perhaps expand link speed detection to descend into bridges and grab t=
he
> underlying link speeds?

Afaik br0.100 is a VLAN interface which does not provide link speeds on its=
=20
down.

Automatic link detection on the underlying bridge interface will be tricky.=
 If=20
the bride contains multiple slave interfaces which link speed should be use=
d?

Cheers,
Marek



