Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD7F6C55172
	for <batman-adv@archiver.kernel.org>; Tue,  4 Aug 2026 10:21:45 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3D10C84232
	for <batman-adv@archiver.kernel.org>; Tue, 04 Aug 2026 12:21:44 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785838904;
 b=PqWLKlOOPxFs6TziX1jP03sn91SmJ2VXwskhJd3XO/eDWjK9WQgz4Rq4quejJBNOzh+jr
 GfqBymdprZrsX5Ryrtnf7G9Cyw6fvCAzSEoE7SfxFSdsvy7XoDPZEzArjTz4sI0ZtreRYi7
 mvWuoWdExchLmcYcvWB6dMa1i+Ca3QE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785838904; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=vc5PkiUWVJm7D6u7wOet0qW5htwWvao+J6MVriPo06Y=;
 b=ISIIOrRI98DGsPCcX4/h+pmkf8g95ky5AG/jcuw78lspzPK1Qgm9B8oiDgHPqF1aT0FXk
 OtTxFUQX69ytzTeshrsa85CN/d5QbO13wImIEmn1LzqwlkD46IPtwuyPTx+p+azbs/36hH7
 wiIWo9ttwXTH/nd2KgQQwgkPX01ZKpE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 5421584205
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 04 Aug 2026 12:19:35 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785838775;
	b=sU23XGq5koFl51M+BSZje/RbTO1TgWyKWmDRMk3Cv6vjZw+IITnC60ecFy3RJzQBfvehOo
	AOD7W4BrEZsceDHz8h4yOpXbkTtr64szLUiN71gSbKxeQV/a49cl7lmiZIVfZDExKMXEQo
	EKK/gtWKIYAjMCHZVAd8H4kOv0dudG8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785838775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=vc5PkiUWVJm7D6u7wOet0qW5htwWvao+J6MVriPo06Y=;
	b=UQZOkoJaaUmOJYJQc9ny+l19HJth5Qvus4HCaj7lD8AjemcZOJtj8Qwt4oJ+EqsQaFxVUW
	YwUy7UX1G06XoP0h1eXjz24orn0AF70EKP19AX6gviwjFVRhgqEIQNav6+fsXkzrDcWjSj
	dSzSyW2Oc1pOmeEETKysvjMPdsXrG3E=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=rHkq3apk;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id E9FB320210;
	Tue, 04 Aug 2026 10:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785838771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vc5PkiUWVJm7D6u7wOet0qW5htwWvao+J6MVriPo06Y=;
	b=rHkq3apkqbDHxwbOof/xLQ9/Y/A7TPgjwwqVi6DrcaKFrcq5XT8q7xieR9hX/iqUsXm66x
	rZ/kHNg7m2UcBgGAyZUr9GRU1wGTOP1BT7iIgckU3hzxgO7g7uOpPf7XICWZWIV16CdnyK
	0jgyt+NwmnxGnSaHbud/vKSIk5XklM4=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 04 Aug 2026 12:18:16 +0200
Subject: [PATCH batadv v2 5/6] batman-adv: tt: decrement count for
 committed client on local_remove
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-tt-fixes-v2-5-487c48fc7fc4@narfation.org>
References: <20260804-tt-fixes-v2-0-487c48fc7fc4@narfation.org>
In-Reply-To: <20260804-tt-fixes-v2-0-487c48fc7fc4@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1625; i=sven@narfation.org;
 h=from:subject:message-id; bh=9AzL4Ge1qI+Idxn9RSk6Umc0bJdkZ8T9DK94keUlyXU=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmFe7LefahIncR0rc9o3keNQM3da3UE5+YqmS+SVypJX
 Wk96e/TjlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBE1t5h+GdUZnUl68OvGKl5
 H6ZzMn4yeu90pnzTntr9//rD33HqZnIyMly04Ei3ec6rUc+x7XarNqPmi7v5Gz91FT5WFE1ekti
 5mA0A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: FQIJCAMO2S27RLNZU7IRSLEFEEWKIL62
X-Message-ID-Hash: FQIJCAMO2S27RLNZU7IRSLEFEEWKIL62
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FQIJCAMO2S27RLNZU7IRSLEFEEWKIL62/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Local TT entries which have the BATADV_TT_CLIENT_NEW no longer set are
committed. The batadv_tt_local_size_inc() was called for them and thus the
batadv_tt_local_size_dec() has to be called also when
batadv_tt_local_remove() is called for them when the BATADV_TT_CLIENT_NEW
wasn't consumed in the remove path.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index cf13ea2f..28575051 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1418,6 +1418,7 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 	struct batadv_tt_local_entry *tt_local_entry;
 	struct hlist_node *tt_removed_node;
 	u16 curr_flags = BATADV_NO_FLAGS;
+	u16 old_flags;
 	u16 flags;
 
 	tt_local_entry = batadv_tt_local_hash_find(bat_priv, addr, vid);
@@ -1463,6 +1464,15 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
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

