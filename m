Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE8EDECE58A
	for <batman-adv@archiver.kernel.org>; Tue, 10 Sep 2024 03:43:52 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 95BD783B13
	for <batman-adv@archiver.kernel.org>; Tue, 10 Sep 2024 05:43:32 +0200 (CEST)
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1725939812;
 b=Zg9nd6qJFN/a1HYDLJx3tdCb3XCEiIc0abhCMeybRUzJB92kRqLdd8S05S1L8x6nAAp0+
 miaj3cejN/B8YLP4Q76dMRwutXBTpNMHg8Wg9USyquMVWOoaMZaK6vcBQmUObx8R7fA709r
 u+mGkKws4Xy3/H11gJ4iW/8SjdQRFSs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1725939812; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=stGH7KcQT4lpGSCy7x5ylUPDY4NcjjRVce003ehpaOw=;
 b=udQCh17gZevslxDQ4YbqSW8PQmyyXF4oiceKs4N/XhPNbla/WgSvmlWVgXIl+rlK5/gYv
 X4dtv3Jxx5pyyQ0fsTbAKBbHyRBA39OZc7h51mLJIRcCLjloS4K56o+6EgguAMI0KsfSm+M
 jqPjTo5ftk0aCTUlc67HBy0tSIxIiVU=
ARC-Authentication-Results: i=1; open-mesh.org; dkim=fail;
  arc=none (Message is not ARC signed);
  dmarc=fail (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail;
 arc=none (Message is not ARC signed);
 dmarc=fail (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 78A348244E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 10 Sep 2024 05:43:25 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH v2] alfred: add more verbose error message
From: noahbpeterson1997@gmail.com
To: b.a.t.m.a.n@lists.open-mesh.org
Date: Tue, 10 Sep 2024 03:43:25 -0000
Message-ID: <172593980548.1027.7186764909573595247@diktynna.open-mesh.org>
User-Agent: HyperKitty on https://lists.open-mesh.org/
Message-ID-Hash: RL6Z3C7LGHUXZQQ6ZPIY5YISMFHVJLRE
X-Message-ID-Hash: RL6Z3C7LGHUXZQQ6ZPIY5YISMFHVJLRE
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RL6Z3C7LGHUXZQQ6ZPIY5YISMFHVJLRE/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

There is an issue with some Linux distributions where network interfaces are up and
active, but do not have the correct link-local address. This condition is now checked and
output to stderr to help better users troubleshoot this issue.

Signed-off-by: Noah Peterson noahbpeterson1997@gmail.com
---
netsock.c | 14 +++++++++++++-
1 file changed, 13 insertions(+), 1 deletion(-)
diff --git a/netsock.c b/netsock.c
index feed21d..a3101df 100644
--- a/netsock.c
+++ b/netsock.c
@@ -21,6 +21,7 @@
 #include <sys/types.h>
 #include <stdlib.h>
 #include <sys/epoll.h>
+#include <arpa/inet.h>
 #ifdef CONFIG_ALFRED_CAPABILITIES
 #include <sys/capability.h>
 #endif
@@ -321,8 +322,19 @@ static int netsock_open(struct globals *globals, struct interface *interface)
 	}
 	enable_raw_bind_capability(0);
 
+
 	if (bind(sock, (struct sockaddr *)&sin6, sizeof(sin6)) < 0) {
-		perror("can't bind");
+		char ipstr_buf[INET6_ADDRSTRLEN];
+		const char *ipstr;
+		ipstr = inet_ntop(AF_INET6, &interface->address.ipv6.s6_addr,
+					ipstr_buf, INET6_ADDRSTRLEN);
+		if (errno == EADDRNOTAVAIL)
+			fprintf(stderr, "can't bind to interface %s; "
+				"expected ipv6 address not found: %s\n",
+				interface->interface,
+				ipstr);
+		else
+			perror("can't bind");
 		goto err;
 	}
