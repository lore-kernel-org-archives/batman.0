Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2804C61DD3
	for <batman-adv@archiver.kernel.org>; Tue,  1 Sep 2026 18:10:35 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0F4E48213A
	for <batman-adv@archiver.kernel.org>; Tue, 01 Sep 2026 20:10:34 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788286234;
 b=nkfkFkjqhoWITsSFQu6cMwqLx2ecnv4SKMDjSQKXD38eqrGHA69QiyGb/fmJNRIW8coxx
 868I+TbezKDu7HR7aVPVGHKQrfmBUqSws751qOEYqjdNMcB83Xymn2UgDopL+p8Vzae2APO
 sqtfZWcg/Zr/NXUpyUpnkXDf83/c+Ho=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788286234; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=tzcRPgmBLSyO1VOafvDjFoShA5wpSL8qnC75aGL3IGw=;
 b=uSPTppI1KQ7ieuE5Bt1rzY4HtyzlBxFLFzesFqWiG7AQpZ2JugnQKoNK+Ewvb0WkRgjrU
 hsrwDifZvlaiG/K/Kfw0m6JsqHYbEEhxzRfu1wshd0ZtrPZr6Emuk2V0guQt1Zt4IJsjk/q
 dchS2+pj1q1K+lB8sQ/xH/aGGCREDHg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id D933981028
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 01 Sep 2026 20:10:14 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788286224;
	b=1PXrZKWEgAYkA6BzideSuxD0bgnwr56nz6UPPhRM2Ho2R06fxkdnfTxixc6chkLax1lkEe
	HWwAVdKHbl7MhRin6HreU6k97LS1GD0lCB6iuJi2LjCHzqhQo+W1mHjPFsKDR4u6k6yWF7
	u8IfWYPuU48d8iLQv713/5PLLCgpgc0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788286224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=tzcRPgmBLSyO1VOafvDjFoShA5wpSL8qnC75aGL3IGw=;
	b=2kfoGI0GLxj044L+Bptnv4hkhCJoueclHXk86grrcBUpCqYKd2PZnsMU/c7KDUc42D56/B
	xRQ/06OtOVQFAi12CfIjkOZIuK9WwycDBxUVjXE0+VZduljkppl1DEXXMGUUkkO+y0lqqE
	dTj4n2WxVhTLPGY8U+GLTf4XS0W5bXo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=s3Z+zaVD;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 0C9BB1FE7E;
	Tue, 01 Sep 2026 18:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788286210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tzcRPgmBLSyO1VOafvDjFoShA5wpSL8qnC75aGL3IGw=;
	b=s3Z+zaVDUvD0w/RlTOs2U2IscyV3YiZ8yKgAYU5me/nt4mD7TCdT3cLCfWVeB7/j4Zr3Ku
	hVO2l69SmCPK+HjKGFPF5wnm29GoRH8d61+MYJKNOfGjrlX56t0/+zue8H0njhpHxEMKQL
	55nDAwd3A0p1Z/LhvJCV420PwyCDzVU=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 01 Sep 2026 20:10:06 +0200
Subject: [PATCH batadv] batman-adv: tt: only queue local del event after
 successful unlink
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-tt-del-event-queue-late-v1-1-fc28ca54c342@narfation.org>
X-B4-Tracking: v=1; b=H4sIAP0Ul2oC/yWMwQrCMBAFf6Xs2YU0BbH+inhIk1ddKVGTTSiU/
 rtRjzMws1FGEmQ6dxslVMnyjA36Q0f+7uINLKExWWOPZjQ9q3LAwqiIyu+CAl6cgn2Yx8EPJws
 XqNWvhFnW3/lCk1MXKl3/PpfpAa/fLe37By5VxT6DAAAA
X-Change-ID: 20260901-tt-del-event-queue-late-cdf93c382ead
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sashiko <sashiko-bot@kernel.org>, Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1777; i=sven@narfation.org;
 h=from:subject:message-id; bh=lMxpQ15h2XKZIJGIPwaudHnJohFiW4PinmBIH8pvyTo=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnTRf7bPdJbbL3DJ9WxV8jF8Pmf2gmy2m6da7qELhhYx
 PzvfJjYUcrCIMbFICumyLLnSv75zexv5T9P+3gUZg4rE8gQBi5OAZiI9V1Ghi1fv9RNyFa6G33m
 aeQJLykuxmnG/u4i2yTjUjnqb9hZz2L477KQzaL7cMeMGSyKRXVnJ+/n/Ov3aHuFYYLa5fc7OmT
 M+QE=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: TN4WBSNFJJCAFHGYV6TTXMBXBWCVLXE2
X-Message-ID-Hash: TN4WBSNFJJCAFHGYV6TTXMBXBWCVLXE2
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/TN4WBSNFJJCAFHGYV6TTXMBXBWCVLXE2/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When batadv_tt_local_remove_now() finds another local TT entry with the
same MAC + VLAN, it will not try to remove it. A delete event must not be
queued because it would otherwise cause the queued ADD event for the other
TT entry to be dropped.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831135117.574836-1-sw%40simonwunderlich.de?part=8
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 1fcbe417..da17c2a8 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1544,8 +1544,6 @@ batadv_tt_local_remove_now(struct batadv_priv *bat_priv,
 	struct batadv_tt_common_entry *common = &tt_local_entry->common;
 	struct hlist_node *tt_removed_node;
 
-	batadv_tt_local_event(bat_priv, tt_local_entry, BATADV_TT_CLIENT_DEL);
-
 	/* remove exactly this object when still present in hash */
 	tt_removed_node = batadv_hash_remove(bat_priv->tt.local_hash,
 					     batadv_compare_tt_entry,
@@ -1553,6 +1551,8 @@ batadv_tt_local_remove_now(struct batadv_priv *bat_priv,
 	if (!tt_removed_node)
 		return;
 
+	batadv_tt_local_event(bat_priv, tt_local_entry, BATADV_TT_CLIENT_DEL);
+
 	/* batadv_tt_local_transition_new() may have committed the entry and
 	 * thus counted it in the local table size since the
 	 * BATADV_TT_CLIENT_NEW check in batadv_tt_local_mark_removed().

---
base-commit: bd881c94108e3fb3f3d9ef7186d74e51afe1e5a6
change-id: 20260901-tt-del-event-queue-late-cdf93c382ead

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

