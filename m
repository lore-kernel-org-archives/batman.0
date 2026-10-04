Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A815CA5FEC
	for <batman@archiver.kernel.org>; Sun,  4 Oct 2026 10:09:53 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id BE4C284625
	for <batman@archiver.kernel.org>; Sun, 04 Oct 2026 12:09:51 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791108591;
 b=LKiewiEOp8oR85LrWTNsA8MjNnWMY77mxC+kX0UagfPSmShlMGLt7njDbo5apDF8w+TVf
 L7vSgEoFw+1iTMY9AIDgIlTEkrDHLlaQIzWphJZMAwzQaYp708AKamPAx4lEM+kib9Zd7OQ
 GKhvmqFeDjIbgGLTkTWMpzhBBsQ1MN0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791108591; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=CkX81aM6GxtYChpaZeZ9vCEmZ5g3mNJ2l7wF0uS3zyc=;
 b=u2ejnTpg9SrareSOcFH1HRCyFhGOZU9717vDByViCNjCwXBs8I5iAxPZgQddKMbTn4msB
 zeQyO1DCQbB1RTma7YJGnRih3bRnFPFb02NpuK4Eya0z3SJITW4Mp+Wxnv78beAHARhKPm+
 LQ1AOBwRg6NSuVDkaKCfvPVffCG2Z9A=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id A9ADC80F1E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 04 Oct 2026 12:09:12 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791108552;
	b=1CTJiN7m2puXl1r4vCg8e0XtKERwFd+Uqk+fBjjqOgIaW1LJ0P/FO89VNVU215Dn2WiCfv
	OJZKTsik1d5Mt8Py+0/1PKKAClqLazqEXfFk6YAi0kGwfsedKd/CU42rk0hJeEiUy2BE3U
	SAlFoGylLHfUeQTz7v2YvI4isuiScQk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791108552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=CkX81aM6GxtYChpaZeZ9vCEmZ5g3mNJ2l7wF0uS3zyc=;
	b=xwAxbW5rvK+iBq5Um8hPo0hT6/E7M2yudrRabDbGiJqaRUOrMTcgTf8c+pYp30S4ULx5bx
	xS2bU809mHxz0HnZ+Ib6nKTLM5o6DEVbtcSKUMifG/MQyZSbB/0IYa1ycweJwi6a+uU/EC
	krunLJ4qsOyRDFSU/dWV6zTIvkDa6pw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=KxuRXJY8;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id BE002205E6;
	Sun, 04 Oct 2026 10:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791108550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CkX81aM6GxtYChpaZeZ9vCEmZ5g3mNJ2l7wF0uS3zyc=;
	b=KxuRXJY8DIMJtaCRSvgC9VFHTfqSMQPsbErgj5fnxpeE7+syOnsUzyWtFhwp77eFIm7Gir
	WaK3cOItZyrW5aNUvtxarvE7hEDcYh/tnXd0qWlWQdYgh6VHoa7Vyx00ScTaCBjsmOFtVY
	8SPFBB1UBfPK/ZyNxoXPoSknSNUM5jw=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 04 Oct 2026 12:08:40 +0200
Subject: [PATCH batadv v2 5/9] batman-adv: annotate originator last_seen
 with READ/WRITE_ONCE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-dat-last_update-once-v2-5-ab012a4b18ed@narfation.org>
References: <20261004-dat-last_update-once-v2-0-ab012a4b18ed@narfation.org>
In-Reply-To: <20261004-dat-last_update-once-v2-0-ab012a4b18ed@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4847; i=sven@narfation.org;
 h=from:subject:message-id; bh=DTePba8wkD+EQDPiQ6UxpORchbNCtxheV2elAu8cPDo=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmHVLfwpF18b7LdVXDG0lXx6Zd0ivV4WULcuxVmXEw53
 HtgoYRRRykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAit8sZ/jtqxvpa3vu5e8Xz
 A4q6YlK67wM7OS5cXMpjIhj2oXzvsU6GvxKBjSb/s5n9jjMsMtx4z1R669RFVvoZBpMnvLrUKH2
 olw8A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 35TWHA64VULL7JNEAOZNO26UFC3WMPVW
X-Message-ID-Hash: 35TWHA64VULL7JNEAOZNO26UFC3WMPVW
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/35TWHA64VULL7JNEAOZNO26UFC3WMPVW/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The last_seen field for batadv_orig_node tracks the jiffies value of the
most recent activity and is used to detect timeouts. These accesses are not
consistently protected by a lock, so READ_ONCE/WRITE_ONCE must be used to
prevent data races caused by compiler optimizations.

To avoid an underflow due to an non-strict order read of jffies vs
last_seen, use jiffies_delta_to_msecs instead of jiffies_to_msecs to
evaluate the delta.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_iv_ogm.c | 6 ++++--
 net/batman-adv/bat_v.c      | 4 +++-
 net/batman-adv/bat_v_ogm.c  | 7 ++++---
 net/batman-adv/originator.c | 8 +++++---
 4 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 85e99506..ee3a5ac4 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1291,7 +1291,7 @@ static bool batadv_iv_ogm_calc_tq(struct batadv_orig_node *orig_node,
 	if (orig_node == orig_neigh_node)
 		neigh_node->last_seen = jiffies;
 
-	orig_node->last_seen = jiffies;
+	WRITE_ONCE(orig_node->last_seen, jiffies);
 
 	/* find packet count of corresponding one hop neighbor */
 	orig_eq_count = batadv_iv_orig_ifinfo_sum(orig_neigh_node, if_incoming);
@@ -2045,10 +2045,12 @@ batadv_iv_ogm_orig_dump_subentry(struct sk_buff *msg, u32 portid, u32 seq,
 				 bool best)
 {
 	unsigned int last_seen_msecs;
+	unsigned long last_seen;
 	void *hdr;
 	u8 tq_avg;
 
-	last_seen_msecs = jiffies_to_msecs(jiffies - orig_node->last_seen);
+	last_seen = READ_ONCE(orig_node->last_seen);
+	last_seen_msecs = jiffies_delta_to_msecs(jiffies - last_seen);
 
 	if (!batadv_iv_ogm_neigh_get_tq_avg(neigh_node, if_outgoing, &tq_avg))
 		return 0;
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 596889b3..de80e656 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -301,6 +301,7 @@ batadv_v_orig_dump_subentry(struct sk_buff *msg, u32 portid, u32 seq,
 {
 	struct batadv_neigh_ifinfo *n_ifinfo;
 	unsigned int last_seen_msecs;
+	unsigned long last_seen;
 	u32 throughput;
 	void *hdr;
 
@@ -312,7 +313,8 @@ batadv_v_orig_dump_subentry(struct sk_buff *msg, u32 portid, u32 seq,
 
 	batadv_neigh_ifinfo_put(n_ifinfo);
 
-	last_seen_msecs = jiffies_to_msecs(jiffies - orig_node->last_seen);
+	last_seen = READ_ONCE(orig_node->last_seen);
+	last_seen_msecs = jiffies_delta_to_msecs(jiffies - last_seen);
 
 	if (if_outgoing != BATADV_IF_DEFAULT &&
 	    if_outgoing != neigh_node->if_incoming)
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 70846c99..03c70d91 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -626,6 +626,7 @@ static int batadv_v_ogm_metric_update(struct batadv_priv *bat_priv,
 	struct batadv_neigh_ifinfo *neigh_ifinfo = NULL;
 	struct batadv_orig_ifinfo *orig_ifinfo;
 	bool protection_started = false;
+	unsigned long last_seen;
 	u32 path_throughput;
 	int ret = -EINVAL;
 	s32 seq_diff;
@@ -656,9 +657,9 @@ static int batadv_v_ogm_metric_update(struct batadv_priv *bat_priv,
 	if (seq_diff < 0 && !protection_started)
 		goto out;
 
-	neigh_node->last_seen = jiffies;
-
-	orig_node->last_seen = jiffies;
+	last_seen = jiffies;
+	neigh_node->last_seen = last_seen;
+	WRITE_ONCE(orig_node->last_seen, last_seen);
 
 	orig_ifinfo->last_real_seqno = ntohl(ogm2->seqno);
 	orig_ifinfo->last_ttl = ogm2->ttl;
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index f06583ef..3b925ba9 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -977,7 +977,7 @@ struct batadv_orig_node *batadv_orig_node_new(struct batadv_priv *bat_priv,
 	WRITE_ONCE(orig_node->last_ttvn, 0);
 	orig_node->tt_buff = NULL;
 	orig_node->tt_buff_len = 0;
-	orig_node->last_seen = jiffies;
+	WRITE_ONCE(orig_node->last_seen, jiffies);
 	reset_time = jiffies - 1 - msecs_to_jiffies(BATADV_RESET_PROTECTION_MS);
 	orig_node->bcast_seqno_reset = reset_time;
 
@@ -1210,16 +1210,18 @@ static bool batadv_purge_orig_node(struct batadv_priv *bat_priv,
 {
 	struct batadv_neigh_node *best_neigh_node;
 	struct batadv_hard_iface *hard_iface;
+	unsigned long last_seen;
 	struct list_head *iter;
 	bool changed_ifinfo;
 	bool changed_neigh;
 
-	if (batadv_has_timed_out(orig_node->last_seen,
+	last_seen = READ_ONCE(orig_node->last_seen);
+	if (batadv_has_timed_out(last_seen,
 				 2 * BATADV_PURGE_TIMEOUT)) {
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Originator timeout: originator %pM, last_seen %u\n",
 			   orig_node->orig,
-			   jiffies_to_msecs(orig_node->last_seen));
+			   jiffies_to_msecs(last_seen));
 		return true;
 	}
 	changed_ifinfo = batadv_purge_orig_ifinfo(bat_priv, orig_node);

-- 
2.47.3

