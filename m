Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5357DCD98F0
	for <batman@archiver.kernel.org>; Sun, 21 Jun 2026 14:43:19 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E75C3845F6
	for <batman@archiver.kernel.org>; Sun, 21 Jun 2026 16:43:17 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782052997;
 b=iF0MgeSa3GVgjvNz00P+R5TX+o+ekn5E5j2Yg5b/Jza1mWDbjNKmboBkb14B8WCziU7mX
 fMbpuEM04zFYMg7HzCqvIgRMq6X25h1HcRjn38oqbLua+mAOWhm0mNVY47SYdVMTZekoKeM
 CrU6fu43pUEujsYxyZ25Hg1wpEjoKy0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782052997; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=DNBsZYB/Hj6HqBBP/FsM47g02KXRwSohNVZMXbMdTQs=;
 b=xTdiy6TGhX6T36JuKRJ71Iucl8zvYkG1pKZ4Jwr6T1x3FrVLpWG6lQ/p+5YNYdhgVVN9C
 AFKcw4M/5xi3c2bVjrIYvYy21HYh/MmYk8wVKUabAdKA0QAN9T/+GbposQS81B52rGhccks
 iUFZz+ufoAF3EMhmTMgqYbcEhDMaTA4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 9BB9C8059C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 21 Jun 2026 16:26:16 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782051976;
	b=iEFE8oljjMTMAGbTZxJSqKwQlD4VQ2/lB4VCABAQP5vfwSBzMSvb3uUu8IR4XfIzThSN39
	fizg10YGeRx7ie1msMo9jgc2AmEPUuKRor7Wh6qhOkSHwSZViAUNlXYJijFYURExKk/cHB
	tOyRT8ZgS5KtYCFEqoMQPHF9d8GB3UM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782051976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=DNBsZYB/Hj6HqBBP/FsM47g02KXRwSohNVZMXbMdTQs=;
	b=33dow07lBSGAkdBNtOxUd2FJ9WsQfRCqegXW6ALLhpilDKYjJAQ+87BJBLvUxEiZ0hV/qD
	XR3Ub397oRVMWLiQy7+9azRS1YVGTXWqGarlqnVzhG8vOkED529dTlCLDXkjoMtySgBKcf
	KdgqZfCYi9MKKHuESCrUpG5UIkCqxm4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=bvVI7kLy;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 43A0820059;
	Sun, 21 Jun 2026 14:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782051976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DNBsZYB/Hj6HqBBP/FsM47g02KXRwSohNVZMXbMdTQs=;
	b=bvVI7kLy4yYMMca7irlhVhEATYJxZCfqa/mUijdCtSEiz4F+33QuyhMwIm67JzwU1/hwMB
	osY3Ki3adGbEZImBgf2h34WM+OH2XdAy93TZDh6Q0GpvFdGADJjgCnMNiAXy+f+yYaOUtW
	Bi5uztdHVe1Eo6UQzRF+DgG/bda2pXI=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 21 Jun 2026 16:24:15 +0200
Subject: [PATCH 25/28] batctl: bisect_iv: handle failed node_get for
 RT_FLAG_DELETE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260621-bugfixes-v1-25-b09736288a4a@narfation.org>
References: <20260621-bugfixes-v1-0-b09736288a4a@narfation.org>
In-Reply-To: <20260621-bugfixes-v1-0-b09736288a4a@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=844; i=sven@narfation.org;
 h=from:subject:message-id; bh=x1OB1gsOVfp54vPsv22XXTVhuq0u4idDNEkpdW9i4oA=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnmX9jV5Pv7d9dJR2zbOo3V3mDG2tO3/2tXLJ+ak/kka
 PHiE1Y2HaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJbO5j+GdzWGEt014Tn3jZ
 qlj1Vj/jiPmvD0r9Sq1fIfXny9/jkQcZGV68vuY65VIuH1v6vambfk+afZJPRtf2p93Go4n/TJn
 Ka5kA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: GDZXIK7PQ74XUKHYHWOYH3P3G4CCWLBW
X-Message-ID-Hash: GDZXIK7PQ74XUKHYHWOYH3P3G4CCWLBW
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/GDZXIK7PQ74XUKHYHWOYH3P3G4CCWLBW/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When a node could not be found or allocated, then node_get() will return
NULL. If this is not checked then it will cause NULL-ptr dereferences in
the seqno_event->orig is accessed.

Fixes: 700749a4c2f4 ("[batctl] add recursive check for routing loops")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 bisect_iv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/bisect_iv.c b/bisect_iv.c
index f1ba94e..0e34d37 100644
--- a/bisect_iv.c
+++ b/bisect_iv.c
@@ -311,6 +311,11 @@ static int routing_table_new(char *orig, char *next_hop, char *old_next_hop, cha
 			}
 
 			seqno_event->orig = node_get(orig);
+			if (!seqno_event->orig) {
+				free(seqno_event);
+				goto rt_hist_free;
+			}
+
 			seqno_event->neigh = NULL;
 			seqno_event->prev_sender = NULL;
 			seqno_event->seqno = -1;

-- 
2.47.3

