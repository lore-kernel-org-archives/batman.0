Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 388CEC56207
	for <batman-adv@archiver.kernel.org>; Thu,  6 Aug 2026 15:15:44 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 778D38427E
	for <batman-adv@archiver.kernel.org>; Thu, 06 Aug 2026 17:15:42 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1786029342;
 b=WXlpY61wtJH5Dal+0hoVWELLr8+fKYvd8Jp9wy9ywHCyE/ZEGLgZVEL8lYetbnj/MjpX6
 NhsyGLkhWaE3ci8Aq/HH3J+AJ6su2c03C8qRcRMJsjmuxyVYkdNoVsDIKGXMfrIRUUua0H0
 iKERTV+zLZsm9opGDAM7gVkffYrPLc0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1786029342; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=LRLsJc9cqYySGqkmyQxuV41sU19tUslidq+Ut+SdwSs=;
 b=i8BdAiIFCzQi1w1+qxBxMQ84Sna7PwpQPxPFDaspXi/lZ4+gMmTV0Edxl9DxGIR3am1Et
 7LtD+yc9lJradlDjhI/y0Ntr/hKAQZ9NnSqB3rwNKdqXMAkhKimOXwi13BupXcnaq+GH6fN
 /VIljier6qhgp06UrJjBVAJWltNwj0Q=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 1C56D803FA
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 06 Aug 2026 17:15:26 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1786029326;
	b=v/yHhcgF50fyC0RjYsX+1IPpm/hB1Q2nQoNexaJZndbzVXM3iyp7KgmKkHOL83fiY8l2j0
	9t61R1OPvzI5rUydzuWGZMEnesxviXeFZmTmwtvBxQmol7gV3NaqBDQeYBJbwj2mZbCAGH
	xsEMFjqM62/giHMeDBjf/1nxIFwHJpE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1786029326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=LRLsJc9cqYySGqkmyQxuV41sU19tUslidq+Ut+SdwSs=;
	b=M0tIqdXG2i0F7u6hMonIY/PpLqxaDJ5HZGtWCD0NaeuUOBleG4UFUS2Gmgz5sGF8V3cKnc
	88baNRgbx1u+JlpG/ifA4OnNyqiswU8+9Anq+vzcmuzg4rZvfHf00jtyNEyZRBg85LGx1T
	g7el/kMbE8GM+TVYzGI+TVSmJw53EF0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=DmOLar+P;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 7F3BD2049B;
	Thu, 06 Aug 2026 15:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1786029321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LRLsJc9cqYySGqkmyQxuV41sU19tUslidq+Ut+SdwSs=;
	b=DmOLar+PVbIG62vkeRHNsoKm42mKrpiUgT0cIOcf2Alizm3Kd+OxUTOBg/lgHNb4pg0Ho7
	mO2OG4Cr5wJ6TDV0+BdDm+kowvWIK90xpxIHMlrks+iakNu30IkKzbrQDZi9qKzTuUz9FA
	0rx2TcqM7jeTMCceVGUT93MIyDfgEDI=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 06 Aug 2026 17:15:03 +0200
Subject: [PATCH batadv v2] batman-adv: dat: fix printing of unknown 4addr
 subtype
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: 
 <20260806-4addr-unknown-subtype-print-v2-1-26d1700f01ff@narfation.org>
X-B4-Tracking: v=1; b=H4sIAPakdGoC/42PwQ6CMBBEf4Xs2TUUAcGT/2E4LHSBatKStlQJ4
 d8t+AMeZzPzdmYFx1axg1uyguWgnDI6iuyUQDeSHhiVjBqyNCvTKi0xJyktzvqlzVujm1u/TIy
 TVdojC6p7kiSoyiESJsu9+hz0B7TkSQZofvcYfHLnd/TuHJXzxi5HjSAO/18fg0CBXKflpbhSU
 dXFXZPtyccVZ2MHaLZt+wLS2Uv25AAAAA==
X-Change-ID: 20260806-4addr-unknown-subtype-print-e1a9fada1a84
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sashiko <sashiko-bot@kernel.org>, Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1333; i=sven@narfation.org;
 h=from:subject:message-id; bh=/B0FgDjC0kJ3/9oroFvimxVbZW6JMuMPyA3PPDt8Ygg=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFklS75/SBXPEy7P2DH1oY22xy1D76CvVyy9w+Zu9P4s8
 f1PqSpzRykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAiD38w/I9fUtQQ7Lzvr+f5
 +toLv/UXWbUsyv7E7ng8sPLNvDllM3MY/tfFzzq5JP1bha8K5850/8XpHyr4/ytu5PN1OuwbcVf
 nATsA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: V274LTDPIFTDDKVISIWLJG7MEZMZBUVT
X-Message-ID-Hash: V274LTDPIFTDDKVISIWLJG7MEZMZBUVT
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/V274LTDPIFTDDKVISIWLJG7MEZMZBUVT/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

If an unknown subtype of an unicast 4addr packets was detected in
batadv_dbg_arp(), it is printing the (known) packet_type instead of the
subtype. This must be switched to the subtype to have any kind of use for
the reader of the debug message.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Changes in v2:
- fix incorrect structure
- Link to v1: https://patch.msgid.link/20260806-4addr-unknown-subtype-print-v1-1-e906357a5895@narfation.org
---
 net/batman-adv/distributed-arp-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 011cfdc4..270f8d6e 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -548,7 +548,7 @@ static void batadv_dbg_arp(struct batadv_priv *bat_priv, struct sk_buff *skb,
 			break;
 		default:
 			batadv_dbg(BATADV_DBG_DAT, bat_priv, "* type: Unknown (%u)!\n",
-				   unicast_4addr_packet->u.packet_type);
+				   unicast_4addr_packet->subtype);
 		}
 		break;
 	case BATADV_BCAST:

---
base-commit: 979765fe212e92b34a1627998820a9c3aaea6424
change-id: 20260806-4addr-unknown-subtype-print-e1a9fada1a84

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

