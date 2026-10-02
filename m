Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F40CA5FDD
	for <batman@archiver.kernel.org>; Fri,  2 Oct 2026 20:05:34 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 01678825D1
	for <batman@archiver.kernel.org>; Fri, 02 Oct 2026 22:05:33 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1790971532;
 b=iMe6Oh2HU81H7D02hVmCRPxm7Ll8LjAaUSojxRhT3aYx++QBMqVF8hUC2vWfblT91TT2/
 UKFXRBsMYiGkD5ImdCp7bgmh0LqiUm6iIydTVKTfLppOm9Fbn6+dt/255n842tsBA+aNkol
 7tWQoSh5S7XoL/mItxJ2wlAqomuKk3o=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1790971532; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=wcUO1KqOxLwPlfyol9Ho5w6j05a+/NVsUqDFy9GC+6k=;
 b=QIgyjgf6gpROLY+itJvW5EAkyS+7SerG64VKusw0x/lxmcc1xDA0hR2E8FpM7HNqlwFaZ
 Vg0/H19hsj0e8v9vlBfjEDr2j+WBZykCfjUScgfoxThCpzTs6uA+9OsokqJDZZI/XtmQO2o
 EpE2Sq+UcwlLTT8tlJV2gbsfwhaN1UY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 1177382534
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 02 Oct 2026 22:05:11 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1790971522;
	b=vuRBT8cPDUNlpLzKm+do6GvhLcLsS6+g6FWVhvhFCYz1Y2H7v2wQ8ExEA6rJGdUwwmvftX
	uFEYW10mf1fw7i9hC+FQEaa60oGCa7tVhbOlkeulgzaTLFZK70NUgbLvQh+cnDtdF4hqpi
	GGCQSBCCoca33wr9RIlnMeaXTl8vN6U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1790971522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=wcUO1KqOxLwPlfyol9Ho5w6j05a+/NVsUqDFy9GC+6k=;
	b=tr87wFj+cNk45CGm/FCDUHhSnkF2urKBg5qa/o6kDB20P/3I0YkE46nRNPGrRbb6MSEks6
	pRwYegslZFiilWvvoG8yJvyIUrKD7d63NSjjl9N8yihnMZsGdxbIIjimX+TH+jtRflJTr3
	gqFav9+dF7OVLRxyvir/scjH9eKkPTc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=zWI2SvuE;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 7636A20292;
	Fri, 02 Oct 2026 20:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1790971510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wcUO1KqOxLwPlfyol9Ho5w6j05a+/NVsUqDFy9GC+6k=;
	b=zWI2SvuEwRY+TwMnd5Mep9mnJxJjnMYKKi2EOhCnjTzlFbkzQmFrs+59AfBipDS3hHes08
	Ee+bYMhTmEiceTjwCmOCioLedpK66bf8+qb2BSsFBzvf/o/RKQgxD+qIAzTdqk5q65XH1m
	G/MroTUJS8CiW53gQysCeQi9bMBtvqw=
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de, netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 7/9] batman-adv: tt: queue local DEL event before
 marking
 entry as pending
Date: Fri, 02 Oct 2026 22:05:07 +0200
Message-ID: <39803813.XM6RcZxFsP@sven-desktop>
In-Reply-To: <179084943057.434549.7181634875043920373@kernel.org>
References: <20260930094558.3723766-8-sw@simonwunderlich.de>
 <179084943057.434549.7181634875043920373@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2010014.IobQ9Gjlxr";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: YVHIOMDSICZ7IZQVQK2VE6TXXICKCNOI
X-Message-ID-Hash: YVHIOMDSICZ7IZQVQK2VE6TXXICKCNOI
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/YVHIOMDSICZ7IZQVQK2VE6TXXICKCNOI/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart2010014.IobQ9Gjlxr
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: sw@simonwunderlich.de, netdev-bot+sashiko@kernel.org
Date: Fri, 02 Oct 2026 22:05:07 +0200
Message-ID: <39803813.XM6RcZxFsP@sven-desktop>
In-Reply-To: <179084943057.434549.7181634875043920373@kernel.org>
MIME-Version: 1.0

On Thursday, 1 October 2026 12:10:30 CEST netdev-bot+sashiko@kernel.org wrote:
[...]
> > diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
> > index c229c51cafa72..481dc6afaaba1 100644
> > --- a/net/batman-adv/translation-table.c
> > +++ b/net/batman-adv/translation-table.c
> 
> [ ... ]
> 
> > @@ -1420,28 +1433,37 @@ int batadv_tt_local_dump(struct sk_buff *msg, struct netlink_callback *cb)
> >  }
> >  
> >  /**
> > - * batadv_tt_local_set_pending_event() - trigger events for TT pending removal
> > + * batadv_tt_local_set_pending() - mark local TT entry as pending removal
> >   * @bat_priv: the bat priv with all the mesh interface information
> > - * @tt_local_entry: local TT entry which was marked as BATADV_TT_CLIENT_PENDING
> > + * @tt_local_entry: local TT entry to mark as BATADV_TT_CLIENT_PENDING
> >   * @flags: TT change flags to announce together with the pending removal
> >   * @message: debug message describing the reason for the change
> >   *
> > - * Schedule the TT change announcement for the entry. The caller must already
> > - * have added BATADV_TT_CLIENT_PENDING to the @tt_local_entry and must hold the
> > - * hash bucket list_lock of @tt_local_entry since setting the flag.
> > + * Schedule the TT change announcement and set BATADV_TT_CLIENT_PENDING on the
> > + * entry. The entry is kept in the local table until the next TTVN increment
> > + * so that a consistency-check response can still be answered.
> > + *
> > + * Next to the flags_lock of the entry, the caller must hold the hash bucket
> > + * list_lock of @tt_local_entry. Otherwise
> > + * batadv_tt_local_purge_pending_clients() could remove the entry before its
> > + * change was queued.
> 
> [Severity: Low]
> Is this rationale still accurate after the reordering?
> 
> With this patch, batadv_tt_local_set_pending() queues the event and then
> sets BATADV_TT_CLIENT_PENDING, and both happen inside one
> common->flags_lock section:
> 
>     __batadv_tt_local_event(bat_priv, common, common->flags | flags);
>     common->flags |= BATADV_TT_CLIENT_PENDING;
> 
> batadv_tt_local_purge_pending_clients() only acts on PENDING after
> reading it under the same flags_lock:
> 
>     scoped_guard(spinlock_bh, &tt_common->flags_lock) {
>         if (!(tt_common->flags & BATADV_TT_CLIENT_PENDING)) {
> 
> So it looks like purge_pending_clients() cannot see PENDING before the
> change is queued, whether or not list_lock is held.

The list_lock comes from the previous statement and only the flags_lock part 
was added. The list_lock one comes from the parallel 
batadv_tt_local_commit_changes() -> batadv_tt_local_purge_pending_clients(). 
And it was previously better to have the list lock because 
batadv_tt_local_event and batadv_tt_local_purge_pending_clients only held it 
for a short period of time. But the list_lock was held over the whole time in 
batadv_tt_local_purge_pending_clients() and now still held for 
batadv_tt_local_mark_removed(). A request which actually came from Sashiko.

I consider removing/rewriting this statement at a later point when simplifying 
the locking situation with batadv_tt_local_set_pending() and 
batadv_tt_local_mark_removed(). But it needs a further review of 
batadv_tt_local_commit_changes() to make sure that it doesn't reintroduce the 
previous problems.

But since this needs further checking, it is outside the scope of this patch. 
And maybe it doesn't even work out (see below)


> [Severity: High]
> Does this close only one ordering of the race with the re-add path?

Yes, which is exactly the scope of the patch.

> 
> The add side still changes the flags and queues the ADD in two separate
> steps. batadv_tt_local_add_existing() clears PENDING inside a flags_lock
> scoped_guard and returns. batadv_tt_local_add() then queues the ADD after
> that lock is dropped:
> 
>     if (added)
>         batadv_tt_local_event(bat_priv, tt_local, BATADV_NO_FLAGS);
>     ...
>     if (batadv_tt_local_update_flags(bat_priv, tt_local, iif_is_wifi, mark))
>         batadv_tt_local_event(bat_priv, tt_local, BATADV_NO_FLAGS);

This part is outside the scope of this patch:
https://www.open-mesh.org/issues/481

It would be really invasive because it is not enough to just have a single 
region with list_lock held which then checks for batadv_tt_local_add if 
"common->flags & BATADV_TT_CLIENT_PENDING" is not set before running 
__batadv_tt_local_event() but also needs to hold the list_lock to avoid that 
batadv_tt_local_remove_now() queues a DEL when a new entry was already added. 
Or to avoid that batadv_tt_local_add() added the newly allocated entry which 
was then removed again by something like batadv_tt_local_remove_now() before 
it checks for "!common->flags & BATADV_TT_CLIENT_PENDING" and queues the 
event.

Something like:

diff --git c/net/batman-adv/translation-table.c w/net/batman-adv/translation-table.c
index e46040fd..14e095d5 100644
--- c/net/batman-adv/translation-table.c
+++ w/net/batman-adv/translation-table.c
@@ -925,55 +925,6 @@ static bool batadv_tt_iif_is_wifi(struct net *net, int ifindex)
 	return batadv_is_wifi(wifi_flags);
 }
 
-/**
- * batadv_tt_local_add_existing() - refresh an already known local TT entry
- * @bat_priv: the bat priv with all the mesh interface information
- * @tt_local: the local TT entry which was found in the local table
- * @roamed_back: set to true when the client returned to its original location
- *
- * Return: true when the client has to be announced to the mesh again, false
- * otherwise.
- */
-static bool batadv_tt_local_add_existing(struct batadv_priv *bat_priv,
-					 struct batadv_tt_local_entry *tt_local,
-					 bool *roamed_back)
-{
-	struct batadv_tt_common_entry *common = &tt_local->common;
-
-	tt_local->last_seen = jiffies;
-
-	scoped_guard(spinlock_bh, &common->flags_lock) {
-		if (common->flags & BATADV_TT_CLIENT_PENDING) {
-			batadv_dbg(BATADV_DBG_TT, bat_priv,
-				   "Re-adding pending client %pM (vid: %d)\n",
-				   common->addr, batadv_print_vid(common->vid));
-			/* whatever the reason why the PENDING flag was set,
-			 * this is a client which was enqueued to be removed in
-			 * this orig_interval. Since it popped up again, the
-			 * flag can be reset like it was never enqueued
-			 */
-			common->flags &= ~BATADV_TT_CLIENT_PENDING;
-
-			return true;
-		}
-
-		if (common->flags & BATADV_TT_CLIENT_ROAM) {
-			batadv_dbg(BATADV_DBG_TT, bat_priv,
-				   "Roaming client %pM (vid: %d) came back to its original location\n",
-				   common->addr, batadv_print_vid(common->vid));
-			/* the ROAM flag is set because this client roamed away
-			 * and the node got a roaming_advertisement message. Now
-			 * that the client popped up again at its original
-			 * location such flag can be unset
-			 */
-			common->flags &= ~BATADV_TT_CLIENT_ROAM;
-			*roamed_back = true;
-		}
-	}
-
-	return false;
-}
-
 /**
  * batadv_tt_local_create() - allocate and initialize a local TT entry
  * @mesh_iface: netdev struct of the mesh interface
@@ -1046,27 +997,72 @@ batadv_tt_local_create(struct net_device *mesh_iface, const u8 *addr,
 }
 
 /**
- * batadv_tt_local_update_flags() - update the dynamic flags of a local entry
+ * batadv_tt_local_refresh() - refresh a local TT entry of an active client
  * @bat_priv: the bat priv with all the mesh interface information
- * @tt_local: the local TT entry to update
+ * @tt_local: the local TT entry to refresh
  * @iif_is_wifi: whether the client is connected via a wifi interface
  * @mark: the value contained in the skb->mark field of the received packet (if
  *  any)
+ * @announce: whether an ADD event has to be queued even when no announced
+ *  flag was modified
+ * @roamed_back: set to true when the client returned to its original location
  *
- * Return: true if a flag announced to the other nodes was modified, false
- * otherwise.
+ * TODO
+ *
+ * Return: true if the entry was refreshed, false if it is no longer part of
+ * the local table.
  */
 static bool
-batadv_tt_local_update_flags(struct batadv_priv *bat_priv,
-			     struct batadv_tt_local_entry *tt_local,
-			     bool iif_is_wifi, u32 mark)
+batadv_tt_local_refresh(struct batadv_priv *bat_priv,
+			struct batadv_tt_local_entry *tt_local,
+			bool iif_is_wifi, u32 mark, bool announce,
+			bool *roamed_back)
 {
+	spinlock_t *list_lock; /* protects write access to the hash lists */
 	struct batadv_tt_common_entry *common = &tt_local->common;
+	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
 	u8 remote_flags;
 	u32 match_mark;
-	bool modified;
+	u32 i;
+
+	i = batadv_choose_tt(common, hash->size);
+	list_lock = &hash->list_locks[i];
+
+	tt_local->last_seen = jiffies;
+
+	spin_lock_bh(list_lock);
+
+	/* the entry was removed from the local table after it was looked up */
+	if (hlist_unhashed(&common->hash_entry)) {
+		spin_unlock_bh(list_lock);
+		return false;
+	}
 
 	scoped_guard(spinlock_bh, &common->flags_lock) {
+		if (common->flags & BATADV_TT_CLIENT_PENDING) {
+			batadv_dbg(BATADV_DBG_TT, bat_priv,
+				   "Re-adding pending client %pM (vid: %d)\n",
+				   common->addr, batadv_print_vid(common->vid));
+			/* whatever the reason why the PENDING flag was set,
+			 * this is a client which was enqueued to be removed in
+			 * this orig_interval. Since it popped up again, the
+			 * flag can be reset like it was never enqueued
+			 */
+			common->flags &= ~BATADV_TT_CLIENT_PENDING;
+			announce = true;
+		} else if (common->flags & BATADV_TT_CLIENT_ROAM) {
+			batadv_dbg(BATADV_DBG_TT, bat_priv,
+				   "Roaming client %pM (vid: %d) came back to its original location\n",
+				   common->addr, batadv_print_vid(common->vid));
+			/* the ROAM flag is set because this client roamed away
+			 * and the node got a roaming_advertisement message. Now
+			 * that the client popped up again at its original
+			 * location such flag can be unset
+			 */
+			common->flags &= ~BATADV_TT_CLIENT_ROAM;
+			*roamed_back = true;
+		}
+
 		/* store the current remote flags before altering them. This
 		 * helps understanding is flags are changing or not
 		 */
@@ -1088,10 +1084,17 @@ batadv_tt_local_update_flags(struct batadv_priv *bat_priv,
 		else
 			common->flags &= ~BATADV_TT_CLIENT_ISOLA;
 
-		modified = remote_flags ^ (common->flags & BATADV_TT_REMOTE_MASK);
+		if (remote_flags ^ (common->flags & BATADV_TT_REMOTE_MASK))
+			announce = true;
+
+		if (announce)
+			__batadv_tt_local_event(bat_priv, common,
+						common->flags);
 	}
 
-	return modified;
+	spin_unlock_bh(list_lock);
+
+	return true;
 }
 
 /**
@@ -1114,7 +1117,6 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 	struct batadv_tt_global_entry *tt_global = NULL;
 	struct batadv_tt_local_entry *tt_local;
 	bool roamed_back = false;
-	bool added = false;
 	bool iif_is_wifi;
 	bool ret = false;
 	int hash_added;
@@ -1126,10 +1128,15 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 	if (!is_multicast_ether_addr(addr))
 		tt_global = batadv_tt_global_hash_find(bat_priv, addr, vid);
 
-	if (tt_local) {
-		added = batadv_tt_local_add_existing(bat_priv, tt_local,
-						     &roamed_back);
-	} else {
+	if (tt_local &&
+	    !batadv_tt_local_refresh(bat_priv, tt_local, iif_is_wifi, mark,
+				     false, &roamed_back)) {
+		/* stale entry which has to be replaced by a new one */
+		batadv_tt_local_entry_put(tt_local);
+		tt_local = NULL;
+	}
+
+	if (!tt_local) {
 		tt_local = batadv_tt_local_create(mesh_iface, addr, vid, iif_is_wifi);
 		if (!tt_local)
 			goto out;
@@ -1145,21 +1152,12 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 			goto out;
 		}
 
-		added = true;
+		batadv_tt_local_refresh(bat_priv, tt_local, iif_is_wifi, mark,
+					true, &roamed_back);
 	}
 
-	/* announce the (re-)added client to the mesh */
-	if (added)
-		batadv_tt_local_event(bat_priv, tt_local, BATADV_NO_FLAGS);
-
 	batadv_tt_local_add_roam(bat_priv, tt_global, roamed_back);
 
-	/* if any "dynamic" flag has been modified, resend an ADD event for this
-	 * entry so that all the nodes can get the new flags
-	 */
-	if (batadv_tt_local_update_flags(bat_priv, tt_local, iif_is_wifi, mark))
-		batadv_tt_local_event(bat_priv, tt_local, BATADV_NO_FLAGS);
-
 	ret = true;
 out:
 	batadv_tt_local_entry_put(tt_local);
@@ -1624,14 +1622,7 @@ int batadv_tt_local_dump(struct sk_buff *msg, struct netlink_callback *cb)
  * @flags: TT change flags to announce together with the pending removal
  * @message: debug message describing the reason for the change
  *
- * Schedule the TT change announcement and set BATADV_TT_CLIENT_PENDING on the
- * entry. The entry is kept in the local table until the next TTVN increment
- * so that a consistency-check response can still be answered.
- *
- * Next to the flags_lock of the entry, the caller must hold the hash bucket
- * list_lock of @tt_local_entry. Otherwise
- * batadv_tt_local_purge_pending_clients() could remove the entry before its
- * change was queued.
+ * TODO
  */
 static void
 batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
@@ -1664,14 +1655,9 @@ batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
  * @roaming: true if the deletion is due to a roaming event
  * @curr_flags: pointer to store the flags of the entry before it was marked
  *
- * An already announced entry is marked as BATADV_TT_CLIENT_PENDING and the
- * (roamed) DEL change is queued. Both happen under the hash bucket list_lock
- * of the entry to prevent concurrent batadv_tt_local_purge_pending_clients()
- * from removing the entry and batadv_tt_local_transition_new() from clearing
- * BATADV_TT_CLIENT_NEW after it was checked.
+ * TODO
  *
- * Return: true if the entry has to be kept in the local table until the next
- * ttvn increment, false if it can be purged immediately.
+ * Return: false if the entry has to be purged immediately, true otherwise.
  */
 static bool
 batadv_tt_local_mark_removed(struct batadv_priv *bat_priv,
@@ -1690,6 +1676,12 @@ batadv_tt_local_mark_removed(struct batadv_priv *bat_priv,
 
 	spin_lock_bh(list_lock);
 
+	if (hlist_unhashed(&common->hash_entry)) {
+		*curr_flags = BATADV_NO_FLAGS;
+		spin_unlock_bh(list_lock);
+		return true;
+	}
+
 	scoped_guard(spinlock_bh, &common->flags_lock) {
 		*curr_flags = common->flags;
 
@@ -1733,15 +1725,24 @@ static void
 batadv_tt_local_remove_now(struct batadv_priv *bat_priv,
 			   struct batadv_tt_local_entry *tt_local_entry)
 {
+	spinlock_t *list_lock; /* protects write access to the hash lists */
 	struct batadv_tt_common_entry *common = &tt_local_entry->common;
-	struct hlist_node *tt_removed_node;
+	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
+	u32 i;
+
+	i = batadv_choose_tt(common, hash->size);
+	list_lock = &hash->list_locks[i];
+
+	spin_lock_bh(list_lock);
 
 	/* remove exactly this object when still present in hash */
-	tt_removed_node = batadv_hash_remove(bat_priv->tt.local_hash,
-					     batadv_compare_tt_entry,
-					     batadv_choose_tt, common);
-	if (!tt_removed_node)
+	if (hlist_unhashed(&common->hash_entry)) {
+		spin_unlock_bh(list_lock);
 		return;
+	}
+
+	hlist_del_init_rcu(&common->hash_entry);
+	atomic_inc(&hash->generation);
 
 	batadv_tt_local_event(bat_priv, tt_local_entry, BATADV_TT_CLIENT_DEL);
 
@@ -1752,6 +1753,8 @@ batadv_tt_local_remove_now(struct batadv_priv *bat_priv,
 	if (!(batadv_tt_flags_get(common) & BATADV_TT_CLIENT_NEW))
 		batadv_tt_local_size_dec(bat_priv, common->vid);
 
+	spin_unlock_bh(list_lock);
+
 	/* drop reference of remove hash entry */
 	batadv_tt_local_entry_put(tt_local_entry);
 }
@@ -1881,7 +1884,7 @@ static void batadv_tt_local_table_free(struct batadv_priv *bat_priv)
 		spin_lock_bh(list_lock);
 		hlist_for_each_entry_safe(tt_common_entry, node_tmp,
 					  head, hash_entry) {
-			hlist_del_rcu(&tt_common_entry->hash_entry);
+			hlist_del_init_rcu(&tt_common_entry->hash_entry);
 			tt_local = container_of(tt_common_entry,
 						struct batadv_tt_local_entry,
 						common);
@@ -4434,7 +4437,7 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 					   tt_common->addr,
 					   batadv_print_vid(tt_common->vid));
 
-				hlist_del_rcu(&tt_common->hash_entry);
+				hlist_del_init_rcu(&tt_common->hash_entry);
 
 				/* An entry which still carries BATADV_TT_CLIENT_NEW was
 				 * never counted and must not be uncounted here.





And it could be a good idea to have a fast-path because tt_local_add will 
otherwise choke easily on the shared list lock:


diff --git c/net/batman-adv/translation-table.c w/net/batman-adv/translation-table.c
index 14e095d5..2ab66601 100644
--- c/net/batman-adv/translation-table.c
+++ w/net/batman-adv/translation-table.c
@@ -996,6 +996,48 @@ batadv_tt_local_create(struct net_device *mesh_iface, const u8 *addr,
 	return tt_local;
 }
 
+#define BATADV_TT_LOCAL_DYNAMIC_MASK \
+	(BATADV_TT_CLIENT_WIFI | BATADV_TT_CLIENT_ISOLA)
+
+static u16 batadv_tt_local_dynamic_flags(struct batadv_priv *bat_priv,
+					 bool iif_is_wifi, u32 mark)
+{
+	u16 flags = 0;
+	u32 match_mark;
+
+	if (iif_is_wifi)
+		flags |= BATADV_TT_CLIENT_WIFI;
+
+	/* check the mark in the skb: if it's equal to the configured
+	 * isolation_mark, it means the packet is coming from an
+	 * isolated non-mesh client
+	 */
+	match_mark = (mark & bat_priv->isolation_mark_mask);
+	if (bat_priv->isolation_mark_mask &&
+	    match_mark == bat_priv->isolation_mark)
+		flags |= BATADV_TT_CLIENT_ISOLA;
+
+	return flags;
+}
+
+static bool
+batadv_tt_local_refresh_needed(struct batadv_tt_local_entry *tt_local,
+			       u16 dynamic_flags)
+{
+	struct batadv_tt_common_entry *common = &tt_local->common;
+	u16 flags;
+
+	flags = batadv_tt_flags_get(common);
+
+	if (flags & (BATADV_TT_CLIENT_PENDING | BATADV_TT_CLIENT_ROAM))
+		return true;
+
+	if ((flags & BATADV_TT_LOCAL_DYNAMIC_MASK) != dynamic_flags)
+		return true;
+
+	return hlist_unhashed_lockless(&common->hash_entry);
+}
+
 /**
  * batadv_tt_local_refresh() - refresh a local TT entry of an active client
  * @bat_priv: the bat priv with all the mesh interface information
@@ -1021,15 +1063,23 @@ batadv_tt_local_refresh(struct batadv_priv *bat_priv,
 	spinlock_t *list_lock; /* protects write access to the hash lists */
 	struct batadv_tt_common_entry *common = &tt_local->common;
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
+	u16 dynamic_flags;
 	u8 remote_flags;
-	u32 match_mark;
 	u32 i;
 
+	dynamic_flags = batadv_tt_local_dynamic_flags(bat_priv, iif_is_wifi,
+						      mark);
+
+	tt_local->last_seen = jiffies;
+
+	/* fast path: nothing to modify or to announce */
+	if (!announce &&
+	    !batadv_tt_local_refresh_needed(tt_local, dynamic_flags))
+		return true;
+
 	i = batadv_choose_tt(common, hash->size);
 	list_lock = &hash->list_locks[i];
 
-	tt_local->last_seen = jiffies;
-
 	spin_lock_bh(list_lock);
 
 	/* the entry was removed from the local table after it was looked up */
@@ -1068,21 +1118,8 @@ batadv_tt_local_refresh(struct batadv_priv *bat_priv,
 		 */
 		remote_flags = common->flags & BATADV_TT_REMOTE_MASK;
 
-		if (iif_is_wifi)
-			common->flags |= BATADV_TT_CLIENT_WIFI;
-		else
-			common->flags &= ~BATADV_TT_CLIENT_WIFI;
-
-		/* check the mark in the skb: if it's equal to the configured
-		 * isolation_mark, it means the packet is coming from an
-		 * isolated non-mesh client
-		 */
-		match_mark = (mark & bat_priv->isolation_mark_mask);
-		if (bat_priv->isolation_mark_mask &&
-		    match_mark == bat_priv->isolation_mark)
-			common->flags |= BATADV_TT_CLIENT_ISOLA;
-		else
-			common->flags &= ~BATADV_TT_CLIENT_ISOLA;
+		common->flags &= ~BATADV_TT_LOCAL_DYNAMIC_MASK;
+		common->flags |= dynamic_flags;
 
 		if (remote_flags ^ (common->flags & BATADV_TT_REMOTE_MASK))
 			announce = true;




But this doesn't deal yet with the DEL queued in case 
batadv_tt_local_remove_now is called (by parallel context) in the middle of 
the batadv_hash_add and batadv_tt_local_refresh of batadv_tt_local_add().
This would require something like:


diff --git c/net/batman-adv/translation-table.c w/net/batman-adv/translation-table.c
index ff87bd30..5926a878 100644
--- c/net/batman-adv/translation-table.c
+++ w/net/batman-adv/translation-table.c
@@ -671,14 +671,22 @@ static u16 batadv_tt_flags_get(struct batadv_tt_common_entry *common)
 }
 
 /**
- * __batadv_tt_local_event() - store a local TT event (ADD/DEL) with given flags
+ * batadv_tt_local_event() - store a local TT event (ADD/DEL) with given flags
  * @bat_priv: the bat priv with all the mesh interface information
  * @common: the TT entry involved in the event
  * @flags: flags of the TT entry combined with the event flags
+ * @cancel_add: whether a DEL may cancel a queued ADD because the entry was
+ *  never announced to the other nodes
+ *
+ * Only a single change per client is queued. It describes the latest state of
+ * the client and a new event therefore replaces an already queued one. The
+ * only exception is a DEL for an entry which was never announced. It cancels
+ * the ADD of this entry because the other nodes don't need to know anything
+ * about it.
  */
-static void __batadv_tt_local_event(struct batadv_priv *bat_priv,
-				    const struct batadv_tt_common_entry *common,
-				    u8 flags)
+static void batadv_tt_local_event(struct batadv_priv *bat_priv,
+				  const struct batadv_tt_common_entry *common,
+				  u8 flags, bool cancel_add)
 {
 	struct batadv_tt_change_node *tt_change_node;
 	struct batadv_tt_change_node *entry;
@@ -711,21 +719,19 @@ static void __batadv_tt_local_event(struct batadv_priv *bat_priv,
 			continue;
 
 		del_op_entry = entry->change.flags & BATADV_TT_CLIENT_DEL;
-		if (del_op_requested != del_op_entry) {
-			/* DEL+ADD in the same orig interval have no effect and
-			 * can be removed to avoid silly behaviour on the
-			 * receiver side. The  other way around (ADD+DEL) can
-			 * happen in case of roaming of  a client still in the
-			 * NEW state. Roaming of NEW clients is now possible due
-			 * to automatically recognition of "temporary" clients
+		if (cancel_add && del_op_requested && !del_op_entry) {
+			/* ADD+DEL of a client which was never announced (e.g.
+			 * roaming of a client still in the NEW state) have no
+			 * effect and can be removed
 			 */
 			list_del(&entry->list);
 			kmem_cache_free(batadv_tt_change_cache, entry);
 			changes--;
 		} else {
-			/* this is a second add or del in the same originator
-			 * interval. It could mean that flags have been changed
-			 * (e.g. double add): update them
+			/* the other nodes may know the client with different
+			 * flags. A DEL+ADD must therefore still announce the
+			 * current flags and an ADD+DEL must still remove the
+			 * client. ADD+ADD and DEL+DEL only update the flags
 			 */
 			entry->change.flags = flags;
 		}
@@ -743,23 +749,6 @@ static void __batadv_tt_local_event(struct batadv_priv *bat_priv,
 	spin_unlock_bh(&bat_priv->tt.changes_list_lock);
 }
 
-/**
- * batadv_tt_local_event() - store a local TT event (ADD/DEL)
- * @bat_priv: the bat priv with all the mesh interface information
- * @tt_local_entry: the TT entry involved in the event
- * @event_flags: flags to store in the event structure
- */
-static void batadv_tt_local_event(struct batadv_priv *bat_priv,
-				  struct batadv_tt_local_entry *tt_local_entry,
-				  u8 event_flags)
-{
-	struct batadv_tt_common_entry *common = &tt_local_entry->common;
-	u8 flags;
-
-	flags = batadv_tt_flags_get(common) | event_flags;
-	__batadv_tt_local_event(bat_priv, common, flags);
-}
-
 /**
  * batadv_tt_entries() - compute the number of entries fitting in tt_len bytes
  * @tt_len: available space
@@ -1099,6 +1088,7 @@ batadv_tt_local_refresh(struct batadv_priv *bat_priv,
 	struct batadv_tt_common_entry *common = &tt_local->common;
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
 	u16 dynamic_flags;
+	u16 event_flags;
 	u8 remote_flags;
 	u32 i;
 
@@ -1159,9 +1149,14 @@ batadv_tt_local_refresh(struct batadv_priv *bat_priv,
 		if (remote_flags ^ (common->flags & BATADV_TT_REMOTE_MASK))
 			announce = true;
 
-		if (announce)
-			__batadv_tt_local_event(bat_priv, common,
-						common->flags);
+		/* BATADV_TT_CLIENT_ROAM can still be set when a client which
+		 * roamed away was re-added. It must not be announced with an
+		 * ADD because the other nodes would then handle it as roaming
+		 */
+		if (announce) {
+			event_flags = common->flags & ~BATADV_TT_CLIENT_ROAM;
+			batadv_tt_local_event(bat_priv, common, event_flags, false);
+		}
 	}
 
 	spin_unlock_bh(list_lock);
@@ -1710,7 +1705,7 @@ batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
 	lockdep_assert_held(&hash->list_locks[i]);
 	lockdep_assert_held(&common->flags_lock);
 
-	__batadv_tt_local_event(bat_priv, common, common->flags | flags);
+	batadv_tt_local_event(bat_priv, common, common->flags | flags, false);
 	common->flags |= BATADV_TT_CLIENT_PENDING;
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
@@ -1800,6 +1795,7 @@ batadv_tt_local_remove_now(struct batadv_priv *bat_priv,
 	spinlock_t *list_lock; /* protects write access to the hash lists */
 	struct batadv_tt_common_entry *common = &tt_local_entry->common;
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
+	u16 flags;
 	u32 i;
 
 	i = batadv_choose_tt(common, hash->size);
@@ -1816,13 +1812,18 @@ batadv_tt_local_remove_now(struct batadv_priv *bat_priv,
 	hlist_del_init_rcu(&common->hash_entry);
 	atomic_inc(&hash->generation);
 
-	batadv_tt_local_event(bat_priv, tt_local_entry, BATADV_TT_CLIENT_DEL);
-
-	/* batadv_tt_local_transition_new() may have committed the entry and
-	 * thus counted it in the local table size since the
-	 * BATADV_TT_CLIENT_NEW check in batadv_tt_local_mark_removed().
+	/* batadv_tt_local_transition_new() clears BATADV_TT_CLIENT_NEW under
+	 * the list_lock. The flags read here therefore show whether the entry
+	 * was committed (and announced) since the BATADV_TT_CLIENT_NEW check
+	 * in batadv_tt_local_mark_removed(). Only the ADD of an entry which
+	 * was never announced can be cancelled by its DEL.
 	 */
-	if (!(batadv_tt_flags_get(common) & BATADV_TT_CLIENT_NEW))
+	flags = batadv_tt_flags_get(common);
+	batadv_tt_local_event(bat_priv, common, flags | BATADV_TT_CLIENT_DEL,
+			      flags & BATADV_TT_CLIENT_NEW);
+
+	/* a committed entry was counted in the local table size */
+	if (!(flags & BATADV_TT_CLIENT_NEW))
 		batadv_tt_local_size_dec(bat_priv, common->vid);
 
 	spin_unlock_bh(list_lock);

Regards,
	Sven
--nextPart2010014.IobQ9Gjlxr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCasAOcwAKCRBND3cr0xT1
yzyjAQDp68AUXvEXD07g0/zq2LQBR8rEGdo4T5VEEVp9UQLqnAD9EvVPjUTDDqAe
CWWS3ERpvTZaJnanz430NvfdkBI5vQs=
=eQtP
-----END PGP SIGNATURE-----

--nextPart2010014.IobQ9Gjlxr--



