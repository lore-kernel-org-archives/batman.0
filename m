Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CB9606A324
	for <batman@archiver.kernel.org>; Sun,  1 Nov 2026 18:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=bDcaR6iW
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 718F98427A
	for <batman@archiver.kernel.org>; Sun, 01 Nov 2026 19:26:09 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793557569;
 b=HuGzy0pshNCKLhMiln0dqzVtq58ToWcJZM+OiLKDK6KlOt27fgsUYV0b7toSmF9Lpa772
 2M5ezbJa1lmxAiTbhIHwTDfgQmeGrrsMuQqyPk8DE2IS6W19nkKp+7XN+58sjOhWwQGZ/qN
 3qQ6klj8rWeNYX+466OdD6I/UDem80I=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793557569; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=3gc9feQ50L2aA8Z27BCiL16GTcqvn7ZkZFCUO8iImaE=;
 b=zo27HH9Xgm45pPB5i1plLNtMz21S++Yvtr/k+kuko/rwJzVoYnY2EnNpQNQTmEeMmfPW7
 OFe+xBUMK6SS3zuvmeo41pz+pTf+fcZKrJtLf7itDGGVlQYunzjbrojuWOJ/kFjq9Sr7JkQ
 bGLgw18gPidadTbKcws3eolrKtPfTn8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id EF8A682DF9
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 01 Nov 2026 19:25:14 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793557525;
	b=0ap+0Gw5vO+Ai00/EDOwSf3nQF9lUg67M/5PV/TrkqyFMmlgDw9ily1TmAV2O3q0V7PKCH
	1Z46EaXyjL3Ndv2A9nTvLckpHKc2VIrcFInNc0GZzCXX9Dz8967qNABtbdog4/+qpPm1WI
	87BL4v08egFZf2WHKKzcv2kwJIrdYwg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793557525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=3gc9feQ50L2aA8Z27BCiL16GTcqvn7ZkZFCUO8iImaE=;
	b=Ttyr5SrHr35jsnxaSz+FId551IoH+XDQxT2Am+rUnt385BmT7s1U8QjCK1JnajmFxX0o9W
	j8pE/ew2U3e/uOfhhgOv5nLJt5Jgqi4x6qWd/7VafNY/vz9oEhdy0WHjJ196lTeb9CRz5a
	5pd1b3MioE4jMXByRKLl193dpwGB5ms=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=bDcaR6iW;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 5762C21E40;
	Sun, 01 Nov 2026 18:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1793557514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3gc9feQ50L2aA8Z27BCiL16GTcqvn7ZkZFCUO8iImaE=;
	b=bDcaR6iWwkyh/HKAvXuQqSYePODJ1ri6kexZU57LDj9zce/nOYZVWA9gOLqMOyEfqqW1dT
	RXQYA2NyYlbTI0GuO0sOicIv5Uyv4ZHjyCC87kFxTSdx6aU4GkiD31xKrRDdifLie9lX4+
	tkrpyP268VVNh5HHrl8INaLA/iszIDo=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 01 Nov 2026 19:24:44 +0100
Subject: [PATCH batadv v2 1/2] batman-adv: mcast: use mla_lock also during
 mcast_free
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261101-must_hold-v2-1-782bcc7d85fa@narfation.org>
References: <20261101-must_hold-v2-0-782bcc7d85fa@narfation.org>
In-Reply-To: <20261101-must_hold-v2-0-782bcc7d85fa@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1134; i=sven@narfation.org;
 h=from:subject:message-id; bh=NUEh1TtXcrGBCBHpgCM9d7Mu49tJ/iccqV7SF5bwp/A=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnPm789X8mfxiFrXM4o/XnDeqaK1XujkxerfXSOPaS1+
 eW+27I9HaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJiKcy/Hf/zS7X/kF7k+K7
 jowPifvWrty19FWpjBjLlQ0aem7L+30Y/rt9Wfw6vOjeYpN+7zjND4/fh/XyK7m0ntjz/vCMyI5
 HXWwA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 7SCNHBADBNSXFBIGZHBLUZG3YT3ZT3QP
X-Message-ID-Hash: 7SCNHBADBNSXFBIGZHBLUZG3YT3ZT3QP
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/7SCNHBADBNSXFBIGZHBLUZG3YT3ZT3QP/>
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

While it is technical ok to not hold the mcast.mla_lock when calling
batadv_mcast_mla_tt_retract() in batadv_mcast_free(), it is more clear to
always require the lock when calling batadv_mcast_mla_tt_retract(). This
strict + simple rule will later make it also possible to check the lock
requirements automatically via the LLVM/clang CONTEXT_ANALYSIS.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/multicast.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 415981fe..4380241a 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -2184,8 +2184,9 @@ void batadv_mcast_free(struct batadv_priv *bat_priv)
 	batadv_tvlv_handler_unregister(bat_priv, BATADV_TVLV_MCAST_TRACKER, 1);
 	batadv_tvlv_handler_unregister(bat_priv, BATADV_TVLV_MCAST, 2);
 
-	/* safely calling outside of worker, as worker was canceled above */
+	spin_lock_bh(&bat_priv->mcast.mla_lock);
 	batadv_mcast_mla_tt_retract(bat_priv, NULL);
+	spin_unlock_bh(&bat_priv->mcast.mla_lock);
 }
 
 /**

-- 
2.47.3

