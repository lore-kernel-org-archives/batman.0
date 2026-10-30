Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C450606A31A
	for <batman@archiver.kernel.org>; Fri, 30 Oct 2026 13:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=ySC56UOh
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0599D84230
	for <batman@archiver.kernel.org>; Fri, 30 Oct 2026 14:55:45 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793368545;
 b=IB9vup85FDC2P3KRH2B1/E/n3XqK06iyvfIVBHUenVKasjV58+NRLfpLG/UMw3KVdw/8H
 iW2lF1Iv6aZ3xLYh8PtvAWeB0sLkI2uFJ0jpuGWmMwIddr21K1IeGQ9k5HW2/qR4Izv0g1E
 NcG+71ZjfhHO8OLHyc5LorG7dGjDnrY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793368545; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Tb6YY7ws5ricakk5fR+nEefJhgviyi0JtUHb63cvMS4=;
 b=uH5CHOOrwfeAbygdleVfM9hRVt0rhschgpZZyDf6KQJvP90oyS3sqV0PTnVjww8DRQC9i
 MBOWNynHCjzt/Rp0l6kvX4gZyHflaK4Ijs2pNyQg7BADEUhU30zAJpojeDB7qj1i6hh7hv8
 +ETnklWUl1RlOdkW687mO16RUMCjfHY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id DBCC784421
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 30 Oct 2026 14:51:21 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793368291;
	b=UMa2FPqW4UYo6gN2i5hD0b+NXij+hEOtkNB735nUVmuRnK0RqIuezU3TdUQVKZNiwx62lC
	x5q3hQjbOdDCNONqgqkukkPE56A6kYf77XTJXIXeoaQYP4IYRvAPa0Gm6h7EKmy46Sq8e3
	UMAoxEbdYdU4v+tdSKRI2t5u6Kn/9RI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793368291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Tb6YY7ws5ricakk5fR+nEefJhgviyi0JtUHb63cvMS4=;
	b=HKMvftH4ksf/Y0g2y4YiUVgiyTrLgypM7kddbZjdJ71jE1FDjtjxFzzFwF3Nn/CsiFI9NI
	/J2Z5GoOkLxiMjnEkAjgl7SF9k4MZV7zo+pbLE5sb8SEYm1gMOkMNMockrYESM2n3xN8PE
	NBG/EC2dpMmyzuTWYQifP8FQV0KPb9s=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=ySC56UOh;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300C597124fd839580c360d3ed6f6.dip0.t-ipconnect.de
 [IPv6:2003:c5:9712:4fd8:3958:c36:d3e:d6f6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 33787FA1CC;
	Fri, 30 Oct 2026 14:51:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1793368275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tb6YY7ws5ricakk5fR+nEefJhgviyi0JtUHb63cvMS4=;
	b=ySC56UOhdXeYD5ZTai0+o7Hqc1KreHftBHMGenfMfKrr5qZFZ1s1HcAdvUZS5x7BhsYJ6F
	1TYZuDKNg7/in6jWbZBly3cY9N/k5zUrWFTAjLQN6v9k2Z4he3/yG2GcIsdHn5M3hHjAs1
	S+K3fEXz0JxfiiWt4Ll73xGkJ2U8PHadvPU/Oyv9yVGUzVyu2vz8CkpTJ64mkRfCjVRdWO
	0KlpGEFlPEcMEegdohPyHjlKctnNrDEQi0fCKdPOr8SPDoec9XJmmWTbNnqVmtMluyjZT3
	wCq/GmydpGiGXzsQPzdnYdaZo6Wqpy8OcF7UI7hWkpvR2d/kc3qyFwzx84WVIQ==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 07/14] batman-adv: stop originator purge worker before
 freeing TT
Date: Fri, 30 Oct 2026 14:50:58 +0100
Message-ID: <20261030135105.2555887-8-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261030135105.2555887-1-sw@simonwunderlich.de>
References: <20261030135105.2555887-1-sw@simonwunderlich.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 5X5UPH5NGGFVCHLP6AC4PK3PXOGLJQB7
X-Message-ID-Hash: 5X5UPH5NGGFVCHLP6AC4PK3PXOGLJQB7
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/5X5UPH5NGGFVCHLP6AC4PK3PXOGLJQB7/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Sven Eckelmann <sven@narfation.org>

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

Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260708091821.314516-1-sw%40simonwunderlich.de?part=3
Fixes: 9d31b3ce8168 ("batman-adv: fix potential TT client + orig-node memory leak")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index ced76942f33c5..3b9fa861be7be 100644
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
 
-- 
2.47.3

