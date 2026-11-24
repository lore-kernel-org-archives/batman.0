Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB578606A31E
	for <batman@archiver.kernel.org>; Tue, 24 Nov 2026 20:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=xafMupmP
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4D10782F98
	for <batman@archiver.kernel.org>; Tue, 24 Nov 2026 21:03:02 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795550582;
 b=b2i0wlVDFax2FtiCCdtkP0k8S/zMhJyK3wDiKtarp5fDTl4xnsT6epUucpO9UuwseAXpT
 4rUtTbPzszDQp5pIsIYB+NtK5XP+y0v59BBuWGKkkk4F00GAlk2wZFnRtj5F9PFx4Pf50tT
 ZuM8/0Gep2Vrs1iNIlegLevkyr4JiOw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795550582; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=lylw3LyN3gv8iWZ/Dq3IRhRREidXbB+P35bwXfzQl8s=;
 b=eNt4wYlGQv8GAO1w0Q5X6XRCG8CRK2570oT6o/Z2dGXTqMxZu74EYDNXj3qXJxQr9iKgn
 H9FcAxRrzuGOFo6XTkc1X9QVy5bt5sYtEH9GCulUwa5WajpP83qkZjO0wDdikiDE4c/hSrX
 lmxvCbXZkHVZ2K2iK9S/9xNOI2bQJyc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 4AD98810CD
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 24 Nov 2026 21:02:44 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795550574;
	b=ZqmC1YPexCtZR3rczIQ0A4QXX8egKS8SBUbN3f7eX6Fma9DqSp2gVBBgWSE5Bo79T40C83
	uf81dF+/akgH1Mnkxo9gU5XaaE603nD5FzNjmj06XSC/Q36W6O5uRpemoAUT1vlYi0UfEf
	o4KxCs1PdXfMvpBu1cE3o2oNo0AmxCs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795550574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=lylw3LyN3gv8iWZ/Dq3IRhRREidXbB+P35bwXfzQl8s=;
	b=Vcey+ivJT1BmK9k6MStRs2OpTYhE1tqNoqJyi1sfJx32rP5NhEPclxzZuyS/99f953W9/X
	T+hXOXWS1lgYhP95yqKKdlpcBC5xf/v+0t1lRaLSbuN3LBBagLut5s7F6aRsZ7aHTw0c68
	1oY3rrVH/iMNQVPrHbAtKhPOxtLl9I4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=xafMupmP;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 86E3C2026D;
	Tue, 24 Nov 2026 20:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1795550563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lylw3LyN3gv8iWZ/Dq3IRhRREidXbB+P35bwXfzQl8s=;
	b=xafMupmPI3TFWofGzA1NXL3Q2u3vG/MXhFpGR8XV3BAQU6IJoildkx/XrTrByrndoI5WsB
	Wg9I/kG02aVY7Jxsqd4JC8MDdX19TltbFsd1iqQrOfVujs8+unZX0IyPJJ9fsNIVCkdEAh
	wGYEzn7+Q6izhfomdztiCrNQEw6rOw8=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 24 Nov 2026 21:02:29 +0100
Subject: [PATCH batadv] batman-adv: tt: don't allocate for updates of
 queued local changes
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-event-late-allocation-v1-1-756780b98c10@narfation.org>
X-B4-Tracking: v=1; b=H4sIAFTtBWsC/yWMQQrCMBAAv1L27IIJTaF+RTxskm1dCakkaxBK/
 27U4wzM7FC5CFe4DDsUblJlyx3MaYBwp7wySuwM9mwnY+yI3DgrJlJGSmkLpL1A59w8+zFMNjL
 09ll4kffvewVPSrHB7e/ryz846HcKx/EBlVeLfYEAAAA=
X-Change-ID: 20261124-event-late-allocation-55599b4c62de
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sashiko <sashiko-bot@kernel.org>, Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4114; i=sven@narfation.org;
 h=from:subject:message-id; bh=hL/phIg6/MaC/GPSxiWvEcTqfNBih7knWwqCQLH28zk=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDNmsb0Nv7FCpniXIxFMyq3nGxcbvdQs/vPc/e9Jl1jcBM
 /E3UsJlHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJ5F5g+GfK27/AIHBVxum+
 ddM0Jkxust10Q3ZDv8Tpu0vWtLy5efsOwx/O3NBFM7ZwL7/cqfWz1TlWe3r8GebcdVcOy92+fjI
 /7h4XAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: AOOFLO6NZWK42P22PXPNLVALYSMTISWX
X-Message-ID-Hash: AOOFLO6NZWK42P22PXPNLVALYSMTISWX
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/AOOFLO6NZWK42P22PXPNLVALYSMTISWX/>
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

batadv_tt_local_event() allocates the new change before it searches for an
already queued change of the same client. But the new change is only needed
when no such change was found. For ADD+ADD, DEL+DEL, DEL+ADD and ADD+DEL,
the flags of the queued change are updated (or the queued initial ADD is
cancelled) and the just allocated change is freed again.

Search for the queued change first and only allocate a new one when the
client has no queued change. The update and the cancellation of a queued
change can then no longer fail.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261123171827.3294525-2-sw%40simonwunderlich.de?part=11
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index e08bf88b..49364732 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -738,9 +738,10 @@ static bool batadv_tt_local_event(struct batadv_priv *bat_priv,
 	__must_hold(&common->flags_lock)
 {
 	struct batadv_tt_change_node *tt_change_node;
+	__be16 vid = htons(common->key.vid);
 	struct batadv_tt_change_node *entry;
-	struct batadv_tt_change_node *safe;
 	bool del_op_requested;
+	bool queued = true;
 	size_t changes;
 
 	lockdep_assert_held(&common->flags_lock);
@@ -748,15 +749,6 @@ static bool batadv_tt_local_event(struct batadv_priv *bat_priv,
 	if (cancelled)
 		*cancelled = false;
 
-	tt_change_node = kmem_cache_alloc(batadv_tt_change_cache, GFP_ATOMIC);
-	if (!tt_change_node)
-		return false;
-
-	memset(tt_change_node->change.reserved, 0,
-	       sizeof(tt_change_node->change.reserved));
-	ether_addr_copy(tt_change_node->change.addr, common->key.addr);
-	tt_change_node->change.vid = htons(common->key.vid);
-
 	del_op_requested = flags & BATADV_TT_CLIENT_DEL;
 
 	/* the ROAM flag is only meaningful for the receiver in combination
@@ -766,18 +758,14 @@ static bool batadv_tt_local_event(struct batadv_priv *bat_priv,
 	if (!del_op_requested)
 		flags &= ~BATADV_TT_CLIENT_ROAM;
 
-	tt_change_node->change.flags = flags;
-	tt_change_node->initial_add = initial_add && !del_op_requested;
-
 	/* check for ADD+DEL, DEL+ADD, ADD+ADD or DEL+DEL events */
 	spin_lock_bh(&bat_priv->tt.changes_list_lock);
 	changes = READ_ONCE(bat_priv->tt.local_changes);
-	list_for_each_entry_safe(entry, safe, &bat_priv->tt.changes_list,
-				 list) {
+	list_for_each_entry(entry, &bat_priv->tt.changes_list, list) {
 		if (!batadv_compare_eth(entry->change.addr, common->key.addr))
 			continue;
 
-		if (entry->change.vid != tt_change_node->change.vid)
+		if (entry->change.vid != vid)
 			continue;
 
 		if (del_op_requested && entry->initial_add) {
@@ -806,19 +794,32 @@ static bool batadv_tt_local_event(struct batadv_priv *bat_priv,
 			entry->change.flags = flags;
 		}
 
-		kmem_cache_free(batadv_tt_change_cache, tt_change_node);
 		goto update_changes;
 	}
 
+	tt_change_node = kmem_cache_alloc(batadv_tt_change_cache, GFP_ATOMIC);
+	if (!tt_change_node) {
+		queued = false;
+		goto unlock;
+	}
+
+	memset(tt_change_node->change.reserved, 0,
+	       sizeof(tt_change_node->change.reserved));
+	ether_addr_copy(tt_change_node->change.addr, common->key.addr);
+	tt_change_node->change.vid = vid;
+	tt_change_node->change.flags = flags;
+	tt_change_node->initial_add = initial_add && !del_op_requested;
+
 	/* track the change in the OGMinterval list */
 	list_add_tail(&tt_change_node->list, &bat_priv->tt.changes_list);
 	changes++;
 
 update_changes:
 	WRITE_ONCE(bat_priv->tt.local_changes, changes);
+unlock:
 	spin_unlock_bh(&bat_priv->tt.changes_list_lock);
 
-	return true;
+	return queued;
 }
 
 /**

---
base-commit: b76921870912bf2543c1f4c7310fbf18da610acf
change-id: 20261124-event-late-allocation-55599b4c62de

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

