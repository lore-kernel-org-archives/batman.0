Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C7A8C55172
	for <batman-adv@archiver.kernel.org>; Tue,  4 Aug 2026 10:22:16 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8BFBE841F1
	for <batman-adv@archiver.kernel.org>; Tue, 04 Aug 2026 12:22:14 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785838934;
 b=VUzMhjGq5s+V9cKaDMi3GT/lJi8X6Y8uxPu/IIXsftO/ykqFm6v0q1RK/xYyftypisvPd
 RCOHU6ZYAyrmB8TXPiKzLAx7U8GKt4ExKFqAKQbJkgxAQB7lJYyEum9+FerTfuIUZ+Pmoed
 rvk1LH4rcsIKQoga5Jj4C0zc9pbcsbE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785838934; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=NSZ0FoljGzqp9NwYMeq6cmnW17Kx4Z2guo6ng+ggJpo=;
 b=EG1NW+8t2KpFMA/p9/kjWwa5VdD2OwybaQV3kv4ay3H9z3oBE70lBazTW1Q8RNoWcJldZ
 PvgkJ05oBh6mg/tuJGQMg6+E+NUyW67N1Susqvmo1hLMwdD8WapzrykPKVWifMyl/Ajz14W
 S7OfSlMF/SzmQEN0AWddBcuofLPZX/s=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id E4BA18414E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 04 Aug 2026 12:19:41 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785838781;
	b=GZ+QG/s6DUTITjcHw7v3crjDTULAcT6PXyV6v1GLkyWaKrBjyy+OQfMTGeYsSSVhtTEM4a
	+1Elrz7jUnyZBAaGcQ5L3+YweXIUCtUXqCkcXmus9Erk8XFcr1pbOyrDlrKRgVn0zOe4lD
	lxd7AXvZlIiAoZ551pfAWwSsWm7me9Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785838781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=NSZ0FoljGzqp9NwYMeq6cmnW17Kx4Z2guo6ng+ggJpo=;
	b=PQmK2N5bhA5LlM/zNmXXMUmpj0aSLe3Nh5Wxa4oVTrB0qn7EXjA1q16AI3w0OOu+aHEMUD
	qQEhrx2K1+idzRRPLPxNcPcs4SAK+7agu9tMTn8LQigzzCaQ8ODjrBd1zups+4cC67NgNR
	/alxiEZJ7p0eGKW/DYq6+lallRjBgn0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=oOUSarw8;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 7783C20210;
	Tue, 04 Aug 2026 10:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785838777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NSZ0FoljGzqp9NwYMeq6cmnW17Kx4Z2guo6ng+ggJpo=;
	b=oOUSarw8tqvlKLDJMaxr1ujwFSMn/mZfI0UQ/jan3aP5O0O+6G78sOchThhYy8y+EmWP+s
	44/dxRlHY2fVTwOhdO/pD9oPzmKlNLRP/lE4YikP2HlJQhMYcIbpNF3+cIOUMUxt393v/H
	C9nRMgzuWtU+1mZF7BqR0uHWrIdNE2o=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 04 Aug 2026 12:18:17 +0200
Subject: [PATCH batadv v2 6/6] batman-adv: tt: don't uncount never
 committed clients on pending purge
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-tt-fixes-v2-6-487c48fc7fc4@narfation.org>
References: <20260804-tt-fixes-v2-0-487c48fc7fc4@narfation.org>
In-Reply-To: <20260804-tt-fixes-v2-0-487c48fc7fc4@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2052; i=sven@narfation.org;
 h=from:subject:message-id; bh=FghaOGJnRS1QGIjIQSjOepKkPkuuEH1Z6tW0/0J4kW8=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmFe7JmtD84lDK96nDxgg+7fMIE+8qzJDpXrKv+oOM50
 aK9TPBpRykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAizg4M/z0/PzuQHfrVuSDt
 1g3uhruv1B53sK2VFQ63Wx7pK7mosYqRYbvn9w9r7HzC53meffSUce4Cf/6eywpJOq9P/zNivHe
 7nxEA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: P3Y66BFRUCXIHLR4P4BCT4XA6QV3BJW2
X-Message-ID-Hash: P3Y66BFRUCXIHLR4P4BCT4XA6QV3BJW2
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/P3Y66BFRUCXIHLR4P4BCT4XA6QV3BJW2/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_tt_local_purge_pending_clients() decreases vlan->tt.num_entries for
every entry it unlinks, but an entry which still carries
BATADV_TT_CLIENT_NEW was never counted by batadv_tt_local_transition_new().

batadv_tt_local_resize_to_mtu() calls batadv_tt_local_purge() and
batadv_tt_local_purge_pending_clients() directly, without committing in
between, and it halves its timeout down towards zero. Once the timeout is
short enough, batadv_tt_local_purge_list() marks even freshly added clients
as pending. And each of them decreases a counter it never increased.

Consume the BATADV_TT_CLIENT_NEW accounting token here as well, so that the
counter is only decreased for entries which were actually counted.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 28575051..a0ac7899 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -4013,6 +4013,7 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 	struct batadv_tt_local_entry *tt_local;
 	struct hlist_node *node_tmp;
 	struct hlist_head *head;
+	u16 old_flags;
 	u32 i;
 
 	if (!hash)
@@ -4033,8 +4034,16 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 				   tt_common->addr,
 				   batadv_print_vid(tt_common->vid));
 
-			batadv_tt_local_size_dec(bat_priv, tt_common->vid);
 			hlist_del_rcu(&tt_common->hash_entry);
+
+			/* An entry which still carries BATADV_TT_CLIENT_NEW was
+			 * never counted and must not be uncounted here.
+			 */
+			old_flags = atomic_fetch_andnot(BATADV_TT_CLIENT_NEW,
+							&tt_common->flags);
+			if (!(old_flags & BATADV_TT_CLIENT_NEW))
+				batadv_tt_local_size_dec(bat_priv, tt_common->vid);
+
 			tt_local = container_of(tt_common,
 						struct batadv_tt_local_entry,
 						common);

-- 
2.47.3

