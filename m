Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C56D44162
	for <batman-adv@archiver.kernel.org>; Tue, 19 Nov 2024 15:12:06 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7DE0483FBB
	for <batman-adv@archiver.kernel.org>; Tue, 19 Nov 2024 16:12:05 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1732029125;
 b=jlJZz7LAMyZ8ZS0vR+hbTO3uSL6ixW9VITjAhXagaRER/aMiuO/pwdCouZuIz8nzslnWH
 F5qA+WdmaGY5C2B8g8O/vATbaBzNrgQXLigNULSCDjNe5A2YCSeUHjCWO4S1dfFUBTXp2DT
 D5qPqb43fIK2bSHr3hFNjyIywCPb+Eg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1732029125; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=1mt/fjg+3FpWEbPvWP7ZCuhVV8v9ZctVWXSDPJVL0K8=;
 b=Xvhe+jWL89X6b2FojrbWjmjMspx7LqZczCPBJzPvldgPMU5d30igiEGDigirTvWJbD6Z6
 /IVgDZQx6HQp6KhLkDQuFCIvZythfLcY7I3cOyUIGT/OMdRsD+I2uVp6oxmD76Zr6p/6JKn
 k7BEEPX7YOCi5HjjHLor5wyzxMY349k=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 5D5258346C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 19 Nov 2024 16:11:54 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1732029114; a=rsa-sha256;
	cv=none;
	b=g7tOBojROtLfvHc9WoWTft41PVxnVP9osyIl/x+X2bQTETgibWRXSUOGHlyqV0NM0Zqldl
	6Sbx79RMitbPyDpc5/s22Q+VHBqDim8R0vfRWo8HxsbrtKaA+aBhzF/wLk/ianZZT2lLjX
	Ha7IwIdx/3+lCzUNdcFka/6EYO50NV8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=VlxQnt2s;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1732029114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=1mt/fjg+3FpWEbPvWP7ZCuhVV8v9ZctVWXSDPJVL0K8=;
	b=u2tIQdKQ2kp39Z/w//QI4JYZNhhsTn/IoR0DFQbYAnci+aEJPgQvqJ7UKC7meV4z3fxiJQ
	F8WmXo3tPFTVD4ep7y9gNltaUpICguVg2RhEKW/6Kwzjc/0z1NUyVh06JEjP9guQzydQP7
	6WinPdU2YeAfu57WYZa3bQGSoAyKtMo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1732029113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1mt/fjg+3FpWEbPvWP7ZCuhVV8v9ZctVWXSDPJVL0K8=;
	b=VlxQnt2sYcTNzHUi3n5TYyNc1LYRqRsA3jRpGeLjpn4uRnKD9KqCQPWJ3LuPTx/YpehR2S
	91D/taA6kPMzlsqqtyuUNv+UW0xx2a4RYmJ+wAqoQsPTv6XcNYHu4ypNw13XC+WzXl2Afg
	4VxJQrf16AELUoPTtBg5oNxsu2ASpEc=
From: Sven Eckelmann <sven@narfation.org>
To: Mu De <soanican@gmail.com>
Cc: Simon Wunderlich <sw@simonwunderlich.de>, b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: IP connectivity issue at openwrt nodes
Date: Tue, 19 Nov 2024 16:11:51 +0100
Message-ID: <2631894.Lt9SDvczpP@ripper>
In-Reply-To: 
 <CACKXFERn_+LZ4ztxmfOwhUM91ccjVSAbTYf8U1ivS+0sXeJkWw@mail.gmail.com>
References: 
 <173195908428.676947.9438253969806655968@diktynna.open-mesh.org>
 <3253206.5fSG56mABF@ripper>
 <CACKXFERn_+LZ4ztxmfOwhUM91ccjVSAbTYf8U1ivS+0sXeJkWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4388509.ejJDZkT8p0";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: OAPBEOVSCEP6ZA53J4FWMFCIKJCTFFAQ
X-Message-ID-Hash: OAPBEOVSCEP6ZA53J4FWMFCIKJCTFFAQ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/OAPBEOVSCEP6ZA53J4FWMFCIKJCTFFAQ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart4388509.ejJDZkT8p0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Mu De <soanican@gmail.com>
Subject: Re: IP connectivity issue at openwrt nodes
Date: Tue, 19 Nov 2024 16:11:51 +0100
Message-ID: <2631894.Lt9SDvczpP@ripper>
MIME-Version: 1.0

On Tuesday, 19 November 2024 15:59:58 CET Mu De wrote:
> "batctl o" shows empty table

Which means that the underlying link is not working. Either because the 
interface is down, not connected or is manipulating the transmitted OGMs 
(broadcast) in some form. The latter can for example happen if the underlying 
link is converting broadcasts to unicast - some accesspoints are doing that. I 
just mention this because you seem to use station interfaces as underlying 
interface for bat0.

You can use tcpdump on the underlying interface to see whether the submitted 
packets (OGMs) on one side are received exactly the same on the other side. 
Wireshark has support for batman-adv. So, you could easily check the recorded 
PCAPs with it.

You can also check "batctl n" to see on which side you can correctly "hear" 
OGM packets. If you can not hear it only on one side then you should check 
this one initially (but continue with the rest).

Kind regards,
	Sven
--nextPart4388509.ejJDZkT8p0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZzyqtwAKCRBND3cr0xT1
y4LdAP9EycUjZKBzdJ6nE9XxXiH/QSnsRwpspHJv4ef9IhaEVwD+OfDvoxsu9G2k
I/lYYU3i2SRWsqrCve3BJ6Wlgsxkdg8=
=+xSB
-----END PGP SIGNATURE-----

--nextPart4388509.ejJDZkT8p0--



