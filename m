Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BFA7C6FD1F
	for <batman@archiver.kernel.org>; Fri, 29 Mar 2024 12:34:53 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id F3B9081C1A
	for <batman@archiver.kernel.org>; Fri, 29 Mar 2024 13:34:51 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1711715691;
 b=WFXGReePK5LrtLZpop3NHiT3+ZnE4pevtZGwgqxeVd4RTGasuJMoP3ArmyjO1Aoo/7hqk
 N6YsUYYTJP4uDWOpgEHSssluCJRuw+aNcuOgs+FBtjs6dgeMXWGMQb5sYGQ3GO42ypeBXr4
 HopP27kvz1aWhG0XRQIpGmiBal3Bjn8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1711715691; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=O03JOfSXD6q16b7h6A+YRH9874SeNqozWH9b/RVPYDY=;
 b=Xulz09xvjE7OspfWY4e6fX+a3IcY5ctdjQB5BKArzq2YMD8NqNbSxMZSMYBoUtnhKfu+d
 u81HlTtroiu/8FZahEFjLufp2oKYPbGLBejJB9dVlOMGl1Wjgj2qzcEn6Sfd7/YnOjKFl1H
 sJ+VlfRDc+O2qtWs8bUpmm5S3arDTmU=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=kernel.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=kernel.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=none
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 7A85C81D2E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 29 Mar 2024 13:33:23 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1711715603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=O03JOfSXD6q16b7h6A+YRH9874SeNqozWH9b/RVPYDY=;
	b=Q+8eKFlKd/n7bu+KoivvkBaduzazA1DJ8m+aKHeNnd0QAJBUgw5Ry29HUeCYB8Vrm0TpNo
	MgrWMaQMrriIDpcQxG9fruBXyzxHe3pH5fuBf9lt83Btz4ASYbCU2Q3XOx9Q+fyYo90QlJ
	JQF3tPB22vZWZjR8xKk15rpQBnzaGDA=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1711715603; a=rsa-sha256;
	cv=none;
	b=vA4G2NK6BV3G1tzRBS4SIIlGUVlKwLatp04Zi48s3qURg+5alf/EKVqwx9Gucn9vyx3ns1
	5rGmNU5kWHBYqSgkrTbIBa2QJxMqyOTnvO3V/Vwh2NZazb+KhOaINXxTjQLUoelG8IbZRN
	qNV0SM0AjSsHEWV4GiEYD7zwsfCQnGI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=qCFBo2mG;
	spf=pass (diktynna.open-mesh.org: domain of sashal@kernel.org designates
 2604:1380:40e1:4800::1 as permitted sender) smtp.mailfrom=sashal@kernel.org;
	dmarc=pass (policy=none) header.from=kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id E309FCE2F86;
	Fri, 29 Mar 2024 12:33:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2CD4C433F1;
	Fri, 29 Mar 2024 12:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715601;
	bh=v9vlpGsCF0nOaHHd6+aP4ocLIoUxn4ByaujqAgwKQ9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qCFBo2mGPTekIUg1yahvAFYM4twUBN7NpFwPpa860KAJYS8uePUKLI8FiI6eb0e53
	 aeJdiebV9ZGz8AF2+Jbf28x4kiu5uEf2OzCGWGueCvJCn+JHHc2y7sK0SWfLR59xmd
	 jqBIRZlI4IjJtSDHo68+VGQNAc6eOJzb6jCn3sxjrP3lfTu1+g39hK96Zb738fF9Nv
	 B/Lc7Hd1fmxqmn/SffYnWXj05Rredv+5ZbeBFrq+0q2wRKQ2ZDI489OvlNL31QDyUs
	 eliOh2GInyOAdj5BL+U2ueWEfWs0eO87IW2KyeMqHDXhNeYVRjNs/48HavZJQugkIn
	 YtrmHMTI9P5sw==
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
Subject: [PATCH AUTOSEL 5.15 03/20] batman-adv: Improve exception handling in
 batadv_throw_uevent()
Date: Fri, 29 Mar 2024 08:32:51 -0400
Message-ID: <20240329123316.3085691-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123316.3085691-1-sashal@kernel.org>
References: <20240329123316.3085691-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.153
Content-Transfer-Encoding: 8bit
Message-ID-Hash: QGQPYSHE5RTRKEGPGSXAMOXK4MPH3TH2
X-Message-ID-Hash: QGQPYSHE5RTRKEGPGSXAMOXK4MPH3TH2
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/QGQPYSHE5RTRKEGPGSXAMOXK4MPH3TH2/>
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
index 5207cd8d6ad83..fba65c5c90bb9 100644
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

