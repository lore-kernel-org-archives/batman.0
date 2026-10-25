Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2B8606A31A
	for <batman@archiver.kernel.org>; Sun, 25 Oct 2026 08:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=lUMVUZCI
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id EB7D880D74
	for <batman@archiver.kernel.org>; Sun, 25 Oct 2026 09:31:27 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1792917087;
 b=HvU1iPEt3NoRIPhK0HnUhriBEVrJSdx6yBWsH4hVaJ5AeHRvB6zKOdAsw8Zyiz64DrxR0
 /hjwiPh3ogPpm0GADVgHbKM/E4GV73BGQv50c4lfcZwnmOV3t1ju8nvYVfOkuDU8KHhQVg1
 chlHCXqGdFSTm3NVwF04LKPwZb8FsXk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1792917087; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=c2GV4ATVP4iJK70Eo0Wp9Zu1cp/l8m1cIp1Z2bL9pO0=;
 b=Xxp5lTmpbwq+pWfd9QXcXiMScRekGneS50ZlISoDVBf1zMTNQMYaPJ6lQDMomxvEHHcoz
 zetLJxNlHvfuRv1WHPqTqLmWSy3mZKKYBAlqfRIBD4aN//IoEDLcAPmBkSl+AV3OmnBxD2B
 WDcZpmJ23Vo+VvOMtOsly9dmRr6huas=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 7E150801AE
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 25 Oct 2026 09:31:02 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1792917072;
	b=xmmxgmhSqXmTcTxJFzqfIQui/x8BsJ9z/blRV0UzkZHGyCc3bdDRl6K6AhCopujJlDgny7
	1lF8z6g62SAQsnMxNawgvKMgNNdkyIRj0DLPvUl82rx7BTTT7aeisy23DMvojQqaSBK9hP
	0evwOl3Lm3O9V2K5icuImWDxKjp/3mk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1792917072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=c2GV4ATVP4iJK70Eo0Wp9Zu1cp/l8m1cIp1Z2bL9pO0=;
	b=Qbh5UIgUbn6BES7hZoBbQQmATtgMjgjd0byb3lUZf37wZJKYNuOTORUrjhpc0opPo8JO98
	tORaR4jdSXYUxHE4ZIGZ9/r0OAqvZTuc97lPS56fzioxlDeEdxfbGn2X7B/JEVmGr9I1wi
	eUuRCQxAIrPR7u6QW/W5WvG318jNYKE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=lUMVUZCI;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 7CE1D1FEEB;
	Sun, 25 Oct 2026 08:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1792917060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=c2GV4ATVP4iJK70Eo0Wp9Zu1cp/l8m1cIp1Z2bL9pO0=;
	b=lUMVUZCIu998Vxp1PeKJY1KV+A86xcbDRtLfKPIJv0iJvlk+c8fjqlXQ7BkY7mFj7KkdgU
	LOOPzSktWKiuIefUW1PHbhD6ibD3anTLLKkjQUrGQWNnKZvSMNOAWy4tzvqJnASMjt+GZn
	bBBm/gydvv3PRgD9D1P/j6Sva4UjhDw=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 25 Oct 2026 09:30:21 +0100
Subject: [PATCH batadv] batman-adv: tt: take local changes snapshot before
 TTVN decision
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261025-tt-tvlv-changes-check-v1-1-c12b246c0956@narfation.org>
X-B4-Tracking: v=1; b=H4sIABy+3WoC/yWMwQrCMBBEf6XM2YUkYA7+inhI0q2uSpXsGgql/
 260p+HNMG+FchVWnIYVlZuovOYO/jCg3NJ8ZZKxM4IL0btwJDOy9my0r9qTy4PcFH3kwNGXjP5
 9V55k+XvPyMnS2HDZe/3kOxf7SbFtX9uiESOBAAAA
X-Change-ID: 20261025-tt-tvlv-changes-check-0f616e2e61cb
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sashiko <sashiko-bot@kernel.org>, Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5937; i=sven@narfation.org;
 h=from:subject:message-id; bh=Ww0lCeVdrZy1AoubMdOkRgAH9o+Yq3/69+0dlLzqtUg=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFl39xn8Z3j/51bqXKHq0511CyM5yi5MzOiNLNnxeHvcF
 xahbuuPHSUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJVN9h+KYckH7TVcG002km
 Y4u8192DP3aY8gWHGJrLvQzd77m5lpFho8mbDZ+Yz+YcnjFhn03LpNMMJ0IuLpASbOsziz0+9aY
 JKwA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: BIV66HPJYUJQ5B5Y2GY2Z2H4ZRU5EMC7
X-Message-ID-Hash: BIV66HPJYUJQ5B5Y2GY2Z2H4ZRU5EMC7
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BIV66HPJYUJQ5B5Y2GY2Z2H4ZRU5EMC7/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

batadv_tt_local_commit_changes_nolock() decides whether the TTVN has to be
incremented based on an unlocked read of tt.local_changes. The list of
changes is only taken later in batadv_tt_tvlv_container_update().
batadv_tt_local_event() is not serialized by the commit_lock and can queue
new events in between:

  CPU0                          CPU1
  batadv_tt_local_commit_changes_nolock()
    ...local_changes == 0
                                batadv_tt_local_event()
                                  list_add_tail(...);
                                  ...local_changes++;
    batadv_tt_tvlv_container_update()
      list_splice_init(...);
      ...local_changes = 0;

The event is then announced under a TTVN which was not incremented for it.
And because local_changes was reset, the next commit doesn't increment the
TTVN for it either.

The snapshot of the changes must therefore be taken before the TTVN
decision and handed over to batadv_tt_tvlv_container_update(). Events
queued afterwards stay in the tt.changes_list for the next TT round.

This doesn't make the CRC consistent with the announced changeset. The
local table modifications are still not serialized with the commit and
batadv_tt_local_transition_new() can still make a client part of the CRC
for which the event is only part of the next TT round. Such an
inconsistency is detected by the CRC check of the other nodes and solved
via a full table request.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-fc286ddd-5bed-4683-b842-ee7a307eeb19
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 39 +++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index fa849f6c..ff3b3d55 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1397,29 +1397,24 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
  * batadv_tt_tvlv_container_update() - update the translation table tvlv
  *  container after local tt changes have been committed
  * @bat_priv: the bat priv with all the mesh interface information
+ * @changes_list: list of committed changes which will be consumed
+ * @tt_diff_entries_num: number of entries in @changes_list
  */
-static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
+static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv,
+					    struct list_head *changes_list,
+					    int tt_diff_entries_num)
 {
 	struct batadv_tvlv_tt_change *tt_change;
 	struct batadv_tt_change_node *entry;
 	struct batadv_tvlv_tt_data *tt_data;
 	struct batadv_tt_change_node *safe;
 	int tt_diff_entries_count = 0;
-	int tt_diff_entries_num = 0;
 	bool drop_changes = false;
 	size_t tt_extra_len = 0;
-	LIST_HEAD(changes_list);
 	int tt_change_len = 0;
 	int tt_diff_len;
 	u16 tvlv_len;
 
-	/* atomically get the list of changes */
-	spin_lock_bh(&bat_priv->tt.changes_list_lock);
-	list_splice_init(&bat_priv->tt.changes_list, &changes_list);
-	tt_diff_entries_num = READ_ONCE(bat_priv->tt.local_changes);
-	WRITE_ONCE(bat_priv->tt.local_changes, 0);
-	spin_unlock_bh(&bat_priv->tt.changes_list_lock);
-
 	tt_diff_len = batadv_tt_len(tt_diff_entries_num);
 
 	/* if we have too many changes for one packet don't send any
@@ -1441,7 +1436,7 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
 		/* the TTVN of the changes is lost and the other nodes will
 		 * have to request the full table anyway
 		 */
-		list_for_each_entry_safe(entry, safe, &changes_list, list) {
+		list_for_each_entry_safe(entry, safe, changes_list, list) {
 			list_del(&entry->list);
 			kmem_cache_free(batadv_tt_change_cache, entry);
 		}
@@ -1453,7 +1448,7 @@ static void batadv_tt_tvlv_container_update(struct batadv_priv *bat_priv)
 	if (!drop_changes && tt_diff_len == 0)
 		goto container_register;
 
-	list_for_each_entry_safe(entry, safe, &changes_list, list) {
+	list_for_each_entry_safe(entry, safe, changes_list, list) {
 		if (tt_diff_entries_count < tt_diff_entries_num) {
 			memcpy(tt_change + tt_diff_entries_count,
 			       &entry->change,
@@ -4500,11 +4495,25 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
  */
 static void batadv_tt_local_commit_changes_nolock(struct batadv_priv *bat_priv)
 {
+	LIST_HEAD(changes_list);
+	int changes_num;
+
 	lockdep_assert_held(&bat_priv->tt.commit_lock);
 
-	if (READ_ONCE(bat_priv->tt.local_changes) == 0) {
+	/* atomically get the list of changes. The TTVN decision and the
+	 * announced changeset must cover the same events. Events queued
+	 * afterwards stay in the tt.changes_list for the next TT round
+	 */
+	spin_lock_bh(&bat_priv->tt.changes_list_lock);
+	list_splice_init(&bat_priv->tt.changes_list, &changes_list);
+	changes_num = READ_ONCE(bat_priv->tt.local_changes);
+	WRITE_ONCE(bat_priv->tt.local_changes, 0);
+	spin_unlock_bh(&bat_priv->tt.changes_list_lock);
+
+	if (changes_num == 0) {
 		if (!batadv_atomic_dec_not_zero(&bat_priv->tt.ogm_append_cnt))
-			batadv_tt_tvlv_container_update(bat_priv);
+			batadv_tt_tvlv_container_update(bat_priv, &changes_list,
+							changes_num);
 		return;
 	}
 
@@ -4521,7 +4530,7 @@ static void batadv_tt_local_commit_changes_nolock(struct batadv_priv *bat_priv)
 
 	/* reset the sending counter */
 	atomic_set(&bat_priv->tt.ogm_append_cnt, BATADV_TT_OGM_APPEND_MAX);
-	batadv_tt_tvlv_container_update(bat_priv);
+	batadv_tt_tvlv_container_update(bat_priv, &changes_list, changes_num);
 }
 
 /**

---
base-commit: 65840650002746358ae71860d8a27d065b4ae6d6
change-id: 20261025-tt-tvlv-changes-check-0f616e2e61cb

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

