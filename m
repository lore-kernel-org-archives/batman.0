Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E4EEC5B549
	for <batman-adv@archiver.kernel.org>; Sun,  1 Jun 2025 13:37:14 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id BFE6784881
	for <batman-adv@archiver.kernel.org>; Sun,  1 Jun 2025 15:37:12 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1748785032;
 b=NQmKBwaf2qo9BJYVgqOBNAu7mNNdpZU0j+LwEZRiaEuZ17GLQw6mX7eDm/NjoB9UC6rTM
 sBQXruGpz7EgVfVleRM0eKdY2GiMMkJ+hxpL/Y/QDsRQfXlD5VMlYl6TQEn1hPtj9Sjp0Br
 SVV5L4XN2Er9okEjGE8D4w2+RlrxCyA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1748785032; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=6zILuC+fJQ0XHCp2HcwA6LIeh6l7/8sDjGhWTTsieFE=;
 b=ZoYfL7Pg1IOu0TzCrECKOflcDdbn1mNM9Jd+jazCXv0gewnysQiL7gFx0g323Mfwo/1/h
 WfCLmZ1RkwBlg7SL1wqB9yk0jYMBH1nBmVEF4yx0pMJRq2LfhF2pd+89KjL4QC4WUdbB7Q8
 Absl0CJItedWGueYb6vFItYGlynvNSs=
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
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 88EF983B40
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun,  1 Jun 2025 15:36:49 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1748785019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=6zILuC+fJQ0XHCp2HcwA6LIeh6l7/8sDjGhWTTsieFE=;
	b=JyE87hr0keaK4q5fxBf/Njb3zZ1vmPwtOsuSSc3D++/jTmaVXLZsTY9Q2PPufDLqnCJ/Kp
	ZIin34sjUlCvfC/NAacTtBiiYezMnb95pH/6Znf4Pt127bID6YEIE7L9xk1Z8++QEVFlyK
	jKqUf/2a7Dqr25REVi7EmDB+ZThOM9k=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=rLoCL4a+;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1748785019; a=rsa-sha256;
	cv=none;
	b=0dPg7sgCSzXgxVxklS1q0iGXIjZnToqjISukv2VruXHfMmboRbxZJmfnGJB3NzRl8oLZqT
	XbTdusIFu5Dg5+1UR/KoCg9qXIXTkiZ+Zvz/vD2W4LzzFcRika+L297cxwOEDIhJUW3j+6
	MQz3sFsPe0/tU32Gj1EEDPwvFQSxFbA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1748785008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6zILuC+fJQ0XHCp2HcwA6LIeh6l7/8sDjGhWTTsieFE=;
	b=rLoCL4a+u7rcjzVNw7BOCDOPvSFqyKolol1d+Mr+uoLOS29EN8Toga/dII26130TqLW4my
	ZifdsG6Yn4ghya8OZFqIegcRPSCTqDslap5P/cNs/Pl//ZCOv/C+0+CKjtb7C0xeBE4Sxa
	9VQRx75GMoUqLn4XbMSfBk1Jo0Wa2gI=
From: Sven Eckelmann <sven@narfation.org>
To: Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <antonio@mandelbit.com>,
 Matthias Schiffer <mschiffer@universe-factory.net>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH batadv 4/5] batman-adv: remove global hardif list
Date: Sun, 01 Jun 2025 15:36:44 +0200
Message-ID: <2767731.Lt9SDvczpP@sven-l14>
In-Reply-To: <3742218.iIbC2pHGDl@sven-l14>
References: 
 <0b26554afea5203820faef1dfb498af7533a9b5d.1747687504.git.mschiffer@universe-factory.net>
 <bb85858d-b123-45ce-8fae-9658e13b822c@universe-factory.net>
 <3742218.iIbC2pHGDl@sven-l14>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4541340.ejJDZkT8p0";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: NHDKKAT2ONYRK6PMMM4EGCJS4VTS574O
X-Message-ID-Hash: NHDKKAT2ONYRK6PMMM4EGCJS4VTS574O
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/NHDKKAT2ONYRK6PMMM4EGCJS4VTS574O/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart4541340.ejJDZkT8p0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH batadv 4/5] batman-adv: remove global hardif list
Date: Sun, 01 Jun 2025 15:36:44 +0200
Message-ID: <2767731.Lt9SDvczpP@sven-l14>
In-Reply-To: <3742218.iIbC2pHGDl@sven-l14>
MIME-Version: 1.0

On Sunday, 1 June 2025 15:10:50 CEST Sven Eckelmann wrote:
> So, even getting the parent (see `ASSERT_RTNL` in 
> `netdev_master_upper_dev_get`) of the lower interface is a no-go at that 
> point.

I didn't want to say here that this specific operation is necessary here. Just 
wanted to point out that operating on these data structures might not always 
be possible at that point. This is why I tried to point out that it might be 
better to have something "good enough" using RCU which is managed outside this 
context (write-only protected using rtnl_lock).

The idea of having something specific to meshif that still manages to detect 
(beforehand) if there's a path to `batadv_interface_tx` - while `skb_iif` 
remains set to a specific interface along the way - sounds like an 
implementation nightmare to me.

Kind regards,
	Sven
--nextPart4541340.ejJDZkT8p0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaDxXbAAKCRBND3cr0xT1
y2B/AQCJ/7bJD+rjoCQmz2lOKcFzS3+eddnIoXgnTHyC5k6TaQD/c6W7fxCqe45U
ceQ+DuoPPWrCN6EyZMeEMSJ88E1M0AE=
=njVk
-----END PGP SIGNATURE-----

--nextPart4541340.ejJDZkT8p0--



