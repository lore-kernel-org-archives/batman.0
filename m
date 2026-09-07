Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 440B4C79F89
	for <batman-adv@archiver.kernel.org>; Mon,  7 Sep 2026 08:20:52 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B2425841C4
	for <batman-adv@archiver.kernel.org>; Mon, 07 Sep 2026 10:20:50 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788769250;
 b=oBtarzv05AzmeG3LBkmfxm5siYaYfp8/Jqt9LgSHpVvwn+LWe6XuX25f9b9TyMBZnldCm
 Vo95T+DNA7vKMDSFphcv50A6oErfX2cx9bsZGO4pnxshugVoNg+botqLb/7q6LcTWtlBHnd
 BUzIf/k0khzcStQp+90xbYKQMTPO2ZU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788769250; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=RN9LgWd+AGbvJuel+ddkIaD98qz45YUGUEEpTu8o6ss=;
 b=Np8W795d5bl3+Aoo6/N8y0GPNlJMq1dTBfR22ATpyJYffUV1ZROlZQtmmqywAvIochEWI
 +Kd+qY1vnZ0SvWNy5gYBq0Iyqk5C31X6BZ2EUKJuGrJibfISCCbPrjI3vLlzmpHp4caQG40
 LpS87fcxQQ7wpPTLDsV0M2LeMk6k5dQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 41311841A1
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 07 Sep 2026 10:18:38 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788769118;
	b=Dy32n7g+PDN/oovqZMuME/GjCqu3nKfe2QhX1BZ5lpemywaRVKrBn8cb1yKLdUV0aDO5T3
	N7p5pGj5YaiiH7D6CM0Nm6etWqo9Cuq9IepiMf+RqLdOmtQHMDQEtT2TIajLWduei5PIVt
	TF7lyjablm6V8BXFd90k/N+U+YTuo80=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788769118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=RN9LgWd+AGbvJuel+ddkIaD98qz45YUGUEEpTu8o6ss=;
	b=v6UwDCSNnEqOQvvMuu7ZTidiTqaJVYXu98HiKTRy7YFnwURpurK5wVQslc0qu8pBLbtQQ2
	5hkE2e8Lw0NTJyAINcxf4zp3q81tsYeUJUldYTZ7I1B5Z5cW3H4846YAo/frC9oixg8kcL
	cbxYim4qYOIMgWBzj60CQL+CoKVcnYY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b="gZ2bPA+/";
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300C59748d0d8C3747188E6DfE6c0.dip0.t-ipconnect.de
 [IPv6:2003:c5:9748:d0d8:c374:7188:e6df:e6c0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 8E045FA2BC;
	Mon, 07 Sep 2026 10:18:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788769111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RN9LgWd+AGbvJuel+ddkIaD98qz45YUGUEEpTu8o6ss=;
	b=gZ2bPA+/plMxo+VgjXQwtmJwUyf7Z5xNWFKV09Jg+hSEJEspyysiwH1/ZIWEu7d011fcrE
	nRS1LxvhwUVNAdRXBp6GoZ7pWRFw5B9cJryKrrXHSVB9nDwIhSO4AZlEZpbZ/gktVZ9G+X
	22hO7u/12VH9NnTQKg2G44yijtbbafPFRbKx74Qxxlgv9bC1Mj0Eg3oYztBbXt7ID9J+bI
	kpINnGyB1I11Ao8rz8WGma9c0KFPmHJlPnlR012QNZpqYE/6VpX/PmB0GExy0Ty9w4vjL2
	ZDKhTPE6fOqEKG+hqXFIe5wCzbuZfsY1IaiSBaj+r1jMI+Bzz38x+1BOlhsZ/Q==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 07/15] batman-adv: tt: extract merging of flags into
 existing global entries
Date: Mon,  7 Sep 2026 10:18:16 +0200
Message-ID: <20260907081824.2474040-8-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260907081824.2474040-1-sw@simonwunderlich.de>
References: <20260907081824.2474040-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: BQHE3EXVY4DIXMDP2UHRUPVMRNLDSLRF
X-Message-ID-Hash: BQHE3EXVY4DIXMDP2UHRUPVMRNLDSLRF
X-MailFrom: sw@simonwunderlich.de
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BQHE3EXVY4DIXMDP2UHRUPVMRNLDSLRF/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

When an already known global TT entry is announced again, its flags have to
be merged with the announced ones. Two of the merge steps also decide
whether the originator list has to be purged before the announced
originator is added.

Move this to batadv_tt_global_merge_flags() and let it report via its
return value whether the originator list has to be purged.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 87 ++++++++++++++++++------------
 1 file changed, 52 insertions(+), 35 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index d475f8efd44d7..67e4ade5ae997 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1832,6 +1832,57 @@ batadv_tt_global_orig_entry_add(struct batadv_tt_global_entry *tt_global,
 	spin_unlock_bh(&tt_global->list_lock);
 }
 
+/**
+ * batadv_tt_global_merge_flags() - merge announced flags into a global TT entry
+ * @tt_global_entry: the global TT entry to update
+ * @flags: TT flags announced for this non-mesh client
+ *
+ * Return: true if the originator list of @tt_global_entry has to be purged
+ * before the announced originator is added, false otherwise.
+ */
+static bool
+batadv_tt_global_merge_flags(struct batadv_tt_global_entry *tt_global_entry,
+			     u16 flags)
+{
+	struct batadv_tt_common_entry *common = &tt_global_entry->common;
+	bool delete = false;
+
+	scoped_guard(spinlock_bh, &common->flags_lock) {
+		/* if the client was temporary added before receiving the first
+		 * OGM announcing it, we have to clear the TEMP flag. Also,
+		 * remove the previous temporary orig node and re-add it
+		 * if required. If the orig entry changed, the new one which
+		 * is a non-temporary entry is preferred.
+		 */
+		if (common->flags & BATADV_TT_CLIENT_TEMP) {
+			delete = true;
+			common->flags &= ~BATADV_TT_CLIENT_TEMP;
+		}
+
+		/* the change can carry possible "attribute" flags like the
+		 * TT_CLIENT_TEMP, therefore they have to be copied in the
+		 * client entry
+		 */
+		if (!is_multicast_ether_addr(common->addr))
+			common->flags |= flags & (~BATADV_TT_SYNC_MASK);
+
+		/* If there is the BATADV_TT_CLIENT_ROAM flag set, there is only
+		 * one originator left in the list and we previously received a
+		 * delete + roaming change for this originator.
+		 *
+		 * We should first delete the old originator before adding the
+		 * new one.
+		 */
+		if (common->flags & BATADV_TT_CLIENT_ROAM) {
+			delete = true;
+			tt_global_entry->roam_at = 0;
+			common->flags &= ~BATADV_TT_CLIENT_ROAM;
+		}
+	}
+
+	return delete;
+}
+
 /**
  * batadv_tt_global_create() - allocate and initialize a global TT entry
  * @tt_addr: the mac address of the non-mesh client
@@ -1974,41 +2025,7 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 			goto add_orig_entry;
 		}
 
-		delete = false;
-
-		spin_lock_bh(&common->flags_lock);
-		/* if the client was temporary added before receiving the first
-		 * OGM announcing it, we have to clear the TEMP flag. Also,
-		 * remove the previous temporary orig node and re-add it
-		 * if required. If the orig entry changed, the new one which
-		 * is a non-temporary entry is preferred.
-		 */
-		if (common->flags & BATADV_TT_CLIENT_TEMP) {
-			delete = true;
-			common->flags &= ~BATADV_TT_CLIENT_TEMP;
-		}
-
-		/* the change can carry possible "attribute" flags like the
-		 * TT_CLIENT_TEMP, therefore they have to be copied in the
-		 * client entry
-		 */
-		if (!is_multicast_ether_addr(common->addr))
-			common->flags |= flags & (~BATADV_TT_SYNC_MASK);
-
-		/* If there is the BATADV_TT_CLIENT_ROAM flag set, there is only
-		 * one originator left in the list and we previously received a
-		 * delete + roaming change for this originator.
-		 *
-		 * We should first delete the old originator before adding the
-		 * new one.
-		 */
-		if (common->flags & BATADV_TT_CLIENT_ROAM) {
-			delete = true;
-			tt_global_entry->roam_at = 0;
-			common->flags &= ~BATADV_TT_CLIENT_ROAM;
-		}
-		spin_unlock_bh(&common->flags_lock);
-
+		delete = batadv_tt_global_merge_flags(tt_global_entry, flags);
 		if (delete)
 			batadv_tt_global_del_orig_list(tt_global_entry);
 	}
-- 
2.47.3

