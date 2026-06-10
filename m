Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA00CD98CC
	for <batman-adv@archiver.kernel.org>; Wed, 10 Jun 2026 18:35:27 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5C53383DE7
	for <batman-adv@archiver.kernel.org>; Wed, 10 Jun 2026 20:35:26 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1781116526;
 b=Ah0t4yO3N0fWfJyBn6EEbbUwEaHjOiIoE8WidPKHhFE3xyvYCloIaa1dyt5yJ3VAavt/3
 xwHjte/PM0LzcwYxRjZbx60ElBK0Bjwm9WpCW51mdOjQIfwn/kUjfKLRVrdHGBfn+DROAww
 NA5eGPAIWVh8+F5ZDljOaDUu8ltmG4U=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1781116526; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=/CjyputoTMp6UpnADn3bCtJgpBMxojZzwM5b81b2ZiY=;
 b=uqrk9gxyK4VXk9R/FGlPNsWYtpbAOS9fxqHEQ89iFGQbjImjjjcZiTGSE0U8nzggj0yfl
 gLIh3+8dXR8kObGEZRe2LOjIyNKO64l4R93v3o4S/381K8W3EppTGMq1fHBZAjdJdIV79Zg
 Z8fMFkppjn1UE7B7CPfEAk8AQSJ0Fe0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 8F1A081CCE
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 10 Jun 2026 20:35:05 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1781116516;
	b=r/7Skf+DQ4L863vs4UzUJfQc7ykBFUfMeFAQ6h2t9iOtpgykN2MYPYh8ebyUjO8c/EPNUD
	N4Yos7ov2YswRMZboNwd9BiLhztgAV0+8cjLTEgvkGJfgL6NiPon0ztXWrI8cmMLc7968H
	GrjeHF7SaQfc+81FTQwpr6SaJVawBG0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1781116516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=/CjyputoTMp6UpnADn3bCtJgpBMxojZzwM5b81b2ZiY=;
	b=xNHwV7dtRbjhuIScacSDf/yInN9uiGwe1MHABP2DWknWbX2NqlLu5Dty24fJTV1HRvqG/Y
	UYqle5FTEkheucLvL5l7mk5FGtjSz8MZdiGZotzlmJUfGUXBAGDXinCU1z/oJWUYJQsxub
	4GKuD/K5xFutEWiLxGLyxdJkGtF5AcU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="G/q5JQyd";
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
Received: by dvalin.narfation.org (Postfix) id 3EB0B20280;
	Wed, 10 Jun 2026 18:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1781116504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/CjyputoTMp6UpnADn3bCtJgpBMxojZzwM5b81b2ZiY=;
	b=G/q5JQydR4iW7Ek6zgHTxXjx2m2v9a+lpgidSLr4NJ15W0CetxSUI+/FPKP7W0WPFeklc8
	DFkMq+48o4khy5M8xqySgM3UROp8D10VnXx+phYDruDmFeDgOrHEVMhaipsJpBqigUz0W+
	9FiyzfkPdkjl+o9bec62KLbykaxFB5g=
From: Sven Eckelmann <sven@narfation.org>
To: Nora Schiffer <neocturne@universe-factory.net>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH batadv] batman-adv: gw: don't deselect gateway with active
 hardif
Date: Wed, 10 Jun 2026 20:35:00 +0200
Message-ID: <6276013.lOV4Wx5bFT@sven-desktop>
In-Reply-To: <658521a4-cbcf-4f71-b5ee-586bec229bd4@universe-factory.net>
References: <20260607-gw-disable-check-v1-1-d156beb975ce@narfation.org>
 <658521a4-cbcf-4f71-b5ee-586bec229bd4@universe-factory.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5107962.31r3eYUQgx";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: QHNKWMK2RP4LB3KTXELX7HFEYGFCQ6ER
X-Message-ID-Hash: QHNKWMK2RP4LB3KTXELX7HFEYGFCQ6ER
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/QHNKWMK2RP4LB3KTXELX7HFEYGFCQ6ER/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart5107962.31r3eYUQgx
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Nora Schiffer <neocturne@universe-factory.net>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Date: Wed, 10 Jun 2026 20:35:00 +0200
Message-ID: <6276013.lOV4Wx5bFT@sven-desktop>
MIME-Version: 1.0

On Wednesday, 10 June 2026 19:50:12 CEST Nora Schiffer wrote:
[...]
> >   	/* nobody uses this interface anymore */
> > -	if (batadv_hardif_cnt(hard_iface->mesh_iface) <= 1)
> > +	if (batadv_hardif_cnt(hard_iface->mesh_iface) == 0)
> >   		batadv_gw_check_client_stop(bat_priv);
> 
> The change looks correct, but this is the only remaining user of 
> batadv_hardif_cnt(), and it's only checking if there aren't any hardifs, so 
> this could avoid counting altogether and just use
> 
> 	if (list_empty(&hard_iface->mesh_iface->adj_list.lower))
> 
> and drop batadv_hardif_cnt().

Good point. Will submit a new version.

> We are holding RTNL here, right?

Yes, all callers are holding RTNL.

Regards,
	Sven
--nextPart5107962.31r3eYUQgx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaimuVAAKCRBND3cr0xT1
y6wEAQC0HYuK67xOj13zQXC3+qxLppYywmxGILFbciSYtRt7EgEAqCIG5+mrhDab
0i0lGBq9MphDdttNm4l1ZmqGhUXPkQM=
=yHDg
-----END PGP SIGNATURE-----

--nextPart5107962.31r3eYUQgx--



