Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D8A606A31E
	for <batman@archiver.kernel.org>; Wed, 25 Nov 2026 19:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=2UZHOI9Y
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0028183AAD
	for <batman@archiver.kernel.org>; Wed, 25 Nov 2026 20:44:58 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795635898;
 b=sKBszEgtGY84RsV3yGfqV+C7jpWHLaBZWmCkzx3YluGCFHAU2edJia1nD9ZMnkD5uje4h
 yylS54V/CjxE0ahx6uFcWpKLrDGPGm3Jh9VFu/iGqEOZiFxZhDf5aU6VFpg1QCUBeniMggG
 wthZfLE7y9u7IKxxR2cNb8193/iLF5Q=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795635898; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=pHUNf8hrZY3VlcvsCEwdvH9NJek6PhGwzRDwh0/d+6c=;
 b=Putq89KwwpQfPNs580Dub3SoMNxMafjvWFzEmb4eFUDELy1F5m8DGC7q/7hwgNlIXM4ZJ
 3+l7Ow1XYZardvkOXE/moufXCl72rdyDsomktS/iaOLtsxRf6grxK0eW7wPRpA2exZTYqUm
 JIs5E2Yrfg/xU4D6urAk3y2A2ReMhrs=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 36EE08225F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 25 Nov 2026 20:42:10 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795635740;
	b=X4/mYE1NO+aT2Kx5DMQzjdjNhD0Y6HTJ23a++NIMj3rslcDTF4IBPzHNYXtKLtElac68ok
	XR4pDBi2s/Cv7DijL3aJqJR5olCX2BDVvGA+1m4M0YgvxX8YjTU5uTgoCugPlTiDhLlXg3
	Ed8AIFlfnIpm3KBtJqHnIlhSy1doGSw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795635740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=pHUNf8hrZY3VlcvsCEwdvH9NJek6PhGwzRDwh0/d+6c=;
	b=VfcO/iKxaLPFCrgnpaEgyTAmbMY85M6wo9a9ZN/65/dkX8vpqobs8EUOBhVq+weo6w1RtU
	C4Cvcp7j0UxDPYe7GM4u7kYThMwAxslz/AE4DrxY29NPTNTpb/CBz18/xKaz/+2+DytJ1b
	HOXJNuXMYQKNuBdTZOuuqnuvwTacbdY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=2UZHOI9Y;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id CB77120FC8;
	Wed, 25 Nov 2026 19:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1795635729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pHUNf8hrZY3VlcvsCEwdvH9NJek6PhGwzRDwh0/d+6c=;
	b=2UZHOI9Y/Nank1bG5il7+3fF7eMEVt2buxQV4NKGTem1pR6lo50XhsQy62tpTM+IWOSPkM
	ResrmjkJaurhmGy6nWYyM0Jwas0Y1dk9Z1G/0ECK8QRd1EyzxaMixLMAXbHP+hm/xrreLH
	GP4AvLvffErpzmqp921sdDYIR5jGaUo=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 25 Nov 2026 20:41:59 +0100
Subject: [PATCH batadv v2 4/5] batman-adv: tt: document immediate removal
 of unannounced local entries
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-sashiko-kdoc-2026-11-24-v2-4-d26231bfcbd3@narfation.org>
References: <20261125-sashiko-kdoc-2026-11-24-v2-0-d26231bfcbd3@narfation.org>
In-Reply-To: 
 <20261125-sashiko-kdoc-2026-11-24-v2-0-d26231bfcbd3@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3271; i=sven@narfation.org;
 h=from:subject:message-id; bh=luNBiwnyZesvvAhs1w6XSMtNTCgNRFw4dv7SYPp+Ss4=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDNnsVqz8L53uuZav1ei2nhPxcP/pGz/+e16tffFofmnd3
 rz3JquyOkpZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATMWVi+J9bu+VwhXPIo5bM
 sL/xc3meCx6OWtbGrlqd8Jj5ZGnExSiG/wn3/Kc/33r2Snkbm4cn58cX3a6TDsjkWz/VENVNETf
 7zwAA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: AIMEH4VTDRREBCOXPRSRFKVZTLLS2AJX
X-Message-ID-Hash: AIMEH4VTDRREBCOXPRSRFKVZTLLS2AJX
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/AIMEH4VTDRREBCOXPRSRFKVZTLLS2AJX/>
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

A DEL for a local entry whose initial ADD is still queued cancels the ADD
and batadv_tt_local_set_pending() removes the entry from the local table
right away. But the first paragraph of its kernel-doc still states
unconditionally that the entry is kept until the next TTVN increment. And
batadv_tt_local_remove() is still described as only logically removing the
entry.

Limit both statements to entries which were already announced to the other
nodes and mention the immediate removal in the kernel-doc of
batadv_tt_local_remove().

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261123171827.3294525-2-sw%40simonwunderlich.de?part=15
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 46c0c1dc..a068ac8d 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1964,8 +1964,9 @@ static void batadv_tt_local_unhash(struct batadv_priv *bat_priv,
  * @message: debug message describing the reason for the change
  *
  * Schedule the TT change announcement and set BATADV_TT_CLIENT_PENDING on the
- * entry. The entry is kept in the local table until the next TTVN increment
- * so that a consistency-check response can still be answered.
+ * entry. An entry which was already announced to the other nodes is kept in
+ * the local table until its DEL is committed with a TTVN increment so that a
+ * consistency-check response can still be answered.
  *
  * The entry is also marked as BATADV_TT_CLIENT_PENDING when the DEL could not
  * be queued. The removal must not be lost because not all callers are able to
@@ -2032,7 +2033,7 @@ batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_tt_local_remove_entry() - logically remove a local entry
+ * batadv_tt_local_remove_entry() - remove a local entry
  * @bat_priv: the bat priv with all the mesh interface information
  * @tt_local_entry: local TT entry to remove
  * @message: message to append to the log on deletion
@@ -2106,13 +2107,19 @@ batadv_tt_local_remove_entry(struct batadv_priv *bat_priv,
 }
 
 /**
- * batadv_tt_local_remove() - logically remove an entry from the local table
+ * batadv_tt_local_remove() - remove an entry from the local table
  * @bat_priv: the bat priv with all the mesh interface information
  * @addr: the MAC address of the client to remove
  * @vid: VLAN identifier
  * @message: message to append to the log on deletion
  * @roaming: true if the deletion is due to a roaming event
  *
+ * An entry which was already announced to the other nodes is only removed
+ * logically. It is marked as BATADV_TT_CLIENT_PENDING and stays in the local
+ * table until its DEL is committed. An entry whose initial ADD is still queued
+ * is removed from the local table immediately. See
+ * batadv_tt_local_remove_entry() for details.
+ *
  * Return: the flags assigned to the local entry before being deleted
  */
 u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,

-- 
2.47.3

