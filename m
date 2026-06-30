Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13CEEC43458
	for <batman-adv@archiver.kernel.org>; Tue, 30 Jun 2026 14:15:57 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B2D7C8314D
	for <batman-adv@archiver.kernel.org>; Tue, 30 Jun 2026 16:15:55 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782828955;
 b=QPfXDuaqQ8ftEBeAkkWCO8aUwntEntueGrR4SgoxndhH4s2j2Clrk9N790xXR3TJMXRa1
 swGfqdsIqZ4DcUYuIxxb3662iquylXyAJr3xYKDMPReo47z78zPG7i4FyLPIMfVvXa4Hr80
 kXmsOORLn8BB4aGllcX+Ihtnc8/w86s=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782828955; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=MhcjqQ6KyMCxsM73KgBkuwr+9k/iTAvcQoxVAttOCz8=;
 b=eRB3kvi/taWmWAzOkOgKWR3lgK+CUuubK2hSFJKdrCUPvj8NG/spVwvExuch8Dkihv9IW
 d8trTSwrbmxEbUpa65V6DiafhjOI3ndsl39zwlEzg8P3NyJ+nKo/admBwy47dOsI7qkxl7N
 5qia/1xNUuiwvHdKiw3+K70cp2H6mQM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 6351F810AD
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 30 Jun 2026 16:06:34 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782828394;
	b=al9BYtrbX5o42Da87ZFGUyyp517RkxE/TJEEXcBIVeb0NELkJIIoG1YeuNqNgabpg3/WXL
	WO9ua+RBMtr21tTtn42NIdpjC8tpegcMOMuwCOeGzU1GILl/1jE3Oyoz6Rpfq88nIwwFQL
	hiD9cJuXlFdvXtWKJRL/0AbAK4L54yE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782828394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=MhcjqQ6KyMCxsM73KgBkuwr+9k/iTAvcQoxVAttOCz8=;
	b=m6A3ENoW5lgxiIjhg9/QiXYlKcTarDn1Hx0TiG27UvKN4O3Og/E/jy/w5WRn8xwUOVYU8U
	KCLos8zKJ9TIVqKnXmYQCOHWBd47FLJR28RZ84qRMd5QoC+YHmKfj88JCaOs5lgLges2wA
	z1E6nG4O9hTznXYcOWHj3CvgDJwwcBE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=YssNSfpm;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1782828393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MhcjqQ6KyMCxsM73KgBkuwr+9k/iTAvcQoxVAttOCz8=;
	b=YssNSfpmia3UchCW5sl0I7q6j8NZf3LT2shv9134oX7cACrSLYBYQ76SHltA6bn9rrE/Yr
	S2b3SN9MxKYr0DtbWPTMigIeiyUVxF0tRShw9Kw99s/eGoaoW8NY0f7xQNWsU1+4sDkTvS
	uC8gQrDIqo1rpVwrHxU3VRREqRCAgNj8vfHPplEsmALAC3dzrVqpDlZsTS21wR+yu6x707
	cA4tFXyf77NhMZaDc0UR8G+aXyX4B+kbP2Gb1ldNgOzd8vPLxBpe4/HBhUBhawf4A/doXX
	sMTKjpA9hbcXM0jYTmNK6Bzk3YUH7uSbjSsdSXMsDoxs4tzRJWqwSSgLE+zHgQ==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 12/15] batman-adv: tp_meter: combine
 adjacent/overlapping unacked entries
Date: Tue, 30 Jun 2026 16:06:20 +0200
Message-ID: <20260630140623.88431-13-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630140623.88431-1-sw@simonwunderlich.de>
References: <20260630140623.88431-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 65DH2JFTJ2VDI3RPMN7PUQINX7W5NJXL
X-Message-ID-Hash: 65DH2JFTJ2VDI3RPMN7PUQINX7W5NJXL
X-MailFrom: sw@simonwunderlich.de
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/65DH2JFTJ2VDI3RPMN7PUQINX7W5NJXL/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

Right at the point when the receiver gets the first packet with a seqno gap
(due to some packet loss/reordering), entries in the unacked list are
created. They are (besides direct seqno matches) are not combined. A lot
more then necessary entries are therefore created. Not for each gap but for
each packet.

This increases the memory consumption and management overhead. But it is
trivial to handle overlapping or adjacent sequence number ranges during the
insert. Only the handling of closed gaps by a new packets requires an extra
step after the insert.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/tp_meter.c | 61 +++++++++++++++++++++++++++++++++------
 net/batman-adv/types.h    |  2 +-
 2 files changed, 53 insertions(+), 10 deletions(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index b7fee6e55f032..5cc719c81ea0b 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -1406,6 +1406,7 @@ static bool batadv_tp_handle_out_of_order(struct batadv_tp_receiver *tp_vars,
 	__must_hold(&tp_vars->common.unacked_lock)
 {
 	struct batadv_tp_unacked *un, *new;
+	struct batadv_tp_unacked *safe;
 	bool added = false;
 
 	new = kmalloc_obj(*new, GFP_ATOMIC);
@@ -1430,20 +1431,46 @@ static bool batadv_tp_handle_out_of_order(struct batadv_tp_receiver *tp_vars,
 	 * seqno than all the others already stored.
 	 */
 	list_for_each_entry_reverse(un, &tp_vars->common.unacked_list, list) {
-		/* check for duplicates */
-		if (new->seqno == un->seqno) {
-			if (new->len > un->len)
-				un->len = new->len;
+		/* look for the right position - an un which is smaller */
+		if (batadv_seq_before(new->seqno, un->seqno))
+			continue;
+
+		/* smaller/equal seqno was found but they might be directly
+		 * after another or overlapping. keep only a single entry
+		 *
+		 * It is already known that:
+		 *
+		 *	un->seqno <= new->seqno
+		 *
+		 * When establishing that:
+		 *
+		 *	new->seqno <= un->seqno + un->len
+		 *
+		 * Then it is not necessary to add a new entry because the
+		 * smaller/equal seqno of un might already contain the new
+		 * received packet or we only add new data directly after
+		 * the end of un. The latter can be identified using:
+		 *
+		 *	un->seqno + un->len <= new->seqno + new->len
+		 */
+		if (!batadv_seq_before(un->seqno + un->len, new->seqno)) {
+			/* new data directly after un? */
+			if (!batadv_seq_before(new->seqno + new->len,
+					       un->seqno + un->len))
+				un->len = new->seqno + new->len - un->seqno;
+
+			/* un now represents both old un + new */
 			kfree(new);
 			added = true;
+
+			/* un has to be used to check if the gap to the next
+			 * seqno range was closed
+			 */
+			new = un;
 			break;
 		}
 
-		/* look for the right position */
-		if (batadv_seq_before(new->seqno, un->seqno))
-			continue;
-
-		/* as soon as an entry having a bigger seqno is found, the new
+		/* as soon as an entry having a smaller seqno is found, the new
 		 * one is attached _after_ it. In this way the list is kept in
 		 * ascending order
 		 */
@@ -1459,6 +1486,22 @@ static bool batadv_tp_handle_out_of_order(struct batadv_tp_receiver *tp_vars,
 		tp_vars->common.unacked_count++;
 	}
 
+	/* check if new filled the gap to the next list entries */
+	un = new;
+	list_for_each_entry_safe_continue(un, safe, &tp_vars->common.unacked_list, list) {
+		if (batadv_seq_before(new->seqno + new->len, un->seqno))
+			break;
+
+		/* next entry is overlapping or adjacent - combine both */
+		if (batadv_seq_before(new->seqno + new->len,
+				      un->seqno + un->len))
+			new->len = un->seqno + un->len - new->seqno;
+
+		list_del(&un->list);
+		kfree(un);
+		tp_vars->common.unacked_count--;
+	}
+
 	/* remove the last (biggest) unacked seqno when list is too large */
 	if (tp_vars->common.unacked_count > BATADV_TP_MAX_UNACKED) {
 		un = list_last_entry(&tp_vars->common.unacked_list,
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index e1463a029e835..c2ab00d8ef160 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1332,7 +1332,7 @@ struct batadv_tp_unacked {
 	u32 seqno;
 
 	/** @len: length of the packet */
-	u16 len;
+	u32 len;
 
 	/** @list: list node for &batadv_tp_vars_common.unacked_list */
 	struct list_head list;
-- 
2.47.3

