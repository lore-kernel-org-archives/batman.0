Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 870E3CA5FC4
	for <batman@archiver.kernel.org>; Fri,  2 Oct 2026 16:00:17 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 94F698427E
	for <batman@archiver.kernel.org>; Fri, 02 Oct 2026 18:00:15 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1790956815;
 b=AZAy4+K43LVr/k34hUxF1qTm3vF1glbdDn69tHRbrTxHBfGvjaPKrtuOdZG5hrays7Eok
 9ax2MH8HIR8n1YCHEfY8iibl35UTTWOV9dsE6T44/k/FRQt8Ga3aNUQ/9u5vodmbCftkXoQ
 CNrcRXf7MXeQ+lJl1sQXfdG0v51Wgh4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1790956815; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=x1q56wVicCIloc+W4nKmUHYzwS/UjZUx+5MI4DSCe5A=;
 b=AlIAE/wguDAvyC2MXL7kjnFyDaww0LOPlzmeGY4UgyNCyBy5PXcR9l+aqG7oTLA+iJL5F
 AeJRjcqzBSyVjgKF7hv9sNOE8MkaadnsTWzD9ZLcRMuXDXgvp8VzPhiC7b8Nuf0+7AIgAP6
 Z2Qr7/g710xOXqW5golYTyu6U2sCDRo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 65A7483B70
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 02 Oct 2026 17:59:55 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1790956805;
	b=OTedFwGieWCxVKrpJaX7J8v7IP4MJs2I3N3OBa026f4FUT3ZL10ELuiCgdz0qgfTpxXvsr
	M53k7fcjenXfh2hx/bJzv8NbyDxC11nHkcjRVy80Buwaj0IXVmEC/hT1wrjuZSEp7tE3zw
	Xe45g1ZJUUnYFmIVcqE+8nn3xl/x0yA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1790956805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=x1q56wVicCIloc+W4nKmUHYzwS/UjZUx+5MI4DSCe5A=;
	b=Sobw5eO0KhiPR6PQcfAVtj8ENpLrTEJKpRyF/1Fw88qkQksbRimwFDQvvlzZHFOlU/vT1a
	2Odwz9a82vfwO8f6KROc3xTS5JxSX7xWmKPs1YGR0wUlcqpnqnDIZ10pTMiFE4OWYQrfLt
	luBN9niJUhwkKxgHmVtuzKpwWuh9x14=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=eQOmPX3a;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 9BCF31FEA4;
	Fri, 02 Oct 2026 15:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1790956793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x1q56wVicCIloc+W4nKmUHYzwS/UjZUx+5MI4DSCe5A=;
	b=eQOmPX3aFxFzhcddhOT4Bmk7VKAlD7QEgRhS2mbiu5636n8A3dru+TWaHbaRwt3bWcEDyp
	Ax4Q4h4T4NRXkI3jjP5n4lA4kyJhl8YqvOu+YJLsrTMcVoGSPhM5N/RcWGIBC9Q9t6PkOi
	Aq/NYh+vNBOjIK5t2PMBAxr2KBxkyCc=
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de, netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 1/9] batman-adv: bla: avoid double free after
 failed
 backbone_hash alloc
Date: Fri, 02 Oct 2026 17:59:50 +0200
Message-ID: <2427933.ElGaqSPkdT@sven-desktop>
In-Reply-To: <179084942612.434549.483028329310521943@kernel.org>
References: <20260930094558.3723766-2-sw@simonwunderlich.de>
 <179084942612.434549.483028329310521943@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5106887.GXAFRqVoOG";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: HYDGL6UMPMC4J2GC6YZAVTZH3GEQ5XLL
X-Message-ID-Hash: HYDGL6UMPMC4J2GC6YZAVTZH3GEQ5XLL
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/HYDGL6UMPMC4J2GC6YZAVTZH3GEQ5XLL/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart5106887.GXAFRqVoOG
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de, netdev-bot+sashiko@kernel.org
Date: Fri, 02 Oct 2026 17:59:50 +0200
Message-ID: <2427933.ElGaqSPkdT@sven-desktop>
In-Reply-To: <179084942612.434549.483028329310521943@kernel.org>
MIME-Version: 1.0

On Thursday, 1 October 2026 12:10:26 CEST netdev-bot+sashiko@kernel.org wrote:
[...]
> [Severity: Medium]
> 
> Can this sequence actually happen? batadv_bla_init() has only one
> caller, batadv_mesh_init(), and when it fails that function jumps past
> batadv_bla_free():

Even when trying to get sashiko to stop complaining about something, the other 
Sashiko instance will just complain about the opposite:

https://sashiko.dev/#/patchset/20260831135117.574836-1-sw%40simonwunderlich.de?part=6

Regards,
	Sven
--nextPart5106887.GXAFRqVoOG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCar/U9gAKCRBND3cr0xT1
y/4kAP4kuH/5O3QRxPjxIrzpsKnwdB5IbO5OR4G5ThyIU32qMAD/SW4QPrjupRd6
oJ3/EfQRQz8LFi5MnDT7s+vBXEf1aQ0=
=6dmz
-----END PGP SIGNATURE-----

--nextPart5106887.GXAFRqVoOG--



