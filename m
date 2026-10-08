Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA39CA600D
	for <batman@archiver.kernel.org>; Thu,  8 Oct 2026 15:54:50 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C3F42844B2
	for <batman@archiver.kernel.org>; Thu, 08 Oct 2026 17:54:48 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791474888;
 b=eag2QJ877Ro6lSlBb6aFhSzMp2igOMi60QtPW3B4Y2HHwlPf2t9y4RYAPj6V7NloRPKo1
 E5pejeVFSNja6L0shafxfZL4DPmOc7Eba73SywZvbJl3ug4ahR4xqXZikZzHiu2ihnVHT+7
 BEJVZq/wBrQ2kLPb7JvU9n8rcWuGATM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791474888; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ipQrWmftf5RXVu9HtVMPnGMDYgG7uKftHQn9Y5Mryec=;
 b=B88bCkON3CZInoNkItVQ4JPTE6jmlwv1N56yXeKi6g2LE49AchA0Y7ZKhw1GtAWyzTwKo
 OiR2Sozwm/58n9IdSzmsCcQXUJNjbwDsfUfytIxvhNCsx0LkKXtHle+qORAZnkZ8tMi3oWK
 lKZjcdUk8D/oIR1OWJCIUo2Jlu4ei04=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 8586B842B3
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 08 Oct 2026 17:53:13 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791474793;
	b=H15XOad+EOE3ttfZSReCM+01BpLg2kd4CIvdFLXsIL1jcyN/1JNjprpvODIEFG7gXXWibY
	FUFrgEHGQ1EdE0Y3lPo4XXAJ8j6p/9wRk99IlAu61d2+6kqFNi7491CQ81W47IiadD+Sjr
	vfqi0Tx1KYlerrKhLi+l6yNGrM0j0hI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791474793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=ipQrWmftf5RXVu9HtVMPnGMDYgG7uKftHQn9Y5Mryec=;
	b=LWz8o56gBY9q9no3OIiaG4BAD1P32Z5ZaqC+HOV8HMi4MgA1k3nP4B9HkKWCiu91+lI+16
	EVvCTWOaVY6Wn4cvOIAL7vBm2H1CiNAzb39TUhxtq32+PueiUaoi8wfISRkfhQNOtiU/R8
	FQDa5CWgPtSc+toR8ZS99iTIZLE06EI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=0VNvMYTD;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 124E7204B3;
	Thu, 08 Oct 2026 15:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791474793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ipQrWmftf5RXVu9HtVMPnGMDYgG7uKftHQn9Y5Mryec=;
	b=0VNvMYTDmfraipJ3ttLRigC1NYpK4p6h7/cGVyu/9hZL5VdOtXyaASnJ2Ng7JGfFqO13f0
	jf0jkogcKDI1MO2X1DQUtzBIV3v0MiTmZCNbNV0SDr3hxXdBscff2bem0KLDtnhaLzQG3R
	meeKmkN6o/dIMcLfkWj4/lHGcHn5gs4=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 08 Oct 2026 17:53:01 +0200
Subject: [PATCH batadv v2 3/4] batman-adv: bla: increase hash generation
 when purging entries
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-tt-hash-generatopn-v2-3-72b61e956a81@narfation.org>
References: <20261008-tt-hash-generatopn-v2-0-72b61e956a81@narfation.org>
In-Reply-To: <20261008-tt-hash-generatopn-v2-0-72b61e956a81@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1655; i=sven@narfation.org;
 h=from:subject:message-id; bh=DIHn1dBM4drk0PD9O4kteiUS1fmY8Fc2masbV0L0q8Q=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnH98QvW8/kHtekP5PX8IFKdf5lo1XlAVO/1jQ0e8/1z
 L9+O5uno5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjCRQFtGhs2caTytNVXXop9f
 P2MiVjAxZd6rhVkrvq6ddazshYQWTysjw7XXrpY+D8qjbP/ZF5TPtTtwaGIl07zZay6YWM341rt
 7BjcA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 2CBLDM62RO5RNVUU6G474UQWSJ5VU6EW
X-Message-ID-Hash: 2CBLDM62RO5RNVUU6G474UQWSJ5VU6EW
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/2CBLDM62RO5RNVUU6G474UQWSJ5VU6EW/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

If batadv_bla_claim_dump() or batadv_bla_backbone_dump() is preempted
during a netlink dump and resumes in the middle of a hash bucket while
batadv_bla_del_backbone_claims() or batadv_bla_purge_backbone_gw()
concurrently removes an entry, the dump offset will be shifted.

Without incrementing the hash generation counter, netlink won't set
NLM_F_DUMP_INTR and the userspace will not be informed about the
inconsistent dump.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-83da443f-ce69-4393-a29f-e02b70d1ec96
Fixes: 529bce0db7d7 ("batman-adv: Add inconsistent claim netlink dump detection")
Fixes: f6afc85e049b ("batman-adv: Add inconsistent backbone netlink dump detection")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bridge_loop_avoidance.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index a96f269d..4df90e40 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -321,6 +321,7 @@ batadv_bla_del_backbone_claims(struct batadv_bla_backbone_gw *backbone_gw)
 				continue;
 
 			hlist_del_rcu(&claim->hash_entry);
+			atomic_inc(&hash->generation);
 			batadv_claim_put(claim);
 		}
 		spin_unlock_bh(list_lock);
@@ -1285,6 +1286,7 @@ static void batadv_bla_purge_backbone_gw(struct batadv_priv *bat_priv, int now)
 				batadv_bla_del_backbone_claims(backbone_gw);
 
 				hlist_del_rcu(&backbone_gw->hash_entry);
+				atomic_inc(&hash->generation);
 				break;
 			}
 			spin_unlock_bh(list_lock);

-- 
2.47.3

