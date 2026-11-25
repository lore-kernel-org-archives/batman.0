Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32111606A31E
	for <batman@archiver.kernel.org>; Wed, 25 Nov 2026 19:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=NEJFJK5T
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id AEBA482380
	for <batman@archiver.kernel.org>; Wed, 25 Nov 2026 20:42:51 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795635771;
 b=s45Vc+lO7L6zlMvODV31229cxJLKL8ssVTHMzy3tFwhLzbZ7S0MOjIX78MYkeXaAElnBX
 2yz2Nm1qasr7LDz+u8nVW7U4aRBNrOO7JWBDP2nJ87NHgSBD8LZ0BemX3Q4rtEQ15iDlmXc
 zQ1d5b2Qwo+raD1lilS4n0lch7I2XUI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795635771; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=BZpsyrmCNzbOTsxDMwhimeR6Prs+ySPkBRfXB0cR3eE=;
 b=IywBXJXzi1SDjYCEFU2y4RAvJyrPfxBeAZPgdME7ho+Sz0e183wTxa9Bsncjpsoyg97E5
 CQa1rPQs2SidiDjel4ggzA6PdXTaGtNRFG2womciM0CJspNB0kCQSpiUER5+2mKjua8DODN
 OAXogzhrwO+ULfZ3Jc+vX0oMvcyAPcc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 6EABD80479
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 25 Nov 2026 20:42:13 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795635733;
	b=UvlhEo1GdTFNMZYH8yOQQmpumXsV8CloY1rbe9dKC+g0atCQBZdvmkTrsRzQSK0uojgI63
	JgfujzMHpAuGHlX4qMNfMBYFYHX2iy0Jbm30Bjm6CbVB4NF0WvyMGd37g5w3q7wWGuAgAZ
	qSeq48MO9Gmhb6JMpUjlH1PfKWNo2Rs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795635733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=BZpsyrmCNzbOTsxDMwhimeR6Prs+ySPkBRfXB0cR3eE=;
	b=N5YhtDg6senz8mTNpeXlwg8xvKdDJWvoyI/374+3Z2yfn2lFVKDi3PBI/dPp3FRBTDP/ta
	XyhWcmpTjywSL+CbWkrfrfYnT9jPSG8zh4RJBTRA07fNj1fOscF7i/oy26Iaft403OELAi
	aFI1jwqc6eHNyTQx9EqaDKVjJ+0/1Fc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=NEJFJK5T;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id BC70220FE4;
	Wed, 25 Nov 2026 19:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1795635731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BZpsyrmCNzbOTsxDMwhimeR6Prs+ySPkBRfXB0cR3eE=;
	b=NEJFJK5TkMvmeQJaNyDJnKanYBajkOXaLyIsDUNIC3C/VKzr5FxzwaX5I78vqTQzIX6q3D
	4C4m6VJUOt8VDJC9u0T24YsAININqQWzFE6MM6CHynBAQ3nHddhm0ZGM98Os3pRvTT7Soq
	QFnVRRNIOx3Q6AxyW8YEe24klv8WPrM=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 25 Nov 2026 20:42:00 +0100
Subject: [PATCH batadv v2 5/5] batman-adv: unify kernel-doc about refcount
 of returned objects
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-sashiko-kdoc-2026-11-24-v2-5-d26231bfcbd3@narfation.org>
References: <20261125-sashiko-kdoc-2026-11-24-v2-0-d26231bfcbd3@narfation.org>
In-Reply-To: 
 <20261125-sashiko-kdoc-2026-11-24-v2-0-d26231bfcbd3@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4664; i=sven@narfation.org;
 h=from:subject:message-id; bh=zyad9aeYeDxiLfP3kfOQOs1qBpRGHADt+DUhpFXmyTQ=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDNnsVqw7Tk3790XYSvalwluhm4XelRXXmZOrb5d1WNmrb
 hedPuVoRykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAinEsZ/gqLvU/mKzle/dFZ
 PE7HceHi+uf/92Su/D/f5adLu3OmZx7D/+jnDzKNC6caZWXKNFRd/71DYGdDXMBylbz9fkc4uUX
 XcwIA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: DCXUXKEI27B3SXQUVLIVLJY6XU7H5YWG
X-Message-ID-Hash: DCXUXKEI27B3SXQUVLIVLJY6XU7H5YWG
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/DCXUXKEI27B3SXQUVLIVLJY6XU7H5YWG/>
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

