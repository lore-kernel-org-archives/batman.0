Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EACDECE564
	for <batman-adv@archiver.kernel.org>; Tue, 10 Sep 2024 03:27:25 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 549FA83B3C
	for <batman-adv@archiver.kernel.org>; Tue, 10 Sep 2024 05:27:22 +0200 (CEST)
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1725938842;
 b=kT4i71Lv6jrlFnIItRdCI1DLrsLMLmzPlpXye0JD9R6+ogsstVMCKFHrc2B7Kv8mQHfmY
 l0ZKTPUOkfI5/hVnSXgThOzvF/UCAog5zhP0jafYT1FbKwUc2xqE/CMKxK3vO+fcfQSs3gz
 lHNweUKB5qLYKdByJ9ZUKI4nwLY1CXo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1725938842; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=m9dnPvxFUCKk1B5gpFXiYuQhJDTW5JtOINzkFWOO9Po=;
 b=chCYK22E5aVIdAcJETfDbaHAGIQif/9tQyZm7MNcHVRalhxKChHVpwtjUAEI+GKd2ZEiA
 itAeMKxKdIWTxZOlmuVxEvFYrFhDDQHWOLCQP+K/YZdzdv+rV/vyvyx0IqWAMCXMHnQVkKP
 CacrPKTlWxH3YvTbiVFI3QiGuS63QTE=
ARC-Authentication-Results: i=1; open-mesh.org; dkim=fail;
  arc=none (Message is not ARC signed);
  dmarc=fail (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail;
 arc=none (Message is not ARC signed);
 dmarc=fail (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 049CA80F2D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 10 Sep 2024 05:27:14 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH v2] batctl: Dynamically select header format in
 netlink_print_neighbors
From: noahbpeterson1997@gmail.com
To: b.a.t.m.a.n@lists.open-mesh.org
Date: Tue, 10 Sep 2024 03:27:14 -0000
Message-ID: <172593883400.1027.14861329029277869493@diktynna.open-mesh.org>
User-Agent: HyperKitty on https://lists.open-mesh.org/
Message-ID-Hash: YDDKAJNBI4CXWY4AWTLIZZ7BSGA573TJ
X-Message-ID-Hash: YDDKAJNBI4CXWY4AWTLIZZ7BSGA573TJ
X-MailFrom: noahbpeterson1997@gmail.com
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/YDDKAJNBI4CXWY4AWTLIZZ7BSGA573TJ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The netlink_print_neighbors() function previously used a static header format, which did not account for variations between the neighbor list output from different BATMAN routing algorithms (BATMAN_IV vs. BATMAN_V).

This patch introduces a dynamic header selection mechanism that adjusts the output format based on the active routing algorithm:
- For BATMAN_IV, the header is set to "IF             Neighbor              last-seen".
- For BATMAN_V, it changes to "         Neighbor   last-seen      speed           IF".

This change ensures that the table header output in `batctl n` is accurate for both BATMAN routing algorithms.
Signed-off-by: Noah Peterson <noahbpeterson1997@gmail.com>
---
 neighbors.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)
diff --git a/neighbors.c b/neighbors.c
index 3102b0e..f34952b 100644
--- a/neighbors.c
+++ b/neighbors.c
@@ -6,6 +6,7 @@
  * License-Filename: LICENSES/preferred/GPL-2.0
  */
 
+#include <errno.h>
 #include <net/if.h>
 #include <netinet/if_ether.h>
 #include <netlink/netlink.h>
@@ -119,9 +120,28 @@ static int netlink_print_neighbors(struct state *state, char *orig_iface,
 				   int read_opts, float orig_timeout,
 				   float watch_interval)
 {
+	char *header = NULL;
+	char *info_header;
+
+	/* only parse routing algorithm name */
+	last_err = -EINVAL;
+	info_header = netlink_get_info(state, BATADV_CMD_GET_ORIGINATORS, NULL);
+	free(info_header);
+
+	if (strlen(algo_name_buf) == 0)
+		return last_err;
+
+	if (!strcmp("BATMAN_IV", algo_name_buf))
+		header = "IF             Neighbor              last-seen\n";
+	if (!strcmp("BATMAN_V", algo_name_buf))
+		header = "         Neighbor   last-seen      speed           IF\n";
+
+	if (!header)
+		return -EINVAL;
+
 	return netlink_print_common(state, orig_iface, read_opts,
 				    orig_timeout, watch_interval,
-				    "IF             Neighbor              last-seen\n",
+				    header,
 				    BATADV_CMD_GET_NEIGHBORS,
 				    neighbors_callback);
 }
