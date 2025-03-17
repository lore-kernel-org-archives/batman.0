Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B19DDC282EC
	for <batman-adv@archiver.kernel.org>; Mon, 17 Mar 2025 11:16:32 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2DD83842CF
	for <batman-adv@archiver.kernel.org>; Mon, 17 Mar 2025 12:16:31 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1742210191;
 b=xTLDnLJPYvyLSNjCIbL/wItENR+/fVEYE+bcM3BaUjBNM/XTLif6SJGrF35xsJvQuveC3
 0fgeFV3EFZFRLdrKH9FEu1OFNalFaAyBlxov8ZZDMJ73qeaPQwkhMrvvaTa+HsBtacvmmf4
 eFbUT8IJt5ngoLO97FMJqF4SlKZ7YoM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1742210191; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=+Oh/l+vLDDyx9iXLoYHtEzt1lfkvZblSSRlq/TmUws0=;
 b=EWL8mxeN2ymXtxlWw/HB/pr2N0IYLsh1mjs71HQaP+oE1ZdoSNvAtfIEuvqRSGsHRep92
 biqqvruC8t6bgXIe/QBco17xNvjzdZC5RmEn4g969J/FH5UW5yqNd85y2+Q2CXKRVRTbr3i
 1y5h0XcPi2fMXgZ9DWoNv/kuHzoBoV8=
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
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 8EC7381F4B
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 17 Mar 2025 12:16:20 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1742210181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=+Oh/l+vLDDyx9iXLoYHtEzt1lfkvZblSSRlq/TmUws0=;
	b=qo6IteQ2iQqTXx9XBu7GMFw14M6EudhTbeF0xVz5XdgKaPjN1MrpqTNgarh9xMH+mSAOF1
	t2AF8EODJcT3EVSa7Wb9AoGVcsjRdMhHCMKfEaiA8Bv7K7Zqi/l/u3fqeaY+3cKp/B4nEt
	TdxTwkHXLV55tWphbw+9lqvuX+oTOtw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=c1Idg7Nv;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1742210181; a=rsa-sha256;
	cv=none;
	b=L+OSkEGr8rfr0B7Wo4dKtY21HPM44m/e2DfcDQxTZM6Ug/lQoPxP1GFlZ/UwLjNUZWjs/O
	zw1SpERiBPtERqNslr5Ki3VU1An3jarY9c1KFOpyahHGsb9glPu13M0xt2AXfNBrkWybwY
	L/8oMuVnF0D93EA9h/sjomWY18n/yMI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1742210179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Oh/l+vLDDyx9iXLoYHtEzt1lfkvZblSSRlq/TmUws0=;
	b=c1Idg7NvX32RvWD0f4wmh0w5L7qKVWpfI2/RMxLt88ph+FV4kuO6lBI93BnAjy/I8hAUrh
	VDGIzkTfxLbxR3TBSo4Ry5DX1qQjG5qBMeO29uugn7St4PIrP766U8WYjp/ymQGVBZCbnh
	vd4yr7KHq04RgikBUHZvUYkiN7f9rCw=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <antonio@mandelbit.com>
Subject: Re: [PATCH] batman-adv: no need to start/stop queue on soft-iface
Date: Mon, 17 Mar 2025 12:16:16 +0100
Message-ID: <5871015.DvuYhMxLoT@ripper>
In-Reply-To: <20250317105434.17545-1-antonio@mandelbit.com>
References: <20250317105434.17545-1-antonio@mandelbit.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6139530.lOV4Wx5bFT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: L2R3D334OWILE6AFZH7EHAWUIU2O5XO7
X-Message-ID-Hash: L2R3D334OWILE6AFZH7EHAWUIU2O5XO7
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/L2R3D334OWILE6AFZH7EHAWUIU2O5XO7/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart6139530.lOV4Wx5bFT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 17 Mar 2025 12:16:16 +0100
Message-ID: <5871015.DvuYhMxLoT@ripper>
In-Reply-To: <20250317105434.17545-1-antonio@mandelbit.com>
References: <20250317105434.17545-1-antonio@mandelbit.com>
MIME-Version: 1.0

On Monday, 17 March 2025 11:54:34 CET Antonio Quartulli wrote:
> The batman-adv soft-iface is flagged with IFF_NO_QUEUE,
> therefore there is no reason to start/stop any queue in
> ndo_open/close.
>=20
> Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>

$ b4 shazam -s 20250317105434.17545-1-antonio@mandelbit.com
Grabbing thread from lore.kernel.org/all/20250317105434.17545-1-antonio@man=
delbit.com/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
Analyzing 1 messages in the thread
Analyzing 0 code-review messages
Checking attestation on all messages, may take a moment...
=2D--
  =E2=9C=93 [PATCH] batman-adv: no need to start/stop queue on soft-iface
    + Signed-off-by: Sven Eckelmann <sven@narfation.org>
  ---
  =E2=9C=93 Signed: DKIM/mandelbit.com
=2D--
Total patches: 1
=2D--
Applying: batman-adv: no need to start/stop queue on soft-iface
Patch failed at 0001 batman-adv: no need to start/stop queue on soft-iface
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
error: net/batman-adv/soft-interface.c: does not exist in index
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch



Might be related to the fact that soft-interface is now called mesh-interfa=
ce.

Kind regards,
	Sven
--nextPart6139530.lOV4Wx5bFT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZ9gEgAAKCRBND3cr0xT1
y0gqAQDIchrSTcjUVlTj4msCgp9RoTTPax8O/B5WA1efh8xhBAD9HMAPhMwRNMUr
UCcpBqvxpR+/CKeSVsC1V1Nmt8bD8wI=
=L/IQ
-----END PGP SIGNATURE-----

--nextPart6139530.lOV4Wx5bFT--



