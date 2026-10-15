Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E46CC6B34
	for <batman@archiver.kernel.org>; Thu, 15 Oct 2026 07:26:51 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7D963845BE
	for <batman@archiver.kernel.org>; Thu, 15 Oct 2026 09:26:49 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1792049209;
 b=T/WUlkt+7vhV4uS1oJMGG7AXeGYFYgP+bPuW7/Pnzf9ybZREKIXB376LqZ7uaSeBYUVqW
 doNb/XNP2p7KCKLaxKAWqCI7UENI9A55eZXUuB5Zgt+va3Z9UQJcdz7TsMnFALaYtaugVKe
 WN+KjoksEbRGHq5J65eXUUiF1kUD/xk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1792049209; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=TN6uZdGRKGVWFrEsy6l6MYYhi5HZ2pwfzYoo6AoX+F0=;
 b=zIY/QscsDxD/zCW/2Q4yuBI1B7h/SbJCH5jQy9qH7CDTPx1q0mHPiP7HRFLuRKDHUCyId
 4wVh4XdO83jecZ8f6C0aynT13c3o0yM9FqeEC+eiBoosj58nGAWfy+zyOdbrdo6vw3F9JxT
 U3fsxoYYtfIM6U/QqkzBYX9uZSk+KiQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id A6CB8811E0
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 15 Oct 2026 09:26:31 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1792049201;
	b=gnhmpj2K4fValmOSVwXRBvtKTN/LhpEAljKAJ82b/xYVkYSd4hBhSoGhnAXBlV4nwR97WR
	9fDzC2BN42xQiHXqPMzokskcIM6havrS7Sbx4AmOtsC7HPpcek/ti9QD+RFsnoDMKFAwli
	PBhM29VO1JjeZlQ91ADRsw1GN5NWBSM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1792049201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=TN6uZdGRKGVWFrEsy6l6MYYhi5HZ2pwfzYoo6AoX+F0=;
	b=HFHqWybljl6knVN7Y1ZzVCHPqXAiAk4ayOaNkQ9LekzYhW0oE0xWrp13xoELNhMv6ySjuG
	Dj9SkN7OBimV+7FtfuLDh7vh81QbU1YbC1ONMv4wZkHJl1L81wzyOp+4LdmYG/GZbypDti
	6k/9gOqflEKDZ02USsfD+kvcaFHUAK8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=WJgfuSwx;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 8B71C202BE;
	Thu, 15 Oct 2026 07:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1792049190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TN6uZdGRKGVWFrEsy6l6MYYhi5HZ2pwfzYoo6AoX+F0=;
	b=WJgfuSwxfpXg83wPYhN1wgMro5iqW+xPOBHJbPXj2mUkZthrjofnjwIQ/KP6Geo54xqwkO
	H8ECxN38/+qM8+VxP6w5//INunmqvI0D6L+PWP41WFiyRHnjgMaD0IUG5sVBfiTWjrHlFY
	KMrpCOf5JRJhcWitSEoWM7DA0e3lud8=
From: Sven Eckelmann <sven@narfation.org>
To: sashiko-reviews@lists.linux.dev
Cc: marek.lindner@mailbox.org, sw@simonwunderlich.de, antonio@mandelbit.com,
 b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH batadv] batman-adv: mark functions inheriting critical
 sections
Date: Thu, 15 Oct 2026 09:26:21 +0200
Message-ID: <2860295.mvXUDI8C0e@sven-desktop>
In-Reply-To: <sashiko-outbox-172395@kernel.org>
References: <20261015-must_hold-v1-1-7ddbb82da7c3@narfation.org>
 <sashiko-outbox-172395@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12997114.O9o76ZdvQC";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: LDQB5UUAHY2ENL5TMITLMD2I5ZBBVT4Q
X-Message-ID-Hash: LDQB5UUAHY2ENL5TMITLMD2I5ZBBVT4Q
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/LDQB5UUAHY2ENL5TMITLMD2I5ZBBVT4Q/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart12997114.O9o76ZdvQC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: sashiko-reviews@lists.linux.dev
Date: Thu, 15 Oct 2026 09:26:21 +0200
Message-ID: <2860295.mvXUDI8C0e@sven-desktop>
In-Reply-To: <sashiko-outbox-172395@kernel.org>
MIME-Version: 1.0

On Thursday, 15 October 2026 09:22:30 CEST sashiko-bot@kernel.org wrote:
[...]
> [Severity: Low]
> Does adding this capability annotation break the type signature when passed
> as a function pointer?
> 
> In net/batman-adv/originator.c, batadv_frag_check_entry() is passed as the
> check_cb argument to batadv_frag_purge_orig():
> 
> 			batadv_frag_purge_orig(orig_node,
> 					       batadv_frag_check_entry);
> 
> Because the check_cb function pointer definition lacks the corresponding
> capability annotation, this creates a capability type mismatch that leads to
> a static analysis warning or error during context analysis.

No, it doesn't in my tests.

> 
> [ ... ]
> 
> > diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
> > index 22dd28d5e1abc..6ebab4eb1382e 100644
> > --- a/net/batman-adv/multicast.c
> > +++ b/net/batman-adv/multicast.c
> > @@ -683,6 +685,7 @@ static void batadv_mcast_mla_list_free(struct hlist_head *mcast_list)
> >   */
> >  static void batadv_mcast_mla_tt_retract(struct batadv_priv *bat_priv,
> >  					struct hlist_head *mcast_list)
> > +	__must_hold(&bat_priv->mcast.mla_lock)
> >  {
> 
> [Severity: Low]
> Is it possible this annotation is violated during teardown?
> 
> In batadv_mcast_free(), the code intentionally skips acquiring mla_lock
> because it relies on implicit serialization after the worker is canceled:
> 
> 	/* safely calling outside of worker, as worker was canceled above */
> 	batadv_mcast_mla_tt_retract(bat_priv, NULL);
> 
> However, batadv_mcast_mla_tt_retract() is now strictly annotated to require
> the lock, which will cause a build warning or error when compiled with
> CONFIG_WARN_CONTEXT_ANALYSIS=y. Is this one of the corner cases preventing
> the enablement of CONTEXT_ANALYSIS := y?

Yes, it is one one of the corner cases.

Regards,
	Sven
--nextPart12997114.O9o76ZdvQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCatCAHQAKCRBND3cr0xT1
y1M8AP4n6111DlJJ9v+mJgG3cwaBxuXBa+LmaXHLhR4K+/G96gD+P+jdBqNLmP3z
+JCcHsD7/WLhNPamUAmCmX20wvJKvgY=
=S1ns
-----END PGP SIGNATURE-----

--nextPart12997114.O9o76ZdvQC--



