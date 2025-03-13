Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D26C6C282DE
	for <batman-adv@archiver.kernel.org>; Thu, 13 Mar 2025 16:20:01 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7907884592
	for <batman-adv@archiver.kernel.org>; Thu, 13 Mar 2025 17:20:00 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1741882800;
 b=zPEQfgsKTaZ41iN9h8T4qyM+Nbp8fttwwUJ23co4Kar7iJKthucpwVu4i8pLDDB/Mxkrb
 dkGIkYkmVwVyvNOCtn2lb8EOiA6fyd9spqEiq/zxxvc98kcYMmPp2efNuqBUZ67rmCrsIoN
 57g7tTLAlkT5dnlCD7GYE75GMbiefK4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1741882800; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=mRQB9HoHz/JRUfSoDu4yp1QZYxY24go8AF79U/pOkBc=;
 b=KF6AsJP//8sNEstgKVVsy0DfSabxPaoaTObg/Tw+o2TATdEPuHJx9rXM8wr+wl2QvQ12m
 k1mAIrJCAhpbJFTGuzp28SIqI+I72tCBOgEJPZWq6ikWM840/iepkuhN+8oH5V2nb37WBIF
 cBUx3c0eJMnvidNX/pCvGQjIOGxUJxM=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 189058425F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 13 Mar 2025 17:17:46 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1741882666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mRQB9HoHz/JRUfSoDu4yp1QZYxY24go8AF79U/pOkBc=;
	b=rs+DygcVKCI/j3/ccmIPdKMOVU4XCLgbva5hfSULcRj3u1dE8c6Vqo3c4pxUEPME0YzN2q
	8k+H/m4V7VTlWXgGAsuWAAOD0nZNaHv1HpiwJUXKSgDq1gY4ws1csoTFv9A2xtPcVp1cCw
	l/X1dPW/ph0PpKNN7+j5C/50vbkDWhk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1741882666; a=rsa-sha256;
	cv=none;
	b=U7C8wKCooX6IExf3Wn/q8h48JNcpLzbCRUH7Xa/wT4HVF0rLOkMMZC1In7IEiF8PC8OhDi
	B83RfBQhJkrRLyZjCqpW0sNG2tVEakPHC/6/xBHTcs+M9wqF3iMcgsi8Mbsn7hjzdOdToI
	e4fMI3LHn1aA06e1JijbR/REFRUMmJQ=
Received: from kero.packetmixer.de
 (p200300FA272413901a38a4Bc9C0DE305.dip0.t-ipconnect.de
 [IPv6:2003:fa:2724:1390:1a38:a4bc:9c0d:e305])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 7FB4DFA1EE;
	Thu, 13 Mar 2025 17:17:45 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Remi Pommarel <repk@triplefau.lt>,
	stable@vger.kernel.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 4/5] batman-adv: Fix incorrect offset in
 batadv_tt_tvlv_ogm_handler_v1()
Date: Thu, 13 Mar 2025 17:17:37 +0100
Message-Id: <20250313161738.71299-5-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250313161738.71299-1-sw@simonwunderlich.de>
References: <20250313161738.71299-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: V7PFDVFXLGVATEGGG6EXNJVSYNMFYET3
X-Message-ID-Hash: V7PFDVFXLGVATEGGG6EXNJVSYNMFYET3
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/V7PFDVFXLGVATEGGG6EXNJVSYNMFYET3/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Remi Pommarel <repk@triplefau.lt>

Since commit 4436df478860 ("batman-adv: Add flex array to struct
batadv_tvlv_tt_data"), the introduction of batadv_tvlv_tt_data's flex
array member in batadv_tt_tvlv_ogm_handler_v1() put tt_changes at
invalid offset. Those TT changes are supposed to be filled from the end
of batadv_tvlv_tt_data structure (including vlan_data flexible array),
but only the flex array size is taken into account missing completely
the size of the fixed part of the structure itself.

Fix the tt_change offset computation by using struct_size() instead of
flex_array_size() so both flex array member and its container structure
sizes are taken into account.

Cc: stable@vger.kernel.org
Fixes: 4436df478860 ("batman-adv: Add flex array to struct batadv_tvlv_tt_data")
Signed-off-by: Remi Pommarel <repk@triplefau.lt>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 760d51fdbdf6..7d5de4cbb814 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -3959,23 +3959,21 @@ static void batadv_tt_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 	struct batadv_tvlv_tt_change *tt_change;
 	struct batadv_tvlv_tt_data *tt_data;
 	u16 num_entries, num_vlan;
-	size_t flex_size;
+	size_t tt_data_sz;
 
 	if (tvlv_value_len < sizeof(*tt_data))
 		return;
 
 	tt_data = tvlv_value;
-	tvlv_value_len -= sizeof(*tt_data);
-
 	num_vlan = ntohs(tt_data->num_vlan);
 
-	flex_size = flex_array_size(tt_data, vlan_data, num_vlan);
-	if (tvlv_value_len < flex_size)
+	tt_data_sz = struct_size(tt_data, vlan_data, num_vlan);
+	if (tvlv_value_len < tt_data_sz)
 		return;
 
 	tt_change = (struct batadv_tvlv_tt_change *)((void *)tt_data
-						     + flex_size);
-	tvlv_value_len -= flex_size;
+						     + tt_data_sz);
+	tvlv_value_len -= tt_data_sz;
 
 	num_entries = batadv_tt_entries(tvlv_value_len);
 
-- 
2.39.5

