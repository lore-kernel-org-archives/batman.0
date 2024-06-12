Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4299C27C53
	for <batman-adv@archiver.kernel.org>; Wed, 12 Jun 2024 18:23:27 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id EAD4283464
	for <batman-adv@archiver.kernel.org>; Wed, 12 Jun 2024 20:23:25 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1718216605;
 b=0AdrQaBTIm04FUky07DzKwlo+oz4QfABiBE4JsE4nqadP2vYUAYSoHmDapaL9+k/DqFC/
 Q9lcmZjskYigOHDzK+b285bC6t/DLN3a74k4spQtoqH0ciSEt/u/x3KkkjkRMML2WIxpDx0
 iGsZ1gOENGjfaeEEB3xE21Q9MfzB7wE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1718216605; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=r2DIMPyxXsUsx3z3UHNDfQvmHitGXJiStJK05XL6M2Q=;
 b=lefn0C/dXdmsgZM7MeJhX78CO6Eu+aUiCPJ4VDWJ17pB47K6WtJAF1/Fx6FnSTm41q3t5
 X3Yev0DACoSJs6GuA3rCo9NOZbcanZnPEpihetTyAUkpNVV9nddOzdTLB5SEXfgOFyv7vgD
 QPUXQ4rKjwjCTY8myoMt8O8xPY+gFTE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id C9DD082655
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 12 Jun 2024 20:22:53 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1718216573; a=rsa-sha256;
	cv=none;
	b=sVson1p16Xq0VnS6OQttYjQrByAGzxIdWPHLcDrRMkGdVp8gskFxk+P+ZPiQ2clI3pwEs5
	MptAnbUO0M0b4eClqjp/iebUcZp7ms5YVyLmJuqp/fn2C1vEk3bhpAW/sT2s1X9PEvrM+U
	TNTVIJJQffROQpnhzbeoFlwlJxT5tng=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=iX4SAKjS;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1718216573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=r2DIMPyxXsUsx3z3UHNDfQvmHitGXJiStJK05XL6M2Q=;
	b=rc2BHzfp3aA7LyElTm/3QBTMTby6tCR3cKfY6DlvhgEsSey+c9a2ZL+EWFAIp1iWwKqvzN
	SJ0bAiRFiW7h55QIug8fB7RWO4aW5zLdpC3enCKXF0Gxwxg8L4bH4BuBrchLlLfq7sPsOh
	vgrOV8cq4V0Kl1yD8QkVUP2n482M5TE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1718216572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r2DIMPyxXsUsx3z3UHNDfQvmHitGXJiStJK05XL6M2Q=;
	b=iX4SAKjS85UNGwt2lkaEQqSxCKTvFY5YqaV5lR5uo6cmb3yqiPqSy0QTNp06jX/47CgtUt
	gAs50cZL2EXRva9Xf0iAnCBIhRpgC+JEqUqNnjqVVm/4Kb3sCo4e2qiroY/jdGH1zwk4e7
	fzTxXeRhTjT6C0prhAE+4lu0OZ+Sxu0=
From: Sven Eckelmann <sven@narfation.org>
To: "Paul E. McKenney" <paulmck@kernel.org>, b.a.t.m.a.n@lists.open-mesh.org
Cc: b.a.t.m.a.n@lists.open-mesh.org, Dmitry Antipov <dmantipov@yandex.ru>,
 netdev@vger.kernel.org, rcu@vger.kernel.org,
 Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Subject: 
 Re: [PATCH] Revert "batman-adv: prefer kfree_rcu() over call_rcu() with
 free-only callbacks"
Date: Wed, 12 Jun 2024 20:22:49 +0200
Message-ID: <2328482.ElGaqSPkdT@sven-l14>
In-Reply-To: <ZmnNfU44NekafjA_@sellars>
References: 
 <20240612133357.2596-1-linus.luessing@c0d3.blue>
 <020489fa-26a3-422c-8924-7dc71f23422c@paulmck-laptop>
 <ZmnNfU44NekafjA_@sellars>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4898629.GXAFRqVoOG";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: 6YCHHJOXAI22GOAO7I2RF6CY42GWHIEY
X-Message-ID-Hash: 6YCHHJOXAI22GOAO7I2RF6CY42GWHIEY
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/6YCHHJOXAI22GOAO7I2RF6CY42GWHIEY/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart4898629.GXAFRqVoOG
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 12 Jun 2024 20:22:49 +0200
Message-ID: <2328482.ElGaqSPkdT@sven-l14>
In-Reply-To: <ZmnNfU44NekafjA_@sellars>
MIME-Version: 1.0

On Wednesday, 12 June 2024 18:31:57 CEST Linus L=FCssing wrote:
> On Wed, Jun 12, 2024 at 09:06:25AM -0700, Paul E. McKenney wrote:
> > We are looking into nice ways of solving this, but in the meantime,
> > yes, if you are RCU-freeing slab objects into a slab that is destroyed
> > at module-unload time, you currently need to stick with call_rcu()
> > and rcu_barrier().
> >
> > We do have some potential solutions to allow use of kfree_rcu() with
> > this sort of slab, but they are still strictly potential.
> >
> > Apologies for my having failed to foresee this particular trap!
>=20
> No worries, thanks for the help and clarification! This at least
> restored my sanity, was starting to doubt my understanding of RCU
> and the batman-adv code the longer I tried to find the issue in
> batman-adv :D.

Thanks Linus and Paul. I've queued up the revert. But feel free to submit a=
=20
version with updated text in case you want to incorporate information from=
=20
this thread.

Kind regards,
	Sven
--nextPart4898629.GXAFRqVoOG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZmnnegAKCRBND3cr0xT1
y/2ZAQCJLtdWIbCPUrkTqkI9mv1ThzM/ZcLceVmbFSKhVCSe8AEAtVQx2GE9aUCk
S1OPFkU0m5zCxxMHHIygDnw3SwaMvAA=
=mD28
-----END PGP SIGNATURE-----

--nextPart4898629.GXAFRqVoOG--



