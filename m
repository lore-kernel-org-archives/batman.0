Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A43FC43458
	for <batman-adv@archiver.kernel.org>; Sun,  5 Jul 2026 18:42:08 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E1B3283FE1
	for <batman-adv@archiver.kernel.org>; Sun, 05 Jul 2026 20:42:06 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783276926;
 b=TRvD183SFz7pM9w5zTCsCyNWWeYjWfzkb8aPDKet4v8GUuQZvpa93NvLBMFR2W8bZfoFG
 Lypr9IPgQYDbZWuyI90uBT/m/p09qjSxXMdfYRaYAB4rCwofpIGxkWbG9HxORJdSgwcWcQ7
 rAbKtJO9R2F1z9orwb11LLizN0WoYD4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783276926; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=uW6niyKd3zYXPxWCgV5RL+iFZwPERvAL7psWWCRV9W8=;
 b=KnPGyt/cJRGNN+QVZafNsb5ubEBoxWSFXx2pgOuPdsUCTHzjGlAdKq/OTUDMRxBy57j+1
 JHSCl3gv4VQ7xrSeRhNg0GNPPsyyS4MM7+Zncwz6ShSNdxvpZLfUtLA9xwLY6zlvXMYZS7J
 cUNi+LoUQ9nYFEYhGgsi1VRF/J56nQg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 41114809EE
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 05 Jul 2026 20:41:37 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783276907;
	b=sRpBAKx8MwLI7PtoKQNF1AcnVWSa4FMURJ/PARvO6gxCyvRExvPFhrQQqt7juo4V0InNDQ
	QYcbdKzN7S69L9bUiE2wt00GnXMsZLbIYlCqPTnI7gRRxbhq23TO7C0CPmI26SQJAtNCSH
	/t0JskTa1wORvOoHQ/gH8LsclLvPWsE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783276907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=uW6niyKd3zYXPxWCgV5RL+iFZwPERvAL7psWWCRV9W8=;
	b=MXDHKUwPgZs38cjUc6hpvb42Eutvleu/IPVDFtnyHVx22TcrGo83DHuiYKVnoAiHO9jsa2
	3I39D1w9mPHT6EIK1C4cOvbkYL3ea3EzXBENXqsOY+mMLkgbN2vxez5xWyRtk8v45F51Kr
	2IfgI8dVs9T6nU1iJx2em1149sGDiiU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=qPLqLQeU;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id DAD061FEF7;
	Sun, 05 Jul 2026 18:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783276895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uW6niyKd3zYXPxWCgV5RL+iFZwPERvAL7psWWCRV9W8=;
	b=qPLqLQeUUWtavqf7QW54TaPm8kWBU5sCk6q/VPNJN8MTd7l+ucQBAze2c25l3mVXRvVK2n
	16+HX3LiuWduXFjfK81cApgwSqqtLnuQRL9lKtfACFZKsDW1cvqCYjxOjAPzQXk800593T
	F3BfATkbMLFhLE6mGAoOQmjWSKUG8v8=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 05 Jul 2026 20:41:20 +0200
Subject: [PATCH batadv] batman-adv: dat: fix tie-break for candidate
 selection
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-dat-tie-break-v1-1-5d06df5cd9e7@narfation.org>
X-B4-Tracking: v=1; b=H4sIAE+lSmoC/yWMwQrCMBAFf6W8swvbgpX4K+Jhk111FaoksQil/
 26qxxmYWVAsuxUcuwXZZi/+nBr0uw7pJtPVyLUxBh5GPvCeVCpVN4rZ5EEWOIReNAVltOaV7eK
 f3++EKFV0xvnvyzveLdVthnX9Au288Ul5AAAA
X-Change-ID: 20260705-dat-tie-break-e90991adc9d0
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1656; i=sven@narfation.org;
 h=from:subject:message-id; bh=zmJGhaqnSGv08WQHKOEodAYvaVWBtJntC2qyWeKmjn8=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFleS0PiLf7JZ6b0pyrf3PF+yp7Tnb9mm7louzrFae633
 vt2UfTbjlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBE/kxkZFj5NuEY86ep92YF
 8afM2/U1PNDiwq2Vkk2/pd6fSNolwLCe4X/s2hAPuxkpjOnvuLa123/48XnDBAeHpW/n7vKq/3/
 Ot5EZAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: DM3UIITU3TGT265X4UKJPYMLHPQV252L
X-Message-ID-Hash: DM3UIITU3TGT265X4UKJPYMLHPQV252L
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/DM3UIITU3TGT265X4UKJPYMLHPQV252L/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The original version of the candidate selection for DAT attempted to
compare both candidate and max_orig_node to identify which has the smaller
MAC address. This comparison is required as tie-break when a hash collision
happened.

But the used function returned 0 when the function was not equal and a
non-zero value when it was equal. As result, the actually selected
node was dependent on the order of entries in the orig_hash and not
actually on the mac addresses. The last originator in the hash collision
would always win.

To have a proper ordering, it must diff the actual MAC address bytes and
reject the candidate when the diff is not smaller than 0.

Fixes: 34b3c3850e7d ("batman-adv: Distributed ARP Table - create DHT helper functions")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/distributed-arp-table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index a5c9b6d0..30cb1e93 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -615,7 +615,7 @@ static bool batadv_is_orig_node_eligible(struct batadv_dat_candidate *res,
 	 * the one with the lowest address
 	 */
 	if (tmp_max == max && max_orig_node &&
-	    batadv_compare_eth(candidate->orig, max_orig_node->orig))
+	    memcmp(candidate->orig, max_orig_node->orig, ETH_ALEN) >= 0)
 		goto out;
 
 	ret = true;

---
base-commit: e281f6726677f7e8950dad1640d5386867e6d2e6
change-id: 20260705-dat-tie-break-e90991adc9d0

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

