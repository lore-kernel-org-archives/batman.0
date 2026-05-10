Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9CF3CD37B9
	for <batman@archiver.kernel.org>; Sun, 10 May 2026 14:00:06 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3A7D285B4F
	for <batman@archiver.kernel.org>; Sun, 10 May 2026 16:00:03 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778421603;
 b=eov6el31WYqAgKG8G7McNJZz2Mn4h2DiQrqWKml6rlSGcGabqSfeL8u9G1REz8ticUeIl
 w3H/uqrsR5nkur+Dj8ypmzwehD9zc8ZkAzVTMf6I8bkbYiLBGpSzGsdvCEY6B5FGUc6hVuN
 GkcIEcVBCAJvnfljdQAlD+/5rzCXjKU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778421603; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=jVCwo7BAkD8R4Hpn93up0UOwq0mQ7FOeUN6bc6/i4XQ=;
 b=veHX0G/K9yGU/d+l0V+t+YylhA11x2IvuptWtA17Upv7kxFhBgnPZOfaqtLkiaVb5cnI3
 3WM5BYzDLDtukg07BZtztnwBUt3CxtrM6wRO/WeeE9VPzXY0iP0LtAJvkBUy068uzhMIyL4
 8SjZjIgIHKVnKfPSiiiLs9YK1EZTlS4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 940F8841B8
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 10 May 2026 15:59:38 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778421578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=jVCwo7BAkD8R4Hpn93up0UOwq0mQ7FOeUN6bc6/i4XQ=;
	b=zvcqq/DjgVjbo7GOQlRZd4i2MRHS4N0HE+oEBHAAeJLsoMInNRl3WpkEaeDflq8QhxMlTS
	gsvmaPwRmlpyOH0olTz6LR9HwCP9hSedlAddBv3yIrK8ahfOBG+ZorfN7xv1JU7bRl7yzk
	u0FnJWbGkIjFL3GbDZ7UhCWWQ757abE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=uj4zKrYY;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778421578;
	b=jfW6JJo6aT1cKRwq1I2kbAY1TTeKL5EOAqJhoIAtwXSw2Z/UgtT6yubkhZ74jiT394gREG
	e6onJjMgfKHyv94fllm6mHrkSuGQrKr2Y1XZi3IUT0gCUllhhcPraUPLtQbt2eeP5xopJA
	p+GIY9xDsCPyhixjd+4M6aNTK7CtlGM=
Received: by dvalin.narfation.org (Postfix) id 78EC11FF65;
	Sun, 10 May 2026 13:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778421577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jVCwo7BAkD8R4Hpn93up0UOwq0mQ7FOeUN6bc6/i4XQ=;
	b=uj4zKrYY+Ycx5wAG2G5nM5/KEAbY5uqA9l5qahoYBbRc68Og9+ticUIVUbUsg8XyIzKcAM
	6Xfu4olDSGUuwr9d7AlnZW3+vZe9UBbu6teynOv2ZRzWuRTop1NoEdf7lcoA37sR9JuFmk
	Id+2AB4t5C/g+pCeS8MwJN9Q3nZRDZk=
From: Sven Eckelmann <sven@narfation.org>
To: Matthias Schiffer <mschiffer@universe-factory.net>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH batadv 2/5] batman-adv: only create hardif while a netdev
 is part
 of a mesh
Date: Sun, 10 May 2026 15:59:34 +0200
Message-ID: <12908485.O9o76ZdvQC@sven-desktop>
In-Reply-To: <6005840.1IzOArtZ34@sven-desktop>
References: 
 <0b26554afea5203820faef1dfb498af7533a9b5d.1747687504.git.mschiffer@universe-factory.net>
 <e311c7d643fa1a7d13f2b518f6ee525eb6711f6c.1747687504.git.mschiffer@universe-factory.net>
 <6005840.1IzOArtZ34@sven-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6009324.DvuYhMxLoT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: 6WTXHTBFST6VITXYFQ2CK4Z6YFNV64NZ
X-Message-ID-Hash: 6WTXHTBFST6VITXYFQ2CK4Z6YFNV64NZ
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/6WTXHTBFST6VITXYFQ2CK4Z6YFNV64NZ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart6009324.DvuYhMxLoT
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Matthias Schiffer <mschiffer@universe-factory.net>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Date: Sun, 10 May 2026 15:59:34 +0200
Message-ID: <12908485.O9o76ZdvQC@sven-desktop>
In-Reply-To: <6005840.1IzOArtZ34@sven-desktop>
MIME-Version: 1.0

T24gU2F0dXJkYXksIDMxIE1heSAyMDI1IDExOjUyOjEyIENFU1QgU3ZlbiBFY2tlbG1hbm4gd3Jv
dGU6Cj4gT24gTW9uZGF5LCAxOSBNYXkgMjAyNSAyMjo0NjoyOSBDRVNUIE1hdHRoaWFzIFNjaGlm
ZmVyIHdyb3RlOgo+ID4gLWludCBiYXRhZHZfaGFyZGlmX2VuYWJsZV9pbnRlcmZhY2Uoc3RydWN0
IGJhdGFkdl9oYXJkX2lmYWNlICpoYXJkX2lmYWNlLAo+ID4gK2ludCBiYXRhZHZfaGFyZGlmX2Vu
YWJsZV9pbnRlcmZhY2Uoc3RydWN0IG5ldF9kZXZpY2UgKm5ldF9kZXYsCj4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBuZXRfZGV2aWNlICptZXNoX2lmYWNlKQo+
ID4gIHsKPiBbLi4uLl0KPiA+ICsgICAgICAgaGFyZF9pZmFjZS0+d2lmaV9mbGFncyA9IGJhdGFk
dl93aWZpX2ZsYWdzX2V2YWx1YXRlKG5ldF9kZXYpOwo+IAo+IE1vdmluZyB0aGlzIGhlcmUgc2hv
dWxkIGJyZWFrIHRoZSBXSUZJIFRUIGZsYWcgaW4gc2NlbmFyaW9zIGxpa2UgdGhpczoKPiAKPiAg
ICAgICAgICAgICAgICAgICAg4pSM4pSA4pSA4pSA4pSA4pSA4pSA4pSQICAgICAgICAgICAgIAo+
ICAgICAgICDilIzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilLxici1sYW7ilJzi
lIDilIDilIDilIDilIDilIDilJAgICAgICAKPiAgICAgICAg4pSCICAgICAgICAgICDilJTilIDi
lIDilIDilIDilIDilIDilJggICAgICDilIIgICAgICAKPiAgICAgICAg4pSCICAgICAgICAgICAg
ICAgICAgICAgICAgIOKUgiAgICAgIAo+ICAgICAgICDilIIgICAgICAgICAgICAgICAgICAgICAg
ICAg4pSCICAgICAgCj4gICAgICDilIzilIDilrzilIDilJAgICAgICAgICAgICAgICAgICAgIOKU
jOKUgOKUgOKWvOKUgOKUkCAgICAKPiAgICAgIOKUgmFwMOKUgiAgICAgICAgICAgICAgICAgICAg
4pSCYmF0MOKUgiAgICAKPiAgICAgIOKUlOKUgOKUgOKUgOKUmCAgICAgICAgICAgICAgICAgICAg
4pSU4pSA4pSA4pSs4pSA4pSYICAgIAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IOKUgiAgICAgIAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIOKUgiAgICAgIAo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIOKUjOKUgOKUgOKWvOKUgOKUgOKUkCAgIAo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIOKUgm1lc2gw4pSCICAgCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAg4pSU4pSA4pSA4pSA4pSA4pSA4pSYICAgCj4gCj4gCj4gYXAw
IGlzIG5vdCB0aGUgbG93ZXIgaW50ZXJmYWNlIG9mIGFueSBiYXRhZHYgbWVzaCBpbnRlcmZhY2Ug
YnV0IFRUIGFwIAo+IGlzb2xhdGlvbiBpcyBkZXBlbmRpbmcgb24gdGhlIGluZm9ybWF0aW9uIHN0
b3JlZCBmb3IgdGhpcyBoYXJkaWYuIFNlZToKCkkgaGF2ZSBub3cgcG9zdGVkIApodHRwczovL3Bh
dGNod29yay5vcGVuLW1lc2gub3JnL3Byb2plY3QvYi5hLnQubS5hLm4uL3BhdGNoLzIwMjYwNTEw
LWhhcmRpZi13aWZpLWNhY2hlLXYxLTEtNmRjZTVlZTZiMGY5QG5hcmZhdGlvbi5vcmcvCnRvIHNl
cGFyYXRlIHRoZSB3aWZpIGZsYWdzIGZyb20gdGhlIGNvZGUgKGFyb3VuZCBiYXRhZHZfaGFyZGlm
KSB3aGljaCB5b3UgCnRyeSB0byBtb2RpZnkuCgpSZWdhcmRzLAoJU3Zlbg==


--nextPart6009324.DvuYhMxLoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCagCPRgAKCRBND3cr0xT1
y46sAQD3azTP2Zt3AIXcte4zCOa8HZ9gfCHylcX1KiI3zGR7lwD+PKHNKb8DZv8h
0yE/8Hj074yAJY8HmjkjX3YtFVpszAM=
=HFr4
-----END PGP SIGNATURE-----

--nextPart6009324.DvuYhMxLoT--



