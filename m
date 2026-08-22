Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE4CC5B572
	for <batman-adv@archiver.kernel.org>; Sat, 22 Aug 2026 11:01:34 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9E820814AA
	for <batman-adv@archiver.kernel.org>; Sat, 22 Aug 2026 13:01:32 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1787396492;
 b=V50hsTnF2DOAk594QAqCkI12gKdaKe5kMHOnj+SQ9O4SQF9sACogShcKUJ1M95POscdMK
 LOmYoxUyH8QGXFJp4bKgOrefjqjZANGwiT9Km9Tbno3MJzxDCjPA5gBzRabOkY05hCA7cK+
 hKdHqwiYZQKfBOhqZkolJG7SLmp/Glo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1787396492; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=5TYPD9L0vmzoBWI6d9zzsVJKKo6+pNNu3F7nzirXqkI=;
 b=F50Icn3PAJ3lBEkkX/au8h7arRze19m6VemcwBWXf20acYbPHR189XNOYzr6Q156FJ9ia
 FRdVSY2nOpizuzR+pBDYqKUU3ly+obwv70KnL2mU+zjmXCH/I6yl7sWV5qDgUbGAURojbfm
 eYj8d8By0YZr4Tf46vWOsDI3/+unNB0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id E2F4E81487
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 22 Aug 2026 13:01:23 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1787396484;
	b=k8Ob7sviTkgl008E9EmqUz4UZzcbU9IbvoUyIKQ7MJ+EfhLX4xYpiBblfINnDliR6iNhAP
	MbEdeB4dL0jj2tzvNR+5CTLt9hqtMv6++KHcB2pNNDBxxlk4cQ7hyRtjNnfJHTWH0YiLLW
	XgTUh3QjzF3RinIZNo8MgAVUq/iVjgs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1787396484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=5TYPD9L0vmzoBWI6d9zzsVJKKo6+pNNu3F7nzirXqkI=;
	b=M58+Po/RMPWQ50CWTvEGkQMw7F6++VaYnOu43nB9Mrz/WHrmdCorvRu4PmpzXOLFDevklh
	wfT5kDB8f2p7/G5t60PfxUdBxiEr33RZ80us86OtVHT1fCx+NoRt+rs4KsHOUO6C2CeUcx
	QnZvoBue8a9kIpqA8aiZe+Zot6NR8Ng=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=m5P5axHG;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id A528A200FB;
	Sat, 22 Aug 2026 11:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1787396479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5TYPD9L0vmzoBWI6d9zzsVJKKo6+pNNu3F7nzirXqkI=;
	b=m5P5axHGoYbicMzsTsmqiUl+iT6btqG1qWti/E74AUKojpV8/aTK0thoU6Oj88mn8Ksgv2
	dcYw5VzI0Pn2JYlbFAvQb+rrBPAZDJoBcBDYUfk2kYzXv6XGdSie28ond565Wwazxo09zR
	b9ZdX+57R4GEjwKdC+adI5XV+59MJLw=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, stable@vger.kernel.org,
 Sashiko <sashiko-bot@kernel.org>, Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: [PATCH net 2/9] batman-adv: bla: avoid CRC corruption due to
 parallel
 claim add
Date: Sat, 22 Aug 2026 13:01:14 +0200
Message-ID: <2277407.irdbgypaU6@sven-desktop>
In-Reply-To: <20260821094813.201800-3-sw@simonwunderlich.de>
References: <20260821094813.201800-1-sw@simonwunderlich.de>
 <20260821094813.201800-3-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart14080243.uLZWGnKmhe";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: OHCV2V6YHMWV575DQDOVZOV6NCXDOTLI
X-Message-ID-Hash: OHCV2V6YHMWV575DQDOVZOV6NCXDOTLI
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/OHCV2V6YHMWV575DQDOVZOV6NCXDOTLI/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart14080243.uLZWGnKmhe
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Date: Sat, 22 Aug 2026 13:01:14 +0200
Message-ID: <2277407.irdbgypaU6@sven-desktop>
In-Reply-To: <20260821094813.201800-3-sw@simonwunderlich.de>
MIME-Version: 1.0

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260821094813.201800-1=
=2Dsw%40simonwunderlich.de?part=3D2

[...]
> > @@ -732,43 +734,56 @@ static void batadv_bla_add_claim(struct batadv_pr=
iv *bat_priv,
> >  			kfree(claim);
> >  			return;
> >  		}
> > +
> > +		spin_lock_bh(&backbone_gw->crc_lock);
> > +		backbone_gw->crc ^=3D claim_crc;
> > +		spin_unlock_bh(&backbone_gw->crc_lock);
>=20
> Discovered by: gpt-5-6-sol, opus-5 =C2=B7 Missed by: sashiko-gemini
> This isn't an issue introduced by this patch, but how do these relative X=
OR
> updates interact with the absolute CRC store that still exists in
> batadv_bla_del_backbone_claims() at this commit?

Please, look literally one patch further.
https://lore.kernel.org/r/20260821094813.201800-4-sw@simonwunderlich.de

[...]
> Discovered by: gpt-5-6-sol, opus-5 =C2=B7 Missed by: sashiko-gemini
> This is a pre-existing inconsistency rather than something this patch
> introduces, but now that the compare and the swap of claim->backbone_gw
> both happen under claim->backbone_lock here, should the two remaining
> readers be annotated too?
>=20
> net/batman-adv/bridge_loop_avoidance.c:batadv_bla_del_backbone_claims() {
> 	...
> 		hlist_for_each_entry_safe(claim, node_tmp,
> 					  head, hash_entry) {
> 			if (claim->backbone_gw !=3D backbone_gw)
> 				continue;
> 	...
> }
>=20
> net/batman-adv/bridge_loop_avoidance.c:batadv_bla_answer_request() {
> 	...
> 			/* only own claims are interesting */
> 			if (claim->backbone_gw !=3D backbone_gw)
> 				continue;
> 	...
> }
>=20
> Both do a plain load, not even READ_ONCE(), while types.h documents the
> field as:
>=20
> 	/** @backbone_lock: lock protecting backbone_gw pointer */
> 	spinlock_t backbone_lock;
>=20
> At both sites the pointer is only compared and never dereferenced, and in
> batadv_bla_del_backbone_claims() a stale comparison still keeps the CRC
> parity correct because the deferred batadv_claim_release() XORs the addre=
ss
> out of whichever backbone the claim points at. So this looks like a
> KCSAN-visible plain-access race with no functional fallout, but would a
> READ_ONCE() or a comment on those two readers be worth adding so the
> documented locking rule matches the code?

No about this patch and definitely not high priority. Still made a ticket:=
=20
https://www.open-mesh.org/issues/465 for Simon

Regards,
	Sven
--nextPart14080243.uLZWGnKmhe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaomBegAKCRBND3cr0xT1
y+KRAP9EfpNMr0q7Bfn7zIWFY7VjQOW7BiYkErSJbQdMN/rPYAD9Hi9nJOko648D
VHcO8RgNr3MYcNRsHGItdwE+8+03kQI=
=d71n
-----END PGP SIGNATURE-----

--nextPart14080243.uLZWGnKmhe--



