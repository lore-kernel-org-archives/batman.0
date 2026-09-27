Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB9B3C9832F
	for <batman-adv@archiver.kernel.org>; Sun, 27 Sep 2026 15:24:52 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3D02C8408E
	for <batman-adv@archiver.kernel.org>; Sun, 27 Sep 2026 17:24:51 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1790522691;
 b=ek46Ly1EMhjHwzMrEwbRTFFnVzKj/3dlFJDTOD2dOrS+WQKQCa+4btIYdxBg5w5SpHlw3
 v68aPbQ+XtMrWRapQ1tbmXytpJ6t6sg/T7E/QwBjgw3IptNp4yhCYJPgTXWTmJwfZgBli+Y
 BuvXIbfmBRxGYh9WdUX0XetgmzJWro4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1790522691; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=8urSy1/nZBpdQ3QFBM7ML9gVRrJV5rxBEvLxMLEA+AE=;
 b=WM0zEDflXtCBYu3y6ff71a4uiTKxLu/+ihBp/74QJhVvRY/FCtRNXUAUWNaZoDdjbZoYa
 no4r0VKFokbfxSvbu7Vx2CKjElV5iI+x84hhurFWBYQPz0ssSy9A7G5crRJQXHhiQv1BeDM
 gTEGoZDW9O3wChcrlLDCbVrZG/tKyLY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 78D948408E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 27 Sep 2026 17:23:27 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1790522617;
	b=0bWIc1giUH6wMz9+W3tfMdHrJWBq1HtkqDtojv6kb+d3/QlDUdCmvrSSGPSJTEIKVqbghB
	n+5wXV7iotvQvasw4Ut6fxqIznc6S9qw1y/I5sCtZARROxe84EN2KEmE8iMTtRolaCOuHl
	hT4cxFuAyx0ZqPetBexIapA7VKPfgN4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1790522617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=8urSy1/nZBpdQ3QFBM7ML9gVRrJV5rxBEvLxMLEA+AE=;
	b=KAu3P1nisL0T7AJPoR6EIk9fTgJHw1A/Smd7P5tZ6ocauf6Y5PxJq2imR6uFrbrApKvmKX
	ET0+IGfSI46A5X12nHqcNW09h2kmcbvpYuywEq5MmoyvK89pioeVanoWrZeYiVGLxEJqde
	6Qw1SuHyJRY4f2FSWndUoTgkI/3fo5k=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=c+DQ5Fjn;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
Received: by dvalin.narfation.org (Postfix) id CA57E207E6;
	Sun, 27 Sep 2026 15:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1790522606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8urSy1/nZBpdQ3QFBM7ML9gVRrJV5rxBEvLxMLEA+AE=;
	b=c+DQ5Fjn31bUlREZqOPLmDmXlVKm5Gmoc0J4yv0oI+DrqMNQ5IcszWXiBRuD0KT2AWc6ht
	m/Hx6aF2K66gZpLJ2uWKO4+o+zy1A4ghlP931rtkPiKrdgdypmIo5VnirPo975oQUs+n6r
	vSVEF10ewPynWYGu6TNnqNcnBc3RrwQ=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 27 Sep 2026 17:23:12 +0200
Subject: [PATCH batadv 2/2] batman-adv: tt: queue local DEL event before
 marking entry as pending
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-tt-order-local_remove-v1-2-8951549e4a38@narfation.org>
References: <20260927-tt-order-local_remove-v1-0-8951549e4a38@narfation.org>
In-Reply-To: <20260927-tt-order-local_remove-v1-0-8951549e4a38@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5918; i=sven@narfation.org;
 h=from:subject:message-id; bh=F7RVO5hHKC3LkmmcvFX8MVbPfel24OyBSv8DwPHZX+k=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFk7TR5fNE8X4pyjK//42tN/ojecbes07i/ur840Urr7O
 MOr4LV7RykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAiGxczMlx4u65gSThX4W5F
 vZL919Tult/aJ/aw81+S0vpJis5BBUGMDPcPTdFzVQq7VPP4orz4t8sPdrTsWN14/6XTjLzKWu1
 rFYwA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: MPGYAXVQANNO7KCLJZ5J65C4ZJI6WX4I
X-Message-ID-Hash: MPGYAXVQANNO7KCLJZ5J65C4ZJI6WX4I
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/MPGYAXVQANNO7KCLJZ5J65C4ZJI6WX4I/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_tt_local_set_pending() originally queued the DEL change event and
only afterwards set BATADV_TT_CLIENT_PENDING on the local entry. Commit
ea5a8b4def29 ("batman-adv: tt: use protected flag modifications") inverted
this order for batadv_tt_local_remove() and batadv_tt_local_purge_list().

The hash bucket list_lock held around both steps does not help against
batadv_tt_local_add_existing() because it is not holding it.

  CPU0                          CPU1
  flags |= ..._PENDING;
                                batadv_tt_local_add_existing()
                                  flags &= ~..._PENDING;
                                batadv_tt_local_event(ADD)
  batadv_tt_local_event(DEL)

If the ADD was already announced by a commit in between, the DEL is sent in
the next TTVN although the entry is no longer pending (after
batadv_tt_local_add_existing()) and the local entry was never purged. The
incorrect DEL will corrupt the CRC on neighbor nodes. A full table sync
request is therefore issued to resolve this problem.

When the DEL event is queued before the flag is set, a
batadv_tt_local_add_existing() which clears the flag afterwards queues its
ADD behind the DEL, and both cancel each other out.

Fixes: ea5a8b4def29 ("batman-adv: tt: use protected flag modifications")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831135117.574836-1-sw%40simonwunderlich.de?part=12
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 43 +++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 4c71bf1c..09580e29 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1605,29 +1605,37 @@ int batadv_tt_local_dump(struct sk_buff *msg, struct netlink_callback *cb)
 }
 
 /**
- * batadv_tt_local_set_pending_event() - trigger events for TT pending removal
+ * batadv_tt_local_set_pending() - mark local TT entry as pending removal
  * @bat_priv: the bat priv with all the mesh interface information
- * @tt_local_entry: local TT entry which was marked as BATADV_TT_CLIENT_PENDING
+ * @tt_local_entry: local TT entry to mark as BATADV_TT_CLIENT_PENDING
  * @flags: TT change flags to announce together with the pending removal
  * @message: debug message describing the reason for the change
  *
- * Schedule the TT change announcement for the entry. The caller must already
- * have added BATADV_TT_CLIENT_PENDING to the @tt_local_entry and must hold the
- * hash bucket list_lock of @tt_local_entry since setting the flag.
+ * Schedule the TT change announcement and set BATADV_TT_CLIENT_PENDING on the
+ * entry. The entry is kept in the local table until the next TTVN increment
+ * so that a consistency-check response can still be answered.
+ *
+ * The caller must hold the hash bucket list_lock of @tt_local_entry. Otherwise
+ * batadv_tt_local_purge_pending_clients() could remove the entry before its
+ * change was queued.
  */
 static void
-batadv_tt_local_set_pending_event(struct batadv_priv *bat_priv,
-				  struct batadv_tt_local_entry *tt_local_entry,
-				  u16 flags, const char *message)
+batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
+			    struct batadv_tt_local_entry *tt_local_entry,
+			    u16 flags, const char *message)
 {
+	struct batadv_tt_common_entry *common = &tt_local_entry->common;
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
 	u32 i;
 
-	i = batadv_choose_tt(&tt_local_entry->common, hash->size);
+	i = batadv_choose_tt(common, hash->size);
 	lockdep_assert_held(&hash->list_locks[i]);
 
 	batadv_tt_local_event(bat_priv, tt_local_entry, flags);
 
+	scoped_guard(spinlock_bh, &common->flags_lock)
+		common->flags |= BATADV_TT_CLIENT_PENDING;
+
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
 		   "Local tt entry (%pM, vid: %d) pending to be removed: %s\n",
 		   tt_local_entry->common.addr,
@@ -1645,7 +1653,8 @@ batadv_tt_local_set_pending_event(struct batadv_priv *bat_priv,
  * An already announced entry is marked as BATADV_TT_CLIENT_PENDING and the
  * (roamed) DEL change is queued. Both happen under the hash bucket list_lock
  * of the entry to prevent concurrent batadv_tt_local_purge_pending_clients()
- * from removing the entry.
+ * from removing the entry and batadv_tt_local_transition_new() from clearing
+ * BATADV_TT_CLIENT_NEW after it was checked.
  *
  * Return: true if the entry has to be kept in the local table until the next
  * ttvn increment, false if it can be purged immediately.
@@ -1677,10 +1686,8 @@ batadv_tt_local_mark_removed(struct batadv_priv *bat_priv,
 		if (roaming)
 			common->flags |= BATADV_TT_CLIENT_ROAM;
 
-		if (!(common->flags & BATADV_TT_CLIENT_NEW)) {
-			common->flags |= BATADV_TT_CLIENT_PENDING;
+		if (!(common->flags & BATADV_TT_CLIENT_NEW))
 			pending = true;
-		}
 	}
 
 	if (pending) {
@@ -1688,8 +1695,8 @@ batadv_tt_local_mark_removed(struct batadv_priv *bat_priv,
 		if (roaming)
 			flags |= BATADV_TT_CLIENT_ROAM;
 
-		batadv_tt_local_set_pending_event(bat_priv, tt_local_entry,
-						  flags, message);
+		batadv_tt_local_set_pending(bat_priv, tt_local_entry,
+					    flags, message);
 	}
 
 	spin_unlock_bh(list_lock);
@@ -1808,15 +1815,13 @@ static void batadv_tt_local_purge_list(struct batadv_priv *bat_priv,
 				cont = true;
 				break;
 			}
-
-			tt_local_entry->common.flags |= BATADV_TT_CLIENT_PENDING;
 		}
 
 		if (cont)
 			continue;
 
-		batadv_tt_local_set_pending_event(bat_priv, tt_local_entry,
-						  BATADV_TT_CLIENT_DEL, "timed out");
+		batadv_tt_local_set_pending(bat_priv, tt_local_entry,
+					    BATADV_TT_CLIENT_DEL, "timed out");
 	}
 }
 

-- 
2.47.3

