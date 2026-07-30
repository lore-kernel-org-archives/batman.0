Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA705C55162
	for <batman@archiver.kernel.org>; Thu, 30 Jul 2026 17:34:31 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5C81084004
	for <batman@archiver.kernel.org>; Thu, 30 Jul 2026 19:34:30 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785432870;
 b=XSZNzpdoq5XvJkN+C3pTTiPSmSylk+ttHRIDoU155nh9fBK1s5OE9sZ5RtDUKIN2zfJq3
 UmpYHz0+hv7/1M3mK9xSq18eusKwIf+ayPeCJNLQT/uQ3oNEPFWkGYKB+KhaK3xeysEXTEg
 Kqq9ItSGSxKqLjNEldPm+pcgAwfb/eQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785432870; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=BNxOx2Vmsxa+QH9TOS0OxYbwT3QBD9uMzyMstbsah3g=;
 b=FFmM0FG0f6f+oV7a/cQGgC1uQjJRfy2RL+xyQ9pP1jfMPiSPodQMna6q+IIrHDkfK6yTf
 F3Oho9by1zqTLjHd/YWFwHx94J/x+gAw0NR0xh6Y0dRY/E792SEReqV78P7Pkp+ylQIopvI
 JLxep2slE6c0HjDTMz7Fx3a+Y0hjUCI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 4830883E4C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 30 Jul 2026 19:33:22 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785432802;
	b=FL4KvN7aXckp0Rp3mIzhsWN4BoPUlTCkm+XPm4q7CIqBxJy2sCzMlpyimDWoBbKVWQK73S
	pu5YUqLcnvmwfj0LoXgemkVhd3/grAUpEq799vsn2VlixngHi2CuXAsdmSXLrr7u1VHt9I
	Fi3Xo7oYV4GACeLIoOJJfB74Eo/w+5k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785432802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=BNxOx2Vmsxa+QH9TOS0OxYbwT3QBD9uMzyMstbsah3g=;
	b=fmL/wmhbAbrM6mxQJyAIe0m4UbYe2S1v3fmrL733Kd4cOrQ3Th/oIgEmCxoFJ4sPTIFzW7
	cdVtuLSoXtNHTEsq9JS4L5PWqPCpMpmMtAHL15Gh4XnqhZNKAYgkE97mfjLVQsveMBt1DK
	35sJz9GNtomtNjrGAMIGS2UwfeuBfXg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=FVYsTbML;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id CD5A5203F6;
	Thu, 30 Jul 2026 17:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785432797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BNxOx2Vmsxa+QH9TOS0OxYbwT3QBD9uMzyMstbsah3g=;
	b=FVYsTbMLtR0PuvWJuV11U4Vw29P/iAl4AjH0HdVefnioNVuvgteeHWnB48c/3cjxv8AmS+
	GvcepF+KTFMWXTWke+x7XByjH5XL1yB+qvds+d1eiamf1+A0P0hnE53ZQYAHP1DhAZtrYL
	FoghC81806OUIws39455Xv9AjKdW2Cw=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 30 Jul 2026 19:32:57 +0200
Subject: [PATCH batadv 2/4] batman-adv: tt: don't directly clear NEW flag
 when removing local entry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-tt-fixes-v1-2-64e9e525d555@narfation.org>
References: <20260730-tt-fixes-v1-0-64e9e525d555@narfation.org>
In-Reply-To: <20260730-tt-fixes-v1-0-64e9e525d555@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3663; i=sven@narfation.org;
 h=from:subject:message-id; bh=jPaH/QEHMV7Qjj7yg1tGOX29w6gulGm3IcXyU/W1Krs=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnZXeeOFtWEFhxd6vuPYaHglJWBrxVFtFa07zYOj70TY
 XrE8YhgRykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAiZWsYGebe9pQq7Pk/7//T
 3VvOJAsVSi2xvrO8x/rC8iSFz4r+bKKMDDNnur3PF9KPe7p5bVN77MHkN03pnexPtq07NqOQV7p
 QlQcA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: WGNYOA47FK3DEEQP5MVFMCKWOPSZB3VH
X-Message-ID-Hash: WGNYOA47FK3DEEQP5MVFMCKWOPSZB3VH
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/WGNYOA47FK3DEEQP5MVFMCKWOPSZB3VH/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The conversion of the translation table flags to atomic_t turned the pure
BATADV_TT_CLIENT_NEW test in batadv_tt_local_remove() into a
test-and-clear. This is not needed for the atomic flag handling and instead
breaks the local translation table size accounting.

BATADV_TT_CLIENT_NEW is the only marker which tells the commit worker that
an entry still has to be counted. The single increment site is the NEW ->
!NEW transition in batadv_tt_local_transition_new(), while
batadv_tt_local_purge_pending_clients() unconditionally decrements every
still hashed entry which carries BATADV_TT_CLIENT_PENDING. Clearing the
flag outside of batadv_tt_local_transition_new() therefore drops the
increment while keeping the decrement:

  CPU A batadv_tt_local_remove()
    atomic_fetch_andnot(NEW) -> old_flags has NEW
    batadv_tt_local_event(..., BATADV_TT_CLIENT_DEL)
  CPU B batadv_tt_local_remove() (entry found before A unlinked it)
    atomic_fetch_andnot(NEW) -> old_flags has no NEW
    batadv_tt_local_set_pending() -> atomic_or(PENDING)
  CPU C commit worker
    batadv_tt_local_transition_new() -> no NEW, no size_inc
    batadv_tt_local_purge_pending_clients() -> size_dec + hlist_del_rcu
  CPU A batadv_tt_local_remove()
    batadv_hash_remove() -> NULL

Restore the read-only test at the start of the function and add an explicit
batadv_tt_local_size_dec() for the !NEW case. Losing the race against
another remover is already handled by batadv_hash_remove() returning NULL.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: 8b4cee3c9355 ("batman-adv: tt: use atomic flag modifications")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 99887237..248b2966 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1416,13 +1416,19 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 		atomic_or(BATADV_TT_CLIENT_ROAM, &tt_local_entry->common.flags);
 	}
 
-	old_flags = atomic_fetch_andnot(BATADV_TT_CLIENT_NEW,
-					&tt_local_entry->common.flags);
-	if (!(old_flags & BATADV_TT_CLIENT_NEW)) {
+	/* This must stay a read-only test while the entry is still hashed:
+	 * clearing the flag here would make a concurrent remover of the same
+	 * entry pick the branch below and mark a not yet committed entry as
+	 * pending. A parallel batadv_tt_local_purge_pending_clients()
+	 * then calls batadv_tt_local_size_dec() for this entry even when
+	 * it was never counted by via batadv_tt_local_set_flags()
+	 */
+	if (!(atomic_read(&tt_local_entry->common.flags) & BATADV_TT_CLIENT_NEW)) {
 		batadv_tt_local_set_pending(bat_priv, tt_local_entry, flags,
 					    message);
 		goto out;
 	}
+
 	/* if this client has been added right now, it is possible to
 	 * immediately purge it
 	 */
@@ -1436,6 +1442,15 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 	if (!tt_removed_node)
 		goto out;
 
+	/* batadv_tt_local_transition_new() may have committed the entry and
+	 * thus counted it in the local table size since the BATADV_TT_CLIENT_NEW
+	 * check above.
+	 */
+	old_flags = atomic_fetch_andnot(BATADV_TT_CLIENT_NEW,
+					&tt_local_entry->common.flags);
+	if (!(old_flags & BATADV_TT_CLIENT_NEW))
+		batadv_tt_local_size_dec(bat_priv, tt_local_entry->common.vid);
+
 	/* drop reference of remove hash entry */
 	batadv_tt_local_entry_put(tt_local_entry);
 

-- 
2.47.3

