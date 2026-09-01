Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7540C61DD3
	for <batman-adv@archiver.kernel.org>; Tue,  1 Sep 2026 18:12:01 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 717728211D
	for <batman-adv@archiver.kernel.org>; Tue, 01 Sep 2026 20:12:00 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788286320;
 b=0DwtbZ09uO3mTFYRdHh1PkHl/+PrbND+HRqArdJ522uTXgRzOJoNBETRo0laQZ+5SLhiH
 m3lT9vFs7GYSroPRsBmIMTm9+0oicOdDuRFA1WERmDdUW52VIE1mJyWLPi70Rgd6ZS8wUST
 BJUddJwBd7CMtn5lSp+ErwBzi7i+utA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788286320; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=DrZVg5yyugsh3pnXFYR7mWnNWLEs9A/k+0uGr3hUOXY=;
 b=1w8RI+FDp68NXo8vELgcMzQBVCS6oeAn7TviW0utyBEwdBFW8phoP2xwmzVu47Ewh8nnv
 e5qaPfvBHCMYKwSWgj0oHWTfm94lqlcW8W9lJIn+CtlIsflUkkouCtTMacMvPD2XOQx7iL9
 N313sUuOQRQI339JpJBj0ecjqMelXpw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 8429380DCC
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 01 Sep 2026 20:11:52 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788286312;
	b=3rs3mLyW4outZ6QmK4SQDUo2T73vfCJ0y369b3UZrTt5SnOIY9nMyBHvf1UA6pnojKcCaK
	LFvQ0e0r1vQ0hFDb8cprcE9uB9UmDzYcMQmJMLXpUnmqbN3ngx+Y17xSlUcRemKV+QTD6u
	xrUrUWlJTvErt6DoF2VjIewZqGI0jlM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788286312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=DrZVg5yyugsh3pnXFYR7mWnNWLEs9A/k+0uGr3hUOXY=;
	b=mU3G7OFaohln/pa8kUgGFePqZP9zWraGFoftRTj8m5S1YoONerTkCksMGJvVrBPuwyJcT9
	RRUC2N+qAymWj43ch7KG97pRzZncdpQhY4Z3F42rGl/rKpp+BGVIzytODJ3cE8rNrr9hXD
	jYN+TFe2cSWOcIhBX8Cj11TbnZaDO1Q=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=SgNwWBcg;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 132CE20514;
	Tue, 01 Sep 2026 18:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788286307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DrZVg5yyugsh3pnXFYR7mWnNWLEs9A/k+0uGr3hUOXY=;
	b=SgNwWBcgO4kqz4kuYVLWAvVI8yaHAIJke8J9HVluHBgTETC6ZxM4ue0AUsNNn1rmQhnK5P
	/0gwcqILNkJZ4bIXUd/oMV2t/1BmssYey+5rsZTOXA1wykwiLFu7tqKsVukbnjbifApXW3
	SaSXzzJDVcEuD23Jjc2k9F2C5bInyf4=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: [PATCH net-next 08/15] batman-adv: tt: remove only the entry
 which was
 looked up from the hash
Date: Tue, 01 Sep 2026 20:11:44 +0200
Message-ID: <2206929.KlZ2vcFHjT@sven-desktop>
In-Reply-To: <20260831135117.574836-9-sw@simonwunderlich.de>
References: <20260831135117.574836-1-sw@simonwunderlich.de>
 <20260831135117.574836-9-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2773984.k3LOHGUjKi";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: 266W3YBJQZVWHTGOWUCGLW2OD5TXGM7B
X-Message-ID-Hash: 266W3YBJQZVWHTGOWUCGLW2OD5TXGM7B
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/266W3YBJQZVWHTGOWUCGLW2OD5TXGM7B/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart2773984.k3LOHGUjKi
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org, Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 01 Sep 2026 20:11:44 +0200
Message-ID: <2206929.KlZ2vcFHjT@sven-desktop>
In-Reply-To: <20260831135117.574836-9-sw@simonwunderlich.de>
MIME-Version: 1.0

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831135117.574836-1=
=2Dsw%40simonwunderlich.de?part=3D8

[...]
> > So when the looked up entry was already unlinked by another context and=
 a
> > new entry for the same client was added in the meantime, these two
> > functions unlink that new entry instead.
>=20
> Discovered by: gpt-5-6-sol, opus-5 =C2=B7 Missed by: sashiko-gemini
> Should this carry a Fixes: tag?  The two converted call sites had this
> defect since the refcount handling around batadv_hash_remove() was
> introduced, and the sibling fixes for the very same call sites did use
> Fixes: tags:
>=20
>   ef72706a0543 ("batman-adv: protect tt_local_entry from concurrent delete
>   events") is the Fixes: target of 3d65b9accab4 for the local path
>=20
>   7683fdc1e886 ("batman-adv: protect the local and the global trans-tables
>   with rcu") is the Fixes: target of f131a56880d1 for the global path
>=20
> Both of those commits already noted that batadv_hash_remove() may delete
> "an entry ... which is not the same object as the needle" and only repair=
ed
> the reference accounting, which is the part this patch completes.  Without
> a trailer, stable tooling has no hint that this is a functional fix rather
> than part of the surrounding cleanup.

I am not allowed to add Fixes: lines for patches targeting net-next. See
https://lore.kernel.org/all/7d73cd74-b040-4a3d-9d78-4ad8fc0a01f4@redhat.com/

>=20
> > diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/transl=
ation-table.c
> > index 88aeefa97db6..66456a2d45e2 100644
> > --- a/net/batman-adv/translation-table.c
> > +++ b/net/batman-adv/translation-table.c
> > @@ -95,6 +95,26 @@ static bool batadv_compare_tt(const struct hlist_nod=
e *node, const void *data2)
> >  	return (tt1->vid =3D=3D tt2->vid) && batadv_compare_eth(data1, data2);
> >  }
> > =20
> > +/**
> > + * batadv_compare_tt_entry() - check if a hash node is a specific TT e=
ntry
> > + * @node: the list element pointer of the TT entry stored in the bucket
> > + * @data2: pointer to the tt_common_entry which is looked for
> > + *
> > + * Unlike batadv_compare_tt(), this only matches the very object which=
 is
> > + * passed as @data2 and not just any entry for the same TT client. It =
is meant
> > + * for batadv_hash_remove() callers which must not unlink an entry the=
y did not
> > + * look up themselves.
> > + *
> > + * Return: true if @node belongs to @data2, false otherwise
> > + */
> > +static bool batadv_compare_tt_entry(const struct hlist_node *node,
> > +				    const void *data2)
> > +{
> > +	const struct batadv_tt_common_entry *tt =3D data2;
> > +
> > +	return node =3D=3D &tt->hash_entry;
> > +}
> > +
>=20
> Discovered by: gpt-5-6-sol, opus-5 =C2=B7 Missed by: sashiko-gemini
> This isn't a bug introduced by this patch, but was the identical pattern =
in
> batadv_bla_del_claim() (net/batman-adv/bridge_loop_avoidance.c) considered
> for the same treatment?  It still looks a claim up by key via
> batadv_claim_hash_find() and then removes by key:

Out of scope. And it is missing the completely different promises by this=20
function. It would make the code a little bit cleaner but it is definitely=
=20
nothing missing it this patch. A ticket for a potential improvement can be=
=20
found in https://www.open-mesh.org/issues/471.

[...]
> Discovered by: gpt-5-6-sol =C2=B7 Missed by: opus-5, sashiko-gemini =C2=
=B7 Confirmed by: opus-5
> This is a pre-existing issue, but should the kernel-doc of
> batadv_hash_remove() in net/batman-adv/hash.h be corrected while these
> callers are being touched?  It says:
>=20
>  * Return: returns pointer to data on success, so you can remove the used
>  * structure yourself, or NULL on error
>=20
> while the implementation returns the matched hash node:
>=20
> 		data_save =3D node;
> 		hlist_del_rcu(node);
>=20
> This patch drops the hlist_entry() conversions that used to make the
> node-ness of the return value obvious at both tt call sites, so the only
> remaining hint is the tt_removed_node variable name.

Out-of-scope for this patch. Follow up patch was submitted
https://patch.msgid.link/20260901-kdoc-hash_del-return-type-v1-1-07b9c26e8d=
f3@narfation.org

>=20
> Discovered by: gpt-5-6-sol =C2=B7 Missed by: opus-5, sashiko-gemini =C2=
=B7 Confirmed by: opus-5
> This isn't a bug introduced by this patch either, but is the caller side =
of
> batadv_tt_global_free() still racy in a way the identity compare cannot
> help with?  batadv_tt_global_del() tests the orig_list emptiness after
> batadv_tt_global_del_orig_node() has already dropped
> tt_global_entry->list_lock:
>=20
> 		batadv_tt_global_del_orig_node(bat_priv, tt_global_entry,
> 					       orig_node, message);
>=20
> 		if (hlist_empty(&tt_global_entry->orig_list))
> 			batadv_tt_global_free(bat_priv, tt_global_entry,
> 					      message);
>=20
> Meanwhile batadv_tt_global_orig_entry_add() can add an originator for the
> very same object under that lock:
>=20
> 	spin_lock_bh(&tt_global->list_lock);
> 	...
> 	hlist_add_head_rcu(&orig_entry->list, &tt_global->orig_list);
> 	atomic_inc(&tt_global->orig_list_count);
>=20
> Since the emptiness decision and the hash removal are not atomic, can a
> global entry that has just regained a valid originator still be unlinked?
> The new comparator matches here because it is the same object.  The
> hlist_empty() read also happens outside the lock that the orig_list is
> documented to be protected by.

Outside the scope of this patch. For interested contributors
https://www.open-mesh.org/issues/473


[...]
> Discovered by: gpt-5-6-sol, opus-5 =C2=B7 Missed by: sashiko-gemini
> With the identity compare, batadv_hash_remove() can now fail while a
> different, live local entry for the same MAC and VLAN is still linked in
> bat_priv->tt.local_hash.  The BATADV_TT_CLIENT_DEL change event is queued
> before the removal and is not undone on that new failure path.
>=20
> batadv_tt_local_event() coalesces purely by MAC and VLAN:
[...]
> Can the stale DEL then cancel the pending ADD of the surviving entry?
>=20
> CPU A: batadv_tt_local_remove() (or the purge work) unlinks entry E
> CPU B: batadv_tt_local_add() inserts E' for the same addr/vid; the
>        batadv_hash_add() happens before its ADD event is queued at
>        the add_event label
> CPU A: having looked E up earlier via batadv_tt_local_hash_find(), with no
>        lock spanning lookup, event and removal, queues DEL and then finds
>        no node equal to &E->common.hash_entry
>=20
> Either ordering ends with both the ADD and the DEL removed from
> bat_priv->tt.changes_list, so E' stays in the local hash with
> BATADV_TT_CLIENT_NEW set and no queued change.
[...]
> Would it make sense to queue the event only after a successful unlink, or=
 to
> re-queue the ADD when the removal fails?  The ordering is still the same =
at
> the end of the series, in "batman-adv: tt: decrement count for committed
> client on local_remove".

This is not the only way something like this could happen. But ok, submitte=
d a=20
patch

https://patch.msgid.link/20260901-tt-del-event-queue-late-v1-1-fc28ca54c342=
@narfation.org

Regards,
	Sven
--nextPart2773984.k3LOHGUjKi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCapcVYAAKCRBND3cr0xT1
y9+YAP98+C/Ht+TGUGUg5X1M2wYPZsunrJTzg6j7O2pV3FUflwD+MerFlOPHwuVB
O7VGSmyyN1uSBe51q1iXVDfLOkyiyQE=
=XWNn
-----END PGP SIGNATURE-----

--nextPart2773984.k3LOHGUjKi--



