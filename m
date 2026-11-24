Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC0B606A32A
	for <batman@archiver.kernel.org>; Tue, 24 Nov 2026 21:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=VBiFhedo
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id AFC7680C5D
	for <batman@archiver.kernel.org>; Tue, 24 Nov 2026 22:03:01 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795554181;
 b=WE403o53vy/DHZEYQNpuPFcGRMCBgFKCrbyBMLHOBD13Rsix5wnaKQ9vidmEl1lNHehWS
 N5ZXfquf4P2f56Tc5sohbyVi1KddWMQKjG4wZ7u9kAtmg5C3obBqVPzpOz5TtS9My4XAKLv
 EQbgnU9j0TTiHyvQgcEIZw0uTb54BFQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795554181; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=4JGiNssiIcSVO+k5XG7/GTij0g2M1gpRrtZJ04qYbvI=;
 b=I7lMHELpuZTlhnH32KxSPj0wX5LrIMyMM8sfIb3lR375OOpSMH43lefNLwLwXWBtCRfLQ
 Eet4ccbXnWOapl7iNUEfSSwbn3fG9K9NoFmVHouYc+FE8sxsz2mvhQvhFof/MK0UWoLKF2J
 1sZKXEo3FqyOQgd+PN6gkPrAGR8C+yQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id A1C88807E4
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 24 Nov 2026 22:02:44 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795554174;
	b=s8KG1yszjw7Wa+050x9ocmNdO+6e1NKy8Hzq35oxPvYphjRHMHpl7On8wKH8PB1Z3B6vNq
	giObW7+TOOyStf4xzP2ZyK+rykzW5Oa7lkJcsvyeArqMnU0l//RgZ+/VMSva7oBSWyxjjC
	SAtwSaL4ejZnk2dNsuDupD/e52HLC5o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795554174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=4JGiNssiIcSVO+k5XG7/GTij0g2M1gpRrtZJ04qYbvI=;
	b=ASl1eoOuRX5XCW/6toHuXaZCEH4IuaL48esr+CnuenV5siZieOZopkPbgGz9iLVNAKSTzj
	XU/2cgzYqSl+WGE93inOFUFQ0fnVpc0QZ4vHIOzCZ4q/LsBGo7+p2R43WmPOuGu7rNn/Ys
	tRekUoHMnl3a4u+XvvYNz+LMssbK9JQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=VBiFhedo;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 58AA02014F;
	Tue, 24 Nov 2026 21:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1795554163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4JGiNssiIcSVO+k5XG7/GTij0g2M1gpRrtZJ04qYbvI=;
	b=VBiFhedo04EAIz/Qylw9LFm+7RRDT8VKIZchXKdAlsoVp+mSKZna2Uljn6qt1ciaWTMs/y
	xWRJSi6OPtnQcKTu+xqLSZXv4on9mFh78CIgsFkI619LkO4DpFAKpRvCKRU4LGgqAn5dDd
	jiRDNoyXGnkcr10W3+hF+3PsdtjICi8=
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de, netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH net-next 15/15] batman-adv: tt: drop ADD+DEL events of
 never
 announced clients
Date: Tue, 24 Nov 2026 22:02:41 +0100
Message-ID: <2071514.yKVeVyVuyW@sven-desktop>
In-Reply-To: <179554084949.3135.16426370585063518179@kernel.org>
References: <20261123171827.3294525-16-sw@simonwunderlich.de>
 <179554084949.3135.16426370585063518179@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2249726.OBFZWjSADL";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: EEW6ILJA2FYMA25OTY45LLWMXZBRZAVI
X-Message-ID-Hash: EEW6ILJA2FYMA25OTY45LLWMXZBRZAVI
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/EEW6ILJA2FYMA25OTY45LLWMXZBRZAVI/>
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

--nextPart2249726.OBFZWjSADL
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de, netdev-bot+sashiko@kernel.org
Date: Tue, 24 Nov 2026 22:02:41 +0100
Message-ID: <2071514.yKVeVyVuyW@sven-desktop>
In-Reply-To: <179554084949.3135.16426370585063518179@kernel.org>
MIME-Version: 1.0

On Tuesday, 24 November 2026 18:20:49 CET netdev-bot+sashiko@kernel.org wrote:
[...]
> > @@ -685,6 +692,9 @@ static bool __batadv_tt_local_event(struct batadv_priv *bat_priv,
> >  
> >  	lockdep_assert_held(&common->flags_lock);
> >  
> > +	if (cancelled)
> > +		*cancelled = false;
> > +
> >  	tt_change_node = kmem_cache_alloc(batadv_tt_change_cache, GFP_ATOMIC);
> >  	if (!tt_change_node)
> >  		return false;
> 
> [Severity: Low]
> Can the cancellation be skipped under memory pressure? In
> batadv_tt_local_event(), the new change node is allocated before
> changes_list is searched for a queued initial ADD.

See
https://patchwork.open-mesh.org/project/b.a.t.m.a.n./patch/20261124-event-late-allocation-v1-1-756780b98c10@narfation.org/

[...]
> > @@ -1883,6 +1919,11 @@ static void batadv_tt_local_unhash(struct batadv_priv *bat_priv,
> >   * retry it. Such an entry is marked as del_unqueued instead. It stays in the
> >   * local table until batadv_tt_local_purge_list() was able to queue its DEL.
> >   *
> > + * A client whose initial ADD is still queued was never announced to the other
> > + * nodes. Its DEL cancels the ADD and the entry is removed from the local table
> > + * right away. The caller has to drop the hash reference of the entry after it
> > + * released the flags_lock.
> > + *
> 
> [Severity: Low]
> This isn't a bug, but the first paragraph of the
> batadv_tt_local_set_pending() kernel-doc still reads:
> 
>  * The entry is kept in the local table until the next TTVN increment
>  * so that a consistency-check response can still be answered.
> 
> That is no longer always true with the new cancel path. Only this later
> paragraph mentions the exception.
> 
> The summary line of batadv_tt_local_remove() also still says "logically
> remove an entry from the local table". Through
> batadv_tt_local_remove()->batadv_tt_local_remove_entry()->
> batadv_tt_local_set_pending(), the entry can now be unhashed and freed
> before any TTVN increment.
> 
> Could both comments be updated? The callers of batadv_tt_local_remove()
> in mesh-interface.c and multicast.c rely on that description.

Will send a follow up patch:

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 7de69a30dda5de8f3e875acc21e4edfada838c9c..d69e5380f461c73443ddee949a2698ee02b8c0bf 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1964,8 +1964,9 @@ static void batadv_tt_local_unhash(struct batadv_priv *bat_priv,
  * @message: debug message describing the reason for the change
  *
  * Schedule the TT change announcement and set BATADV_TT_CLIENT_PENDING on the
- * entry. The entry is kept in the local table until the next TTVN increment
- * so that a consistency-check response can still be answered.
+ * entry. An entry which was already announced to the other nodes is kept in
+ * the local table until its DEL is committed with a TTVN increment so that a
+ * consistency-check response can still be answered.
  *
  * The entry is also marked as BATADV_TT_CLIENT_PENDING when the DEL could not
  * be queued. The removal must not be lost because not all callers are able to
@@ -2106,13 +2107,19 @@ batadv_tt_local_remove_entry(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_tt_local_remove() - logically remove an entry from the local table
+ * batadv_tt_local_remove() - remove an entry from the local table
  * @bat_priv: the bat priv with all the mesh interface information
  * @addr: the MAC address of the client to remove
  * @vid: VLAN identifier
  * @message: message to append to the log on deletion
  * @roaming: true if the deletion is due to a roaming event
  *
+ * An entry which was already announced to the other nodes is only removed
+ * logically. It is marked as BATADV_TT_CLIENT_PENDING and stays in the local
+ * table until its DEL is committed. An entry whose initial ADD is still queued
+ * is removed from the local table immediately. See
+ * batadv_tt_local_remove_entry() for details.
+ *
  * Return: the flags assigned to the local entry before being deleted
  */
 u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,

> 
> [ ... ]
> 
> > @@ -1907,8 +1952,13 @@ batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
> >  	lockdep_assert_held(&hash->list_locks[i]);
> >  	lockdep_assert_held(&common->flags_lock);
> >  
> > -	queued = __batadv_tt_local_event(bat_priv, common,
> > -					 common->flags | flags);
> > +	queued = batadv_tt_local_event(bat_priv, common, common->flags | flags,
> > +				       false, &cancelled);
> > +	if (cancelled) {
> > +		/* the entry was never announced */
> > +		batadv_tt_local_unhash(bat_priv, tt_local_entry, message);
> > +		return true;
> > +	}
> 
> [Severity: Low]
> Does this hold when the DEL comes from a roaming event? The commit
> message says:
> 
>   The other nodes never heard about the client and don't need a DEL
>   for it.
[...]

There is too much text for a low severity at this time of day. Just made a 
note for later: https://www.open-mesh.org/issues/493

Regards,
	Sven

--nextPart2249726.OBFZWjSADL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCawX7cQAKCRBND3cr0xT1
y50yAQDNQi+vtGSntlly8ShE3zzrK3+CZsHKQhJwg55Dds1DTgEA4K3LIwpHjAc+
91zj5Z+iAsW5VREI+Qgz6IsDpH/xzQg=
=MVS0
-----END PGP SIGNATURE-----

--nextPart2249726.OBFZWjSADL--



