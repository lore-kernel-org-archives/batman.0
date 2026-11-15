Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192B4606A31A
	for <batman@archiver.kernel.org>; Sun, 15 Nov 2026 09:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=ti/mgU+I
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B35E984762
	for <batman@archiver.kernel.org>; Sun, 15 Nov 2026 10:38:11 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1794735491;
 b=DY27p435WMvhvR5rOuporUiTuc3hMcHTUJnfeF9S7yzqw1p4RBynNv3CCr8dShV3LJgfP
 HjJzA9AaRTMCXqh93Qk+5ev3+9WJ2ltPHXwo++/jxK+Pp8Ili1TNNeyVlAmeCFwcuVnhTQ7
 wUFUG105cNBFQKGStwIqX0geMJU4PJ0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1794735491; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=wwmpXvyRTyVJUt+RqQWfGJPUrlqMaIfW3WE9yDFdAx4=;
 b=FzXtjv9JKym+iRG8yGnaCPqvDwZ8A0Czr7trKCBd+3ho4C00u/dAySMRcV7QHIU4UQF6k
 hOfTfBTwCNTT55h6EVncRjJzNUXa97JW3/TRkwpLkAxlqNStdSetjuO+BjjpmNBwPMPEPd+
 wte0d1U23oltaJJEObejRNrog+Vdn8I=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 0BC3483E17
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 15 Nov 2026 10:37:47 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1794735468;
	b=vqWZ7VRqQMrdiTTFiv0f99Kbgcen62NmNkgg39QgACsm53zi/HMAQOWx9D2Y+j01ZHwL5m
	mceWOwP5Xx9PYvn52ZphHnsTOdJjB4HkeqkONKFhPi2foVyDaEOecNGHfmkuByKc/5cGBj
	iL8D+UMJKrnrYvFBdraiVVTVhB+Fs7U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1794735468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=wwmpXvyRTyVJUt+RqQWfGJPUrlqMaIfW3WE9yDFdAx4=;
	b=iw2EF05EVaD2ZTfSVpErPP0wCTlChOW10P0ORjWnanJEv4DSf6+tbcdyQian5vAwDWzEwu
	5kMDMtFHkNu4XHQoPWPj13uKSDqT7tOBM46xjmrvOQSM7XCkBU9WeAAuO0Icx8ufhcYbBy
	ruLAEtSZ+ILBOrzWNoSWXKOj+gQJYT0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="ti/mgU+I";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id D0E681FDCB;
	Sun, 15 Nov 2026 09:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794735467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wwmpXvyRTyVJUt+RqQWfGJPUrlqMaIfW3WE9yDFdAx4=;
	b=ti/mgU+I2rgdcQk1OnSy+Xef2JsFl2ybsKWDeMwV+E0hKr0qEXH5lRsFeGYkOiiw9gOkzl
	DvlOqjkVgKxaVP0jodRleBp0lu7OfE3WqiYdSdlS7RHE1sCEo+kRITZrtYyQl4ExcazFbW
	5A1z5tgMu5GE7RWhZ7nBEDEFw6C4V4s=
From: Sven Eckelmann <sven@narfation.org>
To: Simon Wunderlich <sw@simonwunderlich.de>, sashiko-reviews@lists.linux.dev
Cc: marek.lindner@mailbox.org, antonio@mandelbit.com, netdev@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH net-next 02/15] batman-adv: bla: use dedicated key type
 for
 backbone gateway hash
Date: Sun, 15 Nov 2026 10:37:39 +0100
Message-ID: <13009955.O9o76ZdvQC@sven-desktop>
In-Reply-To: <sashiko-outbox-215348@kernel.org>
References: <20261114091556.3336038-1-sw@simonwunderlich.de>
 <20261114091556.3336038-3-sw@simonwunderlich.de>
 <sashiko-outbox-215348@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6047506.DvuYhMxLoT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: GKRACMUPPW5JNQCCUE52MFSF7RJ6QAHQ
X-Message-ID-Hash: GKRACMUPPW5JNQCCUE52MFSF7RJ6QAHQ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/GKRACMUPPW5JNQCCUE52MFSF7RJ6QAHQ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--nextPart6047506.DvuYhMxLoT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 15 Nov 2026 10:37:39 +0100
Message-ID: <13009955.O9o76ZdvQC@sven-desktop>
In-Reply-To: <sashiko-outbox-215348@kernel.org>
MIME-Version: 1.0

On Sunday, 15 November 2026 10:24:42 CET sashiko-bot@kernel.org wrote:
[...]
> [Severity: Medium]
> This problem wasn't introduced by this patch, but should
> batadv_bla_purge_backbone_gw() and batadv_bla_del_backbone_claims()
> [1] increment hash->generation when removing entries with
> hlist_del_rcu()?
> 
> Netlink dumps such as batadv_bla_backbone_dump() and
> batadv_bla_claim_dump() set cb->seq from atomic_read(&hash->generation) and
> rely on genl_dump_check_consistent() to flag concurrent table changes with
> NLM_F_DUMP_INTR.  Because these bulk deletions (as well as
> __batadv_dat_purge() and batadv_purge_orig_ref()) unlink entries directly
> without bumping hash->generation, a concurrent netlink dump can miss
> NLM_F_DUMP_INTR and return an inconsistent snapshot to userspace.

This is done in the "increase hash generation when purging entries" patches in 
this series.

And it is absolutely unrelated to this patch.

Regards,
	Sven
--nextPart6047506.DvuYhMxLoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCavl9YwAKCRBND3cr0xT1
yyY4AQCqj6pW6rJ265sQV3f8auxGfvDlUuerS5OMIji8HgG76QEA7hVNDYG02lCD
WQlSSI2FSAkxM1Od6pw/IX65AhH3pA0=
=eLP7
-----END PGP SIGNATURE-----

--nextPart6047506.DvuYhMxLoT--



