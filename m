Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A37BCC55172
	for <batman-adv@archiver.kernel.org>; Tue,  4 Aug 2026 10:20:29 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 153A084214
	for <batman-adv@archiver.kernel.org>; Tue, 04 Aug 2026 12:20:28 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785838828;
 b=DY1Uwr3uL5WtQ6Cl59KaIFxv4Ii4Acb/LoG/6cmrNQ4TJ17LheCFPr8XdxbQbgr2jLJ4g
 zvkER6nI840VlGK7lgdeMOZMe/NoZlGEnknQ0+lWRz/aNgY+PLeMSyZx8BQk59bI/eow4fr
 d1HLZdE6yBcH3w0J5cKSw2NzqLfpixQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785838828; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ySyPelc7Z0vx8SSFi15BU5TocuNea9dhUMNWabrGkDw=;
 b=x1swJ+nNRtZ5ODs62h8wDXPbAcHhbOAnnH8XtQX0J0YvtkG9g7XkY0xqRMXMHV0UkD3/O
 OhOBQ0tAqLxPVfm6vIFNPUfaEcV94LVMCDcuut1ElYMifRwx/PvA/4Ty/oCDpe0wxLMTsKP
 Un5HpHJp/rjoDJCT4h5W/gjcVz2LJ7Y=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id B738B84087
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 04 Aug 2026 12:19:20 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785838760;
	b=iP9iq3fjiAbLqbFWt+vDCPd5Bw8eF2oxEtGk8yL3x6CNpv/Be4npqLxIuMGVz+irYIA2dY
	zfb1amgGbbckfaUyNyKZFlYIjpZRby205kPRtfLZ+6HwfKG52NXijQu3ikWT2EWC+SXbB5
	+4KvuukzODqMz3EFxJkg7qN+/k30Z+M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785838760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=ySyPelc7Z0vx8SSFi15BU5TocuNea9dhUMNWabrGkDw=;
	b=NJvKuFUpP9McNjTcbETGnqwTkBlNYQP7yL2PvP+r7gIWdmeFPuAscx9+WldHT758KyAA2S
	2nM/LNRE3EmGn3EiYctqsvwLmeC58Qbbhmga+pWHUFW5vaJiNo1llQFHd3nsL2aDGlMprt
	0yVOYLLUNbmX40Z/Gs865BQuOhXuFk8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=iEKJYr4n;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 5299320210;
	Tue, 04 Aug 2026 10:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785838756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ySyPelc7Z0vx8SSFi15BU5TocuNea9dhUMNWabrGkDw=;
	b=iEKJYr4nTO7wpAZbU+qU7v1SROFTs0F2vSUwiEoVSVH1cZoazg3CImVvuZm4zc9gppj/1o
	QJ/z3po3t/zGs+42foo5+fxZILY/wWToHXINLeHdQ3GmtSnshUS+iYW9yc+9CYK83HmjWt
	LYvZXfJE4VpHckEgxuxmltjrb2viL/8=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 04 Aug 2026 12:18:14 +0200
Subject: [PATCH batadv v2 3/6] batman-adv: tt: simplify NEW flag transition
 code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-tt-fixes-v2-3-487c48fc7fc4@narfation.org>
References: <20260804-tt-fixes-v2-0-487c48fc7fc4@narfation.org>
In-Reply-To: <20260804-tt-fixes-v2-0-487c48fc7fc4@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2662; i=sven@narfation.org;
 h=from:subject:message-id; bh=hGkYlfEMJKwYcVg2ekLUL+5O8TOQCG+hggRkrQOAtAo=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmFezLvLnK7cOqbqsLKtpUn1399MdXzeFHXXVOW3LSLP
 S0Wx9bXdZSyMIhxMciKKbLsuZJ/fjP7W/nP0z4ehZnDygQyhIGLUwAmsvQ1I8Oytm9Bz/w4D5np
 rnl5bIv9zcyn0zh+W979k+sXGb9de6kmI0OXWl+OxYbZtv7+L7g2znyY8873+ePeFsbDf3Yvn5U
 e78oBAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: XR33I2WO55UNRRKI6B5G56F2RSRW2SNH
X-Message-ID-Hash: XR33I2WO55UNRRKI6B5G56F2RSRW2SNH
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/XR33I2WO55UNRRKI6B5G56F2RSRW2SNH/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The function batadv_tt_local_set_flags() implements support for various
flags and to set/unset them. It is also possible to decide whether this
change should increase the TT size or not.

But in reality, this function is only used to transition tt local entries
from the NEW state and count these entries. Remove the rest of the code to
simplify the function.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 2a1d8963..5f0f7fb6 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -3868,15 +3868,11 @@ void batadv_tt_free(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_tt_local_set_flags() - set or unset the specified flags on the local
- *  table and possibly count them in the TT size
+ * batadv_tt_local_transition_new() - unset the NEW flag on the local
+ *  table and count them in the TT size
  * @bat_priv: the bat priv with all the mesh interface information
- * @flags: the flag to switch
- * @enable: whether to set or unset the flag
- * @count: whether to increase the TT size by the number of changed entries
  */
-static void batadv_tt_local_set_flags(struct batadv_priv *bat_priv, u16 flags,
-				      bool enable, bool count)
+static void batadv_tt_local_transition_new(struct batadv_priv *bat_priv)
 {
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
 	struct batadv_tt_common_entry *tt_common_entry;
@@ -3892,19 +3888,11 @@ static void batadv_tt_local_set_flags(struct batadv_priv *bat_priv, u16 flags,
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(tt_common_entry,
 					 head, hash_entry) {
-			if (enable) {
-				if ((tt_common_entry->flags & flags) == flags)
-					continue;
-				tt_common_entry->flags |= flags;
-			} else {
-				if (!(tt_common_entry->flags & flags))
-					continue;
-				tt_common_entry->flags &= ~flags;
-			}
-
-			if (!count)
+			if (!(tt_common_entry->flags & BATADV_TT_CLIENT_NEW))
 				continue;
 
+			tt_common_entry->flags &= ~BATADV_TT_CLIENT_NEW;
+
 			batadv_tt_local_size_inc(bat_priv,
 						 tt_common_entry->vid);
 		}
@@ -3977,7 +3965,7 @@ static void batadv_tt_local_commit_changes_nolock(struct batadv_priv *bat_priv)
 		return;
 	}
 
-	batadv_tt_local_set_flags(bat_priv, BATADV_TT_CLIENT_NEW, false, true);
+	batadv_tt_local_transition_new(bat_priv);
 
 	batadv_tt_local_purge_pending_clients(bat_priv);
 	batadv_tt_local_update_crc(bat_priv);

-- 
2.47.3

