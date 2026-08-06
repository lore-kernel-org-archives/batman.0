Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47450C55ABF
	for <batman-adv@archiver.kernel.org>; Thu,  6 Aug 2026 07:46:06 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id ABD0A84227
	for <batman-adv@archiver.kernel.org>; Thu, 06 Aug 2026 09:46:04 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1786002364;
 b=Oc3g1Gs8O96Ymd+HEtETxt1L8uwgdd4fz53HQIMxyBUY0hkFBOp8yU+VgIaAxbxuXZCwq
 OWdKBZItSf81wkcVgHjh5zdF8nr5tOJUBrtJhX9yBsX34unZYC6wDD3pNKD+g3R0YquWBe4
 bvpKHtG6tDpCkZEeq970Ner2Nv1V7kc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1786002364; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=geTCVzQnoHsD6I+/VABrpr06USyGCVzkQ+HF8HEGeg4=;
 b=I/Pw9Nzs1d5e7LP5jJrSM8QdmJRoQwJlnqg9kLrRWQNeFoQKzT7YraxS9AP47iUJMhkQs
 8zgpSzvW7Jiyl91GhaeGPqsAOqqNp/Fkyr2+3fvEcHgQ7cvwQ5rPqnOimweM42nkx4F7GHi
 8YfIovP/V/qVJdcJbBqJBNS+xGqeY+s=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id A70DC84222
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 06 Aug 2026 09:42:50 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1786002170;
	b=PLWRpQXL3GKlyQ5LceMVhOZz2f12ubxFq9FEByd7Z9gOR6i83wZYghneSaTywHNuPNfFe7
	qwO4CBbAR0DAgtU4pU6SkecqfI7aoxtAIBoEb550yyxs3m8pPQDbuzp40tfpBvaNAtYGyl
	e06p9dUtlAU84Ixv0nK9l/RJls9PgBI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1786002170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=geTCVzQnoHsD6I+/VABrpr06USyGCVzkQ+HF8HEGeg4=;
	b=IEohnFyibFDPbXAKjS6bpSXzcBWfmhthoRnEtiXUVjh667UharR6bdCWAbq80ktYBTkTsM
	x7KsAlhsg5/TF09leQ6kU4UISrzTH+7pQJnuWsswaodPGCDF/VzMhkEsUR2elp6zSHsYZj
	tpmAI8Ki8glRZ9LgxVObZZNphdJ6l60=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=GBYZo9Uz;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 3F00E200D8;
	Thu, 06 Aug 2026 07:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1786002166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=geTCVzQnoHsD6I+/VABrpr06USyGCVzkQ+HF8HEGeg4=;
	b=GBYZo9UzjDW/d93y9pn5k6LvabazBpr/GKhtcvsJ6RombtX6VTERwTDfl9038IZEy19cfc
	E6asE0BNBcs0g1elIujbvCg8iaNDAEstRZu1d+7UT/Vmxo/sTPAwTZ963pPR/kaMRDi2X3
	KcxmUwz92jK5S4RKQy9Tj8T7GcgxiMU=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 06 Aug 2026 09:41:32 +0200
Subject: [PATCH RFC batadv v4 7/8] batman-adv: tt: don't uncount never
 committed clients on pending purge
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-tt-fixes-v4-7-c2fc871fe807@narfation.org>
References: <20260806-tt-fixes-v4-0-c2fc871fe807@narfation.org>
In-Reply-To: <20260806-tt-fixes-v4-0-c2fc871fe807@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1993; i=sven@narfation.org;
 h=from:subject:message-id; bh=LaM9ylGTAho1KQgzoFF8z0ScLhBbJnzIj18xdAL5zDM=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFklVqsZdG6aqJbdytT1NmlsmFlSkNUulOgzfYJ+oM482
 wmPZW92lLIwiHExyIopsuy5kn9+M/tb+c/TPh6FmcPKBDaEi1MAJiJjwsjwyvhV5KK3t+wYnm3P
 rl8pP6X2i7HV+q3m7JX1H7rK/foVGP5w3rr1Ktfoz86ZJ+xd7M8euc337ar1qemZDXeNLoj78Gx
 jAQA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 4QLH4WUIZW57ELIAM4EN62LYN2Y5JG3I
X-Message-ID-Hash: 4QLH4WUIZW57ELIAM4EN62LYN2Y5JG3I
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/4QLH4WUIZW57ELIAM4EN62LYN2Y5JG3I/>
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
index fcdccd52..b8aff4ec 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -398,6 +398,10 @@ static void batadv_tt_local_size_inc(struct batadv_priv *bat_priv,
  *  given vid
  * @bat_priv: the bat priv with all the mesh interface information
  * @vid: the VLAN identifier
+ *
+ * It must only be called after a batadv_tt_local_entry without NEW flag
+ * was removed from bat_priv->tt.local_hash (under under the specific
+ * list_locks[i]).
  */
 static void batadv_tt_local_size_dec(struct batadv_priv *bat_priv,
 				     unsigned short vid)
@@ -4071,8 +4075,13 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
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

