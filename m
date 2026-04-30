Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C83CCD13D3
	for <batman@archiver.kernel.org>; Thu, 30 Apr 2026 07:45:46 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0006C85A57
	for <batman@archiver.kernel.org>; Thu, 30 Apr 2026 09:45:44 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1777535144;
 b=Ye47PdgRvaDbLCR1CLQWdYLzaSzo8aqgu74ASYnXqz4Upi2QcPVkFk4kgm1kGY+CRzID1
 B+8YefFdMLYlQ9c8rFgMKy9p3slmNMd4hm1Ckbch9Jy4StPt6pocnreEzCmys/USARbvGjx
 LHCaTIdBCkeU2pWmpRaiPpvV2JiH9so=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1777535144; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=b5T6Tm8mn1JHMRFC8Mtn+CMd8n0ePg2A3I4KI2l1PNA=;
 b=gZO2L7eJwthIj/9ztrXmtxlfogColEl/NQfnxKXT2+SsMEEa26t3EO79KSEHipsynxfNr
 HpiVR4JckqdRoKXOSLedUewQVpqdiEZNIz0wsZru3NN+PdCee1Dmfg/lysOfd0qlsHHEQM/
 0BD2HRS2IRFg93U49/6C/JIxpiwKcNE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 06BD5842E3
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 30 Apr 2026 09:40:39 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1777534840;
	b=0+Gj/7Ik6FegOQyzBtrG1eh1XUKmz80qHao1bMSYM/PWY/lScHLfQ+fRU6ZG77MECEIkvi
	1j+KA1igEhpISG71+ANSc7s4t08vwFzeYpnB6enCyCKAMZoISFe8bc43h1l3w8mW6ed55b
	lX2+qfUOK4hLsX/qZPot1Ac86dqBowM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=R0rS2QeC;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1777534840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=b5T6Tm8mn1JHMRFC8Mtn+CMd8n0ePg2A3I4KI2l1PNA=;
	b=2dwbpxDLTB4PCBqWQnTQa/Y/U3rABp/Z4mUTeITwoz0D7bNS9PW8Ktrs6Us/81QhV1d7vU
	F6ZxPbsnIC89gPtcBoOxhLjW8bsG8KUB1RsK34Zxv6w9jpQNSdxQIgkiTY8LzQIMddfX9d
	O3fJMR0V89LpLYDVN0k+IejgOqD29iA=
Received: by dvalin.narfation.org (Postfix) id 10CBB1FF65;
	Thu, 30 Apr 2026 07:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1777534838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b5T6Tm8mn1JHMRFC8Mtn+CMd8n0ePg2A3I4KI2l1PNA=;
	b=R0rS2QeCbZsX3riHy7LG7YuYAQ5vd7gYDMFY/W+HjoTIOOeNKyBh443kjjMRPmsJHpQvsO
	bxR5mog0StlF0o+J/ijdo4EmDu4rYIuxR3bAILL45VX37Y6AoiSG8AJ0R5aRkWd5XN6y86
	pqCP2QpjyJoSD8H9jgi4QHnqIyZZPMs=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org, Haoze Xie <royenheart@gmail.com>,
 Robert Garcia <rob_garcia@163.com>, b.a.t.m.a.n@lists.open-mesh.org
Cc: Simon Wunderlich <sw@simonwunderlich.de>,
 Robert Garcia <rob_garcia@163.com>, Yifan Wu <yifanwucs@gmail.com>,
 Juefei Pu <tomapufckgml@gmail.com>, Yuan Tan <yuantan098@gmail.com>,
 Xin Liu <bird@lzu.edu.cn>, Ao Zhou <n05ec@lzu.edu.cn>,
 Marek Lindner <mareklindner@neomailbox.ch>,
 Antonio Quartulli <a@unstable.cc>, "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
 Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 5.15.y] batman-adv: hold claim backbone gateways by
 reference
Date: Thu, 30 Apr 2026 09:40:34 +0200
Message-ID: <3609597.QJadu78ljV@ripper>
In-Reply-To: <1857579.VLH7GnMWUR@ripper>
References: <20260430071645.3030702-1-rob_garcia@163.com>
 <1857579.VLH7GnMWUR@ripper>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1959533.CQOukoFCf9";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Hits: max-recipients
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-size;
 news-moderation; no-subject; digests; suspicious-header
Message-ID-Hash: YM5RYRQOF65UJCUUWENZRGRMRCIV7OA4
X-Message-ID-Hash: YM5RYRQOF65UJCUUWENZRGRMRCIV7OA4
X-Mailman-Approved-At: Thu, 30 Apr 2026 09:45:09 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/YM5RYRQOF65UJCUUWENZRGRMRCIV7OA4/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart1959533.CQOukoFCf9
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 30 Apr 2026 09:40:34 +0200
Message-ID: <3609597.QJadu78ljV@ripper>
In-Reply-To: <1857579.VLH7GnMWUR@ripper>
MIME-Version: 1.0

On Thursday, 30 April 2026 09:38:05 CEST Sven Eckelmann wrote:
> Sasha Levin <sashal@kernel.org> picked it up for 5.15.y (on Sun, 19 Apr 2026 
> 21:13:58 -0400, MsgId 20260419195610.batman-adv-5.15@kernel.org). 
> Yes, it was not yet published or 5.15 - so maybe fell through the cracks.

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?h=queue/5.15&id=6fd37208adf6771125b59e1ae0452561024be4e2

Regards,
	Sven
--nextPart1959533.CQOukoFCf9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCafMHcgAKCRBND3cr0xT1
y7V/AP9BMH0S8bDU+veLaqdqd/7YjiL5klqj+wG7K6SUqPoNAQD/ZFycWLIHLcz3
YaivZtqG9mnJJkSDo399V/GNymYUZAk=
=lQ4+
-----END PGP SIGNATURE-----

--nextPart1959533.CQOukoFCf9--



