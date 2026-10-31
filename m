Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E301606A31A
	for <batman@archiver.kernel.org>; Sat, 31 Oct 2026 20:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=aBnumxgT
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 36A52823C1
	for <batman@archiver.kernel.org>; Sat, 31 Oct 2026 21:31:45 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793478705;
 b=UvhvmpgQMXIZjXyjJ436+iuVKrbk7C25/BuAHzWljbCqHqQwT4yyG5blGVvNkSuJG63Qo
 dqsHHgNZUhF2SrjX/qqOCipkqzU4WlE3jlq2nV9gQoLHYjkl8InRKMmtJ1pn+YiP7cXJGt4
 QoZiJ0X5EcBiCzDTAe82m2s9b3foqwE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793478705; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Yh2zpkARu2dYJw8n0NKcJySlDZxcV1YWp1C66/CViOA=;
 b=o3rHYuQgytJsHg7lXGUug/yCUXzTEhlz9xGLsBBPJr5NHyGBeqc2xOWzkr3+v6HHNC4EM
 b1npxSA7wQL7/kaVH6DaOvazi8GNS+LQInNPO757ZtJO/k3ui7ImqKMh3QZGRlVyr6Zr28C
 IAnqWlMSomTZBlGsOfwptjQU0lKlxR8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id E5114826A9
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 31 Oct 2026 21:30:37 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793478637;
	b=wZXNrXGxU5dnjBdlqex/BPTnlqk1ukfeKHk5hFyVQTU2eDDfEdb5TKYDkHjygl+myaG5BE
	9lLj2kQ+7Z8Qe7KyQhdfHkJTx86sUIAA17UoEnIknwplKRShxAk/VlL2dc4z7a55wd48dG
	VyGulMcMRN+6H/3tGdHDAgtynU5IL2I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793478637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Yh2zpkARu2dYJw8n0NKcJySlDZxcV1YWp1C66/CViOA=;
	b=at5fT5SVlBFpuvFEV2707FKpu0iko2wQV/GosCOSaoeT5fvKjzgAJVySdaqAZGsUsKia81
	jB9jM+mpBLqqaFXZF5tz+TGbuaB6r2OKo3vVz2DC6kCpDMYlYlia1odZzENUMs1tUbYZ6M
	wPMfeEqoJps3HaexqOZGlgSPauuCYEw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=aBnumxgT;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 9DD3520FE8;
	Sat, 31 Oct 2026 20:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1793478637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yh2zpkARu2dYJw8n0NKcJySlDZxcV1YWp1C66/CViOA=;
	b=aBnumxgTIeEv4K2898AVj2FKUE1H7LP9CsLYbHSY+7+zN9N4T6sBeYaFRxdxOF28JRVDmy
	VK5WiE35QK/vrNfomjzG69kyOj47JZAdCA/HVBw6rk8ozQfhED+MdaOtPY13EHS2I70gWG
	rJ9qh2asMiBMSFdcHeu2K3mozfYyCiQ=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 31 Oct 2026 21:29:45 +0100
Subject: [PATCH batadv v4 5/7] batman-adv: annotate originator last_seen
 with READ/WRITE_ONCE
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261031-dat-last_update-once-v4-5-3f7994b1f5fe@narfation.org>
References: <20261031-dat-last_update-once-v4-0-3f7994b1f5fe@narfation.org>
In-Reply-To: <20261031-dat-last_update-once-v4-0-3f7994b1f5fe@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4848; i=sven@narfation.org;
 h=from:subject:message-id; bh=midRS57uxNeGUztyXXpqzR0QmYdeIp+a57dClA3Qg5c=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnP/He9d7rIna/sw8CT2T9x8rLQi0t4Vkx7sWq/zCFp9
 sMH191e11HKwiDGxSArpsiy50r++c3sb+U/T/t4FGYOKxPIEAYuTgGYyIFFjAynVA5XVm+OKf/C
 vuPg3cvGsat+i0zrOfPl9I+lDKr39y/uYmSY9Nicb+5WdeVTBcmdq6T840KEn67f090+vTz8wJd
 ZAh5sAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: NTWCYA6AKHOFGD6ZIK3JFURB2K4HQUYB
X-Message-ID-Hash: NTWCYA6AKHOFGD6ZIK3JFURB2K4HQUYB
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/NTWCYA6AKHOFGD6ZIK3JFURB2K4HQUYB/>
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

The last_seen field for batadv_orig_node tracks the jiffies value of the
most recent activity and is used to detect timeouts. These accesses are not
consistently protected by a lock, so READ_ONCE/WRITE_ONCE must be used to
prevent data races caused by compiler optimizations.

To avoid an underflow due to an non-strict order read of jiffies vs
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
index 4a25e513..2679090c 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -302,6 +302,7 @@ batadv_v_orig_dump_subentry(struct sk_buff *msg, u32 portid, u32 seq,
 {
 	struct batadv_neigh_ifinfo *n_ifinfo;
 	unsigned int last_seen_msecs;
+	unsigned long last_seen;
 	u32 throughput;
 	void *hdr;
 
@@ -313,7 +314,8 @@ batadv_v_orig_dump_subentry(struct sk_buff *msg, u32 portid, u32 seq,
 
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

