Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37CCAFF8875
	for <batman@archiver.kernel.org>; Thu, 30 Apr 2026 07:38:46 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A12A5859D5
	for <batman@archiver.kernel.org>; Thu, 30 Apr 2026 09:38:44 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1777534724;
 b=eW329ndXY2BIjd5jpeQugCY+OwMbzDpoBJNY6xDxVEqZTrEqkCoNx12tRu3mM8hRX6MSl
 lHcJHCgaVdzkRS77ADjGB9d8v/E9jW3dCSfBbt1ZTxaQZqg9ws2kPXvH1KTeVxFNa8Tro40
 ep36KXNvhpKXE/I4drx2LYFXr7uG3dM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1777534724; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=lrWkfmosicCb3bXJFi7fcRxV+xZwfl91sGSlkgUQsYQ=;
 b=q3ErRzsWX9n+TU8oPP0hDXoOhyVVbPr4hMXxRp+xxAiiPqyKPlc9Wu5kPzGhHFPzPZzoP
 aQZAPMt3OK3vXciNyLPaKm+K7aFuK18KA0C/CfB5dQJ2xKwNpcs2B0iFk1nbEobA7zwyNTQ
 yE4DVWU5gFJ+IbEV66BmywviTvrpt48=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 333EC82232
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 30 Apr 2026 09:38:10 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1777534690;
	b=IjZkh54BaPt+WSeXan/zISJ4n0NKRr24MAr6EVC1haDiun1mBfvnEH2/EYTtmaBE5mhFLa
	10ork2gu0ELX0/OvAfgBU/ff7wO0nYVTn5fz6RH+JaHdSYGauAgZKu6dGvsj7zwT97HYL7
	2bmdQMsp3A68BTR6VqE0nB6U09yo1G4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=lIRYhsmR;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1777534690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=lrWkfmosicCb3bXJFi7fcRxV+xZwfl91sGSlkgUQsYQ=;
	b=DiESkBRlUa0eEiA6WfyKwckBV+CsJCbaIJWIlvCXtZtoUEfIHYdN8CETW6BH+rSp/Le6AQ
	vHedOczoQN3Q4YWx+9Y/gJSdt5LhQ+Us8ZIceTbEZcxUZVzo0ExQhki+B5pbUOczxVoQbG
	Jt4g1wza4Q6NvoFkW+oG60YFuQg4i0Y=
Received: by dvalin.narfation.org (Postfix) id 8D1E21FF8D;
	Thu, 30 Apr 2026 07:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1777534689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lrWkfmosicCb3bXJFi7fcRxV+xZwfl91sGSlkgUQsYQ=;
	b=lIRYhsmRno4XToAYKY2FN2Yf2DHcu3M89tJ61RllITajpDHavnbrB9y/rvnvS4DO552Wd4
	uenZSsUW14sY/31l0lDlw+Qil/Gyx3SXQ31nHgZ1Abu7UiInN0kpvkOJ2X12xvEhugmWjy
	GQ5lU0m7EOMjfYFqSj9+poDsf0nd+tg=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org, Haoze Xie <royenheart@gmail.com>,
 Robert Garcia <rob_garcia@163.com>
Cc: Simon Wunderlich <sw@simonwunderlich.de>,
 Robert Garcia <rob_garcia@163.com>, Yifan Wu <yifanwucs@gmail.com>,
 Juefei Pu <tomapufckgml@gmail.com>, Yuan Tan <yuantan098@gmail.com>,
 Xin Liu <bird@lzu.edu.cn>, Ao Zhou <n05ec@lzu.edu.cn>,
 Marek Lindner <mareklindner@neomailbox.ch>,
 Antonio Quartulli <a@unstable.cc>, "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] batman-adv: hold claim backbone gateways by
 reference
Date: Thu, 30 Apr 2026 09:38:05 +0200
Message-ID: <1857579.VLH7GnMWUR@ripper>
In-Reply-To: <20260430071645.3030702-1-rob_garcia@163.com>
References: <20260430071645.3030702-1-rob_garcia@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8717455.NyiUUSuA9g";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: 53ZVCH3RD5NQATZEPMBTEY53WZYUJGHM
X-Message-ID-Hash: 53ZVCH3RD5NQATZEPMBTEY53WZYUJGHM
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/53ZVCH3RD5NQATZEPMBTEY53WZYUJGHM/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart8717455.NyiUUSuA9g
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 30 Apr 2026 09:38:05 +0200
Message-ID: <1857579.VLH7GnMWUR@ripper>
In-Reply-To: <20260430071645.3030702-1-rob_garcia@163.com>
References: <20260430071645.3030702-1-rob_garcia@163.com>
MIME-Version: 1.0

On Thursday, 30 April 2026 09:16:45 CEST Robert Garcia wrote:
> From: Haoze Xie <royenheart@gmail.com>
> 
> [ Upstream commit 82d8701b2c930d0e96b0dbc9115a218d791cb0d2 ]
> 
> batadv_bla_add_claim() can replace claim->backbone_gw and drop the old
> gateway's last reference while readers still follow the pointer.
> 
> The netlink claim dump path dereferences claim->backbone_gw->orig and
> takes claim->backbone_gw->crc_lock without pinning the underlying
> backbone gateway. batadv_bla_check_claim() still has the same naked
> pointer access pattern.
> 
> Reuse batadv_bla_claim_get_backbone_gw() in both readers so they operate
> on a stable gateway reference until the read-side work is complete.
> This keeps the dump and claim-check paths aligned with the lifetime
> rules introduced for the other BLA claim readers.
> 
> Fixes: 23721387c409 ("batman-adv: add basic bridge loop avoidance code")
> Fixes: 04f3f5bf1883 ("batman-adv: add B.A.T.M.A.N. Dump BLA claims via netlink")
> Cc: stable@vger.kernel.org
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Co-developed-by: Yuan Tan <yuantan098@gmail.com>
> Signed-off-by: Yuan Tan <yuantan098@gmail.com>
> Suggested-by: Xin Liu <bird@lzu.edu.cn>
> Signed-off-by: Haoze Xie <royenheart@gmail.com>
> Signed-off-by: Ao Zhou <n05ec@lzu.edu.cn>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> Signed-off-by: Robert Garcia <rob_garcia@163.com>

See https://lore.kernel.org/r/20260413125407.85603-1-sven@narfation.org for 
the original backport. Can you explain further why you send a new version?

Sasha Levin <sashal@kernel.org> picked it up for 5.15.y (on Sun, 19 Apr 2026 
21:13:58 -0400, MsgId 20260419195610.batman-adv-5.15@kernel.org). 
Yes, it was not yet published or 5.15 - so maybe fell through the cracks.

Regards,
	Sven
--nextPart8717455.NyiUUSuA9g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCafMG3QAKCRBND3cr0xT1
y41NAQDcrtNDGgWALEYpUXSE0WJzqoMrzlHp9SPLAwNG0wQnAgD+KXx7wBA9AmQ5
m9xfCxUXBRwKccOO0RwYSOtd4QP3igY=
=5+3O
-----END PGP SIGNATURE-----

--nextPart8717455.NyiUUSuA9g--



