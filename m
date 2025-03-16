Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D9D2C282DE
	for <batman-adv@archiver.kernel.org>; Sun, 16 Mar 2025 12:18:01 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9F446842C6
	for <batman-adv@archiver.kernel.org>; Sun, 16 Mar 2025 13:17:59 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1742127479;
 b=nI/AqYziMgitnTVdqE+QvaxCplI5+kR6p9QimMJblwROxSIEHranA89URNua3WkKaUU0a
 CQGPp7Gn3KeNy9ckbpR3CbEur065IeyDV0PNowL+RLvYZ+PxI8prqyqSqNbtQohxKlBha1z
 z+UCDjsIkjSFFGLvjViBIkpMz7b8ifU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1742127479; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=haMd1TY8UcQEvT842fyNLu7C7F/Lh2jnySiu6uy/KHE=;
 b=Qaf83KmRpO1ZadfwS3Om6Hi5CZPllFQlXJqKT0DJeXVToqgDhqh0OrIyadSRolnftVVRh
 3KPOP+spXFg4w03ZYmJbfh7qUjRCJU3ALDbMB01bI8C2OhKqMS9zD8R1sQROhgVufowjeAP
 78r9cFr9GbErS+ZnBMbVqw+lL9nleLo=
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
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 5FA3A81F40
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 16 Mar 2025 13:17:50 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1742127470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=haMd1TY8UcQEvT842fyNLu7C7F/Lh2jnySiu6uy/KHE=;
	b=e+nZteQQsVAEYooEHsWxL4mWHd9RsZFC/RvM49rYgQddvUCJN5uRvfsotAjfyE3kaksXFO
	ApHYjlRS3tnyXle3h4g11nxRCygJvK780evdqbXt/KH67eAxeTQVzc39gMLgNWSKxDuLmP
	zaSuR2n/DyUHR6M3D+butH640QQX8wc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=AQxO0nbF;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1742127470; a=rsa-sha256;
	cv=none;
	b=NEFRrqUUfpnTo3ur0SueoCX2hvJXBtzJdlW+AcfTW6GupYNxzjs2W817LlBQpeaUHmDHsj
	osLPAQ87t2GgHYCsbISGz169FSSBuUkiNi57UFUusHrqHkCPLKvCGbNj2ycZLuKCBxb2P+
	THkKSxb67K8L2bEsbBdZvvfjZHCh8kg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1742127469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=haMd1TY8UcQEvT842fyNLu7C7F/Lh2jnySiu6uy/KHE=;
	b=AQxO0nbFA+r46wWgCIq6JcXE0skDM2J17AEqJTtFzgZR4/HkVVeXcf9TucKK0qGxgPNm8R
	zH8Syd5cmFlJKcW3m2bcjLKL016i1+wD4U7RQu/WW4kfHvhvvtLdJ4g4gi/Shs0GSPgDGq
	oL4m7phM4IRbwDA5paY7mFNr+jdQZGU=
From: Sven Eckelmann <sven@narfation.org>
To: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Jingwei LI <marscatcn@live.com>
Subject: 
 Re: Limited Connectivity in Mixed Wired & Wireless Backhaul Deployment
Date: Sun, 16 Mar 2025 13:17:41 +0100
Message-ID: <5097328.31r3eYUQgx@sven-l14>
In-Reply-To: 
 <OS3PR01MB576553C5DACFE878AF2C6878D5DC2@OS3PR01MB5765.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB576553C5DACFE878AF2C6878D5DC2@OS3PR01MB5765.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4738876.LvFx2qVVIh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: BWZFMDZGR6I4RJSYC5XGI4FDFOMHKCVA
X-Message-ID-Hash: BWZFMDZGR6I4RJSYC5XGI4FDFOMHKCVA
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BWZFMDZGR6I4RJSYC5XGI4FDFOMHKCVA/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart4738876.LvFx2qVVIh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Cc: Jingwei LI <marscatcn@live.com>
Date: Sun, 16 Mar 2025 13:17:41 +0100
Message-ID: <5097328.31r3eYUQgx@sven-l14>
MIME-Version: 1.0

On Sunday, 16 March 2025 11:07:17 GMT+1 Jingwei LI wrote:
> 9a:15:64:00:0b:f8    0.172s (        1.0) [      rax0]

Either use B.A.T.M.A.N. IV with its loss metric or fix the throughput
(incorrectly set to 1.0 MBit/s in most of your links) when you want to use 
B.A.T.M.A.N. V.

Kind regards,
	Sven
--nextPart4738876.LvFx2qVVIh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZ9bBZQAKCRBND3cr0xT1
yxHhAQCrlFLQpKnl5tB5WoeETvd6QwgSqxwCq6BPCoHX+sF+cgD9Fg8hdmKtdZpg
7DtAQfMAVZfROzmWm0LkuSxtqUeB2QA=
=fEAE
-----END PGP SIGNATURE-----

--nextPart4738876.LvFx2qVVIh--



