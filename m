Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11FA606A31E
	for <batman@archiver.kernel.org>; Tue, 24 Nov 2026 21:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=MFoLqrVA
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5D9E384036
	for <batman@archiver.kernel.org>; Tue, 24 Nov 2026 22:13:21 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795554801;
 b=Pqk5GDLca+Yu0yuvWiDnN3sgbg4B6BiHrRoKK+8lbsdfyrILJo4leRv8cO8eFsqEoNMER
 4rtjqmejMa30iYrBe/NjBe5kVR4FxmapLjWp+kTbO0qJQ4euCSxKsuS54DgMAQznYDoqU7f
 L214lbIdWSQz5oJNKuscsbZjzeINCMU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795554801; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=kON8j0CoM3VuAZP+z0ErB5aMjVyc1wpfelxMuT67lqs=;
 b=wGyY+62f5mQl4WsOcoCh9CXfrVPh8K1L+W08Mhwj4hoXDF+BSKxj2EY9e4w+roZMHLW1D
 9TFrC8xB+nQWtom46UBbrUSsLb0YgdRJ2KIqjUwCqKKlaHpuvOGeg9/1D85nu+xNFhWwnhF
 qeIDVl2GBUhvghBP95NUQGz8cjFm0NA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 8973382745
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 24 Nov 2026 22:12:13 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795554733;
	b=N1Qvy5ABJKEgpO733SJp05lKtNDiEk176NdbnwvDuLDIpN3DciuXpVFG04GFoKxpje2kaD
	r9gPRJ4aYw3rJ5XFFHDplhTxoQGGeBj+4hPo2cZ1/mJHI3FrG+ydkt009TsuPmNLB98L+1
	41Tk9xcUTchlz8FbqVV9t7xHBGpba/o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795554733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=kON8j0CoM3VuAZP+z0ErB5aMjVyc1wpfelxMuT67lqs=;
	b=pS8+VGWLUrWWMsMYowOqyMEogsYUQvy7lh7exA0qRP46Yox/ybrbAwbdWzHGqIS9T+1K/R
	DnTKds3CeFeVkJRx9GpKq4H+arjLf5+r1ZCSWbAAncbeFhJJESAkkOTs2LXSkjcE1Wbvqr
	01zmEFGP2Wy1/yl305wkkWRWG+nkELo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=MFoLqrVA;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 4B28B2040A;
	Tue, 24 Nov 2026 21:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1795554733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kON8j0CoM3VuAZP+z0ErB5aMjVyc1wpfelxMuT67lqs=;
	b=MFoLqrVAWw/CA+BQTUA3mxvNtZKAZRA9CtHow6TNxQDJWTn4ZuogS/jXuEUzUELOFeZJQD
	VKvjts8E13QvIqtvFAHJ0/fLdU/HoVUKKouKNoBy/XVhXyHKC7LGB6myY8A5IR9tlWM23e
	PiLE5q27312LJNGQ6zyfzYv5uW35DEk=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 24 Nov 2026 22:12:06 +0100
Subject: [PATCH batadv 2/5] batman-adv: tt: clarify uncounted state of new
 local entries
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-sashiko-kdoc-2026-11-24-v1-2-27282884274f@narfation.org>
References: <20261124-sashiko-kdoc-2026-11-24-v1-0-27282884274f@narfation.org>
In-Reply-To: 
 <20261124-sashiko-kdoc-2026-11-24-v1-0-27282884274f@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1964; i=sven@narfation.org;
 h=from:subject:message-id; bh=rwGPgJ28wSaUB9rj71kNTg9Nfk/x/kHe0USyzvbLEOE=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDNmsf5fZpYm+arshYxDsVxtTxMtR6djD41GbHcr4aq3Wv
 uNuutM6SlkYxLgYZMUUWfZcyT+/mf2t/OdpH4/CzGFlAhnCwMUpABM5acTIcF0qRYpp91Pn3Xab
 JVyU7QKuMXOK3ky5rhnJpPF5xWmLuQz/XWUyWpqZDWVbJjumXkjbdudAluiK0O18NQWhars3pKW
 wAAA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: BXJGXGVAOZZ7KBDJOSGWE3D6FACKO3P2
X-Message-ID-Hash: BXJGXGVAOZZ7KBDJOSGWE3D6FACKO3P2
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BXJGXGVAOZZ7KBDJOSGWE3D6FACKO3P2/>
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

The comment in batadv_tt_local_unhash() states that an entry with
BATADV_TT_CLIENT_NEW was never counted. But batadv_tt_local_commit_change()
can bring an already counted entry back into the BATADV_TT_CLIENT_NEW state
and uncounts it. The flag only means that the entry is currently not
counted.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261123171827.3294525-2-sw%40simonwunderlich.de?part=13
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 82eadd73..a436c39c 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1949,8 +1949,8 @@ static void batadv_tt_local_unhash(struct batadv_priv *bat_priv,
 	hlist_del_init_rcu(&tt_common->hash_entry);
 	atomic_inc(&hash->generation);
 
-	/* An entry which still carries BATADV_TT_CLIENT_NEW was never counted
-	 * and must not be uncounted here.
+	/* An entry which carries BATADV_TT_CLIENT_NEW is currently not counted
+	 * because its ADD was not committed yet. It must not be uncounted here.
 	 */
 	if (!(tt_common->flags & BATADV_TT_CLIENT_NEW))
 		batadv_tt_local_size_dec(bat_priv, tt_common->key.vid);
@@ -4744,7 +4744,8 @@ void batadv_tt_free(struct batadv_priv *bat_priv)
  * it.
  *
  * The caller must hold the hash bucket list_lock and the flags_lock of the
- * entry. It must have checked that the entry is still part of the local table.
+ * entry. It must have checked that the entry is still part of the local table
+ * and has to drop the reference of the hash after it released the flags_lock.
  *
  * Return: true if the entry was unhashed and the caller has to drop the
  * reference of the hash after it released the flags_lock, false otherwise.

-- 
2.47.3

