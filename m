Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC3BCCD5BD5
	for <batman-adv@archiver.kernel.org>; Tue, 26 May 2026 07:01:04 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3878682FED
	for <batman-adv@archiver.kernel.org>; Tue, 26 May 2026 09:01:03 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1779778863;
 b=gLTlgnguvekEm5w4yPGgVedLfbmtRHus+4bfvik0fQC/XwyRFoJYGxVCg6JKcymknJ+sr
 TYhUB3kpE3o4Yv+H/DmOtOKKEfF4BiDymOxGsIOTX7WasqR+XffzCFIKPD4QOw2U6X6fDrX
 yht0lt6rEJJxmaaRRCsdx3syFkNCkUk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1779778863; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=O/iQlSdODyUFcZUiDfoqt+9/8YQPirYzjTroKpMrHK0=;
 b=yWdXn8h316nDHTFQGEFhpueDnd0dpmwvF67UQlSivTVVezi7QFrU6/SHC+H4K+PTeSS3N
 6GSwtclu1Uc6gOVU+MSbgF4HoM35b50I9zIKT+2TTfLJorq1v0G5KZbeChI6BrWsfE2pU0N
 pKnkSgDNo8IqKxI29V3wQRyRfq+v1Hc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=snu.ac.kr;
 arc=pass;
 dmarc=pass header.from=snu.ac.kr policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=snu.ac.kr; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=snu.ac.kr policy.dmarc=none
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 055D380F29
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 26 May 2026 08:48:47 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1779778140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=O/iQlSdODyUFcZUiDfoqt+9/8YQPirYzjTroKpMrHK0=;
	b=O6bPVRbVjcFUBnyt14grEJ0P4wCrRKW1YhO4AU8S47zXV5VbnBzSDyuhSBghTRB1mEAYvh
	bsH7hsyXXRqnp85QpquPBjIj0wn0BfEfF7Wnhaq+w2OcaSinCqlOjoefg9FVY5ogPE6j9d
	3zYl5IC8JZbvQWsVcg2FIUT2LBmf1Wk=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1779778140;
	b=cSXxHYmAzjwpk8/4LhUGZntEZxdSmJf9KQgcmZEN721Alp8b733dMvV2OUX/IFrfqZ4lZn
	M9zUxjpq4fqBi0Mkikb/itYtIgZquAy+YDyDFAKe5DBffkDpzslDAY5WULZKOBegW++V/H
	vRr9YtiZfaRdeE7XXnDS95rDCLS5iYE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=snu.ac.kr header.s=google header.b=bhCQFxin;
	spf=pass (diktynna.open-mesh.org: domain of swan2718@snu.ac.kr designates
 2607:f8b0:4864:20::42a as permitted sender) smtp.mailfrom=swan2718@snu.ac.kr;
	dmarc=pass (policy=none) header.from=snu.ac.kr
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-82faf871346so7807281b3a.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Mon, 25 May 2026 23:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1779778125; x=1780382925;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O/iQlSdODyUFcZUiDfoqt+9/8YQPirYzjTroKpMrHK0=;
        b=bhCQFxinXZ7opoZDuPXm3dKIN4D5OOoOK7xU/1hDEt/a2KHKeumcHPP5kW2K/g4qZE
         pekZeqPXbeq2LFiBFUVqaVrwG7DD+ciBIxS1pHIUHqnnqQ0iilk3D97FByrWFTQzaa+V
         4GUFhE05rpisxlgtXcciZH+5K1Bmr6VxtQfS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779778125; x=1780382925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O/iQlSdODyUFcZUiDfoqt+9/8YQPirYzjTroKpMrHK0=;
        b=d7VPQqWjVRW6xB0MsCwWaXJilSTEl5XnHXPibn3YGlv9gtclVug2+VYZYKGXhTr5uH
         X5+ZZxoNBew2zLshhjR4x3gXNKQP8OvC61E5ViN/kazZPvFMot9cesb6n+wHtCfqrx2V
         oYwjyEXnMy24v++a86H89Jy8qB9Pg5xpYsBPLjUBIcLcYHN/BcsmN8eYOVxVxOWvRQcr
         4Kkt/T4YciXpR0956VyJkRJMAJ2SPEHFZ9oJZgPgyYoQ8ZVfnqRIPAznDa0Yp/EpyJMS
         wSMWb50ntREb6nN7PFKVZzky3UP8SYvr71Chx+tVlodrYBnGrFGkIVGVXLvNq+PyWjKM
         tbSw==
X-Gm-Message-State: AOJu0Yy0jsx5Z9kmorvktUKCvHDAsD4Cx09QOG1EPeHqU1JhjfwVTc3W
	26vkcUXH8qS+ODarsQH2ptJt8EzP2OWKvhJiypmCJ75VyiNAhGkitAvipvZeCHuOw84djfbilyN
	e+/EU5x/x5HzH
X-Gm-Gg: Acq92OEQ20I1kelOHfnrKSxuKrB6+xlLn+wnNnGqbX5ENSE3w6WpeWonXc7Lr7sDsWz
	awHSVq9h6IXI8M55QiYlgWg4SeyqoIcPsMVp4nzEl9VNx87kGXYdETgnlHhiwfQY2FpH+VjG1/s
	AeXcRXIse5RNY8/gAn+l7oTYqaioNmv+KLpObGFiZD8HeJVoVl8nVVHAvJT3cTmaCJPftagYqIA
	be7fBI4Rtp7tQlJrBcCuKvGK4jV8YVZuzJSHGJEWPwuDfXcrQ5/D5iunrfS23fp7jWZbl1xCdv1
	d87iPJFq+6u9Kje+oqc1nuq680gaT6K9n4dUwYoqlocsmx8dZCNVWiop2LgkR8pclwdo2oarXZU
	tVdn1jpJqod98Q5dwqtfu2R/8ai+UvGxPAFPcJTrx5CHsTvsXwtA6b88IE8nZDPjDkTtgNtSeo6
	D76afx058ROUqrPuY5zDjl3oXNcVjVcXJoAqA6ZZy/lXumh872vA==
X-Received: by 2002:a05:6a00:2da4:b0:82a:6ef8:cb43 with SMTP id
 d2e1a72fcca58-8415f53dbe4mr15892684b3a.19.1779778125518;
        Mon, 25 May 2026 23:48:45 -0700 (PDT)
Received: from ubuntu.. ([147.46.174.166])
        by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84164e9e7cdsm11909392b3a.34.2026.05.25.23.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 23:48:44 -0700 (PDT)
From: Soowan Park <swan2718@snu.ac.kr>
To: b.a.t.m.a.n@lists.open-mesh.org,
	netdev@vger.kernel.org
Cc: marek.lindner@mailbox.org,
	sw@simonwunderlich.de,
	antonio@mandelbit.com,
	sven@narfation.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Soowan Park <swan2718@snu.ac.kr>
Subject: [PATCH] batman-adv: fix DAT purge use-after-free on teardown
Date: Tue, 26 May 2026 15:48:35 +0900
Message-ID: <20260526064835.2233822-1-swan2718@snu.ac.kr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: swan2718@snu.ac.kr
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: XWZWXES4YTMFBWYQNIX4M4A6CUEL56ID
X-Message-ID-Hash: XWZWXES4YTMFBWYQNIX4M4A6CUEL56ID
X-Mailman-Approved-At: Tue, 26 May 2026 09:00:32 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/XWZWXES4YTMFBWYQNIX4M4A6CUEL56ID/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_dat_purge() is a periodic delayed work that re-queues itself via
batadv_dat_start_timer() at the end of each run. When the mesh interface
is torn down, batadv_dat_free() calls cancel_delayed_work_sync() to stop
the purge work before freeing the DAT hash table.

However, cancel_delayed_work_sync() leaves the work in an enabled state.
If the purge work is currently executing and re-queues itself before
cancel_delayed_work_sync() internally marks it for cancellation, the
newly queued work escapes cancellation. This re-queued work then fires
after batadv_dat_hash_free() has already freed the hash table but before
the pointer is set to NULL, causing __batadv_dat_purge() to operate on a
dangling pointer that passes the NULL check, and spin indefinitely on a
spinlock in freed memory.

Replace cancel_delayed_work_sync() with disable_delayed_work_sync(),
which additionally disables the work so that any concurrent
queue_delayed_work() call from the running batadv_dat_purge() is
silently rejected. This guarantees no re-queued work can fire after
disable_delayed_work_sync() returns.

Found by syzkaller.

Fixes: 2f1dfbe18507 ("batman-adv: Distributed ARP Table - implement local storage")
Signed-off-by: Soowan Park <swan2718@snu.ac.kr>
---
 net/batman-adv/distributed-arp-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 0a8bd95e2f99..9dce7da4282c 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -837,7 +837,7 @@ void batadv_dat_free(struct batadv_priv *bat_priv)
 	batadv_tvlv_container_unregister(bat_priv, BATADV_TVLV_DAT, 1);
 	batadv_tvlv_handler_unregister(bat_priv, BATADV_TVLV_DAT, 1);
 
-	cancel_delayed_work_sync(&bat_priv->dat.work);
+	disable_delayed_work_sync(&bat_priv->dat.work);
 
 	batadv_dat_hash_free(bat_priv);
 }
-- 
2.43.0

