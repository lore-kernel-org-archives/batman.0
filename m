Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FDCBC001B0
	for <batman-adv@archiver.kernel.org>; Wed, 26 Jul 2023 14:32:13 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4597681ED5
	for <batman-adv@archiver.kernel.org>; Wed, 26 Jul 2023 16:32:12 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1690381932;
 b=QJi9RNNWkXyWH7Q56L10gVxKZnbtO7U5CrU1RTDovA0WJWtW0D6L6y+pPi/4DGoZGfQb4
 CIQByEbbXIqRau+KdWLKS9VPuRK2fyLrm6aWEqrNT8bRdHfsx8zKDGr/T23T9yHjC4GdMtS
 7b1YkfBZSqRC6odjl1rUkWjlfzzdV2c=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1690381932; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=B8zkmEooAd3ivhBI5159aRXGkQXjdZ6DaWps5lwao+8=;
 b=fnXUBJbVchWmF/wvzTLxVqFCTXwZlkP/TEuPqHgH8nNZBdZc6mcIuGeeiepqRTu1E2gn/
 ZlDl1MFPWBdMm4+DziFDCl0H0+OuuzgcPCcoKPBFvGoaTQDiK06kylNd5vk7jMm0PywFEkm
 et8lqv1FEZhiIMeHZgVwooZnzgE6Rm8=
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
	by diktynna.open-mesh.org (Postfix) with ESMTPS id A01A0802D9
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 26 Jul 2023 16:31:56 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1690381916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=B8zkmEooAd3ivhBI5159aRXGkQXjdZ6DaWps5lwao+8=;
	b=DOBufPbxalAlBAN6Zu7yKJMQyUx2YgEMeRmOhxH+td7ufGteENWgK74DshKP8PeBSmx8Y8
	VAPDn2RAgK8cuewI6kTyj5gA/+wPG85s4AJZWoMpC42ESCY1bwsB5Si43QWjk3ylEpu9cl
	JXPUtaUhSTyDjY7/PWA6qq8w5/91FpA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=BKP68AtH;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1690381916; a=rsa-sha256;
	cv=none;
	b=wdj7qoy8ymrBoW75nrn4Vj4atrDSxM4ATQduPKlsIBmDk4l/KCR1bRrbpLcIwYbtzGtyvS
	rvNncErSkxNRlMrJeQmB4tgysIbeu/7dZmApN3pf25pDvip2GD/4iixacLHQ06CRdOAaDG
	En5XoB38N4JenEcNQD9yk7aVzmlsuD8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1690381915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B8zkmEooAd3ivhBI5159aRXGkQXjdZ6DaWps5lwao+8=;
	b=BKP68AtHg+sp03VT6ikDKu6RX6Sh+A4yjAxzN5bhI1jkNTxFPjHCgf4ufAUlqSRRvKEMQ9
	AGBcWytXmqNfU/Fy/GVq2mOP4s8Il4tHFwFKO8znxgwg5/q4OPFRlGAo801nrVoSgjaUty
	ndAAoOs/h2LWMIHCM6YndnI7JWPfeHA=
From: Sven Eckelmann <sven@narfation.org>
To: mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 yuehaibing@huawei.com, YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH net-next] batman-adv: Remove unused declarations
Date: Wed, 26 Jul 2023 16:31:51 +0200
Message-ID: <2978210.e9J7NaK4W3@sven-l14>
In-Reply-To: <20230726142525.29572-1-yuehaibing@huawei.com>
References: <20230726142525.29572-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3326948.aeNJFYEL58";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: ZMC7MHOXKYRVEPA22FOPX5VRRXILNXDP
X-Message-ID-Hash: ZMC7MHOXKYRVEPA22FOPX5VRRXILNXDP
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ZMC7MHOXKYRVEPA22FOPX5VRRXILNXDP/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart3326948.aeNJFYEL58
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH net-next] batman-adv: Remove unused declarations
Date: Wed, 26 Jul 2023 16:31:51 +0200
Message-ID: <2978210.e9J7NaK4W3@sven-l14>
In-Reply-To: <20230726142525.29572-1-yuehaibing@huawei.com>
References: <20230726142525.29572-1-yuehaibing@huawei.com>
MIME-Version: 1.0

On Wed, 26 Jul 2023 22:25:25 +0800, YueHaibing wrote:
> Since commit 335fbe0f5d25 ("batman-adv: tvlv - convert tt query packet to use tvlv unicast packets")
> batadv_recv_tt_query() is not used.
> And commit 122edaa05940 ("batman-adv: tvlv - convert roaming adv packet to use tvlv unicast packets")
> left behind batadv_recv_roam_adv().
> 
> 

Applied, thanks!

[1/1] batman-adv: Remove unused declarations
      commit: 5af81b30fd8fc8dcaf2c20e91c9f1f053bf2b4f5
--nextPart3326948.aeNJFYEL58
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmTBLlgACgkQXYcKB8Em
e0aN+A/+NNABiED0zziMTAwSLZoKYqPEfBGuh+wDQZNdXvb7GJI0ufIdlMrwNEIx
FPsrWyEdD09oOldgb1PJSGsDRel9VaUmK/1J6/bUHH6cFOhywZ2tpsjMb7XDnvhE
5hq6VeRV1uapfxD9l6yupSX9qLeUjB/kk9DSqkDIlX1xDYU1ubojC1chlXpFxmjJ
EJsg/w/1rJrT73aWBesCODU0mHJoF0ouCTXN1t5MCJnnHK45u2rb+18piR+z95y5
iXcCVCAlz8G8Ahg8f4++7kengv6EjJ0+dsocs5bf5aceyE4D0Axy9CN0cQGf+60k
uihHpN5t+oaTZvccqavi/W0c1EbW4S5/7he0B7GekQLD3lUwPD4NULjljSEqofKl
XV+kngsN9e6lMZYIBZZTlkvNL/jyYzUDF5fx2kqtm/0Y1Z69zTRZPO5xPPQQicj+
NkCqUklTY+uTzNohwj2Lwt6/D9q1P0ldqCkz0a9scqoLUPKWuRsu0tg34/vAEUJk
xqVptkrfWZQWWcCb+bAfOw+bgspLh1U26zTIrHwcMyhujaICSAeSQeh5ejFm0Otn
xwPBuxju3WuvTsAMECPsyr/e5khZB27bMPOnioDh+Nx8qj4eXxffPQduPWRk5DKi
26eCmmVTXmkQNSe8TPryajqONF1/O088DOyztpsygO8dLMUpcj8=
=7Jpv
-----END PGP SIGNATURE-----

--nextPart3326948.aeNJFYEL58--



