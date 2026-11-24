Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8EC606A332
	for <batman@archiver.kernel.org>; Tue, 24 Nov 2026 21:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=hg63tCel
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 06594802A3
	for <batman@archiver.kernel.org>; Tue, 24 Nov 2026 22:14:53 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795554893;
 b=L6xg8+/Xw9d0OfSiFbOo4LE+5d2HVNcqIi7ts/M+em5D1RY/wbQSzNc0SFj/EGE7c3fmf
 xT/QwWFEz+iDaby8Jxh8xzJn8Z8PdRO/w3Z8B655ZQABY65YqU4yZXdpimkYMG/NyT2nXmj
 i/LedgrqQQrqE/pAqJvtyrz4eT8390A=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795554893; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=BZpsyrmCNzbOTsxDMwhimeR6Prs+ySPkBRfXB0cR3eE=;
 b=hs5m8CZ9TNUW5PRVIUOEeweCT4VmSd0kGKXzbiguDddfiFQgkfqXmO8Olo09oXEPt13dD
 cFAxa75C89Zq1fEeRsps9VXW7ffvfFM92UGGLyejTsJDoM1KywY3NGeJSOoydKZlnEmtkb9
 nrHmwqzdggK0aVChcgZnteyW7ltlrfQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id E45E282745
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 24 Nov 2026 22:12:18 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795554738;
	b=nBUPKAyW7WbvP4wjD0Bk9kyoA+ZNj8A23lqBki35IoUtNSnVL9lbRk0srsi8B4DXb4DfS/
	BGdaNwFvos/g+Z3KBVUgPvT5Pv0casUUuTuXIEawgMMmxb2BEmVSLERshIObQU52UfdoZh
	jnk1MABhRkDEHpLLr6UPOr8mDGpx3ug=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795554738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=BZpsyrmCNzbOTsxDMwhimeR6Prs+ySPkBRfXB0cR3eE=;
	b=TDUY/PA96uieXcuojpW5/CWHQCgu2D7EeruZJ2JKfREZY7VY4RTH9+t9J7WQLYEfO9pjDh
	9gro5gr0Di9w95L8v+th7hLZx2YWmlbd6A29WfjDtlQZwOppgOCfHd8e1zQJHDCtO7eEzZ
	HMZY17ywvHFkiB8SRuCpH9c2K37Jvqw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=hg63tCel;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id A112C203E3;
	Tue, 24 Nov 2026 21:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1795554738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BZpsyrmCNzbOTsxDMwhimeR6Prs+ySPkBRfXB0cR3eE=;
	b=hg63tCelXYnMhAuVupbvzK8cvn8khXBZ0bSrURo6O32dYK/ZZVtXS9U+SCv325NHTouf9a
	jUgxSJLKlnSuGXnrq3HCVEbxWnKJI6KewF+T5lIbAA/LGcg29Z48R9WPwx9uL7ce9zPy4f
	v2FZrIlnVq6Y0qVOwYi1h298mfUzVRo=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 24 Nov 2026 22:12:09 +0100
Subject: [PATCH batadv 5/5] batman-adv: unify kernel-doc about refcount of
 returned objects
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-sashiko-kdoc-2026-11-24-v1-5-27282884274f@narfation.org>
References: <20261124-sashiko-kdoc-2026-11-24-v1-0-27282884274f@narfation.org>
In-Reply-To: 
 <20261124-sashiko-kdoc-2026-11-24-v1-0-27282884274f@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4664; i=sven@narfation.org;
 h=from:subject:message-id; bh=zyad9aeYeDxiLfP3kfOQOs1qBpRGHADt+DUhpFXmyTQ=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDNmsf5fdYqhOeGLGfeKhUYqog4ZKiVX0Vues2ycLNkrGx
 Vn8qj/SUcrCIMbFICumyLLnSv75zexv5T9P+3gUZg4rE8gQBi5OAZiIhjgjw61NTlVGGybZrpmt
 d2hXifPNTXfjphnOXrXmEtvDFG+tWUwM/+NEMlckCQSt2cywpmzB/qqLt7ftvb8lxyMjQCVRse1
 zAyMA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: F4URBOFV5XMV5UBH7JUSAIJUIJHJEH3Y
X-Message-ID-Hash: F4URBOFV5XMV5UBH7JUSAIJUIJHJEH3Y
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/F4URBOFV5XMV5UBH7JUSAIJUIJHJEH3Y/>
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

The kernel-doc of the functions which return an object with an increased
refcounter was unified to "The returned object has an increased
refcounter." by commit 07b98ba7d5de ("batman-adv: document refcount of
returned objects"). But the functions which already documented it as "The
object is returned with refcounter increased by 1." were left untouched.

Convert them to the same wording and place it after the description of the
return value like it is done for the other functions.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261123171827.3294525-2-sw%40simonwunderlich.de?part=1
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/originator.c | 20 +++++++-------------
 net/batman-adv/routing.c    |  5 ++---
 2 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 25a3f78a..917bdbdd 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -165,8 +165,7 @@ static bool batadv_vlan_id_valid(unsigned short vid)
  * Return: NULL in case of failure or the vlan object identified by vid and
  * belonging to orig_node otherwise. The object is created and added to the list
  * if it does not exist.
- *
- * The object is returned with refcounter increased by 1.
+ * The returned object has an increased refcounter.
  */
 struct batadv_orig_node_vlan *
 batadv_orig_node_vlan_new(struct batadv_orig_node *orig_node,
@@ -313,8 +312,7 @@ void batadv_neigh_node_release(struct kref *ref)
  *  the OGM should be sent to
  *
  * Return: the neighbor which should be the router for this orig_node/iface.
- *
- * The object is returned with refcounter increased by 1.
+ * The returned object has an increased refcounter.
  */
 struct batadv_neigh_node *
 batadv_orig_router_get(struct batadv_orig_node *orig_node,
@@ -373,8 +371,7 @@ batadv_orig_to_router(struct batadv_priv *bat_priv, const u8 *orig_addr,
  * @if_outgoing: the interface for which the ifinfo should be acquired
  *
  * Return: the requested orig_ifinfo or NULL if not found.
- *
- * The object is returned with refcounter increased by 1.
+ * The returned object has an increased refcounter.
  */
 struct batadv_orig_ifinfo *
 batadv_orig_ifinfo_get(struct batadv_orig_node *orig_node,
@@ -408,8 +405,7 @@ batadv_orig_ifinfo_get(struct batadv_orig_node *orig_node,
  * Return: NULL in case of failure or the orig_ifinfo object for the if_outgoing
  * interface otherwise. The object is created and added to the list
  * if it does not exist.
- *
- * The object is returned with refcounter increased by 1.
+ * The returned object has an increased refcounter.
  */
 struct batadv_orig_ifinfo *
 batadv_orig_ifinfo_new(struct batadv_orig_node *orig_node,
@@ -451,9 +447,8 @@ batadv_orig_ifinfo_new(struct batadv_orig_node *orig_node,
  * @neigh: the neigh node to be queried
  * @if_outgoing: the interface for which the ifinfo should be acquired
  *
- * The object is returned with refcounter increased by 1.
- *
- * Return: the requested neigh_ifinfo or NULL if not found
+ * Return: the requested neigh_ifinfo or NULL if not found.
+ * The returned object has an increased refcounter.
  */
 struct batadv_neigh_ifinfo *
 batadv_neigh_ifinfo_get(struct batadv_neigh_node *neigh,
@@ -487,8 +482,7 @@ batadv_neigh_ifinfo_get(struct batadv_neigh_node *neigh,
  * Return: NULL in case of failure or the neigh_ifinfo object for the
  * if_outgoing interface otherwise. The object is created and added to the list
  * if it does not exist.
- *
- * The object is returned with refcounter increased by 1.
+ * The returned object has an increased refcounter.
  */
 struct batadv_neigh_ifinfo *
 batadv_neigh_ifinfo_new(struct batadv_neigh_node *neigh,
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 821fb5ad..73d9217a 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -538,9 +538,8 @@ static int batadv_check_unicast_packet(struct batadv_priv *bat_priv,
  * batadv_last_bonding_get() - Get last_bonding_candidate of orig_node
  * @orig_node: originator node whose last bonding candidate should be retrieved
  *
- * Return: last bonding candidate of router or NULL if not found
- *
- * The object is returned with refcounter increased by 1.
+ * Return: last bonding candidate of router or NULL if not found.
+ * The returned object has an increased refcounter.
  */
 static struct batadv_orig_ifinfo * __must_check
 batadv_last_bonding_get(struct batadv_orig_node *orig_node)

-- 
2.47.3

