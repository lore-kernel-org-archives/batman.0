Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E8C606A31B
	for <batman@archiver.kernel.org>; Tue, 27 Oct 2026 13:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=cXezh2H/
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7F489806EC
	for <batman@archiver.kernel.org>; Tue, 27 Oct 2026 14:31:43 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793107903;
 b=A9D6wonGfJ/quqHuRfW1x5T0GFrH+sD1Xl9+lKzab3L23t9Vs8POJHnvMh/ZSlHlYC3h/
 dr2sHlz2Drzd2D+hMVZvD0GvKk+tR9S/8ftyPFsJVNcZvEhlaRQxqOU+eK9Vu3HD+wXWhbI
 aZySERzOQn2WoaMgqGnESeGRIeq0rko=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793107903; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=CtmBFZqy7yb/5wYHUpcMRHp04sS85G1RGMRlAVhNk2A=;
 b=RmyWuPRCDIvxC3p2321fBW3sJRmpDBDdISV7tVCLjMuVpGawkn6uR+BbBeBGOJSaJqY8f
 Ir8R12E1QzKQRKyNn5L/XB1uPMQhN9iNb8ZM406lJtm3d+CrlqWHK0J8kcJW3swu7ytiNtc
 OInTmYapgU4zXvVwBFbZXAUU4jQhSbo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id A6064806EC
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 27 Oct 2026 14:31:28 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793107888;
	b=UW4ZHA0QZj1Hk6D5dsGu9R2qik3l/LCpnBZynqht5f7RLMJnQIP4rUDY5pqvP73r7bC148
	cHXuAbCfNKaQQubv1mFQCuCvunvGHW40owpLkA4Q32LWEf0/dUCjVCWI5OwOuPRB02cxrx
	hNxywwjq24t/5jWeYtpub6EF1nDk5Bc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793107888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=CtmBFZqy7yb/5wYHUpcMRHp04sS85G1RGMRlAVhNk2A=;
	b=3+mxM7bIDbutFLrhcnHQ4C+w27BhzqxK+Nl1MO2eMpirEGGt2WE5BjDo+J9BCcONMe2aDe
	QO+O7n6yuyxnOZPD3nzSXARU3GdbotgPCLUlAJnoC2HZ1u4TQ/zro+vXVxDpselKpLhgLI
	cz5YTWi6bhSmI7yBhBxp1dKosqXEGL0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="cXezh2H/";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 0D7801FF1F;
	Tue, 27 Oct 2026 13:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1793107888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CtmBFZqy7yb/5wYHUpcMRHp04sS85G1RGMRlAVhNk2A=;
	b=cXezh2H/E7GewGqyaKqbpKa1w11CeXbx9IMUt3T/mRS60BwkE7jF4zMa2QIXe5S02UgcA7
	bqPEq2xhWCnJRcSD1RsrGGVzcezhxXyrKOhs2PXsElBtybJx0aU+sKTsnJyO1IfIFuBSZy
	oA4wBBQ08Jt0Fj+K+8GMH+TBx3BnaTk=
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de, netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sashiko-bot@kernel.org
Subject: Re: [PATCH net 09/10] batman-adv: tt: don't drop local events queued
 during
 TVLV update
Date: Tue, 27 Oct 2026 14:31:25 +0100
Message-ID: <3709090.V25eIC5XRa@ripper>
In-Reply-To: <179309132364.3134.18203109296409373363@kernel.org>
References: <20261026085309.1074911-10-sw@simonwunderlich.de>
 <179309132364.3134.18203109296409373363@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3771355.LM0AJKV5NW";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: ME32XEDBBLHCSFNWKHNCWTW64C7LN2FD
X-Message-ID-Hash: ME32XEDBBLHCSFNWKHNCWTW64C7LN2FD
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ME32XEDBBLHCSFNWKHNCWTW64C7LN2FD/>
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

--nextPart3771355.LM0AJKV5NW
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de, netdev-bot+sashiko@kernel.org
Date: Tue, 27 Oct 2026 14:31:25 +0100
Message-ID: <3709090.V25eIC5XRa@ripper>
In-Reply-To: <179309132364.3134.18203109296409373363@kernel.org>
MIME-Version: 1.0

On Tuesday, 27 October 2026 09:55:23 CET netdev-bot+sashiko@kernel.org wrote:
[...]
> > diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
> > index 24054077cf3db..6774484f1c573 100644
> > --- a/net/batman-adv/translation-table.c
> > +++ b/net/batman-adv/translation-table.c
> > @@ -1327,11 +1327,18 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
> >  	int tt_diff_entries_num = 0;
> >  	bool drop_changes = false;
> >  	size_t tt_extra_len = 0;
> > +	LIST_HEAD(changes_list);
> >  	int tt_change_len = 0;
> >  	int tt_diff_len;
> >  	u16 tvlv_len;
> >
> > +	/* atomically get the list of changes */
> > +	spin_lock_bh(&bat_priv->tt.changes_list_lock);
> > +	list_splice_init(&bat_priv->tt.changes_list, &changes_list);
> >  	tt_diff_entries_num = READ_ONCE(bat_priv->tt.local_changes);
> > +	WRITE_ONCE(bat_priv->tt.local_changes, 0);
> > +	spin_unlock_bh(&bat_priv->tt.changes_list_lock);
> 
> [Severity: Medium]
> This isn't a bug introduced by this patch, but the window left open at the
> end of the commit message seems to have a worse effect than described. An
> event in that window can be lost, not just announced under the wrong TTVN
> or CRC.
> 
> batadv_tt_local_commit_changes_nolock() makes its decisions from a lockless
> read, before this splice happens:
[...]
> Would either of these close the window: taking the snapshot in
> batadv_tt_local_commit_changes_nolock() before the local_changes check and
> passing the list down, or not consuming the list in the non-committing
> branch?

Out-of-scope for this patch and handled in another pending patch

https://patchwork.open-mesh.org/project/b.a.t.m.a.n./patch/20261025-tt-tvlv-changes-check-v1-1-c12b246c0956@narfation.org/

> [ ... ]
> 
> > @@ -1349,19 +1356,23 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
> >
> >  	tvlv_len = batadv_tt_prepare_tvlv_local_data(bat_priv, &tt_data,
> >  						     &tt_change, &tt_diff_len);
> > -	if (!tvlv_len)
> > +	if (!tvlv_len) {
> > +		/* the TTVN of the changes is lost and the other nodes will
> > +		 * have to request the full table anyway
> > +		 */
> > +		list_for_each_entry_safe(entry, safe, &changes_list, list) {
> > +			list_del(&entry->list);
> > +			kmem_cache_free(batadv_tt_change_cache, entry);
> > +		}
> >  		return;
> > +	}
> 
> [Severity: Low]
> Does this statement in the commit message hold when the node is idle?
> 
>   "The changes can no longer be kept for the next round when the TVLV
>   buffer allocation fails. But they would be sent with a skipped TTVN
>   anyway, so the other nodes have to request the full table in this case
>   either way."
> 
> When batadv_tt_prepare_tvlv_local_data() fails here, the caller
> batadv_tt_local_commit_changes_nolock() has already bumped tt.vn to N,
> updated the CRCs and reset ogm_append_cnt to BATADV_TT_OGM_APPEND_MAX. No
> new container is registered, so OGMs keep carrying the old container (ttvn
> N-1 with the old CRCs).
[...]
> Before this patch, the !tvlv_len return left the list and counter in place.
> The next interval then bumped the TTVN to N+1, and peers saw the skipped
> TTVN immediately.

Why would the first round fail and the second round not? Please don't start 
with kmalloc-failures - this would open a completely different can of worms 
related to containers and OGMs.

> With this change, can peers learn about the committed local changes several
> OGM intervals later, with no TTVN skipped at all? Re-queueing the changes
> isn't simple because __batadv_tt_local_event() expects at most one queued
> change per (addr, vid). Would it be enough to force a TTVN bump or commit in
> the next round instead?

What is proposed here?

        if (!tvlv_len) {
                /* the changes are lost and the other nodes have to request the
                 * full table. Announce the new TTVN in the next OGM interval
                 * and don't answer TT requests for it with the stale changeset
                 * of the previous TTVN
                 */
                list_for_each_entry_safe(entry, safe, &changes_list, list) {
                        list_del(&entry->list);
                        kmem_cache_free(batadv_tt_change_cache, entry);
                }

                spin_lock_bh(&bat_priv->tt.last_changeset_lock);
                kfree(bat_priv->tt.last_changeset);
                bat_priv->tt.last_changeset = NULL;
                bat_priv->tt.last_changeset_len = 0;
                spin_unlock_bh(&bat_priv->tt.last_changeset_lock);

                /* announce the already committed TTVN in the next OGM interval
                 * instead of waiting for BATADV_TT_OGM_APPEND_MAX idle rounds
                 */
                atomic_set(&bat_priv->tt.ogm_append_cnt, 0);
                return;
        }

https://www.open-mesh.org/issues/485
https://patchwork.open-mesh.org/project/b.a.t.m.a.n./patch/20261027-tt-tvlv-alloc-fail-v1-1-02058bcc4595@narfation.org/

> 
> [Severity: Medium]
> Can this error path leave a stale bat_priv->tt.last_changeset that is later
> served under the new TTVN?

Which it did even before the patch

[...]
> The new comment says "the other nodes will have to request the full table
> anyway", but here the first request is a diff request.

Which makes the statements untrue because of "first request"? Which is not
even mentioned in the comment.

> Should this path
> free last_changeset and set it to NULL under last_changeset_lock, or force
> the next round to bump the TTVN?

https://www.open-mesh.org/issues/485

Regards,
	Sven

--nextPart3771355.LM0AJKV5NW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCauCnrQAKCRBND3cr0xT1
y950AQDuGG0HAjKHF4ix691UqCNIHbtVk+Us9my7NayEmeo/2QD+NrUQvy8K/xI8
lvqkE8wvR7H+r9c4YCn9u+oNkcR8cwQ=
=Se1b
-----END PGP SIGNATURE-----

--nextPart3771355.LM0AJKV5NW--



