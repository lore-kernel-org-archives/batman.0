Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45D6E77197
	for <batman@archiver.kernel.org>; Sun,  5 Jan 2025 08:47:26 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 20A37840FC
	for <batman@archiver.kernel.org>; Sun,  5 Jan 2025 09:47:25 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1736066845;
 b=T6D1rvSGudlaYKX9Nyai863jzqmtcvcsGokeNdHv8e9arZWWkJPaXfYCjJhLUffi3LZLb
 hI4+rzLFeM1nhQwXuaT1l1KMM+pm8xj68xR/eevEgM8AixgK+AEHofujAQJvrxuFu/SFWXQ
 Um8GYLG3zQF5kYsDFDFdU2yHFaxSmOk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1736066845; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=aPQo+VVn8UciPjFOMjjIqVGo/afzi9PqNNggnfkoSXg=;
 b=wsUsJbG2t92+PWEjCbKN7coB95IL3G+GYXweJuo40lTQiAa9IUlME5iACD3HSnXpxAvJ5
 LaJOHqVGHUR3UbfXtLcjg/qogzp/qUQql9wbyEYpDcXdpD4BOVbzQsGcg2Qft0qG0VBDvNe
 Fqwd6a4TnrNWNCkaiQDJPoLmkc7AkAw=
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
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 5906782593
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun,  5 Jan 2025 09:47:10 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1736066830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=aPQo+VVn8UciPjFOMjjIqVGo/afzi9PqNNggnfkoSXg=;
	b=Wx+sEsexQ7Ah+Uggcyw63/Okm9Qat568gQMoFGnu3r/6Uk0oA8aSSTUzp8L2n52IVk4nN0
	FEGV5NquJImKimDiq1jlmbzAh7n1hPxe+EGay0DjyvTje1bLUOS0yNk/wOFBLd6xC+cX0S
	LRPDJV49lHJG0mwJ6hmnthpkgbn6ML8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=Ep0+BYiJ;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1736066830; a=rsa-sha256;
	cv=none;
	b=VKm0V9N2veTZnfORQ0zo2kx2q0PqEK41naRQq8yZrXY88Q0PIoGveTwn5b2NuNQCrqeGwX
	yCDKGgYLJLXMSAzv30fLnUNWgJ2YNRknNASN7w1lv8DbgGDR2q5odcG2gfFwsEKg43OqzJ
	63AmDgqp6bQfS88C4NgwCRv+ooZu6zo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1736066829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aPQo+VVn8UciPjFOMjjIqVGo/afzi9PqNNggnfkoSXg=;
	b=Ep0+BYiJuwKGDWjrTdC23OJwBhiM+zFjeDTTKj4S/Eul8kP6dnQjEiWT5ychVXjc4xtPlB
	kWAxgt/Sd79SnKvUuKUViYhdzdG+aoERvyRJYajfJwk4r37ywLH6/ydF8VJItA4BlBENJm
	I6+UtSJf3FhhXPayZAzUwPI0FwjLuFY=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Noah Peterson <NoahBPeterson1997@gmail.com>
Subject: 
 Re: [PATCH v5 1/1] batctl: ping: Add subsecond precision to ping interval
Date: Sun, 05 Jan 2025 09:47:06 +0100
Message-ID: <24705456.ouqheUzb2q@sven-l14>
In-Reply-To: <20250105000908.66343-2-NoahBPeterson1997@gmail.com>
References: 
 <20250105000908.66343-1-NoahBPeterson1997@gmail.com>
 <20250105000908.66343-2-NoahBPeterson1997@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2386571.KlZ2vcFHjT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: NORUYMYSLW24JGHQFDDEWGLECB2ACPOD
X-Message-ID-Hash: NORUYMYSLW24JGHQFDDEWGLECB2ACPOD
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/NORUYMYSLW24JGHQFDDEWGLECB2ACPOD/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart2386571.KlZ2vcFHjT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Noah Peterson <NoahBPeterson1997@gmail.com>
Date: Sun, 05 Jan 2025 09:47:06 +0100
Message-ID: <24705456.ouqheUzb2q@sven-l14>
In-Reply-To: <20250105000908.66343-2-NoahBPeterson1997@gmail.com>
MIME-Version: 1.0

On Sunday, 5 January 2025 01:09:08 GMT+1 Noah Peterson wrote:
> +                       errno = 0;
> +                       ping_interval = strtod(optarg, &end);
> +                       if (errno) {

You forgot to do anything with the end(ptr).

Btw. end is a bad choice for the name because it shadows the global variable 
for "the first address past the end of the uninitialized data segment (also 
known as the BSS segment)".


I will now change the patch myself because this amount of ping-pong for such a 
trivial patch is wasting everyones time and should be unnecessary. Please try 
to focus and recheck things before you submit your patches.

Kind regards,
	Sven
--nextPart2386571.KlZ2vcFHjT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZ3pHCgAKCRBND3cr0xT1
y0+pAP42+SRjs18StU4g3vOIhvozMcOdAley3/vqOTW6Ui3z9QEArZnGynNhQ6do
sYWOgqNAnyqy2eQFYsa3H5x504L/6AA=
=dPqB
-----END PGP SIGNATURE-----

--nextPart2386571.KlZ2vcFHjT--



