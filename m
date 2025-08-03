Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC66C87FCB
	for <batman-adv@archiver.kernel.org>; Sun,  3 Aug 2025 06:49:46 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C4CA084BC2
	for <batman-adv@archiver.kernel.org>; Sun,  3 Aug 2025 08:49:44 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1754203784;
 b=Wi9aqC35aQAbfs22n81DxhuLQ3URt0kPX40TugyyYGyVk9j4xnvDnZ3PjhcHlheSsi8Pv
 y2ZEsLsUWFw/GcDj7etlJYi0caaSBbonJqYcNg1XXoldl7G1E9426T8t0SBvnUOeK8hiaFy
 UsSYnMWMwQ9L3sdaK59PHNe3qzCjT8Q=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1754203784; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=N7YV4fzN+fXG/NtcnvAR2/CRZPI3P9k18QGZ/r9bVjY=;
 b=SWCxrz9QxgAbiu81mrjEVefYdi4ZCX7vYPUY8LTtsSrfNxXbFBGg4RFqM95Amf1iEVOg4
 u58YPYIobyaK1tsWBm6H4Wb5zIJosrJDaAjXlnLISwaR6bclwzYEXIRr8JUWeZR9Y115Orr
 zKUsfSJFSqGwBb8bmoTRlFaqXjFFxTM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id D6E9084B3C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun,  3 Aug 2025 08:49:21 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1754203761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=N7YV4fzN+fXG/NtcnvAR2/CRZPI3P9k18QGZ/r9bVjY=;
	b=ukIiBK/7RNiaJZ+RxqTCBqU1XBtGe6uRZ5KNkGSDFTq711VKJAZn4B4GGysLaSdyBVqvfi
	LwjtY/SLoYr/eB1AkXW6D8TDXH2GnN/2um9KDgOogyZQMFqLaITg8AbY8JmL6kqYvCm7EX
	g+8nf0lgVqxR5rlv3XpiBZAQ2Bgi5yk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=DYk0TgfH;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1754203761; a=rsa-sha256;
	cv=none;
	b=zUL8BhpLQJReeXJC/CUA7gNTtLDICr5guBRbJXJu4BS/0zD9AuF/jbOQWWsVTo67Iloowl
	dz38cXmCA7OBxCuAgfuQukV29nw88WfhL2pDkujhrB6DrGVZJIKPSk7IGKGIulgpA87ICy
	QY3C1gLiV222pzKl2SatyUM6uYtOWtA=
Received: from sven-desktop.home.narfation.org (unknown
 [IPv6:2a00:1ca0:1d86:99fc::8c24])
	by dvalin.narfation.org (Postfix) with UTF8SMTPSA id 8376B1FEAC;
	Sun,  3 Aug 2025 06:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1754203761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N7YV4fzN+fXG/NtcnvAR2/CRZPI3P9k18QGZ/r9bVjY=;
	b=DYk0TgfH9oTDpR+yRlvf3c9jP6t7hht++QXZdLdOB+Wim1CQBGAcZWwnKvGn5Po52Iu5Dq
	dOA33fmI8YdUZYM7tLaB3gnM/EhgeefoGy9bNWeBuypnjD8J7KUAeLsvXRM2sfFSc9hOeL
	62YzD0f15aw91DAiwKyt4kSDpIqqdRI=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 2/2] batctl: Avoid memory leak in print_routing_algos
Date: Sun,  3 Aug 2025 08:49:12 +0200
Message-ID: <20250803064912.702093-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250803-various-bugfixes-v1-0-017f917ea98c@narfation.org>
References: <20250803-various-bugfixes-v1-0-017f917ea98c@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: CBU7TSUPLQT3VXYLLHEIHU4ETTPWGVWS
X-Message-ID-Hash: CBU7TSUPLQT3VXYLLHEIHU4ETTPWGVWS
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/CBU7TSUPLQT3VXYLLHEIHU4ETTPWGVWS/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The opts.remaining_header string is alocated before the netlink callback
object is created. But the callback object allocation can fail and the
function will return in this case. To fix this, either the string buffer
must be freed in this case or the opts.remaining_header allocation can
simply be moved to a later point.

Fixes: 0a14f8800dac ("batctl: Handle nl_cb_alloc errors")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 routing_algo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/routing_algo.c b/routing_algo.c
index 5aa4597..c3f4580 100644
--- a/routing_algo.c
+++ b/routing_algo.c
@@ -95,12 +95,12 @@ static int print_routing_algos(struct state *state)
 	nl_send_auto_complete(state->sock, msg);
 	nlmsg_free(msg);
 
-	opts.remaining_header = strdup("Available routing algorithms:\n");
-
 	cb = nl_cb_alloc(NL_CB_DEFAULT);
 	if (!cb)
 		return -ENOMEM;
 
+	opts.remaining_header = strdup("Available routing algorithms:\n");
+
 	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, netlink_print_common_cb,
 		  &opts);
 	nl_cb_set(cb, NL_CB_FINISH, NL_CB_CUSTOM, netlink_stop_callback, NULL);
-- 
2.47.2

