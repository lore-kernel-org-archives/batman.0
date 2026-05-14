Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A4B4CD4F25
	for <batman-adv@archiver.kernel.org>; Thu, 14 May 2026 08:33:26 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5140D858CC
	for <batman-adv@archiver.kernel.org>; Thu, 14 May 2026 10:33:25 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778747605;
 b=H2SSwwxyQRpvn9MfIhQPa7Nt2mTsd3CAcxsyBj2dqqpdpKBheOVbubFXW8NubGTI9+/+F
 VHuFtgG6WjVs2X+72gOK0EmHK4omxFaJJseeB9Eu7Lh60C6rNFscYuAGTM9T+8HfMMjhrLF
 a3zELdS58Y0bPe++M5vuwZoE+YPj3KI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778747605; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=pOC6KBcYvK7mpcWbdDYjYFsPQAOHt1igs+BK4MfBbAY=;
 b=0j9xdISUaRuvhAttMssfSr+Zl/4/Ey66UvITOYExxX+ayfNvD6kcGpo/oMg9J4ocf6ARq
 Z2AEQJRpcmATJ4gGRV0/RoSt5+cmUkdOQqP5c0WGrsKOmTTUlS+5tzouJF7NU2pCcRaEe57
 6gByVQGb5WS6foyiMGOUccRuYveb/WE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 427F4802D2
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 14 May 2026 10:33:09 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778747600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=pOC6KBcYvK7mpcWbdDYjYFsPQAOHt1igs+BK4MfBbAY=;
	b=TqEb4x67KB6yBYh1btHVu1SPN8fMBIY5XbMVO8SpIdhnul0Y28F6pKIECmRUfXf7yQisXJ
	gcPOKRDQ4Q4b0U4CJ9Mu2hvBZ6CtloaAVID5wxigJZzxL17nIgqR5o8oOXXoiIGHUEH4oq
	aik5BPDl1MuTEgqq1dT9U5s+h2Y9kS4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=SHCU9PZW;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778747600;
	b=3jKfNodB5lxYAyaiZyO4w3jlIOoLuf7O2e5xROPiujZysrDtXRfoDCVY0mpUIq7qe6TcTV
	LY46agxnxdb6oXyP+DRJ26G4fNBmHJW7H5+oOZTOHnOMxuFvxzCWZF383xgn3OE4Ba847/
	VXnI2/zrepKwSflaalOrgROkjGd0jyM=
Received: by dvalin.narfation.org (Postfix) id B0F7C200D8
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 14 May 2026 08:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778747588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pOC6KBcYvK7mpcWbdDYjYFsPQAOHt1igs+BK4MfBbAY=;
	b=SHCU9PZWCeiV8L5kGhxr05E8ANhXj2Toxt1P6bjHWdsrQByv4VEj3NRDrpEI8Rd2vfuLw2
	JS5bxEfq+/+TLXtY0XrEWx5mOBpZrmsGpq+pTGWxQAnm7Tz18py7d8utanBS69cw7wzixg
	6Zg7YYzo6aWqnLMnGcUjgN86g6xPIzY=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH batadv] batman-adv: tp_meter: fix race condition in send
 error
 reporting
Date: Thu, 14 May 2026 10:33:05 +0200
Message-ID: <5993633.DvuYhMxLoT@sven-desktop>
In-Reply-To: <20260513-tp-reason-missing-v1-1-752a882bd61a@narfation.org>
References: <20260513-tp-reason-missing-v1-1-752a882bd61a@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6267779.lOV4Wx5bFT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: VNW57LABOLX4XGWXACHLBUAEXLO3Z4CB
X-Message-ID-Hash: VNW57LABOLX4XGWXACHLBUAEXLO3Z4CB
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/VNW57LABOLX4XGWXACHLBUAEXLO3Z4CB/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart6267779.lOV4Wx5bFT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Date: Thu, 14 May 2026 10:33:05 +0200
Message-ID: <5993633.DvuYhMxLoT@sven-desktop>
MIME-Version: 1.0

On Wednesday, 13 May 2026 23:57:52 CEST Sven Eckelmann wrote:
> +       /**
> +        * @stop_reason: 0 when sending is ongoing and otherwise
> +        * enum batadv_tp_meter_reason
> +        */
> +       atomic_t send_result;

Should have been @send_result
--nextPart6267779.lOV4Wx5bFT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCagWIwQAKCRBND3cr0xT1
y6KtAQCELiTtjggqQwcrJRvj6KTYu4AnSRHYyL8cKCKw9NZX6wD/Yt+dj3cap1xa
NdWreAuiu9T8DuGNDSUSmIhPNc479w8=
=2cYa
-----END PGP SIGNATURE-----

--nextPart6267779.lOV4Wx5bFT--



