Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F680E6FE49
	for <batman-adv@archiver.kernel.org>; Sun,  8 Sep 2024 19:47:37 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B6B5C833C7
	for <batman-adv@archiver.kernel.org>; Sun,  8 Sep 2024 21:47:35 +0200 (CEST)
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1725824855;
 b=LZOmpjXa0WCz3WVzQ2pBt1W9WpZtXPVr7RIaryYIjz11TzcDl80we0mN1qMOs5e8u3ATM
 7G1+JOVJy/EQI/HKJajfQpZx0Simog5GTp2ybvOaNoIkSVYzFy6kyzJzdLnp+9vXMXksHqs
 GuEC+qerbj1+O02jL1zcMU95Yl+H/84=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1725824855; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=zxN/gZvQFbMyqmaUU0a9e90miARlZhCCL7/mLtmnvI8=;
 b=tGzILnj+2rGvblaa1AJ8QhebIY3AuI+QX7b9+2NBdY/ZZzt9LDkqTxBeu1HzuYZsK7jps
 wmbnFKVOzk6tjKigE4KlxeZf+A9S5W1fKeoPgPBVBDxJlHdiocMzJ9HGAcXzHSDpi5vkyjp
 3hiNdfQu/mizD97cmLkhKv3pNO+dLjM=
ARC-Authentication-Results: i=1; open-mesh.org; dkim=fail;
  arc=none (Message is not ARC signed);
  dmarc=fail (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail;
 arc=none (Message is not ARC signed);
 dmarc=fail (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 62BB080E20
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun,  8 Sep 2024 21:47:27 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] batctl: neighbor: Fix print neighbors table header
From: noahbpeterson1997@gmail.com
To: b.a.t.m.a.n@lists.open-mesh.org
Date: Sun, 08 Sep 2024 19:47:27 -0000
Message-ID: <172582484739.965.4055700225406232992@diktynna.open-mesh.org>
In-Reply-To: <2343687.ElGaqSPkdT@sven-l14>
References: <2343687.ElGaqSPkdT@sven-l14>
User-Agent: HyperKitty on https://lists.open-mesh.org/
Message-ID-Hash: APBKDOP5M554L74CE3CHBHSH6JP4QLX5
X-Message-ID-Hash: APBKDOP5M554L74CE3CHBHSH6JP4QLX5
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/APBKDOP5M554L74CE3CHBHSH6JP4QLX5/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

> This is wrong, this is not what it outputs for the default B.A.T.M.A.N. IV:

Oops. I believe I now have this issue corrected. I copied the routing algorithm checking code from the netlink_print_gateways() function in gateways.c and change the header accordingly. Let me know if I should revert the change in README.rst.
---
README.rst  |  6 +++---
neighbors.c | 22 +++++++++++++++++++++-
2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/README.rst b/README.rst
index 3495fba..5eda1d3 100644
--- a/README.rst
+++ b/README.rst
@@ -376,9 +376,9 @@ Usage::
 
 Example::
 
-  IF             Neighbor              last-seen
-         enp0s1     16:7b:3c:c2:bf:b8    4.612s
-         enp0s1     ae:1b:bf:52:25:58    0.740s
+           Neighbor   last-seen      speed           IF
+  16:7b:3c:c2:bf:b8    4.612s (     1000.0) [     enp0s1]
+  ae:1b:bf:52:25:58    0.740s (     1000.0) [     enp0s1]
 
 
 batctl originators
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
+       char *header = NULL;
+       char *info_header;
+
+       /* only parse routing algorithm name */
+       last_err = -EINVAL;
+       info_header = netlink_get_info(state, BATADV_CMD_GET_ORIGINATORS, NULL);
+       free(info_header);
+
+       if (strlen(algo_name_buf) == 0)
+               return last_err;
+
+       if (!strcmp("BATMAN_IV", algo_name_buf))
+               header = "IF             Neighbor              last-seen\n";
+       if (!strcmp("BATMAN_V", algo_name_buf))
+               header = "         Neighbor   last-seen      speed           IF\n";
+
+       if (!header)
+               return -EINVAL;
+
        return netlink_print_common(state, orig_iface, read_opts,
                                    orig_timeout, watch_interval,
-                                   "IF             Neighbor              last-seen\n",
+                                   header,
                                    BATADV_CMD_GET_NEIGHBORS,
                                    neighbors_callback);
 }
