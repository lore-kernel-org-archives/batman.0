Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB1D606A323
	for <batman@archiver.kernel.org>; Tue, 24 Nov 2026 21:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=NWt5e3zK
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id EB8E884220
	for <batman@archiver.kernel.org>; Tue, 24 Nov 2026 22:12:51 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795554771;
 b=oIQH7jHRpbErJsO+RHzkXczDFPpGVCUDf7AwUyB0Q23G6nA4Zi2t5E1aiAZV/emijHFmM
 kb36D4DaPNXeJUM8y0BAjplrR24hvgFQAhqKQTqvCIxaPR1DSOL8dZV/Uyo81Bn+5szX7ZX
 WkcSad5F/McqD0y9xes7MdTqVhOLVTc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795554771; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=rIcmkjdY/Qa/FuCB9PKw/T/z5f9EaLkKNYxyNFleTSs=;
 b=ZPUeWHsAmriHjbnIBvtxIB47PBKW9DypFsQIjbo99PAqX2NDIrjuizW8ZBUNnX2wgFugb
 QMsLfak97vTwiixW+hbgCVtKLhlGPTtx/H/YGRFLknxd/3QMpKV6AMp0NqhkD2NOxEUuGGo
 7ZrohXQlIlAdOn1C2qvcV6kbmsFPuGM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id A77138103E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 24 Nov 2026 22:12:11 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795554731;
	b=dE8XXkrBTSoXLSn3h0UHiORRwdbFr6VpMqV+KQCBLInZ9NElLfRJpvFxdGpF8xKtc1Lhrs
	JmRjvLE56VfUkuih4KaVY3YEAMWWpSDytr4vLPbM9ZRgS2ZEXybxN7OBu/xl4REKllJHfl
	MDhPZRz2rm/50r4rbUd9vnQ/nt8gyYM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795554731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=rIcmkjdY/Qa/FuCB9PKw/T/z5f9EaLkKNYxyNFleTSs=;
	b=DmEQ+Qzv92vFWlbENwc3AEBTutBjyVCcPSTXPSiYQ5UCd8xow5ZOkerlR4qH8FZV0ZcyFD
	RfEcDsqz/VuvUOwZqqbj52cgj8lqtIK4fGKX9KV+AWRp934oPuMnVuAWPADwABNfe3uVFb
	o6rxh5IEdv5FWft6eyGuc163L/j+jIk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=NWt5e3zK;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 52809203E3;
	Tue, 24 Nov 2026 21:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1795554731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rIcmkjdY/Qa/FuCB9PKw/T/z5f9EaLkKNYxyNFleTSs=;
	b=NWt5e3zKBYTYGCRtvmY8XXm2cv2nflPDAYYhNWAFfgAz2x2G3tA4PvN+eGoxyQrxd71zu7
	oQuFHf2Tbgd+OPUSQuMx3QAH51nQPdh+b5L1LRKaqqTO26+cbadvujea4nkTfswoTms/tE
	/gNTM0ovP/I6I+TOx0sXzmhme0K7O8o=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 24 Nov 2026 22:12:05 +0100
Subject: [PATCH batadv 1/5] batman-adv: tt: sync requirements of unhash
 helpers for local entries
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-sashiko-kdoc-2026-11-24-v1-1-27282884274f@narfation.org>
References: <20261124-sashiko-kdoc-2026-11-24-v1-0-27282884274f@narfation.org>
In-Reply-To: 
 <20261124-sashiko-kdoc-2026-11-24-v1-0-27282884274f@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1505; i=sven@narfation.org;
 h=from:subject:message-id; bh=0/JAa6bPQff7cTesCH0R6HqYjriOKY/yMhco7mIbELo=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDNmsf5dy954K2WGVz84qHftTfH7xjOKFN1c5CjKqf+N3e
 L6gOd+7o5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjCR/GhGhtXS/q5rRLOPnFxn
 HR2w4Me2zC2MM59dvMvJ8qFV3L7fRIfhr+j1m9ueXHlw0eDuD0bWPesynXnYTCtCgk4/8th9X2b
 bGyYA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: OXQYIFNNCUA5U4LDDUVRUS6MW6VOQS3N
X-Message-ID-Hash: OXQYIFNNCUA5U4LDDUVRUS6MW6VOQS3N
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/OXQYIFNNCUA5U4LDDUVRUS6MW6VOQS3N/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

batadv_tt_local_unhash_pending() removes the entry via
batadv_tt_local_unhash() and therefore inherits its requirements. But its
kernel-doc only asks for the hash bucket list_lock and the flags_lock.

Sync it with the kernel-doc of batadv_tt_local_unhash(): the caller must
have checked that the entry is still part of the local table and has to
drop the reference of the hash after it released the flags_lock.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261123171827.3294525-2-sw%40simonwunderlich.de?part=12
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index e08bf88b..82eadd73 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -4744,10 +4744,10 @@ void batadv_tt_free(struct batadv_priv *bat_priv)
  * it.
  *
  * The caller must hold the hash bucket list_lock and the flags_lock of the
- * entry.
+ * entry. It must have checked that the entry is still part of the local table.
  *
  * Return: true if the entry was unhashed and the caller has to drop the
- * reference of the hash, false otherwise.
+ * reference of the hash after it released the flags_lock, false otherwise.
  */
 static bool
 batadv_tt_local_unhash_pending(struct batadv_priv *bat_priv,

-- 
2.47.3

