Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D03C4332F
	for <batman@archiver.kernel.org>; Tue, 12 Dec 2023 19:30:47 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9233D8276D
	for <batman@archiver.kernel.org>; Tue, 12 Dec 2023 20:30:45 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1702409445;
 b=ImZ8J6W90tEcSjymg2Dn4eUyWLbfKlT+0HjrxxM4sqbBhibcKRvCPr5kgd1Tkb7Vtq2XG
 xBwdOsPex2ZAGO8QED6C5roxZ5DQPJeqizt07uA5zUVjJ9DxvkkAXmVqMlhX4Hc3LCFJEia
 8SlHVXawIiAUuzetGlikOs3SDeNFyCc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1702409445; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=GqEb8gkKqZeDj9wB9uybkVhtqneww2/AIoFtIGcy6js=;
 b=jg2GRfYpnFmPYx1G6S4IxqZRRKP2aR2rILwkBUQse69Q6Jp9zclETELoz/cSuStFtiwX8
 gfVEpj/PhUaMN6D2u8+AjJ+9BgIyVJTv/7XxkVxHn1lmkPMWb42p4TioUHS65l/dv02mOit
 IJ9xvPYKHCK4FKq564XG7QksvdEvT+E=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=proton.me;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=proton.me
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=proton.me; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=proton.me
 policy.dmarc=quarantine
Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch
 [185.70.43.25])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id C4C4C80E02
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 12 Dec 2023 20:30:40 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1702409440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=GqEb8gkKqZeDj9wB9uybkVhtqneww2/AIoFtIGcy6js=;
	b=fcvVx+H5Op8c32Cf3id2uob9luSFWWmTLgC5zJzAEf/uii52JuSwU9/iWbiRIdgIeNibU3
	aetupqsO8XDEW1Tb7ig1M0k6vfQfgssRuNktpCQLwOyrcqc7kNlzEfiYGBdu2sj8G+JoWs
	38kfzRsbjLvZeKyO+pjpDeL0EHkAYHA=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1702409440; a=rsa-sha256;
	cv=none;
	b=Azp/6SjsD6rk2mKcc2c1zoch6sxpTrZ/v1NmbdXuFCtI+TzVDDpSb6ER1qNfW3sPB4LgEy
	r/an7wDggiqa0QGyerhsuevNee8pAWl6f12kJaMW2Rbrtq7UwH4qOHCcxMY7Ii+jcJhLXI
	a+4VyzrpJYjHIPO1Nj2ksSU6cPXjNg0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=proton.me header.s=protonmail header.b="ACn/oeGO";
	spf=pass (diktynna.open-mesh.org: domain of rchase47@proton.me designates
 185.70.43.25 as permitted sender) smtp.mailfrom=rchase47@proton.me;
	dmarc=pass (policy=quarantine) header.from=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1702409439; x=1702668639;
	bh=GqEb8gkKqZeDj9wB9uybkVhtqneww2/AIoFtIGcy6js=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ACn/oeGOS3Za3z9xeOU8bbuMqRV2RUHmvVAgflO1TFUbHqR68KDxKjKJCWfK36mHc
	 Qsn5Pk4ByMfrHQJy86nr5fxtrucuYKIKNWDa4QyjfYXxpAmUF1Jo5uxEefKt0Yocmi
	 AzIyHHPco2V67UD1BtDGLFmGDmTcbFn4xETmpsqOF3poi/UZVbZFdhwisq4bAmL563
	 rcJn2Ge9w41L/5UobcE5Lt6SmZksoEzhMT2fZmcdBNOpL3fOhjUQAlm0PTr+/5zdJp
	 ea9uPV0RGX7z9uUe+vXI1atGScrTPtKiSkApgR0BGeGoo0AMtj/er1YDBR1m+i/YPw
	 8tXgr37YttyiQ==
Date: Tue, 12 Dec 2023 19:30:24 +0000
To: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>
From: Rich Chase <rchase47@proton.me>
Subject: Re: bat0 not capable of MTU > 1500
Message-ID: 
 <mwhWyjjJXHvw6-948GpvusAWgqEJ_5SglADOQJRkhdzLl_r4VYK7ZWUzRG0UHDswIyUghMf7z_dJXIJzywAtc3js09aedSvTZx0pxkEgU-Y=@proton.me>
In-Reply-To: 
 <Q1WvDb-RVDm4Z2qmDwD2hpBjITfuDQMFtWJYgRrhbad0oE0M76pzK6dfZyGkClGkkJskqjMAB0ZQUpZJ250oUB_EEZaVPqQd2pDEEKknXRM=@proton.me>
References: 
 <Q1WvDb-RVDm4Z2qmDwD2hpBjITfuDQMFtWJYgRrhbad0oE0M76pzK6dfZyGkClGkkJskqjMAB0ZQUpZJ250oUB_EEZaVPqQd2pDEEKknXRM=@proton.me>
Feedback-ID: 93688764:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Message-ID-Hash: CDQ6VNSQYPA3KT52Q2TOGLNYRA6T2FFN
X-Message-ID-Hash: CDQ6VNSQYPA3KT52Q2TOGLNYRA6T2FFN
X-MailFrom: rchase47@proton.me
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/CDQ6VNSQYPA3KT52Q2TOGLNYRA6T2FFN/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

I am trying to create an unimpeded path MTU of 1500 on my OpenWRT router (B=
elkin RT-3200). I built the firmware from git Master, with kernel version 6=
.1, and batman-adv version 2023.2.
I have a batmesh hard-if device mastering an 802.1S mesh, which are both se=
t to MTU=3D2304.

Using Luci (OpenWRT web gui for uci), I set the MTU of bat0 to 1504 to acco=
mmodate .1q vlans on bat0 -- bat0.5, bat0.110, etc.

I see in the system log:

=C2=A0 =C2=A0 kern.err kernel: [751585.375855] bat0: mtu greater than devic=
e maximum


Also, if I do:

=C2=A0 =C2=A0 #> ip link set bat0 mtu 1504


I get:

=C2=A0 =C2=A0 ip: SIOCSIFMTU: Invalid argument


and if I test:

=C2=A0 =C2=A0 #> ip link show bat0

...it says that my mtu is 1500 still.

For my life I can't see anything I'm doing wrong. Why can't bat0
have MTU greater than 1500?

I don't have any other devices mastered by bat0, other than my .1s wifi mes=
h link.

Throwing myself at your mercy. Help?
