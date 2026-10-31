Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14E6606A31D
	for <batman@archiver.kernel.org>; Sat, 31 Oct 2026 14:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=k54nASmC
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 6ECD984828
	for <batman@archiver.kernel.org>; Sat, 31 Oct 2026 15:20:29 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793456429;
 b=UeT3P3a8Ks7PSa8cW381y1mWtYvj8iOD2/VIujjquDwBeS2trqVPHq3fV5l47wt0PyaCK
 ZXc20PUbhFZSeppSCE1htrnc5qWsHC8OVbL/HgX2vhg/Yow/GWLb27OlkuyJoSFg6K/rd0n
 FfPyCb9YaTpWA+bZff+lwYpQQrB9UHA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793456429; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=yoYaomVVIgBtPptVSpd/XzENTexn4bVDmzF3s0hSweI=;
 b=oHUbQRq6MQ4Qbn6qA1WmFbqRDAQ5SCp6FjCzpV118YpgYBaP+zacfYUFQkMMtaorbsnps
 4UkOgBFpB2iRek8JHPc6LnALb7UJzzkmLLw/4Hjvt3dXFL6u7nU5dpsDR6Q2+bqgMFdIewl
 YIUrGTmljEEbnr0Zfwe3J6Y+1WlNjdo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id CD7138109D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 31 Oct 2026 15:20:04 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793456414;
	b=MiaS3gLq5/Sce1uNayKI3FwrTqe7NrKmNgTRUduw1Bt/7eHHrAd/jHSLt/bnjt6tYs2L3u
	mvQrWhD+ecbhkVT91Ia+9z8ZYUhhZQngJwrefou4hMh/5BEqdP4kuRVwT/WqwVsM391evA
	FQc2GR+xkJDwOpqdR4QB8plKsqLVepk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793456414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=yoYaomVVIgBtPptVSpd/XzENTexn4bVDmzF3s0hSweI=;
	b=DmGOYn5XsMTtNRKAbNw//EUQDTUfSlGhxjih8zf++TPFGEgwV+yVqU1cfCEupZl1QNYkNY
	5+4XpkuTrVBeiCdWu/moraNYSYsxmFmTPfUbLhenQM0KaYkQFaKMu6+WP/K5feT371G+F+
	sqZ185ILIVJycB6hR8hucbOtXRAf7Jg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=k54nASmC;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 267FD1FF1F;
	Sat, 31 Oct 2026 14:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1793456402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yoYaomVVIgBtPptVSpd/XzENTexn4bVDmzF3s0hSweI=;
	b=k54nASmCB3EMFcBsWdVMkxFadLU/2tXmjQpaOS3wFU2JOmo7Y4E+1C+V/KtLwL7puagWfg
	dAR7a1VzFwp8nAKa4nOgLvC+390hoCCaD9Pvq/Yrm5bPHFgPxyNRx0RBAChzZJd5q2ECMk
	IBV6QBZh/xpgEW/YcZBnnhE2ARE8Gr0=
From: Sven Eckelmann <sven@narfation.org>
To: marek.lindner@mailbox.org, sw@simonwunderlich.de, antonio@mandelbit.com,
 =?UTF-8?B?w5ZtZXI=?= Mete Kaya <omermetekaya0@gmail.com>,
 b.a.t.m.a.n@lists.open-mesh.org
Cc: davem@davemloft.net, b.a.t.m.a.n@lists.open-mesh.org,
 linux-kernel@vger.kernel.org,
 syzbot+61b202fdc410840f0198@syzkaller.appspotmail.com,
 Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH net] batman-adv: reduce softirq drain in tt_purge loops
Date: Sat, 31 Oct 2026 15:19:59 +0100
Message-ID: <8752561.T7Z3S40VBb@sven-desktop>
In-Reply-To: <2282819.irdbgypaU6@sven-desktop>
References: <20261030000222.286935-1-omermetekaya0@gmail.com>
 <48b23995-4f67-4f3b-8988-78546cc23ecd@gmail.com>
 <2282819.irdbgypaU6@sven-desktop>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart10939703.nUPlyArG6x";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: 4RDVRQTDLH2EPLBZXALME6R3WXXQJ6DB
X-Message-ID-Hash: 4RDVRQTDLH2EPLBZXALME6R3WXXQJ6DB
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/4RDVRQTDLH2EPLBZXALME6R3WXXQJ6DB/>
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

--nextPart10939703.nUPlyArG6x
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 31 Oct 2026 15:19:59 +0100
Message-ID: <8752561.T7Z3S40VBb@sven-desktop>
In-Reply-To: <2282819.irdbgypaU6@sven-desktop>
MIME-Version: 1.0

On Friday, 30 October 2026 00:59:51 CET =C3=96mer Mete Kaya wrote:
> +               if ((i & 63) =3D=3D 63) {
> +                       local_bh_enable();
> +                       cond_resched();
> +                       local_bh_disable();
> +               }

This is repeated (and will be in the future even more repeated). And it=20
contains odd magic values. This should maybe be extracted.

https://git.open-mesh.org/pub/ecsv/batman-adv.git/commit/?h=3Db4/hash-itera=
te-disable-bh&id=3D2cda1f6e4640b3bbdfadb8ef1ef633cf3c87f6ec

Regards,
	Sven
--nextPart10939703.nUPlyArG6x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCauX5DwAKCRBND3cr0xT1
y5ipAQD63Kw+bMcj8AIxPvUzFYUhtLLwiicMmdsg9ZJ2/LHOZwEArOXlL+o9jBAT
bphEj2XUuhD/qPQdN/fRfzOXi0etzwg=
=Mymd
-----END PGP SIGNATURE-----

--nextPart10939703.nUPlyArG6x--



