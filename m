Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D19CA600C
	for <batman@archiver.kernel.org>; Thu,  8 Oct 2026 16:29:35 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A3303842AC
	for <batman@archiver.kernel.org>; Thu, 08 Oct 2026 18:29:33 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791476973;
 b=z1Dp1OEFaA5tgwoaXTtAHaNgf5bwQNO39ff8DPknKldxjhTelRlvQ8xq7r8S6DBB98WTG
 Z+1O4j26K5T7sJYAMRRr2DZLnYKZg0oIIXQKA6kA8NFcUAFDTIMoCQvkCt6Lq2n/jk8nATg
 T2A7ldaFjn8sc+3AVJ4v2gPY72GGDts=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791476973; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Ew6tJh4QVus/ztPZ7dWebQLyi/ldMYvb7n1Q00HSBn8=;
 b=xO+34wHkz1K1iwAPk0HaOZudCfAGRLxn4AggHA7h/d9ynvGXdOqUVC282ETGoHjgCpcW9
 Mk4iLu473Zijxy7J7UbCWBxvf05Z2DsQOaSodp74voTHdh6nKdZBi/DodkeS3BX5wwR+UAj
 SP5E+NvYEnLQtcK8uN4dh0FL7bU5MlM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id E65AC806D6
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 08 Oct 2026 18:29:24 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791476965;
	b=vHltCz790mhEMuq5McCpm3rewRSF4b8vLwwdJd+y1kiSNFbyypkFwMPFASHuy7p/yoIEHf
	ZdTCUWriSb9MiW10Tec7HKDebFUdL9CN8pp/tm17GED4AmoA11dt5lmusyltjC7kp6dCg+
	fVT8sdgLLMVg2WFWaAicgUfrdZ1G3sY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791476965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=Ew6tJh4QVus/ztPZ7dWebQLyi/ldMYvb7n1Q00HSBn8=;
	b=ukLJPGDmM416vGBFJV+4gQ+cydT08NB0jNE9dllPLygQ7tBAZPh6OnTLAKIq+CXscfD1jo
	EWgzXrp3QNNv0+cJgwTfotVwukdaBy6SL1wyibXy+tqrcnDo5udzoeXGVUCmv/zCRYKqZF
	2vPn2GLro461gxwPsrvrP3EzGMLP7H8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=s+qaGDFv;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 189C22038A;
	Thu, 08 Oct 2026 16:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791476964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ew6tJh4QVus/ztPZ7dWebQLyi/ldMYvb7n1Q00HSBn8=;
	b=s+qaGDFv9iL/5ceAE5TL5d/Ge9lAZvZQIBTK41N/I55zYn0JqNq6W9p6mp2XrO9eWf/4Eg
	O7PUQN7g8XlH6RdabFIBoEevJ8uvPPgb230CMRa3rksH85/xLhzZv6mzAp3LazV0JegJ3u
	LoOxn04ulKGD4m5XYy+xheGkp4tEw3Y=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 08 Oct 2026 18:29:16 +0200
Subject: [PATCH batadv] batman-adv: stop originator purge worker before
 freeing TT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-mesh_free-order-v1-1-a5edf68f1a96@narfation.org>
X-B4-Tracking: v=1; b=H4sIANvEx2oC/yWMXQqDMBAGryL73EAiWLRXKaXk54tuoVp2rRTEu
 zfq4wzMrKQQhtKtWkmwsPI0FnCXiuLgxx6GU2GqbX111rbmDR2eWQAzSYKYpo2dQxeczQ2V6iP
 I/DuOdwp+9mmhx+n1G16I876jbfsDzWs9JHsAAAA=
X-Change-ID: 20261008-mesh_free-order-58c91e9b10f5
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sashiko <sashiko-bot@kernel.org>, Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2054; i=sven@narfation.org;
 h=from:subject:message-id; bh=1H4lL1q1m0nYfNd8HvatAGthB663mI5mW4KIH8NEZ+k=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnHj9xf4T6rovL6xnMV8ZWivoezLlfmrRMz1IxSX5e4K
 zc5TNqzo5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjCRx0UM/7McJ26T2Lk+2qDn
 beBb7eeSQTcvJAmuEGYK8gn86J3pf46R4Tx/3Y5Piz7OXDAnou/7xOeR/PUad47d1pF0miX5c0K
 yLxsA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: F3JVYLUC4B4URH666CWWW42ECM777DUU
X-Message-ID-Hash: F3JVYLUC4B4URH666CWWW42ECM777DUU
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/F3JVYLUC4B4URH666CWWW42ECM777DUU/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_mesh_free() releases the translation tables via batadv_tt_free()
before batadv_originator_free() stops orig_work. The purge worker can
therefore still run while the TT is torn down. When an originator times
out, batadv_purge_orig_ref() calls batadv_tt_global_del_orig(), which
loads tt.global_hash and walks all buckets while taking their locks:

  CPU0                          CPU1
  batadv_tt_free()              batadv_purge_orig()
                                  batadv_tt_global_del_orig()
                                    hash = ...tt.global_hash;
    batadv_tt_global_table_free()
      batadv_hash_destroy(hash);
                                    spin_lock_bh(&hash->list_locks[i]);

Disable orig_work at the beginning of batadv_mesh_free(), directly after
the mesh was marked as deactivating. The second
disable_delayed_work_sync() in batadv_originator_free() is harmless because
it is free'd anyway.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260708091821.314516-1-sw%40simonwunderlich.de?part=3
Fixes: 21fa2647ad45 ("batman-adv: fix potential TT client + orig-node memory leak")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 6c54a8d4..eb9c6bdd 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -295,6 +295,11 @@ void batadv_mesh_free(struct net_device *mesh_iface)
 
 	WRITE_ONCE(bat_priv->mesh_state, BATADV_MESH_DEACTIVATING);
 
+	/* the originator purge worker accesses (among others) the TT tables
+	 * and must therefore be stopped before any of them are freed
+	 */
+	disable_delayed_work_sync(&bat_priv->orig_work);
+
 	batadv_purge_outstanding_packets(bat_priv, NULL);
 	batadv_tp_stop_all(bat_priv);
 

---
base-commit: 0eaac0f4187bc9b69b41d90998fd7b93ab07e53e
change-id: 20261008-mesh_free-order-58c91e9b10f5

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

