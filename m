Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35BE5FF885A
	for <batman-adv@archiver.kernel.org>; Tue,  5 May 2026 06:32:25 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A8A7D85B93
	for <batman-adv@archiver.kernel.org>; Tue, 05 May 2026 08:32:23 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1777962743;
 b=s0k95DyO1My02ScIwFckpgcofSSbly6sNbgWukDquj67BJ7x5+81o+7yefQHJ0+RzbocJ
 HnlSSgoIl1alSOlFE6RPZZFwuHPULIBJRyHkSChAVS2K3qIRhZ8rfPFqtFwqO15PqKk+JJV
 lFyWw5YyWSqnmkxqN+DtDC0PmbbWvJ4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1777962743; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=HD3iTXfKGJBlIpjktgAQIrYhdTUbSK8KQ+y1nR0wWcw=;
 b=BYIukOfaCX2AVYTzhwU8MNC/JtXjrbvB7ynd5ZVaaIOF041fqRtzMrBFhCUkPv0+sPjK7
 VBkw4AyyvbWsHS8dn8PYlfNveh13cdSIdlnf2gKzzcyt3QLX0dkGgRuUwwxXXyA4INjolMI
 YolRDh+BIQ3mli9JAAEm9fK+J6ejDk8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass header.from=kernel.org policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=quarantine
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 09C07816EC
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 05 May 2026 07:21:23 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1777958494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=HD3iTXfKGJBlIpjktgAQIrYhdTUbSK8KQ+y1nR0wWcw=;
	b=i6PSQhdMDMTqP4ICNh3Ke1ADZDy2Xc0d6P8wXYex1bKH04igyFc7B6TsayJF4pAatNnH6u
	5hQEixycSUihL0Z4zNvEOCqlwnNZmt2T8vEMp6giXTgq6QEFFiP0mVfqap28hpYMYdhFam
	FV1zMho1C+RXO4CWQ8eSgetEfuIiLeM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=BluNQRxq;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (diktynna.open-mesh.org: domain of matttbe@kernel.org designates
 172.234.252.31 as permitted sender) smtp.mailfrom=matttbe@kernel.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1777958494;
	b=GfIC7Ffi0iWLhN4VsywMZm1dmQMeY5rHrIfDnyoeIeTIyav5DrcRaLxjHaP5RdxL0Hke+D
	0nUShYdyvOjdsU8VB8852a+/JThtzOkXKl8yXeJZVgl4JBv9q4xCouVXXV2rSZhyOte2Ns
	0XVPzRIrZ3VgdX8lzg9LfNYtieHFqdY=
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D21804062F;
	Tue,  5 May 2026 05:21:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9F1C2BCC7;
	Tue,  5 May 2026 05:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777958481;
	bh=HD3iTXfKGJBlIpjktgAQIrYhdTUbSK8KQ+y1nR0wWcw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=BluNQRxqU/Nb+izLhUsjxTwXDG/jWhQaJheesmKvldmgp/MAx4YPYXNc2aEDjnZeI
	 t2Zj3NDH4D2/HKOxh3nzdHzWqJTMJjMgB6rNA4biUj8NIpz7HBnVutSujpyXPLV3JD
	 JmdcgoUWf48B1eLcDrnR1Nn/4fcwfVUTvtsE1qGkiDqUCPJVeSTU1NZO4g8Kl7F1mj
	 QC4wK3qMrAYYBztQTJExb/itLpMeaKe29VnV6jQwtyv81X90S2ppK5qkARAdkP4qj9
	 /DV6SMmn9aeox/oVeZ7hfzriG/Z5lMgVISyUxaUuBG9ZLioDRPyBz86MULm3todC3t
	 lPX3r8hQ6/lBA==
Date: Tue, 5 May 2026 07:21:13 +0200
From: Matthieu Baerts <matttbe@kernel.org>
To: Sven Eckelmann <sven@narfation.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	Marek Lindner <marek.lindner@mailbox.org>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Antonio Quartulli <antonio@mandelbit.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, b.a.t.m.a.n@lists.open-mesh.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ao Zhou <n05ec@lzu.edu.cn>, Haoze Xie <royenheart@gmail.com>,
	Jiexun Wang <wangjiexun2025@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>, Luxing Yin <tr0jan@lzu.edu.cn>,
	Ruide Cao <caoruide123@gmail.com>, Xin Liu <bird@lzu.edu.cn>,
	Yifan Wu <yifanwucs@gmail.com>, Yuan Tan <yuantan098@gmail.com>,
	stable@kernel.org, "Kernel.org Tools" <tools@kernel.org>
Message-ID: <c75c7d50-36b2-4397-8355-891c83d663c9@kernel.org>
In-Reply-To: <2262783.irdbgypaU6@sven-l14>
References: <20260503-fixes-followup-v1-0-4313278918d3@narfation.org>
 <20260504171051.2b3e47ef@kernel.org> <5990011.DvuYhMxLoT@sven-l14>
 <2262783.irdbgypaU6@sven-l14>
Subject: Re: [PATCH batadv 0/8] batman-adv: follow up fixes
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <c75c7d50-36b2-4397-8355-891c83d663c9@kernel.org>
X-MailFrom: matttbe@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: FAC5RYJW7VC4E2DBNAKVS2F47OGCTHOZ
X-Message-ID-Hash: FAC5RYJW7VC4E2DBNAKVS2F47OGCTHOZ
X-Mailman-Approved-At: Tue, 05 May 2026 08:31:30 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FAC5RYJW7VC4E2DBNAKVS2F47OGCTHOZ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi Sven,

05 May 2026 07:00:27 Sven Eckelmann <sven@narfation.org>:

> On Tuesday, 5 May 2026 06:46:11 CEST Sven Eckelmann wrote:
>> On Tuesday, 5 May 2026 02:10:51 CEST Jakub Kicinski wrote:
>>> On Sun, 03 May 2026 14:22:33 +0200 Sven Eckelmann wrote:
>>>> While reviewing the fixes submitted to batman-adv in the recent weeks,
>>>> further problems in similar or adjecent code was identified. This was =
either
>>>> noticed in the manual review or reported by sashiko.dev.
>>>
>>> Are you CCing netdev to get this reviewed by Sashiko?
>>> Please don't..
>>> We delegate code to sub-sub-systems to lower the patch volume :(
>>>
>>
>> Because of `b4 prep --auto-to-cc`. Will now manually remove you.
>
> To speed up the discussion: @Konstantin, is there a way in b4 to say "sto=
p at
> the sub-sub-systems" when doing `b4 prep --auto-to-cc`? I am just trying =
to get the
> `b4` workflow somehow working with the netdev requirements.

Maybe a new option could be added, but that seems difficult to guess
where to stop, and to which subsystems to apply this.

Can you not simply omit using `b4 prep --auto-to-cc` when working
with "internal" patches?

On my side, that's what I'm doing. I added a .b4-config file with this
content, not to have to specify --set-prefix nor --to:

[b4]
=C2=A0=C2=A0=C2=A0 send-series-to =3D MPTCP Linux <mptcp@lists.linux.dev>
=C2=A0=C2=A0=C2=A0 prep-pre-flight-checks =3D disable-needs-auto-to-cc
=C2=A0=C2=A0=C2=A0 send-prefixes =3D mptcp-next

Cheers,
Matt

