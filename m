Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78311C56208
	for <batman-adv@archiver.kernel.org>; Thu,  6 Aug 2026 16:56:36 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 83CDA803DF
	for <batman-adv@archiver.kernel.org>; Thu, 06 Aug 2026 18:56:30 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1786035390;
 b=pcO/V3oSWnZ9WEbF8KuDUtLJRBBdcehZVveN6+1irok1mf+jI2v/IhzGaRXsMKgki7swi
 LGpfIBrcwSdu5S7FdnlyfVQyLwZphnD7XAWmCCrZglj45LdihJH7pgrqgfOQIU9PSHtf2QX
 sZbOHlVLU1anCJxykgO+Hp8/Kx3HHXI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1786035390; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=LZtLPKTcwUO/HvzMqfdkw/jWU6LZFxp3friabveOrME=;
 b=Hj7WrqxKBWMm/XTD2UBiJbDD7BVRcu0XM3H0sHZBfA65pMgQiVD199mlAQZm6GuG1F+eO
 Ly3e75ugn6rtZ0fTYgVoQMwikYtjdY29PeX+jxeUh75aUOgwPc8tSlwbM9pmnXFEYfE+aGL
 VxRL7gz2BVam/t4KoYwuK9E56CjQU24=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id EC1E88315F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 06 Aug 2026 18:33:32 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1786034013;
	b=NKE7nypSI6Sogju5XjsXXxHmecys/hvifnGUnS+ulCF5reiLA6zQUySoD8DYGEPSzdSryx
	/6cg7XiaSTYQoyid0DuX+0W6L1IdcemRAi95xPO0xfO2LEmIxNKHk21Af0TZAXU47v/0G1
	li03CMb9sibl6CQoqqzS+dLuurdyCeE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1786034013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=LZtLPKTcwUO/HvzMqfdkw/jWU6LZFxp3friabveOrME=;
	b=iDt1Xn8uGdQ3fmijU0vmkznDdnvzi2w+iq5vPzm8QbkuQ0bmPsyuFjFcJUpLdPT9Zto8el
	v8mrIOmzqG44/wt8MNwW4FHafupQAxyT0gc0iKrCyHzjDpabrUZ4V/66mii+Xdo6ai3Anp
	46ZwQx/fLL4XFrFpM3gU6sOVD6w/Xi4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=oIFQMvBG;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id F0ABE20DEB;
	Thu, 06 Aug 2026 16:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1786034008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LZtLPKTcwUO/HvzMqfdkw/jWU6LZFxp3friabveOrME=;
	b=oIFQMvBG346wQril8K0XbuHdSuaM2VRNkWfShVGI/gsDrgAUxj2tZHI5FJdV/78QSjs06u
	Szm0rdfUU5xyyEKZ0suWTk0qOIihPobnuEaLznM70ORwMeIKwgu8Xfo7ED/ummin/7j8QO
	nuyIJGUuIZMOslO8HstEG3AlePwT37A=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 06 Aug 2026 18:33:24 +0200
Subject: [PATCH batadv] batman-adv: drop direction in
 _batadv_is_ap_isolated kernel-doc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: 
 <20260806-ap_isolation_kerneldoc-param-v1-1-59e0d1cfb5e3@narfation.org>
X-B4-Tracking: v=1; b=H4sIAFO3dGoC/yXMUQrCMBBF0a2U+TaQ1qaKWxEpk2TU0ZqETCxC6
 d4b9fM+HmcBocwkcGoWyDSzcAw12l0D7o7hRop9beh0N+ijHhSmkSVOWOpxfFIONPnoVMKML2X
 Jm0PbG2fNHiqRMl358+PPYLGgn+Hy3+VtH+TK14Z13QD6Gzz4iAAAAA==
X-Change-ID: 20260806-ap_isolation_kerneldoc-param-bed57145cb53
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sashiko <sashiko-bot@kernel.org>, Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1561; i=sven@narfation.org;
 h=from:subject:message-id; bh=q1aCnE1kiM/E9Ru2rwmfpNCgdX0kBdfFYEwM9sAXi2k=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkl20PiIh/IXrtx8tySrl3zkgq//Fsiv7phxeJo3xl3x
 eXUj82O6ChlYRDjYpAVU2TZcyX//Gb2t/Kfp308CjOHlQlkCAMXpwBMZG4jw/+q4nXNX7kU7kZa
 yFhOuXitLVTloW6lh/EiQ6vSCLlnmzQYGRZ7rO+fW/6mv/+YW+vX5yHHj11YcuP60tBVNQYCCVu
 9KxkB
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 5VIR5CXMVJLRATNPBCVHZNTXP64RUZQP
X-Message-ID-Hash: 5VIR5CXMVJLRATNPBCVHZNTXP64RUZQP
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/5VIR5CXMVJLRATNPBCVHZNTXP64RUZQP/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The _batadv_is_ap_isolated() is called by

* batadv_transtable_search()
  - tt_local_entry is the source
  - tt_global_entry is the destination
* batadv_is_ap_isolated
  - tt_local_entry is the destination
  - tt_global_entry is the source

It is therefore incorrect to document the tt_local_entry as sending client
and tt_global_entry as the destination client.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 4f47c97b..883b6c33 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -2490,8 +2490,8 @@ static void batadv_tt_global_table_free(struct batadv_priv *bat_priv)
 /**
  * _batadv_is_ap_isolated() - check whether two clients are AP-isolated from
  *  each other
- * @tt_local_entry: local TT entry of the sending client
- * @tt_global_entry: global TT entry of the destination client
+ * @tt_local_entry: local TT entry of one local client
+ * @tt_global_entry: global TT entry of the remote client
  *
  * Return: true if traffic between the two clients should be dropped because
  *  either both are WiFi clients or both carry the ISOLATION flag; false

---
base-commit: 979765fe212e92b34a1627998820a9c3aaea6424
change-id: 20260806-ap_isolation_kerneldoc-param-bed57145cb53

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

