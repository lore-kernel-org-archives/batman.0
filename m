Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D4B606A327
	for <batman@archiver.kernel.org>; Mon, 23 Nov 2026 18:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=VYLYrLdV
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9C3A184745
	for <batman@archiver.kernel.org>; Mon, 23 Nov 2026 19:13:50 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795457630;
 b=1miMsCjP+LvgbBhTf+xp3IP23ijkmh8yTu4fEeL/mBNNtUlJNZlLfNLHgNlsQKLndIcPI
 GSQyV0IYTzr8/OIJBqhlJbGJ9An8Ck34HZ7IpbEhD3OoEChqauF4lmhuUC8tHHjvs9Vpebj
 bzRgU4LtZt1IKe4zWsNOdHVEDXfF4e0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795457630; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=YLMzs3icaI/TF/cOgSaIuciSiXWXB4AeI/+AwQ2yC+s=;
 b=WpngnWuRi8GG6Lt9jEhYlNI8knOgjqwyJGV0PU73ncb/galwoteWpFCMb7iE+dDs3z3CP
 46WGHXpaJtGwmZUGXiAB+6FKcqOV4xTms89mcC5by/MRFzDtGeyoi+ZioMrzHLmwPT77x3l
 CnFdxJALyKd5KwzOl4DoIX0amU7R8C4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id A4CF582092
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 23 Nov 2026 19:13:42 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795457622;
	b=vf+zuXwgx6bbwcsDBVD8l9Nvnx/tgaIydzj7T04VAnL2uu44tB9EJkA8QF+rIRQcyBBv3N
	I4pv0gQ+BrMSUf//sxxTfCqTzgkI0YoLID+CeeeuJw1DtaTL6e95uUi6FWzfOyYJTyHOxf
	/eyBRcD3S7v4Syua9SkvSOH8g8I9I24=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795457622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=YLMzs3icaI/TF/cOgSaIuciSiXWXB4AeI/+AwQ2yC+s=;
	b=zzCt59UD+CBrWauWDwBqI7FVOz680HqXBrLJzmKc+QZ06toY6EWHhgeSaI+dT6Eov2M5BV
	Q+Va0Pu0gD+g8O4jwbHgrC+IGJ1/5P+YlIF5QQgAbfAuT/zlM2SzgWbKMnRuK8adN70vYL
	AEL5f6V2gg5pYgeZZMh+x9BmWeZTrrE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=VYLYrLdV;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
Received: by dvalin.narfation.org (Postfix) id 221D52040A;
	Mon, 23 Nov 2026 18:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1795457621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YLMzs3icaI/TF/cOgSaIuciSiXWXB4AeI/+AwQ2yC+s=;
	b=VYLYrLdVifUrrtmmAPdqVOYBhjLtGJrsb9Hrt5w2pR3p9vV+El8z3TM8BoR5cOr+OklMZ7
	IWT7QRBSKbdoZwsnC/Tq8ad94C4WmmXxun+YaJKIG7dwxoHT8oea2xdNvPOJlz1TyQrP8L
	mD6wCkTiwvzYG9tTdJOmt6XrOBfUvOQ=
From: Sven Eckelmann <sven@narfation.org>
To: netdev-bot+sinfo@kernel.org
Cc: Simon Wunderlich <sw@simonwunderlich.de>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH net-next 01/15] batman-adv: document refcount of returned
 objects
Date: Mon, 23 Nov 2026 19:13:38 +0100
Message-ID: <3799504.aeNJFYEL58@ripper>
In-Reply-To: <179545458375.3294.10693460852466613013@kernel.org>
References: <20261123171827.3294525-1-sw@simonwunderlich.de>
 <20261123171827.3294525-2-sw@simonwunderlich.de>
 <179545458375.3294.10693460852466613013@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3806106.44csPzL39Z";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: RSHYLIT2SCPO5DYNI4XMPSJWRBLI7YT4
X-Message-ID-Hash: RSHYLIT2SCPO5DYNI4XMPSJWRBLI7YT4
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RSHYLIT2SCPO5DYNI4XMPSJWRBLI7YT4/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--nextPart3806106.44csPzL39Z
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev-bot+sinfo@kernel.org
Date: Mon, 23 Nov 2026 19:13:38 +0100
Message-ID: <3799504.aeNJFYEL58@ripper>
In-Reply-To: <179545458375.3294.10693460852466613013@kernel.org>
MIME-Version: 1.0

On Monday, 23 November 2026 18:23:03 CET netdev-bot+sinfo@kernel.org wrote:
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by LLM and not proven at runtime). If it was triggered
>    please include the symptoms, like the stack trace or kernel messages.

They are things found by an LLM and they were marked with "Closed"+
"Reported-by" tags. None of them are reproduced. The marked ones are about the 
logical consistency of the local translation table (ok, and bridge-loop-
avoidance in one patch) and the data reported to other nodes.

They are corner cases but definitely problems in the implementation. They are 
not meant for backporting to stable or to net because they are no known 
affected users. And it looks to me like affected users would have the problem 
solved by some extra full translation table syncs.

Regards,
	Sven
--nextPart3806106.44csPzL39Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCawSCUgAKCRBND3cr0xT1
y6REAQCsYugepYdtsUSDSZo3sJxEzu12QJVD1rVmDQoBtYHFBwD/XpSil1+5a+sa
jP6ctPMTOeKxWbtnUrlwa299k7SS1A8=
=7L95
-----END PGP SIGNATURE-----

--nextPart3806106.44csPzL39Z--



