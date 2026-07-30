Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D875AC5516D
	for <batman@archiver.kernel.org>; Thu, 30 Jul 2026 19:33:32 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 23956831FC
	for <batman@archiver.kernel.org>; Thu, 30 Jul 2026 21:33:31 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785440011;
 b=if0ivF0Y46h+hm+7j7HSGxg3Iafkyn8WKvIZtUuhHr6Aqnb9MHFdvi+BXUn9LLYX5YvEJ
 t3G8P8k62647Iessa50SahQB3lln+txu7modGjuRBumxOUEcLRjvrCuxshvHMCCH14f+XJn
 0ZtPG16s+/cJf7d26XP92Qu14H56ILk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785440011; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=AH6YQxpye2YzWYDOWoXSAUOaZRHHc7NgN3IK6N6p8M4=;
 b=ruPwZxiYVffDUW5cG6WyDkQ2bb3Pn8NVY+JNfQFExHRgtHL9nQzhyE2dSSda/oZaW08Da
 bqF0W7mHbsdlCCGTtuoHCJQXhAsKeQAaiXXWXmjda6tUMdoPnVoO4y9Em8SNHqarkyRKSYI
 gDF+Nn/fuX3grS/yedqhTngHDNQQyAQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 4C98483538
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 30 Jul 2026 21:32:29 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785439949;
	b=Ib+W51qjWmPppzptUawvV0jvMPPFcNgiV9zsXfzIT/hwO4OgSR5inTB523HmE1PcNRX7XT
	TQYVXsNaqW74pRaeQmdvuPlK7ZzdTFW9h3CkCVVbpmcfgofPKP54VRk2gkXZbDj3dbeeSe
	SCXrwfhKT9eJIvbRgjg1nQdRii2jkoI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785439949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=AH6YQxpye2YzWYDOWoXSAUOaZRHHc7NgN3IK6N6p8M4=;
	b=A2jNgSqq8XkNGaEerhRvCpc78wBJ+WUj/2wWSyNJcQhTj0V1V73dUFbsjlFME4shzrmSTE
	WG6seg29iwcuHNwPgN0sI6tq1B+uR/Xy0pHloRzKELfmRxF1mUIHfBcPh+EpFhoAm9lSJp
	Qwz1t04AcwaosPcxzShdKj/gsreGCHA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=Sm5MBhDz;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id D2D7B20CBF;
	Thu, 30 Jul 2026 19:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785439944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AH6YQxpye2YzWYDOWoXSAUOaZRHHc7NgN3IK6N6p8M4=;
	b=Sm5MBhDzjBlcwc9qfO8eE9fAVRO4X4X4brP8VE82k67RDmsWjDek6dl7N4NscBIJ+u83MS
	SOi2PJBhbvbVQdkyP9qz66p7z4fy9h74YBNtIx21prSTy5M/pdKZMgZ3bSGSSh2JBH/dkK
	iRvkjR3E9cqnlhWIkmEcnskQS39etrg=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 30 Jul 2026 21:31:56 +0200
Subject: [PATCH 2/6] alfred: free interface parameters before assigning new
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-bugfixes-parsing-v1-2-c0f2ce4764bd@narfation.org>
References: <20260730-bugfixes-parsing-v1-0-c0f2ce4764bd@narfation.org>
In-Reply-To: <20260730-bugfixes-parsing-v1-0-c0f2ce4764bd@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1218; i=sven@narfation.org;
 h=from:subject:message-id; bh=deJ28v9UYY4FXPQ2oYnPWLH3JBX5WqdeF1NQVKB/m6M=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnZy9bOmjy1biHnmrNN0RVGk1gPforkqWa+bDtl1v7+O
 5vn7H8X2VHKwiDGxSArpsiy50r++c3sb+U/T/t4FGYOKxPIEAYuTgGYiIYkI8OfnU1nf7S+aapq
 /Pzn6j/7ELH8VYF3Ln9ZYH05tqL0SU0BI8PtQxPL7G4yTGQUj319o4lZbMsJa02nF9Yu/7kXMbj
 /mskDAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: JFCECSRMFRW7T3KUO33Q3PMV4YF6LCZ4
X-Message-ID-Hash: JFCECSRMFRW7T3KUO33Q3PMV4YF6LCZ4
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/JFCECSRMFRW7T3KUO33Q3PMV4YF6LCZ4/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When an interface specific parameter is given multiple times then it is
necessary to free the already allocated interface string buffer.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/main.c b/main.c
index 21def01..cc3bc42 100644
--- a/main.c
+++ b/main.c
@@ -235,12 +235,6 @@ static struct globals *alfred_init(int argc, char *argv[])
 		case 'm':
 			globals->opmode = OPMODE_PRIMARY;
 			break;
-		case 'i':
-			globals->net_iface = strdup(optarg);
-			break;
-		case 'b':
-			globals->mesh_iface = strdup(optarg);
-			break;
 		case 'V':
 			i = atoi(optarg);
 			if (i < 0 || i > 255) {
@@ -264,10 +258,16 @@ static struct globals *alfred_init(int argc, char *argv[])
 			break;
 		case 'I':
 			globals->clientmode = CLIENT_CHANGE_INTERFACE;
+			/* fall-through */
+		case 'i':
+			free(globals->net_iface);
 			globals->net_iface = strdup(optarg);
 			break;
 		case 'B':
 			globals->clientmode = CLIENT_CHANGE_BAT_IFACE;
+			/* fall-through */
+		case 'b':
+			free(globals->mesh_iface);
 			globals->mesh_iface = strdup(optarg);
 			break;
 		case 'S':

-- 
2.47.3

