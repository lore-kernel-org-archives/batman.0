Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D2DCC04A94
	for <batman-adv@archiver.kernel.org>; Wed,  9 Aug 2023 15:34:31 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9FF1D8311B
	for <batman-adv@archiver.kernel.org>; Wed,  9 Aug 2023 17:34:29 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1691595269;
 b=HRFWEOOhymjC9XxB/IhPQXQ0kD1sJao2emkcSEZeGm6F+zfFxxfVM0Lq/c86k6eZdIb2d
 mUAGijm+hBhv/v0ZI5tHpEkStGMPISnbe45/M91+PDJ96D5Tg0mnLVwvP+bv+2ytpNEGf1A
 nJ981NXT3xaK5TT8eDVTTd/PH8YFMgI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1691595269; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=IUjvc0hCBrzREs+fZbNzsO+5+uaKgJCIeVukgQ8i7+A=;
 b=WDGSXutbwkqD7IzHa2KKg1eKMei7QjdhKRNEsIIteudx5f9ofdHRzlu9HlyIef6PkL2/r
 +NvPHtpHyYCi5ZfngypqzzhTlclmjRxHtKmM9MwRsdCQhFWVOTKOYCVNsUW+yqNW6nvhMkW
 ebxJyMYdqz02xm1iYWsvFnsNRSATjF4=
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
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 9C6F58044C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed,  9 Aug 2023 17:33:56 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1691595236; a=rsa-sha256;
	cv=none;
	b=FL3Xg1O/t9Lj535sqLTf+Xp+ekdO+yjWqV/uyVz+M8Vf+khr1RvSDmVFErXwCOXC7caSTA
	ZbtTGZC2Fn7OxPcgwYSlh2WNYE9Rl7cEsnieap+IU5pH+1dSIjx5y580AQ95RrBZeGBfWp
	0dO3u/8eajrOfYJThnO9S+co/4ZszBM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=cKfZCdNK;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1691595236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=IUjvc0hCBrzREs+fZbNzsO+5+uaKgJCIeVukgQ8i7+A=;
	b=zTbcWakKhSY8iIkwvZkd/MHhaV2IiPfjWaho6wgKuqpztjD7fBAA8g3NsV8VEdBpoecZsb
	cRtxNJtdp3qEuSp4/T8ll4m2P8z3nZjqoDNlqjo/Z0z12pyHcP5XUtxxmTFBSjwGxDbQpu
	kpS/YZMoK3Vt5HM+hSYBDR0heeC7h2g=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1691595231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IUjvc0hCBrzREs+fZbNzsO+5+uaKgJCIeVukgQ8i7+A=;
	b=cKfZCdNKT+zUlLJDSNainIts3G762q4FHCKWv0eLr8bs4hwYSlWpHoN7Dz95Shd2dcZOXc
	KQEn1hkpHvqmakvqqH1xgHX2K9IHD7OYlrtJYTsjx6crBMCpx1VDYtaZuoUSgPvtYzQWMq
	MkjSbrAmj8zDN7r/k6ZCxMdP7aUhZ80=
From: Sven Eckelmann <sven@narfation.org>
To: Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>,
 Remi Pommarel <repk@triplefau.lt>
Subject: Re: [PATCH net] batman-adv: Fix batadv_v_ogm_aggr_send memory leak
Date: Wed, 09 Aug 2023 17:33:49 +0200
Message-ID: <1951515.yKVeVyVuyW@ripper>
In-Reply-To: <20230809152913.27218-1-repk@triplefau.lt>
References: <20230809152913.27218-1-repk@triplefau.lt>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2119410.OBFZWjSADL";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: 4EGF3SQNU5WJ6ACT4XDUPAVPYTERWJZ2
X-Message-ID-Hash: 4EGF3SQNU5WJ6ACT4XDUPAVPYTERWJZ2
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, b.a.t.m.a.n@lists.open-mesh.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Remi Pommarel <repk@triplefau.lt>, stable@vger.kernel.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/4EGF3SQNU5WJ6ACT4XDUPAVPYTERWJZ2/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart2119410.OBFZWjSADL
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 09 Aug 2023 17:33:49 +0200
Message-ID: <1951515.yKVeVyVuyW@ripper>
In-Reply-To: <20230809152913.27218-1-repk@triplefau.lt>
References: <20230809152913.27218-1-repk@triplefau.lt>
MIME-Version: 1.0

On Wed, 09 Aug 2023 17:29:13 +0200, Remi Pommarel wrote:
> When batadv_v_ogm_aggr_send is called for an inactive interface, the skb
> is silently dropped by batadv_v_ogm_send_to_if() but never freed causing
> the following memory leak:
> 
>   unreferenced object 0xffff00000c164800 (size 512):
>     comm "kworker/u8:1", pid 2648, jiffies 4295122303 (age 97.656s)
>     hex dump (first 32 bytes):
>       00 80 af 09 00 00 ff ff e1 09 00 00 75 01 60 83  ............u.`.
>       1f 00 00 00 b8 00 00 00 15 00 05 00 da e3 d3 64  ...............d
>     backtrace:
>       [<0000000007ad20f6>] __kmalloc_track_caller+0x1a8/0x310
>       [<00000000d1029e55>] kmalloc_reserve.constprop.0+0x70/0x13c
>       [<000000008b9d4183>] __alloc_skb+0xec/0x1fc
>       [<00000000c7af5051>] __netdev_alloc_skb+0x48/0x23c
>       [<00000000642ee5f5>] batadv_v_ogm_aggr_send+0x50/0x36c
>       [<0000000088660bd7>] batadv_v_ogm_aggr_work+0x24/0x40
>       [<0000000042fc2606>] process_one_work+0x3b0/0x610
>       [<000000002f2a0b1c>] worker_thread+0xa0/0x690
>       [<0000000059fae5d4>] kthread+0x1fc/0x210
>       [<000000000c587d3a>] ret_from_fork+0x10/0x20
> 
> [...]

Applied, thanks!

[1/1] batman-adv: Fix batadv_v_ogm_aggr_send memory leak
      commit: 421d467dc2d483175bad4fb76a31b9e5a3d744cf

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>
--nextPart2119410.OBFZWjSADL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmTTsd0ACgkQXYcKB8Em
e0avDw/+MF/kddOKnCxKk9v0V/vSIk/U0uEOmlH7zC7YPuyOGgFZVxIF65zdp5N5
hSaVC4pM2qY2BM3W4ooN8OZOvaNzWIURKWG1Dy6Wv8OCfqGNPYDsg5K/c13pMbBo
ovHZzZDGaM9aQgTkstHsgX2f05HkCDsTZlwlmH5A4XE4HJhiMWcD6q939UWnMLrW
lEXmm3nQ4M0ZCiRWg9dwLv92h0POfi3G1Svg0CZ+82+rrrde3Rtjsuo3qP+D2yk2
aNI6z10VOlh6e0CG/hGAwJ5r521aYyozEMv9NRwCycTMupA9gP/VGbvhHe12cVOF
67lG5E7D1L9t9lqNeUWrAq99IW4GSQsITaUlOg+aWDw8BahBe1ltfsW3pI63nisG
pUvwhvv6fEVpnJHblV37JvVxNkc/rusWdGcxPP5oLFQ2kS3U0DD9xU07UhTrt0ei
R95iwjNw7UxXY4T/nWpeIKoBSq9tVwjsw3A39lMaF7viD7aBl2WHtOMc11H12qSG
U1L5TrgQUn/YNBeIbqq7FYIr1XHmpSN0fS3AIwvWlySGmvr/NM2ycQM+Ceq0878D
dHFQ8l3FpuXop+3/OtaWzO/ix13MA6eYsggfez0xSQgWVJg1So7Na46rO5ijoLEJ
++o3GT8ruQOz4PerpQo1Ib6kNSeMPcM4DYWjBN1BdBXB3IfJFxg=
=ARQj
-----END PGP SIGNATURE-----

--nextPart2119410.OBFZWjSADL--



