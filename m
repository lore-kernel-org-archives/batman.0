Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21C8606A31E
	for <batman@archiver.kernel.org>; Wed, 25 Nov 2026 19:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=XrW9AvCk
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4BD6A832BF
	for <batman@archiver.kernel.org>; Wed, 25 Nov 2026 20:43:22 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795635802;
 b=jTyQGD68Syss1a9rCGky+Kt4SOWI/xdZ2pSC9CgSrGa6jD2L0UoGc9DENOzsi8eUFAJ8n
 KSY6ZGHY1rQfN5mJWMS68AcPTzw01iYCxkDsFg3PU5Om1qYDjk2uJy/VKbSg5r5ejUOEw5B
 m4yNeWxP2h63CgFZOTnVf6WE+8BAE0M=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795635802; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=rIcmkjdY/Qa/FuCB9PKw/T/z5f9EaLkKNYxyNFleTSs=;
 b=ibFSvH86OUqydOonlPKHbOyxpQnvRueUhqXLz0N6CLN7dH3KzODfjby6wv0Fm6BwhQkrg
 EYin3ByzILvJUXM3knjqjD/I24YPGCcoKzP0U4D/ezIsst04vw/cUHx8auJeIaKckzSLKmk
 K3H5JvSTPeqk/1+JkGgnNB6Y0iKH/0Y=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id DDD9E80479
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 25 Nov 2026 20:42:03 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795635733;
	b=JoczeONJ75GU8F/TvhAtPOheenOqH80c1/ViK/Z/araA4o+PFC83PsTmWRmUm2xTUPHr5h
	0IEQohtciZ6ER5/+LeKfgg2BlS72SpecgjwVrT8T2PJBGAsTuLfBdBAS+vddDJ+1DWAWbI
	EKYoECE5tKd/oRUzVjRXUzgv7nAAEGc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795635733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=rIcmkjdY/Qa/FuCB9PKw/T/z5f9EaLkKNYxyNFleTSs=;
	b=hFJiOK8KBtlxgW552X2sObvY80txHBiL6gG5+/oMAxfhz63TctV6osSP2AIRY/67cnSUss
	/HXL4hgsFKW8b/5xz3FTQmAsHf+AbNsJa9O8SDaAfov3BkbCNiOVDbqu/NeMtziNX6QAWt
	OCcm/gRVLNloZTZguebZrfjvnCHKHUc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=XrW9AvCk;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 79237206AD;
	Wed, 25 Nov 2026 19:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1795635723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rIcmkjdY/Qa/FuCB9PKw/T/z5f9EaLkKNYxyNFleTSs=;
	b=XrW9AvCk30ZAr7547pmyW5Hr8utA5lmrYOxLJAv28AWfHxIGa8OxFVp/hYe5eUrpQbtV6w
	W+PSUvURIyTVKzw6hXf5i6CZM7I4SNR43uBAO7vL/yeFnThPksGAUfD583APcO31/bd12+
	cgQC62OF0+zySptMbfKMcSrluY54AgI=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 25 Nov 2026 20:41:56 +0100
Subject: [PATCH batadv v2 1/5] batman-adv: tt: sync requirements of unhash
 helpers for local entries
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-sashiko-kdoc-2026-11-24-v2-1-d26231bfcbd3@narfation.org>
References: <20261125-sashiko-kdoc-2026-11-24-v2-0-d26231bfcbd3@narfation.org>
In-Reply-To: 
 <20261125-sashiko-kdoc-2026-11-24-v2-0-d26231bfcbd3@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1505; i=sven@narfation.org;
 h=from:subject:message-id; bh=0/JAa6bPQff7cTesCH0R6HqYjriOKY/yMhco7mIbELo=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDNnsVqxSsk0rLVNFODc4c7BNP+lxZVLUvwuBq+a92L3j5
 Qm/mVGrO0pZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATWVzI8D9mZUlJamKAzvEf
 BeLmBiK3JWve/a3NnyioJiIV9stEm5Xhf4VP9B0zqeQNS19YXfkf/0Dm28OL+eUTNbzVmV6sz7v
 /nxsA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: EPFLO5EDP33PMFKFTYDYO6G2DESCRIJC
X-Message-ID-Hash: EPFLO5EDP33PMFKFTYDYO6G2DESCRIJC
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/EPFLO5EDP33PMFKFTYDYO6G2DESCRIJC/>
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

batadv_tt_local_unhash_pending() removes the entry via
batadv_tt_local_unhash() and therefore inherits its requirements. But its
kernel-doc only asks for the hash bucket list_lock and the flags_lock.

Sync it with the kernel-doc of batadv_tt_local_unhash(): the caller must
have checked that the entry is still part of the local table and has to
drop the reference of the hash after it released the flags_lock.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261123171827.3294525-2-sw%40simonwunderlich.de?part=12
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index e08bf88b..82eadd73 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -4744,10 +4744,10 @@ void batadv_tt_free(struct batadv_priv *bat_priv)
  * it.
  *
  * The caller must hold the hash bucket list_lock and the flags_lock of the
- * entry.
+ * entry. It must have checked that the entry is still part of the local table.
  *
  * Return: true if the entry was unhashed and the caller has to drop the
- * reference of the hash, false otherwise.
+ * reference of the hash after it released the flags_lock, false otherwise.
  */
 static bool
 batadv_tt_local_unhash_pending(struct batadv_priv *bat_priv,

-- 
2.47.3

