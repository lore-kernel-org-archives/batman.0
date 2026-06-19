Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59518CD98E6
	for <batman@archiver.kernel.org>; Fri, 19 Jun 2026 07:06:16 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E4BE6842F8
	for <batman@archiver.kernel.org>; Fri, 19 Jun 2026 09:06:14 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1781852774;
 b=ALhtxReH9kAAguQ/clegCkI/FB0kEhUy3/qNhWoWM1jv3rD4fitSg99nYldXe3bQ6+Rpw
 rNd5CBJxLyW+OCLn7zZ/LeBRRUGGOjAO0vQnKfEa1T+5PshQNzNb40gvvl4nxT3s90Hxyw5
 g3XD8L0g2L/zGH8ZuEOlLBLpHy9hjTQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1781852774; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=YneazJjRkjkrqRDvITxwprn6VJASejkPKALeQwRLQHs=;
 b=fEkU0a3lSBOs4nyVFbEhTfzofmTUgRN7xp1agvYrfhEojID3XpTS5QufhUhXduIYSLYpW
 L2X1o+fHjca3BIo1ATPgw7Y1bEngS2hiuxcBAWX0TExPyMJ00DrYHrsDJ7cbNG/DQv1yPzb
 kxpdFfRLZM9W1EOo6/c8iRUS9XBY5T0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id AEFD483717
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 19 Jun 2026 09:00:49 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1781852454;
	b=cWar8IcMJoEkJ6pDLSzpLUc4Hnsh729aMIHnO9p80hUvD6WUQD2qDPfYQd5Km1fMVC7Kq/
	EGcsB8ctT8hwR+CJ0DHWWEa2DevqjWGvz8XLUg+B8UwD9RsIZDAyIlliiHERqh6Sv7u5eT
	EYDVTCqSOIJQiGJZ5Tgpqr52fThJMdY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1781852454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=YneazJjRkjkrqRDvITxwprn6VJASejkPKALeQwRLQHs=;
	b=R07eg2kSC5LEuKlJXjHC5F91Kp//LOtDJ1QMDU7nvqrgfNb7iFGmWBa1Q5sU1AJ8unWZBW
	fteo84D3BQ+e+xqTLisutfi47EzMqoMe+/zMc+dGYwJaOwro9YYRG52vHzCyPHw56zMLvw
	OhNwkxFxOH6D5R4sgA3QQRPIqewZLzg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b="Dff/JlD6";
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1781852448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YneazJjRkjkrqRDvITxwprn6VJASejkPKALeQwRLQHs=;
	b=Dff/JlD62udaKvKivKPN2l1UmATX2XDIdfCBf1G/zAMZMcwxZ0nnMe8qEdbTo5Ms/k85H4
	/Yw3wW+rpvoUxiSuAFYV2U/FHdZjlShfCh63+/upslhW9Dy8RcnhWFh+PPLagVIoIIPGF7
	lWxzfa+5OOed0aj7hdo2VymDHmdbNYhWWE+qOkwXHVMN+hVAffWQXqsaHfGfWQyLguqC+h
	YVNUpbjURlrwmyXWrPH2QOiGWlHqobl3YKzjBA5m4ej4dS0A3+fGrnmkBL4ouopfjGRCdb
	t8HNbHnSm5JETZ1RMtcHPk1XAOj3drGblsaRd1GpNJvXFKGvbmx2Hjf+LnZIoQ==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 03/15] batman-adv: fix (m|b)cast csum after decrementing
 TTL
Date: Fri, 19 Jun 2026 09:00:33 +0200
Message-ID: <20260619070045.438101-4-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619070045.438101-1-sw@simonwunderlich.de>
References: <20260619070045.438101-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: R7H7YL6AVV2X6NMRIK7S5LIU55LBJ56P
X-Message-ID-Hash: R7H7YL6AVV2X6NMRIK7S5LIU55LBJ56P
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/R7H7YL6AVV2X6NMRIK7S5LIU55LBJ56P/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

The broadcast and multicast packets can be received at the same time by the
local system and forwarded to other nodes. Both are simply decrementing the
TTL at the beginning of the receive path - independent of chosen paths
(receive/forward). But such a modification of the data conflicts with the
hw csum. This is not a problem when the packet is directly forwarded but
can cause errors in the local receive path.

Such a problem can then trigger a "hw csum failure". The receiver path must
therefore ensure that the csum is fixed for each modification of the
payload before batadv_interface_rx() is reached.

Since all batman-adv packet types with a ttl have it as u8 at offset 2, a
helper can be used for all of them. But it is only used at the moment for
batadv_bcast_packet and batadv_mcast_packet because they are the only ones
which deliver the packet locally but unconditionally modify the TTL.

Cc: stable@kernel.org
Fixes: 3f69339068f9 ("batman-adv: bcast: queue per interface, if needed")
Fixes: 07afe1ba288c ("batman-adv: mcast: implement multicast packet reception and forwarding")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/routing.c | 58 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 56 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 7b4acd1ad991a..8786b66c8a924 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -8,6 +8,7 @@
 #include "main.h"
 
 #include <linux/atomic.h>
+#include <linux/build_bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/compiler.h>
 #include <linux/errno.h>
@@ -204,6 +205,59 @@ bool batadv_check_management_packet(struct sk_buff *skb,
 	return true;
 }
 
+/**
+ * batadv_skb_decrement_ttl() - decrement ttl in a batman-adv header, csum-safe
+ * @skb: the received packet with @skb->data pointing to the batman-adv header
+ *
+ * Supports the following packet types, all of which carry the TTL at offset 2:
+ *
+ * - batadv_ogm_packet
+ * - batadv_ogm2_packet
+ * - batadv_icmp_header
+ * - batadv_icmp_packet
+ * - batadv_icmp_tp_packet
+ * - batadv_icmp_packet_rr
+ * - batadv_unicast_packet
+ * - batadv_frag_packet
+ * - batadv_bcast_packet
+ * - batadv_mcast_packet
+ * - batadv_coded_packet
+ * - batadv_unicast_tvlv_packet
+ *
+ * Return: true if the packet may be forwarded (ttl decremented),
+ *  false if it must be dropped (ttl would expire)
+ */
+static bool batadv_skb_decrement_ttl(struct sk_buff *skb)
+{
+	static const size_t ttl_offset = 2;
+	u8 *ttl_pos;
+
+	BUILD_BUG_ON(offsetof(struct batadv_ogm_packet, ttl) != ttl_offset);
+	BUILD_BUG_ON(offsetof(struct batadv_ogm2_packet, ttl) != ttl_offset);
+	BUILD_BUG_ON(offsetof(struct batadv_icmp_header, ttl) != ttl_offset);
+	BUILD_BUG_ON(offsetof(struct batadv_icmp_packet, ttl) != ttl_offset);
+	BUILD_BUG_ON(offsetof(struct batadv_icmp_tp_packet, ttl) != ttl_offset);
+	BUILD_BUG_ON(offsetof(struct batadv_icmp_packet_rr, ttl) != ttl_offset);
+	BUILD_BUG_ON(offsetof(struct batadv_unicast_packet, ttl) != ttl_offset);
+	BUILD_BUG_ON(offsetof(struct batadv_frag_packet, ttl) != ttl_offset);
+	BUILD_BUG_ON(offsetof(struct batadv_bcast_packet, ttl) != ttl_offset);
+	BUILD_BUG_ON(offsetof(struct batadv_mcast_packet, ttl) != ttl_offset);
+	BUILD_BUG_ON(offsetof(struct batadv_coded_packet, ttl) != ttl_offset);
+	BUILD_BUG_ON(offsetof(struct batadv_unicast_tvlv_packet, ttl) != ttl_offset);
+
+	ttl_pos = skb->data + ttl_offset;
+
+	/* would expire on this hop -> drop, leave header + csum untouched */
+	if (*ttl_pos < 2)
+		return false;
+
+	skb_postpull_rcsum(skb, ttl_pos, 1);
+	(*ttl_pos)--;
+	skb_postpush_rcsum(skb, ttl_pos, 1);
+
+	return true;
+}
+
 /**
  * batadv_recv_my_icmp_packet() - receive an icmp packet locally
  * @bat_priv: the bat priv with all the mesh interface information
@@ -1197,7 +1251,7 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
 
 	bcast_packet = (struct batadv_bcast_packet *)skb->data;
 
-	if (bcast_packet->ttl-- < 2)
+	if (!batadv_skb_decrement_ttl(skb))
 		goto free_skb;
 
 	orig_node = batadv_orig_hash_find(bat_priv, bcast_packet->orig);
@@ -1304,7 +1358,7 @@ int batadv_recv_mcast_packet(struct sk_buff *skb,
 		goto free_skb;
 
 	mcast_packet = (struct batadv_mcast_packet *)skb->data;
-	if (mcast_packet->ttl-- < 2)
+	if (!batadv_skb_decrement_ttl(skb))
 		goto free_skb;
 
 	tvlv_buff = (unsigned char *)(skb->data + hdr_size);
-- 
2.47.3

