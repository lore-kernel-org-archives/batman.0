Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F23CD4F4C
	for <batman-adv@archiver.kernel.org>; Sun,  8 Sep 2024 18:08:24 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id AF73683AE5
	for <batman-adv@archiver.kernel.org>; Sun,  8 Sep 2024 20:08:22 +0200 (CEST)
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1725818902;
 b=oZ8H3Op+WNOsuTi01F2C4ChvnUZ6+hWrc82mFv2PkDunsdbYRjfmpw+JQ+Jstmto059d2
 A6I4ljy7ngIIT7d3PlCqIHM5bsVDo2Mfyh3LLMbYLdqdLxbITWy/BeL/FWK824pgLyk+5OT
 7v1CMx44Ra7F14jI/MLpeqLOxOe4dTk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1725818902; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=dxU9dlphWw/NrMAagsrcgtsQ/SJzcXDBATG13nyWZVA=;
 b=NJ5Y7S/sr9D1TwhfqzhWlf25tuJYaORRxINz1dEZ48ASfXh9Ou9UfcisE78o4y7qqoGD9
 57OOwlWLcfXAFuBg8hPyeV6nu2YftXRdssJFG/yGKK23enD4AMh+CZC8hG9kax3vJQBAhgb
 0zPDWaCu35J3kjtM0UEC0RAG4XuwnTQ=
ARC-Authentication-Results: i=1; open-mesh.org; dkim=fail;
  arc=none (Message is not ARC signed);
  dmarc=fail (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail;
 arc=none (Message is not ARC signed);
 dmarc=fail (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 670C081E85
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun,  8 Sep 2024 19:44:28 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH] batctl: neighbor: Fix print neighbors table header
From: noahbpeterson1997@gmail.com
To: b.a.t.m.a.n@lists.open-mesh.org
Date: Sun, 08 Sep 2024 17:44:28 -0000
Message-ID: <172581746841.965.10559798237378220086@diktynna.open-mesh.org>
User-Agent: HyperKitty on https://lists.open-mesh.org/
X-MailFrom: noahbpeterson1997@gmail.com
X-Mailman-Rule-Hits: member-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address
Message-ID-Hash: YG6BHFBYGCSWAYRS2QVEUK5CEKKLMELB
X-Message-ID-Hash: YG6BHFBYGCSWAYRS2QVEUK5CEKKLMELB
X-Mailman-Approved-At: Sun, 08 Sep 2024 20:08:10 +0200
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/YG6BHFBYGCSWAYRS2QVEUK5CEKKLMELB/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

netlink_print_neighbors() now prints the correct header to match what
batman-advanced currently outputs.


The examples in the README.rst are updated too.


Signed-off-by: Noah Peterson <noahbpeterson1997@gmail.com>
---
README.rst  | 6 +++---
neighbors.c | 2 +-
2 files changed, 4 insertions(+), 4 deletions(-)

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
index 3102b0e..9dcdb81 100644
--- a/neighbors.c
+++ b/neighbors.c
@@ -121,7 +121,7 @@ static int netlink_print_neighbors(struct state *state, char *orig_iface,
 {
        return netlink_print_common(state, orig_iface, read_opts,
                                    orig_timeout, watch_interval,
-                                   "IF             Neighbor              last-seen\n",
+                                       "         Neighbor   last-seen      speed           IF\n",
                                    BATADV_CMD_GET_NEIGHBORS,
                                    neighbors_callback);
 }
