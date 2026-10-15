Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A5C6CC6B34
	for <batman@archiver.kernel.org>; Thu, 15 Oct 2026 07:49:26 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0F72C845CF
	for <batman@archiver.kernel.org>; Thu, 15 Oct 2026 09:49:24 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1792050564;
 b=qrfdyuu9MX1Pwhg22lx4B2fYf+EFWPFQIDZAph8UTzKe0hnNbAQS9MMhz45zwtKvIJgUN
 PBUUE7Ak3kyWuaQG3osDgbmwLPsyqOk4RlPHUmAiSCg5/+FHaX9XIAlCmgn446ZPmb+Oh0z
 n/sAGjuMEcPtCm65RpT4/BpjTPqctwU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1792050564; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=2Z04HSMPCq4TStSlOrI0Qzkx+UdltHqoHvsA/gtOiko=;
 b=zMfbSCkY7Ehzxeqnp1Xx9VeLRpC6M4GhUaeBQptwtR1fiDz9jyPfq2tzB1j3TyiTKg8uT
 b+hDDgzzuBmCquah1pRSe0SZAb8eiEOvc6gHAh3shq5Jf738NEXWr66uB1TRxOyslRwBpSb
 58AiWtay7WxIWpQ3UpQ/rBVC5lDF69E=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id F27BD80454
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 15 Oct 2026 09:49:03 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1792050554;
	b=BxhGFPEzFzamCdUXhuEcFMd1D6OSqmsSPr4b8KAZgeMdxPivjqNwwus9YJlrTlJppB+dHr
	QfQnzO/KXaUXF7TFUR3LkQKy2j333u6Q9O0wPTY4p2YeXMSgUvXiieA+zuun1uxxF9CgvQ
	KXc/citPm88jgDAED6HDmfDxjVZMgMs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1792050554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=2Z04HSMPCq4TStSlOrI0Qzkx+UdltHqoHvsA/gtOiko=;
	b=Sw6bACg2ByJOcPdbfX0eTCu9DkeTzCwSnO5ZLo5ZGFfD9fVKjsqiV9SYes1quRaMq7ChmT
	hkdI4tlRI9KdZLHE0urhxD/AonrM7We4dSoX+5lCqdVQAg8k7iegwpN6zma0d+TX7OcP5N
	ueyzXhmhWZb7ODZKAEwezxw3b7Uo8cM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=hAYWudea;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 054D6202DA;
	Thu, 15 Oct 2026 07:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1792050538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Z04HSMPCq4TStSlOrI0Qzkx+UdltHqoHvsA/gtOiko=;
	b=hAYWudea/+8ozZBecqfImxsPSlMPCSdnQ1GwMLkgnrDE56o3FXg5bcYo67x0XuFi7uB1dZ
	kUM4khEPB+FXLseuUuNisOUf20yphwS7YRJv35H3z9XjN8ajHIJvd+Ybnl/HgFtHpl92FB
	MICMiS4nptzYrmWn8YSdEt+nMBmjE3E=
From: Sven Eckelmann <sven@narfation.org>
To: Linus =?UTF-8?B?TMO8c3Npbmc=?= <linus.luessing@c0d3.blue>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH batadv] batman-adv: dat: initialize orig_node of unfilled
 candidate slots
Date: Thu, 15 Oct 2026 09:48:55 +0200
Message-ID: <2865631.mvXUDI8C0e@sven-desktop>
In-Reply-To: <asTVqLO0EWAVM_IE@sellars>
References: 
 <20261004-dat-eligable-uninitialized-v1-1-9674029343da@narfation.org>
 <asTVqLO0EWAVM_IE@sellars>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart13002458.O9o76ZdvQC";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: 2CHQAJ53S5XMFCLHIX3VXGIX5LXB6TQD
X-Message-ID-Hash: 2CHQAJ53S5XMFCLHIX3VXGIX5LXB6TQD
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/2CHQAJ53S5XMFCLHIX3VXGIX5LXB6TQD/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart13002458.O9o76ZdvQC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Linus =?UTF-8?B?TMO8c3Npbmc=?= <linus.luessing@c0d3.blue>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Sashiko <sashiko-bot@kernel.org>
Date: Thu, 15 Oct 2026 09:48:55 +0200
Message-ID: <2865631.mvXUDI8C0e@sven-desktop>
In-Reply-To: <asTVqLO0EWAVM_IE@sellars>
MIME-Version: 1.0

On Tuesday, 6 October 2026 13:04:08 CEST Linus L=C3=BCssing wrote:
> (Also, I can't read the Sashiko link, I guess it's only accessible for
> maintainers?)

Please try out the link from the patch now. It should now in theory be=20
accessible by everyone.

Regards,
	Sven
--nextPart13002458.O9o76ZdvQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCatCFZwAKCRBND3cr0xT1
yyuJAP92B4UsWhqmW9D7FZuEBQ+QQk5s4x+mKZ6vKZnGgCLJrgEAhwR5pZvSYdzv
TCshilOUP+ust2m7d/A0X9GITTRg1QQ=
=CJou
-----END PGP SIGNATURE-----

--nextPart13002458.O9o76ZdvQC--



