Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48939E7719A
	for <batman@archiver.kernel.org>; Thu,  9 Jan 2025 10:55:48 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B21168424B
	for <batman@archiver.kernel.org>; Thu,  9 Jan 2025 11:55:46 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1736420146;
 b=lXoA5d8Fnkrj8gUf+hus1pRYmn/ZjrTSUJZkF1j9p8R80r8l5gwUmmn0EReFV3gxyrspI
 eu638pmi6VOIHjzO3TZJ984Fq+q3uAA04jAfwLI+p++fkT0f+MnqmjC3yYD02ytipIxCZ9o
 7JBb9+tJWyAg4rYPvxZiafLANJkOCbE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1736420146; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=u075XG2Hm/HsJd+FXoo5Do9TAJznPNIvBwXePN9ojFM=;
 b=mX2VaK6Wnj1vlK0baMJ9wMf8zND4haf58jCJM2hSePgo9WotqhuOHvBjF5j4swWzOvGfS
 RjgTLrOTFJ2Ida/tcIf47qFNhmSoW91qtkiV+iCksz7qe0QyPtvOGj7zc76Z6URkGRJcr/P
 QdxRLMvcfoNFleR7CKJOa+cunZQZUR4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id A53928172F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu,  9 Jan 2025 11:55:27 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1736420127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=u075XG2Hm/HsJd+FXoo5Do9TAJznPNIvBwXePN9ojFM=;
	b=xvsa2yyJDmT+jLq5SVJv6Vuw4Qu7SmH/HDwl44Tgl2WPMZwAJLwRTR3t5557UZ4UIZ163Z
	JWn1W9KycAKKud+yt8qvA+rBAFJfjqkXhEba2M2r3kGpl5/eQHvjSOOCG9+klDegxy/a+/
	F5SCj8w79iOVfzLh9YpQ9SOmLYrSlpk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=rpzHjXo2;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1736420127; a=rsa-sha256;
	cv=none;
	b=Qwiv/wQ9sAo1MxeZ0a7lbg9jmSNShDGBNhbjlJ9YQWOUqpC6l2S3vgfZefFycfCij5YK4t
	y4/HTQozRHTkYMrHDISjfUtYNMCzR4UlEj1okMEpxL4Jwf13jaj50pmpcgkN82pLehO3Y4
	nC+ErDGdFxI6X9IEZZz6idqv/omx3KM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1736420127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u075XG2Hm/HsJd+FXoo5Do9TAJznPNIvBwXePN9ojFM=;
	b=rpzHjXo2Gr9prpYXMEgxU+brEta6NEFoEOWFXNo2Yaz5Nln6pQSHw5ZAnhdJIh4nU4FOFC
	4doapf955N9ig4DL13S6o3QFY+1GATVQ3m6fzA0hhLKg7jm/aXSmZRMpS0zBPkG0MCMmnL
	VH1HxMeoDcYWLrfJRxTC+4bbHI15mwQ=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Matteo Fortini <matteo.fortini@gmail.com>,
 Antonio Quartulli <antonio@mandelbit.com>,
 Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Subject: 
 Re: Multiple ARP replies for same address on openwrt module 6.6.69.2024.3-r3
Date: Thu, 09 Jan 2025 11:55:23 +0100
Message-ID: <4646493.cEBGB3zze1@ripper>
In-Reply-To: <74e4f2ce-5629-4816-93ee-f8b3ed3891e2@gmail.com>
References: <74e4f2ce-5629-4816-93ee-f8b3ed3891e2@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5051391.0VBMTVartN";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: BD4VUAIQUIAFQVYHJQIBKO3OERQX7RIG
X-Message-ID-Hash: BD4VUAIQUIAFQVYHJQIBKO3OERQX7RIG
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BD4VUAIQUIAFQVYHJQIBKO3OERQX7RIG/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart5051391.0VBMTVartN
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Date: Thu, 09 Jan 2025 11:55:23 +0100
Message-ID: <4646493.cEBGB3zze1@ripper>
In-Reply-To: <74e4f2ce-5629-4816-93ee-f8b3ed3891e2@gmail.com>
References: <74e4f2ce-5629-4816-93ee-f8b3ed3891e2@gmail.com>
MIME-Version: 1.0

On Thursday, 9 January 2025 11:31:06 CET Matteo Fortini wrote:
> I am noticing random unreachability of hosts in my network, in 
> particular if I just nmap -sP the whole range.
> 
> I traced it down to ARP poisoning, and the source seems to be two hosts 
> running batman-adv which are claiming the same address.
[...]
> 
> issue is, 02:00:06:bb:00:07 is not the right node and the host is 
> unreachable. The other MAC is the right one.
> 
> If I clear the ARP cache in my source host, then the remote host is 
> reachable again as it gets the right answer.

Might be DAT related. But I am not sure of it. Can you please add the output 
of

$ batctl mj

to see the (batadv interface specific) configuration.

This might be helpful for Antonio/Linus. If it is enabled, you could also try 
to disable it on all involved hosts via:

$ batctl dat disable

Just to see if it has any influence on the behavior (to see if there is any 
ARP poisoning in the long run - not to solve the intermediate problem).


> The problem started after updating to the 24.10RC series of openwrt.

When you used 23.05.x before, then this would suggest that it was introduced 
somewhere between 2023.1 and 2024.3 (or OpenWrt) somehow.

I didn't test it but a quick check in the sources suggest that the 23.05 
batman-adv sources (from the routing feed) should also work with 24.10 - so 
you could actually git-bisect openwrt routing from 
6afc0452c2534ed0bc65b59b1fb6fd74439ddf27 to 
eaa4aba30b017de66bece8ef9d3dde5299fc787d

Kind regards,
	Sven
--nextPart5051391.0VBMTVartN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZ3+rGwAKCRBND3cr0xT1
y2vyAQDjLwdw4yt6o8C+mbSlD6LJ7JmAShZWlGl21+gwm+lWKAD8DiCJasVWdv41
PZapzxoRUmYexHwUlcPv+DEHo51nfwY=
=2dXd
-----END PGP SIGNATURE-----

--nextPart5051391.0VBMTVartN--



