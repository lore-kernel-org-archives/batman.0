Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D7C4C6FD1F
	for <batman@archiver.kernel.org>; Fri, 29 Mar 2024 12:33:33 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id AD2D581D82
	for <batman@archiver.kernel.org>; Fri, 29 Mar 2024 13:33:31 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1711715611;
 b=HyILQG1Y7xLjWbKOPUILHVCliScTvbfr7zTSkAkba4rrZZRpDEsj5QCNrT3x6z4sr8MwO
 kDg8156GjY9wT9P4mW28I5qQ4WnJuXOMO4yR+K9wpawP0R/RvrvGw7ooXG8BkiRVlGJOFvC
 wN0mHHHpeqIJdmTGdAmasq+F+Zv8nuw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1711715611; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=yDzh2VsZNayAFsdVImoll1H1wFZAkzrKoNsx2LMKx7Q=;
 b=NNKmoefDVWtz/JQQaA6x6StQpr6daat/AgMavyGi9+zdZbqlN+5h3izMf5jqDJiGjL9W7
 SLB0oJKu1+Y3aiv8ec5mPyrx5toEWKbE8lBCafOR2J3LjxMR4PXKc2dDillUOh+/LkI0ZnA
 pHNOAtb2s+7wEs1Ic9QffamiFBesOL0=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=kernel.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=kernel.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=none
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id C3B5F8160D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 29 Mar 2024 13:32:15 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1711715536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=yDzh2VsZNayAFsdVImoll1H1wFZAkzrKoNsx2LMKx7Q=;
	b=oUYYtI/UmKbXVTqOczAs60514ZxDLEi8F+UYfTGFyzyrPnKO5phfnEQUN13P45tUgGldcm
	M412tvZizOHI95oOtdv+d6AFqgTvSDRzqcuAAehRPqh+zpX3nhLgJFPC7si9J/EwrJ8tEy
	lxyMoDzqMZoW2vTkygUkHz4n+HCbdFU=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1711715536; a=rsa-sha256;
	cv=none;
	b=JdXxgzCk07jDkAeKp6NMgZLgl8zJ23JQwtxL4i+dw/5Zy9+YlGt3CLAzHqrMYyTGzq0DA+
	l6nzmL0cXYDDkxAtzQqev98PQobBOKcT7Df7++arQVAF03vrTwqTv4alXP1ksC/DELiBnK
	Tz7Ovsn/KoO2VjrJBjmr7cpj8X0arJo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=KO+xz6iG;
	spf=pass (diktynna.open-mesh.org: domain of sashal@kernel.org designates
 2604:1380:40e1:4800::1 as permitted sender) smtp.mailfrom=sashal@kernel.org;
	dmarc=pass (policy=none) header.from=kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 1A2E2CE2F76;
	Fri, 29 Mar 2024 12:32:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD6C2C43390;
	Fri, 29 Mar 2024 12:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715533;
	bh=S82mcnLoAgLHLLUc/tmsd7zTZGwm1HRCO6vTX9LS/lk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KO+xz6iGzGYExW+tc6fK9ZjqI2Til+gK25fmCjCK4mIVUX0N+Y9Oi6HJPOpCMRUgm
	 Q+RQ2eOhzLyGeaOhd5aa7HpPh+DHpLOPp9TsmrZ9PP6cJsc3tbOJLRwwy+RCixZapm
	 06226FlibBUvBXMf/0yHaZ0z7Jv0KfBW+ipVRJ9+1VdcjjpT8iY30FCgrKctx5E0aj
	 u2rouCRFNly7ypEWAE2zv2jqJkJORozsir9L5y6Q3eG0OpTkytvMUi4djBr0fXQaBO
	 8Q6NQPfnWHve8N2Kc84i3+JzjOkxcqY3Etz2Aa2+bafhcHgvejs0EtzgORc2A+omyr
	 4HCUr9KRNwj1g==
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
Subject: [PATCH AUTOSEL 6.1 04/31] batman-adv: Improve exception handling in
 batadv_throw_uevent()
Date: Fri, 29 Mar 2024 08:31:23 -0400
Message-ID: <20240329123207.3085013-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123207.3085013-1-sashal@kernel.org>
References: <20240329123207.3085013-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
Content-Transfer-Encoding: 8bit
Message-ID-Hash: IZWIX5UFAIVOXQLZG7BEYSQVUPHLTWSC
X-Message-ID-Hash: IZWIX5UFAIVOXQLZG7BEYSQVUPHLTWSC
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/IZWIX5UFAIVOXQLZG7BEYSQVUPHLTWSC/>
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
index e8a4499155667..100e43f5e85aa 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -688,29 +688,31 @@ int batadv_throw_uevent(struct batadv_priv *bat_priv, enum batadv_uev_type type,
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

