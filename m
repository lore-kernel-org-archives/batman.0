Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75665D6C2AF
	for <batman-adv@archiver.kernel.org>; Tue, 19 Nov 2024 22:22:52 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C9E3883F9E
	for <batman-adv@archiver.kernel.org>; Tue, 19 Nov 2024 23:22:50 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1732054970;
 b=enRVdgr+EEUSGNcj5dYq9eEGnZW6qCYm7z4dvMKlHLvauvXosSSPwU4yMwz5P32EFtqgl
 CLtJ9qE4B7XHilk3jHJci49WhJ8l5YKLYz7hnr0mvSPcEIF7vJLm3zhLo9SXnHYIYNqp1UT
 SdxYBBS+w+8xJ6qbDFdr/IWBbhQroEg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1732054970; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=J9cdRAtnoHpHl/nBc3bWQqX9vO5BVm8602cupq/oGk8=;
 b=wTF5peQbsSX4D16Ts0LooQ6dtKTe5W2mYmLoTYrPR/gXKdLBWex8KhQCWwh//2tvfgD2+
 Bfls85wzcwt9DgaQeCgfvmH4o7dvqKNREFW/uZ7YFWrO5y2XPYNYG80nQ4MkFo3PPk706vj
 cOt0GYwl5MXFoiu650Ke4jN/MyANZ2M=
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
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 5A445833D4
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 19 Nov 2024 23:22:38 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1732054959; a=rsa-sha256;
	cv=none;
	b=oKFPa+kEE3tEsvBIeyjPmEB3QkGQT0obUvnyGDH1jxGSwva23ac6KJBQyaov5g6HL3M4ho
	n1wV4jzU/SlU1CXU6+dFsHPU7aCrOrdU4BSyXBkeeXaF2DmW5Z9u+JJsyYpgc0ppZNeE27
	gPc45aAFXk2OS1/Mg+xX3QbXXPUq3eg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=o+wJdp9B;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1732054959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=J9cdRAtnoHpHl/nBc3bWQqX9vO5BVm8602cupq/oGk8=;
	b=ye3SwhxNr/Qx+PMamKbVXOyfIzHULxm+SMCS8qdX/DdCqSk9p6LNRXpQAxcVDXtEbMjC6v
	2zeEOpKjE8/os4FtC/7LOp7gJDhmTEYNbXJBVd+AvSebfHlOs3zRoDHmap3yeSE3osrQ/M
	pv+jnHPcaNS3v5KqWFqN4jM8AStOFGQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1732054957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J9cdRAtnoHpHl/nBc3bWQqX9vO5BVm8602cupq/oGk8=;
	b=o+wJdp9BMOVxm7zNDw5DTaiSaJLptziB0Jcagsf7cxZ4mcXfWKw4H1kU2Hr04v52l4RN45
	ZanJQcIuAIttbgjUOtV/g2fiAVeKf8iVCwjGzCx52kwbQXij4zzsAh6MpGztqedo/cInxT
	9SV3KLSEEuu2ATyhyboHIKjnFQez5Lc=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: soanican@gmail.com
Subject: Re: IP connectivity issue at openwrt nodes
Date: Tue, 19 Nov 2024 23:22:34 +0100
Message-ID: <6133886.lOV4Wx5bFT@sven-l14>
In-Reply-To: <173205350334.676947.1092357942194170513@diktynna.open-mesh.org>
References: 
 <2631894.Lt9SDvczpP@ripper>
 <173205350334.676947.1092357942194170513@diktynna.open-mesh.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4998009.31r3eYUQgx";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: VNGJQC5TLZUSKSD2KSKST43D7VOHNCNJ
X-Message-ID-Hash: VNGJQC5TLZUSKSD2KSKST43D7VOHNCNJ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/VNGJQC5TLZUSKSD2KSKST43D7VOHNCNJ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart4998009.31r3eYUQgx
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: soanican@gmail.com
Subject: Re: IP connectivity issue at openwrt nodes
Date: Tue, 19 Nov 2024 23:22:34 +0100
Message-ID: <6133886.lOV4Wx5bFT@sven-l14>
MIME-Version: 1.0

On Tuesday, 19 November 2024 22:58:23 CET soanican@gmail.com wrote:
> my AP and STA were both on WDS mode, looks like batman is having issues with 4-address mac frame format.
> Taking them to standard mode resolved the issue.

batman-adv doesn't even see these headers. It only gets to see the normal 
2-address 802.3 header. This is why I said that you should have used 
tcpdump to capture on top of the underlying interfaces.

And to be honest, I don't get why you are using standard accesspoint 
interfaces below batman-adv anyway.

Kind regards,
	Sven
--nextPart4998009.31r3eYUQgx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZz0PqgAKCRBND3cr0xT1
ywcyAQDGAFekWhSFseXsV9q+Pl15FWtPQrB7g7TJAnU2NU6oaAEAonUJr5DT8wdG
K8Oh6xj/yonYYwmm5+0Ru0n+tJbSGQE=
=4BLI
-----END PGP SIGNATURE-----

--nextPart4998009.31r3eYUQgx--



