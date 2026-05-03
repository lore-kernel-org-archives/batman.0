Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5ACFCD3424
	for <batman@archiver.kernel.org>; Sun,  3 May 2026 20:46:53 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id DD3A785437
	for <batman@archiver.kernel.org>; Sun, 03 May 2026 22:46:51 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1777841211;
 b=W8D4lhr9Xi/XdGOCLYDG+v5X9Ohngu5SLvgQ5kd1sA02iwM5fdMxVB2pflgThpVfvbkRF
 cfRRcsRKaKD+jHA7mv6JHy92JHSiEjmJn1AZw34RTB8RjIZM3HW4ykRdyj0qNN3LRIir3Kt
 h6ENovYxOI5jVfP9nucnY5GCLWqnJa4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1777841211; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=2akAyu476DYSvCMGTegf/7PngWzy4rf2uSUoD3iLa/w=;
 b=VW6wfiwkFp/Bb4q7TMOO0Lg/ECoR5P5j+qJjZtK7WYl+pt7RPc0nOijvx8JZD8chOl+5z
 qYu1Lm/pQPVR/1a3DXL2qAZnpZiPZcnmIPe8My/bBAwiAJHHzBPcXIpKaY5jTNDr3wXVtZj
 5tSQfDeLAzjw443YRcSsh+X8WcuGHVk=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 04E1882444
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 03 May 2026 22:46:47 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1777841208;
	b=KatM8ZZbzIR5N5CjHHOv8dh7WEudUiA3Ypp1kOFYh0kIuSkCDrE+d//0zmVgUkPAOn95Ve
	9HmYYQzHOiIleYYepNu5oMKydVBz2NOMcw5L6Oghr+8oH9YTEjSzEZWrITp4YAR9yfntDD
	BMvWbpLGMlL1fbguHxOd3pEPtXqn3Dc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=FLLavlkq;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1777841208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=2akAyu476DYSvCMGTegf/7PngWzy4rf2uSUoD3iLa/w=;
	b=MRgezbEHtlWtDxjnj1bLrk/tRKSY9jUkpqR8orJXYpDFs9QoPVnACB96wk64IYbKml3s2s
	N1OAlFg7GiaHW3ETp+B8MUx1tVsNU7Uvkku+qC23rulsZBlrjBPseOdJNRg5z6vGepErXe
	BGjlyHuosrNt3XHQey/7kQk8KGzCpHY=
Received: by dvalin.narfation.org (Postfix) id 01AD01FDD3;
	Sun, 03 May 2026 20:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1777841206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2akAyu476DYSvCMGTegf/7PngWzy4rf2uSUoD3iLa/w=;
	b=FLLavlkqOlzh99EoWLzh+NDkWX//t1OyPFygTlcOd3y0L9+ZPldOD/UF/Ux3CwOj0OrQWT
	ma0Ui3DR9Zaq0njtmlMmZmELhDv7NypyEP8/YaNmGszWLf6HTYPsbVVh66lRl5/AEGUY08
	d8g6koKugFfdJKht6SbF0P6Mu6wEB6A=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH batadv-next 0/2] batman-adv: post-fixes cleanup
Date: Sun, 03 May 2026 22:46:13 +0200
Message-Id: <20260503-post-fixes-cleanup-v1-0-9c5c0ff0fcb4@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABW092kC/yWMSwrDMAwFrxK0rsCNUQu9SunCH6VVKY6xnBAIu
 XucZjnMm7eCchFWeHQrFJ5FZUwNrpcOwselN6PExtCb/mbIWMyjVhxkYcXwY5emjAN5tmTNnSh
 CC3Ph/6B1T/Cuujhj4qXC65Q6+S+HetzCtu3FpF28gwAAAA==
X-Change-ID: 20260503-post-fixes-cleanup-f5be3530755d
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1017; i=sven@narfation.org;
 h=from:subject:message-id; bh=5AaVjDs8EZZnCBNAn8BVXeou0Ybt7Mv9SfEVhplyLQA=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDJnft0g0uhjI3RH20z6Uv/HSm0k2NR+9Gc/95igX39u74
 feDZKPzHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJvKpg+Gfr+3z2ZdlO3c2F
 W/tO3TspsVzZs/XK/v7LVlkf/nJa60xl+F+V5h14pz9ewc/dRH3K8efLPIVCP7K8f/5LxioysOV
 KNzsA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: THZI2WX5AFF4MNZKWVIZ6DNH5M45CA4M
X-Message-ID-Hash: THZI2WX5AFF4MNZKWVIZ6DNH5M45CA4M
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/THZI2WX5AFF4MNZKWVIZ6DNH5M45CA4M/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

In some of the recent fixes, we got a couple of unclean changes which are
either reported by the daily builds or were noticed during the "follow up
fixes" preparations.

It is nothing spectacular and no reason to add it to the stable branch. Let
us just handle them as part of main/next.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Sven Eckelmann (2):
      batman-adv: add missing includes
      batman-adv: tt: replace open-coded overflow check with helper

 net/batman-adv/bat_v_ogm.c         | 1 +
 net/batman-adv/fragmentation.c     | 1 +
 net/batman-adv/gateway_client.c    | 1 +
 net/batman-adv/hard-interface.c    | 1 +
 net/batman-adv/tp_meter.c          | 1 +
 net/batman-adv/translation-table.c | 8 +++-----
 net/batman-adv/tvlv.c              | 1 +
 7 files changed, 9 insertions(+), 5 deletions(-)
---
base-commit: 3158b1f3ce2a4fe0a07d2a9544dd4b72e2f2670f
change-id: 20260503-post-fixes-cleanup-f5be3530755d

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

