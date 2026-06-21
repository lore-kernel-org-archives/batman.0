Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F37CD98F0
	for <batman@archiver.kernel.org>; Sun, 21 Jun 2026 14:45:33 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id BE6D684229
	for <batman@archiver.kernel.org>; Sun, 21 Jun 2026 16:45:31 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782053131;
 b=Xrvp7Jr05uYsd/x7GAdtpOljYH5mL6WfkpIY+XXJRxojZujpdV2m2HrqzJP+hGNOIWbO5
 FBv1aoULbzRVl9YqDSHt4qGiila93V2UW2MDaWVygfqjeakQzVqOAeUd85BRD1DYJG4hL4j
 KYT4qNKTjYlvOnVOeqnbAMO4hS9zqdA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782053131; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=5uLx9pq0AX8NJYdtNmGEyPGw2VyNgoyG/RfMDYz7UTU=;
 b=cK8cVbnqw3lNY4stF4KU0N5xa8jqBlMui+3MoiMnC183bY5MMUBTz2+45LOrMhlFr7z+g
 QFKICVBMyYmsUV3hv2FB8Zsv4yU627KDreww+PQgLROft0aBFlDD5T0GqlNw4tnXur6iU/5
 fZ4w/7s67/ZrjY6Km3/2hXtgywoTvH4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id E483A81170
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 21 Jun 2026 16:26:22 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782051982;
	b=NvPnm9QhKcFXlviB98gM+D1ZOUKAHRncwxYaYzvzsxdv6CxWNVdP6ZWTRhdoZoyN9tSJ56
	SAkyNcGc+yjYcvRRWo0J7zXPsk4ReSQ5r5NG1Jetr+FP9KBhH2dAXOGllkn4gvc1/bJBZA
	4D8rmxFfLo344vtYtMObJ1/NZO4dh4A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782051982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=5uLx9pq0AX8NJYdtNmGEyPGw2VyNgoyG/RfMDYz7UTU=;
	b=G7M1AKoJU8JbZb/YzRPpQQhE9FYQ4geK6zeGdY2KIx56tbFw2HN1X4C7XtB/SWm2BSj4Gc
	eKRBeFVohaQx5gzL9x/TCzeWwyAx4VCrQE++o68D2gZPAKTcq4Wy5GYcyA6VMWlwyG6+ov
	5dy3jbmOjYdHdk2AUM5yuD4BGKxs6pY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=KbXkKN5F;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id A52B920059;
	Sun, 21 Jun 2026 14:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782051982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5uLx9pq0AX8NJYdtNmGEyPGw2VyNgoyG/RfMDYz7UTU=;
	b=KbXkKN5FU9CM94nkGzWHdG24DZB66ha1w3u7nz1zmj1gJEO33Fkp4kcemCRqc3pK3oKqX3
	XdIIWwoMkU4dAu7dU402TUK9vK/9UNydqB9Gwsw30MmbenQO1SY774h7JLBRbpsLZE2e5z
	IMnXMBHckUvwqZgrZYPpS2kJUl92Td4=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 21 Jun 2026 16:24:18 +0200
Subject: [PATCH 28/28] batctl: bisect_iv: drop dangling phantom event on
 OOM error
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260621-bugfixes-v1-28-b09736288a4a@narfation.org>
References: <20260621-bugfixes-v1-0-b09736288a4a@narfation.org>
In-Reply-To: <20260621-bugfixes-v1-0-b09736288a4a@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1373; i=sven@narfation.org;
 h=from:subject:message-id; bh=NfB3JKNRvz22lMrfuP2W5rpXTZUPQ3Xtwx/45YZFfDc=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnmXzha87oPlnlseFiyIKdj8e0fP37N6nzw9TCjoKOC8
 xRTgdlTO0pZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATWSrGyLDh3T1uRcvlG5le
 L3Mt5vuXzija3cnrZL8lSMegp0FM9RTDX3Hl7jmvM7zC/0fsX1/NFmN3PT91e9qX54za7AU1jLK
 zWQA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: B4A3FZFIG4I3KJL67ROLODS364TXPI3H
X-Message-ID-Hash: B4A3FZFIG4I3KJL67ROLODS364TXPI3H
X-MailFrom: sven@narfation.org
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/B4A3FZFIG4I3KJL67ROLODS364TXPI3H/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When routing_table_new() fails to allocate rt_table->entries, it might
alrady have allocated the seqno_event for RT_FLAG_DELETE. This seqno_event
is also already part of the orig_event->event_list.

To avoid this dangling DELETE event, it must also be unlinked and freed.

Fixes: ece05e1c4c1f ("[batctl] bisect (a tool to analyze logfiles) added")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bisect_iv.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/bisect_iv.c b/bisect_iv.c
index 6c3f5d6..43b97e4 100644
--- a/bisect_iv.c
+++ b/bisect_iv.c
@@ -187,8 +187,8 @@ static void node_free(void *data)
 
 static int routing_table_new(char *orig, char *next_hop, char *old_next_hop, char rt_flag)
 {
+	struct seqno_event *seqno_event = NULL;
 	struct rt_table *prev_rt_table = NULL;
-	struct seqno_event *seqno_event;
 	struct bat_node *next_hop_node;
 	struct orig_event *orig_event;
 	struct rt_table *rt_table;
@@ -334,6 +334,10 @@ static int routing_table_new(char *orig, char *next_hop, char *old_next_hop, cha
 	if (!rt_table->entries) {
 		fprintf(stderr,
 			"Could not allocate memory for routing table entries (out of mem?) - skipping");
+		if (rt_flag == RT_FLAG_DELETE && seqno_event) {
+			list_del(&seqno_event->list);
+			free(seqno_event);
+		}
 		goto rt_hist_free;
 	}
 

-- 
2.47.3

