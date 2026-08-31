Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66ACCC624C6
	for <batman-adv@archiver.kernel.org>; Mon, 31 Aug 2026 13:53:53 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 93D0F81E84
	for <batman-adv@archiver.kernel.org>; Mon, 31 Aug 2026 15:53:51 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788184431;
 b=qT81/2sapKc1PrN71l3g1YMel5zpINTDI07v1LQsaN5RviOvkEP/KC7+6mp7ny59KqeNM
 qo0yqo2O97o9W8H+Hni3/n2ZEAlz4+JDtMOFL7FXeRc8CKsL0vCLGFHFUnVGMLlkxa6rjGW
 A3cUZZqT9oPRvMJh/FRvR3DSpmbN298=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788184431; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=9djlSccpnSy7X9rubGoKjj29XMoDwYx5YPADpj9abOg=;
 b=terxPngQSFm+7IFdI/vCv1EDM34NuqXT9EexJHvVKnCrwX4h1/YnCMRaWM52ARyTykJaU
 oBzxUMH7ddnuodtM9t3XFemOFU/ZV7JxqXnf0k51EZPiGtex4gcgwLimcpfhT5h6+ljntgw
 1FDvmb4ifS1GOiwlVUPLXbbgWbl/k4Q=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id B416C81958
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 31 Aug 2026 15:51:40 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788184300;
	b=pzLroYNhULEv2KLzDsNefqTTiOth9qFt0BVLSHfX/yuZkGwkqk0kbLHjmpr74GmHJU0i+J
	Ig19Cbgy3Yl+un1iyO9T5atPRJvjMArQiNNL2UaDA9gM0ysnr2lPUNF9bJ3/YDcPsnWrmE
	Bb/AdOdx6TVZIBugPkOt9TOjz7bg1tw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788184300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=9djlSccpnSy7X9rubGoKjj29XMoDwYx5YPADpj9abOg=;
	b=gM7bo1xBS+Kj1BzTDJzDN4iBagULD+496RADGmRyN/v6IVeQKR5wVPBYX+oony/2yUBiH6
	QwYhx+EIlng0WfTfSV+4sMlwfMs7orGj9sJVStkfdmVUQAS1+oLXKO2RGzB7x7chQ35OyG
	etMm2uAogWDJmC+qNgsSf3JDeuFdEP0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b="kvyKXH/6";
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300c5970eeDD85F51F1FAA919d7A5.dip0.t-ipconnect.de
 [IPv6:2003:c5:970e:edd8:5f51:f1fa:a919:d7a5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 9C4F6FA197;
	Mon, 31 Aug 2026 15:51:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788184291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9djlSccpnSy7X9rubGoKjj29XMoDwYx5YPADpj9abOg=;
	b=kvyKXH/6eHNfqquj7moJ4cukey3QnXE7eW1DTm68acRIcvfac+uXEgMwIcAHVKiX8GyqGl
	fNB6yVVqgFMM6TXd/96UAYDjoVMG/8gM3Qf6vvlk2+a6ig5V//akmq/YrQ+bpSfo7//kaY
	Vq60sAnxQQMY39yqTV4vK3ZBZxSTz74kmLE3eXCFZiQlpo8/Bs5stpCegrjCd/vVpLVotV
	knNEqZh7SyxapqzAnsJm8hP7+T6+99HvmWit22RsfhjxYsOxyUIBm/EbNXRcRr9Vi9ZiBc
	RWy90Q0k0/nAf2kty0sNUovtidqjsEMo22H8NHjF0u/JZhKwXOEJ9XRUYAriEg==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 05/15] batman-adv: use more descriptive var names for
 is_similar_or_better
Date: Mon, 31 Aug 2026 15:51:07 +0200
Message-ID: <20260831135117.574836-6-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831135117.574836-1-sw@simonwunderlich.de>
References: <20260831135117.574836-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: IZMIISTCIPDLYQGC56HHH46DTHF26SRG
X-Message-ID-Hash: IZMIISTCIPDLYQGC56HHH46DTHF26SRG
X-MailFrom: sw@simonwunderlich.de
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/IZMIISTCIPDLYQGC56HHH46DTHF26SRG/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

neigh1 and neigh2 is not really helpful when looking at a code which needs
to judge the metric similarity between a candidate and a reference. This
already caused an implementation error in the B.A.T.M.A.N. V bonding code.
Simply using "reference" and "candidate" for the neighbors is a lot more
descriptive and makes it easier to understand the code.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c | 25 +++++++++++-----------
 net/batman-adv/bat_v.c      | 42 ++++++++++++++++++-------------------
 net/batman-adv/types.h      | 12 +++++------
 3 files changed, 40 insertions(+), 39 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 53fbdbbe8f4f7..3fe09b4c30463 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -2424,25 +2424,26 @@ static int batadv_iv_ogm_neigh_cmp(struct batadv_neigh_node *neigh1,
 /**
  * batadv_iv_ogm_neigh_is_sob() - check if neigh1 is similarly good or better
  *  than neigh2 from the metric prospective
- * @neigh1: the first neighbor object of the comparison
- * @if_outgoing1: outgoing interface for the first neighbor
- * @neigh2: the second neighbor object of the comparison
- * @if_outgoing2: outgoing interface for the second neighbor
+ * @candidate: the first neighbor object of the comparison
+ * @if_outgoing_cand: outgoing interface for the @candidate neighbor
+ * @reference: the second neighbor object of the comparison
+ * @if_outgoing_ref: outgoing interface for the @reference neighbor
  *
- * Return: true if the metric via neigh1 is equally good or better than
- * the metric via neigh2, false otherwise.
+ * Return: true if the metric via @candidate is equally good or better than
+ * the metric via @reference, false otherwise.
  */
 static bool
-batadv_iv_ogm_neigh_is_sob(struct batadv_neigh_node *neigh1,
-			   struct batadv_hard_iface *if_outgoing1,
-			   struct batadv_neigh_node *neigh2,
-			   struct batadv_hard_iface *if_outgoing2)
+batadv_iv_ogm_neigh_is_sob(struct batadv_neigh_node *candidate,
+			   struct batadv_hard_iface *if_outgoing_cand,
+			   struct batadv_neigh_node *reference,
+			   struct batadv_hard_iface *if_outgoing_ref)
 {
 	bool ret;
 	int diff;
 
-	ret = batadv_iv_ogm_neigh_diff(neigh1, if_outgoing1, neigh2,
-				       if_outgoing2, &diff);
+	ret = batadv_iv_ogm_neigh_diff(candidate, if_outgoing_cand,
+				       reference, if_outgoing_ref,
+				       &diff);
 	if (!ret)
 		return false;
 
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 0d0a226c3fd0c..596889b3522d0 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -514,40 +514,40 @@ static int batadv_v_neigh_cmp(struct batadv_neigh_node *neigh1,
 /**
  * batadv_v_neigh_is_sob() - check whether two B.A.T.M.A.N. V neighbours have
  *  a similar or better throughput
- * @neigh1: first neighbour to compare
- * @if_outgoing1: outgoing interface to use for @neigh1
- * @neigh2: second neighbour to compare
- * @if_outgoing2: outgoing interface to use for @neigh2
+ * @candidate: the first neighbor object of the comparison
+ * @if_outgoing_cand: outgoing interface for the @candidate neighbor
+ * @reference: the second neighbor object of the comparison
+ * @if_outgoing_ref: outgoing interface for the @reference neighbor
  *
- * Return: true if the throughput of @neigh1 is more than 3/4 of the
- *  @neigh2 throughput
+ * Return: true if the throughput of @candidate is more than 3/4 of the
+ *  @reference throughput
  */
-static bool batadv_v_neigh_is_sob(struct batadv_neigh_node *neigh1,
-				  struct batadv_hard_iface *if_outgoing1,
-				  struct batadv_neigh_node *neigh2,
-				  struct batadv_hard_iface *if_outgoing2)
+static bool batadv_v_neigh_is_sob(struct batadv_neigh_node *candidate,
+				  struct batadv_hard_iface *if_outgoing_cand,
+				  struct batadv_neigh_node *reference,
+				  struct batadv_hard_iface *if_outgoing_ref)
 {
-	struct batadv_neigh_ifinfo *ifinfo1;
-	struct batadv_neigh_ifinfo *ifinfo2;
+	struct batadv_neigh_ifinfo *ifinfo_cand;
+	struct batadv_neigh_ifinfo *ifinfo_ref;
 	bool ret = false;
 	u32 threshold;
 
-	ifinfo1 = batadv_neigh_ifinfo_get(neigh1, if_outgoing1);
-	if (!ifinfo1)
+	ifinfo_cand = batadv_neigh_ifinfo_get(candidate, if_outgoing_cand);
+	if (!ifinfo_cand)
 		goto err_ifinfo1;
 
-	ifinfo2 = batadv_neigh_ifinfo_get(neigh2, if_outgoing2);
-	if (!ifinfo2)
+	ifinfo_ref = batadv_neigh_ifinfo_get(reference, if_outgoing_ref);
+	if (!ifinfo_ref)
 		goto err_ifinfo2;
 
-	threshold = ifinfo2->bat_v.throughput / 4;
-	threshold = ifinfo2->bat_v.throughput - threshold;
+	threshold = ifinfo_ref->bat_v.throughput / 4;
+	threshold = ifinfo_ref->bat_v.throughput - threshold;
 
-	ret = ifinfo1->bat_v.throughput > threshold;
+	ret = ifinfo_cand->bat_v.throughput > threshold;
 
-	batadv_neigh_ifinfo_put(ifinfo2);
+	batadv_neigh_ifinfo_put(ifinfo_ref);
 err_ifinfo2:
-	batadv_neigh_ifinfo_put(ifinfo1);
+	batadv_neigh_ifinfo_put(ifinfo_cand);
 err_ifinfo1:
 	return ret;
 }
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 9bdc5a3e799e2..99667f632d4d9 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -2087,14 +2087,14 @@ struct batadv_algo_neigh_ops {
 		   struct batadv_hard_iface *if_outgoing2);
 
 	/**
-	 * @is_similar_or_better: check if neigh1 is equally similar or better
-	 *  than neigh2 for their respective outgoing interface from the metric
+	 * @is_similar_or_better: check if @candidate is equally similar or better
+	 *  than @reference for their respective outgoing interface from the metric
 	 *  prospective
 	 */
-	bool (*is_similar_or_better)(struct batadv_neigh_node *neigh1,
-				     struct batadv_hard_iface *if_outgoing1,
-				     struct batadv_neigh_node *neigh2,
-				     struct batadv_hard_iface *if_outgoing2);
+	bool (*is_similar_or_better)(struct batadv_neigh_node *candidate,
+				     struct batadv_hard_iface *if_outgoing_cand,
+				     struct batadv_neigh_node *reference,
+				     struct batadv_hard_iface *if_outgoing_ref);
 
 	/** @dump: dump neighbors to a netlink socket (optional) */
 	void (*dump)(struct sk_buff *msg, struct netlink_callback *cb,
-- 
2.47.3

