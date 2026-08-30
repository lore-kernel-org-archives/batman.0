Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39928C61DD9
	for <batman-adv@archiver.kernel.org>; Sun, 30 Aug 2026 15:30:43 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A551A803D9
	for <batman-adv@archiver.kernel.org>; Sun, 30 Aug 2026 17:30:41 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788103841;
 b=CJsx2ytijpXGxB8L930CcfB7H1sywT3mEI/KgP9MzM5EeQTcchzybm0VgX4zcXl+y7wdQ
 2K72ILBfQfd5xTmcJLajKN2/QGp7PkLYhYqHn+7JFjXqKrxhHHN2HWlGVfehDXzvt3hI1Ni
 oZVYIrPDwyt2shjafHMy9dYSxOlfBu8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788103841; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=qMK8P7hzDgj/WhBJV176Gx7S+y+xdKhK6Wj4BQh6fz4=;
 b=GaL8icZQ4BtbTrq4QdFcBgsZIKQOYLBQZ0Kcuv6tc9USHqt88BsuV7gGdL938Phb1ohGu
 QpjnrvI1Y/uwEskch2LQoGPNS38zy6xCfJnlvI6mNGgU1GIN83RJ/Z5gl38t1kbEGQlXgiz
 Dbrtnhmhe0Zm/z4wh99D2CHFyBvnV6M=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id DD76E803BC
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 30 Aug 2026 17:23:02 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788103382;
	b=XW7jBvTakZyf884pkeMqlMLykysd0Nzt7277NqSlx8Z4SPEiKWO1DJCCdXsOdqsMwEZE9o
	xmslEt/+4Kciy9r1wFF8djYvn0J8bygAMxZQ9Ih64juBbyWNWybewsysczG0PosJfD5a03
	JMe6OTulXlrL6eAw8OtgjVVw9JEsj3o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788103382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=qMK8P7hzDgj/WhBJV176Gx7S+y+xdKhK6Wj4BQh6fz4=;
	b=bSPbGa7z04wvQ5l0gF76gc9iuh4PF/ecDHmhiJKE+S/K2k1twv3qC64iu5sSE92AkXxF/q
	sJwPYzo3iiKSY92eS9qrn6W2L9Yl19M2XZ4pGPrnHhoJYjvneElw/M0rhfYWbEplgNS/ur
	kjK7+YXo5eI+VvOXUVGQCCMJ33+bz98=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=J4eAjFo5;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 72D1D2083E;
	Sun, 30 Aug 2026 15:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788103378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qMK8P7hzDgj/WhBJV176Gx7S+y+xdKhK6Wj4BQh6fz4=;
	b=J4eAjFo5tUMKfHq81QUoEg+FFIOco8kjHxa+Zdo5RTKjp6AICPjIXi3ASKx+xoYL/mCs7u
	WBB4OHMJ/bnJrrQjfsSUmv+BbC090DQWTPqy2bynmvcXU/y9vMXDOZuCTujcIxMx8AKumU
	qDlAJhR0twt2OeYiFG0ctxilgACZCS8=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 30 Aug 2026 17:21:53 +0200
Subject: [PATCH batadv v6 16/20] batman-adv: tt: replace add_orig_entry
 goto in batadv_tt_global_add()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260830-tt-fixes-v6-16-a56568a15041@narfation.org>
References: <20260830-tt-fixes-v6-0-a56568a15041@narfation.org>
In-Reply-To: <20260830-tt-fixes-v6-0-a56568a15041@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1436; i=sven@narfation.org;
 h=from:subject:message-id; bh=B/CQVQQtJgtfvivWQxzovTljX/eu7hknfRNz+sujmCI=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFlTvNpTCn0WT1DiEZ9hvtD6bPp5K1a+xPU3+C3D5Cymm
 BmEh9d3lLIwiHExyIopsuy5kn9+M/tb+c/TPh6FmcPKBDKEgYtTACbyzpThf4KBxeMrz/Nfq6ZH
 55+c//7owTL2R7e127VehpTbfW03PcrI8O3Q4x2rN7VwN1fNKX49nd8iax6jfV1G8M03UTVKAX3
 NrAA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: TOGMQVXI56ZG4LUGGK6XOLAT6HQUEG3Z
X-Message-ID-Hash: TOGMQVXI56ZG4LUGGK6XOLAT6HQUEG3Z
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/TOGMQVXI56ZG4LUGGK6XOLAT6HQUEG3Z/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The "add_orig_entry" label was only used to skip the flag merging of the
non-temporary path. Which means that the code jumping to it and the code
below it are the two halves of an if/else.

Both halves now only decide whether the originator list has to be purged,
so turn them into an if/else and purge the list at a single place.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index deb7c1af..61cafd0d 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -2074,15 +2074,16 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 			if (batadv_tt_global_entry_has_orig(tt_global_entry,
 							    orig_node, NULL))
 				goto out_remove;
-			batadv_tt_global_del_orig_list(tt_global_entry);
-			goto add_orig_entry;
+
+			delete = true;
+		} else {
+			delete = batadv_tt_global_merge_flags(tt_global_entry, flags);
 		}
 
-		delete = batadv_tt_global_merge_flags(tt_global_entry, flags);
 		if (delete)
 			batadv_tt_global_del_orig_list(tt_global_entry);
 	}
-add_orig_entry:
+
 	/* add the new orig_entry (if needed) or update it */
 	batadv_tt_global_orig_entry_add(tt_global_entry, orig_node, ttvn,
 					flags & BATADV_TT_SYNC_MASK);

-- 
2.47.3

