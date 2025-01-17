Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3435EC02183
	for <batman-adv@archiver.kernel.org>; Fri, 17 Jan 2025 12:44:52 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9AF3D84344
	for <batman-adv@archiver.kernel.org>; Fri, 17 Jan 2025 13:44:50 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1737117890;
 b=qckDNuuuEToI/5CoTx3xX/kA3j5V7gU8JOF5m9cSBhGgpBI3ME9nyHVoHCNxQsSH3kVtD
 thtMbsqWawsKSJxZMcC+GnvWYht6bjBwERH/gOu82JPgexy2DcNB9BdcnWtzykFjawX45lt
 x/HxjRj2pVhz3WDWnlVUeFB8h7UlpVY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1737117890; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=+Kb70Z5k1y0Pl1EtJjbF6twEOfd1u4YE37YIEjZcDX8=;
 b=Zq3L36ZMOoN3/JpVoF30RbC+UP08Ox177oN+wFznRzmgzAk8QLSxUDFtI98c+vMmrecRO
 W/3V1ZfkWdMcu0nBW2o4SOaSSZE1RyWqMBTysFdOlhH2q9355WDGgsuotHLNGpVoHsoDtVA
 LZa1GX/ENbGTQmAHLpN2wib3cnwoRFw=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 19D4784113
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 17 Jan 2025 13:39:41 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1737117581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Kb70Z5k1y0Pl1EtJjbF6twEOfd1u4YE37YIEjZcDX8=;
	b=00mbOLEnCS3HH483w1qLDCIMEanSxc0qWOesx88Xj/3iZPV+lPUMzw8ax7vYmtQQUd9P6K
	pcU23V/b/CJNWbgKonnj8DoNPoXJdspK/bZYUN18E0MJptbHHk8kpWbbaPnZmpa4Z8wQWw
	qGt5H9v546v4IlKgmGrjBDkXYVmMkaY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1737117581; a=rsa-sha256;
	cv=none;
	b=h72BPCGIl5pIuRZRDH/3skb+bpp8wuq6djBnIN6qyqmAorOkpwTnEQfdJMyrG1gaYwAORe
	ljHTlvW0+er8kYrV6M3RtkiCr/Lz1yy7GYOS73xBUHwZC9jGDOFsSeFNWNotp42fljQ0Ma
	VTvMNwe4ZQilsby9h50HR5Y1Yl8MTc8=
Received: from kero.packetmixer.de
 (p200300c5973c90d8a96Dd71A2E03F697.dip0.t-ipconnect.de
 [IPv6:2003:c5:973c:90d8:a96d:d71a:2e03:f697])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 617C8FA367;
	Fri, 17 Jan 2025 13:39:40 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 07/10] mailmap: add entries for Simon Wunderlich
Date: Fri, 17 Jan 2025 13:39:07 +0100
Message-Id: <20250117123910.219278-8-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250117123910.219278-1-sw@simonwunderlich.de>
References: <20250117123910.219278-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: DQDSJ5IITKEHFUEP4BAM2SRF2P6K5Y2T
X-Message-ID-Hash: DQDSJ5IITKEHFUEP4BAM2SRF2P6K5Y2T
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/DQDSJ5IITKEHFUEP4BAM2SRF2P6K5Y2T/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Map the defunc mail addresses to the currently used mail address (listed in
MAINTAINERS).

Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 .mailmap | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/.mailmap b/.mailmap
index 53e038f5f654..efabe03f7849 100644
--- a/.mailmap
+++ b/.mailmap
@@ -642,6 +642,11 @@ Simona Vetter <simona.vetter@ffwll.ch> <daniel@biene.ffwll.ch>
 Simon Horman <horms@kernel.org> <simon.horman@corigine.com>
 Simon Horman <horms@kernel.org> <simon.horman@netronome.com>
 Simon Kelley <simon@thekelleys.org.uk>
+Simon Wunderlich <sw@simonwunderlich.de> <simon.wunderlich@open-mesh.com>
+Simon Wunderlich <sw@simonwunderlich.de> <simon.wunderlich@s2003.tu-chemnitz.de>
+Simon Wunderlich <sw@simonwunderlich.de> <simon.wunderlich@saxnet.de>
+Simon Wunderlich <sw@simonwunderlich.de> <simon@open-mesh.com>
+Simon Wunderlich <sw@simonwunderlich.de> <siwu@hrz.tu-chemnitz.de>
 Sricharan Ramabadhran <quic_srichara@quicinc.com> <sricharan@codeaurora.org>
 Srinivas Ramana <quic_sramana@quicinc.com> <sramana@codeaurora.org>
 Sriram R <quic_srirrama@quicinc.com> <srirrama@codeaurora.org>
-- 
2.39.5

