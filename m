Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB48DC282DE
	for <batman-adv@archiver.kernel.org>; Thu, 13 Mar 2025 16:46:06 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8381C8429D
	for <batman-adv@archiver.kernel.org>; Thu, 13 Mar 2025 17:46:05 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1741884365;
 b=GqdU9GMPUSZSMIWfP3JasVPgUzNshS/vK+ckFz7zzvBPQV0PzNERH+/z7URltfDIR18Y4
 GhnGxrGJtS/2oZefXgmGG+KKO7JqnGDFkMZtVNZdABGYwHi0PK0mlYTSF/FbYDNbkwQzkAS
 8vSFo9K2RI6w/b5Ja/kOKnERJV+w7cI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1741884365; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=PONVhyNOc5eW7i9J9HSf+4V7/o77WpaWJ7+zFiXaQJc=;
 b=V1t1LnFWag4lBjTVthp7K4qeqxnYr9xOc+h6XX0LIJiiZrH1TdENtRPtvRvXTt0RT2AA7
 3Gm7o2zYs5comlHt5VHjTa7DTZWCWUHn2xtDxK4EMJqYqDtiXogKGHmKY+uqFYZwdfrnmB0
 Qk674WoLHeK47locJY2Id6E8j9EtDoY=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 0A4DB800D6
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 13 Mar 2025 17:45:24 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1741884324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PONVhyNOc5eW7i9J9HSf+4V7/o77WpaWJ7+zFiXaQJc=;
	b=WIDYq8nzNuYuMyUI7xQ0FYW7KUmhzXK8dow5TyaheDdqMJLp2EKnvjsBqxqqsN2tnyOwOk
	/riimqIOi58HyuMyYLbhJWrGiubw2a2cklmMqz24pp/HxQRKvUCK+At1XqaJBRHfdCqQgo
	mJenJRHNEjlQXcOAcp6VW/+AS2BTzhY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1741884324; a=rsa-sha256;
	cv=none;
	b=17Egmc949JhubN8lbArd2URslpAI+9oOn+vJA8AaqeLCsXff1hD8hBQb5bbfkaTqJJ9MCo
	EdtkK7zsLsWw9QjyefAhv67PGMXS/wpLdZN6KIokGbakGcryKKYVOnh9AMOHZciCDqGRXC
	kOzG5Ne6nOoVcmTQpckuPdzZiN8DufA=
Received: from kero.packetmixer.de
 (p200300FA272413901a38A4BC9c0de305.dip0.t-ipconnect.de
 [IPv6:2003:fa:2724:1390:1a38:a4bc:9c0d:e305])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 79F3BFA132;
	Thu, 13 Mar 2025 17:45:23 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 01/10] batman-adv: Start new development cycle
Date: Thu, 13 Mar 2025 17:45:10 +0100
Message-Id: <20250313164519.72808-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250313164519.72808-1-sw@simonwunderlich.de>
References: <20250313164519.72808-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: GNBLXKC3VBKA5AUNOWJ66OMHRHJAB4JW
X-Message-ID-Hash: GNBLXKC3VBKA5AUNOWJ66OMHRHJAB4JW
X-MailFrom: sw@simonwunderlich.de
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/GNBLXKC3VBKA5AUNOWJ66OMHRHJAB4JW/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

This version will contain all the (major or even only minor) changes for
Linux 6.15.

The version number isn't a semantic version number with major and minor
information. It is just encoding the year of the expected publishing as
Linux -rc1 and the number of published versions this year (starting at 0).

Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/main.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 964f3088af5b..626618d0c366 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -13,7 +13,7 @@
 #define BATADV_DRIVER_DEVICE "batman-adv"
 
 #ifndef BATADV_SOURCE_VERSION
-#define BATADV_SOURCE_VERSION "2025.0"
+#define BATADV_SOURCE_VERSION "2025.1"
 #endif
 
 /* B.A.T.M.A.N. parameters */
-- 
2.39.5

