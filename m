Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC6D3C43458
	for <batman-adv@archiver.kernel.org>; Sun,  5 Jul 2026 12:25:06 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3F03B84300
	for <batman-adv@archiver.kernel.org>; Sun, 05 Jul 2026 14:25:05 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783254305;
 b=pQBl2rXNhWbCXlGjhslZdxIX/iWyADeFcBeP5uWoY6wLMfq55ShjHfqDN2f/PL6dmiFbC
 gNyRa0hauCsk2wF/pVwfZZRG3C0iVFC3xg8dP9YKE71Nu7t9na18GT0PLURyJtcGeeIbox9
 HleWJ1+gYsCxQqs3RR1CvvHuf2uMaBw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783254305; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=UN3OYKeWWMdzRLyIltfQXEl4SYdRpzWxkhTOsimbNAU=;
 b=B3N+rid4NQrw364jjs6Si/WWjtjL7npYvXkufOBjW2+7xr5C0fB8I3hjkfKWvsfvvj8GL
 FRpg9mFR5BrEXhCjeS4e1PVivKsEbHxJNm1hohYKMgakD3qsh8ia7u/258nLTMiMfl6a6qm
 Kg1YeiCf30dns/fUs7TwUWvBVtmdvMQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=gmail.com;
 arc=pass;
 dmarc=pass header.from=gmail.com policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id E0EA0809A3
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 05 Jul 2026 14:21:46 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783254107;
	b=pmdbZsQo/ZI5NQ6pwUnYTJs+BiGiO+P/D7eTmXu1PaFFLcMamoeL3+7Y7RV1rqY2fXHZaX
	Qqemi/osa7jZeD+xJuJqMSPq3oElbF6SFVUCpqFXhDS0W9i2fZXCsJ0WjOvV0lPKNd9Yzp
	lYKsG3udDYaarZ0VLNHJi12x2PL5ZLI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783254107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=UN3OYKeWWMdzRLyIltfQXEl4SYdRpzWxkhTOsimbNAU=;
	b=GhmiazkJfd3nO5bRZqI21OFIeOc2PCY6Yoyh8UMAt53hmrqas3c9HN5EKdruEnF3SI9B8M
	2YbBknHj/XCmM73UdvnZisSI441E9CKDqDUrOEcmyCkCCR6i8KU9ZdMfPU16vJ/Q4O/nYr
	jS1JzcI+UDXswkIOiNwpD0DM6hC7rmU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=WteipATn;
	spf=pass (diktynna.open-mesh.org: domain of singh.amitesh@gmail.com
 designates 2607:f8b0:4864:20::1036 as permitted sender)
 smtp.mailfrom=singh.amitesh@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-38101f85591so1887019a91.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Sun, 05 Jul 2026 05:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783254104; x=1783858904;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UN3OYKeWWMdzRLyIltfQXEl4SYdRpzWxkhTOsimbNAU=;
        b=WteipATn0GZMrHDRJHtgAdKcM8rb8aUoXziRn4wopN1XfzkQIq85Tw9Wg+JSWhaM6A
         i3G5n7BEhhSugrH141J09UMSJCuZ5xXV+piZM7KXoyzuazY19gepjH9f7hXZnw2JLOz+
         mXVqiWPAl4DAug8nIyCE+cKhxcGjT9kL3eMa3rh3E6aJ6LBu2AMK7FQMoTEYUa6c+/Zr
         HD4XSkr8Y2WQ3UyE7A0s/HTbXd2fYKZoKfhqv7GpfGWh1BU9VHXs+9UCihWhQrXdhlgR
         oEj2eTR0RnJWrA8LZGXrUmLFOVNl2OPuOm/FtOgY+zRpMVVb5kCce3nnYjQ1OtpntGTW
         8zpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783254104; x=1783858904;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UN3OYKeWWMdzRLyIltfQXEl4SYdRpzWxkhTOsimbNAU=;
        b=RGawjWxQSCiwoGIGFbPJT74Hp+Y8gCbSZFm02eJmW0a0gg2l9VvY4vhZPU5LQ74fv1
         sqYsF3WfJ8ebqLFiMeOqRNCy8pI4nVLn+Cz1tojgUyumD/wGPKbot3at8K7ikI6FXYoo
         lY7KofTnToTDUW2ofHjannyWUvt4pDTLg/PSnop+EjiqIVWsXjkIuW2/sCPsL1qqKl7D
         9gIpThrAgjzgKqucHzKzqKlWZUtzR5/cclsTb8XO7TS50ud1Qes4+U55MWgZ5cJKvwmX
         Ix+4vn22kneZW2pFsTV9wjRwgB5HcV0PtddvmGamZ8WPiL5+uaJRD9dQiQ0leMxKev23
         zpcA==
X-Gm-Message-State: AOJu0YzqnMyBwxpSGrCdQ9oneiJUpySY3KhIR9keg30GrnENPRSbgLu6
	SDVksPTer/3M2JNmuNkxxr+BnJ2N1TVYQtbEy79ZhUs/AtIvp3EzDxynpFod955D
X-Gm-Gg: AfdE7ckdNMjI1HqAbCydintpBAPDfEg0V8Yp3ar6HIYNahDeDDLRoUgPgV7QhDZ9uJX
	MZ/0POzOekWJmoDdfqt+ruxLqpH31UI5Cohcz/3BZbHmSx6PKv7BDUFVQiZOTe6m7rs5sws06fc
	18fs2ipnxt+45t9UdsBHaA6sT+ZrhUMePG9+k86YJa2yTY90QHzlfWGHSM4g24HuSvfQFVB4ukW
	mEcvrRpxI+PVYjxhSoRXw201+CreI5OJ0z+0/8HJbdaSOvKOYBDlb4pCLyFRmgDM5wcE2rUGHMx
	ubIOEAylM/+k6oBXTsFcfl13krGR8gtOoSBQrqeKatVnsxnytCChAnXQg5mE2Zn901OOGkA77xB
	kVKLEpVulVaPRXJY440AinU9C5wWkSKNclhjnPCr9CvN1MrguxmVGVX82tpFFbPYUtqhcTuXS+w
	YiBeCW6m0V72SPMomJ0o11pkZ+yaSRSlkftJypFVfc7vmEBddBpHFiaAE1oYYIhxs7VZZwk7BnJ
	uwVTG6H1T+WqOhOHG0whaS+kB9N
X-Received: by 2002:a17:90b:3885:b0:385:3ab:fecb with SMTP id
 98e67ed59e1d1-38503abff46mr1735933a91.4.1783254103623;
        Sun, 05 Jul 2026 05:21:43 -0700 (PDT)
Received: from CP-IN-7ZMK5M3.. ([2402:e280:411f:685:c587:ed87:1606:e634])
        by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f38ee1333sm25795547eec.24.2026.07.05.05.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 05:21:42 -0700 (PDT)
From: Amitesh Singh <singh.amitesh@gmail.com>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: marek.lindner@mailbox.org,
	sw@simonwunderlich.de,
	antonio@mandelbit.com,
	sven@narfation.org,
	linux-kernel@vger.kernel.org,
	amitesh.singh@chargepoint.com
Subject: [PATCH] batman-adv: fix throughput detection for VLAN interfaces
Date: Sun,  5 Jul 2026 17:51:34 +0530
Message-ID: <20260705122134.62809-1-singh.amitesh@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: singh.amitesh@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: EM5VZVE5E56RD5AVQ6DAPB2LADR3M75X
X-Message-ID-Hash: EM5VZVE5E56RD5AVQ6DAPB2LADR3M75X
X-Mailman-Approved-At: Sun, 05 Jul 2026 14:24:43 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/EM5VZVE5E56RD5AVQ6DAPB2LADR3M75X/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Amitesh Singh <amitesh.singh@chargepoint.com>

batadv_v_elp_get_throughput() calls __ethtool_get_link_ksettings() to
determine the link speed of an Ethernet interface. Virtual interfaces
such as a VLAN on a bridge return success but with SPEED_UNKNOWN, so the
function falls through to the hardcoded default even when the underlying
physical device has a known speed.

Move rtnl_unlock() into each exit branch so the lock is still held
after the initial query. When the speed is unknown, walk the lower
device stack with netdev_walk_all_lower_dev() to find the first real
device that reports a valid speed, which covers DSA ports and physical
NICs sitting below a VLAN or bridge interface.

Signed-off-by: Amitesh Singh <amitesh.singh@chargepoint.com>
---
 net/batman-adv/bat_v_elp.c | 48 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 6ad6042a..3d4d82c5 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -70,6 +70,32 @@ static void batadv_v_elp_start_timer(struct batadv_hard_iface *hard_iface)
 			   msecs_to_jiffies(msecs));
 }
 
+/**
+ * batadv_v_elp_lower_dev_throughput() - netdev_walk_all_lower_dev callback
+ *  to query ethtool link speed on a lower device in the stack
+ * @dev: current lower device being visited
+ * @priv: nested priv; priv->data points to a u32 to receive the throughput
+ *  value in multiples of 100kbps
+ *
+ * Return: 1 to stop the walk once a valid speed is found, 0 to continue.
+ */
+static int batadv_v_elp_lower_dev_throughput(struct net_device *dev,
+					     struct netdev_nested_priv *priv)
+{
+	struct ethtool_link_ksettings settings;
+	u32 speed;
+
+	if (__ethtool_get_link_ksettings(dev, &settings) != 0)
+		return 0;
+
+	speed = settings.base.speed;
+	if (!speed || speed == SPEED_UNKNOWN)
+		return 0;
+
+	*(u32 *)priv->data = speed * 10;
+	return 1;
+}
+
 /**
  * batadv_v_elp_get_throughput() - get the throughput towards a neighbour
  * @neigh: the neighbour for which the throughput has to be obtained
@@ -167,7 +193,6 @@ static bool batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh,
 	 * ethtool (e.g. an Ethernet adapter)
 	 */
 	ret = __ethtool_get_link_ksettings(hard_iface->net_dev, &link_settings);
-	rtnl_unlock();
 	if (ret == 0) {
 		/* link characteristics might change over time */
 		if (link_settings.base.duplex == DUPLEX_FULL)
@@ -177,9 +202,30 @@ static bool batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh,
 
 		throughput = link_settings.base.speed;
 		if (throughput && throughput != SPEED_UNKNOWN) {
+			rtnl_unlock();
 			*pthroughput = throughput * 10;
 			return true;
 		}
+
+		/* Virtual interfaces (e.g. VLAN on bridge) don't report link
+		 * speed directly. Walk the lower device stack to find a real
+		 * device that does, such as a DSA port or physical NIC.
+		 */
+		throughput = 0;
+		{
+			struct netdev_nested_priv priv = { .data = &throughput };
+
+			netdev_walk_all_lower_dev(hard_iface->net_dev,
+						  batadv_v_elp_lower_dev_throughput,
+						  &priv);
+		}
+		rtnl_unlock();
+		if (throughput) {
+			*pthroughput = throughput;
+			return true;
+		}
+	} else {
+		rtnl_unlock();
 	}
 
 default_throughput:
-- 
2.43.0

