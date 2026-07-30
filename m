Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D192C55162
	for <batman@archiver.kernel.org>; Thu, 30 Jul 2026 17:35:39 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id CDF9183704
	for <batman@archiver.kernel.org>; Thu, 30 Jul 2026 19:35:37 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785432937;
 b=pSwj0manLl5KS7hR/4je+8l1899ecxSPGhWkmhQdNK3JZlE5I8F0MhA0y8BEncamgzU+c
 0SLA+qNkJclzd6QHHWsiwCzIvbnecR2jpQz9loLjl6xGE95PmLWRrCxFeIRCWuuLc4DiKxm
 ZIoxZ2iaiVB6nMIBHwDadXcIpFPsL08=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785432937; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=eEHPN6C/ZvPISFud9MZPK7xR5tCNJ4hM1kIJ+ugtWOg=;
 b=xuhU8Ew48aip4jZB5p2fjAjezdqFeskj7LoDxjh+FE7v3drRJk+aQYXUDCtlU3y0wxlDj
 Bg2M4W3YSYNzdovNmcMASTMarTUG6R61mnNXuuLSfVK+oLjHCOnXLqBazueDGOGSw61AyZA
 3cwK6L1bmTPPo9oBETOJ1A26N04WUvI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id AAC5584009
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 30 Jul 2026 19:33:34 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785432814;
	b=LB62n5gtYF5eEG4BhGuP8id0Ux/03oCXiitAhd6O9WExzTLSW2h6RUw+e0a2cU31E1o3bD
	v8M4rz6OK3LWNirV6tHYOvwKpD0K3Zf07ZVS/TYpdcdAGPQx+k5EBozQiqou6fz1h9p7QZ
	Z1KAWcOjT57DArV8AWDjep9+Bm9jhSA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785432814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=eEHPN6C/ZvPISFud9MZPK7xR5tCNJ4hM1kIJ+ugtWOg=;
	b=gw2/rFCILqBYKwntXtW8ha/I3O4aJME0g+rYoHO2wr0ZAwH4yW9SG1IuHeNop7OFFdaKTH
	QvojHwGqduOMeY5xNQ8rh+V5pBXWjGs22DF/kw1ZeefkBDreo7Cc/NUFFw066oXtCwSYl3
	2oy/0bFDJ8eLAPFtsCuBMPAfmfwWlAk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=o0XzophA;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 42378203F6;
	Thu, 30 Jul 2026 17:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785432810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eEHPN6C/ZvPISFud9MZPK7xR5tCNJ4hM1kIJ+ugtWOg=;
	b=o0XzophAh9foHjltu7H9rHC+2+YjqJyQWvPT1cZlKEY8O/wWwz1gKTcW4VAdPKIscUmBFW
	pGHd3Ky2P2DNsFjdC9SxuLdgOYJNddAXN58sfxThrklYILSYeHM/YuI3Vap3J6ZaKIkojH
	m5/8SnIeZWPf7zL9K4HtLvsgaOf2KB0=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 30 Jul 2026 19:32:59 +0200
Subject: [PATCH batadv 4/4] batman-adv: tt: fix roaming state handling of a
 local client
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-tt-fixes-v1-4-64e9e525d555@narfation.org>
References: <20260730-tt-fixes-v1-0-64e9e525d555@narfation.org>
In-Reply-To: <20260730-tt-fixes-v1-0-64e9e525d555@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5635; i=sven@narfation.org;
 h=from:subject:message-id; bh=17iFjkIHhpjU1Aj9CDNp/4FU1CJvklANeigIQFRnr50=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnZXeeedxhuvNcV1z7FIOUgr3P9tVtyypF5kqdmOkWfY
 WNRlpjTUcrCIMbFICumyLLnSv75zexv5T9P+3gUZg4rE8gQBi5OAZiIgT3D/5qjLM/WHTG4VPRV
 9Jvqx30ca/NPpstw50lxya+4HVFk08jIMFMsdQbnFO15Z355tn8tqXNU2WY7V7ig/XyVZP2q52e
 TWAA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: PAAGSQXBBMXELLOYY3GQK6ECUXHKIE4V
X-Message-ID-Hash: PAAGSQXBBMXELLOYY3GQK6ECUXHKIE4V
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/PAAGSQXBBMXELLOYY3GQK6ECUXHKIE4V/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Turning the BATADV_TT_CLIENT_ROAM handling in batadv_tt_local_add() into an
atomic single claim changed the behaviour of the roaming check in three
ways.

* the cleanup of the global entry was moved out of the block which is
  only entered when the roaming process was not handled yet.
* the flag is now published before tt_global->roam_at is stamped,
  with the whole batadv_send_roam_adv() loop in between.

Revert this handling but avoid sending the initial roaming-away
announcements when another context took responsibility for it. To keep it
more readable, extract it in a new function.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: 8b4cee3c9355 ("batman-adv: tt: use atomic flag modifications")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 94 +++++++++++++++++++++++---------------
 1 file changed, 58 insertions(+), 36 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 7907f1c6..b2e15dd1 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -667,6 +667,63 @@ static void batadv_tt_global_free(struct batadv_priv *bat_priv,
 	batadv_tt_global_entry_put(tt_global);
 }
 
+/**
+ * batadv_tt_local_add_roam() - handle roamed clients during batadv_tt_local_add()
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @tt_global: the global TT entry
+ * @roamed_back: whether @tt_global roamed back
+ */
+static void batadv_tt_local_add_roam(struct batadv_priv *bat_priv,
+				     struct batadv_tt_global_entry *tt_global,
+				     bool roamed_back)
+{
+	struct batadv_tt_orig_list_entry *orig_entry;
+	struct hlist_head *head;
+	u16 old_flags;
+
+	if (!tt_global)
+		return;
+
+	/* Check whether it is a roaming, but don't do anything if the roaming
+	 * process has already been handled
+	 */
+	if (atomic_read(&tt_global->common.flags) & BATADV_TT_CLIENT_ROAM)
+		return;
+
+	if (!roamed_back) {
+		/* The global entry has to be marked as ROAMING and has to be
+		 * kept for consistency purpose.
+		 *
+		 * batadv_tt_global_to_purge() evaluates roam_at as soon as it
+		 * observes BATADV_TT_CLIENT_ROAM, so the timeout has to be
+		 * stamped before the flag is published. Otherwise the entry can
+		 * be deleted right away as "Roaming timeout".
+		 */
+		tt_global->roam_at = jiffies;
+
+		/* The flag is claimed via an atomic test-and-set to make sure
+		 * that only a single context announces the roaming
+		 */
+		old_flags = atomic_fetch_or(BATADV_TT_CLIENT_ROAM,
+					    &tt_global->common.flags);
+		if (old_flags & BATADV_TT_CLIENT_ROAM)
+			return;
+	}
+
+	/* These node are probably going to update their tt table */
+	head = &tt_global->orig_list;
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(orig_entry, head, list) {
+		batadv_send_roam_adv(bat_priv, tt_global->common.addr,
+				     tt_global->common.vid,
+				     orig_entry->orig_node);
+	}
+	rcu_read_unlock();
+
+	if (roamed_back)
+		batadv_tt_global_free(bat_priv, tt_global, "Roaming canceled");
+}
+
 /**
  * batadv_tt_local_add() - add a new client to the local table or update an
  *  existing client
@@ -685,14 +742,12 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 {
 	struct batadv_priv *bat_priv = netdev_priv(mesh_iface);
 	struct batadv_tt_global_entry *tt_global = NULL;
-	struct batadv_tt_orig_list_entry *orig_entry;
 	struct batadv_tt_local_entry *tt_local;
 	struct net *net = dev_net(mesh_iface);
 	struct net_device *in_dev = NULL;
 	struct batadv_meshif_vlan *vlan;
 	bool roamed_back = false;
 	bool iif_is_wifi = false;
-	struct hlist_head *head;
 	int packet_size_max;
 	u8 new_remote_flags;
 	bool ret = false;
@@ -701,7 +756,6 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 	int table_size;
 	u32 match_mark;
 	u8 clear_flags;
-	u16 old_flags;
 	u8 set_flags;
 	u16 flags;
 
@@ -821,39 +875,7 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 	batadv_tt_local_event(bat_priv, tt_local, BATADV_NO_FLAGS);
 
 check_roaming:
-	/* Check whether it is a roaming, but don't do anything if the roaming
-	 * process has already been handled. The ROAM flag is claimed via an
-	 * atomic test-and-set to make sure that only a single context handles
-	 * the advertisement for a client
-	 */
-	old_flags = BATADV_TT_CLIENT_ROAM;
-	if (tt_global &&
-	    !(atomic_read(&tt_global->common.flags) & BATADV_TT_CLIENT_ROAM))
-		old_flags = atomic_fetch_or(BATADV_TT_CLIENT_ROAM,
-					    &tt_global->common.flags);
-
-	if (tt_global && !(old_flags & BATADV_TT_CLIENT_ROAM)) {
-		/* These node are probably going to update their tt table */
-		head = &tt_global->orig_list;
-		rcu_read_lock();
-		hlist_for_each_entry_rcu(orig_entry, head, list) {
-			batadv_send_roam_adv(bat_priv, tt_global->common.addr,
-					     tt_global->common.vid,
-					     orig_entry->orig_node);
-		}
-		rcu_read_unlock();
-
-		if (!roamed_back) {
-			/* The global entry was marked as ROAMING and
-			 * has to be kept for consistency purpose
-			 */
-			tt_global->roam_at = jiffies;
-		}
-	}
-
-	/* clean up independent of the roaming advertisement handler */
-	if (tt_global && roamed_back)
-		batadv_tt_global_free(bat_priv, tt_global, "Roaming canceled");
+	batadv_tt_local_add_roam(bat_priv, tt_global, roamed_back);
 
 	/* store the current remote flags before altering them. This helps
 	 * understanding is flags are changing or not

-- 
2.47.3

