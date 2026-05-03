Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22859FF885A
	for <batman@archiver.kernel.org>; Sun,  3 May 2026 06:28:40 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 594558558E
	for <batman@archiver.kernel.org>; Sun, 03 May 2026 08:28:39 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1777789719;
 b=Nst5fUK02csm4sX7mgB8eFwqTLOrg82ngDB43yiteJ9pSo9V5Zne4Zvqh7orIAOBr4Jug
 SEfLl5Ctz7EkNXVp5G/SvOYNM62Aqfmw3FUHhBQpyDESpAYiECR9KeXYluSQfXjpCfbe8AX
 6E15CZmvJUA0Y54D4yTVv7jOCnKw2gU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1777789719; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=jW+9Pv7ljZz23qHb+1/ku5/ck8ddnN56WAE5fWyjZOM=;
 b=pRsuVS9m9J38p1uP1tHxSZza2YUWXV+v//3KRIEnpwstWK5E+pRnXHJjhTOGHltCxnqH0
 gZlGn+uUDdLcu+Emzgbn3G8pvtSy+b8d+WGQzxRBiEncqNI8i1s9TOg3NBJW26n88vbziLo
 2L0r9u/MIHC6kxHRnOIltA1rw3Suuvg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net
 [207.46.229.174])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3DACF83C42
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 03 May 2026 06:29:04 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1777782548;
	b=IWeFXGobNpOy38TbofSgW8f6LO6adryjukhz2faBPmp3FR+gN0GZLmOMkmguazMfeEQ0LM
	trCWdQNq5CBIelhsfNlfSTU7jfp+qmU3BOE98z6ZzF4C4z+tWRrQVuyO8OGpDC3o3dKey2
	jNSltoMZJCr3vPKDad9/r+a5CQOZT6o=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of n05ec@lzu.edu.cn designates
 207.46.229.174 as permitted sender) smtp.mailfrom=n05ec@lzu.edu.cn;
	dmarc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1777782548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jW+9Pv7ljZz23qHb+1/ku5/ck8ddnN56WAE5fWyjZOM=;
	b=p//a1Vt9KtFFV7gqwsWsruvbV5vg0IpFk2ZTtyzsLIzONCGWHI8SO8NaXT7TBmIDnyJBvq
	4qxYmUNw1PoGbXm66HgV8xlg7DvujzPf745Z58YjiRb9+Q/Uz3wFcstA33u1ycWsz3w4bh
	n9pcyjNXy3P0Cb65TduwmzAfuy20l3w=
Received: from enjou-Legion-Y7000P-2019.coin-barley.ts.net (unknown
 [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowACnHwAJz_Zp8tL0AA--.58707S3;
	Sun, 03 May 2026 12:28:59 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: b.a.t.m.a.n@lists.open-mesh.org,
	netdev@vger.kernel.org
Cc: marek.lindner@mailbox.org,
	sw@simonwunderlich.de,
	antonio@mandelbit.com,
	sven@narfation.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	yuantan098@gmail.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	bird@lzu.edu.cn,
	wangjiexun2025@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH net 1/1] batman-adv: stop caching unowned originator pointers
 in BAT IV
Date: Sun,  3 May 2026 12:28:58 +0800
Message-ID: 
 <e12a51ee998808be6381780d6aaf32e093dc7d1e.1777692024.git.wangjiexun2025@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1777692024.git.wangjiexun2025@gmail.com>
References: <cover.1777692024.git.wangjiexun2025@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: ygmowACnHwAJz_Zp8tL0AA--.58707S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGF17CF13uFy8tF4xKFykXwb_yoWrtr1rp3
	WfKrW5Crsrt3ZxWFW8t34avrWfAFZrtr4UKFykAr1YyryDtr95uw1Fga4UCF1rZFWkGr95
	Kr10k34UXF1qyrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB01xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
	87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
	Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_GFv_Wrylc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY2
	0_Gr4l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRMXdjDUUUU
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQEQCWn1umMEugAAsi
X-MailFrom: n05ec@lzu.edu.cn
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: RQ5ZW5RNFQ5Q4PHCKXU4PB35BPQ6XMVP
X-Message-ID-Hash: RQ5ZW5RNFQ5Q4PHCKXU4PB35BPQ6XMVP
X-Mailman-Approved-At: Sun, 03 May 2026 08:28:34 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RQ5ZW5RNFQ5Q4PHCKXU4PB35BPQ6XMVP/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Jiexun Wang <wangjiexun2025@gmail.com>

BAT IV keeps the last-hop neighbor address in each neigh_node, but some
paths also cache an originator pointer derived from a temporary lookup.
That pointer is not owned by the neigh_node and may no longer refer to a
live originator entry after purge handling runs.

Stop storing the auxiliary originator pointer in the BAT IV neighbor
state. When BAT IV needs the neighbor originator data, resolve it from
the stored neighbor address and drop the reference again after use.

Fixes: c6c8fea29769 ("net: Add batman-adv meshing protocol")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Jiexun Wang <wangjiexun2025@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 net/batman-adv/bat_iv_ogm.c | 56 +++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index f28e9cbf8ad5..168b413dd18b 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -173,19 +173,12 @@ batadv_iv_ogm_orig_get(struct batadv_priv *bat_priv, const u8 *addr)
 static struct batadv_neigh_node *
 batadv_iv_ogm_neigh_new(struct batadv_hard_iface *hard_iface,
 			const u8 *neigh_addr,
-			struct batadv_orig_node *orig_node,
-			struct batadv_orig_node *orig_neigh)
+			struct batadv_orig_node *orig_node)
 {
 	struct batadv_neigh_node *neigh_node;
 
 	neigh_node = batadv_neigh_node_get_or_create(orig_node,
 						     hard_iface, neigh_addr);
-	if (!neigh_node)
-		goto out;
-
-	neigh_node->orig_node = orig_neigh;
-
-out:
 	return neigh_node;
 }
 
@@ -906,6 +899,31 @@ static u8 batadv_iv_orig_ifinfo_sum(struct batadv_orig_node *orig_node,
 	return sum;
 }
 
+/**
+ * batadv_iv_ogm_neigh_ifinfo_sum() - Get bcast_own sum for a last-hop neighbor
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @neigh_node: last-hop neighbor of an originator
+ *
+ * Return: Number of replied (rebroadcasted) OGMs for the originator currently
+ * announced by the neighbor. Returns 0 if the neighbor's originator entry is
+ * not available anymore.
+ */
+static u8 batadv_iv_ogm_neigh_ifinfo_sum(struct batadv_priv *bat_priv,
+					 const struct batadv_neigh_node *neigh_node)
+{
+	struct batadv_orig_node *orig_neigh;
+	u8 sum;
+
+	orig_neigh = batadv_orig_hash_find(bat_priv, neigh_node->addr);
+	if (!orig_neigh)
+		return 0;
+
+	sum = batadv_iv_orig_ifinfo_sum(orig_neigh, neigh_node->if_incoming);
+	batadv_orig_node_put(orig_neigh);
+
+	return sum;
+}
+
 /**
  * batadv_iv_ogm_orig_update() - use OGM to update corresponding data in an
  *  originator
@@ -975,17 +993,9 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 	}
 
 	if (!neigh_node) {
-		struct batadv_orig_node *orig_tmp;
-
-		orig_tmp = batadv_iv_ogm_orig_get(bat_priv, ethhdr->h_source);
-		if (!orig_tmp)
-			goto unlock;
-
 		neigh_node = batadv_iv_ogm_neigh_new(if_incoming,
 						     ethhdr->h_source,
-						     orig_node, orig_tmp);
-
-		batadv_orig_node_put(orig_tmp);
+						     orig_node);
 		if (!neigh_node)
 			goto unlock;
 	} else {
@@ -1037,10 +1047,9 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 	 */
 	if (router_ifinfo &&
 	    neigh_ifinfo->bat_iv.tq_avg == router_ifinfo->bat_iv.tq_avg) {
-		sum_orig = batadv_iv_orig_ifinfo_sum(router->orig_node,
-						     router->if_incoming);
-		sum_neigh = batadv_iv_orig_ifinfo_sum(neigh_node->orig_node,
-						      neigh_node->if_incoming);
+		sum_orig = batadv_iv_ogm_neigh_ifinfo_sum(bat_priv, router);
+		sum_neigh = batadv_iv_ogm_neigh_ifinfo_sum(bat_priv,
+							   neigh_node);
 		if (sum_orig >= sum_neigh)
 			goto out;
 	}
@@ -1106,7 +1115,6 @@ static bool batadv_iv_ogm_calc_tq(struct batadv_orig_node *orig_node,
 	if (!neigh_node)
 		neigh_node = batadv_iv_ogm_neigh_new(if_incoming,
 						     orig_neigh_node->orig,
-						     orig_neigh_node,
 						     orig_neigh_node);
 
 	if (!neigh_node)
@@ -1372,8 +1380,8 @@ batadv_iv_ogm_process_per_outif(const struct sk_buff *skb, int ogm_offset,
 
 	router = batadv_orig_router_get(orig_node, if_outgoing);
 	if (router) {
-		router_router = batadv_orig_router_get(router->orig_node,
-						       if_outgoing);
+		router_router = batadv_orig_to_router(bat_priv, router->addr,
+						      if_outgoing);
 		router_ifinfo = batadv_neigh_ifinfo_get(router, if_outgoing);
 	}
 
-- 
2.34.1

