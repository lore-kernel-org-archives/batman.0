Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C734606A31E
	for <batman@archiver.kernel.org>; Sun, 15 Nov 2026 09:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=BgryksRZ
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C09E783E17
	for <batman@archiver.kernel.org>; Sun, 15 Nov 2026 10:50:29 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1794736229;
 b=dQmx3hDOsFo5nASHM2MU8mCOkv3U/MgBJMdxZRiouZE8Vudc0VLZ3SIx3zSZVmMDY+Cdp
 izRdmmZfGsWEtP6zFzV3iMw+iF5W++kExyvQPZaU3aD3i4zu33VPbahDJ3r07sW6dxOpiJl
 IX5ZHH1pQzNE0Y2j24OTEmajJIeJmyU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1794736229; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=fZ05mL96e7xsv2qPwj5DbOYLveVjhQuS5JmkAfy2xHw=;
 b=bCjjlgfvq3erkEqoruKw01jGWgoiqBVDDRbt8Mk+1pQcs5KuG8KMW1N5Pu4HmZ+uMJfIg
 0eLiuXQgXnP11HzHweb1QMxtyaItcqtXI0Yi3V3QJMdCV9HTir/DAXv+6q0T6jf6s3MhM3M
 Myq5dqyH0muUOyiIo6beaEXi95cMsvI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 24C2780C5D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 15 Nov 2026 10:50:06 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1794736206;
	b=Y6ZruuJiUoBLkj58Wyq6jonSg5QzsF68WXUd6uQQ8wHPJCoczJBZNWOdKEml1eczlVFXhD
	Sr9v56jifjYAknuMBxm8NG/ZzXjMwLlkL6j5EjnpmeDR47hMZQgHylPna9FJL5Wyu/ooNv
	3wN5xldYrUKr2gSZvc9l6kydWDCZfRo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1794736206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=fZ05mL96e7xsv2qPwj5DbOYLveVjhQuS5JmkAfy2xHw=;
	b=nuq5c013aC+I04LhUsqx4U5OekVXmBzUc3jPrd425+OUm/DbHGL896mTu1juJmIyZAVWSY
	L7da24MfzwrPS5Kw9bBKioQsgQhMU7s4NAfLHk91MhUasirL6RE8Sas0oH0nDo0osgxkBH
	VK6QMGphi7xd3RxbWAsFQexwtjmFtYU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=BgryksRZ;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 3F5FA1FDCB;
	Sun, 15 Nov 2026 09:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794736205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fZ05mL96e7xsv2qPwj5DbOYLveVjhQuS5JmkAfy2xHw=;
	b=BgryksRZW6STpubVR0e0SCKzXMREAfmttpEBSNtLlvMzcrtIPUpbliPlgvlUeHQSYNUfJz
	ANQTP6msF6EiA6r38UIcGTiA9N64RZVrP0RiUGaa/8B1qu7x7EyOFKBuG9qlO0S534Shw/
	m4j43/H8L/lDR2gJKHokRvmsTPd0Y70=
From: Sven Eckelmann <sven@narfation.org>
To: Simon Wunderlich <sw@simonwunderlich.de>, sashiko-reviews@lists.linux.dev
Cc: marek.lindner@mailbox.org, antonio@mandelbit.com,
 b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 12/15] batman-adv: dat: increase hash generation
 when
 purging entries
Date: Sun, 15 Nov 2026 10:50:02 +0100
Message-ID: <8759436.T7Z3S40VBb@sven-desktop>
In-Reply-To: <sashiko-outbox-215358@kernel.org>
References: <20261114091556.3336038-1-sw@simonwunderlich.de>
 <20261114091556.3336038-13-sw@simonwunderlich.de>
 <sashiko-outbox-215358@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart10948139.nUPlyArG6x";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: HYGMOFE4WM3Z7ZSHBIQDRUOAE4ZVDEI5
X-Message-ID-Hash: HYGMOFE4WM3Z7ZSHBIQDRUOAE4ZVDEI5
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/HYGMOFE4WM3Z7ZSHBIQDRUOAE4ZVDEI5/>
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

--nextPart10948139.nUPlyArG6x
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 15 Nov 2026 10:50:02 +0100
Message-ID: <8759436.T7Z3S40VBb@sven-desktop>
In-Reply-To: <sashiko-outbox-215358@kernel.org>
MIME-Version: 1.0

On Sunday, 15 November 2026 10:24:45 CET sashiko-bot@kernel.org wrote:
[...]
> 
> [Severity: Low]
> Inconsistent netlink dump detection for the DAT cache was introduced without
> updating bat_priv->dat.hash->generation in __batadv_dat_purge().  Should this
> include:
> 
>   Fixes: 6f81652a4713 ("batman-adv: Add inconsistent dat netlink dump detection")

No, "Fixes" (for old kernels) should not be added without "Cc: stable@....". 
And patches with these tags which should go through net-next.

It was decided that this is so irrelevant for most situations and fixed 
primarily for getting rid of these constant "This problem wasn't introduced by 
this patch, but...." reports by Sashiko. No need to increase the load on the 
stable-kernel team for such a change.

Regards,
	Sven
--nextPart10948139.nUPlyArG6x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCavmASgAKCRBND3cr0xT1
yxUHAP0SFX9XcPbQw/S7jXOHEiEHcuBlvb3h37+TT8raM6TsnAEAlZpJ7BLTmoer
0QaxcP3q2bhGKie94xKiP7hPsq57wwE=
=+9WZ
-----END PGP SIGNATURE-----

--nextPart10948139.nUPlyArG6x--



