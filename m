Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1352DC7EE23
	for <batman@archiver.kernel.org>; Thu,  8 Jun 2023 16:57:56 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 12A4581668
	for <batman@archiver.kernel.org>; Thu,  8 Jun 2023 18:57:55 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1686243475;
 b=zftDN8u8CY5pMtr/FQ7KZ5g1X5qTo4w0/dD+OKCygw2pdV7y7PsVLcB005PHb3cFUv9ka
 amNgxshLNGAzYRkHy3cMejsv1F8vsG3jeLYjG2kEpFTOJArmgNLKpE1rxG3ahmQzsnjXReW
 tllv5LjiHAdK3ilmP7H+88Rkmie9u5M=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1686243475; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Swrwi2+BTcTTOtQrnhZFPM4TZWnkfpHRVJ6RdmbTlE0=;
 b=zkr0um3ZT37K6OQzgFvFUScazzy7+gemTxvjPyYU0wCYVCOASfSDP3mHRuFmr86XR/fnm
 mMqAGp8DT19vHjrJto/k4CSJvr0YWTiGc2mDMhumA2LbhrFpEBOthRe0OnlQu7l45UXRQK/
 Wa7TnBNnWvJ/ym8v+EQGirn7Z1Sw8Sc=
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
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 73CE8803FF
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu,  8 Jun 2023 18:57:50 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1686243470; a=rsa-sha256;
	cv=none;
	b=ihRk5Pbo1sm3djmujLBBvj1jhjhZe4lc+w7e0W9We3v9kSAU27bg+ixB2bM/9CPIpLLW1W
	JyglCHsXF4VSgCpN/InyAOkOQERlKdWFoWK3wcKiwLle5Qbr+4X8atKdDPIouZ/H5Wz4tR
	TJPMohKwh5y4JVrKB9M/MTrt2sNOth8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=ts56ChoV;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1686243470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Swrwi2+BTcTTOtQrnhZFPM4TZWnkfpHRVJ6RdmbTlE0=;
	b=gaZRY1uyMjw9kITuq2n7PFJN/CprI+BwFm/k+tU96qDPFJAv64WVj4wZPu8jiCeyPkvdRF
	86bNK9YE+E406T8rjRWbtqPmXw4wYaKKDIMioAgQurwJ+yJ13DP2TRt7xYck85P1lp1AA/
	+ZYlfgN8h5e9HofhxFTgZfY/GEm3KVA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1686243469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Swrwi2+BTcTTOtQrnhZFPM4TZWnkfpHRVJ6RdmbTlE0=;
	b=ts56ChoVKHSa+PpM+jwHHKcTXXuIMuBIxHOooXE82cCA4bru4SJPi3DLGPspC/MRWxzO9X
	DLu4GEzka7miDcMryYZxkt++k9fw2wpmL2Fk85obvi+fOp8RUtx4TaU9f4DdQNJJy4vut2
	8hmU/vqd6IRV0yUOEV8+2xL8JWARrzI=
From: Sven Eckelmann <sven@narfation.org>
To: Jakub Kicinski <kuba@kernel.org>,
 Simon Wunderlich <sw@simonwunderlich.de>, Paolo Abeni <pabeni@redhat.com>
Subject: 
 Re: [PATCH 1/1] batman-adv: Broken sync while rescheduling delayed work
Date: Thu, 08 Jun 2023 18:57:44 +0200
Message-ID: <5681063.DvuYhMxLoT@ripper>
In-Reply-To: <6a36f208b961181df9a0c611a6f5ffc4c76911f6.camel@redhat.com>
References: 
 <20230607155515.548120-1-sw@simonwunderlich.de>
 <20230607220126.26c6ee40@kernel.org>
 <6a36f208b961181df9a0c611a6f5ffc4c76911f6.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5940952.lOV4Wx5bFT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: VJLZG2XYYR2CHDT4OOHE5VA3HMCDUPW3
X-Message-ID-Hash: VJLZG2XYYR2CHDT4OOHE5VA3HMCDUPW3
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: davem@davemloft.net, netdev@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, Vladislav Efanov <VEfanov@ispras.ru>,
 stable@kernel.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/VJLZG2XYYR2CHDT4OOHE5VA3HMCDUPW3/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart5940952.lOV4Wx5bFT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 08 Jun 2023 18:57:44 +0200
Message-ID: <5681063.DvuYhMxLoT@ripper>
MIME-Version: 1.0

On Thursday, 8 June 2023 11:27:31 CEST Paolo Abeni wrote:
[...]
> > We're still not preventing the timer / work from getting scheduled
> > and staying alive after the netdev has been freed, right?
> 
> I *think* this specific use case does not expose such problem, as the
> delayed work is (AFAICS) scheduled only at device creation time and by
> the work itself, it should never be re-scheduled after
> cancel_delayed_work_sync()

Correct.

* batadv_dat_start_timer is the only thing scheduling it
* batadv_dat_start_timer is called by:

  - batadv_dat_purge (the worker rearming itself)
  - batadv_dat_init (when the interface is created)

Kind regards,
	Sven
--nextPart5940952.lOV4Wx5bFT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmSCCIgACgkQXYcKB8Em
e0ahnQ/+PJdBfj+dwesG6ozn6XhVZsKGvFnJ9wZ7+g3EfWPDJ+jtobwN2g8oRfSn
nUWhNXD+Dj1+AFLxc59t3M+TlFuMtEIujprsRTnrMSRRGWbQl8HNU/aa0JDpkJKP
jrnIELPjGUdK1IgVd0XilH8fpKid/wleacRfIKAwa5JCyfL7LeK/28CnMpb5+l1p
zwJo2xyZJKTx0jUNuK1yh55pzwPtHftWEp6mIx+wOnebcZg1+c/dmyB0IfV3PaCQ
cu0igtHvFPFdT/xONvWPbGTLf+XypCVElAiFgoQZgwl9hZdG1a8is5CGJzpxubn5
AWQXCqcRyAiqNmEiTnoevRcO/WNesevwv7xi51/QJPvVfidC+Q4qEW3yzSY0X9k7
aNs6P1L4mJE2bb1bR225dErrQ3coQX9Sg9HNAV40iY9C8QwROCmZNQfBTi3jI3H4
EjftcdKnNi/UMuM7hjy1VzOX36nEfQmtp/qsPS6MdzsFDld1aBB+8CUxaTXjZNdJ
FHDODNiTZiRqudzytfR6dj70HInTStStsGWctE3k0XJcXm0pfrJp/E5jy+dtEtxz
GED67B8l0bCA5MjCGvSofR1g5DQ7lqZBlUcoD0NdmYM5roi6XRO5DsMTEfuVxMqN
tgjKnD/VmfYBHj7Gz9Zjgr803wamzjsacP/dXOLo6mNafuzlLpM=
=v3Ii
-----END PGP SIGNATURE-----

--nextPart5940952.lOV4Wx5bFT--



