Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1BDAEB64DD
	for <batman-adv@archiver.kernel.org>; Tue, 11 Jul 2023 13:17:12 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0148381CFA
	for <batman-adv@archiver.kernel.org>; Tue, 11 Jul 2023 15:17:11 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1689081431;
 b=Vgo+Vy6kiOfTkhvGh51vuxUweBqxnC1nWRoQlPxT2UqHrU9Ol0bEzs7H9rz75qJLUf2hc
 vkCSvgNyuBcU4Jjdt8khtRPU4aH8Q8ng+wYy1TM8YkGd7c4b9MWvZIAWzJgBmiIMmbN2RQJ
 FVkDjKBDyPOIg8ohVsUxUGZh+nPRPIc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1689081431; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ZaOAkO39vYUggDcACAcvheQDbeLMHMjwX1CvXbBh7Xc=;
 b=DhD8jHiVRLKnPXAb+lgy+R1W4esrmqT/H8ozSWEtQB/VLngL8Z2+6FztmJZMXI2ajW78y
 TqgZFFcRKKUvyBry/RB3tsZICACa5BM1wwu0uEU3ScIk23ackch1xcaACq8fRxobm6mZWJ8
 /JqGuOD9X/lopOEVA46ZycVkmpnNBLI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id D7B3780BA6
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 11 Jul 2023 15:16:56 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1689081416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=ZaOAkO39vYUggDcACAcvheQDbeLMHMjwX1CvXbBh7Xc=;
	b=u4jamsjz7xjcmPeHVxP02GVPpVa3s8FGipdkEmOlli4aqUbUfICQNZwvcbbshGqgfYiSHj
	K9C2q8TTEn3FyuxKotsCY6AGbeYkdAUjrt3uG9F9scyosKzPoGJQ15yr+4drIA0i12IRGu
	tQn3xmNeYwzehEc4yL8gIdVfj4v5PEk=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1689081416; a=rsa-sha256;
	cv=none;
	b=u+TfHYUEcRN8ikzGWkupmQdHflbfmi2pcaAXECn6Ss89brTIwc97jbh67xqi1RMCvBjMeT
	CX03KTmFtEagA9sY6/D4GCdMcNpUhT2agi7shUecR8cR8OMQLlBhhf9UYLpMZc2G6c6QSb
	sXWX03a47tU8ZhsWn7cZTnGdh3ILfB8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=Rd7e1ivJ;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1689081412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZaOAkO39vYUggDcACAcvheQDbeLMHMjwX1CvXbBh7Xc=;
	b=Rd7e1ivJGED7XfnasKL4ciIfSzDpLsIYvrAejWFxV8MASsb8TT7Yj6+4dFPSyt1gkmn38K
	TlViVjjdnbpeYQbtVF4muAhj1Js6FPn64EYuasEjffN62HgAPzri/ig78bSw1X9MoOZQbQ
	ox9n2DVLa2xDLpdu2WQZkE1GpseHx7A=
From: Sven Eckelmann <sven@narfation.org>
To: anders.berndtsson@idptech.se
Subject: Re: Yocto meta-batman
Date: Tue, 11 Jul 2023 15:16:49 +0200
Message-ID: <5859564.DvuYhMxLoT@sven-l14>
In-Reply-To: <004301d9b3f8$148ce6a0$3da6b3e0$@idptech.se>
References: <004301d9b3f8$148ce6a0$3da6b3e0$@idptech.se>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6119891.lOV4Wx5bFT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: 6S7LYXKUPASNOE3FFZKSMYILZQSC52LT
X-Message-ID-Hash: 6S7LYXKUPASNOE3FFZKSMYILZQSC52LT
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Jonathan Haws <jhaws@sdl.usu.edu>, b.a.t.m.a.n@lists.open-mesh.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/6S7LYXKUPASNOE3FFZKSMYILZQSC52LT/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart6119891.lOV4Wx5bFT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: anders.berndtsson@idptech.se
Cc: Jonathan Haws <jhaws@sdl.usu.edu>, b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: Yocto meta-batman
Date: Tue, 11 Jul 2023 15:16:49 +0200
Message-ID: <5859564.DvuYhMxLoT@sven-l14>
In-Reply-To: <004301d9b3f8$148ce6a0$3da6b3e0$@idptech.se>
References: <004301d9b3f8$148ce6a0$3da6b3e0$@idptech.se>
MIME-Version: 1.0

On Tuesday, 11 July 2023 15:03:25 CEST anders.berndtsson@idptech.se wrote:
> Is there anyone supporting Yocto layer meta-batman ? 
> 
> https://github.com/jhaws1982/meta-batman 

Why aren't you asking the maintainer [1]? But he already wrote [2] on the 
mailinglist [3] that he will only accept PRs but not maintain it actively.

Kind regards,
	Sven

[1] https://github.com/jhaws1982/meta-batman#patches
[2] https://lore.kernel.org/batman/DFCF0D4B-8A76-4CB8-9577-620452E7F116@sdl.usu.edu/
[3] https://www.open-mesh.org/projects/open-mesh/wiki/MailingList

--nextPart6119891.lOV4Wx5bFT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmStVkEACgkQXYcKB8Em
e0aOLw/9E4LYh8DhsIc4mom2qypOhB2n5P/NxgKACOdlOVWD0Zvl4ZT3BdZuz0O0
OP9e5xw4lcYC0Nu2wm75jE+bpoZ+hcML+2rdmOzrziI+MLGw8Wx8LQBhwCmk0R+l
57jENBA/7V72wtldhei6sl5uXOAtN0kxdftQiom4r0oP7RvC43FXoa/DGl/MZQSJ
CUxhxKRIdCdd1LpNxpe4fbkP9A2mZnAfULl6jDiEGWSH4fdaz55CsVKTlzbMQ1Oo
Dsh3ikYsE4kI6oPNz5XW8FjQlgBJ0q7fYUpavdCxCUwzXKbkkM+lgf99OvHlgf0O
V+JMKn1256V0WvLbr+/AJkoGaGyjePYUhgupCzhbSWD8rOLo0fXO0GrBfYFh0ZLQ
x8P6arFD1mSMF3OeGjYLClsEWvT3vIj5iPL35sM2zYjkKqudeFMxO1lHTnwdrx3R
9dBnD4k2Vm6a+WkIVDzNrjwiGj95A/9SbZpxdlgdocOABCxhe3t5T+2CZ7D2uawP
qZsm2WfNkAuSVzsqrn3ISrNEFdwr1p3V+Pj5V/K7Aj/outpnfkU6Dwjy64kU5OeC
iRF/S2bE62J7ojnNQ71hJyC8EaLkbuQqFlDzuAaBp/Ouc6M+SKcvP7JucPonKPZb
Di5+vTpdkkgoGWC2GA7nu3Se7DP5JZHnphydN4MTsORNMHbiFEY=
=Y8Zn
-----END PGP SIGNATURE-----

--nextPart6119891.lOV4Wx5bFT--



