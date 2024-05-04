Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC3AC4345F
	for <batman@archiver.kernel.org>; Sat,  4 May 2024 20:27:33 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4C9AB8212F
	for <batman@archiver.kernel.org>; Sat,  4 May 2024 22:27:31 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1714854451;
 b=LM1ZzIj7Agjn278+/TuEU0SRmLpa0nfh0valtnthFzjJ9b6vXXEaVC+2YZ5uuGpbTV6ya
 BGGPlyq3ejYSOD4x5d8oOsYrTGj6EABBpkMtNjUhVCB0Homuw3oBH+x9j9WUM4NQmkmO5JD
 LCqnjghodFFCGBG9zxstQlgbe6mYg5Y=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1714854451; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=HJ0IaHTE8eCZIg11ocZHzPe9V+KPhxnhC4Do3qvkE5M=;
 b=ZE0mGEG1Y9dPHSlBzlwHHk7O5d03D4pVJfj2wZ+Le0e5LzyA+7QcuyvbJ6gaLXnvy3W5X
 34Jg9LxTrZYrwy2HknvgBbqmg3p4keZ98S7wcTUuOSPVvyttF4b47CirDcux6gegS30v+ND
 KoSm3gKhfY7uF4SAuLZdauhsvJdVQxI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 67F83819D5
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat,  4 May 2024 22:27:27 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1714854447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=HJ0IaHTE8eCZIg11ocZHzPe9V+KPhxnhC4Do3qvkE5M=;
	b=tisrA5btZItA55Vsc5iFDRf7NeWppGdBIvc+7GWDU53MDaHetn1YHfgxnv5OPy2tiONJRT
	fBUZCeQfDoJDh1rptLeMIyUnhsc0U41MuYiKSW8+eGTqI4RxyTwcfUkx9zhCZDl1YiVrnV
	F5+JZXGDBcvfT2VEtVnJFoOX7x1UkE8=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1714854447; a=rsa-sha256;
	cv=none;
	b=labZSbRaE8a5H1chc28bwVnacJDfhwGqoLDtuAT1F455O9YA5RCOSuBmFvd7rrDuLJUHCn
	7C441wXD56CzGHHybKz+Czm6/rqng3PjAjkyUxdPHVOk+qy7wEpN5mt26ArAU1MivWjZz0
	QawDxiV1QPi76ZZyyeXPcMevI4Nk8TA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=un6X6VPY;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1714854446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HJ0IaHTE8eCZIg11ocZHzPe9V+KPhxnhC4Do3qvkE5M=;
	b=un6X6VPYwLusB0dOL/oManKJztgq6uaXlxlFO9Ip/R6UDxU/3jVtRAQvon7p+KOVeRbWo0
	NFJxvfP4ZPsONybwREgOix6cLlzAKccHhrumcvFRFub9mD19C6wd8ELUkU2uemqaIVo16w
	DJ1zTVKg9PO172YD1U/mzqoMfIZIykE=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 04 May 2024 22:27:21 +0200
Subject: [PATCH] batman-adv: Don't accept TT entries for out-of-spec VIDs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240504-vlan_check-v1-1-7577dd779198@narfation.org>
X-B4-Tracking: v=1; b=H4sIACiaNmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDUwMT3bKcxLz45IzU5Gxdo2TLZENDM0MDo0RDJaCGgqLUtMwKsGHRsbW
 1AHYeSvtcAAAA
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Antonio Quartulli <a@unstable.cc>,
 =?utf-8?q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>,
 Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2569; i=sven@narfation.org;
 h=from:subject:message-id; bh=b7T2sIEafFAlnHU8HLPFPptu692LI4GQbjzpUHt04Ms=;
 b=owEBbQKS/ZANAwAKAV2HCgfBJntGAcsmYgBmNpopjsTmGhHF6V3ggw5voUGJhpC+46a8mQsQx
 4WN+sHfLFmJAjMEAAEKAB0WIQQXXSuHYSVz3OMy4AJdhwoHwSZ7RgUCZjaaKQAKCRBdhwoHwSZ7
 Rn3AD/9hDQgAUNxSe/SwVJ0Qp3Xnj4SKAc0sXiIfFHNDHAHXIcAzYWJG1INF8HT9SEXDAszx/O/
 Yc+k6+i0DW94VksVMpd3xhwrlSkQxMSUK0oIBN0/6liXPAJtrXUfKbb/KYaXbUtyxu64zjr7LVa
 11U5hYCSIIhHyxjKbs6SRLABPdCsbI47c/OpytCROMfU13gccM6Etkdoq0HXKkfZWnUhJiq6SA3
 KxIVIEXi2C993onRzEJBGynvAWJ9cC2UbkhvQYnzwcfIakMkMQJoRfId7lTRtVnAGpd4chwF5Rr
 yLoxwx8CyULzHKaq+BJFAaNO0JLGZMJ33ndATSPnbX7DQ+kX4FW5oYvbugPiJ+wNW6PJ6qvdq4b
 38ZKkgyA7BQxI2l/zi9G5p0ngeiNE5epFvSr2gaxRs4MNBeAY5S3nZlMDOckHQXwBwjvQ9SVjbg
 XoNDUKNAZJK27kDq7ChocQ0diuz8v16UCg8uKvQ3CCsNmLNbgFpxwHdayZb4eO/iGCtm/fWDdS7
 U0lkLQ8moRbT7I7IjS1WW2M7RUt2yyJRYCgt2KeCTwdnZ/xAqspLIU9IwDEpaKf+WmyHNLaRdIr
 icNSEYTKjoMmD9zlWc10r16GFl7z/7iXIsI5Wj2sbkonO65BE/p1BNcQfJuLFhKvLjP4aZFyLYB
 SzTEeLrZuDabNdg==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: NG6O7VWWY5S7VRBXOF6RYAJC2SWNA6H7
X-Message-ID-Hash: NG6O7VWWY5S7VRBXOF6RYAJC2SWNA6H7
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/NG6O7VWWY5S7VRBXOF6RYAJC2SWNA6H7/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The internal handling of VLAN IDs in batman-adv is only specified for
following encodings:

* VLAN is used
  - bit 15 is 1
  - bit 11 - bit 0 is the VLAN ID (0-4095)
  - remaining bits are 0
* No VLAN is used
  - bit 15 is 0
  - remaining bits are 0

batman-adv was only preparing new translation table entries (based on its
soft interface information) using this encoding format. But the receive
path was never checking if entries in the roam or TT TVLVs were also
following this encoding.

It was therefore possible to create more than the expected maximum of 4096
+ 1 entries in the originator VLAN list. Simply by setting the "remaining
bits" to "random" values in corresponding TVLV.

Fixes: 21a57f6e7a3b ("batman-adv: make the TT CRC logic VLAN specific")
Reported-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/originator.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index ac74f6ea..8f6dd2c6 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -12,6 +12,7 @@
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
 #include <linux/gfp.h>
+#include <linux/if_vlan.h>
 #include <linux/jiffies.h>
 #include <linux/kref.h>
 #include <linux/list.h>
@@ -131,6 +132,29 @@ batadv_orig_node_vlan_get(struct batadv_orig_node *orig_node,
 	return vlan;
 }
 
+/**
+ * batadv_vlan_id_valid() - check if vlan id is in valid batman-adv encoding
+ * @vid: the VLAN identifier
+ *
+ * Return: true when either no vlan is set or if VLAN is in correct range,
+ *  false otherwise
+ */
+static bool batadv_vlan_id_valid(unsigned short vid)
+{
+	unsigned short non_vlan = vid & ~(BATADV_VLAN_HAS_TAG | VLAN_VID_MASK);
+
+	if (vid == 0)
+		return true;
+
+	if (!(vid & BATADV_VLAN_HAS_TAG))
+		return false;
+
+	if (non_vlan)
+		return false;
+
+	return true;
+}
+
 /**
  * batadv_orig_node_vlan_new() - search and possibly create an orig_node_vlan
  *  object
@@ -149,6 +173,9 @@ batadv_orig_node_vlan_new(struct batadv_orig_node *orig_node,
 {
 	struct batadv_orig_node_vlan *vlan;
 
+	if (!batadv_vlan_id_valid(vid))
+		return NULL;
+
 	spin_lock_bh(&orig_node->vlan_list_lock);
 
 	/* first look if an object for this vid already exists */

---
base-commit: c14c19af09d593a8948dcfd4a75ad6eef943ae3e
change-id: 20240504-vlan_check-2c9c116102a1

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>

