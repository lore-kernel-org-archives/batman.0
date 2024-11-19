Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50081D44161
	for <batman-adv@archiver.kernel.org>; Tue, 19 Nov 2024 14:25:12 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D347683CE3
	for <batman-adv@archiver.kernel.org>; Tue, 19 Nov 2024 15:25:10 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1732026310;
 b=2teG9NWBm08SLIN46hxYPLBAonI6jEtSYYM83cS6uO/aPfDCuR3Zl0yfTkf/3n1+gdp1c
 pbJhOj65av+m+YuKU5Os+hCqwG2A5ls+/nCnp3nXxirLeUsxR8HNm/hFLku3CiOndaWK847
 tjA9pXTyH/L/tCoP9lOY81bscPFwiG0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1732026310; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=3OGEwXusEUTFMeKKIJPcMNkyTLM3U2jMuB10N1NC7UU=;
 b=QVhUGo0CDzr3k5Ms4d5q+cyQK16GFfw1xjqX8WQ7n1t0kEln++CTIDdLwka5EVQh2QSWh
 u5xYgm/koKvxCwk0UVNNU3mWrYXWOHEhnE7gOaaf1i5BOeNHFN9ccNPCco1KE3wPxhfvbOV
 Xe7nO6lKJLfog2O+pQdFJcbd/85XE5E=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 6AF2781C22
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 19 Nov 2024 15:24:57 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1732026297; a=rsa-sha256;
	cv=none;
	b=J09woljZaTW5WIsvngdY9uWMmL6MvCcX8of8F7m3fJQWRbcOR/Nh3QA9amQqRnbrZ2Sfo3
	IdOZuTz+9lSdmB+J5hv4FR8XYp4RTD12TO1/ZkHpZBP6I/8qeX76XSPRFxt87AxKYokWZ4
	gFxYpMiTNszO4VLd3vM9F2O7VmU6Ir4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=qMkt2P7s;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1732026297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=3OGEwXusEUTFMeKKIJPcMNkyTLM3U2jMuB10N1NC7UU=;
	b=asIPizbgPoK5Q3RD1gO6Zh5bngvGgmz/7A0x2UDCNE5k+dVfN2cDZ8orfsVMHIxjiqnSjJ
	0M///k3Dcv8lPFWZtvnndS6VgVaG2ZFS8H09q3cPetvWY1sPpx+DymuD+AaNSgeMJIExn+
	723FprShhcb6nqY05x+hrNaakYQLLbI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1732026296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3OGEwXusEUTFMeKKIJPcMNkyTLM3U2jMuB10N1NC7UU=;
	b=qMkt2P7srhBrLkr1WC3LvrESBrm86fjp6ijdR1AGTvjBQW17er/pI89L+FLNExI9PCV+ET
	16gwr9ThgqCJ0O0CkXa78Ln0CYyjFbR54GmrjK7v6q5gK5Ehs8hXgkF6dwUJbp9+1uKL4+
	WznnbzGaL5H7TW3AfOkL2lU2NXFvLj8=
From: Sven Eckelmann <sven@narfation.org>
To: Simon Wunderlich <sw@simonwunderlich.de>, b.a.t.m.a.n@lists.open-mesh.org,
 Mu De <soanican@gmail.com>
Subject: Re: IP connectivity issue at openwrt nodes
Date: Tue, 19 Nov 2024 15:24:54 +0100
Message-ID: <3253206.5fSG56mABF@ripper>
In-Reply-To: 
 <CACKXFETaiEdriRp7rS2KfuFOcfXpcNe_y+4WfgRUW5t8R=MsLQ@mail.gmail.com>
References: 
 <173195908428.676947.9438253969806655968@diktynna.open-mesh.org>
 <13641455.uLZWGnKmhe@ripper>
 <CACKXFETaiEdriRp7rS2KfuFOcfXpcNe_y+4WfgRUW5t8R=MsLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5996796.MhkbZ0Pkbq";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: Q3PKZM3GDFOXROLU6JCWTIPP25NQR6WP
X-Message-ID-Hash: Q3PKZM3GDFOXROLU6JCWTIPP25NQR6WP
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/Q3PKZM3GDFOXROLU6JCWTIPP25NQR6WP/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart5996796.MhkbZ0Pkbq
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: IP connectivity issue at openwrt nodes
Date: Tue, 19 Nov 2024 15:24:54 +0100
Message-ID: <3253206.5fSG56mABF@ripper>
MIME-Version: 1.0

On Tuesday, 19 November 2024 15:17:28 CET Mu De wrote:
> Dear Sven,
> 
> I would like to ask generic system and topology questions:

Sorry about the "hijack part". Looked at first glance like another person + 
topic. Simply because you've used a different from + signature and suddenly 
added other persons in Cc.

> 1-)Generic System Question
> According to info at the "
> https://www.kernel.org/doc/Documentation/networking/batman-adv.txt" , if
> following "batman-adv" folder do not exist, your interface might not be
> supported.
> If those folder does NOT exist in a system but interfaces can be
> add/removed via "batctl if" command, and outputs indicates interface
> active, can we consider this system works properly?
> 
> "/sys/class/net/eth0/batman_adv/"

This is an outdated document. See 
https://www.kernel.org/doc/html/latest/networking/batman-adv.html for the 
correct one

> 2-)Generic Topology Question
> Consider multiple batman nodes, each have 1 bridge interface, bridge have
> two ports, one "bat0" and "eth0",

Ok, ethernet bridge to mesh

> and IP is assigned to the bridge node.

Ok

> At
> each node, multiple wired/wireless interfaces which have stable connections
> to other nodes are assigned to "bat0" and these interfaces are indicated as
> "active" via batctl.

Ok, the underlying interfaces for bat0 have "redundancy"?

> Can local process of batman nodes and external non-batman nodes connected
> to "eth0" port of the bridge, have IP connectivity to each other via IP
> addresses assigned to bridges?

Yes. The bridge is handling this part - not batman-adv. Just make sure that 
you don't have any IP conflicts. So, for example eth0 + bat0 + underlying 
interfaces for bat0 should most likely have no IP address assigned - unless 
you know what you are doing and need it for debugging (or similar things).

Kind regards,
	Sven

--nextPart5996796.MhkbZ0Pkbq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZzyftgAKCRBND3cr0xT1
y0maAQCRRXz4FvxsdISvFZBioXvVr5whu4GQLGJQi5PMPNqCdAD+K0cjgXrcLM34
OCR5NiKTg19p5pPp/ZuGfogh7mq4NAA=
=bxXH
-----END PGP SIGNATURE-----

--nextPart5996796.MhkbZ0Pkbq--



