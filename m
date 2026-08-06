Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80700C55ABF
	for <batman-adv@archiver.kernel.org>; Thu,  6 Aug 2026 07:46:37 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C3AD08423B
	for <batman-adv@archiver.kernel.org>; Thu, 06 Aug 2026 09:46:35 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1786002395;
 b=Ma2MiAvFmVk+igDQErFq2nj6X7utV//Jc1OJojYyKfXSpQt9tBWNHpLfN9379Y0WOCx3q
 U6VjocWhE5yBfLS6Vp/L3ZaEjhGQ371Qul8bIyndZiFlTRr1vhVk9sbUR4+pj/x0CSykTIb
 OR6wSh3r/nt6YBV6eKalmdHOs2yvDTE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1786002395; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=xzxCUzaLqnFwe4fXb/py+i2HUhNIWuzUpFMovqxAMlg=;
 b=iYsW2v99Xv2tT8ehUc/IRF5ShUj39ly8OQzjpTuZ/wgf48OdKCBc5ciMQzIKSEmghPK1k
 lzkyXlP0sNv9FyrDlrcKFIaKYwS14VF6CDujsXV4krdeHWanVLDf1KIslanPv0XsKhlk+L0
 5vq6O001m2vHMH176stIh9f/Gb9dj/0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 95B8184266
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 06 Aug 2026 09:42:57 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1786002177;
	b=APF8omem+JyKlueb6TuwVETENrjO91yeJLH9kuaIYkyYsA+bp/8dpBNv2mA9blO/pb8w61
	NX/NHmZdF8TVmWh7Rv3MbvT1okjtLNrT7RhmHUTHPS5Pni+ic3xRXLCgbbN+Au8Rs+ojKK
	bpgdnTE1sjX3DACMOXaK3FCiLt4Nn20=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1786002177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=xzxCUzaLqnFwe4fXb/py+i2HUhNIWuzUpFMovqxAMlg=;
	b=LXfbMqeXq11B/Cq/ty2LHHWyiYKuFexjb0M0n0roakBR0LC8t7zKr8twBzwIZQUFv+DL9H
	Ir76Dk1wKfMxUejRJvkZVnnRVIE0plRaEbmdhmi131oPACgfffz581LF9r5UV1JMzQY7db
	JyAjIkJy+oFCPw9JqSz7N4eQ8lYgcuc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=vm11g5eL;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 2CC19200D8;
	Thu, 06 Aug 2026 07:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1786002173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xzxCUzaLqnFwe4fXb/py+i2HUhNIWuzUpFMovqxAMlg=;
	b=vm11g5eLWUgUMfyQbF4n0p7jtSjWUv2ncUHjKJMRoxzTyvRAnj3ZlApEsyx/BHmvQXG6IS
	S5OhJSYj7g7oWc9E2qMvW2vGDdjO+1UCAzeLkTS1vHjiHrcTyuXWPbUEDTS5Hkw3Jk5/rF
	T9DaC6o3Plt9sQGhs2rV0uUcxdTTcEM=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 06 Aug 2026 09:41:33 +0200
Subject: [PATCH RFC batadv v4 8/8] batman-adv: tt: decrement count for
 committed client on local_remove
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-tt-fixes-v4-8-c2fc871fe807@narfation.org>
References: <20260806-tt-fixes-v4-0-c2fc871fe807@narfation.org>
In-Reply-To: <20260806-tt-fixes-v4-0-c2fc871fe807@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1235; i=sven@narfation.org;
 h=from:subject:message-id; bh=j9+vM6dGx5LhMHpTSO52WkpYj4M819vQMtG7HVOeTqA=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFklVqvXNuX33b939KiLVXJQY4x3qdjnrbz9sTzvAnMOM
 7/hmLKho5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjCRzW2MDP9O++7e3ZZ4Mfhm
 9axp565ZzHh+hDnkyBVm+9IHe+R26VQxMux4n3PKa+KbJCnu6Md3Xwvw8eZy+uquZI3MX5d1dO6
 XZxwA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: FAYCV6PXHKB3TXI7D35FH4RXD6OAWYUR
X-Message-ID-Hash: FAYCV6PXHKB3TXI7D35FH4RXD6OAWYUR
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FAYCV6PXHKB3TXI7D35FH4RXD6OAWYUR/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Local TT entries which have the BATADV_TT_CLIENT_NEW no longer set are
committed. The batadv_tt_local_size_inc() was called for them and thus the
batadv_tt_local_size_dec() has to be called also when
batadv_tt_local_remove() is called for them when the BATADV_TT_CLIENT_NEW
wasn't consumed in the remove path.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index b8aff4ec..bdf5a206 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1476,6 +1476,13 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 	if (!tt_removed_node)
 		goto out;
 
+	/* batadv_tt_local_transition_new() may have committed the entry and
+	 * thus counted it in the local table size since the BATADV_TT_CLIENT_NEW
+	 * check above.
+	 */
+	if (!(batadv_tt_flags_get(&tt_local_entry->common) & BATADV_TT_CLIENT_NEW))
+		batadv_tt_local_size_dec(bat_priv, tt_local_entry->common.vid);
+
 	/* drop reference of remove hash entry */
 	batadv_tt_local_entry_put(tt_local_entry);
 

-- 
2.47.3

