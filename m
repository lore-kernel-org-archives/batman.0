Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12E1606A31D
	for <batman@archiver.kernel.org>; Sun, 15 Nov 2026 09:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=2dJ5YK7Q
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 739E284735
	for <batman@archiver.kernel.org>; Sun, 15 Nov 2026 10:42:41 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1794735761;
 b=CxeSeENG1y8kU2MN/D5tPDfbqfB1wi5upleOeIcLjhOh3VVhKx417YzTfaX91XiRLnjBq
 iumj8kS66Oh3ljX0RTKxYIyJpKnCuzHx+BlIPSSxWUsJ5IfQIWKBJcqzsPjta+gGZhXHefZ
 bjOstm6/nkwfHcT9NYHVFbqu8jtM3ms=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1794735761; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=jyi0ZYdSXMFjxWis5yIKPZ/e/pVOg1Og2RcpInXXxw8=;
 b=Rugp5f/ZLxVdoLJT9HoAILENuOWij2tkvEU+IU2l09Ay2/0O13jIMKr9jCYmKzf1haffh
 e9k1JqEyhjiul3En+EGewqJVoy6T9VXPwNw2KGEEmSKSMJRaKKXjUeowzbZRH5sL5z7UKsP
 FCn+4LQVtW728QKrQuj0HpIeofVb9j4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 0F67D83E17
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 15 Nov 2026 10:42:17 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1794735738;
	b=lHjPVd0kL0Dr1tmlkLZriG87xOAN+rO34Gb0SJU3zwboixpcxHiiDrL9E+PsoZxlJSeTYH
	e43aQAKuQLA9PskxkbftbnRg/klKFIUieGmt+bMF7XK4HYoICKjB5GmF/Zk7Nh3koNpKlQ
	1UOS3vaU9LtgqeKdJAYU8lpFRiQo3g4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1794735738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=jyi0ZYdSXMFjxWis5yIKPZ/e/pVOg1Og2RcpInXXxw8=;
	b=Jl7pcCJ3t0LNDwuUd+x4DlgO14m5aXdz/273KgCX9Fa+A6tFDmQL2AEqOiJV6M9M9TkiSv
	9GS2n9ZhkAtP5veMbGZr80cBB3/UbmC+ZiQG8Z1b0sJ1vBKLHOGtcDY8F2Zy/iqTYo6P5q
	78SfRXpSwvJamYpWibNioj2Z7DTzUVU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=2dJ5YK7Q;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id BAC5A1FD16;
	Sun, 15 Nov 2026 09:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794735736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jyi0ZYdSXMFjxWis5yIKPZ/e/pVOg1Og2RcpInXXxw8=;
	b=2dJ5YK7QgAfvNQVVaVJdmuWNlNlG87tdSddq1xEh5UJBMdX58p49zinqu6YR6whGjIz/LD
	prKGB6QESgD1kXYCieRxW6E2EWWDHtl6szTA5Qk5WqrIgD9aAmkAxygZq3IIPk+84cf2VL
	QlXVmQ6fmMB3n8E4qWSK8NPL9ZVfpfU=
From: Sven Eckelmann <sven@narfation.org>
To: Simon Wunderlich <sw@simonwunderlich.de>, sashiko-reviews@lists.linux.dev
Cc: marek.lindner@mailbox.org, antonio@mandelbit.com, netdev@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH net-next 04/15] batman-adv: tt: use dedicated key type for
 hashes
Date: Sun, 15 Nov 2026 10:42:13 +0100
Message-ID: <4777859.LvFx2qVVIh@sven-desktop>
In-Reply-To: <sashiko-outbox-215350@kernel.org>
References: <20261114091556.3336038-1-sw@simonwunderlich.de>
 <20261114091556.3336038-5-sw@simonwunderlich.de>
 <sashiko-outbox-215350@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2433226.ElGaqSPkdT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: PTW2ZXXO2JSXOUPD5FYNK4GXXZ3GJQAX
X-Message-ID-Hash: PTW2ZXXO2JSXOUPD5FYNK4GXXZ3GJQAX
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/PTW2ZXXO2JSXOUPD5FYNK4GXXZ3GJQAX/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--nextPart2433226.ElGaqSPkdT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 15 Nov 2026 10:42:13 +0100
Message-ID: <4777859.LvFx2qVVIh@sven-desktop>
In-Reply-To: <sashiko-outbox-215350@kernel.org>
MIME-Version: 1.0

On Sunday, 15 November 2026 10:24:43 CET sashiko-bot@kernel.org wrote:
[...]
> [Severity: Medium]
> This problem wasn't introduced by this patch, but can batadv_tt_local_crc()
> include a BATADV_TT_CLIENT_PENDING entry in the local CRC calculation
> [1]?
> 
> batadv_tt_local_commit_changes_nolock() runs
> batadv_tt_local_purge_pending_clients() and batadv_tt_local_update_crc()
> sequentially under per-bucket locks, and batadv_tt_local_crc() only skips
> BATADV_TT_CLIENT_NEW:
> 
> CPU0                                    CPU1
> batadv_tt_local_commit_changes_nolock()
>   batadv_tt_local_purge_pending_clients()
>                                         batadv_tt_purge()
>                                           batadv_tt_local_purge()
>                                             ...
>                                               common->flags |=
>                                                 BATADV_TT_CLIENT_PENDING
>   batadv_tt_local_update_crc()
>     batadv_tt_local_crc()
>       includes pending entry in crc     <-- CRC mismatch
> 
> The local CRC then disagrees with the committed translation table state and
> triggers unnecessary full TT synchronizations across the mesh.


Not related to this patch. And the patchset to handle this better is pending [1].

Regards,
	Sven

[1] https://git.open-mesh.org/pub/ecsv/batman-adv.git/log/?h=b4/tt-avoid-unhashed-event
--nextPart2433226.ElGaqSPkdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCavl+dQAKCRBND3cr0xT1
y6oOAQCKyP0GEmH1xuxYPjD3qa2YYZvDjNW99ur5+VT7Yt97uQEA4rDoEHRecu4r
PYXljqTRHgyXPN3+KI4Z3DyQouxt3g8=
=CaO4
-----END PGP SIGNATURE-----

--nextPart2433226.ElGaqSPkdT--



