Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D72606A321
	for <batman@archiver.kernel.org>; Thu, 12 Nov 2026 10:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=aZBIcGHd
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B385D818DE
	for <batman@archiver.kernel.org>; Thu, 12 Nov 2026 11:58:14 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1794481094;
 b=jGqxdmmUb+MLswINtk+W7eitpkvJphGVsVELoDIOywxTgf34EQnr2sTgpzJ05t2EVAelW
 NBFXY9Rtg+GERhP+BuyI/zjiTzP4AI7AbMYp87pfzn+cnWxN/R3cgSisLqQmfktWwm+i6Ey
 /fVLvcOBlFtNK7GE4997KSGQ8zvh+vk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1794481094; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=8P9ng6dnAOZ1uLRwI2Xyior8nl1Uol/mP/8AoZqdZUo=;
 b=NwiHLM+cNRn+mXkQqDUzlQ36+FjUnaF0SkLBPJnQK8dumN//WXGwuu5+AWb3kjCttS2va
 mwG8x4X9iyqWES6yZ8LdJa4x2JtI1NfPj2kDcI3HXRckatgo/dH1Pcx//mbdk24yFnLgRbD
 uZ6SSKhEF1NqHAB/DD7nJumKpOUcw3I=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 8965D8119A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 12 Nov 2026 11:57:41 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1794481071;
	b=dhVz+nGd0A5XdlJsBoxxAH4rKr/ngspkMMBhmM72IqBoipekClQv3qpSRezDE6iLlIsgGh
	PzZ2e45ZwzCUS1E1+vGVuolc+3v6AnqO4J4BbidBibsNIpDOmJwI63x2m/JGByBv1zPW8w
	1YCDTMt4/7GvEOxNOK1q2JnFcyzDni8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1794481071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=8P9ng6dnAOZ1uLRwI2Xyior8nl1Uol/mP/8AoZqdZUo=;
	b=h2hi6WUqTh4A3dfhdgbo3v5mZOwxEE6o9s7OKj3xhOFuMROwgZom+H9R2nYK8Ykqe6IFYN
	MmlaI+KR1yl3pYKn023nXd3+JTTMlqp7zoXAigrJkIk2jK8HYTHzf/cZB10pbhoEfw9JYg
	XKpW5AbwelC/SE2l+EcpOMiJqfL6JmU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=aZBIcGHd;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 46F7F1FEF7;
	Thu, 12 Nov 2026 10:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794481060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8P9ng6dnAOZ1uLRwI2Xyior8nl1Uol/mP/8AoZqdZUo=;
	b=aZBIcGHdgmTgfk0JcPXJLdRysccdxIvZ/gaPvXpts6Ofv5Y3eOzvbwWlk3Cs5A0WFSNdlC
	aXjzjLzKCOIB85shL/DCf4ggsC9869mYZ9NSWOp2K5ht2NFUHFIfa1J1JkBsqpC+2fk3dO
	uiewdbMYQkq+6nYDyjZ4z8TL97QIwfo=
From: Sven Eckelmann <sven@narfation.org>
To: sashiko-reviews@lists.linux.dev, b.a.t.m.a.n@lists.open-mesh.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next 09/15] batman-adv: annotate originator last_seen
 with
 READ/WRITE_ONCE
Date: Thu, 12 Nov 2026 11:57:37 +0100
Message-ID: <1831685.QkHrqEjB74@ripper>
In-Reply-To: <sashiko-outbox-210959@kernel.org>
References: <20261111102729.2096241-1-sw@simonwunderlich.de>
 <20261111102729.2096241-10-sw@simonwunderlich.de>
 <sashiko-outbox-210959@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4751616.8F6SAcFxjW";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: RFM7AC7H2PY6ZQEVUHJI2MS6DREZZYSE
X-Message-ID-Hash: RFM7AC7H2PY6ZQEVUHJI2MS6DREZZYSE
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RFM7AC7H2PY6ZQEVUHJI2MS6DREZZYSE/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--nextPart4751616.8F6SAcFxjW
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 12 Nov 2026 11:57:37 +0100
Message-ID: <1831685.QkHrqEjB74@ripper>
In-Reply-To: <sashiko-outbox-210959@kernel.org>
MIME-Version: 1.0

On Thursday, 12 November 2026 11:34:43 CET sashiko-bot@kernel.org wrote:
[...]
> [Severity: Medium]
> This problem wasn't introduced by this patch, but can
> batadv_v_neigh_dump_neigh() and batadv_iv_neigh_dump_neigh()

batadv_iv_neigh_dump_neigh? There is no function with this name in the source 
code. There is only batadv_iv_ogm_neigh_dump_neigh()

> suffer from
> the same timestamp underflow [1]?
> 
> net/batman-adv/bat_v.c:batadv_v_neigh_dump_neigh() {
>     ...
>         last_seen_msecs = jiffies_to_msecs(jiffies - hardif_neigh->last_seen);
>     ...
> }
> 
> Because hardif_neigh->last_seen is updated locklessly on packet reception
> and read without READ_ONCE() or jiffies_delta_to_msecs(), a concurrent
> update can leave hardif_neigh->last_seen ahead of the sampled jiffies
> value, wrapping the subtraction and exporting a huge last_seen_msecs
> value over netlink.

This is adjusted in the next two patches in this patchset.

Regards,
	Sven
--nextPart4751616.8F6SAcFxjW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCavWboQAKCRBND3cr0xT1
y30qAQCxM2pzrCpWwjtmdG17Uozu4UXuGHZ7Y558+4W2pqCO7wD/dz9ukJGdb+Jv
qjF9rkCqVOr4xg+aDzhwJ5Pan1aQGww=
=hGQR
-----END PGP SIGNATURE-----

--nextPart4751616.8F6SAcFxjW--



