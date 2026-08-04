Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32FD7C55172
	for <batman-adv@archiver.kernel.org>; Tue,  4 Aug 2026 10:39:01 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 79938841F1
	for <batman-adv@archiver.kernel.org>; Tue, 04 Aug 2026 12:38:59 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785839939;
 b=Us8OxwE8WcTpNPNXhfayfD1gnnyupNbiiYSC69w5DIEConQmWpTowRw60KCt4TXGDIej+
 rVYo1syxNIgQEqZy5pTPkuht35Pj9UEaGt1yJip1GmQVLkrz5807+F2BZ8AoagbSu8mxbsa
 Xx9nbD1kVYQ46i9r+mNFcySJZNiSz2k=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785839939; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=WtJy2MfaXTaEOmlC5rfqzTgy+eUfkYpLXbncaIJYzvg=;
 b=diPEXOsrPFKnzhadqBKqKUiTy6bxmIl19MBVJjYpQhG5vSWe2/Ie5fo34p3mr8j2Mxc3m
 NuawdAjAN5PXHxjDe106A9ZHcae5cpkijoEAsmoVnu6o6Qgc7RWat9EJcMuxhkSeUQ1AnrO
 cNYsvRuBzBYjgNlmtEsfywpfUK8H3SA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 8146381010
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 04 Aug 2026 12:38:31 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785839921;
	b=os0uQRMaGjLSK9i0WvtJonE+8PQWRekmSQsJkwDgzKQjicLUHs5aQm1twkIf7xNEmfCUCo
	FZNTeStu57tLDf8sif2OhE5ULzMv0SdOZytud3TwVh9CoFnxLC8v8cREg0Bzvesa+Pgx8z
	zHcCUM5JJczExt0yy4sHu/WD1F68k7w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785839921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=WtJy2MfaXTaEOmlC5rfqzTgy+eUfkYpLXbncaIJYzvg=;
	b=R2EtcVRUIF5yEjbheEqAOePK9qbv5HyyXSB6u0S86UEEVXVG8QkD8VGN7Q/Gh0aAjepPzq
	y7EFrqmtsNShm0ax+wPKXsKkza7gWLGWB+6NFVkekYOX5OHMsGJqkDGpqlBog0mjwIv5AC
	UPeGQ8BJs80EPXXz/CXHOVWsEovlGxA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=Xqb8fs9j;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 59A85200A3;
	Tue, 04 Aug 2026 10:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785839906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WtJy2MfaXTaEOmlC5rfqzTgy+eUfkYpLXbncaIJYzvg=;
	b=Xqb8fs9jBaghyfcphqr6xlbpr8U9hGzTJPg7ag836MrBfSOT4akI41uK41Dx2F3AUgc2AP
	VQ8oprJkKwQ5rOj7WVNyhMWP64Zff/xx/AI9V5k3w1mLrkpmi/9jJNAjuIkLXKyPJcxHqO
	Zn9OtmCUNjFw+hOSgHV1OFCy45RBhgY=
From: Sven Eckelmann <sven@narfation.org>
To: Simon Wunderlich <sw@simonwunderlich.de>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH net-next 00/15] pull request for net-next: batman-adv
 2026-07-28
Date: Tue, 04 Aug 2026 12:38:23 +0200
Message-ID: <5248054.31r3eYUQgx@sven-desktop>
In-Reply-To: <7d73cd74-b040-4a3d-9d78-4ad8fc0a01f4@redhat.com>
References: <20260728133918.643267-1-sw@simonwunderlich.de>
 <7d73cd74-b040-4a3d-9d78-4ad8fc0a01f4@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4880609.LvFx2qVVIh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: JGHS7DWTGZMHWSGUYEGBCQNCDBM2QAGX
X-Message-ID-Hash: JGHS7DWTGZMHWSGUYEGBCQNCDBM2QAGX
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/JGHS7DWTGZMHWSGUYEGBCQNCDBM2QAGX/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart4880609.LvFx2qVVIh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 04 Aug 2026 12:38:23 +0200
Message-ID: <5248054.31r3eYUQgx@sven-desktop>
In-Reply-To: <7d73cd74-b040-4a3d-9d78-4ad8fc0a01f4@redhat.com>
MIME-Version: 1.0

On Tuesday, 4 August 2026 12:19:13 CEST Paolo Abeni wrote:
> On 7/28/26 3:39 PM, Simon Wunderlich wrote:
> > Dear net maintainers,
> > 
> > here is a minor bugfix/cleanup pull request of batman-adv to go into net-next.
> 
> Note that it's preferred to avoid fixes and stable tags for changes
> targeting the net-next tree. If the fixes are really minor, both could
> possibly safely dropped. If there is some real problem behind, such
> changes should instead target the net tree.
> 
> Can you easily rebase your tree and adjust the PR vs the above?

I have a different statement from Linus:
https://lore.kernel.org/lkml/CAHk-=wjt1NiKOdyAMz_DT7NmZ++SizPOhRSi492ukdTnpDzHQw@mail.gmail.com/T/#u

This is why we started to not send out net.git fixes PRs for things which 
aren't highly critical or for Linus' "just merged for this release commits"  
late in the development process.

Regards,
	Sven
--nextPart4880609.LvFx2qVVIh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCanHBHwAKCRBND3cr0xT1
y/8QAQDzUcTw7FHaaCVpHMlzRh2IWzL1KDQNhQYlWN3UCPzYawD+Lq761nAESYoH
ZJYYYX7K7shuAGSuyAGLY51vTpi+Iw4=
=dPxd
-----END PGP SIGNATURE-----

--nextPart4880609.LvFx2qVVIh--



