Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 574C7EDE9AF
	for <batman-adv@archiver.kernel.org>; Tue, 10 Sep 2024 19:23:13 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A816A83E74
	for <batman-adv@archiver.kernel.org>; Tue, 10 Sep 2024 21:23:11 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1725996191;
 b=Yh3v/ECLHBDKRaRw818E+jZ0ppu62BK4nWV7G3rT5WSlPVsQqfzwVKQNjle1taOu9UdOa
 2O4wiDy+JLN7sylIdL01eWTPT+X+QIhexGTYcCBer+fufw4AGBLBBISY4Wv7qSHFmbiii5F
 O5s4Q80kcHqdF85q0BPfMXGzfYw0sZ8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1725996191; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=L8rIewIgOga3cKLrhKh/y9Jw45YJxfbi5b3zRRBtmlA=;
 b=WtQnAfYp5SYUOfNQ8fZvjDTmpEIwaTc4NmTaw3QEOubnU2rphxirnRc5IkJwszhOS/p3r
 x6LbruAAM8QzstE9/yaMS+sg4E8lZ2pDnef7USZY28ndi1hcrB6ODCyUmgGrwS5ri/PWNse
 3ESMFGO12NI6UXUaYfadWHjKhGJ1HqI=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 0081A824B1
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 10 Sep 2024 21:22:30 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1725996151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=L8rIewIgOga3cKLrhKh/y9Jw45YJxfbi5b3zRRBtmlA=;
	b=JGaxDsAQxcp8TXRbD6BAf9OFnT1jaP9z26QDbq/6vIR08uAC0rKbRE5aWneXp87icVm3ii
	iG0HQSJjoHBEJXdYjI7Phs442Dh8/XHkzipsKdlnPk6fhB8wxmeMIfCQp/ptin1KO4gDuw
	jEuxzvX8hBO4XtvWv/cpHhQKAHw7m5U=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=bqu0hm49;
	spf=pass (diktynna.open-mesh.org: domain of noahbpeterson1997@gmail.com
 designates 2607:f8b0:4864:20::1134 as permitted sender)
 smtp.mailfrom=noahbpeterson1997@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1725996151; a=rsa-sha256;
	cv=none;
	b=279BRveKmd29rr6Ro5BqIi4jqOxMXR+x4QkjKy8VwiM7odA0QmvEFxl2ep2xAWt9xvqcu6
	7wmRqEnFB8zT9j9BWE0mjm5NkkmrWTIKpw0xtDKRHOHEOn4P4laWqGnuAD3rxS4qlEQkej
	cybhT1Aq/t1gDxxKTr3BTop3qJ50EXc=
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-6d9f65f9e3eso56500707b3.3
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Tue, 10 Sep 2024 12:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725996149; x=1726600949;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L8rIewIgOga3cKLrhKh/y9Jw45YJxfbi5b3zRRBtmlA=;
        b=bqu0hm49c43rDOW3fYfFD4w1TWBQ7BFdqQAnvuKEJZ87/Cr3OtZbOL18EVWyd+cK62
         nEUWIDwbpuMMeM0xu7IKPR9kCSWdEfBqu6vUDnuH6MybFRRGBg6AGBKo8GNSwJqtao/Y
         jaCKTJtx5uc0E0cCBRbwrT9LUuI4HOJeurYjULCe19pqPJr5+04aFg7EXRJ+mrOJAI53
         guqtKtaaB9PmXqme5La/dK0YplGlAXvFjGDVH4JPuDLQOv6v6vOwqr0jvjZNTgSRwD+n
         /UcWJeyyXjDXgJc91s329RqgvurbqhFTi8HrPNck/+TOY6s2fWUKz5UfTkwPJdL4thxf
         cR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725996149; x=1726600949;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L8rIewIgOga3cKLrhKh/y9Jw45YJxfbi5b3zRRBtmlA=;
        b=WAn2ynsv9o57c8ZrxUJuyblFzqwnoSAd1US6Hf2j8ezPl2MxgZEyhrcZYWhRx2k0Pm
         Kq4LrtOGihuEFj5p21pHkHudn2ZtYDg6WZ6mGIkuy0ri2ja1t8zdSfd6ZaJTHHCXnqk3
         UD3yCJuiIHfSW0KXaAaBEfa9SpQSarRcnByaDLReMshG4nUE7K8wlPzknRYFDOkNEPMN
         wnSLDk0SIyuD0zcQmrZT7XgSo1h+YBJlRXWjuWC+ywpNeIAUwRLZUYDhn8+1DM7Y4doh
         CBvG1eY4zZ/xBkRO46DzexpPxoQKgu0FuR1OJaDze0kSZxoIT/DnyPGkTdKHPWzcg7bx
         kCeQ==
X-Gm-Message-State: AOJu0YxiG9zlidutguuAl9YCnK0ZKNttQRvl/uqEpv4JM0DUu6bDbVO/
	04rKJL6/vXpeOCETBR8jgmLKjL5mYjmeYpfEgJrOuNt3WqUngZc/50WTfUXR0e/W1g==
X-Google-Smtp-Source: 
 AGHT+IHcqMS0IMYXXJ2gKykrFLD+UEU/geNL6ge023iBzEToIOE0JufwXDXv4Z6T83ZArMlHdWau3g==
X-Received: by 2002:a05:690c:dcb:b0:643:92a8:ba00 with SMTP id
 00721157ae682-6db44a61301mr185978827b3.0.1725996149407;
        Tue, 10 Sep 2024 12:22:29 -0700 (PDT)
Received: from localhost.localdomain
 ([2800:860:71ac:81ad:39dd:aadf:88a2:f660])
        by smtp.gmail.com with ESMTPSA id
 00721157ae682-6db965232f2sm4076837b3.132.2024.09.10.12.22.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Sep 2024 12:22:29 -0700 (PDT)
From: Noah Peterson <noahbpeterson1997@gmail.com>
X-Google-Original-From: Noah Peterson
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Noah Peterson <NoahBPeterson1997@gmail.com>,
	Noah Peterson <noahbpeterson1997@gmail.com>
Subject: [PATCH v3] batctl: Dynamically select header format in
 netlink_print_neighbors
Date: Tue, 10 Sep 2024 13:22:02 -0600
Message-Id: <20240910192201.14442-1-NoahBPeterson1997@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 24GCNRGBNJV4T6RLPDVS3NOHFRCXKJYM
X-Message-ID-Hash: 24GCNRGBNJV4T6RLPDVS3NOHFRCXKJYM
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/24GCNRGBNJV4T6RLPDVS3NOHFRCXKJYM/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Noah Peterson <NoahBPeterson1997@gmail.com>

The netlink_print_neighbors() function previously used a static header
format, which did not account for variations between the neighbor list
output from different BATMAN routing algorithms (BATMAN_IV vs. BATMAN_V).

This change ensures that the table header output in `batctl n` is accurate
for both BATMAN routing algorithms.

Signed-off-by: Noah Peterson <noahbpeterson1997@gmail.com>
---

v3: Correcting commit message and newlines, noted by Sven
<sven@narfation.org>
v2: Changing output based on BATMAN routing algorithm, noted by Sven
<sven@narfation.org>

This patch introduces a dynamic header selection mechanism that adjusts
the output format based on the active routing algorithm:
- For BATMAN_IV, the header is set to "IF             Neighbor              last-seen".
- For BATMAN_V, it changes to "         Neighbor   last-seen      speed           IF".
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
--
2.39.3 (Apple Git-146)

