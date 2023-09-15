Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 704ABC46CA1
	for <batman@archiver.kernel.org>; Fri, 15 Sep 2023 20:13:55 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 36C54832CE
	for <batman@archiver.kernel.org>; Fri, 15 Sep 2023 22:13:54 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1694808834;
 b=vmUKenhEiq3Ofel/3YXuJ2qC00dgzYq/teUmDMmNYESGAmlACnq2zxnAVwsmyGUav8R3c
 OhDoGfsfDUpilnO/EkJgDEwblwJIn3OVwSKirOyjScd9kN+6cE2kp2Evp0IikB0/aID8VOW
 fd6jVuEY53HYOBcvSykWSXHRM1+y23o=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1694808834; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=7C/EY/MYX0La7ZZmXGZHdEP5K1a3AaFah1xUgy48dfA=;
 b=k+OzWKnz6j6hb3dRH9EpzUG7fUohSJJj4C+ZBoPWb+cVV2dPeeMvrbwHO/8xZYwqWDNJP
 7lm2J+01X4x58LiPqPvJ1oHlBHG8h1nqMsCxn9s+vcPtvTy+aFQB326daHyRMtlQM7oYHqV
 cOLE6MlfOe3cFNzqr9z6smtqwVyY41E=
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
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 4D16980BD0
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 15 Sep 2023 22:13:37 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1694808817; a=rsa-sha256;
	cv=none;
	b=i2oMQd4xg8bK6knPGlRHVG1vHlI4pgKiCEtkAJdDrWFVwuUJeylNCkwLiOSdaS5AKrDsSh
	nrjpL7F7TnLNS13hNHM04yasb4OvTBT0u8au3eYV5WtJeAGUnLdYHYnEvfig/DNZYvqLxS
	Y7sEgJTl4JYQlNAYvSMCDUbZ6tJSZ8I=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=L4081Lo+;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1694808817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=7C/EY/MYX0La7ZZmXGZHdEP5K1a3AaFah1xUgy48dfA=;
	b=YLOVZWDWnYOGJmIWCG+Psm6FJy9f5WzndhYQp0f32xMVqoT081Bqgeq3eomc2ej7Fv/rU4
	i9ZSWTYZSGUXqRj1MK8QjhL7YxcR4gNshiwDQtJbAzXPhJhl3YNu54Oqksdtj3+kGIliVK
	3nM2En4joI0skok1ETJKE27SUukdD/4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1694808816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7C/EY/MYX0La7ZZmXGZHdEP5K1a3AaFah1xUgy48dfA=;
	b=L4081Lo+TxKCVWdTNnO6sf+6cG7rqsuRpzjx0QEO1J/lAAk8p9Y3uZWTJBP0FITVdJz4N2
	xkrKtOUXEBsxOWwQas9jnENZPD1omXYDn4H8vTc4Hs7lEtrASMu66O9f/gc/DvcGrJpZN1
	JgTs7qrJEIZP8KQ++3s5/0g8JzAfEK8=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: Fwd: Possibility of dual-licensing to ease bringing into FreeBSD
Date: Fri, 15 Sep 2023 22:13:34 +0200
Message-ID: <2321546.ElGaqSPkdT@sven-l14>
In-Reply-To: 
 <CAN8-kNWFXhFzeu0fcKg115VHHj_qLoL-GEroBRqSroHY65EMSw@mail.gmail.com>
References: 
 <CAN8-kNUktsXSTnG2jA51h3piRxf8-a-JJBGtPF8uJdEWXspm1w@mail.gmail.com>
 <CAN8-kNWFXhFzeu0fcKg115VHHj_qLoL-GEroBRqSroHY65EMSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4856680.GXAFRqVoOG";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: 5FZCZFEOZ2LHX7RVYF2AF6Y7IBKE2ZFU
X-Message-ID-Hash: 5FZCZFEOZ2LHX7RVYF2AF6Y7IBKE2ZFU
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: obiwac <obiwac@gmail.com>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/5FZCZFEOZ2LHX7RVYF2AF6Y7IBKE2ZFU/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart4856680.GXAFRqVoOG
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: obiwac <obiwac@gmail.com>
Date: Fri, 15 Sep 2023 22:13:34 +0200
Message-ID: <2321546.ElGaqSPkdT@sven-l14>
MIME-Version: 1.0

On Friday, 15 September 2023 16:11:44 CEST obiwac wrote:
> Would it be possible to
> dual-license batman-adv to GPL/BSD

This is not really likely. There is not a single entity which can re-licens=
e=20
the code - instead there are nearly 120 authors recorded in the repository=
=20
which have some saying over their contribution. There can be even more=20
copyright holders which weren't recorded correctly (especially in the early=
=20
days).

Akinobu Mita
Al Viro
Alexey Dobriyan
Alexey Fisher
Anders Roxell
Andrea Gelmini
Andrea Ghittino
Andreas Langer
Andreas Pape
Andrew Lunn
Andr=C3=A9 Gaul
Andy Shevchenko
Antonio Quartulli
Arnd Bergmann
Ben Hutchings
Chris Lang
Christophe JAILLET
Colin Ian King
Cong Wang
Dan Carpenter
Daniel Seither
Daniele Furlan
Danny Kukawka
David Ahern
David Decotigny
David Howells
David S. Miller
Def
Denys Vlasenko
Ding Tianhong
Eric Dumazet
Eric W. Biederman
=46elix Fietkau
=46engguang Wu
=46lorian Westphal
Gao Feng
Geliang Tang
George Spelvin
Greg Kroah-Hartman
Gustavo A. R. Silva
Himangi Saraogi
Jakub Kicinski
Jason A. Donenfeld
Javier Martinez Canillas
Jean Delvare
Jean Sacren
Jeremy Sowden
Jesper Juhl
Jiri Pirko
Joe Perches
Johannes Berg
Jonathan Corbet
Julia Lawall
Jussi Kivilinna
Kees Cook
Ken Helias
Kirill Smelkov
Krzysztof Kozlowski
Kyungrok Chung
Leon Romanovsky
Linus L=C3=BCssing
Linus Torvalds
Luc Van Oostenryck
Lucas De Marchi
Luis de Bethencourt
Marek Lindner
Markus Elfring
Markus Pargmann
Martin Hundeb=C3=B8ll
Martin Weinelt
Masahiro Yamada
Mathieu Desnoyers
Matthias Schiffer
Micha=C5=82 Miros=C5=82aw
Minghao Chi
Nicolas Dichtel
Nikolay Aleksandrov
Octavian Purdila
Pankaj Bharadiya
Patrick McHardy
Pau Koning
Paul E. McKenney
Paul Kot
Pavel Skripkin
Phil Sutter
Randy Dunlap
Rasmus Villemoes
Remi Pommarel
Ren=C3=A9 Treffer
Ruben Wisniewski
Sasha Levin
Scott Raynel
Sebastian Andrzej Siewior
Shan Wei
Shaokun Zhang
Shigeru Yoshida
Simon Wunderlich
Stephen Hemminger
Steven Rostedt (Google)
Sven Eckelmann
Sven-Thorsten Dietrich
Sylvestre Ledru
Taehee Yoo
Tejun Heo
Tetsuo Handa
Tobias Klauser
Tom Gundersen
Tracey Dent
Vasiliy Kulikov
Vladimir Oltean
Vladislav Efanov
Wilfried Klaebe
Xiyu Yang
Yajun Deng
Ying Xue
Yu Zhe
YueHaibing
Zheng Yongjun

And I don't want to start now any discussion about per country rules regard=
ing=20
copyright and copyrightable work. Just wanted to point out that it is not a=
s=20
simple.

Kind regards,
	Sven
--nextPart4856680.GXAFRqVoOG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmUEuu4ACgkQXYcKB8Em
e0ZB7BAA04s5cOdr9w8qau0L67cuKwkp6TFD6tENBGe9U2CdYVvb8zvc3Ah8avt1
6ZhGRDQqein2Vsld17TeeghEqn3sl1fHi9SFQLlVF4cxERhvLrd3eHIT9quKptrT
f4ghhXAcTT2UGL6MksfHm6CqO5SBq72i+1nVi1Db8ov6Pm7GqWj5YUb6oTvKRgMp
I7bnXIPAMyJCsMebITeqQu/0CERK3TCP5nG+HrYBpekFHSxfAMGVp8Erzp7NZy0o
AlxOITNfnnXadHN0BF6wW0Rbhfs7TPQXqH/TYZRnRKKPZfoxO8avBLBEPDedA8xq
GVubZCLKYOKiCnSBg9c3VjfFMdHF2jYv7ATG4XRRnk0LI21Ge0/pTpbi3ad23WKj
AdFmukJCDJ8bmp55iMhGSD3Wwp1mhVVsyPBfO7IVo5WidsftP3RjCJ7Z0nFfvi4e
CMRWJM2dsp+ZQSMMt61RBPgHwlHsnak8eY4K0UGuSqSvhnTHev49RNSFilE2njkN
vH6iRRpLxkMXRyoq11lDVsx0Ky/nbDqKJasDXrLfsLYXdmo4cnT0EMXSCC+uGwYs
GJm4iMhbYvdFD+CKPEvYqMEVcpFfy3z7KZq07D1YU7gngDQ0VUIPf7eUYUY5QCNu
daFvxIyDpIBNX+zvmBUzawXnSBaM+aN2pCKIPdQS7DCITtjYwyI=
=i4U9
-----END PGP SIGNATURE-----

--nextPart4856680.GXAFRqVoOG--



