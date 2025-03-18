Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92BD4C28B28
	for <batman@archiver.kernel.org>; Tue, 18 Mar 2025 13:56:28 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1A89383CDE
	for <batman@archiver.kernel.org>; Tue, 18 Mar 2025 14:56:27 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1742306187;
 b=maSWrAj8EkzrQoGaPQbTaPN9TUHm1cEQtwEE00EfRKP9bYZ5OKx+vUfFSv1ekxBFRiv3J
 xuorIPpaguxutEN5bpRDqRALcOvgvwenSEq2yMMWLE0GweDOjHI3we4UNE1znhToZhS1seT
 OobLpmXGEBZ0Sb7MXjqa2C2aQV5/swE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1742306187; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=zS6U9IbqxukiJ1clWx1A4PxWHL2mCHGPOXvVeRtKO/w=;
 b=D4Ok1Ym48iBo9Fg1ldn0ifaxFTLsb5hRtxoCAXsgn5cE6J42w+QAg1nkfYSA5QJjjwuGV
 0sLv1xze2mNYZafX6vwKsOnxvg5oiuDdWRy9qcI4RdTiew936RvD7A6L9jqy8w7EJzSdqhY
 FLCQ9bN9RxGR1ixmSqyNw2FbPZ5WtXQ=
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
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 7C294800D6
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 18 Mar 2025 14:56:11 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1742306171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=zS6U9IbqxukiJ1clWx1A4PxWHL2mCHGPOXvVeRtKO/w=;
	b=XZrOrwZkpljm20wdUg2kt1ULxnI2HeMVMHyAcOq9mm2dxNpG0ZNBYBq9yb5MVeFtQfAvZY
	XdT4uQy/GiTCqw7ciiHm3va8hZ+77bOQrVDBhWYXibNWj8KTCpVqtvn7Ea0IsNCoGBjHy/
	d4bK6skWgC4zDGrto35JNDmuTseOhL0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=0mT47E2y;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1742306171; a=rsa-sha256;
	cv=none;
	b=AQSy4ncNZ2nOuL1vLPGx+0Fa4dM77VJA/kBi1EjPOLDaLU3uNF7Zv956SIbsFm3c8H4KEa
	Fwes8NsbGdwg1kuiiiEi2M6a/sf92CBjfmLvaJFRhVbtp5Sa+cAS9ghRJJJXYXIXP9HhJl
	DyM9PEpFg2V10dwLq2iinDSEPo1FBW4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1742306170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zS6U9IbqxukiJ1clWx1A4PxWHL2mCHGPOXvVeRtKO/w=;
	b=0mT47E2yVSK9sQUtr2JzKuXdSBEYGzBRbtTqUi6/gq6OOpst2y3o9eErHmgUIOC2b45dNM
	Zooer++1C3wtMq0Ny7oqY3hp7V5Xv2cWZz3iH7s22ByHUs/BA1dX2yUU4YFq68mumjPtEd
	DRYMGzX0hI7yjd78mlCtcrGgOdQjYGo=
From: Sven Eckelmann <sven@narfation.org>
To: Simon Wunderlich <sw@simonwunderlich.de>, davem@davemloft.net,
 Paolo Abeni <pabeni@redhat.com>
Cc: kuba@kernel.org, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH 0/5] pull request for net: batman-adv 2025-03-13
Date: Tue, 18 Mar 2025 14:56:07 +0100
Message-ID: <3809149.MHq7AAxBmi@ripper>
In-Reply-To: <a0f1deec-2770-4b51-ad2b-b3d0e846be25@redhat.com>
References: 
 <20250313161738.71299-1-sw@simonwunderlich.de>
 <a0f1deec-2770-4b51-ad2b-b3d0e846be25@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1964837.taCxCBeP46";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: USKRCU6O7HCVYUH3BSRCDDO5ZQIOQY6Z
X-Message-ID-Hash: USKRCU6O7HCVYUH3BSRCDDO5ZQIOQY6Z
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/USKRCU6O7HCVYUH3BSRCDDO5ZQIOQY6Z/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart1964837.taCxCBeP46
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 0/5] pull request for net: batman-adv 2025-03-13
Date: Tue, 18 Mar 2025 14:56:07 +0100
Message-ID: <3809149.MHq7AAxBmi@ripper>
In-Reply-To: <a0f1deec-2770-4b51-ad2b-b3d0e846be25@redhat.com>
MIME-Version: 1.0

On Tuesday, 18 March 2025 12:05:52 CET Paolo Abeni wrote:
> The series does not apply cleanly to the net tree, could you please
> rebase it?

$ git log -1 --oneline
9a81fc3480bf (HEAD, net/main) ipv6: Set errno after ip_fib_metrics_init() in ip6_route_info_create().

$ git pull --no-ff git://git.open-mesh.org/linux-merge.git tags/batadv-net-pullrequest-20250313
>From git://git.open-mesh.org/linux-merge
 * tag                         batadv-net-pullrequest-20250313 -> FETCH_HEAD
Merge made by the 'ort' strategy.
 net/batman-adv/bat_iv_ogm.c | 3 +--
 net/batman-adv/bat_v_ogm.c  | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

So, it works perfectly fine for me .

I understand that it is confusing that that Simon send a PR with 5 patches 
mentioned. It is actually only 1 patch - 4 were already submitted in the last 
PR. But still, the PR seems to apply cleanly for me.

Any hints how to reproduce your problem?
 
> While at it, could you please include the target tree in the subj prefix?

It currently mentions net in the subject. But I think you mean to change it 
from "[PATCH 0/5] pull request for net: batman-adv 2025-03-13" to 
"[PATCH net 0/5] pull request: batman-adv 2025-03-13". Or which exact format 
do you prefer?

Kind regards,
	Sven


--nextPart1964837.taCxCBeP46
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZ9l7dwAKCRBND3cr0xT1
y5/DAQD20CG4iCNDzl8RXkBPzxz4miX+U6QNUXpR+iB0JCSm8QEAzVj7p6ylNvFQ
Cqf6IBTk8Z+k1c9gZxXP1SkDzm6uAwk=
=+ADe
-----END PGP SIGNATURE-----

--nextPart1964837.taCxCBeP46--



