Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D2BAC00A5A
	for <batman@archiver.kernel.org>; Thu, 19 Jan 2023 12:47:51 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0F89C83E93
	for <batman@archiver.kernel.org>; Thu, 19 Jan 2023 13:47:50 +0100 (CET)
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id C40B78065D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 19 Jan 2023 13:47:26 +0100 (CET)
ARC-Seal: i=2; s=20121; d=open-mesh.org; t=1674132446; a=rsa-sha256;
	cv=pass;
	b=RmWWiayblypn0yFXUwumSZ15pGPYsa3TbEh7OF7M0dJ6BmeqkRNhnPoA0gysR9SLA4EpM0
	a3QVQcIcmGxq0al2zVH5w+JrXBsMZ71y4ARpO9Y/3Hl4mIU2jImHn5BTBDssQr2xPD9pA9
	snoaJqxo2sG9Z36EidHTXvWbjCdMtws=
ARC-Authentication-Results: i=2;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=OOWjXcDx;
	arc=pass ("simonwunderlich.de:s=09092022:i=1");
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates 2a01:4f8:c17:e8c0::1 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1674132446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=QcyWxqEjLoaRUMlDZmfYppbESaXi4aaTVp7f7OkAEn8=;
	b=25dCkuqKvkWDtBtH1mInSWrAmVBFIQiPwwWYasvvLM50pTFGO0wOWBgJN8XfOK9SI5Dd+T
	9tjRQXCIC7lJPnpLN4w+aeckRaJ9C2e9RSmf6SzINyw/CVYp9JLieXAgNBRjY8BlIW64DO
	ux3mOA2IlBEKc6QYEpGWXFmbH7puIZo=
Received: from prime.localnet (p200300c59728DEd875eA98F0f509C43e.dip0.t-ipconnect.de [IPv6:2003:c5:9728:ded8:75ea:98f0:f509:c43e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 59F59FAFBD;
	Thu, 19 Jan 2023 13:47:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1674132446; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QcyWxqEjLoaRUMlDZmfYppbESaXi4aaTVp7f7OkAEn8=;
	b=OOWjXcDxGl48fGb3+OHdf2tZQ6YNqFa40TIj0xepSXqP1dc8QDnbyd85NykXyLiZHOuz4C
	SmUQTfdq1ysXw2PPADrzNZiUXMmC4LKkdghoOhtijbG/HL1n1Xg880rqBjUKGehqLgl+AP
	vx93XP3t6wUqZSldXCjXRax9w1OZGM0Z3mvlI6sXnaIVgoOUcvK8DkUpouc2brhobskC2P
	PIB0kox4gBSL/Q1VE+bkEhIFhfsWs6Yw6p6D/C7n8y8jycsfmGU6CmheGqWlaHL9qLPo/z
	ats5lRIUYt/jGzAd9/evgy8559TUYt7uC0RcvaWJZB1e6cWyf8ULcDtu715bqA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>, Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Subject: Re: [PATCH v4 3/5] batman-adv: mcast: implement multicast packet reception and forwarding
Date: Thu, 19 Jan 2023 13:47:25 +0100
Message-ID: <2927983.YVBx59ikfs@prime>
In-Reply-To: <20221227193409.13461-4-linus.luessing@c0d3.blue>
References: <20221227193409.13461-1-linus.luessing@c0d3.blue> <20221227193409.13461-4-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1721268.p0HWoCWSJs"; micalg="pgp-sha512"; protocol="application/pgp-signature"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
	d=simonwunderlich.de; s=09092022; t=1674132446;
	h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QcyWxqEjLoaRUMlDZmfYppbESaXi4aaTVp7f7OkAEn8=;
	b=IJLk1xmXSaAoKcD2gQQVguLQ8ttXIH6NniJJmcoitZjyKlWNhPHOo5FNae3+erv3AdX2GM
	FkawmMayNpAqvrenMO/7ClD2Lj51meGG1tVAPiYUGQ4VTRxHlXoSvV+z4i5e02izpZjj8p
	9qUXzl1v+iwzu4AEMNhzPtwq3fyAhpMqpHrj7DNJYWxGRz5ZLUH1T/rqUgBtBLJnIsadSJ
	fT1mSYWvHIKOGeLEdT4I8v9Y4QlsGXCx1y871tdWPMRCJ+U6AQYFhvT8r/PhK6RoyE6Gu4
	bi6FnRRx4SpM0ShQR8Qb6eIckqMM6+MRz5jvHyH0cCVnTcg+m9xcL9BIJSH0bQ==
ARC-Seal: i=1; s=09092022; d=simonwunderlich.de; t=1674132446; a=rsa-sha256;
	cv=none;
	b=GMhQj1PXajaYC6rPM74A/O317c/ly0sbHJ6pkEMFdfZi+JaqpU1rNdfNnt6mvvovcWXvc6abzromwCe1fgb5KV83accoBuAYxbbJNJcb51/GZlzrqdE7YenaBbfbp0DvmoHA3WK6hzJm7y6VAGZu346NF+h0h80DdOyXzR2+OPq7U2tvFlYVLyD+03M6hlJxC6lSfBFlSJlKnvsBqkWdV9Ipf94vwGLKRyP2pY1BlRiw8RwjFQ098RpPjRPfuXc3Wsgc5Osj+G3Szq/FEOgtXNtnjb2yrgN4yiqk++nzFQ1/ZsfYgotiXTKd3p/FVXONvhGrq66svncXB8aooE6WQA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sw@simonwunderlich.de smtp.mailfrom=sw@simonwunderlich.de
Message-ID-Hash: M5ZCNHMRMJFWMORKT4OC6WJMXO4FO25N
X-Message-ID-Hash: M5ZCNHMRMJFWMORKT4OC6WJMXO4FO25N
X-MailFrom: sw@simonwunderlich.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-b.a.t.m.a.n.lists.open-mesh.org-0; header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.2.1
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/M5ZCNHMRMJFWMORKT4OC6WJMXO4FO25N/>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart1721268.p0HWoCWSJs
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; protected-headers="v1"
From: Simon Wunderlich <sw@simonwunderlich.de>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>, Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Subject: Re: [PATCH v4 3/5] batman-adv: mcast: implement multicast packet reception and forwarding
Date: Thu, 19 Jan 2023 13:47:25 +0100
Message-ID: <2927983.YVBx59ikfs@prime>
In-Reply-To: <20221227193409.13461-4-linus.luessing@c0d3.blue>
References: <20221227193409.13461-1-linus.luessing@c0d3.blue> <20221227193409.13461-4-linus.luessing@c0d3.blue>

On Tuesday, December 27, 2022 8:34:07 PM CET Linus L=FCssing wrote:
> +/**
> + * struct batadv_tvlv_mcast_tracker - payload of a multicast tracker tvlv
> + * @num_dests: number of subsequent destination originator MAC addresses
> + * @align: (optional) alignment bytes to make the tracker TVLV 4 bytes
> aligned, + * present if num_dests are even, not present if odd
> + */
> +struct batadv_tvlv_mcast_tracker {
> +       __be16  num_dests;
> +       __u8    align[2];
> +};
> +
The one thing which I really don't like is to have the alignment in the=20
beginning, and depending on the number of entries. Normally, such alignment=
s=20
should be at the end of the structure so it is straight forward for a parse=
r=20
to omit it.

My understanding is that the alignment is due to technical reasons (mac=20
address list is assembled by pushing the data to the front), perhaps to sav=
e=20
another memove/memcpy. However, the data is collected by traversing various=
=20
lists, and if performance would be a concern, then this data should be cach=
ed=20
and this "technicality" wouldn't be needed either.

So please, skip the alignment in the front and have it in the back.

The rest of the packet format looks good from what I've seen.

Cheers,
      Simon


--nextPart1721268.p0HWoCWSJs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAmPJO94ACgkQoSvjmEKS
nqEmwQ/9EBE8qyrT1VZjLjRVbE8il+NogWnhZmN6oe1jSjYlLYvUYlrL+vAp6YQX
2SXHlXVFUJUBKcUeIcqPCq96JsB9gUOFIQNUHE3we01Df9MEqaEc6xbVN+dXjWr8
Lut91frqSJjkxePRH8Scpy/53KRyaEsjViba156yBUCbM2w17HYYq5g2/e7ZnlYe
PerJXeEwDNrsf/SIauBDuOuiZMKWFD1XBUzlZ880gJnupcaNvXMsvSXaahTC7R9V
1P0/r0lM/yYfjZSw/IKZkjEtrS80CotfmFTZHmPhs3kwLuTuM5lL/84jVHKLCuBD
xqi0lzWs2StQ4STm0ostdHWobPG8LU0n54j7gnhp6L/hgJe1TJBMA8f5k57LSHn5
i/Vk+7Im9tJCleWE9JbB+VNgZoLUG34UkIGUL14Nu67pYMaMRc71L7Cq3a4SqB3n
/EBlhflTxlnTSlGJmsEvEN1eA32I8UFdIuzyzVXqOw2Uip/xK2dI1Jt2y8khETFI
M7MPVPx7Gwqo4e16CZMlZdJgJ5WMG6UrjqJ+f3dmlO4ko7E/7gVOnFFuz5zTEOyT
A3MK5t/Dv/MQohKiKo+iyFepelOPtYwzhyoWHImoAM6cMoUSKnfBtpeopUN3OgF9
KIP6QvgOow2pTVOY3j+MQizDeq90A3BzEQ5BDAhOKMF/QrKkrj4=
=5IvU
-----END PGP SIGNATURE-----

--nextPart1721268.p0HWoCWSJs--


