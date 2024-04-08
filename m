Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E8F3CD1292
	for <batman-adv@archiver.kernel.org>; Mon,  8 Apr 2024 07:42:56 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C33C381A07
	for <batman-adv@archiver.kernel.org>; Mon,  8 Apr 2024 09:42:54 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1712562174;
 b=DmhjC/4cjhVBR8CUg/95mIzDmqlmQvpAhVPNrNrjn6sx/jNyf8XImLUtjFDXYRayhpGXI
 Qj4xcfZuE1naoWGN4hTQM+yCIIXa0YzJliAj6tSZ19DuKmzSe5OsF+Z5p/bUjraMQHDFwfK
 rcCpVZ60SzKceq8w7kbo+MSSVHF1vI4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1712562174; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=2kWUqTZbaKWSp2drzpGeuiPMZSgH5jg5bgHz03n1Z1c=;
 b=RnGERHctxltYeKzrk/8cABYhijpfG0y28c0xVdn9CU5ZjC2BUx2xHCIh/MU6mlTSlX3oa
 +XZtkKkK5Y0DxhgxXOJPVvZzxYvZKcZKgcxKxUjL87nXcXE0ay2bReqn2thpplkvkap3NLL
 aeJINr/OnosqabMcl+lNVUoyHqC/hmA=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id BE92180398
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon,  8 Apr 2024 09:42:49 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1712562169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2kWUqTZbaKWSp2drzpGeuiPMZSgH5jg5bgHz03n1Z1c=;
	b=RCTSX69f0JqBxw1xNMP9Hg3OGRaUWv5t2sPnS5SxZRdMO72aRusfg4k/ZRdMUjScUBVjsd
	StsLSyBxj3Aaz/MINlr4GglgxO8rACicantemVgmVhn3NuZ37LaW/0xYqYGgX9fcB1avNA
	OLX41Q6kqPtOeZMXfz7weG6AZ4UMhWk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1712562169; a=rsa-sha256;
	cv=none;
	b=hgd4AaWIhV1FvDBysnjPFwYlI1PZpy+7m2UiFRaOXjLUO5az+NeWi7ZkB7pYGkzzY3GQLL
	iWce/riTEdSzH/PxSof18DccVC9zc5ea1OhdWjLvn72Z/kUMG5FFjskucgCdCtVeqhlh5t
	jv8FYOtA/TpfVsmaf/pxVVSaG0fYOf4=
Received: from prime.localnet
 (p200300C5970C08D880F0E590a91F010C.dip0.t-ipconnect.de
 [IPv6:2003:c5:970c:8d8:80f0:e590:a91f:10c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 34138FA100;
	Mon,  8 Apr 2024 09:42:49 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Liunian Bian <mrbianliunian@outlook.com>
Subject: Re: How to cite the BATMAN routing protocol in a research paper?
Date: Mon, 08 Apr 2024 09:42:45 +0200
Message-ID: <2269621.iZASKD2KPV@prime>
In-Reply-To: 
 <MEYP282MB31231B4B48B7D9960334CEE4BF012@MEYP282MB3123.AUSP282.PROD.OUTLOOK.COM>
References: 
 <MEYP282MB31231B4B48B7D9960334CEE4BF012@MEYP282MB3123.AUSP282.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1969758.PYKUYFuaPT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: NPTSDVBRQ4V4FV7GVNADFZWEBUU7CP3Q
X-Message-ID-Hash: NPTSDVBRQ4V4FV7GVNADFZWEBUU7CP3Q
X-MailFrom: sw@simonwunderlich.de
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/NPTSDVBRQ4V4FV7GVNADFZWEBUU7CP3Q/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart1969758.PYKUYFuaPT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Simon Wunderlich <sw@simonwunderlich.de>
Cc: Liunian Bian <mrbianliunian@outlook.com>
Date: Mon, 08 Apr 2024 09:42:45 +0200
Message-ID: <2269621.iZASKD2KPV@prime>
MIME-Version: 1.0

On Sunday, April 7, 2024 11:46:49 AM CEST Liunian Bian wrote:
> Subject: How to cite the BATMAN routing protocol in a research paper?
> Hi, I cannot find a proper citation for the BATMAN routing protocol.
>=20
> The citations I could find were:
> > A. Neumann, C. Aichele, M. Lindner, and S. Wunderlich, =E2=80=9CBetter =
approach to
> > mobile ad-hoc networking (B.A.T.M.A.N.)," IETF Draft, 2008 [Online] R.
> > Sanchez-Iborra, M. -D. Cano and J. Garcia-Haro, "Performance Evaluation
> > of BATMAN Routing Protocol for VoIP Services: A QoE Perspective," in IE=
EE
> > Transactions on Wireless Communications, Sept. 2014
> which are incomplete and outdated.
> Is there any references I can use for citing BATMAN IV or BATMAN V in a
> research paper? It would help me a lot.
>=20

Hi Liunian Bian,

unfortunately we don't have a good way to cite batman-adv in a paper. What=
=20
most people did is to cite the 2008 IETF draft (which is actually not suppo=
sed=20
be cited) or refer to our website www.open-mesh.org/. Perhaps the best way =
is=20
to cite both, referring to the website for up-to-date documentation.

Cheers,
       Simon


--nextPart1969758.PYKUYFuaPT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAmYTn/UACgkQoSvjmEKS
nqEmWg//SDx0RvJrjAmBFCGnRosWUQhLWGjsp8V0GIrOSh+SuQZpEzsWmwy/9fie
DQ5odxfEcWQ0Vkxo5E+MmdheK+eAGx9+CntCvtSyoKcwnddAX83ThtMkw4QB1puX
UVPoD/0Sp/W3vicIMr5ZoOxtwJuTrU654uKD8DZj9ziUFfS8iP5ho4Tl0rXqvSuA
kZ5UWnqP0FQ9pbxkSDPri7PFNh6dVg+wI1xujnZTytznCnxdaEdTk6CE/95QZFdv
oZg3nihiTE/Ayr2/tJnNMixw19TG3SBpOaRAHunOnvJuB8ifK4hIQbgZ8pkXid34
XFyqJcFh3nm72noa/9Om8aUYVJaq/nt01bcsYeL3ztRyXXcNqmjAt4qSEyaR6sn5
/ebZ3nKUGfpRvGUkOPMZB9q/H4m7GENiufaYHb/MOXEQOKIkEHi3RJDTt2CaWCc9
0NP18dXSxz4EVWsvwerdUNoyYndQRXJP7NNynarL8x9biztEGASJN4QM39lCl4Uj
Ysc4kt4yvLmhZ4q0TKeb5VUt2SiU3InTszf5uoij9T2HSukSszK/1iuvy7/JxYM7
18UXYfSXVofOYzGm/d5RWVPvbwNcDp27F5sIyDiznNE3cSA77nS5gxEgxfloyZEh
H+FOzq/USvV5seU6dq8QOFItzIiH62njNS6foLEYfPFv0VWhP68=
=USrO
-----END PGP SIGNATURE-----

--nextPart1969758.PYKUYFuaPT--



