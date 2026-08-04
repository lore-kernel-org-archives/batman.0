Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A620C55184
	for <batman-adv@archiver.kernel.org>; Tue,  4 Aug 2026 06:56:36 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 418E684186
	for <batman-adv@archiver.kernel.org>; Tue, 04 Aug 2026 08:56:34 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785826594;
 b=c+nDyobSE9f4NfqwIOuAiAfGy4OgtlmJEr74kM5DNNcJ0aQLu2cLFNK42YcJmlgB/voHx
 Ztgjk6ewpqj0n0zrOn/KAUgTUODDsFeXDlZFfhNfMSX2CdCg1x/ohop9atIi55+OMxX+sD3
 PkONBkmGmwSEXYR6LxNV0O+G8mw7Tvc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785826594; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=GyKqvdPJboPC+rw5Gusa2cgeLAvNIQAvnaOSrAsjNyo=;
 b=LSGt9vIQaFpXRSNYFuAtpKsH5tHMHHrLn6+k4tnVPQKq7HsWauS4XmQikN3SBqTFo5BQD
 PJFOoQPb9gpxqfGuZdBO936pfBVPfGefjelkkc09mlZHGMGjYUdhtef2eaBDJnXYvvFDMSr
 u+WwZMZmUPOMb1j13jROSqgbwMeJ80M=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 626CF8171F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 04 Aug 2026 08:56:04 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785826575;
	b=b01hiJAXuzpxG0tDH6OPkVBwVW99VP4EG41oTQWUMMT6XZVtcPHzrFAmjttdq92JdUG2mR
	TnQ7+fPraiawGptHti+mhaD2FFfFQUIjor14VJSnHC2ezl4qpeFeqsXVO8ta2rKD8PQ8Dq
	epAOk5MRIsGwE6Rv+sK9GTb7i6C2UNo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785826575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=GyKqvdPJboPC+rw5Gusa2cgeLAvNIQAvnaOSrAsjNyo=;
	b=t32fwYEAYkHb3qcMhk7xmVgKWn1XuyXx8dy8mo8bJ3Hr2t9bUaeyNMNF2TvxxuSfKohfia
	wFYQGCP29QkRv1nSuyucdBUJyhjBTS5EdU2T1y9FnFsZVQZXgNIZ+exDf/h6/BGtFaLuka
	9iky+m5bh8XHpdWtlfHOhpAiQRGmNkM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=kJXIb0sj;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 0ED1120597;
	Tue, 04 Aug 2026 06:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785826559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GyKqvdPJboPC+rw5Gusa2cgeLAvNIQAvnaOSrAsjNyo=;
	b=kJXIb0sjXS6J6YN2e+ui3iWcElawhRrJGgO9Y8yzas0CSMpS5z0exulrOZiQektvxK0UOd
	qjRHf4Tmst837LEr9WNkPoUEJHN5++cuNpSYrNtcGUz03lc1nrxrmyC+c5IwEdYhqDbAtA
	bryJVhUpBf77YcQJWrVUW+u0VxLbifc=
From: Sven Eckelmann <sven@narfation.org>
To: Simon Wunderlich <sw@simonwunderlich.de>, b.a.t.m.a.n@lists.open-mesh.org
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, b.a.t.m.a.n@lists.open-mesh.org,
 Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next 00/15] pull request for net-next: batman-adv
 2026-07-28
Date: Tue, 04 Aug 2026 08:55:51 +0200
Message-ID: <3386526.aV6nBDHxoP@sven-l14>
In-Reply-To: <20260803191920.0e6c5a2c@kernel.org>
References: <20260728133918.643267-1-sw@simonwunderlich.de>
 <20260803191920.0e6c5a2c@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3093944.VdNmn5OnKV";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: 7Q3FLDHAX6UOQBFEFBAXA7JTCX6QPRWM
X-Message-ID-Hash: 7Q3FLDHAX6UOQBFEFBAXA7JTCX6QPRWM
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/7Q3FLDHAX6UOQBFEFBAXA7JTCX6QPRWM/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart3093944.VdNmn5OnKV
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 04 Aug 2026 08:55:51 +0200
Message-ID: <3386526.aV6nBDHxoP@sven-l14>
In-Reply-To: <20260803191920.0e6c5a2c@kernel.org>
MIME-Version: 1.0

On Tuesday, 4 August 2026 04:19:20 CEST Jakub Kicinski wrote:
> On Tue, 28 Jul 2026 15:39:03 +0200 Simon Wunderlich wrote:
> > here is a minor bugfix/cleanup pull request of batman-adv to go into net-next.
> 
> Can you look thru the Sashiko comments here (especially Medium+
> severity)?
> 
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260728133918.643267-11-sw@simonwunderlich.de

https://patchwork.open-mesh.org/bundle/ecsv/pu-main/

We were just waiting for a verdict. I am guessing it it a "no, will not 
merge", correct?

> At a glance patch 14 does not inspire confidence. I guess patch 15
> removes the worst part - but is there a real reason not to use locking?

In its current state, you would need spinlocks over larger (op-count) portions 
of code in the hot-path. And since it it nearly impossible to get feedback 
from the TT author/maintainer, I am not willing to invest time in a total 
rewrite of the TT infrastructure.

Regards,
	Sven


--nextPart3093944.VdNmn5OnKV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCanGM9wAKCRBND3cr0xT1
y3sqAP93VUsjB/3zBZEPOEwVl9F8KchEpqol2vmkE2mbdlui4gD/ZcZ0qOW3IWsP
+5olqy4xUDXtdwWKz+2KDX80Fe+2mwI=
=12G3
-----END PGP SIGNATURE-----

--nextPart3093944.VdNmn5OnKV--



