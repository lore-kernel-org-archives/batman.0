Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EAFAE9D834
	for <batman@archiver.kernel.org>; Mon,  6 Apr 2026 13:51:08 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 57FDC857DA
	for <batman@archiver.kernel.org>; Mon, 06 Apr 2026 15:51:07 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1775483467;
 b=lp4zXYFfLzikDWp7DhmBXccorFptjuDHAndi/8qADAzv4WXX/OSSpNnVzFCuhylYx8SxG
 O8ZR9f+b/wK4lrnygVmd7TR2Q5ShUva03PSCmS4c/kvhd5kh2RNZtH3zUkW6AiQbR1mxnXt
 MRiabQu9iKRQzNGpFPspPyP+aNilOQg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1775483467; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=iRR+ID16DnxnNiho6gkKFAiloy6TB7CgO30hWezRnb4=;
 b=GWAXl+1Tl3aGtMZ7IVCh+4pP80TLl5wcNvtdoU1ZT7KBVwFA4sPPa8QLjqHhSnpkvINLu
 ZkRBQ4zgTr+9rPiwgU2VA9J1MRmzV+WpCgu3UUGjKiRLgVug21lLynYHDuMKjjTWCzWtAN7
 tNZr2NhOsmyZvEVH/NFirN7kHxixZsw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 0159D80D6B
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 06 Apr 2026 15:50:42 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1775483453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=iRR+ID16DnxnNiho6gkKFAiloy6TB7CgO30hWezRnb4=;
	b=E5d49hTaSYQ0mRzgr1xAfBIDTk0D6puoYTtrVi0KQ5uNgMm0ohSzbyXEQjbl0H7C4DQDvG
	CCjEV4us1R6RC5O2z5Bvv8cnLUaUlsixfn+DIw/RDjA5En1ja1lyJeFBPqOvmDceg4NTaj
	CWO3HaHF/k6mWoTE0wyqMRG8fi+uCVo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=OxGEO5ni;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1775483453;
	b=CYDXs1i++KtUlP6qLAjxvh54iy9rAShUxVbveV+JFHSF0JvwMmPYVywQC8nzudFR81PDeT
	PMVOXRjtc/hHc0OJlw4wz1BoQ6GUGfEWUt3hH98LVmOOGehlUdYVID+TqqZaPRzJOiRPRN
	7eZvcFXEoGBtjb5Z8uJNJMsn9SlnQH0=
Received: by dvalin.narfation.org (Postfix) id E18A320EDE;
	Mon, 06 Apr 2026 13:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1775483441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iRR+ID16DnxnNiho6gkKFAiloy6TB7CgO30hWezRnb4=;
	b=OxGEO5niePgkHVCRAJkUYE1s3aLeyd6sDJCpSYwEP6xEN0J+6q1kOOe1R4odwdTaQweuW1
	KTTrThG0GAYffUV4Drr7PlnAuPDgdfehpWPv7hCGs5uZ7pe5Yoq8/KsZ2v5Du/7jq/tr+v
	wqLWjZTH9VDOMzrUADyS96pJnIsBbL4=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 Ao Zhou <n05ec@lzu.edu.cn>
Cc: Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <antonio@mandelbit.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Yifan Wu <yifanwucs@gmail.com>, Juefei Pu <tomapufckgml@gmail.com>,
 Yuan Tan <yuantan098@gmail.com>, Xin Liu <bird@lzu.edu.cn>,
 Ao Zhou <n05ec@lzu.edu.cn>, Haoze Xie <royenheart@gmail.com>
Subject: Re: [PATCH net 1/1] batman-adv: hold claim backbone gateways by
 reference
Date: Mon, 06 Apr 2026 15:50:37 +0200
Message-ID: <6721686.DvuYhMxLoT@sven-desktop>
In-Reply-To: 
 <4a58d2daef70ac17bb9be1f244a182439d5c4d63.1775301426.git.royenheart@gmail.com>
References: <cover.1775301426.git.royenheart@gmail.com>
 <4a58d2daef70ac17bb9be1f244a182439d5c4d63.1775301426.git.royenheart@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6995330.lOV4Wx5bFT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: 7DS4MGUHWJYH4MVNUIFCOAKSGKQMYMUM
X-Message-ID-Hash: 7DS4MGUHWJYH4MVNUIFCOAKSGKQMYMUM
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/7DS4MGUHWJYH4MVNUIFCOAKSGKQMYMUM/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart6995330.lOV4Wx5bFT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 06 Apr 2026 15:50:37 +0200
Message-ID: <6721686.DvuYhMxLoT@sven-desktop>
MIME-Version: 1.0

On Monday, 6 April 2026 15:17:28 CEST Ao Zhou wrote:
> From: Haoze Xie <royenheart@gmail.com>
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
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Co-developed-by: Yuan Tan <yuantan098@gmail.com>
> Signed-off-by: Yuan Tan <yuantan098@gmail.com>
> Suggested-by: Xin Liu <bird@lzu.edu.cn>
> Signed-off-by: Haoze Xie <royenheart@gmail.com>
> Signed-off-by: Ao Zhou <n05ec@lzu.edu.cn>
> ---
>  net/batman-adv/bridge_loop_avoidance.c | 27 +++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)

Applied, thanks!

[1/1] batman-adv: hold claim backbone gateways by reference
      https://git.open-mesh.org/linux-merge.git/commit/?h=batadv/net&id=82d8701b2c930d0e96b0dbc9115a218d791cb0d2

Best regards,
---
Sven
--nextPart6995330.lOV4Wx5bFT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCadO6LQAKCRBND3cr0xT1
y26iAQCjQv+PeIhpfRpwFpDi1Zektlh+3ZpKeTsIhBbRNXUa2QD/fvkRpCmUVrPR
ILSBN6mBEL93oFdBwIh3VqNG9kzmPQ4=
=GnOB
-----END PGP SIGNATURE-----

--nextPart6995330.lOV4Wx5bFT--



