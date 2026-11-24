Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D9E606A31E
	for <batman@archiver.kernel.org>; Tue, 24 Nov 2026 21:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=jH7T/pTE
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D7B8A80D1C
	for <batman@archiver.kernel.org>; Tue, 24 Nov 2026 22:14:20 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795554860;
 b=dnx/ZlhMFbJ+TZ20MTBMcKmncUO07/g45LByXH2DKj9kapy260kDymfrauYSl3FMYDr4P
 /Qjx7i7CQIAJBSDuyrjp3SfjIIwplYTI93oS0daKL0glMDjDB7qbR2FndI1bKneyKp753mV
 M9JkgCK2ZtB90fABS7AIlbjiGXF3HZM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795554860; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=HR26081relviTFoxfPfd1h1A8qxKie49cpyGP9BYkc0=;
 b=jR9d5H2xbmjyI/g+a8/E0bUQUSudYnF16Qf4LHADuE3vT+0jSPxNsqdUgjrS0emB1EA0a
 X+6H2KSmayCBpnNjPjvpCvsfh0m9RkuKlCTeth657+zIbFqLgjjAw4yn24s3NGLoa2HD68C
 Js7PoubQRUVDFiRqHHZ5EYoGYEadQcE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 284A5830EF
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 24 Nov 2026 22:12:17 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795554737;
	b=SpjDXGopIcy2s4GebSf8tLA3xopZ7zD0/EqDW0z+EsUFr/dAfFxw1//xIIqyJl93fsbeOj
	jGNBYPQxleIEzr4kkIg6SWFxfrTyQIMMu6/TIBjKHttCMN0gnSuDnItBQLwDcmzBl7ME1G
	OyFdsfTuGOPMqCrUMlqiyLxv91OOtlU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795554737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=HR26081relviTFoxfPfd1h1A8qxKie49cpyGP9BYkc0=;
	b=c8aJGw988dp22JfU+4hIJtZ2B0qlhQAlEo+7iUa1gTvr3FgkwRf6UxPRHr+dyAbB0mzxRd
	14wVncIrlxn8xUK26uHi6gT66168AlAt+BUPUaz3IzKyZ5q+bM4gl8P/e24TyLaQ8Lw2oa
	NbSsbm5n0VnU309eLfdSH5Qg5D5SZsY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="jH7T/pTE";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id D92B820462;
	Tue, 24 Nov 2026 21:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1795554737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HR26081relviTFoxfPfd1h1A8qxKie49cpyGP9BYkc0=;
	b=jH7T/pTEw+r5ZHu4b251oOJlVbLBbGttIVqvlupy2QtYyOeGO/qCQBwqRX+UFlxKiFETvD
	1v8EAf33//qsDpElaJqdI3NNQAA8caHtoN9TSHGQo4mAv2uti/hryy/+26uVVymbY6gDoy
	dH1y2E/HlYunHjS381pFiWm4ixTtl9A=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 24 Nov 2026 22:12:08 +0100
Subject: [PATCH batadv 4/5] batman-adv: tt: document immediate removal of
 unannounced local entries
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-sashiko-kdoc-2026-11-24-v1-4-27282884274f@narfation.org>
References: <20261124-sashiko-kdoc-2026-11-24-v1-0-27282884274f@narfation.org>
In-Reply-To: 
 <20261124-sashiko-kdoc-2026-11-24-v1-0-27282884274f@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2875; i=sven@narfation.org;
 h=from:subject:message-id; bh=MDiAtFLjbSBANdJ8zGGcucB7MYTR8Z766QWkzGq6mWg=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDNmsf5ddEFmR+kT2seal6T9udHkdujDP99lZFYnDM3rL1
 e9MOH3OvKOUhUGMi0FWTJFlz5X885vZ38p/nvbxKMwcViaQIQxcnAIwkVW7Gf5Zt356/OzaqRKD
 32/4mRK6JD5v+fRhcuzhjuqFVl95mDmPMvxm/142Qflxc4He4dzlk29q6vemGpaqH14gkvu8RpE
 7dSIDAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 43HYZX42DNI6S6H73GMFKE4NUYENRCER
X-Message-ID-Hash: 43HYZX42DNI6S6H73GMFKE4NUYENRCER
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/43HYZX42DNI6S6H73GMFKE4NUYENRCER/>
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
 net/batman-adv/translation-table.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 7de69a30..d69e5380 100644
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

