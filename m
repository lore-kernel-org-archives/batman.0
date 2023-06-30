Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B949EB64D7
	for <batman-adv@archiver.kernel.org>; Fri, 30 Jun 2023 12:46:52 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4F18F81995
	for <batman-adv@archiver.kernel.org>; Fri, 30 Jun 2023 14:46:50 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1688129210;
 b=k1qlUEYyXRzHkg13eoIyd8Fiyonmse/GvSSRmIkb6CcytctdwDIBvMnkbxKiMky6YV35C
 Q4kaAKJO6waVznPj+OYCz6F269lBu8UFfLO76OHWfenlUi+G9G3zeetM4sNjWLoa3jSKG+d
 IobTcW90p3u0wT7jrpQb4pnaxO23Gsg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1688129210; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=c9ecmuu1gBWTSpzEj1ZC89INElZvJXFWec6wyM8rMQk=;
 b=O2zyfHn43jNMTQQrBBmetcJxEWgf9w4SMgvNzBBxnR8yEUwSFyvlMIFVH4UPjR0OrYRx1
 s11yxRq9Gu5fzuHULTux9HRcism/NiqaJzD8mtAZe3cxqGHOdAjjEyyZi1s9yheTXOfKBHL
 FAB8GK2TwQRF6tePYH1N04Hma8mC134=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=mk16.de;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=mk16.de; arc=pass;
 dmarc=none
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de
 [194.59.206.189])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 7E8FE8172F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 30 Jun 2023 14:46:34 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1688129194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 dkim-signature; bh=c9ecmuu1gBWTSpzEj1ZC89INElZvJXFWec6wyM8rMQk=;
	b=XlJglNuS6WQZs2iBletE/AESg+5vdWo5DI79lqnDQeebzl+zIm1L873KlhcU0v58fb36sI
	IgXYXpvgPJhZM5LLM5VB/LrARdSekg1IIpDkDgLlUSuz3yXw0ApxfOShEW9fIkjtd1XYGI
	UHlv15uMvP1uNTbLSWtHrsJm2QKGnLA=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1688129194; a=rsa-sha256;
	cv=none;
	b=S/YDwSYV7o4N2o/QVba+CyVsaHnUhvi/7Hy3x2eShNl7LQw/qaed4M4LWCcBBF0kEG/vRI
	FsKL9Yq7C/62SNBa2IrPRDHNbv2jO+S2GsfjmLbGXOUXrxt5qUKYRxf+I2e7WAIYZ5tCXr
	pQn/0wIEMw/nBL7v7X2t9ETp7OUJUpo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=mk16.de header.s=key2 header.b=F9QVmZBD;
	spf=pass (diktynna.open-mesh.org: domain of m-k-mailling-list@mk16.de
 designates 194.59.206.189 as permitted sender)
 smtp.mailfrom=m-k-mailling-list@mk16.de;
	dmarc=none
Received: from relay02-mors.netcup.net (localhost [127.0.0.1])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4Qsw6y1p0Lz43wm
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 30 Jun 2023 14:46:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mk16.de; s=key2;
	t=1688129194; bh=c9ecmuu1gBWTSpzEj1ZC89INElZvJXFWec6wyM8rMQk=;
	h=Date:From:To:Subject:From;
	b=F9QVmZBDNFFG+fAUUILMKwFBitZrtx/sxu7wVN0+lmoVeTcW9YRQySPtN19n0xPUo
	 0Aa11ZnkAlyjEmPVvEQY7nn21hyReylwpYMFnlRftFQHqlkwvx0vuiXHzf4E85Xd/C
	 hbUK033FvWTqBTF39bWAaNL6/wv2xXj9VL15vLtDWR+zlPMgVllyuxIeEUFLunQRSf
	 klocWsbH0LrdI5CkRakXSLO3I+kV72vP/QW0hRsY3fiZC9NdEB22AJeM8GtBI5vwBG
	 4Hmjq8pd4uwmrhcILfq7XJl71dnxO+50mbTlvlpI3AaShqAK1LoiYmQEZ/+0ZegMbd
	 vXxkOA7enlmlA==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by relay02-mors.netcup.net (Postfix) with ESMTPS id 4Qsw6y1MzRz7wHP
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 30 Jun 2023 14:46:34 +0200 (CEST)
Received: from mxe87b.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits)
 server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4Qsw6x6wJtz8sZR
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 30 Jun 2023 14:46:33 +0200 (CEST)
Received: from parrot
 (dynamic-2a01-0c22-8e00-e2df-18a8-cb02-90e6-1f2c.c22.pool.telefonica.de
 [IPv6:2a01:c22:8e00:e2df:18a8:cb02:90e6:1f2c])
	by mxe87b.netcup.net (Postfix) with ESMTPSA id 9CAFB1C002E;
	Fri, 30 Jun 2023 14:46:29 +0200 (CEST)
Received-SPF: pass (mxe87b: connection is authenticated)
Date: Fri, 30 Jun 2023 14:46:23 +0200
From: Marek =?UTF-8?B?S8O8dGhl?= <m-k-mailling-list@mk16.de>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: Authenticity of routing information in Batman
Message-ID: <20230630144623.238fe33e@parrot>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/s6nNfzNp0+iCotSXQ_dtEAK";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-PPP-Message-ID: <168812918980.3055645.961554392397180571@mxe87b.netcup.net>
X-Rspamd-Queue-Id: 9CAFB1C002E
X-Rspamd-Server: rspamd-worker-8404
X-NC-CID: kvKIfmiFh5iKMh7w2BfQPJpYVMJ0q2oUgg7YRQrxp65vGAgiNejoM0E=
Message-ID-Hash: GAYTMNNCVB5KUL235CBMQCDIBVP3RSMR
X-Message-ID-Hash: GAYTMNNCVB5KUL235CBMQCDIBVP3RSMR
X-MailFrom: m-k-mailling-list@mk16.de
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/GAYTMNNCVB5KUL235CBMQCDIBVP3RSMR/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--Sig_/s6nNfzNp0+iCotSXQ_dtEAK
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,

I recently came across Batman Adv and the question arose in my mind
whether it is possible to authenticate the routing information exchange
- for example with HMAC as in babel. This would for example prevent
attacks where a malicious node says "I have the perfect route to the
destination!". I am not concerned with encryption or authentication of
the traffic, only of the routing information. Is there anything like
this in Batman (Adv)? If not, is it planned to implement something like
this? If there isn't, does anyone have an idea how something like this
could be done differently (in a different layer)?

I would be very happy to receive answers!

Greetings
Marek K=C3=BCthe

--=20
Marek K=C3=BCthe
m.k@mk16.de
er/ihm he/him

--Sig_/s6nNfzNp0+iCotSXQ_dtEAK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEmqKBWfzrPNg7whIBfoaRRmmRCMcFAmSezp8ACgkQfoaRRmmR
CMe8LA//Rrnu+VQsPXlEDbHNEJR/by1sit8Y3RnzlRKKfigHyby3VtMegsht55BS
rjhATY+Tc4rGcfsQvnxB8YlhkSxNzEIs+wgU+pzE2Pi7RiXUrVMCDPI1wjly+YGA
Xq77c29ymCW4hA5NCDCddOl5jInJNIVh6DElj3aseUpGgChuSf+bVoLe5Z92QQO+
/BYEJIEHwyKGqVvLkxfSp2hksdLPjj21VTsjoiKy4eWd+Kw4BzxVFvNZiEmwmt+6
RJ8jYnS/dVVUPzOet20dI6uoz8eTw7Qk/F5UlZpPDCufJPe8JPG9H0I8g08F1PgB
cbtEndHA7H59X9yu8Kk6Q/HohbYzFRnzqcAUT0AkX3oVqqSyDcTzvAVqxqRwjq9c
ybb+llryKtg6khZaFt9KDGwb9K2WCGWjBumoUh9Y9MVHIkZmjL4wYDPuB8ZH1RzE
gwYSstiJq915kweYEu91tlzJdgtZAFCwzz5DwpKpAzNd/13ZyReR3sZcOLN5cpSP
yHgfPhKtTkoIabnwIsYvv3UYAaYTLikdE2EUuLnlYMkjKQTiI6RqJNDYxUtn9B1G
Qeq90CZjKdD+I7uNy4HdNe6k2l1HT/SFDfLh6C16ESDrS3UxpD3AZeqVlBGSrQCl
oBUqRdPEmpzeJca8f3H++opheiIuqG105cy0nq3jo6KR8aBiUgg=
=q1cq
-----END PGP SIGNATURE-----

--Sig_/s6nNfzNp0+iCotSXQ_dtEAK--
