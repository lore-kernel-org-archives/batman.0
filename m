Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E3A4C6FD1F
	for <batman@archiver.kernel.org>; Fri, 29 Mar 2024 12:36:13 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0848B81BBB
	for <batman@archiver.kernel.org>; Fri, 29 Mar 2024 13:36:12 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1711715772;
 b=xuHMVrc60YC7JC6hepDMRuCnJCvOtr8qaFeWTI9KIreZRcUMncoKeJr/jc2MIcqKvUOj5
 Fjuvgw8giuG73s0Vw7lxqNRtpxw9FMhcLNgVZpYLrmmSioyNUybUL7CsDCyKw83Yauho5Qh
 sT/H6sQxdQd2APSCJ/MeQ3JkbuUWVoc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1711715772; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=6ya6zkkq+Nks90HYQMrC355MTH/dpb2kZQVbF4tSfZ8=;
 b=JsHMVqpE3gkqwcj5xTYGkRHcK8YOpKMWmN2tUiz5ZRGH1OxCdM0AjnqpiVm30/aMLXE/O
 UZndYHf1t7RpmeHF2u6RFXsEKbzGN/MsaNmHtPaPf53i3QD8/rvq15qseRNUeFXTrdlJ0g4
 WZgc2F/4NhSVx7pe7puXvPzVoRv4a68=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=kernel.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=kernel.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=none
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 0D39481B86
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 29 Mar 2024 13:34:11 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1711715651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=6ya6zkkq+Nks90HYQMrC355MTH/dpb2kZQVbF4tSfZ8=;
	b=OW6p8KoqhRT5lWNmVnXqMnORG2wGyi6dWkyzOhe+JsSyF6pcwStfIc2Vkqn/uCE1OqHQfZ
	M2GdNDhzS/2ia4vYIzSTOJtuRkGfmmX+mI0/OnTRz1TMke5DthVfJ0qfOb4DmVVSGW7jNP
	e7jTdmFIl/FK3nHgJH9lZD2DnuvACeE=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1711715651; a=rsa-sha256;
	cv=none;
	b=fzz33v2EtjTfroaRJMRuVFuIPAB9bvR+Bw+ZBdN+LDmbUE2unNZyhqg3O/OeYkItxDZiDA
	VPfFQRQvms6g03dzU33fPtplVLk+dhZ9+co44S/6IJjp53OBl00J9eWx1xkbZscX84Vfxy
	C4BQLFaUyD9DZlaLWNSxEIxY17L0bQE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b="u2CEx9/D";
	spf=pass (diktynna.open-mesh.org: domain of sashal@kernel.org designates
 2604:1380:4641:c500::1 as permitted sender) smtp.mailfrom=sashal@kernel.org;
	dmarc=pass (policy=none) header.from=kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E70986192C;
	Fri, 29 Mar 2024 12:34:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27295C433F1;
	Fri, 29 Mar 2024 12:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715649;
	bh=ngA1S56fgzcWt9CzGHE2qExRw9dEtWMwtZCbwyJXCe0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u2CEx9/D8CzOFIPzEHEoE7DVDSoRN8Qz/pet3/g082hX2xebWfse1oj3MmNUxe4At
	 /vT8zn4ofL3bPSqtwHrqu+x854ipge8Wzo01+QOroZN/Fs1tD3VG4WGOGF3m6Jv6l7
	 0utck4cr4eNPESz2ayVJofsjcM4nubicjvb7zFc8dxN7JBBclfZEgwuQu6Jm2kQlQw
	 4dnqkyW7Vnt3hDwudSl+B+Ca7AjqWlKMefZwRPT3iwYyHdNn7MwXeoOZ1LGIFxP91/
	 aedrLTxTMFVnOUBcicH9fD/Ezean+PIYYxxkCwqVI8cKWfw2thYyu0J7kjtN7Na5HV
	 GSOi6SNcRar1A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Markus Elfring <elfring@users.sourceforge.net>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Sasha Levin <sashal@kernel.org>,
	mareklindner@neomailbox.ch,
	a@unstable.cc,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	b.a.t.m.a.n@lists.open-mesh.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 03/17] batman-adv: Improve exception handling in
 batadv_throw_uevent()
Date: Fri, 29 Mar 2024 08:33:42 -0400
Message-ID: <20240329123405.3086155-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123405.3086155-1-sashal@kernel.org>
References: <20240329123405.3086155-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.214
Content-Transfer-Encoding: 8bit
Message-ID-Hash: FVULCWIH3UPT5EKWGUHRUZ46ZTCM4CV5
X-Message-ID-Hash: FVULCWIH3UPT5EKWGUHRUZ46ZTCM4CV5
X-MailFrom: sashal@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FVULCWIH3UPT5EKWGUHRUZ46ZTCM4CV5/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Markus Elfring <elfring@users.sourceforge.net>

[ Upstream commit 5593e9abf1cf2bf096366d8c7fd933bc69d561ce ]

The kfree() function was called in up to three cases by
the batadv_throw_uevent() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

* Thus adjust jump targets.

* Reorder kfree() calls at the end.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Acked-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/batman-adv/main.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 9f267b190779f..ac3ebdba83040 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -732,29 +732,31 @@ int batadv_throw_uevent(struct batadv_priv *bat_priv, enum batadv_uev_type type,
 				  "%s%s", BATADV_UEV_TYPE_VAR,
 				  batadv_uev_type_str[type]);
 	if (!uevent_env[0])
-		goto out;
+		goto report_error;
 
 	uevent_env[1] = kasprintf(GFP_ATOMIC,
 				  "%s%s", BATADV_UEV_ACTION_VAR,
 				  batadv_uev_action_str[action]);
 	if (!uevent_env[1])
-		goto out;
+		goto free_first_env;
 
 	/* If the event is DEL, ignore the data field */
 	if (action != BATADV_UEV_DEL) {
 		uevent_env[2] = kasprintf(GFP_ATOMIC,
 					  "%s%s", BATADV_UEV_DATA_VAR, data);
 		if (!uevent_env[2])
-			goto out;
+			goto free_second_env;
 	}
 
 	ret = kobject_uevent_env(bat_kobj, KOBJ_CHANGE, uevent_env);
-out:
-	kfree(uevent_env[0]);
-	kfree(uevent_env[1]);
 	kfree(uevent_env[2]);
+free_second_env:
+	kfree(uevent_env[1]);
+free_first_env:
+	kfree(uevent_env[0]);
 
 	if (ret)
+report_error:
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Impossible to send uevent for (%s,%s,%s) event (err: %d)\n",
 			   batadv_uev_type_str[type],
-- 
2.43.0

