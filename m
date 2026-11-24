Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C2D606A321
	for <batman@archiver.kernel.org>; Tue, 24 Nov 2026 19:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=qN1cYuK4
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 67B0583099
	for <batman@archiver.kernel.org>; Tue, 24 Nov 2026 20:30:51 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795548651;
 b=1t6oh1rzLtERJpjIaj0gBPWSmEpQ69XncNd0DP1Kz1Q1Lbit1RG09wgBrU2Vau7D/UeMY
 /QGbB/1mmPYIZ+pUoOE+JkCTIR7VL4io1ZfvzFkzb5O7LQAe8OLQCWDaD0EmEksmmQMITgt
 CDmKBppDT6hY9g8MiCnVjXHCQELXgMM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795548651; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=C6LFLahScyEdnHNyHIpJYyhDCb17bkz1JmKjMkFMMbg=;
 b=OgWitMDGWXA4EXIquc/oAW1Igwq86I3T3QwfXkxghmrP+ih4C5zqP38WAijUpcGRbqL5a
 DxC8oStIE/xXbKxfoPvsA7guQSyH/EgwMcIvwlT/1EwfO0VNmYDD3UT8x+Jdjisp7y6OoWW
 L5r13McTu3wVAXyuKpEXr4qiJHZLGFE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 11E2D808BC
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 24 Nov 2026 20:30:43 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795548644;
	b=peC9Yrvi1FxhL1x8RmBkePlhAT+gSb2Aah1T+uIQ/ogDul7zGB8l/5zw/nmkmDnD3IlVOv
	yPgNN72I2SlUCVXi/SnjYacT3vrsS460Chyyc4rEs1hhTPOpWvZpIS+b6dDKmRB8JBMkok
	hmMfB9Prhm0McB99XWZxaq4cL67oE1E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795548644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=C6LFLahScyEdnHNyHIpJYyhDCb17bkz1JmKjMkFMMbg=;
	b=n184ki+xyeIUGLVC/b7Hu/izhxAYuEesKYHR+oqn9MXQp7bcHugR+pHzEmlYiCmJIdtXVh
	eYgsYwzgBH9ov7i1Wa7Wd4Lw7M/hveUHK5S8HNZsJP0YBLoFyEJFdc3lNBr2Qf4/EzK1l7
	j3xMM4qXHXsuhG6o4SBMYEad7aXMVUY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=qN1cYuK4;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id C0FB4203E2;
	Tue, 24 Nov 2026 19:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1795548643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C6LFLahScyEdnHNyHIpJYyhDCb17bkz1JmKjMkFMMbg=;
	b=qN1cYuK498MOSJXUxYLSpZdQzxIJtE/3oMa8dgbowvVVdVJ+mWSBJ38hpTdCoCKLvKBREG
	a5WVQ6xhsfmmB6n7OZEbt79ZChCLpOIpYBZOjAdFAWAVAao9zql97BITbEfRYj2sx+QBdi
	QGMV0p9alIePFRA1EVW0LvY8HpQEMDI=
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de, netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH net-next 10/15] batman-adv: tt: keep local entry unchanged
 when
 ADD can't be queued
Date: Tue, 24 Nov 2026 20:30:40 +0100
Message-ID: <8764057.T7Z3S40VBb@sven-desktop>
In-Reply-To: <179554084314.3135.7493792255015362398@kernel.org>
References: <20261123171827.3294525-11-sw@simonwunderlich.de>
 <179554084314.3135.7493792255015362398@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart10953751.nUPlyArG6x";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: BMSBTTG3MHPIJWCCTVIDFOU5FKSHRTKM
X-Message-ID-Hash: BMSBTTG3MHPIJWCCTVIDFOU5FKSHRTKM
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BMSBTTG3MHPIJWCCTVIDFOU5FKSHRTKM/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--nextPart10953751.nUPlyArG6x
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de, netdev-bot+sashiko@kernel.org
Date: Tue, 24 Nov 2026 20:30:40 +0100
Message-ID: <8764057.T7Z3S40VBb@sven-desktop>
In-Reply-To: <179554084314.3135.7493792255015362398@kernel.org>
MIME-Version: 1.0

On Tuesday, 24 November 2026 18:20:43 CET netdev-bot+sashiko@kernel.org wrote:
> > diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
> > index 977f62c88da76..c94b292a1c4a8 100644
> > --- a/net/batman-adv/translation-table.c
> > +++ b/net/batman-adv/translation-table.c
> > @@ -653,10 +653,18 @@ static u16 batadv_tt_flags_get(struct batadv_tt_common_entry *common)
> >   * Only a single change per client is queued. It describes the latest state of
> >   * the client and a new event therefore replaces an already queued one.
> >   *
> > + * The other nodes only learn about the modification of a local entry through
> > + * the queued change. The caller must therefore not modify the entry in a way
> > + * which depends on this change (e.g. hash it as BATADV_TT_CLIENT_NEW or mark it
> > + * as BATADV_TT_CLIENT_PENDING) when the event could not be stored.
> > + *
> >   * The caller must hold the flags_lock of @common. The events of an entry are
> >   * then queued in the same order in which its flags were modified.
> > + *
> > + * Return: true if the event was stored, false if the memory for it could not
> > + * be allocated.
> >   */
> > -static void __batadv_tt_local_event(struct batadv_priv *bat_priv,
> > +static bool __batadv_tt_local_event(struct batadv_priv *bat_priv,
> >                                    const struct batadv_tt_common_entry *common,
> >                                    u8 flags)
> >        __must_hold(&common->flags_lock)
> 
> [Severity: Low]
> At this commit, batadv_tt_local_set_pending() in
> net/batman-adv/translation-table.c doesn't follow the new rule. It still
> ignores the return value and always sets the PENDING flag:

This prepares it for a later patch. I don't think it helps us here to discuss 
in which patch this comment is added.

Regards,
	Sven
--nextPart10953751.nUPlyArG6x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCawXl4AAKCRBND3cr0xT1
y5yzAQDFrPw6mFWxgsmTLHTh/ggZG6w7rryMxKeiO54dfeOyvQEAt1IQ1iIY/fqW
eqLnt1OzHZWbYCIL3Acb+b0T9X37Aws=
=CMte
-----END PGP SIGNATURE-----

--nextPart10953751.nUPlyArG6x--



