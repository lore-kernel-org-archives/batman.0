Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF29C43458
	for <batman-adv@archiver.kernel.org>; Sun,  5 Jul 2026 12:55:49 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B1B0E8443A
	for <batman-adv@archiver.kernel.org>; Sun, 05 Jul 2026 14:55:47 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783256147;
 b=fR6DUZ2vPLGXbxRmPoCQFKNr2dfhTULaU01Qgqs8RH5NGRHz7bIGEcuL2CAREnxIXU7gA
 QDWE26LAvhLSq5schZC2RBvFc6/pSVSGdntk6/CCpDiEb3mswGT0D30fLe9/R4fDuccwwGE
 xlt2q7N9mDHxpnWTXi3n0TduGN25CZk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783256147; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=g2AaCxxXFy9VZyXSQY8EqGtOgsChbsbd2JFvLlpvkEU=;
 b=tltx76pAV0jl7dG3oZ3lDo2xhKc6RgraAmNRvHKrTXeEEsqYUGZqmAqfRCi3N1VRp0hcC
 3ct4Ikyxuz2l5edAK0FYuyVKFcTXt/7K96gIvrgn8Y6ygFfvFpvVJ59mqZ+pf12pbUP8aHu
 RzKKKv+TZZRUcJPMDf2R6ioxT9EdJ/k=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 69536819B8
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 05 Jul 2026 14:55:24 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783256124;
	b=DlXM9KxJoyZlp1eITKbmSrQqs1mAfp8FeAFuVPcngn7VlrAH86wf09bb5pw/DsAk0h2Z/a
	0ba1qxiMAXJYEWxdETXmv+/1bOXIOhdbvHQgU0Db4ZIiYaQdRn/DpC5GvXHVlYULAaUJCL
	6xd608U6kA7wVF8693C20W7Dj6qqmxw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783256124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=g2AaCxxXFy9VZyXSQY8EqGtOgsChbsbd2JFvLlpvkEU=;
	b=hM5gXlFftb7X24AKih1yyy9vRXd1QOYmu5qh+9ff2rZm/p4I3ANWHOB+jIpwqlVgu1AQUm
	9bo8ClP71PB9hNuLrO9nnJ5WYTLfMVr/glFg67MT050QMAqyw//nwkM+78sQejY5j0aIq0
	YXmSfcvvYVcF0nB6x0x/YBSazN7r4+I=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=nov7HlD3;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id B33E8201CF;
	Sun, 05 Jul 2026 12:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783256123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g2AaCxxXFy9VZyXSQY8EqGtOgsChbsbd2JFvLlpvkEU=;
	b=nov7HlD3Ff8KhRs/fQM1TJeUKzBABB9yoDiEFAi696QvxXkvzV55be3tLNnp8y7XlbmuDM
	Qv6XhKEa+v5UfgDs8F21neFbJqkaQoJtDOGS1XsMarIZaYH0Cn6UzhHKWJSVog8TgdRMpX
	8zP9F1d/L8RsceRbNyMtTvKtHmnh8Qg=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 0/3] batctl: version bugfixes
Date: Sun, 05 Jul 2026 14:55:05 +0200
Message-Id: <20260705-bugfixes-version-v1-0-5f02046c7eea@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAClUSmoC/yWMQQqDMBQFryJ/bSCmbQK9irgwyav9XVjJVxFC7
 t5olwMzk0mQGELPJlPCzsLfuULXNhTe4zxBcaxMRhurnb4rv00vPiBqRzplFW7RxO5hnfegmi0
 Jl1CrfvizbP6DsJ4fKuUHQXV16XQAAAA=
X-Change-ID: 20260704-bugfixes-version-c3d2d1567bbe
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=790; i=sven@narfation.org;
 h=from:subject:message-id; bh=7ZEMG8UYLZZT2JT26VJqi2xPgGxtIreZj8JLNBRaf4U=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFleIXoq//+92XbCk03fiF1qwZrJb67VCJUxKKQ+tAyze
 1pqdeVBRykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAizIEMfzgepFz9cM7svOnp
 e1+clC8r/WYKnv/9X5nkvPtxma1f72oz/BW+4Xw/e8ctLr89y+5snrZmvqTUvK9B7/QnS3l4ajc
 ptTACAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: RQ2VXL5IMCPQ37R4PTBBEVMV5VPXXRSY
X-Message-ID-Hash: RQ2VXL5IMCPQ37R4PTBBEVMV5VPXXRSY
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RQ2VXL5IMCPQ37R4PTBBEVMV5VPXXRSY/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

I have now splitted the bugfixes for batctl in topic branches to make it a
little bit easier to review. Similar to the "random bugfixes 2026-06-21"
patchset, they are just various (mostly minor) problems which should be
tackled at some point.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Sven Eckelmann (3):
      batctl: only mark file read successful on read line
      batctl: version: avoid use of uninitialized read buffer
      batctl: version: don't strip newline for empty buffer

 functions.c |  5 ++---
 main.c      | 11 +++++++----
 2 files changed, 9 insertions(+), 7 deletions(-)
---
base-commit: eb9597d4ca6db17c579f5ae9443c51b013e2fe65
change-id: 20260704-bugfixes-version-c3d2d1567bbe

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

