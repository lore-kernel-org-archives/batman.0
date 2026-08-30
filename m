Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035F1C61DE1
	for <batman-adv@archiver.kernel.org>; Sun, 30 Aug 2026 15:31:12 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 972C9803FA
	for <batman-adv@archiver.kernel.org>; Sun, 30 Aug 2026 17:31:11 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788103871;
 b=yop4i0zQkHLKXgPzp30a8UHOPyx+S7w8T5tLO/ww73rBeHnNhdL/hnU1xVD5o6CEBGsrD
 8fV/LPkL8HNjoyWXiBlp27hqys/JOXhq9D4qkr3uxkMFGZclTEiZyQ0X2DefbnVGRTr0mGQ
 V6rjmrHj0qobmAw9LJW196aDpgFUCNs=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788103871; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=nZPqQTQmLUeKMctIrnqLmZNCDmHsOlQEVZ/KjW+B1qc=;
 b=sXEQqE2c8xEL59VO2glLzSGa53OHsRGpiRPKQXCusyzTpr6jgh59kvwjzaJdnM+mU6u9Y
 cNMMEIL04eg0/CmibcYECHDgFWlsONprm9yF5syildTBEQoljRLnXshC88Ej5/ct9UqD0ep
 UJGyXOPSxrSBY3BSxN0NESk44lT6yTI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 66FF8804AB
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 30 Aug 2026 17:23:07 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788103387;
	b=w7f8lx7cPJGZH59NzPVGWhIJtlfpFI2xz2rhi8KqTYIqJ+neYCnEPE88pvgGXFTxXD2X1p
	RLqxi7XU6C0cBiVCx6P8Ycl7dJD6dpiGZxbKeeEw1ckLfO68NHRFR96HgYgr6f7aBSa3XI
	ZIAu3Y0NXhR59YvUqFqhbua2xn3JS9U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788103387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=nZPqQTQmLUeKMctIrnqLmZNCDmHsOlQEVZ/KjW+B1qc=;
	b=EvhUw4vFfbJvCuQcRa9yO5TtN9DJEm7DofrebSM4d5VR2L75PDSHC9XJun2ybx5OkB3AiC
	RfFbyLaMy8JuDuOqyvmx2JfBaea1eMD6n1K2kKiMwamMjQKAQ7xB59CTwuxxVlQfHMATev
	pqXL6gVY9QXVEDd4Cx2Y6dVUKuHt3bI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=yEwzwEC8;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 0A2EC20D90;
	Sun, 30 Aug 2026 15:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788103383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nZPqQTQmLUeKMctIrnqLmZNCDmHsOlQEVZ/KjW+B1qc=;
	b=yEwzwEC87EHTwQPqEC6OfkoopXhQrMAFTawwBnRlN55y1tiivTYkPKgR5jNW5KJmVrTa2g
	UmjZ72X3EIBQ+a9KbMnAEq8Bm1lPtpB+2+DINM9ihE//z8RLh4hUWJNMUxwMiwe7/bliiY
	USWA39Rd1YGzYLjdbwg86KB37y3TDtA=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 30 Aug 2026 17:21:54 +0200
Subject: [PATCH batadv v6 17/20] batman-adv: tt: extract removal of the
 superseded local entry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260830-tt-fixes-v6-17-a56568a15041@narfation.org>
References: <20260830-tt-fixes-v6-0-a56568a15041@narfation.org>
In-Reply-To: <20260830-tt-fixes-v6-0-a56568a15041@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3404; i=sven@narfation.org;
 h=from:subject:message-id; bh=ZSNQJNLp1ALG3l9dupC3OEDIHft51ThT1glag+dq88o=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFlTvDqy/rAvfvrj2b2HyuLZUl672dnq1V46/jhU+abxx
 C6he1vVO0pZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATidrO8Ifz/4GoRIGeP50n
 d/l/v2ubybgpfsLP1d4m7odnGDExvD/N8D9UZGnfk90u2wo6BZfn/Io00omdtfzJ35ZFdzbbaGc
 8b+QBAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: FOROXTK5U3GS4LOTKPD34KNEYIOUPON5
X-Message-ID-Hash: FOROXTK5U3GS4LOTKPD34KNEYIOUPON5
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FOROXTK5U3GS4LOTKPD34KNEYIOUPON5/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

A client which was announced by another originator is no longer a local
client. The code which drops it from the local table and takes over its
WIFI flag is the second cleanup stage of batadv_tt_global_add() and needed
its own goto to skip over the multicast case.

Move it to batadv_tt_global_purge_local().

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 61 +++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 20 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 61cafd0d..eaf8f48f 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1885,6 +1885,46 @@ batadv_tt_global_orig_entry_add(struct batadv_tt_global_entry *tt_global,
 	spin_unlock_bh(&tt_global->list_lock);
 }
 
+/**
+ * batadv_tt_global_purge_local() - drop the local entry of an announced client
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @tt_global_entry: the global TT entry of the announced client
+ * @flags: TT flags announced for this non-mesh client
+ *
+ * A client which is announced by another originator is no longer a local
+ * client. Remove it from the local table and take over the WIFI flag it was
+ * tracked with.
+ */
+static void
+batadv_tt_global_purge_local(struct batadv_priv *bat_priv,
+			     struct batadv_tt_global_entry *tt_global_entry,
+			     u16 flags)
+{
+	struct batadv_tt_common_entry *common = &tt_global_entry->common;
+	u16 local_flags;
+
+	/* Do not remove multicast addresses from the local hash on
+	 * global additions
+	 */
+	if (is_multicast_ether_addr(common->addr))
+		return;
+
+	/* remove address from local hash if present */
+	local_flags = batadv_tt_local_remove(bat_priv, common->addr, common->vid,
+					     "global tt received",
+					     flags & BATADV_TT_CLIENT_ROAM);
+
+	scoped_guard(spinlock_bh, &common->flags_lock) {
+		common->flags |= local_flags & BATADV_TT_CLIENT_WIFI;
+
+		if (!(flags & BATADV_TT_CLIENT_ROAM))
+			/* this is a normal global add. Therefore the client is
+			 * not in a roaming state anymore.
+			 */
+			common->flags &= ~BATADV_TT_CLIENT_ROAM;
+	}
+}
+
 /**
  * batadv_tt_global_merge_flags() - merge announced flags into a global TT entry
  * @tt_global_entry: the global TT entry to update
@@ -2095,26 +2135,7 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 	ret = true;
 
 out_remove:
-	/* Do not remove multicast addresses from the local hash on
-	 * global additions
-	 */
-	if (is_multicast_ether_addr(tt_addr))
-		goto out;
-
-	/* remove address from local hash if present */
-	local_flags = batadv_tt_local_remove(bat_priv, tt_addr, vid,
-					     "global tt received",
-					     flags & BATADV_TT_CLIENT_ROAM);
-
-	spin_lock_bh(&tt_global_entry->common.flags_lock);
-	tt_global_entry->common.flags |= local_flags & BATADV_TT_CLIENT_WIFI;
-
-	if (!(flags & BATADV_TT_CLIENT_ROAM))
-		/* this is a normal global add. Therefore the client is not in a
-		 * roaming state anymore.
-		 */
-		tt_global_entry->common.flags &= ~BATADV_TT_CLIENT_ROAM;
-	spin_unlock_bh(&tt_global_entry->common.flags_lock);
+	batadv_tt_global_purge_local(bat_priv, tt_global_entry, flags);
 
 out:
 	batadv_tt_global_entry_put(tt_global_entry);

-- 
2.47.3

