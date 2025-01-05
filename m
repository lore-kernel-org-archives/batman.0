Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE21E77197
	for <batman@archiver.kernel.org>; Sun,  5 Jan 2025 07:13:15 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2FA7384092
	for <batman@archiver.kernel.org>; Sun,  5 Jan 2025 08:13:14 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1736061194;
 b=YBnna0MeBoTP6wZ8JugAwa0KgjLThJvPucyhtBzkOJnub061tg1s1PLXAqLSrpyGnko0h
 h9+Gubd0CfQ9POzfm6GbFon9V4BTwP4NGrNdlIniaMcffOKSdsRICses2K+ALrhsiSPIFDV
 PfpUvZapz88Cq0HAiO8rHUjcUUre1Lw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1736061194; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Wt3o4O604bKA4p6AOS0R1b+WDuSo3BO+Dl+7OGmYEKI=;
 b=X7AYEf+0exkpHfGEQcKBrwdHYqYLaikMTstH5OslalQHTktGSqV0UMN12emxe/uLxdNrO
 OSZ0d3bT1QguzY9XuqCfiW6u2ux80ZYKw6r6sLBCWIJHoeFtZSkbgfbcMorK/mpC7S24KQq
 6uj2/nvGUSpIIt0vzIQVP7KvR5c9ASs=
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
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 9511B81B0F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun,  5 Jan 2025 08:12:58 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1736061179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Wt3o4O604bKA4p6AOS0R1b+WDuSo3BO+Dl+7OGmYEKI=;
	b=YL1JHRkVmwx9WJwjLlzLUOO5xpfvScS/Aj3M0SMSb1fEusD+oYdgy+gKkhBsBpTBvjLaqf
	4giKXivBqWcYBO6zxBDEIp/nNRxZy/unjJg+P+ED22Zux4NyeyY5YQUgFwwTB1cZUEOkHS
	IDUE8ZhRU26eiU8SORylHDigciKjwuw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="q5H/zVvq";
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1736061179; a=rsa-sha256;
	cv=none;
	b=OZo6VSiqAarBN9UrrqSbdcEaSem3jXz6YSCLNkyQsPtleqOM/p0fQcQYbWxcYkKz+SBUiX
	HXkfaL9SX26yI97KwaTVPhAOXdcNJG880WKqPJHTf+uLCS+vOre6a53/GooJvFYxCdR2EI
	HQpW9KbtptGbJHMwk76Q19euee7odLI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1736061177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wt3o4O604bKA4p6AOS0R1b+WDuSo3BO+Dl+7OGmYEKI=;
	b=q5H/zVvqxrbe/XyrvvR84pYjrSmDQo5u3qJK/lG4qrkfdKCFbeUwl2Ud1L1mZC432HawVd
	VC1Mni9DfVq0ap1YOtimP8+9pAcjRWbh4F926XN90Dsabafqh3JEsrMNbh0ZUyQ/+w/Axx
	5yJTpEbz2znWyQfuhQtklC3U40sLpA0=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Noah Peterson <NoahBPeterson1997@gmail.com>
Subject: 
 Re: [PATCH v5 1/1] batctl: ping: Add subsecond precision to ping interval
Date: Sun, 05 Jan 2025 08:12:50 +0100
Message-ID: <2668360.NG923GbCHz@sven-l14>
In-Reply-To: <20250105000908.66343-2-NoahBPeterson1997@gmail.com>
References: 
 <20250105000908.66343-1-NoahBPeterson1997@gmail.com>
 <20250105000908.66343-2-NoahBPeterson1997@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart868284398.0ifERbkFSE";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: 5CBFHV5YDYD567J24Q6L6BPGH7NFEHQP
X-Message-ID-Hash: 5CBFHV5YDYD567J24Q6L6BPGH7NFEHQP
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/5CBFHV5YDYD567J24Q6L6BPGH7NFEHQP/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart868284398.0ifERbkFSE
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Noah Peterson <NoahBPeterson1997@gmail.com>
Date: Sun, 05 Jan 2025 08:12:50 +0100
Message-ID: <2668360.NG923GbCHz@sven-l14>
In-Reply-To: <20250105000908.66343-2-NoahBPeterson1997@gmail.com>
MIME-Version: 1.0

On Sunday, 5 January 2025 01:09:08 GMT+1 Noah Peterson wrote:
[...]
>v5: Fixing whitespace misalignment,
[...]
> @@ -330,7 +343,7 @@ static int ping(struct state *state, int argc, char **argv)
>         printf("%u packets transmitted, %u received, %u%% packet loss\n",
>                packets_out, packets_in, packets_loss);
>         printf("rtt min/avg/max/mdev = %.3f/%.3f/%.3f/%.3f ms\n",
> -              min, avg, max, mdev);
> +               min, avg, max, mdev);
>  
>         if (packets_in)
>                 ret = EXIT_SUCCESS;

Ehm.....


Kind regards,
	Sven
--nextPart868284398.0ifERbkFSE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZ3ow8gAKCRBND3cr0xT1
yxLuAP0flevnegONszC544TKucQk6xb4td6tORHYFhLur/AkxAD/SIUxQVOXQMSm
Ew7rR489etLKxDYyGOBykeqeJ1YITg4=
=uOkP
-----END PGP SIGNATURE-----

--nextPart868284398.0ifERbkFSE--



