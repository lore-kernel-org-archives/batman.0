Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B36D5E396
	for <batman@archiver.kernel.org>; Sun, 17 Nov 2024 08:25:03 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 284F78261D
	for <batman@archiver.kernel.org>; Sun, 17 Nov 2024 09:25:02 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1731831902;
 b=gQx3xJlXOfo8L8EMMB3nS1Q6PqAdk0OS5BTrl/TM4Qcwj1RtGjxa6YQcJXrg8v/gOSUtF
 DqfM1dubZFdl3iSUqEEQXqVAm2/JNlnT1YmRcs/yMS/raZjHuHYN0RlciDnjsO8+dLijnaA
 XieDPoJC/VIU4L0Ff+J3Cp2JRazaM2E=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1731831902; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=0ULxDVYi2KA/WEIbu8QCklVrRqNDSeBf0Pmb7XlJlJo=;
 b=ChMvElyxxHDrT5SyUIXaGTO8VZI8LK2KtHNB+EQhwhN9xKd/UDInkJLhyuaqO/ffxsGyo
 FUk9Rd7KRW+8pqAC87qNC40yFokX45iErjwSmRo4LC0MCO+R5QjoI37KPFXG/vfOvBxKcIQ
 qM/mxXt4dwCi25UP4zk+xUsQdGwG9sk=
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
	by diktynna.open-mesh.org (Postfix) with ESMTPS id E385C81CAE
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 17 Nov 2024 09:24:54 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1731831895; a=rsa-sha256;
	cv=none;
	b=P1ZYD0VR5Q6tEpJAyD+oZNR26yhVlcLMVdOy+2NApJIE/nnVEYX8RUPc9+UZ0RPTiHzf5/
	fxVSythPVzDywBog1l7IeT6diKtlNAQvQ1dLddat6Ck4d/GBGyevLjbFTlN6NOupSCTXC4
	ZPmRm+VCJCPhNNR+SeimBZvFy7HAsyM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=ROQEnOvL;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1731831895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=0ULxDVYi2KA/WEIbu8QCklVrRqNDSeBf0Pmb7XlJlJo=;
	b=Y/VuBn0UIrJ4SiI5MTkB07eWCR2q5RJh+AIxMdP1Ssc3FFDv2AM01fqBoNTjlf8NR4Sjr6
	H+WRGkTcm+JJHUb57/9kG4axEP0azU8m/rdqL/tq0AzdPM015qaeGrYeQO3lOI/s0c1oys
	K53V5eO0pvd2cDVZmzNb6QpA5o/yE1E=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1731831894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ULxDVYi2KA/WEIbu8QCklVrRqNDSeBf0Pmb7XlJlJo=;
	b=ROQEnOvLpO93WAiZ3LV4pDPz97XmoJY7J6K4S0bA5fClLTObjEI9O0Zr9QtOhC5kCM/p5Y
	m/ztK+nXrO4DF73gCNDiYomlcRYQa9b4Blgpfg9BzGGqsXALSU+JPGqFa2vMaIkJiK54sZ
	u55yFoQWUnWS6w4721ppkg3C+AxhBpE=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org, Remi Pommarel <repk@triplefau.lt>,
 Antonio Quartulli <a@unstable.cc>
Cc: Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>
Subject: 
 Re: [PATCH v2 0/5] batman-adv: TT change events fixes and improvements
Date: Sun, 17 Nov 2024 09:24:50 +0100
Message-ID: <2376061.n0HT0TaD9V@sven-l14>
In-Reply-To: <cover.1731792497.git.repk@triplefau.lt>
References: <cover.1731792497.git.repk@triplefau.lt>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2565570.Sgy9Pd6rRy";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: ADYUOAUKLFAF3N7E5NTVUPOPSE44DLZX
X-Message-ID-Hash: ADYUOAUKLFAF3N7E5NTVUPOPSE44DLZX
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ADYUOAUKLFAF3N7E5NTVUPOPSE44DLZX/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart2565570.Sgy9Pd6rRy
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 17 Nov 2024 09:24:50 +0100
Message-ID: <2376061.n0HT0TaD9V@sven-l14>
In-Reply-To: <cover.1731792497.git.repk@triplefau.lt>
References: <cover.1731792497.git.repk@triplefau.lt>
MIME-Version: 1.0

On Saturday, 16 November 2024 22:32:04 CET Remi Pommarel wrote:
> The first three patches are actual fixes.
[...]
> The next two patches are more cleanup / potential slight improvements.
> While patch 4 is mainly cosmetic (having negative tt.local_changes
> values is not exactly an issue), patch 5 is here to keep the TT changes
> list as short as possible (reducing network overhead).

Thanks for your patches. They look plausible but I want to get Acks from 
Antonio before applying them.

Minor thing (3. patch): emtpy -> empty, "a creatind" -> creating, ...


@Simon, we need to apply the first three patches to net and send them early - 
just to make sure it is merged in net-next before we send the last two 
patches. Just to avoid some merge conflicts.

Kind regards,
	Sven

--nextPart2565570.Sgy9Pd6rRy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZzmoUwAKCRBND3cr0xT1
y+riAQDBvq9bP6hEag5IAu/SjVVJpdOZvbVxphsEF+TS3nna8QEAswfGHmYyXuG3
Cyy6Lhni91ewc6ogLu1an5X07pFvbQ0=
=rp0c
-----END PGP SIGNATURE-----

--nextPart2565570.Sgy9Pd6rRy--



