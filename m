Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF40D44141
	for <batman-adv@archiver.kernel.org>; Tue, 19 Nov 2024 11:04:47 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D527683F8B
	for <batman-adv@archiver.kernel.org>; Tue, 19 Nov 2024 12:04:45 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1732014285;
 b=QypU9yBXIKtqZWBbZBZ4d4KuNBFwBHQfsISNcqyBEq1eDjTqFs+IcXS8vsRiR8xYRegdS
 5ESFcx1TnBe9cv0nFnjrhKFqajmS8PHAFvzI1VZNCLF9vQG4i+gPjyF0KeLSuyfjDitEfwr
 aTIt1K5sfEgPIDaBcGxXwYTPIPrWqyk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1732014285; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=zyWzSoguyyHX+PkxezNTyxMTsZ4FkT9hLBnX7bvtXg4=;
 b=VTzGJoDZj4Qg3emwOtifWsczOBLpXebsdz80KyOeaMTMXxlcuKbDpxKGxwxR3BdmJTTeK
 3wWOWzSIgPI6A5zipOXcV0BXQzUdC+CoSm/8NkfVYGRvicdhOlT5Ntt9E3IykkoxrsLBi5D
 rpHJmlNBV3KChxXbrGJlf/VVP4XfYX8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id E012980EE9
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 19 Nov 2024 12:04:33 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1732014274; a=rsa-sha256;
	cv=none;
	b=EVJbIpsiFpbToV709P6WbVCHKGVlwOgoZuG+rZl4vUaxfocM46Zw0sUftkwYHMp4hBrE2K
	zNCxC8VvbAbZc3IF5z22+COJj8dx478Ds690k2YD1kwzd0OsWHnSBmSr6BixWnYZ//GAk0
	ggUCzFw3ojEWDi08W2g6SBmDGaIPvfw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=leRMrQ3o;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1732014274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=zyWzSoguyyHX+PkxezNTyxMTsZ4FkT9hLBnX7bvtXg4=;
	b=bpHlGFcpHV7oTwJ6ZhDnwQph1dC264ytI/RvagXnvKwSsvb7lH9LfQeu4KZf02NiTFJf7a
	Rm9Ho5t8sYonCJznuDO5Q03ME8P6lmbgKYFKOKAr8978jMVlEtsQ0BnCK8DIaexsiIh3ye
	lpebOaPnTnjmSIj1n6qnTsU49fJX6jc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1732014273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zyWzSoguyyHX+PkxezNTyxMTsZ4FkT9hLBnX7bvtXg4=;
	b=leRMrQ3oFOiSSymcoerE7I/xDWF0n6wJeJdR/oymmOZk/DwbWemivx5yE8/6Fit71z9kuz
	7yDUnDZXe20hzwmA2KDyRiV7LoTjps74EBWB5UKsCrDF9mlrMxeTQx4UhFodPthJUbYtxW
	wBBLEe0SIvJa+t22/b56xlCLhOFRyU8=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Mike Evans <mikee@saxicola.co.uk>
Subject: Re: Please unsubscribe me from the mailing list. thank you.
Date: Tue, 19 Nov 2024 12:04:30 +0100
Message-ID: <3328029.44csPzL39Z@ripper>
In-Reply-To: <20241119105654.431c38ed@saxicola.saxicola.co.uk>
References: <20241119105654.431c38ed@saxicola.saxicola.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8452476.T7Z3S40VBb";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: RM5MRAEQESLUXQQQXBITWL6XPTT2CVUL
X-Message-ID-Hash: RM5MRAEQESLUXQQQXBITWL6XPTT2CVUL
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RM5MRAEQESLUXQQQXBITWL6XPTT2CVUL/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart8452476.T7Z3S40VBb
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Mike Evans <mikee@saxicola.co.uk>
Subject: Re: Please unsubscribe me from the mailing list. thank you.
Date: Tue, 19 Nov 2024 12:04:30 +0100
Message-ID: <3328029.44csPzL39Z@ripper>
In-Reply-To: <20241119105654.431c38ed@saxicola.saxicola.co.uk>
References: <20241119105654.431c38ed@saxicola.saxicola.co.uk>
MIME-Version: 1.0

On Tuesday, 19 November 2024 11:56:54 CET Mike Evans wrote:
> Please unsubscribe me from the mailing list. thank you.

https://lists.open-mesh.org/mailman3/postorius/lists/b.a.t.m.a.n.lists.open-mesh.org/

Or send a mail to the address shown in the address in the "List-Unsubscribe" 
header:

     b.a.t.m.a.n-leave@lists.open-mesh.org

Kind regards,
	Sven
--nextPart8452476.T7Z3S40VBb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZzxwvgAKCRBND3cr0xT1
y+whAQCSy/eD1zM51/c8vvoG+w2UrwAg82Y3cbVvEZrHbchFsgD/aoZZaBaZkajv
nL2BBpOxIkXuv43kwrNQQFtKSbmGaQE=
=oFEO
-----END PGP SIGNATURE-----

--nextPart8452476.T7Z3S40VBb--



