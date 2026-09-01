Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB6B1C61DD6
	for <batman-adv@archiver.kernel.org>; Tue,  1 Sep 2026 18:19:03 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id F170582220
	for <batman-adv@archiver.kernel.org>; Tue, 01 Sep 2026 20:19:01 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788286741;
 b=3nTE85WLDBTFIAGLOZUWYbnm/GSHqbm20uI6OL0qbypJwFzOuXAYWNbTjKYJXwrlXfU0s
 b2R9RaJBZpZZsC/g51vFYdM50JWJTcaeTLMtpdU4VVhnjrr+341I2Jydwls/Xad6zvjVK8Y
 ilitmW93l+MIhAuUSq56lFhNiKfwvN4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788286741; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=RsvuI7lZ0TZRrrGE3s3xeWRxZcspgFKVyXkTwnTErr8=;
 b=ehwOlGTmq3alA5OaeGyd7DNevPn765CLoJUubS0bRnNvmbF47+Ikf3GwEvQfPak0vh1ct
 XPW3FLbM3bikcrgMYYzO+nk4Akrp2+vCLvw5OlLU+VQrtxL2PYEHXxQcq0WFB1zEB0T0F++
 YSJ+72MilGVWWu9lKJcJhmLi0BMC5fw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id A920180794
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 01 Sep 2026 20:18:54 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788286734;
	b=Qpf2MCmqJ78L1o1pxErKt1ZHV4JL3pLX6DbiSOEY/eiTyaZ/8FuR0l2K/3qQAj3AZiki6d
	xfzACaJ8bngtocSoEwxe9aDBcurUzGyCaIZ2jeFsqXfK4+nfhWY/GMa4bjhsigjgw37dK1
	cE9eDzG4BCRL7FnRvYgpxcoSqL9FP20=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788286734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=RsvuI7lZ0TZRrrGE3s3xeWRxZcspgFKVyXkTwnTErr8=;
	b=ofctsUlsMyQ9FNqw9hRqYFxa95zclxEGUcDvY4TilcGWKcEFcZwn1hGGyF0oSVDu8ssDcX
	5IBsz79YdXVl1+TT/USNdcdrlbZQSzd0AGyvhSppQLjX999kSfPcZ7IiP1KRGp+ah9yHOz
	sDYYh+lJ7Ndzi51BlGMRy7Wsh/kl8d4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="w6oxEPr/";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id DE591203D9;
	Tue, 01 Sep 2026 18:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788286730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RsvuI7lZ0TZRrrGE3s3xeWRxZcspgFKVyXkTwnTErr8=;
	b=w6oxEPr/yLRyLmoykG/ykaHijXj0AhyZBNcWzrmpqWYwgCYNIgyPYGOvxMh1VuXjSSQZ21
	A4RfgfOkuBqHGMBS5ojfaO51H5LstcswzWF457owhmo+pUsOrmche2kPh2f/UP68fswJ6f
	PUBqkS5MmknD+2NfATqmWr0rNCW0k08=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: [PATCH net-next 10/15] batman-adv: tt: simplify NEW flag
 transition code
Date: Tue, 01 Sep 2026 20:18:47 +0200
Message-ID: <5146131.31r3eYUQgx@sven-desktop>
In-Reply-To: <20260831135117.574836-11-sw@simonwunderlich.de>
References: <20260831135117.574836-1-sw@simonwunderlich.de>
 <20260831135117.574836-11-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4778182.LvFx2qVVIh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: PKZGALQYIIPP3XRST2W2MTWMSTJQ47QS
X-Message-ID-Hash: PKZGALQYIIPP3XRST2W2MTWMSTJQ47QS
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/PKZGALQYIIPP3XRST2W2MTWMSTJQ47QS/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart4778182.LvFx2qVVIh
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 01 Sep 2026 20:18:47 +0200
Message-ID: <5146131.31r3eYUQgx@sven-desktop>
In-Reply-To: <20260831135117.574836-11-sw@simonwunderlich.de>
MIME-Version: 1.0

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831135117.574836-1=
=2Dsw%40simonwunderlich.de?part=3D10

[...]
> Discovered by: opus-5, sonnet-5 =C2=B7 Missed by: gpt-5-6-sol, sashiko-ge=
mini
>=20
> This isn't a bug introduced by this patch, since the removed
> batadv_tt_local_set_flags() did the same unlocked read-modify-write under
> rcu_read_lock(), but it may be worth noting for the rewritten loop in
> batadv_tt_local_transition_new().
>=20
> The loop only holds rcu_read_lock(), so it takes neither the hash bucket
> list_lock nor any per-entry lock while doing:
>=20
> 	tt_common_entry->flags &=3D ~BATADV_TT_CLIENT_NEW;
>=20
> Can this store be lost against a concurrent RMW on the same u16 from
> batadv_tt_local_add() or batadv_tt_local_set_pending() on another CPU, for
> example one that is OR-ing BATADV_TT_CLIENT_PENDING or
> BATADV_TT_CLIENT_ROAM into the same word?
[...]

Out-of-scope for this patch. And handled in the patch
"batman-adv: tt: transition NEW local entries only under lock"

Regards,
	Sven

--nextPart4778182.LvFx2qVVIh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCapcXBwAKCRBND3cr0xT1
y8GTAP9pYtgQ53GhxqBDk6erQWp+KbSDdLPShU2KxvHj7228rQEApSyZSKDsN0tA
BBvtJ/3BubEGdI0/mkrs3pHOpE3++Aw=
=mchY
-----END PGP SIGNATURE-----

--nextPart4778182.LvFx2qVVIh--



