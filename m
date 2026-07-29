Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9049C54F51
	for <batman@archiver.kernel.org>; Wed, 29 Jul 2026 21:04:56 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id CDB81809D6
	for <batman@archiver.kernel.org>; Wed, 29 Jul 2026 23:04:54 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785359094;
 b=JHX5BZ6DIr1zdHzoMb6x5/vbxCH5PBycH+qsaM2NMMAwa9pignhldD6c5IpZ5Q/yA7Tow
 pubCURklgv3Yp9yz9oXM4R7dE1PD6+UjOX8gQ3M1FyGhZaV/c+AMyeGMVQxcAh7mdegGtCH
 nR+97DHtrHR3cr34IELo7YoDKY9Et9A=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785359094; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=qerxn0sKivserJwXAnT3AuIqaHi0TM0PgBgAG81YsQc=;
 b=ROuMzaB78HwWyJYdU5uKi4TxVQdUcq8xg/79czCsQ3F556ilG4R5kgu5/7bBxmhoSCjAR
 +gn1ZpkLjZf0OpPo8lzKOGDm0e1xMR6HgWCeQ/TyEHF84CZnGHBEwsOuXZjcTyBBEzvxo6J
 zokTRcss4XkTf4WHugrmR8nnp/xNCmM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 5A12D809D6
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 29 Jul 2026 23:04:25 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785359075;
	b=gBsdtLk/uxvdnJlDtPdQ+O2NDzrq4wbK/xC8+txgPw0EFemcG2pbL38JusQkRxWjiLk0gb
	3+d57OFB+O8V0aQNdMx84CSnXzbWq6z8+Pl8EfdG82qMP/qHUzwps+H2iD4VxbVqgu0Ejl
	GI3z/F+2ISqnujdaqg3Zx8ZQpcePdlI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785359075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=qerxn0sKivserJwXAnT3AuIqaHi0TM0PgBgAG81YsQc=;
	b=qpuSnRPfGEBEct+sKW56U+I+58OgnWJ/0pWEeVTGAHgmYMNksj4EfgJsqERFf1uYdEZglS
	FGSD3J/Hp+bDnMU/uLQVt26O5rKFU5NUk/bHS0ekFDfHpfGnkj/HVTtNNzxsIjL7BNvTnU
	nujJx+bGc8qFqKntqVvHT8oHvWutECM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=IdAPXlQk;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 664DB2005E;
	Wed, 29 Jul 2026 21:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785359059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qerxn0sKivserJwXAnT3AuIqaHi0TM0PgBgAG81YsQc=;
	b=IdAPXlQkSgHBCMnQafZvqMHeCXaD9zXu0ZlbTHE6T7kHH0WDRV2v1Kc1J6sa0/HIU8aHbk
	dzxD2hmV8AESnAJejbdO3fjrxciVr5gORteounxudrEH6NxGSzPzxhJiGk4CJYqxMVRutS
	81lJTsjHo7ADKnzjssgLXWXIpQoIOyg=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 29 Jul 2026 23:04:15 +0200
Subject: [PATCH batadv] batman-adv: bla: only update backbone lasttime on
 changed claim backbone
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: 
 <20260729-bla-lasttime-old-behavior-v1-1-0be875af0456@narfation.org>
X-B4-Tracking: v=1; b=H4sIAM5qamoC/yWMQQrCMBAAv1L27ELNoSV+RTzsdrd2JTaSpEEo/
 btRjzMws0PWZJrh0u2QtFq2uDY4nzqYFlrviiaNwfVu6EfnkQNhoFyKPRVjEGRdqFpMOHvnRh2
 ExQu0/pV0tvfvfQWmQlLh9vd544dO5TuG4/gAumNKMIUAAAA=
X-Change-ID: 20260729-bla-lasttime-old-behavior-f9227e6dbd9d
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1535; i=sven@narfation.org;
 h=from:subject:message-id; bh=9c068pM8rMME1IfcaMBTlNbsT/Wzqjfv2LXqEaH/Vhc=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFlZWRd+CU9b6WWxaqP3m+/CtZJeV68lLfU98r9qA8Mnl
 WNv3J1jOkpZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQAT8WBnZDgy7+d3RzW/g3WT
 Tzb77Zv46axgw11DFfHYE4yi7xXrfBYw/Hf7cKAn+JiPXL2meVT7xFz5Oo2pP5xYNffGbMt+MF9
 RmxEA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 53XYJ6A7AZNB7BYLODN5QI4HMZO7TPRA
X-Message-ID-Hash: 53XYJ6A7AZNB7BYLODN5QI4HMZO7TPRA
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/53XYJ6A7AZNB7BYLODN5QI4HMZO7TPRA/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The old behavior before commit d88d7ea0d0be ("batman-adv: bla: avoid CRC
corruption due to parallel claim add") was to only update the
backbone_gw->lasttime when the backbone_gw of the claim changed. But afte
the CRC fix, the backbone_gw->lasttime was updated for each handled claim.

Return back to the old behavior and only update it when the backbone_gw was
changed.

Fixes: d88d7ea0d0be ("batman-adv: bla: avoid CRC corruption due to parallel claim add")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bridge_loop_avoidance.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index f231afbe..275fdf63 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -766,6 +766,8 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 		spin_lock_bh(&backbone_gw->crc_lock);
 		backbone_gw->crc ^= claim_crc;
 		spin_unlock_bh(&backbone_gw->crc_lock);
+
+		WRITE_ONCE(backbone_gw->lasttime, jiffies);
 	}
 
 	if (old_backbone_gw) {
@@ -777,7 +779,6 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 		batadv_backbone_gw_put(old_backbone_gw);
 	}
 
-	WRITE_ONCE(backbone_gw->lasttime, jiffies);
 	batadv_claim_put(claim);
 }
 

---
base-commit: 95b6f66b2659f617ce1937e790f48dc578ee014c
change-id: 20260729-bla-lasttime-old-behavior-f9227e6dbd9d

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

