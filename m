Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D97A5CD6E45
	for <batman-adv@archiver.kernel.org>; Fri, 29 May 2026 07:07:46 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1963183ECD
	for <batman-adv@archiver.kernel.org>; Fri, 29 May 2026 09:07:45 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780038465;
 b=QM6IYbdqS4IuMd/tnKKlWFGuu/9F6CQG7FLn8936AmCdeKUzsmF8fOpwaXj2krM45C4g5
 1uXirQcQzKqt5krSGLG/9mW3ELYec4VkWJlGbBA8vwMSmDcSX8QsN2oGK3tshxfZvOiKCPp
 fP7YpGm4fQZ9xkp8jcP41hmECOAMjXU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780038465; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=iuyGubf2/NYJK3ycC+f5/Zj97zRD1Z6XF2ZBowjdOAI=;
 b=n74DKLsKAkCqM1fcxNkFMnaNVyHsQzkMyPxB1AXQ7XkXrvliOmvlt0aOuVk7C/g+5OwVL
 OWO15wo3XHey32CDSfTamWcXAvTaHYw+Bdg8vzgGfrv+kmEPBjR599BNVwdvEcclo/cE4Vl
 1ptPuB1gUhD9Ln4mmQ66QXrHbBqWrsg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 469C480B6E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 29 May 2026 09:07:04 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780038434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=iuyGubf2/NYJK3ycC+f5/Zj97zRD1Z6XF2ZBowjdOAI=;
	b=V/kVHWeB7SlUU/s5RH0mV/MRiLBFD0QOYU5znWDlKQwhcHLEIvjGGxFg8y8xc47q8lde/t
	+EWmZFRzUnJ2JnGwb9Fa9X+tXha1EK15VL9lOszktopi8KV848obY/yRaqsmaLNUo51lwV
	FV/W3Nvh+ZUbGnIZItdkfXoSdUCOsPk=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780038434;
	b=NsXbb+ukKmhweJo424I0k9DIUZNNoLiN299XjtS1PJvthApItrP0zqb3APzNqxRh0jMo/l
	vXJOcjsF5INZwNqmFMtg8x6FjzGudO+VvAnl0Bv5c+c6HNM1C9wa+hkpsNoXy8TnLSCtg9
	fJfH3cReWYVYdMRAAzMU2nRQruzLjoU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=Cqm1KyfG;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 53DF920039;
	Fri, 29 May 2026 07:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780038422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iuyGubf2/NYJK3ycC+f5/Zj97zRD1Z6XF2ZBowjdOAI=;
	b=Cqm1KyfGBuB4o/OZX1THF9NPlPy+ckEnjk2RPGJId14f0n/b5yUqPg+jHNiNNOnlWkf/o1
	jvpvLfDofkARW7HYKfEpV9H2FdhcLV3535+JLpx3EKlELJ6LqGSWEyxIu+NW+wCOk6JaQ8
	tOKVf+096fvPpCuPSE9XUEZMhMi0yms=
From: Sven Eckelmann <sven@narfation.org>
To: Simon Wunderlich <sw@simonwunderlich.de>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH net-next 01/15] batman-adv: drop batman-adv specific
 version
Date: Fri, 29 May 2026 09:06:56 +0200
Message-ID: <5075322.GXAFRqVoOG@ripper>
In-Reply-To: <20260528171412.7a60e8f7@kernel.org>
References: <20260528142924.329658-1-sw@simonwunderlich.de>
 <20260528142924.329658-2-sw@simonwunderlich.de>
 <20260528171412.7a60e8f7@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1957926.tdWV9SEqCh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: TWJFIUFPLLSVVUF2UQLBVY6HB6CLDCKB
X-Message-ID-Hash: TWJFIUFPLLSVVUF2UQLBVY6HB6CLDCKB
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/TWJFIUFPLLSVVUF2UQLBVY6HB6CLDCKB/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart1957926.tdWV9SEqCh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 May 2026 09:06:56 +0200
Message-ID: <5075322.GXAFRqVoOG@ripper>
In-Reply-To: <20260528171412.7a60e8f7@kernel.org>
MIME-Version: 1.0

On Friday, 29 May 2026 02:14:12 CEST Jakub Kicinski wrote:
> On Thu, 28 May 2026 16:29:10 +0200 Simon Wunderlich wrote:
> > +#define BATADV_SOURCE_VERSION "linux-" UTS_RELEASE
> 
> What purpose that does "linux-" prefix serve?
> The unwritten rule is that the OOT drivers have to append something 
> to their version to distinguish themselves. In-tree version is just
> the pure kernel version.

We don't have a real preference here. If you prefer UTS_RELEASE only then I 
get rid of BATADV_SOURCE_VERSION and just use it in both places in
version.c

https://git.open-mesh.org/batadv.git/commit/?id=8cc63db2462ad7d3ee213059025bf5fffe2e7982

> To be clear, definitely a move in the right direction. I hope we can
> move _all the way_ in the right direction, tho, without still defining
> OOT-feeling version.h file with a dedicated BATADV_SOURCE_VERSION

version.c and version.h are there to not recompile more parts of batman-adv 
than necessary when the linux kernel version changes. Has nothing to do
with OOT. If you consider this a no-go, I can also just place 
generated/utsrelease.h + UTS_RELEASE in the three different files.

Regards,
	Sven
--nextPart1957926.tdWV9SEqCh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCahk7EAAKCRBND3cr0xT1
y8BpAP9YDul7jL0bTPXj2bxk32/4QTLdSxErhd7Ivj5bCnIr2AEA7+zwi4YULFDh
yVRmS4hsFwvO4ggFawfGEkH9xbH7Fgg=
=BVcL
-----END PGP SIGNATURE-----

--nextPart1957926.tdWV9SEqCh--



