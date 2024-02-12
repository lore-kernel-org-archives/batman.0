Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3735C48297
	for <batman@archiver.kernel.org>; Mon, 12 Feb 2024 11:24:23 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D708583DF3
	for <batman@archiver.kernel.org>; Mon, 12 Feb 2024 12:24:21 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1707737061;
 b=QZzxApz7XNsei2ZnX/Evke8TXs3/gCTy8iu6484U+GMIvmr8Bebm1rRlE9lWAvv61uUlO
 MrawU/8MNDM0yOi6C5Gp4pKSMbA5ZdTIPY0JSOvIUjZwSATJL/4+G1Y8EcLaPIu3g2RTqO+
 3MMvEm16Beb6p01SH3zzbV5Mm8mDXOY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1707737061; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=IdW3ANPsOumnUTm35YIcSXXwWb81rhjV/4NqYwmk2Pw=;
 b=bHqJ3/7w+OAljRvoy2u699pxMluKEpuzOujPdzQXGFiCmSxu88CZCBGp1qLKfxAlWOMjB
 DPFy4Ra5qgZ3oshxj4wqs8IacTZOxpXQke0KyjklBexoys0yiN0u6Jriq5UFTOB1HISwFdB
 gqIDoq8oxYtQF93KI5MeGz6+iunwYLM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 0B98B806BA
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 12 Feb 2024 12:23:54 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1707737035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=IdW3ANPsOumnUTm35YIcSXXwWb81rhjV/4NqYwmk2Pw=;
	b=WwWDrD/TkHjTG67W3HgNg++p2FQHVBFYw6k7u/Qp1CbvvTxaPZGZ/VSLpa2l6OzEboNENK
	3Sy/n43Uhsrkz9pYqPnaB3p7I7dGYzV6f30S4rKEhKvV2ilurKUl7lgdr3WxRw0C/OgCso
	NF35qWphHy9Hoi8ZvmAObYWvOsNcUp4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=ehnTOX7x;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1707737035; a=rsa-sha256;
	cv=none;
	b=HIw+jj/5K6aiCNCbASS5XoM/ob7jtXnE9SIPCWs90nhravpgvuh8IMvLvNFNyuyb02eELr
	WG/uU0Mouzir5P+qEMCsmD9XnqQMG63x+JlytoI/8MtDBDBeGfyEpY0CeRPJ902gkzqOYG
	mivpELoevGDV/gCAtTmZ06iebGwJnro=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1707737034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IdW3ANPsOumnUTm35YIcSXXwWb81rhjV/4NqYwmk2Pw=;
	b=ehnTOX7xVqtW5lTFDHFyLRRbQ0lNc35QSCDG8pDLUj2YvuFR1E/SQbn56rHpD4o7qAQz4i
	qQLzA+okoJLz/xU88ulBpdVRl038dVl4X7/GdX2+71m9DWj3weIZW1UdAZOJLZKrTihze9
	+obYQ5F+CyocSijNqt9gjiWNU+YscMI=
From: Sven Eckelmann <sven@narfation.org>
To: syzbot <syzbot+a6a4b5bb3da165594cff@syzkaller.appspotmail.com>,
 Eric Dumazet <edumazet@google.com>
Cc: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net,
 kuba@kernel.org, linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch,
 netdev@vger.kernel.org, pabeni@redhat.com, sw@simonwunderlich.de,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [batman?] BUG: soft lockup in sys_sendmsg
Date: Mon, 12 Feb 2024 12:23:51 +0100
Message-ID: <2173575.irdbgypaU6@ripper>
In-Reply-To: 
 <CANn89iKPYAY226+kV9D0jUn6Kfjq1gQJBAjSRxxFgQJK-QbLwA@mail.gmail.com>
References: 
 <000000000000ae28ce06112cb52e@google.com>
 <CANn89iKPYAY226+kV9D0jUn6Kfjq1gQJBAjSRxxFgQJK-QbLwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart13450391.uLZWGnKmhe";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: DCIBE4RSXWDPINYIL4WQQ4U2DVXL4M2I
X-Message-ID-Hash: DCIBE4RSXWDPINYIL4WQQ4U2DVXL4M2I
X-MailFrom: sven@narfation.org
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/DCIBE4RSXWDPINYIL4WQQ4U2DVXL4M2I/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart13450391.uLZWGnKmhe
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [syzbot] [batman?] BUG: soft lockup in sys_sendmsg
Date: Mon, 12 Feb 2024 12:23:51 +0100
Message-ID: <2173575.irdbgypaU6@ripper>
MIME-Version: 1.0

On Monday, 12 February 2024 11:41:38 CET Eric Dumazet wrote:
> This patch [1] looks suspicious

Shouldn't be caused by this - but this might be another way to trigger the 
problem. The problem would be visible even without it when a mtu is explicitly 
set. But the reproducer is not available so I can't actually check what is 
going on.

> I think batman-adv should reject too small MTU values.

You are refering to the size calculated by 
batadv_tt_local_table_transmit_size(), right? And yes, I would agree that it 
looks suspicious and might not have been correctly integrated in 
batadv_max_header_len() when commit a19d3d85e1b8 ("batman-adv: limit local 
translation table max size") introduced the code. But I think we also need to 
remove interfaces again when receiving NETDEV_CHANGEMTU and an interface is 
not having the correctly sized anymore. So have to check how to do this the 
best way.

Kind regards,
	Sven
--nextPart13450391.uLZWGnKmhe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmXJ/8cACgkQXYcKB8Em
e0ZZFw/+N3em2ptTXcnr3+ApNV8/D8QriRS0O6mBuF8Hijfj6xnYM1hPFaRImy21
WtJjnb2ti7uavNtiBKGR71EUpLW8nNsdI/tB/Pc3ndzy/AOMN9/+JqQE6ekD9K0I
n7rKn5MqBoYjIPMB06lm26Cgx5WyDr3Lkuu3S2OCP3mZZ9+g/p3T0ALJR1c1dkSd
iTM9Yl5zapFzbtebJEa3ywLfeWVApBh0sTpWgfkevsS1OnkRnep59h/KnOa4oBt/
V/BuknZ+m8McCLySH8DuuY0XBvah+mWHMGoGY3qpoeqCo447axPSweIAAXs143t3
ujigchJGL1eaKtOvc/ZeOr2jSwPqmiqIeMN+g7S/mHe7GIW+l6fzH0ZfYm+EADCa
8yJmtZhhwRtSB5j0QsDDEquWlykluoN+jkB2ysTkb3ATY1S+K1ICVZpVMtZ6jCZr
PK68KmxnUFaGXdwKAMpDtDi50roDis7kafjRuIT+rSiTsTkR/uEJ7G4AZs7ca0xz
PfGS7dnXprXm+y/2pQuVXNUzcsuaZxCXzHtjEuzaCEec4qMq4a9QYRrHCLH5xQHE
LxkEvQ2TElGKTzFiOi2daRAreLUv5iQ6U9Y9taiL8AMsKaIjmDUdOmBAUFPhFHDX
ixcgudSFeAbYp0bGwjpqdvXkftitKiGESCAvgEDl+MIhIIK/4jI=
=4r6M
-----END PGP SIGNATURE-----

--nextPart13450391.uLZWGnKmhe--



