Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44C6C5AE59
	for <batman-adv@archiver.kernel.org>; Sat, 31 May 2025 09:18:35 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5189784A5A
	for <batman-adv@archiver.kernel.org>; Sat, 31 May 2025 11:18:34 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1748683114;
 b=l2OzAuN2zvwjf4Yd3fR787UP202CY/XyfzFFTDBhv8Zb8pEeIKx+z5QeTUAFbcwFNCsHz
 FBDhxn5bkeTytZUKx3RwW5CVv5V7rSe1s6QsWcnRt7OnoBV3cS1sQP6nqHa6y9NIUeYLuul
 7mXYOc3Y2tT9j1zynSJwdKKGnJr1RXc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1748683114; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=rQNzauAFKXYmmu3TktHsj7RSHhKaZTHxe8GsYvpuUP4=;
 b=i27eUmbwuyo+2kwnLLAFWPBuf6mF5y1XvnPIcopSQMJCEIy9BaRqJOAjh8eRldSnh+MWX
 JL+y/DW6/u3Chz2PQmcUPb1MiTkrWjBCF8kLyerRtnBXmWclqjZfoU4XCR/noE4clxEjR1h
 e7/jzO8YywbhkI9j0HZ0FrPimaLpxJE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id ED4068478B
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 31 May 2025 11:18:23 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1748683104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=rQNzauAFKXYmmu3TktHsj7RSHhKaZTHxe8GsYvpuUP4=;
	b=usgdU6Yuegp21V3aBmCLU4CF9p6f6bk7RWQOujznCdH7IQDEmKzJsOV8Hrl6oXkaLd48XE
	bw1fw5SpkBRF8YzvV+n9kzaaTqTkX2Gi06IHE7DXAE6kzlw41Hq1N+mj0MUi2ALOcdU1qM
	qRIIQYwJps3fNHxa5pEsG//FF3Afqbc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="a/98SsFD";
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1748683104; a=rsa-sha256;
	cv=none;
	b=ImiM0u2DaSDc/arhyCp06s+KfUIIlAz2qmpRjXFAA7NLKsQSwCSOLpyYOfUDHXWCm0BDkI
	cKAxrPCJ6SQpYIA3DFNKvZHTleCKaGGteRFI7QWU8LIpwzV+WXKsM/V5pS2mX8J+4g1u85
	nXu0MaKzaXHmLmsSElbK40V7V6i9cS0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1748683102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rQNzauAFKXYmmu3TktHsj7RSHhKaZTHxe8GsYvpuUP4=;
	b=a/98SsFD5kXArAHzvHH8VpBQbRoH+MSrN4n6w4o6J67jYoailA6AHGxLcCKYxou7iDgZ2O
	0TzCaG0awMXwf2X/17bBycrRHvcvjhTTnaNSufzqQIU19ro+mAK8ynzwtGzrwipXuJLIyv
	yYiDma7+42C8gKY4zuQoEyfQixTLibk=
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
 Re: [PATCH batadv 3/5] batman-adv: remove BATADV_IF_NOT_IN_USE hardif state
Date: Sat, 31 May 2025 11:18:19 +0200
Message-ID: <3730915.usQuhbGJ8B@sven-desktop>
In-Reply-To: 
 <18929b62aafd4ce02940bea02b7a2bf6c5661089.1747687504.git.mschiffer@universe-factory.net>
References: 
 <0b26554afea5203820faef1dfb498af7533a9b5d.1747687504.git.mschiffer@universe-factory.net>
 <18929b62aafd4ce02940bea02b7a2bf6c5661089.1747687504.git.mschiffer@universe-factory.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5256341.QJadu78ljV";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: 7GKFKT6A7YUS7M3OY6BXGSQMZQINX3DO
X-Message-ID-Hash: 7GKFKT6A7YUS7M3OY6BXGSQMZQINX3DO
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/7GKFKT6A7YUS7M3OY6BXGSQMZQINX3DO/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart5256341.QJadu78ljV
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 31 May 2025 11:18:19 +0200
Message-ID: <3730915.usQuhbGJ8B@sven-desktop>
MIME-Version: 1.0

On Monday, 19 May 2025 22:46:30 CEST Matthias Schiffer wrote:
> With hardifs only existing while an interface is part of a mesh, the
> BATADV_IF_NOT_IN_USE state has become redundant.
> 
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> ---
>  net/batman-adv/bat_iv_ogm.c     | 3 +--
>  net/batman-adv/bat_v_elp.c      | 3 +--
>  net/batman-adv/hard-interface.c | 9 ---------
>  net/batman-adv/hard-interface.h | 6 ------
>  net/batman-adv/originator.c     | 4 ----
>  5 files changed, 2 insertions(+), 23 deletions(-)

Acked-by: Sven Eckelmann <sven@narfation.org>

Thanks,
	Sven
--nextPart5256341.QJadu78ljV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaDrJWwAKCRBND3cr0xT1
y04gAPwMoJas4EzdQIDr04VKE1UCLzkUwpr53WaxvHRdT5BJDQD/fgj+8WPsYSSM
FX7YY8MrPBQD/KKyq+M4ZdC2rfVpkws=
=odll
-----END PGP SIGNATURE-----

--nextPart5256341.QJadu78ljV--



