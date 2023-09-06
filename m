Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 900B8EE14A5
	for <batman@archiver.kernel.org>; Wed,  6 Sep 2023 15:50:43 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B9DC48311B
	for <batman@archiver.kernel.org>; Wed,  6 Sep 2023 17:50:41 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1694015441;
 b=bnuWRdGpMLap3AeL2FDCKc2DqX8T+Hx9rrSdXGoQlwSZXQgqNC/gI5NSAw9oBg8DIrW+Y
 No5E3vgOSzseZlCcflPMnJhApHO7CqNTdOyVQb+yEEsCvkcKGcEXyZUteUJBOI1TiPkrJct
 KZnlzUxkgx4yG0SVfRTp3jZW82ZXDPM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1694015441; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=EqoEz7n9W6QX2+v4CWr9+TFM+9Qbrg2rvQj8O/dSyMc=;
 b=CeOj95jW/B2YQoOV8cttOQ56Fy6X4m2VJ9UUyE2RNYLvRA+X+5UPwXOLPUm0XYbMVL8XT
 behGfNswXnKRBchelPzfehhLrTUpeuK8STFVCyEFxqiBgpWxeB2LoVL9PS5nkkkCjlkUbmI
 +nWp5MC58fcSUqwmaCTjMPDVwrcrqM0=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=kkk-web.de;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=kkk-web.de;
 arc=pass; dmarc=none
Received: from mailout03.agenturserver.de (mailout03.agenturserver.de
 [153.92.196.166])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id C468F80216
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed,  6 Sep 2023 17:50:30 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1694015435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 dkim-signature; bh=EqoEz7n9W6QX2+v4CWr9+TFM+9Qbrg2rvQj8O/dSyMc=;
	b=F8DmQo5p8yZWWf9r5AnYhDce/WYlBOlWi8rJ33BaR6A8ewBlYTHirUpWuWe7hsTvmy7RN6
	/PchDm9eoXq0UKo7qhnYrYLPuMaTwnOTZ2cjE90K9twaXDgNMwm1wu4pwW9LKuIU/1npGP
	AZNOMTtPlvAz9pptDMTasmf5Ws1dAeM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kkk-web.de header.s=agenturserver header.b=DoYXuGSv;
	spf=pass (diktynna.open-mesh.org: domain of mailing.m1@kkk-web.de designates
 153.92.196.166 as permitted sender) smtp.mailfrom=mailing.m1@kkk-web.de;
	dmarc=none
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1694015435; a=rsa-sha256;
	cv=none;
	b=qR3Y1Cij8IRSxUy88ITXLO+Sq82Bsr1MjowMUHfEZiLq1OZHJ5l7kaJ2oZMIGp4O4AtCLk
	wASBGk3zc28lRT6f+93XSTH/yTZhNAb0leMF7oMzIl7V9apyCVgabHVHFWiBqahIjh6Yl9
	YyU/vajpC+fPtiM9avltdZVxJHboxrE=
Received: from mail02.agenturserver.de (mail02.internal [192.168.51.35])
	by mailout03.agenturserver.de (Postfix) with ESMTP id 50CD444A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed,  6 Sep 2023 17:50:30 +0200 (CEST)
Received: from XXX.XXX.XXX.XXX (XXXXX.XX [XXX.XXX.XXX.XXX])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: p381503p13)
	by mail.agenturserver.de (Postfix) with ESMTPSA id 25065A084A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed,  6 Sep 2023 17:50:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kkk-web.de;
 s=agenturserver;
	t=1694015430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=EqoEz7n9W6QX2+v4CWr9+TFM+9Qbrg2rvQj8O/dSyMc=;
	b=DoYXuGSv2IjOCQTK8bc+eAJRkg1vYr/dQ0WrEBICgccUZ7nraOAqLt3ndocZFs/EGY+Oki
	nPrxOe6epmkMzVhri6VP9Bfl6WF08k8vSbDBbVSDlvjgtt+DTa2+IEGohXGxbdkvyE5AhF
	ZGFjGucmRgAk+hwmOgn1apoUTydEhMw=
Message-ID: <0cf2d2fa-4563-c662-1b7c-0052e399ff7f@kkk-web.de>
Date: Wed, 6 Sep 2023 17:50:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: de-DE
To: b.a.t.m.a.n@lists.open-mesh.org
From: MK <mailing.m1@kkk-web.de>
Subject: batman 2023.1 fails to compile with implicit func kstrtou64 on debian
 5.10.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Q6HsFAQqZJiIytZHPHIj1NDQ"
X-purgate-original-type: clean
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for
 further information)
X-purgate: clean
X-purgate-size: 2453
X-purgate-ID: 155859::1694015430-168B949A-531680F8/0/0
Message-ID-Hash: N5XDITGJ2W7EM5VAWLYNBRPRNYX4ZJIB
X-Message-ID-Hash: N5XDITGJ2W7EM5VAWLYNBRPRNYX4ZJIB
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/N5XDITGJ2W7EM5VAWLYNBRPRNYX4ZJIB/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Q6HsFAQqZJiIytZHPHIj1NDQ
Content-Type: multipart/mixed; boundary="------------iseol4gjPbonbfAocj1OUsB8";
 protected-headers="v1"
From: MK <mailing.m1@kkk-web.de>
To: b.a.t.m.a.n@lists.open-mesh.org
Message-ID: <0cf2d2fa-4563-c662-1b7c-0052e399ff7f@kkk-web.de>
Subject: batman 2023.1 fails to compile with implicit func kstrtou64 on debian
 5.10.0

--------------iseol4gjPbonbfAocj1OUsB8
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgbGlzdCENCg0KSSB0cmllZCB0byBjb21waWxlIGJhdG1hbi1hZHYtMjAyMy4xIGZvciBh
IHN0YW5kYXJkIGRlYmlhbiBidWxsc2V5ZSANCmtlcm5lbCA1LjEwLjAtMjUgYnV0IGl0IGZh
aWxzIHdpdGg6DQoNCmJhdG1hbi1hZHYvZ2F0ZXdheV9jb21tb24uYzo1NTo4OiBlcnJvcjog
aW1wbGljaXQgZGVjbGFyYXRpb24gb2YgDQpmdW5jdGlvbiDigJhrc3RydG91NjTigJkgWy1X
ZXJyb3I9aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dDQogICAgNTUgfCAgcmV0ID0g
a3N0cnRvdTY0KGJ1ZmYsIDEwLCAmbHRocm91Z2hwdXQpOw0KY2MxOiBzb21lIHdhcm5pbmdz
IGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzDQoNClRyaWVkIG1ha2UgQ0ZMQUdTPSItV25vLWVy
cm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uIiBidXQgdGhhdCANCmRvZXNuJ3Qg
aGVscC4gU3VjY2Vzc2Z1bGx5IGNvbXBpbGVkIG9uIDUuMTUuMCAodWJ1bnR1IExUUykuDQoN
CkFueSBpZGVhcyBvbiB0aGlzPw0KDQpNYXJ0aW4NCg0KDQoNCg0K

--------------iseol4gjPbonbfAocj1OUsB8--

--------------Q6HsFAQqZJiIytZHPHIj1NDQ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE9IPOuVyPsFfx2iJ9cNiJ0EN5ao8FAmT4n8IFAwAAAAAACgkQcNiJ0EN5ao+c
vQ//WyxM5e8Ggr65UneXBvA84aUrQSrtn4t+INAqUIHbdXcPJwCaZyv2mZo5ej9KRHjW12VSh5GL
rq4CGMvbVH2x5tOJdOGF0ReSBwBRmG22JINIEUGPPYXuljU5Nh5UYNLfP5VVsgGPnQ6Qh3ZYnQTr
KPBRw3qW4WQtDcOjsmvUD1iGpV/fEVHE4Q7WOdz//GthsqFEu9s/d/x9VL0sk5LaZDaI21y+//gL
0KFwSVbwKSyJTM7QauZvNPeRWY1VqlzP9y7RM+AwGzDGaU0j3dDUf88YaEGGews1w3S1Ols33nSE
GFc2vZFncaF7L94hcR2MKptTkmQ5cSWSpBxTJK/wxHjmsKC7Z8icvTSr73hoviY6x83969nj6GEj
cONEgESGrIKsNmUgVYOGKBMgQ24nIgGY/078Ezz1l1XTBO9Mbmc60bV+PZ8o7kqi2y9r522wnD0t
RG6ibImkWbDfUQTSccoikOy/2sHl9ekQiK1LLD57v2oVVxvRL/0FuTgQh60rdSW2NnRFUvupr43s
ILlH/xWK4Wvy1yqIojEqTmvEg5tJHBu4W9mlk8HTYHN8flCmPrf5GiS05OnMyV1OlFpe+J2EmHVM
vVVgia4z8otRYu+AHnMV70hzdVHXvno0GqSWQSqCg0iYBlu+3fQO4F9gCr7UdgZqEa5TlLARu9sW
/3s=
=RNhg
-----END PGP SIGNATURE-----

--------------Q6HsFAQqZJiIytZHPHIj1NDQ--
