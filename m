Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E5BAC369A1
	for <batman@archiver.kernel.org>; Wed,  9 Apr 2025 08:11:13 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A03F383DF8
	for <batman@archiver.kernel.org>; Wed,  9 Apr 2025 10:11:11 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1744186271;
 b=jzAKbmBcIOU2oX//WQXpU58hyvVOxEf8rqGU91d0jtbg9FAMh0Amww3Sr8gL6tBeeMC+9
 PdeOWg+3vNdUEcAYE9s2h1iVaM3CSlOrR9hS91PB3PYnapifLbCjRQQ+JsfnZp1QUejoTSe
 G6fYEMS/qWpmt2BdjCWgj7v4RVycqvo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1744186271; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=PflrDb8OhffdMQCbjwbS7Ify9Hy35vaMmsHmfVvb/DY=;
 b=TBZgHGwWJm81f0JuiZj23/ParLrWE9Q17PQvWXp7RtJyEcZ80hWRcRWgD3wnjZJy9yTUY
 sR1TiNUXu0h3iVXMVUmuCwMLmb++O9EyzpNX9I/kcYI+7dsCSDns4gU6Lzgdy7xP8So+td+
 Y31DxHWjJSYz4hA6xeWEedWEfR/Ha9w=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 8547E806BC
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed,  9 Apr 2025 10:10:45 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1744186255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=PflrDb8OhffdMQCbjwbS7Ify9Hy35vaMmsHmfVvb/DY=;
	b=k5HmExppJLn+ghkRcWNLnRdQ6fy0WpRpo4rPPGfZfGTCwT1I+CDCTZhMCkSZeAiopiYHrl
	KEIvr0PUTn+VGKG44NQrUNy0o71+hUUUKpPMzHMIUBRDDDoPbdu9g6Tpwa0T7F9aJKx5+r
	Gdq3gXvj0YugfJfQyk5XgeSggleyrsg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=f6+8cpJ9;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1744186255; a=rsa-sha256;
	cv=none;
	b=y94HCFblZBAHaB4V8q5tiCJgX+t7EIXscx2PcgSBAN5QNPwEl0nIt0Xo+rQhMaEIFUy7fp
	YB8OwzzZbXOgH1wPjEJVD8DRFIsHD8b6Jg2VjkqeMYi/2cw8DRmL+2EeWWbsgc4krKnChZ
	e87nGWu1cHRAys8JiLZQUDfae86/ZYg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1744186244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PflrDb8OhffdMQCbjwbS7Ify9Hy35vaMmsHmfVvb/DY=;
	b=f6+8cpJ9j2V2kU/c+O8lQqYmKofdK+9NIE1BBIG8bqrs/ssl7TTk9BxlHu8/yerX7yY4KG
	HIWQuPy5OqLNSV0mG8kXXN/iPh7ezl2Km2H8rCQRTSVTOl6q3o5U1wtRUF0T+AWddJhXID
	H+FeiNN7WUnE0EGMFYs6PwR2//NFf0o=
From: Sven Eckelmann <sven@narfation.org>
To: Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <antonio@mandelbit.com>,
 Matthias Schiffer <mschiffer@universe-factory.net>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Matthias Schiffer <mschiffer@universe-factory.net>
Subject: 
 Re: [PATCH net-next] net: batman-adv: constify and move broadcast addr
 definition
Date: Wed, 09 Apr 2025 10:10:39 +0200
Message-ID: <2789676.Lt9SDvczpP@ripper>
In-Reply-To: 
 <c5f3e04813ff92aca8dddc7e1966fe45fca63e56.1744127239.git.mschiffer@universe-factory.net>
References: 
 <c5f3e04813ff92aca8dddc7e1966fe45fca63e56.1744127239.git.mschiffer@universe-factory.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4558621.ejJDZkT8p0";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: OL6S3SEDOMRO4CIBKDOI6PDIVMZQCGBS
X-Message-ID-Hash: OL6S3SEDOMRO4CIBKDOI6PDIVMZQCGBS
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/OL6S3SEDOMRO4CIBKDOI6PDIVMZQCGBS/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart4558621.ejJDZkT8p0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 09 Apr 2025 10:10:39 +0200
Message-ID: <2789676.Lt9SDvczpP@ripper>
MIME-Version: 1.0

On Tuesday, 8 April 2025 17:53:36 CEST Matthias Schiffer wrote:
> +       const u8 broadcast_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};

Should most likely be "static const u8 ..."

(checkpatch STATIC_CONST_CHAR_ARRAY)

Kind regards,
	Sven
--nextPart4558621.ejJDZkT8p0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZ/YrfwAKCRBND3cr0xT1
y1fnAQCy1/kEIFf15jWwkR3S+Qdew6LxzAvY8o6jP+JPRDwUYQEAue+zH2A71OaA
UYqB9V4j1Sg7iuRxg9Ezzcdl47cB4A0=
=b7CK
-----END PGP SIGNATURE-----

--nextPart4558621.ejJDZkT8p0--



