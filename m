Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D78B3C5320E
	for <batman@archiver.kernel.org>; Sun, 25 Aug 2024 16:24:33 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id F19C783D46
	for <batman@archiver.kernel.org>; Sun, 25 Aug 2024 18:24:30 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1724603070;
 b=G4bhRjz+I0SI37WqFZXGrWHqeQ8lObAFLjrDA4spGGbTltU93uADGra4qbjHyhoHzpyLq
 DvacnPAzzo6NpdVh+WWIA5b8kV54QYeXieVYHMNKVPAdWK4c0i/IqMvg3xr+Lo0LY6O21gj
 rUvjJDfYJPE5uLupnh9PBse2MWhZ1IA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1724603070; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=O/0CVHEKDJQyYWXwIbOQUlthvfXsND9N1ahK4smTqQ0=;
 b=y2Hjj0wYMrcHXmO1gHHbafFQAfEAt3jMwL0mYX9u4kJRtPorWNaJo0efTFLYHEFeXxueQ
 m5XQVJqgQRxAKiBWwM7sCJltnl9TZpF+WTZeWXgMxZ4JxH5XBhUWD+5zLHtOPnKwlG1NDw5
 t4PmIHyIbZ2YCn18+90G+FXmbB4kchs=
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
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 05C9480EAD
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 25 Aug 2024 18:24:06 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1724603047; a=rsa-sha256;
	cv=none;
	b=BWgsJ4kJxHLjRuh6DpIbfJaiS8Z2yXVqWm78rzPEIHs07N4Y1MEzzKB6ugZ6emZdoU//eF
	BOwTUWKYF11kQGLnRU2RWKJbW8RKfDPVxsqELTsFWBzsFxTIV/u//aoj3oQohrrmQVrLX4
	Co1c+OgEXgN+5AyUThIqaHkfk1b0AlA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=U5tvvkGl;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1724603047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=O/0CVHEKDJQyYWXwIbOQUlthvfXsND9N1ahK4smTqQ0=;
	b=d3TJe+mZ0BiQQRja8F55x1H3VSwuE7jNmD/WH4KhjupJFz26uyzcSwb0p6bmfvy6WH1Nxs
	carQjF0lP5BOJPaZgNR/5AlmMflEs7Ga2ltt9jOBCoB/t+BwX9IV/zP9jRpHAJSwJ07tXz
	/8FGOq59qSpjFPQA51CR/ZDnfSqNYp4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1724603042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O/0CVHEKDJQyYWXwIbOQUlthvfXsND9N1ahK4smTqQ0=;
	b=U5tvvkGlfI6OBAY8Wz4LUP+Z8uR5hNZyzLXiS7vFNvvx31EUjMDofXUubr8axmBJBtZFPT
	wl1Ehve6XMHlC7A48DB2zyufLuREtd2O5e5zM5uV/yFCDtkciQhXXyKyMAjJZujAFSFl0m
	YZv/gixXtw5t8M5TCyFGIOudVjwA33A=
From: Sven Eckelmann <sven@narfation.org>
To: mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, Xingyu Li <xli399@ucr.edu>
Subject: Re: BUG: general protection fault in batadv_bla_del_backbone_claims
Date: Sun, 25 Aug 2024 18:23:54 +0200
Message-ID: <13617673.uLZWGnKmhe@bentobox>
In-Reply-To: 
 <CALAgD-7C3t=vRTvpnVvsZ_1YhgiiynDaX_ud0O6pxSBn3suADQ@mail.gmail.com>
References: 
 <CALAgD-7C3t=vRTvpnVvsZ_1YhgiiynDaX_ud0O6pxSBn3suADQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2986161.e9J7NaK4W3";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: FHQK6546MQ44TIT2Q63ZAAHTOTZCFV4A
X-Message-ID-Hash: FHQK6546MQ44TIT2Q63ZAAHTOTZCFV4A
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FHQK6546MQ44TIT2Q63ZAAHTOTZCFV4A/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart2986161.e9J7NaK4W3
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 25 Aug 2024 18:23:54 +0200
Message-ID: <13617673.uLZWGnKmhe@bentobox>
MIME-Version: 1.0

On Sunday, 25 August 2024 06:14:48 CEST Xingyu Li wrote:
> In line 307 of net/batman-adv/bridge_loop_avoidance, when executing
> "hash = backbone_gw->bat_priv->bla.claim_hash;", it does not check if
> "backbone_gw->bat_priv==NULL".

Because it cannot be NULL unless something really, really, really bad 
happened. bat_priv will only be set when the gateway gets created using 
batadv_bla_get_backbone_gw(). It never gets unset during the lifetime on the 
backbone gateway.

Maybe Simon has more to say about that.

On Sunday, 25 August 2024 06:14:48 CEST Xingyu Li wrote:
> RIP: 0010:batadv_bla_del_backbone_claims+0x4e/0x360

Which line would that be in your build?

On Sunday, 25 August 2024 06:14:48 CEST Xingyu Li wrote:
> Syzkaller reproducer:

At the moment, I am unable to reproduce this crash with the provided 
reproducer.

Can you reproduce it with it? If you can, did you try to perform a bisect 
using the reproducer?

Kind regards,
	Sven
--nextPart2986161.e9J7NaK4W3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZstamgAKCRBND3cr0xT1
y9x3AQCI8h/Dcc3iVqqa0XiVgpP7ecJxHatYGydBR1RH46HCcwEA997cKeW4kX8v
myVNLA90kDo9mmb3MHmOmn0BjgJhrQM=
=Z8g1
-----END PGP SIGNATURE-----

--nextPart2986161.e9J7NaK4W3--



