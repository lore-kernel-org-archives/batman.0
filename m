Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA97606A323
	for <batman@archiver.kernel.org>; Thu, 12 Nov 2026 10:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=V2zvC8CS
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 003A9803EF
	for <batman@archiver.kernel.org>; Thu, 12 Nov 2026 11:58:46 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1794481125;
 b=SgsePisRPIwgaT7O6br6n18m+0q2nqUbqNJu2pEHoXeZOW3BW+DShQgMrcYshVXWvnJsR
 vvDgo1pEYoQnHgwA918RI1tNbjb2fdThoTkXvGAEnzdEtFUNn6H3gObxLXBR+dBHYSwc1Xa
 zz/yxqOsCqAmRJNbxjT4Gfv6KOovDM8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1794481125; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ycpTw26ozG7nGyxNHYwJnlgidjx45yFTso1Q38E6eC8=;
 b=XLJyTZ9733qFw8oa+L/EJ4hoUZk4DSUWzDuvrBjLohhwUPhfbcHA97iAkfeCOx4+R14OM
 h8r3G1hXHI8vthEQgpEhQK3tnmh44/TJMQRWRLih5LA2c8Ic0wlygtU4OeMN/LM3nDdKXR9
 qmIhNNUEpaJsv/XqQwW36xZ9+F6Ydwo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id C9CD384A14
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 12 Nov 2026 11:57:58 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1794481088;
	b=3OXCppK+G08RW/2iYAvU2UYfeS9Aj0IbtsLeNlJ8RJcOgbA2frTtkG1MrE16nJBqkLtR/f
	SY2RhcbefJB3FQndzucirje5KDyln0GL3wDPwZAAnCDu2RwuLpvB85oaFn6HH4S07wKOWQ
	t9MOIPqS2aXzzx/rKnvmGuOsHPNGf0Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1794481088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=ycpTw26ozG7nGyxNHYwJnlgidjx45yFTso1Q38E6eC8=;
	b=maEskLpU6kmySV+pWs0snO7i7rjwXwS4TrWld52n9NXXo4uuOXcjVPMZcl7OVeIIg7zodt
	JF8BhPvjbaHj3shjeck51KqEnaPGcKFa/9gcZni5KJ0i0qRPLsOgeFFBQTgP5rA3UdjH31
	H5+pI6TY0T6U+Z496FQLcoRkfYojDq8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=V2zvC8CS;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 7DB7A1FEF7;
	Thu, 12 Nov 2026 10:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794481077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ycpTw26ozG7nGyxNHYwJnlgidjx45yFTso1Q38E6eC8=;
	b=V2zvC8CS10XdJfMs1wizSVU/bVMVxl4+Y4HkAcFfF6Qy+Ib+WuFKzV6cVukCowGYJp/WjH
	4AMEHM5ikYrdPyEEXPGwsKlQJPi2+fQKN0a28+017xhQjmsNKhZhouBbnKdM5Z9anJPgSU
	oP6Wg2FEEDh0dY/kEQ+4Fsx2nkrnP8M=
From: Sven Eckelmann <sven@narfation.org>
To: sashiko-reviews@lists.linux.dev, netdev@vger.kernel.org
Cc: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH net-next 08/15] batman-adv: tt: annotate last_seen with
 READ/WRITE_ONCE
Date: Thu, 12 Nov 2026 11:57:55 +0100
Message-ID: <2765052.7s5MMGUR32@ripper>
In-Reply-To: <sashiko-outbox-210958@kernel.org>
References: <20261111102729.2096241-1-sw@simonwunderlich.de>
 <20261111102729.2096241-9-sw@simonwunderlich.de>
 <sashiko-outbox-210958@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3402950.aV6nBDHxoP";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: 2OOVB6ECPZYVU4BTIZAUPJY6VOVW2MXO
X-Message-ID-Hash: 2OOVB6ECPZYVU4BTIZAUPJY6VOVW2MXO
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/2OOVB6ECPZYVU4BTIZAUPJY6VOVW2MXO/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--nextPart3402950.aV6nBDHxoP
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: sashiko-reviews@lists.linux.dev, netdev@vger.kernel.org
Cc: b.a.t.m.a.n@lists.open-mesh.org
Date: Thu, 12 Nov 2026 11:57:55 +0100
Message-ID: <2765052.7s5MMGUR32@ripper>
In-Reply-To: <sashiko-outbox-210958@kernel.org>
MIME-Version: 1.0

On Thursday, 12 November 2026 11:34:43 CET sashiko-bot@kernel.org wrote:
[...]
> [Severity: High]
> This problem wasn't introduced by this patch, but can dropping
> common->flags_lock in batadv_tt_local_add_existing() before queueing the
> ADD event [1] let a delayed ADD cancel a concurrent DEL event?
> 
> batadv_tt_local_add_existing() clears BATADV_TT_CLIENT_PENDING under
> common->flags_lock, and its caller batadv_tt_local_add() only queues the
> corresponding ADD event via batadv_tt_local_event() after the lock has
> been released:

This is handled by a pending patchset [1] which couldn't be submitted here 
because were have so many other things to fix in the TT code and already fill 
our submission up to the max of 15 patchset since a while.

And it is completely irrelevant for the submitted patchset.

Regards,
	Sven

[1] https://git.open-mesh.org/pub/ecsv/batman-adv.git/log/?h=b4/tt-avoid-unhashed-event

--nextPart3402950.aV6nBDHxoP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCavWbswAKCRBND3cr0xT1
y/YpAP9pCjha3Y6xeOY65LTDoFqSdDfgud9m+uI8fWcRtekfsQEAsqHTFRxclv59
2bqkJCF1r3maEqFRRG6k5F/gwf64VAo=
=b0cZ
-----END PGP SIGNATURE-----

--nextPart3402950.aV6nBDHxoP--



