Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57721CA600C
	for <batman@archiver.kernel.org>; Wed,  7 Oct 2026 10:31:53 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D574A83DA2
	for <batman@archiver.kernel.org>; Wed, 07 Oct 2026 12:31:51 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791369111;
 b=h0G4IE9ONORZYSHnXRxk2rReSmNNDz/BUVZTZ12wzWFwpppyDJBe2+8cP1zQNiYoK0R15
 JBVD1RWHHMN9lF8N0dUK/wtdBY7VUx6I3IVndnuY+rHnPy14NjDf5Yf+zxdY1zrDNOQsG9B
 82B4wBanLpqVu5ngCky8kP4YOGQ73r4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791369111; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=YocPex8ifAQzy22UQ4IBr+U3NrP4JSD9C7mrq0BOOzQ=;
 b=BzN/eCAT6cT0nepqrvrZxCwt1rrWJaPZ7DaQekpP1K7zE00FbD5yK2s9IKUlb26zKcJQt
 lFRWU/z8CYH2H1etzDvqa1ifGdbjSFQfrdK+DuanxDNsKUVDsfH/1nM14v61/t1WFGOnXIx
 1PGpmVkc91aphSbsMSY9M8JpvI3qTFA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id D59AF83E15
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 07 Oct 2026 12:30:32 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791369042;
	b=YafRtRZ/5CS5pLgj1tk3nH0TWbUwSDCtmL8PxbzKl0eeEvdGsPVlgbBbSfYYZtbIVGvtyo
	l7Uc4eSzZfS92p6CwvPPl6/M4wV+P2+Tm5gKjxPuSwFmm4z9xxGnNj2Ts4KKHBPpbgUada
	PcERL6mkk8stI5ZVRw9U9a7nE7X4tDU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791369042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=YocPex8ifAQzy22UQ4IBr+U3NrP4JSD9C7mrq0BOOzQ=;
	b=MYkbkiI7EQNWsWFEUAiqvtYClY+L1C3opYAfWNT2wQU7qn+VgAv6/s8tKWSQOOpfMIvrI6
	8qHzQKM+KkuA8Jvv4RYMStLwCpaUuHYocJAl08ZdD3vynvD329sKTHB+RpkeQjRUBPvNRv
	2BvYN4uFQmgzZJfFbKATV0/aIo6Ryl8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=jzIYcGC4;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 90F98205E6;
	Wed, 07 Oct 2026 10:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791369032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YocPex8ifAQzy22UQ4IBr+U3NrP4JSD9C7mrq0BOOzQ=;
	b=jzIYcGC4mKTx2qgxbw8vFBsHvitQioIHGyzHjQF74knSaP4OUQRkSqmmRpzfxaOOq/7Xo3
	egiezVlKyf7D/v//Abtds+PB498a5HiUR/1p3svJ2ObLqAiW2skItgeo3Gd+1z5DQFp+E5
	nt2KfIngLZmCjTqr5Xb26QHxm5y2iPg=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 07 Oct 2026 12:29:46 +0200
Subject: [PATCH batadv 2/4] batman-adv: tt: only update flags for TT events
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-tt-avoid-unhashed-event-v1-2-01c763657916@narfation.org>
References: <20261007-tt-avoid-unhashed-event-v1-0-01c763657916@narfation.org>
In-Reply-To: 
 <20261007-tt-avoid-unhashed-event-v1-0-01c763657916@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5892; i=sven@narfation.org;
 h=from:subject:message-id; bh=ZRybZeUOGJ3u+OFyoFUSrduBisPLd6eraxnKcAvC+OQ=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnH5FWiNxiEzC49yK+6P7vjx6OH95h4c/Yv6Sm6taD0n
 dyCi74SHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJeOsw/NN867VTVp7tfvsU
 i5hq3bSSsw1nxbk2nbU18Vly0eREaCcjw3pWR2ntqWfWaexwVbw3+flq0Uv3Pd/cadi9UFDpGUN
 WKCcA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: RWOMR2D3G53HPOWTYGMPCBLN4MDCZXS6
X-Message-ID-Hash: RWOMR2D3G53HPOWTYGMPCBLN4MDCZXS6
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RWOMR2D3G53HPOWTYGMPCBLN4MDCZXS6/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

In the first implementation of the translation table events, it was only
possible to announce:

* ADD: new locally detected client
* DEL: disappeared local client

If an ADD event was queued and then a DEL event was queued in the same
timeslot, it is valid to destroy both events because nothing actually
changed for remode nodes

But with commit e0eb5f8df352 ("batman-adv: improve the TT component to
support runtime flag changes") and subsequent changes, it could also happen
that there are extra ADD events:

* ADD: _NEW_ locally detected client
* ADD: already existing client with new flags
* DEL: disappeared local client

The first and the last type of event could in theory still be removed
together from the (to be announced) events queue. But if the "update flags"
ADD is dropped together with the DEL, it would still leave global
translation table of a remote node in the incorrect state - believing that
the client didn't disappear.

If a detected client was previously announced, a DEL event must only
overwrite the "update flags" ADD but the DEL itself must still continue to
exist in the (to be anounced) events queue. For now, adjustment of the
announced flags is used for everything instead of dropping already queued
up events completely.

Similarly, a DEL followed by an ADD caused both entries to be deleted. But
the new ADD could announce flags changes which were not yet present for the
client before it was marked for DELetion. The new ADD must therefore only
overwrite the DEL - but still be kept.

A re-added client which roamed away still carries BATADV_TT_CLIENT_ROAM. It
was never announced with an ADD because the DEL always cancelled it. Since
this ADD is now sent, the ROAM flag is removed from it. Otherwise the other
nodes would handle the ADD as roaming and drop their other originators for
this client.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 44 ++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index b545001b..a10345a1 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -675,6 +675,9 @@ static u16 batadv_tt_flags_get(struct batadv_tt_common_entry *common)
  * @bat_priv: the bat priv with all the mesh interface information
  * @common: the TT entry involved in the event
  * @flags: flags of the TT entry combined with the event flags
+ *
+ * Only a single change per client is queued. It describes the latest state of
+ * the client and a new event therefore replaces an already queued one.
  */
 static void __batadv_tt_local_event(struct batadv_priv *bat_priv,
 				    const struct batadv_tt_common_entry *common,
@@ -683,8 +686,6 @@ static void __batadv_tt_local_event(struct batadv_priv *bat_priv,
 	struct batadv_tt_change_node *tt_change_node;
 	struct batadv_tt_change_node *entry;
 	struct batadv_tt_change_node *safe;
-	bool del_op_requested;
-	bool del_op_entry;
 	size_t changes;
 
 	tt_change_node = kmem_cache_alloc(batadv_tt_change_cache, GFP_ATOMIC);
@@ -697,7 +698,6 @@ static void __batadv_tt_local_event(struct batadv_priv *bat_priv,
 	tt_change_node->change.vid = htons(common->vid);
 
 	tt_change_node->change.flags = flags;
-	del_op_requested = flags & BATADV_TT_CLIENT_DEL;
 
 	/* check for ADD+DEL, DEL+ADD, ADD+ADD or DEL+DEL events */
 	spin_lock_bh(&bat_priv->tt.changes_list_lock);
@@ -710,25 +710,12 @@ static void __batadv_tt_local_event(struct batadv_priv *bat_priv,
 		if (entry->change.vid != tt_change_node->change.vid)
 			continue;
 
-		del_op_entry = entry->change.flags & BATADV_TT_CLIENT_DEL;
-		if (del_op_requested != del_op_entry) {
-			/* DEL+ADD in the same orig interval have no effect and
-			 * can be removed to avoid silly behaviour on the
-			 * receiver side. The  other way around (ADD+DEL) can
-			 * happen in case of roaming of  a client still in the
-			 * NEW state. Roaming of NEW clients is now possible due
-			 * to automatically recognition of "temporary" clients
-			 */
-			list_del(&entry->list);
-			kmem_cache_free(batadv_tt_change_cache, entry);
-			changes--;
-		} else {
-			/* this is a second add or del in the same originator
-			 * interval. It could mean that flags have been changed
-			 * (e.g. double add): update them
-			 */
-			entry->change.flags = flags;
-		}
+		/* the other nodes may know the client with different
+		 * flags. A DEL+ADD must therefore still announce the
+		 * current flags and an ADD+DEL must still remove the
+		 * client. ADD+ADD and DEL+DEL only update the flags
+		 */
+		entry->change.flags = flags;
 
 		kmem_cache_free(batadv_tt_change_cache, tt_change_node);
 		goto update_changes;
@@ -1023,6 +1010,7 @@ batadv_tt_local_refresh(struct batadv_priv *bat_priv,
 	spinlock_t *list_lock; /* protects write access to the hash lists */
 	struct batadv_tt_common_entry *common = &tt_local->common;
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
+	u16 event_flags;
 	u8 remote_flags;
 	u32 match_mark;
 	u32 i;
@@ -1089,9 +1077,15 @@ batadv_tt_local_refresh(struct batadv_priv *bat_priv,
 		if (remote_flags ^ (common->flags & BATADV_TT_REMOTE_MASK))
 			announce = true;
 
-		if (announce)
-			__batadv_tt_local_event(bat_priv, common,
-						common->flags);
+		/* BATADV_TT_CLIENT_ROAM can still be set (see above) when a
+		 * client which roamed away was re-added. It must not be
+		 * announced with an ADD because the other nodes would then
+		 * handle it as still roaming.
+		 */
+		if (announce) {
+			event_flags = common->flags & ~BATADV_TT_CLIENT_ROAM;
+			__batadv_tt_local_event(bat_priv, common, event_flags);
+		}
 	}
 
 	spin_unlock_bh(list_lock);

-- 
2.47.3

