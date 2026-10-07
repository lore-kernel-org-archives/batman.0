Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F40A6CA5FFC
	for <batman@archiver.kernel.org>; Wed,  7 Oct 2026 10:46:56 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 54C538065C
	for <batman@archiver.kernel.org>; Wed, 07 Oct 2026 12:46:55 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791370015;
 b=NiMEH+x5daLvdxcmUk/IEX9e4VFEBE4K9bqnfx0ExnQo77NlQX5mYgUSgtShg3Zni+64B
 V7NqHIJRkzid7TaCwMKGCZY2ylOeLvfkxVbN5+AEmlPpgVSO32v9fbBXpd828HoM5a+7ng/
 PeqwwwKXMFGmlZbV4Xe761VEHJ8dIxI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791370015; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=+OJOFHO3tmDnEtxIlyLIw2A54oOlGQF58AaWUotmZP8=;
 b=Wk/l9T2c/yHbLNSI+brWcLeAiYWlWDMh+Zag3rcmcvJ2OhHSDZREkOzzSPE9rhoBFkjZ2
 Z36Zp4wbuSdujO2JWHNjQTUUzCdpRfXi+vc8vJiIhACnDDK0M4wo+QOuZ61Lhd112OpFZfg
 HnmEAaJA+n6jjIUwda0A6dZ84Zlq1So=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 09DF780F86
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 07 Oct 2026 12:46:35 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791370006;
	b=VPPJphMhMHN5/Cr4qV/thpGDEU6fflg9d6mJgMmFscTx3a/DbLKb1GkmahwHnfNwd4kjPr
	LeVEGz39RSl7GvLFk/fFaTuyKHQPStGIznzrByo8wr+rHJpZOGh89zMYnJVrb09ZxDGB6T
	Ow8xo44EnkuC2/MHKbZGmar0zJ9biZE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791370006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=+OJOFHO3tmDnEtxIlyLIw2A54oOlGQF58AaWUotmZP8=;
	b=R+xgNJm5pHq/88wGz8tRhwwCVxonkllxxfusG60iTToJZgTDkB+MWoyNDBPZLrgta/QMYR
	QaYj6JWV3puhT+M7TBGKjo6u+pYEIJm3y/tFmKMKyXFbticIAxPxVqrfJwzxwxMjPkkiKc
	xJwHTFPXOZfvvESwd88dgC3Iglgln1A=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=VvvaoVS9;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 0C19E1FD51;
	Wed, 07 Oct 2026 10:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791369994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+OJOFHO3tmDnEtxIlyLIw2A54oOlGQF58AaWUotmZP8=;
	b=VvvaoVS9zm7fUog9ifvn0dH5AI6sONP+cUkHJ2VO12wXbIxtjC3JK+kx5rKPUCnbbp3IPM
	wAehwrN6/EdzkOOkfGv8V5/1bYWdbzjy2rldf5DTHWFoXbM3cRJor6KeV4uR5tZ6AUTcRe
	VD1f9AyF1Sf9Ul0hkE4Smx8T1xfFo0w=
From: Sven Eckelmann <sven@narfation.org>
To: antonio@mandelbit.com
Cc: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH batadv 2/4] batman-adv: tt: only update flags for TT
 events
Date: Wed, 07 Oct 2026 12:46:31 +0200
Message-ID: <2046633.tdWV9SEqCh@sven-desktop>
In-Reply-To: 
 <20261007-tt-avoid-unhashed-event-v1-2-01c763657916@narfation.org>
References: <20261007-tt-avoid-unhashed-event-v1-0-01c763657916@narfation.org>
 <20261007-tt-avoid-unhashed-event-v1-2-01c763657916@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2356456.irdbgypaU6";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: GXQ253CFPEFSNML5J5BJPV333DK3SBCQ
X-Message-ID-Hash: GXQ253CFPEFSNML5J5BJPV333DK3SBCQ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/GXQ253CFPEFSNML5J5BJPV333DK3SBCQ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart2356456.irdbgypaU6
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: antonio@mandelbit.com
Cc: b.a.t.m.a.n@lists.open-mesh.org
Date: Wed, 07 Oct 2026 12:46:31 +0200
Message-ID: <2046633.tdWV9SEqCh@sven-desktop>
MIME-Version: 1.0

On Wednesday, 7 October 2026 12:29:46 CEST Sven Eckelmann wrote:
> -               if (announce)
> -                       __batadv_tt_local_event(bat_priv, common,
> -                                               common->flags);
> +               /* BATADV_TT_CLIENT_ROAM can still be set (see above) when a
> +                * client which roamed away was re-added. It must not be
> +                * announced with an ADD because the other nodes would then
> +                * handle it as still roaming.
> +                */
> +               if (announce) {
> +                       event_flags = common->flags & ~BATADV_TT_CLIENT_ROAM;
> +                       __batadv_tt_local_event(bat_priv, common, event_flags);
> +               }

Antonio, this is rather awkward. It is caused by basically the return in 
following code:

		if (common->flags & BATADV_TT_CLIENT_PENDING) {
			batadv_dbg(BATADV_DBG_TT, bat_priv,
				   "Re-adding pending client %pM (vid: %d)\n",
				   common->addr, batadv_print_vid(common->vid));
			/* whatever the reason why the PENDING flag was set,
			 * this is a client which was enqueued to be removed in
			 * this orig_interval. Since it popped up again, the
			 * flag can be reset like it was never enqueued
			 */
			common->flags &= ~BATADV_TT_CLIENT_PENDING;

			return true;
		}

		if (common->flags & BATADV_TT_CLIENT_ROAM) {
			batadv_dbg(BATADV_DBG_TT, bat_priv,
				   "Roaming client %pM (vid: %d) came back to its original location\n",
				   common->addr, batadv_print_vid(common->vid));
			/* the ROAM flag is set because this client roamed away
			 * and the node got a roaming_advertisement message. Now
			 * that the client popped up again at its original
			 * location such flag can be unset
			 */
			common->flags &= ~BATADV_TT_CLIENT_ROAM;
			*roamed_back = true;
		}


I know, when you introduced the BATADV_TT_CLIENT_ROAM check in commit 
2443ba383c7d ("batman-adv: roaming handling mechanism redesign"), it was still 
a `goto add_orig_entry;`. But the behavior was the same: two packets are 
necessary to switch a BATADV_TT_CLIENT_PENDING|BATADV_TT_CLIENT_ROAM client 
back to having none of the two flags.

Why is this the case?

Regards,
	Sven
--nextPart2356456.irdbgypaU6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCasYjBwAKCRBND3cr0xT1
y6tVAP9LU8PHRFn7v10en8l76U6xbBBs449KMNg4TEDNrrXxTgD/Sfks/zSBGK90
NkavFmqWvv4E4iHRqFSI8ty2j2aYeg0=
=CciQ
-----END PGP SIGNATURE-----

--nextPart2356456.irdbgypaU6--



