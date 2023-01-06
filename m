Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 709D1C54EBD;
	Fri,  6 Jan 2023 19:54:38 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id EA836846F3;
	Fri,  6 Jan 2023 20:54:34 +0100 (CET)
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 85041808E1
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri,  6 Jan 2023 20:54:31 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1673034871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 dkim-signature; bh=AueWTe21QMyFGpKWDdUP/IlYfMZAUbFI2KmoTy6O2/A=;
	b=z2rs37cH1lIqr3Vhi1l/LOFEsLUdkMh9LE9l8tQsMiUc1osY8iaSGjLyAhNPIKq/giQy6K
	vI4bdyPGKBS1k2e8ntCS9tf+FuaYU05VAV9faa5lRc9dIUOc145e0GETmVpQr+5rKJZyL2
	/tOT5TgsvGx3Yn0iZvFCTScoFXR07LQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="p/erQvwq";
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1673034871; a=rsa-sha256;
	cv=none;
	b=SQxerxWCsekGnkZamtCdCs4DPo96x890vZJZzM6PZgtmp0Gq+dzVFm+T3+01aAFJb5ZhP4
	/eTW+qaixt0eiUbwzxGnT49x0r7p3XcK02d8/18xAfzPjmCFVZOsfKFEWPqgACIH3ELtsH
	0SxrPLg6Krtq/WWoKvP6P2p8VbFXAno=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1673034871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=AueWTe21QMyFGpKWDdUP/IlYfMZAUbFI2KmoTy6O2/A=;
	b=p/erQvwqLakEYxB/Cu+g2rkXChlaAP1PZESko+oglLe4Ibj/W9bL7HgkEC8VAetwr5OvaW
	9oTA0Hou7PkLneHF5C0wM4JR2Plw0f6e6WZEFNCctmZAPQr0pvhD/bDnAtOqwXtPC+zEiw
	ehHDXG4oNNCvZ4ILdr8W5j4NjsTRMto=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: Mailing list mirror on lore.kernel.org
Date: Fri, 06 Jan 2023 20:54:17 +0100
Message-ID: <3249673.X513TT2pbd@sven-l14>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3674341.C4sosBPzcN"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: S5QKHQXTTE7JWZDK2ZZZG3VYQDNEJJQS
X-Message-ID-Hash: S5QKHQXTTE7JWZDK2ZZZG3VYQDNEJJQS
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-b.a.t.m.a.n.lists.open-mesh.org-0; header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.2.1
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/S5QKHQXTTE7JWZDK2ZZZG3VYQDNEJJQS/>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart3674341.C4sosBPzcN
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: Mailing list mirror on lore.kernel.org
Date: Fri, 06 Jan 2023 20:54:17 +0100
Message-ID: <3249673.X513TT2pbd@sven-l14>
MIME-Version: 1.0

Hi,

maybe some of you remember the time when the archive of this mailing list was 
also mirrored to Gmane - providing services like web ui, nntp or raw 
(unmangled) mail downloads. But the original Gmane is gone since a long time. 
And the other public mirror (mail-archive.com) is a lot more web centric and 
not integrated in the kernel.org infrastructure.


So I spend my time between the years to fix the situation and create an 
sanitized archive of all the old mails form this mailing list. This was then 
submitted to the kernel.org's helpdesk for inclusion in their public-inbox [1]
infrastructure [2].

To make a long story short: you can now find the mails also under
https://lore.kernel.org/batman/


Some features are:

* NNTP/Atom feed support
* being able to follow threads spanning multiple (kernel) mailing lists
* handle your patch queues with b4

  For example when you want to apply the new multicast patches from Linus:

     $ b4 am 20221227193409.13461-1-linus.luessing@c0d3.blue
     $ git am ./v4_20221227_linus_luessing_implementation_of_a_stateless_multicast_packet_type.mbx

  Similar things can also be done to prepare the patches for submission.

  See

  - https://people.kernel.org/monsieuricon/introducing-b4-and-patch-attestation
  - https://people.kernel.org/monsieuricon/sending-a-kernel-patch-with-b4-part-1

* whole mailinglist archive available as git repository

  At the moment, our single epoch can be mirrored using:

    $ git clone --mirror https://lore.kernel.org/batman/0 batman/git/0.git
    # but you should use public-inbox/ or otherwise you might miss some 
    # archives in case it is split into multiple epochs

  See

  - https://lore.kernel.org/batman/_/text/mirror/
  - https://people.kernel.org/monsieuricon/subscribing-to-lore-lists-with-grokmirror

* Subscribe^W Pull mailing list with filters via (lore)lei

  See

  - https://people.kernel.org/monsieuricon/lore-lei-part-1-getting-started
  - https://people.kernel.org/monsieuricon/lore-lei-part-2-now-with-imap



The hyperkitty mailing archives on lists.open-mesh.org will continue to be 
supported. But their archives are not perfectly suited for working with 
patch(sets) - so this should be a nice addition for some people.

And I will also continue to use patchwork for keeping track of patches. 
lore.kernel.org and its tooling just adds a cherry on top.

Kind regards,
	Sven

[1] https://public-inbox.org/README.html
[2] https://www.kernel.org/lore.html
--nextPart3674341.C4sosBPzcN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmO4fGkACgkQXYcKB8Em
e0Z0Rw//RFP4xSmJHr2WHBippnknGkXvfbAKGaSV/jPsHzcyZBV/MbtNZeuw+/WO
AoPYGaGhtctNP1fR6pk882/lNg4LOy9HOWQncNN/h9GWsKU6VSiZMaKPjlO9MnDF
XfO/WiQFKyUCIGPK7Y31Qpl7CCIXhs2Jz+Fzd/lpEAt0VnvxIMI42UoWvoNEszmN
tZFB4bEGPY/pBnfgPzfK4Znr5WpfjPd7QyTx+0wPzqdhBA9dO9SQJWkH/PNBt2UF
0+lXIDy81ic8ScqYTXMACqLyM2eSx0aolQyp5RZ2wTLRAB/ZrAclx0vNX3fzweIW
tVGrECmny5LnlOnFB2AVAVoVsZ5JWSRcFxszG4orqGUh+PR7wHg04VjXvFXb/Lmj
3AkqooIrYUfRO4FpnQ7FG6OJNzPH+ZbX5Yy3mTNz8h9WRMrWrof8UtmAdfbdKgXZ
PKOzQ9F5Xhg2ynZyKeSqEPy6xCsz5V8SpXkLLcF4c0jmE87+M3/+vUVnp55k/+0i
+/5AHe0Bfu3BUm6sjGEE+5imOmKMWjHYFK3fC+JNzxk0IXrwaQ8ZmXDJk+pmMcaR
QsLrN6sE4P1dLjx25b/JGuQTMQdwtq8bkENb2WvRiDxYy8U2mzXkkQOHLM9gEyXf
VtEZt1l/UMzQhmJ3qKpEm4BwyyHCro+THfrWFRUbbOSlSiOzIJk=
=P7eN
-----END PGP SIGNATURE-----

--nextPart3674341.C4sosBPzcN--


