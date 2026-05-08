Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 703ADCD3436
	for <batman-adv@archiver.kernel.org>; Fri,  8 May 2026 15:48:16 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 02E7385C5E
	for <batman-adv@archiver.kernel.org>; Fri, 08 May 2026 17:48:15 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778255295;
 b=dM0AEqbRNz895v5RN8TIKobGnfBC/htjCJkdN8DoEJQ7OW0Eye/QmO6gFz3zpL+t6Bj88
 IJeUQHF0wrmmaEZ6Ea/ucy+k+GfkgHgD2k9hlwS/2Q9aszhMs/08eQjfh8dqYkb5V2NuCUd
 3LVOwLrhbHRoHNcPu68hFlTAyauumEI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778255295; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=rKkYdkKDVA6gC80Vrr+hLi2juPjpTi5IVGhvcsqIlUU=;
 b=CTDPHsComKjulzfljXpPiz7qiTawStMpwWye9WVV8nXOrfJ5Y1X71jD4aWE4PlHwqGjMQ
 U7djnjeeDu3DFw6GFexkiv2/gSUJsETmRLtxcysi4jjKYKBuO07vCsDhr1RNH0TgkldvR+H
 fS18LGles2aTXs4MdupHdYdwB4zxKIU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id A34D085AA6
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 08 May 2026 17:43:34 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778255014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=rKkYdkKDVA6gC80Vrr+hLi2juPjpTi5IVGhvcsqIlUU=;
	b=zSdaeXKVA+PgwfaB46nHX+8pOrX7rto1uzar0EA8qwyrybpnI6HejUs6xaoLMXnSc+C4pZ
	lODFDc24APwHlmhdtERx5kRgOmSLrXR9QP38okX+FScB1nNEQVbKEK6ySij/N+C7yGoz0Y
	fC6f8NHL8xTIr/Uj5LyukhBx4lHvcHk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b="v/+GCSlx";
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778255014;
	b=0k8VOzZOHBtkSyeKD6fIJhEeciucASbBAjtya/bMbAaWeVwUe4dB3ug+52eyxqjWHTBmYV
	DCb6TvrCHlT5LfSnR5lvvXhhObjrT4R4TmZBtzsfNaO3Q0z4NMYki9I5t4tdQaSc2sh443
	31VQEo01VF+K2A/6KHXAluC2WeYR8UA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1778255013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rKkYdkKDVA6gC80Vrr+hLi2juPjpTi5IVGhvcsqIlUU=;
	b=v/+GCSlxpizvDw965L+ZXXx+0bNpP5FzqyVAiNCADni4gXVh0xStkeJrCChaRphD2jIxPS
	fUiRhAaIDeOhSn8XqfULs5ENFRYxPMr1XMpzJv2XlFJYTjgD0660SXTvQn4SWV7J9C0lSk
	PcQpTz9hzRmeoiyUv4Kp6F4bg3k2Er//Ow59Cyd+2Svhb0LjtfEAwL8JTpUnYcVCQbYxTI
	RewF1G6z1ww5+L0v5YeZFHN+bioQBBje1O9Evo/NGKrDfXFdSAGvqrufpe77yGdf+I1VI+
	/ozebiq7NTjWSDsZnT2+vAj3ywb5+M+ryTjnrghoxyeWuaVBTUjPJFHklKWgpw==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 7/8] batman-adv: bla: only purge non-released claims
Date: Fri,  8 May 2026 17:43:13 +0200
Message-ID: <20260508154314.12817-8-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260508154314.12817-1-sw@simonwunderlich.de>
References: <20260508154314.12817-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 77M6CG4BEYESQHC4CM7SNRVDQGKJ4ZM2
X-Message-ID-Hash: 77M6CG4BEYESQHC4CM7SNRVDQGKJ4ZM2
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/77M6CG4BEYESQHC4CM7SNRVDQGKJ4ZM2/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

When batadv_bla_purge_claims() goes through the list of claims, it is only
traversing the hash list with an rcu_read_lock(). Due to a potential
parallel batadv_claim_put(), it can happen that it encounters a claim which
was actually in the process of being released+freed by
batadv_claim_release(). In this case, backbone_gw is set to NULL before the
delayed RCU kfree is started. Calling batadv_bla_claim_get_backbone_gw() is
then no longer allowed because it would cause a NULL-ptr derefence.

To avoid this, only claims with a valid reference counter must be purged.
All others are already taken care of.

Cc: stable@kernel.org
Fixes: 23721387c409 ("batman-adv: add basic bridge loop avoidance code")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bridge_loop_avoidance.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 8b77dd2ecfa41..879ab043d57a9 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -1288,6 +1288,13 @@ static void batadv_bla_purge_claims(struct batadv_priv *bat_priv,
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(claim, head, hash_entry) {
+			/* only purge claims not currently in the process of being released.
+			 * Such claims could otherwise have a NULL-ptr backbone_gw set because
+			 * they already went through batadv_claim_release()
+			 */
+			if (!kref_get_unless_zero(&claim->refcount))
+				continue;
+
 			backbone_gw = batadv_bla_claim_get_backbone_gw(claim);
 			if (now)
 				goto purge_now;
@@ -1313,6 +1320,7 @@ static void batadv_bla_purge_claims(struct batadv_priv *bat_priv,
 					      claim->addr, claim->vid);
 skip:
 			batadv_backbone_gw_put(backbone_gw);
+			batadv_claim_put(claim);
 		}
 		rcu_read_unlock();
 	}
-- 
2.47.3

