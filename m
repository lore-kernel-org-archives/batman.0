Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C410CA5FC4
	for <batman@archiver.kernel.org>; Fri,  2 Oct 2026 17:50:17 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9A6288426F
	for <batman@archiver.kernel.org>; Fri, 02 Oct 2026 19:50:15 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1790963415;
 b=dJfuUrmLX0V/hWYiMRov+SSn6fZRJfrQq/jsRhQnDttP0rvA/GivHNTUFFLz7TnsmGlN4
 n2kE8GEYdXz4lnmFoa/0v5FIRvaC6J8YlObJXtfj9w3GWyM03yywqJdY9ReN3pvqSBtiAfJ
 Xyf7rjk6B7kogeXnKwXNyw4erCIXptw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1790963415; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=W0Ot1BcMTpNK+kbIGvFUu40hssPJaulyeB7ZBsnDB0k=;
 b=KImoAN9Iyba8mXOoiVYc8d3c2FeR5/6Y2Z1rm91trOrvUsE2FjwUFaxGU3WrLzT+bknq+
 6b2TtIdbX9H4sHmSRpAkKLd9BvnrloLAPqzyGv/kbsXXq3nEfmwxbwrfEFmJmeQlwGWHcFs
 DGTmVvzT/H5b8Qp5ELXildHqSmtd2pQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 6685380BD8
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 02 Oct 2026 19:49:56 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1790963406;
	b=GRBa/LDr9I89r/KvYdk3CF9FXWRhX19ukjnJ2uSfGm0hv+I3n0XyLbW+ocBrd9Ne+Tlhws
	x9ro7RiftlduelSQOnTOtpTfRy702gyHavgUJW0vJCTbZzlR9U2XXJHttR4BIWPvxc2m8/
	TPSlziRTirSmU1yRQqLAKUDqoLmlaGo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1790963406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=W0Ot1BcMTpNK+kbIGvFUu40hssPJaulyeB7ZBsnDB0k=;
	b=Y5J5k94pPtBhuyJv60i6au/yLUFOTgV/A+J7BCd3ldySWVhqnJeP0WnvyNyrMDEKoVsLRB
	tS1sFK+YsiZLA+KW9EnprZ4jac3DsTUtqzcvid3zVqqbL9nO/4xElx/Vawy2/ySV4XZ23v
	pkE6X3/hA2ZzWQLlTbiPaMlK7vL0U1Q=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=ibK0vntK;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 0AFE81FDE9;
	Fri, 02 Oct 2026 17:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1790963395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W0Ot1BcMTpNK+kbIGvFUu40hssPJaulyeB7ZBsnDB0k=;
	b=ibK0vntKL0fpbYO/LiE2omQ7Bwj5BXWxvZgiat4TIaVTab4TOQffOsUnA137kO5SJkQAdJ
	BC+qv9IlXN/bsSWIpsy6uQKWm2NIx56kg/s1IGbvE0SDizOKFknHTmj7iYhsZuWANXuKOb
	+7jG8koT3mBVmvVrQ5gt1UpkEKHPDcI=
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de, netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 6/9] batman-adv: tt: queue local DEL event under
 bucket
 lock
Date: Fri, 02 Oct 2026 19:49:49 +0200
Message-ID: <1891658.TLkxdtWsSY@sven-desktop>
In-Reply-To: <179084942939.434549.10348803956240291735@kernel.org>
References: <20260930094558.3723766-7-sw@simonwunderlich.de>
 <179084942939.434549.10348803956240291735@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart9737943.rMLUfLXkoz";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: BV5CJKK457P42FFIFZYOZKZOMRON5DP3
X-Message-ID-Hash: BV5CJKK457P42FFIFZYOZKZOMRON5DP3
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BV5CJKK457P42FFIFZYOZKZOMRON5DP3/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart9737943.rMLUfLXkoz
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de, netdev-bot+sashiko@kernel.org
Date: Fri, 02 Oct 2026 19:49:49 +0200
Message-ID: <1891658.TLkxdtWsSY@sven-desktop>
In-Reply-To: <179084942939.434549.10348803956240291735@kernel.org>
MIME-Version: 1.0

On Thursday, 1 October 2026 12:10:29 CEST netdev-bot+sashiko@kernel.org wrote:
[...]
> > diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
> > index c904d67791f8f..c229c51cafa72 100644
> > --- a/net/batman-adv/translation-table.c
> > +++ b/net/batman-adv/translation-table.c
> > @@ -1427,13 +1427,20 @@ int batadv_tt_local_dump(struct sk_buff *msg, struct netlink_callback *cb)
> 
> [ ... ]
> 
> >  static void
> >  batadv_tt_local_set_pending_event(struct batadv_priv *bat_priv,
> >  				  struct batadv_tt_local_entry *tt_local_entry,
> >  				  u16 flags, const char *message)
> >  {
> > +	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
> > +	u32 i;
> > +
> > +	i = batadv_choose_tt(&tt_local_entry->common, hash->size);
> > +	lockdep_assert_held(&hash->list_locks[i]);
> 
> [Severity: Medium]
> This is a pre-existing issue, but the code that clears
> BATADV_TT_CLIENT_PENDING doesn't follow the rule asserted here. Is the
> add path safe against batadv_tt_local_purge_pending_clients()?

You are inferring here something which is not written down like this. You are 
just assuming that another code path unrelated to this one must have the same 
rules. This is only partially correct because this is not yet the goal of this 
commit but might be something which could/should be the case at some point.

Overall: Outside the scope of this patch. Added a ticket about this for the 
actual maintainer of this code. Maybe he wakes up at some point. 
https://www.open-mesh.org/issues/476


> [Severity: Medium]
> This isn't a bug introduced by this patch, but what happens if the
> change node allocation fails here? batadv_tt_local_event() returns
> silently:
> 
> 	tt_change_node = kmem_cache_alloc(batadv_tt_change_cache, GFP_ATOMIC);
> 	if (!tt_change_node)
> 		return;
> 
> By then batadv_tt_local_mark_removed() has already set
> BATADV_TT_CLIENT_PENDING and will return true, so
> batadv_tt_local_remove() skips the immediate removal. No DEL is queued
> and local_changes isn't incremented. The void return leaves no way to
> undo PENDING.

And it also shouldn't undo the pending. Instead, the correct approach is to 
make sure to announce a changed CRC.

> If another change makes local_changes non-zero, the next commit's
> batadv_tt_local_purge_pending_clients() drops the entry from the table
> and the CRC. No DEL is ever announced.

The not announced DEL seems to be OK for me here. Of course, in an ideal 
world, we would have infinite RAM and never have allocation errors. But 
falling back to a full sync is a viable option.

The only thing I don't like is the delayed recalculation of the CRC on an 
allocation error. And this is caused by the precheck in 
`batadv_tt_local_commit_changes_nolock` which depends on `local_changes` 
instead of a flag which announces any potential change (even when the 
allocation for the changes announcement list failed).

Overall: outside the scope of this patch: https://www.open-mesh.org/issues/477

[...]
> [Severity: Medium]
> This is a pre-existing issue, but now that the bucket lock is taken here,
> should this also check that tt_local_entry is still hashed?
[...]
> batadv_tt_local_remove_now() already guards against this. It queues its
> DEL only after batadv_hash_remove() confirms that this exact object was
> unlinked. That check came from the earlier series commit "batman-adv: tt:
> only queue local del event after successful unlink".
> 
> Would a hlist_unhashed() check under list_lock be the equivalent here?

Ok, list_lock is already held, so it could be a worthwhile addition. 
But outside the scope of this patch: https://www.open-mesh.org/issues/478

[...]
> [Severity: High]
> Is the bucket list_lock enough to serialize this against
> batadv_tt_local_commit_changes_nolock()?
> 
> The lock only orders this code against the
> batadv_tt_local_purge_pending_clients() pass over this one bucket. The
> later phases of the commit take no bucket lock:
> batadv_tt_local_update_crc() walks the hash under RCU, and
> batadv_tt_tvlv_container_update() drains the change list. The only thing
> holding those phases together is tt.commit_lock, and
> batadv_tt_local_remove() never takes it.
> 
> That seems to leave two windows with the result the commit message says
> it avoids.

No, it doesn't say that. It never mentions batadv_tt_tvlv_container_update. 
This is outside the scope of this patch: https://www.open-mesh.org/issues/479

> [Severity: Medium]
> This isn't a bug introduced by this patch, but the immediate purge
> branch has a similar ordering problem.

Outside the scope of this patch:

* https://www.open-mesh.org/issues/475
* https://www.open-mesh.org/issues/480

Regards,
	Sven
--nextPart9737943.rMLUfLXkoz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCar/uvQAKCRBND3cr0xT1
y2r4AQCUFsIlCLRkWvAZZ9n4FFZ7ptzzqxuljezHbV6R/70aQwD+NKl10RLbqHhi
S7kcEQk5KqSF20Pm5ypn+3Y+Mju3Kwo=
=V/Zp
-----END PGP SIGNATURE-----

--nextPart9737943.rMLUfLXkoz--



