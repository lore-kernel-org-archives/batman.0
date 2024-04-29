Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D392C4345F
	for <batman@archiver.kernel.org>; Mon, 29 Apr 2024 14:28:35 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 73422820C2
	for <batman@archiver.kernel.org>; Mon, 29 Apr 2024 16:28:33 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1714400913;
 b=Z3uGUQK0dc2l1PlGqm+ts6x/bCJvNhEC3hpdDPsPyqwRSizpEvQAMdpa+mogIRNbbzlS1
 bCIkpjMVgBpKWYGciHIgRp7hxYS9TUHiH2CFasevSR1VPxTSpPbAtBDE0/snRCS8w60FdDm
 l/nsLoG++pvkdz1mykhkuh8NNFUhbbA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1714400913; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=VvRNaCG6eVTctMkMfbd6I0wPvnZig+m0Je/wvxp58oo=;
 b=Cgxk6hWHemfrDSrhxI67pPXOo9KGGp7pMEYr+oyUR22eDT33HFnFvrZbfMVijIFsB1x3R
 QcPEQXIAwVyLlBGMgkA6tTG0bimUnSBb1ZeGCU/G+ElyRBmNc5ABVTBpBQ/gj3HcYj9aLEM
 5rRBnZm1XmcF6X3EgSpPsEiOQr3pvtw=
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
	by diktynna.open-mesh.org (Postfix) with ESMTPS id B3677803CB
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 29 Apr 2024 16:28:28 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1714400909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=VvRNaCG6eVTctMkMfbd6I0wPvnZig+m0Je/wvxp58oo=;
	b=BU3WcWQi/QPeDJqUzG8W21KuR0/JSTI0Ilu5WHi7qGHJLCWVMCL5Ga0dCGmk1vNXBTgnew
	7zxmj/d0SaCvoj+hj2gRjBcXg5Sapi33wntaHVEJtg/GR5dW5tKKbec2J29G0lTmxCneFD
	mHzDtnK/B3FyB1rL7XpsMjh97ehTZJQ=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1714400909; a=rsa-sha256;
	cv=none;
	b=xoUu8SPXegoks6+SNq31mLIO+vNidvsIKMVhTc4d/Q5AUmOryDbtfyU8NUJnyLNMgCFrmf
	YdIgVXfbCqMY09dS8svcsiyI/73XDtrNgYUfGm19eqLNqmAxHFvFB6yvLrJ0dxVuk8QQfg
	Bi6fvfnyT23mpeaTAxBilbWEWTeBtlA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=nKdcItIF;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1714400908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VvRNaCG6eVTctMkMfbd6I0wPvnZig+m0Je/wvxp58oo=;
	b=nKdcItIFzs9l70ryRPvHQHfJXgx+ydUJDZu4jdTh2QZDyhfl8ytOp3t7Mah4x5hqUIRMq5
	eQlibGv+msaO1+tYO/EGw2j8njFsYHfvPQqU3z2n+BPJBY3IfNos8nFcPTHUS2X+54cnRS
	n9dIEM43uz7GpaMN5cRZwYxVzp26r0M=
From: Sven Eckelmann <sven@narfation.org>
To: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>,
 Furmans Hannes <hfurmans@student.ethz.ch>
Subject: Re: Using B.A.T.M.A.N.-Adv and scanning for neighbours
Date: Mon, 29 Apr 2024 16:28:26 +0200
Message-ID: <2934192.e9J7NaK4W3@ripper>
In-Reply-To: <DAE0E173-234B-44C0-8D2B-C16551497CE0@ethz.ch>
References: <DAE0E173-234B-44C0-8D2B-C16551497CE0@ethz.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3287885.aeNJFYEL58";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: DBH5RJ5Z7VLV4A3S4DHPGHBUIFTOLRG3
X-Message-ID-Hash: DBH5RJ5Z7VLV4A3S4DHPGHBUIFTOLRG3
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/DBH5RJ5Z7VLV4A3S4DHPGHBUIFTOLRG3/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart3287885.aeNJFYEL58
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: Using B.A.T.M.A.N.-Adv and scanning for neighbours
Date: Mon, 29 Apr 2024 16:28:26 +0200
Message-ID: <2934192.e9J7NaK4W3@ripper>
In-Reply-To: <DAE0E173-234B-44C0-8D2B-C16551497CE0@ethz.ch>
References: <DAE0E173-234B-44C0-8D2B-C16551497CE0@ethz.ch>
MIME-Version: 1.0

On Monday, 29 April 2024 16:16:21 CEST Furmans  Hannes wrote:
> Hello everyone!
> 
> We have a setup with four Raspberry Pi, all in IBSS mode and connected via B.A.T.M.A.N.. That all works fine. However we now have troubles scanning on the Pis for the neighbours. 
[...]
> Which is not what we expected. We hope to see the RSSI of our neighbours and that should be possible, at least as I understand it.

Why do you want to scan here? If you want to have the RSSI of your "connected" 
neighbors then just run:

    iw dev wlan0 station dump

Btw. this is not really a batman-adv topic. If you want more information about 
the linux wireless stack then you should try the linux-wireless mailing 
list [1] or IRC channel [2]

Kind regards,
	Sven

[1] https://wireless.wiki.kernel.org/en/developers/mailinglists
[2] https://wireless.wiki.kernel.org/en/users/support
--nextPart3287885.aeNJFYEL58
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmYvrooACgkQXYcKB8Em
e0ZzbBAAjzMBxTP4MyyxDrtx+zZcSEAplg1skeuIdPDrDEpOy+MqdmT8RHf4qYFY
KFFb4UI+K0LUJlPiM4hnyFLQmro0zp41NQCmKEw0ibY20lLrTseQPu9mMICPs6/w
1NE/QhmgSNOPW8gXsK0eXguV7TlVDnDMBMPc5aWeuWSP/b6whZgrA5IJYDDvUdJP
ossg1BQnE34+yHnXwqHgwFl0KEkRD4CtLMsu57TrH31knzim2H6++lC2+1SkcA50
NVeWWzFuJ0PiUGX18XZvwL8UXX6DwwSw3iqK756lA2SH/gmN+XDaeEwbN8XgWkWX
avUgf+7cCYY4vjV9OPVa4RIWuUhYM993nTnp1qtgpQinWIlqApynCR3o79xWkuuJ
Dw7HSvzJ337NbSu8M66k2ZzsRMJbv269kaVU0oK+8Ew7Lr6lhFWuYZIV+/Ug0A2T
0tFmyONG7RbNumGoiiV9UI29067hwGlpB2VHLLCQVrThGqXeh0+zJMFboGDnUKPy
cUcjkuODo6yDb/I4PK+WpzEEzqX268WunBI4dDbBaW9P7hSM3Z38SZFk/wc5YvPU
mrDaoadiBJ1ncU0G18tWVlxh+GksXTpJV9S32hoTZAZbJ3ckv7Z6XbVzC30hxefd
qFwKKaz0Lphbn+3ilfkRj1rEBSX0IP51eQrYVfAtB6PUw9pVjWM=
=eB4n
-----END PGP SIGNATURE-----

--nextPart3287885.aeNJFYEL58--



