Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B17C54FCD
	for <batman@archiver.kernel.org>; Sat,  1 Aug 2026 09:56:06 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 54E2D81161
	for <batman@archiver.kernel.org>; Sat, 01 Aug 2026 11:56:05 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785578165;
 b=F05hv+rzDIzjgTNZ0yPs4IOhRVhM9ojXEthP9vnIVorG2HMLNk+7fp9C4CCHeKkUmipDb
 /OLuimtnJA8POiySQOLBh9AOivj2egN0ZY2a6i21ZzUWpUmB9X61lWOJ0zHNyZWV+t/CAi2
 WRz1Ptn7omozCurTATXeFrEUfL/aclw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785578165; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=GMZ7u9TrJAkl++eWbVeHybzAtTqJM4wRotfi+f08UXo=;
 b=g6yHBjppzBHr52r1LG+OggZN/xxHAfhK1VU1MD4BPmKOrkYQA5CKgMfn4do5fq+5elLs7
 IGmBZ4fFgMzcpLb+/99Q8QaBB9h3vd0EJ+8kSUqK5psICaIhZqL5hRfqPV2ch9CP2wRWhTU
 Z6DwriIpIEvsQK3t1cv3PJ2IGEBSz6M=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id C3E0C84028
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 01 Aug 2026 11:55:46 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785578146;
	b=JgV1Vpgm14c/YWhS1F/yvnxenH7gcFCq7H4/ZJi69+p+e9rxpgLQCRTc+4DT8ImJDW9ul9
	a6GFNDzd91QI1Kea/yaTh8mwqnPVBAQV3XaCi4ZJ7xfEakYahSO/JIkN03ILVdd0ywjeXj
	3Rgixct4Y73AiALt0VsrlJ130ESH600=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785578146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=GMZ7u9TrJAkl++eWbVeHybzAtTqJM4wRotfi+f08UXo=;
	b=2JvHT4InIDVPjt15hoobGMWzPHzdooI15aXiL8aImf7pdQtbrL8c1tgQWgNoK2JwEqSseO
	SrWfgjxxnzpw0Vgr6WZy6gKCIWxWNSwvpyFsEqpRpQXNHQXTGsTLhboFzr0e0PlUYeVR5x
	XAwV6O6Y4DxIsem2bmQ+GqaTRIRjKio=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=KBTUPCY1;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 4D5E620F35;
	Sat, 01 Aug 2026 09:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785578142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GMZ7u9TrJAkl++eWbVeHybzAtTqJM4wRotfi+f08UXo=;
	b=KBTUPCY1u1kOHe+TV0XPo//PAtHzD2/8yOR97A0iZ6mkcXYAKleXWfHnKxjXI7XDh2X2sZ
	3esSVNdvqPs9+iy8Z7dkivYMzC4WFspw3sVBUktVE5/6KLjkuwVTQ2exmPHZhDpZekByRV
	qVsPIV5vMiYAafko/xDJn2pBB1U/cLE=
From: Sven Eckelmann <sven@narfation.org>
To: David Lee <david.lee@trailofbits.com>, Kyle Zeng <kylebot@openai.com>
Cc: Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
 b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] batman-adv: reject unrepresentable multicast TVLV offsets
Date: Sat, 01 Aug 2026 11:55:39 +0200
Message-ID: <1966817.atdPhlSkOF@sven-desktop>
In-Reply-To: <178551276852.62695.13954065440231922020.b4-review@b4>
References: <20260731135222.566367-1-david.lee@trailofbits.com>
 <178551276852.62695.13954065440231922020.b4-review@b4>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart48293242.fMDQidcC6G";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: VURAQXBJIHTTVKTLQR3BFA4KKZTAIVOP
X-Message-ID-Hash: VURAQXBJIHTTVKTLQR3BFA4KKZTAIVOP
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/VURAQXBJIHTTVKTLQR3BFA4KKZTAIVOP/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart48293242.fMDQidcC6G
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 01 Aug 2026 11:55:39 +0200
Message-ID: <1966817.atdPhlSkOF@sven-desktop>
In-Reply-To: <178551276852.62695.13954065440231922020.b4-review@b4>
MIME-Version: 1.0

On Friday, 31 July 2026 17:46:08 CEST Sven Eckelmann wrote:
> On Fri, 31 Jul 2026 13:52:22 +0000, David Lee <david.lee@trailofbits.com> wrote:
> > batman-adv: reject unrepresentable multicast TVLV offsets
> 
> Acked-by: Sven Eckelmann <sven@narfation.org>

I am hereby withdrawing this.

NACKed-by: Sven Eckelmann <sven@narfation.org>

This needs a different implementation and a clean patch submission. Summary:

1. weird text + newlines in the tags section which shouldn't be there

2. author didn't sign off the patch

3. weird unrelated Signed-off-by without any understandable connection to 
   patch

4. the checks should be in the API and not added in random places in callers 
   of the API (which makes it hard to understand why the check is there). The 
   users of the API should only handle the return values of the API functions. 
   See commit d45cf1e7d718 ("ipv6: reject malicious packets in 
   ipv6_gso_segment()")

Regards,
	Sven
--nextPart48293242.fMDQidcC6G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCam3CmwAKCRBND3cr0xT1
y2mgAQDi/oHdlfdCkY06CmxenfGT17EvCOmDReQEwv8Eoa1fowEAzrJdzx7R4ZZB
ZhJwKVbiHfzxT4cfFHnj4VqYsgjVKww=
=RJcS
-----END PGP SIGNATURE-----

--nextPart48293242.fMDQidcC6G--



