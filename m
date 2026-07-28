Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE0AC54F51
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 22:46:22 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2B63380B7F
	for <batman@archiver.kernel.org>; Wed, 29 Jul 2026 00:46:17 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785278777;
 b=fFUNZAICdBXMTkW8zJqggf5SLtdQm0inBZ/Ox5EyWLP3dUY7fw545IvGw5axxTBhgNvvO
 AJFQEr7GtO+57W8sFW8sJA4JMT6mfdEuzFIxX86z9QZRNw/hm2/ZBuWwgrR4W+VJtGaIG8M
 sMP8iNKLQfdN/a8B9/pY3YZK/k/Az94=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785278777; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=b4YpHldeIVkPM44yJ56xJlj4REPKn+s+ewNjb03voXs=;
 b=wujj9+7l61FTkmHAeHJpWU9pqKwwaUY9hMD9ykhtwnty9HauCbs7T2+l4ibMf+XZJf9Pz
 NfqEXris3GKM4FPAj3AdhZZrzvERK9a1dy4BqQFPI9eH/lLGNaORaenNAg9fPS4UiHUmXno
 z2kIw1nbAMcOrfSPo0iGKr3/G7rIl9k=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 49A9A81044
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 28 Jul 2026 19:29:43 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785259783;
	b=X5SlV2a7d8fcEXCzNt5kdJgVSWA/YRCkojyauQdTSmPuU692f5QpBiz/TQBhXIjVXy0vKR
	wPn2IoYLrVeFrvBEhDUIn5l+WdE6WAcY2iXpbM/eED8p/nkwR3kcWXhk8QuUblFSiZoYz4
	zolgjXKl7S00QtAvdARIKD9bpWVoOSE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785259783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=b4YpHldeIVkPM44yJ56xJlj4REPKn+s+ewNjb03voXs=;
	b=gb3r8tcfS2Zp8II9Cte+RMuagujQItgulvjwwBJXxB61GYNKwSjfk5RQ3q+aUGjLvqW7XB
	NqLrZihNwpgpcInztL4kyz+Xk0lKVsmYLjsifaMzahM7tvKPTmucKwTAtpdwsq7ZdXPo36
	MlOzxxAPMc2YfgCQk48GP1abUWo3NBo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=TzH9p48E;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id D91D7200D8;
	Tue, 28 Jul 2026 17:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785259778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b4YpHldeIVkPM44yJ56xJlj4REPKn+s+ewNjb03voXs=;
	b=TzH9p48EW6dGOiwFmHO29xWISz4kIZK09fuLwYCJ9N8SXDmur+K1IeEoexjEAFxmlNfYoO
	WaJJIRrLhozjurjGkiogiJBK93YtJM1wzyQWFsuwbzAtiSF3Vj1exmwSIogDJaC6xHJ5Bu
	IJZUYLhL8oER1KlSe6I4zdsvAvbRrOY=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 28 Jul 2026 19:26:19 +0200
Subject: [PATCH 2/2] alfred: don't stop translation table dump after first
 entry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-bugfixes-netlink-v1-2-d338671f316b@narfation.org>
References: <20260728-bugfixes-netlink-v1-0-d338671f316b@narfation.org>
In-Reply-To: <20260728-bugfixes-netlink-v1-0-d338671f316b@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1149; i=sven@narfation.org;
 h=from:subject:message-id; bh=Dsm5VnJSDxz5AsZCQpHieXJPkhOv5uf3OmAlJJAF10Q=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkZz6zPLuxNsdi/WcuM1Xx+zIFL3kX3zQv9PF/cf8fLV
 XjfjMu8o5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjCRHbIMv9nbXC3O1Tke7vi6
 pWGZb//+5bEbX15sNilZ++Nq1NKMdE2GP1yzpLhO94Y/qRF6cXThjSKXh+dEeX/JLLHaeXjTrA6
 ZhywA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 3QH4MV4XUHYBJNFSETYHB3OWFLZOXICH
X-Message-ID-Hash: 3QH4MV4XUHYBJNFSETYHB3OWFLZOXICH
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/3QH4MV4XUHYBJNFSETYHB3OWFLZOXICH/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

translate_mac_netlink_cb() is handling the response for
BATADV_CMD_GET_TRANSTABLE_GLOBAL dump. It returns NL_STOP and cause the
dump to be aborted.

As result, the MAC addresses of all other alfred servers could no longer be
translated to their originator address and their TQ was considered to be 0.
The selection algorithm might then not select the actual best originator
for the data sync.

Continue the dump with NL_OK to fill the translation hash with all (best)
originator entries.

Fixes: a7bc3d9a2b3f ("alfred: Cache the global translation table entries")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 batadv_querynl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/batadv_querynl.c b/batadv_querynl.c
index 199fe9d..9e372d9 100644
--- a/batadv_querynl.c
+++ b/batadv_querynl.c
@@ -79,7 +79,7 @@ static int translate_mac_netlink_cb(struct nl_msg *msg, void *arg)
 	tg_hash_add(opts->tg_hash, &mac_addr, &mac_orig);
 	opts->query_opts.err = 0;
 
-	return NL_STOP;
+	return NL_OK;
 }
 
 int translate_mac_netlink(const char *mesh_iface, struct hashtable_t *tg_hash)

-- 
2.47.3

