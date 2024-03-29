Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC2A7C6FD1F
	for <batman@archiver.kernel.org>; Fri, 29 Mar 2024 12:28:06 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id EEF5781B27
	for <batman@archiver.kernel.org>; Fri, 29 Mar 2024 13:28:04 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1711715284;
 b=13T8J+dyrj7DHP6aouC/6vbiqFIk56XWLSWu9A0Gq8efe0g/erWwSaVWfirdAVNqkkRgO
 1P+bWp3up7tQNKWahxL2Sy7aZLeFO158xAqk5puA+3NSU6PnyRFs4Q2G5BkGArK1HAuI8dG
 E2cajTOEpRgsprny3diGk6YPKr0PYQw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1711715284; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=PE6urRVT9mTvWTv8TeGuDqThX9Zj7pCykw+LKbWkC8I=;
 b=WKf5e3QvvN2dyUskN/AGIJoioj1JYlf/5Bbb9HDu/zNmjYCdR/zAUkIbEbe1PBmsRzJU6
 vnHAWbmWxVwb7cI/+EUvPW1IuSWvLi4WW1Ao53bz5ZRZKh4einXQVH5g10+p2IlbYJXlKwK
 HbnjV21u86Bi9ARfVqqk4ye8/Hz8eSY=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=kernel.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=kernel.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=kernel.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=kernel.org policy.dmarc=none
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id DF30380983
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 29 Mar 2024 13:27:02 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1711715223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=PE6urRVT9mTvWTv8TeGuDqThX9Zj7pCykw+LKbWkC8I=;
	b=ZLXdt4FPAuCdLA34+e4Nm3fUX3TbKmdNT7fTcVyS/kcW/o6HDNWVreU0n+onkwMsWGY/m7
	H4Pw122qAgc+Mu8O7sasAU3oh3p2B491KhueJp8FH4G/hixxn9dbgVa7XPFX/SeKLKRwit
	Iw46W4xa0PacyMP/wrgVEistrNK2mT8=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1711715223; a=rsa-sha256;
	cv=none;
	b=siN7NDsjYBdUNsq0xuwhap0ssjPR6b2cDoiFjCHuRtSOl7ImGvDMpk1y7u3af3cn+opz73
	Mg8/BBq+L7CxAOBg6Ms7fmvZ1VD3sFk4SdwWYWvabt1LBuapDI2JPIYmnn3YGjcd/eibWt
	XCyiQWcjDwqCvopniNU1r1+88P+Esro=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=rR9qSkav;
	spf=pass (diktynna.open-mesh.org: domain of sashal@kernel.org designates
 145.40.73.55 as permitted sender) smtp.mailfrom=sashal@kernel.org;
	dmarc=pass (policy=none) header.from=kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 2DE73CE2F7D;
	Fri, 29 Mar 2024 12:27:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F98C43390;
	Fri, 29 Mar 2024 12:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715220;
	bh=5HU0tVK2jo0gIkWQ4u9tXr3Io81w6m8ndoau/SdGV7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rR9qSkav7WR4Jhy5mb/49maMO/L6ZMiGgUkwgiA98R347uDq1/790umHWMwBx2tiA
	 WMW/2CZcAd7kNOlHgTRuHAK/9V0M2kZMYwVmTHCTP08fc9e7lNWrbeym8z2T/vC2Q6
	 /I2OL/LRdB3D/d55TKLc2ID3An72bQIa31qvOZkkaodkQ1sL9JXjUaP+omanBEcrKL
	 Phx7gavj1PM3Q8kmX9Y5CjBL10SG1/ILDGaVgQdfJGXKG5tryQZkc7gKNcn59W0ADi
	 Yf5ORtNP10YFAOF8jHZYkYmUB3CFLaKE5/Y6Rd1/e0AW9WdiCfCp4bt4ll2m6vjr4U
	 +W5dxh53E7WwA==
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
Subject: [PATCH AUTOSEL 6.8 05/68] batman-adv: Improve exception handling in
 batadv_throw_uevent()
Date: Fri, 29 Mar 2024 08:25:01 -0400
Message-ID: <20240329122652.3082296-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122652.3082296-1-sashal@kernel.org>
References: <20240329122652.3082296-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit
Message-ID-Hash: ULOZBXWESSIDE5TZU7NOZVXPGSJTMKTP
X-Message-ID-Hash: ULOZBXWESSIDE5TZU7NOZVXPGSJTMKTP
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ULOZBXWESSIDE5TZU7NOZVXPGSJTMKTP/>
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
index 5fc754b0b3f7f..75119f1ffcccf 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -691,29 +691,31 @@ int batadv_throw_uevent(struct batadv_priv *bat_priv, enum batadv_uev_type type,
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

