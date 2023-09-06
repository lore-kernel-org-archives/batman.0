Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF0BFEE14C3
	for <batman@archiver.kernel.org>; Wed,  6 Sep 2023 18:55:56 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E87B88313C
	for <batman@archiver.kernel.org>; Wed,  6 Sep 2023 20:55:54 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1694026554;
 b=emNmR0ufHodQh8497a0Jyrg+D63Xy4hf9G+lfks70lVPGCIztZyITD28SUf8KXCNzIECc
 ut760OLIHGI/GKCjRX0oeebdXWSYNyNsY2GDoJpb4U27vY2Eb9DJvMe8QlgMGLeyB71Eys/
 Q9o+oRRTo99MlTSofHzpiql+ax1/+Gw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1694026554; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=c9J0uwzdlib6RG3+mxoQYqQpn0E9zvZcvvH+baLbvcM=;
 b=vNq8Ut64BQ2wDiGXq8ll3+j3Bu/hYCqObuTxYtLNCivU3Ne3tOJ9IEXK3Yp6RStAhq7C7
 fDUZZLHB5iaxrqh9mT0pIklUNQROCBY1zJ/rEiwU9+0J/LMcSDlYhQXMvt302Z8lh8t2ELi
 sS+xMmZ7LHduT7eWSbhfSsIozIlLTkk=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=kkk-web.de;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=kkk-web.de;
 arc=pass; dmarc=none
Received: from mailout04.agenturserver.de (mailout04.agenturserver.de
 [185.15.192.35])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 68CC48090D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed,  6 Sep 2023 20:55:50 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1694026550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=c9J0uwzdlib6RG3+mxoQYqQpn0E9zvZcvvH+baLbvcM=;
	b=f4nDgGuZAgP99Zu51ib4S3pA7V+TMhKzrB+7TRX7CUqpJ8C25ZZJTIPz/YzzL3tufPcx6i
	nFrphJb76jGLDvXI02M0ZflYC90mbGLvMPthyX7zzPftIENMo9ZlSEKOvElsWuQGY5lINu
	ao90L6QHRiQhyq2I9yX3wTVlrTytmdU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kkk-web.de header.s=agenturserver header.b=eUu6HFc8;
	spf=pass (diktynna.open-mesh.org: domain of mailing.m1@kkk-web.de designates
 185.15.192.35 as permitted sender) smtp.mailfrom=mailing.m1@kkk-web.de;
	dmarc=none
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1694026550; a=rsa-sha256;
	cv=none;
	b=AHxEGp37s3l81wHhn0XWL/jkLz1dT3ptTw3PMB+v2jI2U1mxmhPtr1KM/ZFvvtgRNM62h1
	kzTehV1M8tuns/jUWIcj60dL9n6JeOjmCt6AcbxhOWJ1t1tcSeH256oN6il3RKQa7PEVhU
	B735J/oMflIGL5aRuamIvphUEweQ3S4=
Received: from mail01.agenturserver.de (mail01.internal [192.168.51.30])
	by mailout04.agenturserver.de (Postfix) with ESMTP id 329A4275A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed,  6 Sep 2023 20:55:50 +0200 (CEST)
Received: from XXX.XXX.XXX.XXX (XXXXX.XX [XXX.XXX.XXX.XXX])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: p381503p13)
	by mail.agenturserver.de (Postfix) with ESMTPSA id EA82DE00BA
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed,  6 Sep 2023 20:55:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kkk-web.de;
 s=agenturserver;
	t=1694026550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c9J0uwzdlib6RG3+mxoQYqQpn0E9zvZcvvH+baLbvcM=;
	b=eUu6HFc8upyVf5l1Y9h1AtYIEp52FYpAnIsYrwtxAY0PJh9ZK17tQIH6QdJ7PY+/B7N2hu
	YygvyQHM/Bu4qgNKrdm4kPlXEp9IDt9AYF9FWVeOKR/FjEJXpghKwSu1Dr6C5LjDe6S6+R
	CedP2nF8c9o1k/XyLsE7p42+cvNlrpo=
Message-ID: <4cb39084-cd63-c6f6-5380-a90b543e9a3b@kkk-web.de>
Date: Wed, 6 Sep 2023 20:55:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: de-DE
To: b.a.t.m.a.n@lists.open-mesh.org
References: <0cf2d2fa-4563-c662-1b7c-0052e399ff7f@kkk-web.de>
 <5945222.6fTUFtlzNn@ripper>
From: MK <mailing.m1@kkk-web.de>
Subject: Re: batman 2023.1 fails to compile with implicit func kstrtou64 on
 debian 5.10.0
In-Reply-To: <5945222.6fTUFtlzNn@ripper>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------lCKKVVpEGhRndh6Yhgfj03eF"
X-purgate-original-type: clean
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for
 further information)
X-purgate: clean
X-purgate-size: 2206
X-purgate-ID: 155859::1694026550-00D7549A-1A9F9ADD/0/0
Message-ID-Hash: SWUW3H3Y276GGI3OJ642AHCKBOKVLBUS
X-Message-ID-Hash: SWUW3H3Y276GGI3OJ642AHCKBOKVLBUS
X-MailFrom: mailing.m1@kkk-web.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/SWUW3H3Y276GGI3OJ642AHCKBOKVLBUS/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------lCKKVVpEGhRndh6Yhgfj03eF
Content-Type: multipart/mixed; boundary="------------o4w8eYc63JElSH18DYViFRbN";
 protected-headers="v1"
From: MK <mailing.m1@kkk-web.de>
To: b.a.t.m.a.n@lists.open-mesh.org
Message-ID: <4cb39084-cd63-c6f6-5380-a90b543e9a3b@kkk-web.de>
Subject: Re: batman 2023.1 fails to compile with implicit func kstrtou64 on
 debian 5.10.0
References: <0cf2d2fa-4563-c662-1b7c-0052e399ff7f@kkk-web.de>
 <5945222.6fTUFtlzNn@ripper>
In-Reply-To: <5945222.6fTUFtlzNn@ripper>

--------------o4w8eYc63JElSH18DYViFRbN
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgU3Zlbi4NCg0KVGhhbmtzIGZvciB5b3VyIGZhc3QgcmVwbHkuDQoNCiA+UGxlYXNlIHVz
ZSAyMDIzLjINCg0KRGlkbid0IHJlYWxpemUgdGhlcmUgaXMgYSBuZXcgcmVsZWFzZSBiZWNh
dXNlIGl0J3Mgbm90IHlldCBsaW5rZWQgZnJvbSANCnRoZSAiTmV3cyIgcGFnZToNCmh0dHBz
Oi8vd3d3Lm9wZW4tbWVzaC5vcmcvcHJvamVjdHMvb3Blbi1tZXNoL3dpa2kNCg0KQ29tcGls
ZXMgbm93LiBUaGFua3MhDQoNCk1hcnRpbg0K

--------------o4w8eYc63JElSH18DYViFRbN--

--------------lCKKVVpEGhRndh6Yhgfj03eF
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE9IPOuVyPsFfx2iJ9cNiJ0EN5ao8FAmT4yzEFAwAAAAAACgkQcNiJ0EN5ao8K
dA/9GJnCWFRs4k6dMJ80jIv1MbJuRjv5dTOqc1IEx813Xg/FYRM92fB4IrlnQ8lcx+i3pF31/n7Y
c4tDhVE8IYLTPYy49kBVXAgn2+vTD4FJ69UXut3QQ7GI4TmEhxD66989odiTebs8XFT5z/MloFJN
3KTXLCITGWZKiya16lK4lHvZ+cQdlJl98ntEvmJPx/iBkxaCYdj3/PhGWXXWTGTKhoj4htGP8Quq
NtVgS7T5bm2mjuysTB+EFJXbsE9SBYB2CprdYDpoDXyA+G8259BNER5D4IYadtMoyv2J4JuoWQDr
4nmFchf/sKZG4sSvN2gNrZ/ZKmGFilu2Q9lRz3M8RY3H65kW69eflzg94F3YnRxG7ZLstuuFs19r
57lkds8ZYJGzLGVLhhiwXOr9Cka+YAipIpW1mFWAo44xfTpRPNiMsc4fKVuiIKuFcVs6opST5UT6
cFm7a7JzWmDqhys5UeB4rYJ7JVJoURDAbTIT6tKgazcDFsWjSp7Zfp8eB74pmb5xcWW032znwhos
iC6Nj96fMYwDVqRNCvElskBZwyol8SARHZ7u6ohmDyDMsImqKIkkRTbh5TamFg26TI4WWBWT0qp6
9klTGNc4GKpuK9f/QWjpU0ECkyHrusLdenu6RgPAUGm76WoMYu4pVdp+nId8h09bVVDsvGgFDMyw
+tk=
=TaQp
-----END PGP SIGNATURE-----

--------------lCKKVVpEGhRndh6Yhgfj03eF--
