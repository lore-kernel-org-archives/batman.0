Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20EE0C43458
	for <batman-adv@archiver.kernel.org>; Sun,  5 Jul 2026 21:56:24 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 859E18456A
	for <batman-adv@archiver.kernel.org>; Sun, 05 Jul 2026 23:56:22 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783288582;
 b=l+FSsy8quoQZomjmIEqfzAHSM/PDqGVrEpAo+M2mK3jwfDii8z72JQzLP6Pb23KgULoV6
 6p2pISsvhX164oL09nQjHHlJwA5rRq/8+sFlgdjKq2RNLAcLYZU92B0wu3SHqFeyu6GgSqW
 haQCk3JNgPyFmwK9Nxxw4fZXaFHzTXE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783288582; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=RV2Nvnn+HCQh7rj3xTNyt9daeZEAAD876kxQOa969gg=;
 b=iSCPO26LGXQ4zETP7C51822DwEoy4zIHfwlZyYcyCSszOCw7mAKYwcEk982ihyplDKL7e
 iclirRCpqykVBcIVB3tEoe2QyhY0isjrolKHXM733l6yoEwwMrfV0zaNCIiTIthYBi3k1Mq
 FvFv3eKoWSzUWLAHap2jRb07lnsbIrQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 802AE8146C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 05 Jul 2026 23:55:48 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783288558;
	b=JI+tIXXZH0Om/VDC9ZNMXwZnH2UyIAn/eLy+Rdo183FZSA3de9l3jy6uef3UkxQ8jQfcDs
	ihhM7QBIyjUgGkYIuB3ymoD7CrubibfAkGf2HQFT8hdvLTVqBczw7fI5qLU0WrFHYx7ABD
	dPtWg+r9Q8FfA100Ktc2mT2LDDQl+Vs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783288558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=RV2Nvnn+HCQh7rj3xTNyt9daeZEAAD876kxQOa969gg=;
	b=0byoYzpqRi5B8a+6eGERyze4ur6mplKZro5OVgH699cgifNv0VQjb57dQsVLxXDprW9vZn
	tF+PkR09zm/RYKvHepFOmOGF5cj/bxA4xrLgYe7EMHW1OEtI9nm/pMA6Pp7+v/CpCEaIUW
	8Ayg70biDIMqT+bJd6Dw8O5isMHiviU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="sC0W7/hf";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 285111FEDD
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 05 Jul 2026 21:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783288547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RV2Nvnn+HCQh7rj3xTNyt9daeZEAAD876kxQOa969gg=;
	b=sC0W7/hfbEKAj1AkR9x5U39fn/L/8pVR+XAh1SwXAMI1y/kYeQNWQQuWnd2HgCm+uzz6C2
	LdbFN2WsUY61AgMYjp+Gk17ezi1jGeXqoZiMrUceYf/DhjlM72Q71J7SQOqg7SmfB/JMkV
	dfbTaLttD8R+pyd2PMcPVsWCW8aHfCo=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH batadv] batman-adv: bla: avoid CRC corruption due to
 parallel
 claim add
Date: Sun, 05 Jul 2026 23:55:44 +0200
Message-ID: <2915118.mvXUDI8C0e@sven-desktop>
In-Reply-To: 
 <20260705-bla-parallel-add-crc-corruption-v1-1-9082f0b2e59d@narfation.org>
References: 
 <20260705-bla-parallel-add-crc-corruption-v1-1-9082f0b2e59d@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart13002382.O9o76ZdvQC";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: ME3CBE6DJDPLTPQUZLES73637D54QTUI
X-Message-ID-Hash: ME3CBE6DJDPLTPQUZLES73637D54QTUI
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ME3CBE6DJDPLTPQUZLES73637D54QTUI/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart13002382.O9o76ZdvQC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Date: Sun, 05 Jul 2026 23:55:44 +0200
Message-ID: <2915118.mvXUDI8C0e@sven-desktop>
MIME-Version: 1.0

On Sunday, 5 July 2026 23:37:24 CEST Sven Eckelmann wrote:
> -               WRITE_ONCE(claim->lasttime, jiffies);

This was lost while moving the code. Will re-add it tomorrow to v2 of the 
patch.

Regards,
	Sven
--nextPart13002382.O9o76ZdvQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCakrS4AAKCRBND3cr0xT1
yyk2AP9NaVHgOQ0uCTCPZSOA3NX4NiRDFas+dpK/HH15ok5m5wEAwnFEugW+qjvM
PutpJMbLo/mODtRfcIqj+h6O8tfRzQI=
=iMMU
-----END PGP SIGNATURE-----

--nextPart13002382.O9o76ZdvQC--



