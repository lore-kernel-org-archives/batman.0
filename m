Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B784ACD342C
	for <batman-adv@archiver.kernel.org>; Wed,  6 May 2026 20:28:03 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4AB05854FA
	for <batman-adv@archiver.kernel.org>; Wed, 06 May 2026 22:28:02 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778099282;
 b=KQdoxjFvVt7jna+PIu1LpjMOd7fgOJ4uNqK/QcXweHqonevLFbO3RBM6NB8y3O2rSBNzR
 wcG1BfIy0XLy4fTNBUiB67/FlttUOnE7+MXhlrGmy1RW0MjozP6sXkSB2TNIj4C6H0W+Urv
 XnKrx6EPBcbEtoL1be9w2LkiGK2p9bE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778099282; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=JtH+1gaBp7r1iu55Vt/3MBQzlOwokMddmqWibFzTEFc=;
 b=k03fsM7aXM+EjjWPlrm43KvdjKTTcqo80ww0rMEaRdRgAfFPw08fObw5zqwCk2S0D9r0l
 lhap0RVgG/qRKL1maPN0CaXhkgLl4lVoMTiZGH1dnTEjagS7Sk1xkb7mD9koJgXrGLzRHh5
 soiwiOfLUhXDC4yYISreeGxh7IvgMwY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 825D4817F6
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 06 May 2026 22:22:23 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778098943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=JtH+1gaBp7r1iu55Vt/3MBQzlOwokMddmqWibFzTEFc=;
	b=3bYmVpYSDbzxr84hGdLxDusdxAYE8a//05J4R3N8wVyz1jsxyL0ui/XDUWB6fHnW1HfuS4
	o0vtffEsD3fjkmNKznMl0n34EF40Znv3RfltYoFhO7eO+Gv56rtlgbjNtJmh+jT2guTetW
	3jI7Sqzz37J/P12IAQ8/pKzogXNH/f8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=iclgX4T5;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778098943;
	b=M/exqRNFqclugMSvSRPKZDgqlrXfB7SqjhZzTnEO6r+cxMqGp3L7gMM3iwCfKkDRyPSFK3
	Bb1Tc9DUUYLz4P9akGIh02ssfe2sk2TnktQn+E+TsCZrG08Gjvp8NJnC37nI4PIvpBR1ca
	U5B1jgmy/fVyopA4anmN7OGuS9F4pB4=
Received: by dvalin.narfation.org (Postfix) id 3F9DF20D39;
	Wed, 06 May 2026 20:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778098943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JtH+1gaBp7r1iu55Vt/3MBQzlOwokMddmqWibFzTEFc=;
	b=iclgX4T5FC39VBDHqPu5iQqEu50ygRjCvZ/g4TcgnHTTyRtBJSiSH6I9YyfvCYDeSvftCi
	4gXH6aT3mVAu3BnCTwPmvOjnmrLvpR0gETUMnXRDTPL9pEIdvjPQAHkGA1qd+pKwgpBKaG
	Tvo4omABHCkGcLJZ1pO6fffBPbhTQPs=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 06 May 2026 22:20:55 +0200
Subject: [PATCH batadv v2 08/11] batman-adv: tt: reject oversized local
 TVLV buffers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-fixes-followup-v2-8-ce32a2d8d4da@narfation.org>
References: <20260506-fixes-followup-v2-0-ce32a2d8d4da@narfation.org>
In-Reply-To: <20260506-fixes-followup-v2-0-ce32a2d8d4da@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Ao Zhou <n05ec@lzu.edu.cn>, Haoze Xie <royenheart@gmail.com>,
 Jiexun Wang <wangjiexun2025@gmail.com>, Juefei Pu <tomapufckgml@gmail.com>,
 Luxing Yin <tr0jan@lzu.edu.cn>, Ren Wei <n05ec@lzu.edu.cn>,
 Ruide Cao <caoruide123@gmail.com>, Xin Liu <bird@lzu.edu.cn>,
 Yifan Wu <yifanwucs@gmail.com>, Yuan Tan <yuantan098@gmail.com>,
 Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1789; i=sven@narfation.org;
 h=from:subject:message-id; bh=r6v8uIhTpWTnQCIF3XCU6173jTWOBZQ1VRKmTt4uW2o=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDJm/Fx0s2iJwTVn6g8aikpr+pcH/b2ZsDG3Xmp+fbynJX
 ZaVfEG0o5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjCRzbqMDO/nLA7pdpk8+981
 EY7ot8F/rB2zn91XvixTUhKRcExDNJqRYfOyY1sfW/Stkl6unexdfLFw3ZX+B3dfZU+zSTmckXP
 vKg8A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 6JUEA6TBHHVCBMWHVBM3R5RU76MXGBUF
X-Message-ID-Hash: 6JUEA6TBHHVCBMWHVBM3R5RU76MXGBUF
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/6JUEA6TBHHVCBMWHVBM3R5RU76MXGBUF/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The commit 6043a632dd06 ("batman-adv: reject oversized global TT response
buffers") added a check to ensure that a global return buffer size can be
stored in an u16. The same buffer handling also exists for the local data
buffer but was not touched.

A similar check should be also be in place for the local TVLV buffer. It
doesn't have the similar attack surface because it is only generated from
locally discovered MAC addresses but the dynamic nature could still cause
temporarily to large buffers.

Fixes: 21a57f6e7a3b ("batman-adv: make the TT CRC logic VLAN specific")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index d39332ea..e65bd3ea 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -917,12 +917,12 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
 {
 	struct batadv_tvlv_tt_vlan_data *tt_vlan;
 	struct batadv_meshif_vlan *vlan;
+	size_t change_offset;
 	u16 num_vlan = 0;
 	u16 vlan_entries = 0;
 	u16 total_entries = 0;
 	u16 tvlv_len;
 	u8 *tt_change_ptr;
-	int change_offset;
 
 	spin_lock_bh(&bat_priv->meshif_vlan_list_lock);
 	hlist_for_each_entry(vlan, &bat_priv->meshif_vlan_list, list) {
@@ -940,8 +940,10 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
 	if (*tt_len < 0)
 		*tt_len = batadv_tt_len(total_entries);
 
-	tvlv_len = *tt_len;
-	tvlv_len += change_offset;
+	if (check_add_overflow(*tt_len, change_offset, &tvlv_len)) {
+		tvlv_len = 0;
+		goto out;
+	}
 
 	*tt_data = kmalloc(tvlv_len, GFP_ATOMIC);
 	if (!*tt_data) {

-- 
2.47.3

