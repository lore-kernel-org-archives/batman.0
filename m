Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 147E2C61DD9
	for <batman-adv@archiver.kernel.org>; Sun, 30 Aug 2026 15:25:57 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7E42080498
	for <batman-adv@archiver.kernel.org>; Sun, 30 Aug 2026 17:25:55 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788103555;
 b=l8xap39ooZDfGhCyAoPxJvymh7puiu1yBJQy/Mksal6nLfobYYZtdWWq9jUh5E/u4AlWG
 7mh5kXtSsdF1tSETvsDz5htfziPMWymgawuUD/i+Yr+plOQfmIpTN0sM8WZysLdDag0uq4c
 ULtFhOQj5132dmoxHSQjXOur4DADoe4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788103555; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=t5Hqp3l6YbnkDnkQymkYP/Lj03gkdeoVu9gzfV3y0Co=;
 b=BMPmmiXNMbWHalNmMAZQIyUIczfoTAVhu+ComkM9eL+cuVkg/Yf0Nrk5JNNfKHuiWg0AA
 /dRIb565vXu1tpcP0A8GpCN3PhMirfo1x1D0Ld3UA4YdZpR053w48TkYyZSiGNbYLQK9HgT
 +0L/QJPAzwJVXBm0olBzcqdwpTXV1iQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 7658880406
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 30 Aug 2026 17:22:21 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788103341;
	b=KPaflu3s990+e4oHDPuuQM6MS09QUQn08+bXGszBoCHRo6meHZufbIvHrO7MNHF0PWdwo8
	/Mkc9anfQcs2ilCtWKqP1PMC12K/WO23DGDuvtqBFanlfVALkkgFzNnuWMENzggLelXcg0
	2YWBHPyhJ4Bx40OxuLf6pjudOIUqPOI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788103341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=t5Hqp3l6YbnkDnkQymkYP/Lj03gkdeoVu9gzfV3y0Co=;
	b=2/scTUly0RQtzhEhmppNGQ30UwhuYHFTVDEWx7JLmv93nUt9QgT357nr5f05WbNKcD/SXw
	B5535tqUR7WR+GUjNabQ+R6unPHuPHqhd5huEVd+RbjVG1hMyel4MiRVN/zctljedFCqQ8
	9KtpXAQZYTgKzZZPqo3OhEJCLOSgF0g=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=aKwHtd4A;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 13FDD20131;
	Sun, 30 Aug 2026 15:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788103337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t5Hqp3l6YbnkDnkQymkYP/Lj03gkdeoVu9gzfV3y0Co=;
	b=aKwHtd4AP+4MDLxDwNqkXnu2L/eUx6/rVktsVzqWBYOdBDw+DgVbIS9k0m3EI356PuVluX
	kMemh46qhuuCujz1u4z5OEz3Uoa9mZCW7cvNqu8fbOZryOrJ7dyB8ubaHtHy7GzyNUS+ZS
	2ujbVMIM7PJgVhRZKiDyiMfYxUQrpOI=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 30 Aug 2026 17:21:44 +0200
Subject: [PATCH batadv v6 07/20] batman-adv: tt: don't uncount never
 committed clients on pending purge
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260830-tt-fixes-v6-7-a56568a15041@narfation.org>
References: <20260830-tt-fixes-v6-0-a56568a15041@narfation.org>
In-Reply-To: <20260830-tt-fixes-v6-0-a56568a15041@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1987; i=sven@narfation.org;
 h=from:subject:message-id; bh=dnTL6UX5ExcdmldhjkkiL8mTbF+8mKy182iOJeMr+Fg=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFlTvNq8b19pd3/aEDPPY/LSKmeRV2Gv98h6WH/Qbp0zw
 2uu+3u/jlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEwrIYfrP+6syLydxbK8H5
 xG/zk9Kyd3lxbRq311ZP/31u3u74x4cZGbY+PHNmwfEnbGXrbVwtd3TdFn69K5vt4X13lo/Lvd4
 zH2UGAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 2IQCQJX7WF43KSKHG7U5CL54O6ASJCRN
X-Message-ID-Hash: 2IQCQJX7WF43KSKHG7U5CL54O6ASJCRN
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/2IQCQJX7WF43KSKHG7U5CL54O6ASJCRN/>
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 534fbb05..074d7991 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -398,6 +398,10 @@ static void batadv_tt_local_size_inc(struct batadv_priv *bat_priv,
  *  given vid
  * @bat_priv: the bat priv with all the mesh interface information
  * @vid: the VLAN identifier
+ *
+ * It must only be called after a batadv_tt_local_entry without NEW flag
+ * was removed from bat_priv->tt.local_hash (under the specific
+ * list_locks[i]).
  */
 static void batadv_tt_local_size_dec(struct batadv_priv *bat_priv,
 				     unsigned short vid)
@@ -4072,8 +4076,13 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 					   tt_common->addr,
 					   batadv_print_vid(tt_common->vid));
 
-				batadv_tt_local_size_dec(bat_priv, tt_common->vid);
 				hlist_del_rcu(&tt_common->hash_entry);
+
+				/* An entry which still carries BATADV_TT_CLIENT_NEW was
+				 * never counted and must not be uncounted here.
+				 */
+				if (!(tt_common->flags & BATADV_TT_CLIENT_NEW))
+					batadv_tt_local_size_dec(bat_priv, tt_common->vid);
 			}
 
 			if (cont)

-- 
2.47.3

