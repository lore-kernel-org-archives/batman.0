Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F02A8CD6E6B
	for <batman-adv@archiver.kernel.org>; Fri,  5 Jun 2026 07:25:39 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8A15C81DC5
	for <batman-adv@archiver.kernel.org>; Fri, 05 Jun 2026 09:25:38 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780644338;
 b=xqRZtIOxA6CFBV4B79thJQybwuUpRgbB2xca6+Q/KW0YBfqRnaAKA+4nv9ItHCrCX8s6J
 bPQL3Jnfi+ZgBWOmB9SsLtHK8tHIByM5Qr7srxJne/iIAY3d8fudeFj/GColYpcY8wrWZ4r
 A9mXvVp9Hg8nBbAOYKPzNIkHqjRTOzI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780644338; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=dwwDQk/o0iE4YuAUidfs7nDM7wYXtXm46RbYWVM/OnI=;
 b=b+V4z7qr6R/mOcr0VIiKWD9HHEOzyWnkQ4ReLJhu5xqz4AjTVVv8m3W3fpMVVaxvQMjXR
 KxcW8xf8942E/Zm2f4I2maO3P20o4JHQYn7LQ8iUHA0nkdR+/wc/qyKE3h9oavrYkLAjthT
 eppHpHaPykDAFZmFm9g+k7to0SIu53M=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id CBE3781115
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 05 Jun 2026 09:20:17 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780644017;
	b=nEO57l1bHQbUPMwiKa8ULMFvvvEU/iTfkAmemtHzqgZFGVnfbbqIlWH6CPxKDmdj4IEgbA
	Yb3ze0DsSuD6fMwKS1g6XHkPmlp4Z8znh5CzVoVu45yZ5R7jv6+cpgYQUoQlkyi4Hpch6f
	0XeV/VRsGGltX6C3ZFOb4j3ycbISFGg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=RaHn+Uxw;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780644017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=dwwDQk/o0iE4YuAUidfs7nDM7wYXtXm46RbYWVM/OnI=;
	b=Vxder4s4vSzlE8sOddyBy52rQdanH+7o2qqYC1/Z5RGZFsgGmZ9yXibX0S+hTQyLTA1gP2
	ofGoAkcH06PwE26ywO3U5btO0etMqHcSn+tjrWAcGxYl1lJNau74512DA9Yia9YJIdadw9
	RZc5FR7SuuRb5bcRnGfzN2u8Ff+ubno=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780644017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dwwDQk/o0iE4YuAUidfs7nDM7wYXtXm46RbYWVM/OnI=;
	b=RaHn+UxwTY05k7h3JSOpPEmjfA+ZKR3+yqksxOWtYbOPI7qDCsIfBJiJkGr3LqyhzTeDZo
	/nrd9Kj/HblE+KNko565FI5V9Ls+2YQZcJGtGV6XZg+BYSaYPl3KICfAC3mp371PXrcFrz
	jVMi7FYCc9f0K2KVYCp00wZRpkUAOjmsgPsSTEi9hIPW2M0FBz0nZprJ/M1N8kPZfqW3kg
	PZQqj7ea6Etc//FyR8xgTC+ODBrcvQjNflgsmTyqGeSb8tHmhmGH51JcqgBD/wVNXKmJfb
	pe+0rNs7GWtialp/I/GlgIoZim4UJ7gPadIN41qyHOa1sFksRuT9kGvLBc36Lw==
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
Subject: [PATCH net-next 08/11] batman-adv: bla: update stale kernel-doc
Date: Fri,  5 Jun 2026 09:20:02 +0200
Message-ID: <20260605072005.490368-9-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260605072005.490368-1-sw@simonwunderlich.de>
References: <20260605072005.490368-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: BMLMQKAOM2M5RPQSPZRZS2YSZSROMPDR
X-Message-ID-Hash: BMLMQKAOM2M5RPQSPZRZS2YSZSROMPDR
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BMLMQKAOM2M5RPQSPZRZS2YSZSROMPDR/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

The bridge-loop-avoidance code was changed recently to avoid inconsistent
state and race condition problems. The kernel-doc addded in these commits
(and related code) has various minor deficits which are now resolved.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bridge_loop_avoidance.c |  2 +-
 net/batman-adv/bridge_loop_avoidance.h |  2 +-
 net/batman-adv/types.h                 | 10 +++++++---
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 0bd24a19ff202..5c73f6ba16cff 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -123,7 +123,7 @@ static bool batadv_compare_backbone_gw(const struct hlist_node *node,
  * @node: list node of the first entry to compare
  * @data2: pointer to the second claims
  *
- * Return: true if the claim have the same data, 0 otherwise
+ * Return: true if the claims have the same data, false otherwise
  */
 static bool batadv_compare_claim(const struct hlist_node *node,
 				 const void *data2)
diff --git a/net/batman-adv/bridge_loop_avoidance.h b/net/batman-adv/bridge_loop_avoidance.h
index 8673a265995ff..06c7dfb8c677f 100644
--- a/net/batman-adv/bridge_loop_avoidance.h
+++ b/net/batman-adv/bridge_loop_avoidance.h
@@ -21,7 +21,7 @@
  *  detect frame sent by bridge loop avoidance
  * @mac: mac address to check
  *
- * Return: true if the it looks like a loop detect frame
+ * Return: true if it looks like a loop detect frame
  * (mac starts with BA:BE), false otherwise
  */
 static inline bool batadv_bla_is_loopdetect_mac(const uint8_t *mac)
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index a7fa0d9e09288..5fd5bd358a249 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1723,22 +1723,26 @@ struct batadv_priv {
 
 #ifdef CONFIG_BATMAN_ADV_BLA
 
+/**
+ * enum batadv_bla_backbone_gw_state - state of a bridge loop avoidance
+ *  backbone gateway
+ */
 enum batadv_bla_backbone_gw_state {
 	/**
 	 * @BATADV_BLA_BACKBONE_GW_STOPPED: backbone gw is being removed
-	 * and it must not longer work on requests
+	 * and it must no longer work on requests
 	 */
 	BATADV_BLA_BACKBONE_GW_STOPPED,
 
 	/**
 	 * @BATADV_BLA_BACKBONE_GW_UNSYNCED: backbone was detected out
-	 * of sync and a request was send. No traffic is forwarded until the
+	 * of sync and a request was sent. No traffic is forwarded until the
 	 * situation is resolved
 	 */
 	BATADV_BLA_BACKBONE_GW_UNSYNCED,
 
 	/**
-	 * @BATADV_BLA_BACKBONE_GW_SYNCED: backbone is consider to be in
+	 * @BATADV_BLA_BACKBONE_GW_SYNCED: backbone is considered to be in
 	 * sync. traffic can be forwarded
 	 */
 	BATADV_BLA_BACKBONE_GW_SYNCED,
-- 
2.47.3

