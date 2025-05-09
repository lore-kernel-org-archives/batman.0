Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE4EC3ABC3
	for <batman-adv@archiver.kernel.org>; Fri,  9 May 2025 09:11:52 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 92CBE84753
	for <batman-adv@archiver.kernel.org>; Fri,  9 May 2025 11:11:50 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1746781910;
 b=RBE7pVj7h5vV1hlsfNbzX+0Fp+ocSsdILOknEPLr86kKbOerBw/GtkGpR4mkuPVp+2ZUs
 DnvZamDCxBa/LGG124CPyPoaVJfClbzk24ZS9EIty7A7DYlNudIsVLRkZqre20kCTdlUz49
 a1fKGpMf60nIvtm5BEXAUu2dV8HTpwk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1746781910; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=FOTSTXyXwdd23B6zlkPowC76H/vYFG/GDQkuD5qOzTA=;
 b=oyPUdhcHhAcHni8f5z4i62EHwrM5DDsDRz+MbAsgP2Lt93q8NPD2J19WSIeD+obm+hWtk
 VqqNTK09T/RmEcOzVY1zA8mE33NpiqJD4NargEAtVujI1716KFgnPk3hQqUou5PLqLxH4gl
 AuwbW2h6kofs4yYOp2IQBOej4WFMOIA=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id B4471844C4
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri,  9 May 2025 11:10:43 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1746781843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FOTSTXyXwdd23B6zlkPowC76H/vYFG/GDQkuD5qOzTA=;
	b=LoMaTHWSMm5R+hYPPogUbjrurr/N5WVdheUeknGA1tWA7+VS9s71fEkDldlR4mFBJT8c/o
	TLB2ylM+2i44UGU4lArZ6bs+SW7bpaPgDeUK/hrpsOsT37cth2FrteLyBuHZ41XV0M9huP
	5k2oGRYjO2yfhOfJ51jc4Ey/7aHMHFE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1746781843; a=rsa-sha256;
	cv=none;
	b=10/5cywi120iWr3mMfnI1RRxh3yugY6//ABNX44vdplaYTOMddi/Z3p/bTCkA4w468qg0b
	kX324JZ+Lccy7bWIFzGDY/1XO0DT1WxChfxPs5forikHbsUmEMcxOON+5bsZacnanIuBKD
	adI8zfvULLOiYbgSUaG4uHxH8VrdYSw=
Received: from kero.packetmixer.de
 (p200300c59736c7D829705d90AB67A755.dip0.t-ipconnect.de
 [IPv6:2003:c5:9736:c7d8:2970:5d90:ab67:a755])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 484FEFA132;
	Fri,  9 May 2025 11:10:43 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 1/5] batman-adv: Start new development cycle
Date: Fri,  9 May 2025 11:10:37 +0200
Message-Id: <20250509091041.108416-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250509091041.108416-1-sw@simonwunderlich.de>
References: <20250509091041.108416-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: RY3L3UKSSG6SRXHG2IARYEFTUGENQLYC
X-Message-ID-Hash: RY3L3UKSSG6SRXHG2IARYEFTUGENQLYC
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RY3L3UKSSG6SRXHG2IARYEFTUGENQLYC/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

This version will contain all the (major or even only minor) changes for
Linux 6.16.

The version number isn't a semantic version number with major and minor
information. It is just encoding the year of the expected publishing as
Linux -rc1 and the number of published versions this year (starting at 0).

Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/main.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 67af435ee04e..4b5ce8972848 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -13,7 +13,7 @@
 #define BATADV_DRIVER_DEVICE "batman-adv"
 
 #ifndef BATADV_SOURCE_VERSION
-#define BATADV_SOURCE_VERSION "2025.1"
+#define BATADV_SOURCE_VERSION "2025.2"
 #endif
 
 /* B.A.T.M.A.N. parameters */
-- 
2.39.5

