Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E0F606A6A0
	for <batman@archiver.kernel.org>; Tue, 24 Nov 2026 19:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=TUs1pWxp
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 6FCA583099
	for <batman@archiver.kernel.org>; Tue, 24 Nov 2026 20:47:19 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795549639;
 b=aTluUBYCDgOLlJuwe6Hqe9+NMK1SC2CNjRpKwiAZ/+0kP0jS/SXlrBddcsl3wrUmVyBq9
 E5dFh9zpHOTg9UYomiX8Ltv5IoMaeGRNXnrR7Myt7+S101taD/XYm09CzBOH1ALn3XmVMsl
 xxnwQ6fAmrw0KwBpVjHZERUFEEk3R4I=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795549639; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=cJRVzTMJnlShHbcMCuLGWkT4v841qpZ2m9PE1z4Vr0s=;
 b=hJ7YdvooG/+pZumlynnWpbi8rMgXxSa3N6/QewfJi4DoE1RWBv6h0Sl8l7PDt779rjjKt
 T2s8oMdQo3S4g57Y50zvU1cN9tiOQRaTVZt6bv1dmMA+5VhihdRsVhhbzQDS7kDvtv3pllk
 FMKbL7KoDilWSaaPps6w3wdrNaMSTdA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 15E6A82220
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 24 Nov 2026 20:47:00 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795549631;
	b=FRjv8OyMv65waoupPQ7uH9b3O+apPCyaShBB+y6gPSNQ+4GLX2ANvwAWRyh9o1e4/KF3lO
	ltbidhja3xEXr6f4P9CCx4nmExulqkqvRWZJahnyCKdxX7ykA/FlhTDTe6y+BRuk9Qlu2F
	NvwbqtcBRcLhm3Lvgjr5GYiu+uDx+rg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795549631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=cJRVzTMJnlShHbcMCuLGWkT4v841qpZ2m9PE1z4Vr0s=;
	b=z6nmhWAUyBM5ScxMVKiO3+NlBcSx+yZNYyNERI3KolF/sxWsqZWYH3vvnFyp22P4qpm3pe
	bQukJWW0jNdmppHJwxdXaPD1bUAq0WOeWqu35QsZlQinVGNGbXbQGAnQmr71qczLdpWTUQ
	u/m8QRpsPfGNWP2jEw53hsWZkyzjRUA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=TUs1pWxp;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id B8B471FD15;
	Tue, 24 Nov 2026 19:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1795549619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cJRVzTMJnlShHbcMCuLGWkT4v841qpZ2m9PE1z4Vr0s=;
	b=TUs1pWxpJHdUuzx3RVFfsGPmy/ifaaMFFO91p+PtzScMW9Xb3aaKBKHHyyKkH77LdmmpRW
	RToYqifsfyP/z1YWTuFTmwzKIZgjKxSbuiKgmpvkwyeiaDhim2hjZ6ZH0po9g1JPauQdTM
	EUSOmuBy5GNSgU1JvGNsaAF3j10jDck=
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de, netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH net-next 11/15] batman-adv: tt: requeue DEL of pending
 local entry
 after failed allocation
Date: Tue, 24 Nov 2026 20:46:56 +0100
Message-ID: <9710957.CDJkKcVGEf@sven-desktop>
In-Reply-To: <179554084450.3135.11910035656981995724@kernel.org>
References: <20261123171827.3294525-12-sw@simonwunderlich.de>
 <179554084450.3135.11910035656981995724@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3374045.5fSG56mABF";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: KNRZ4ZQZCPU74UW6UU4YWBMFMVHUD6SH
X-Message-ID-Hash: KNRZ4ZQZCPU74UW6UU4YWBMFMVHUD6SH
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/KNRZ4ZQZCPU74UW6UU4YWBMFMVHUD6SH/>
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

--nextPart3374045.5fSG56mABF
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de, netdev-bot+sashiko@kernel.org
Date: Tue, 24 Nov 2026 20:46:56 +0100
Message-ID: <9710957.CDJkKcVGEf@sven-desktop>
In-Reply-To: <179554084450.3135.11910035656981995724@kernel.org>
MIME-Version: 1.0

On Tuesday, 24 November 2026 18:20:44 CET netdev-bot+sashiko@kernel.org wrote:
[...]
> > @@ -1779,13 +1793,24 @@ batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
> >  {
> >  	struct batadv_tt_common_entry *common = &tt_local_entry->common;
> >  	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
> > +	bool queued;
> >  	u32 i;
> >  
> >  	i = batadv_choose_tt(&common->key, hash->size);
> >  	lockdep_assert_held(&hash->list_locks[i]);
> >  	lockdep_assert_held(&common->flags_lock);
> >  
> > -	__batadv_tt_local_event(bat_priv, common, common->flags | flags);
> > +	queued = __batadv_tt_local_event(bat_priv, common,
> > +					 common->flags | flags);
> 
> [Severity: Low]
> This isn't a bug, but this code now relies on __batadv_tt_local_event()
> returning bool. That return value was added by the preceding patch,
> "batman-adv: tt: keep local entry unchanged when ADD can't be queued".

What? I am now not even allowed to build on top of other patches in a patch 
series? This is insane.

> The commit message doesn't mention this dependency, and there is no
> Fixes: tag. No patch in the series has a Fixes: tag, so this may be
> intentional. Is the series meant to stay out of stable?

It is in the same patch series. Why should I add a Fixes: tag? This wouldn't 
even be allowed in a submission for net-next. And when this would not be a 
pull-request then I would not even have a commit ID to use here.

> 
> > +
> > +	/* a failed attempt must not hide the still queued DEL of an already
> > +	 * pending entry
> > +	 */
> > +	if (queued)
> > +		tt_local_entry->del_unqueued = false;
> > +	else if (!(common->flags & BATADV_TT_CLIENT_PENDING))
> > +		tt_local_entry->del_unqueued = true;
> 
> [Severity: Low]
> What happens here when the entry is already BATADV_TT_CLIENT_PENDING and
> the new event carries BATADV_TT_CLIENT_ROAM?
[...]
> Say a plain DEL was already queued earlier in the same OGM interval, for
> example by the timeout in batadv_tt_local_purge_list(). The DEL+DEL
> update can still fail, because __batadv_tt_local_event() allocates
> before it looks for the queued change to merge into:
> 
> 	tt_change_node = kmem_cache_alloc(batadv_tt_change_cache, GFP_ATOMIC);
> 	if (!tt_change_node)
> 		return false;
> 
> In that case the else-if above leaves del_unqueued false. So
> batadv_tt_local_purge_list() never requeues the DEL with the ROAM flag.
[...]
> Could __batadv_tt_local_event() look up the existing change before
> allocating, so the in-place update can't fail? If not, the kernel-doc
> could say that an already pending entry only keeps its first DEL.

This is a corner case (already existing in the current code) but I will make a 
note to think about first searching the list before trying to allocate a new 
entry. https://www.open-mesh.org/issues/491

One case would remain: if the plain DEL has already been taken out of 
changes_list for the next ttvn but not yet committed, the ROAM flag is lost. 
That is unavoidable, because the DEL is already part of the announced change 
set.


> 
> > +
> >  	common->flags |= BATADV_TT_CLIENT_PENDING;
> 
> [ ... ]
> 
> > @@ -1911,11 +1936,18 @@ static void batadv_tt_local_purge_list(struct batadv_priv *bat_priv,
> >  					      common);
> >  
> >  		scoped_guard(spinlock_bh, &tt_local_entry->common.flags_lock) {
> > -			if (tt_local_entry->common.flags & BATADV_TT_CLIENT_NOPURGE)
> > +			/* entry already marked for deletion */
> > +			if (tt_local_entry->common.flags & BATADV_TT_CLIENT_PENDING) {
> > +				/* but its removal must still be announced */
> > +				if (tt_local_entry->del_unqueued)
> > +					batadv_tt_local_set_pending(bat_priv,
> > +								    tt_local_entry,
> > +								    BATADV_TT_CLIENT_DEL,
> > +								    "requeued");
> 
> [Severity: Low]
> This is a pre-existing issue and wasn't introduced by this patch. This
> requeue runs from the periodic work without tt.commit_lock.
> 
> Can it clear del_unqueued after the splice but before
> batadv_tt_local_purge_pending_clients() runs in
> batadv_tt_local_commit_changes_nolock()?

This is just a preparation for the "batman-adv: tt: commit only the announced 
local changes". It is normal that a patch at the beginning of a patch series 
doesn't have everything which is there after the patch series ended. This is 
why it is a patch series and not a patch.

Regards,
	Sven

--nextPart3374045.5fSG56mABF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCawXpsAAKCRBND3cr0xT1
y5YRAP985zfMTcYcJwkAHx7hlY9XIPohnKAfSpgMeUHOdhV9VQD/QTS3VslaZbD3
qcEXTpVYJLENsr2HJOILjrfs6H47jAc=
=Cd5q
-----END PGP SIGNATURE-----

--nextPart3374045.5fSG56mABF--



