Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B2FCD3424
	for <batman@archiver.kernel.org>; Sun,  3 May 2026 12:30:27 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id EAC8D85BBE
	for <batman@archiver.kernel.org>; Sun, 03 May 2026 14:30:25 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1777811425;
 b=zUwHluE8Z1dr7iOfgPYMBcDKxphy5+gVbevgy1x2GssntSRdAXRLBoESxSm8SzikR33YJ
 mALa6vhUoI5gwaAiN9/U7qs4b6Fk0/UJHyzCY53YP85NdeF/Ros1OX2LteR6jQzZmH/2j6Z
 qAw5O4m53PdMJ8ylxzntaXwnAJI2qFU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1777811425; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=KhEbXNhkPfNvLqtNPlezsj4uw+CjuYhQZoIojUxX1vQ=;
 b=h/h4Wuczz+5BT7SFGJCSqpYkBQYffEZE3vEsDIiOk7GUzF6n8iFdYsQoiyZ+zqVWyGJpt
 mE8Gd23Zvrv5DR328DspUqjsiYXTPoXjx4IbxlPwm+yrTvzEVSEzODsEpcJZ8otJMtdPFdP
 HXHPPI+aZvZ2EB4kLh5w0VkA3ffNlx4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id CA5E683D4C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 03 May 2026 14:23:45 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1777811025;
	b=mPllSZuWdeqZ1RQI9oSkM4VAW7f60V+58w4YO13A2jaX/tz/MnwCtHrXNvqSAFy1S1jY9V
	jKVONfgurCj/JH4ebDOw4+C12icYVkTGWLkSHlDPYBUFnUwYJ3mlbWy6PD0R3bA8c7sgDY
	I8T/T/dR/cztm/pxpPcyGNiJu7N6oKc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=SIiJoF+G;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1777811025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=KhEbXNhkPfNvLqtNPlezsj4uw+CjuYhQZoIojUxX1vQ=;
	b=F2Cbq5AdJEKXnvt7atkZteNXd89B5aM3Jd8ijN+vkxk0cfIAu58VXKh9ztGe2KmmlVwgcM
	VRlwFGBOdcdY6tHSWJF+i5BHYudfGmquwNG0kG6pqyxH550YPbjcXJAytfgce8bVX6qFz0
	GuAB8yho/zFqK7zHW+DKithzgfynCPo=
Received: by dvalin.narfation.org (Postfix) id 6A13D1FF1D;
	Sun, 03 May 2026 12:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1777811025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KhEbXNhkPfNvLqtNPlezsj4uw+CjuYhQZoIojUxX1vQ=;
	b=SIiJoF+GuOYBQBXDzSTj6QFlEeRy8CMj9C1U41hLFPkn2Cm64Ao0vE5Ii6d/IIvnestbuu
	xWOfFqf2vXNwAS5TT76RFqXDHIiTJy2l0fe/g0aTd1WwItMnMMMljQGaaIWmjPOBJwj/SI
	lJNbiawix4V7SGWUN3O1pRQOSd2PYAA=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 03 May 2026 14:22:41 +0200
Subject: [PATCH batadv 8/8] batman-adv: tt: prevent TVLV entry number
 overflow
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260503-fixes-followup-v1-8-4313278918d3@narfation.org>
References: <20260503-fixes-followup-v1-0-4313278918d3@narfation.org>
In-Reply-To: <20260503-fixes-followup-v1-0-4313278918d3@narfation.org>
To: Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <antonio@mandelbit.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ao Zhou <n05ec@lzu.edu.cn>,
 Haoze Xie <royenheart@gmail.com>, Jiexun Wang <wangjiexun2025@gmail.com>,
 Juefei Pu <tomapufckgml@gmail.com>, Luxing Yin <tr0jan@lzu.edu.cn>,
 Ren Wei <n05ec@lzu.edu.cn>, Ruide Cao <caoruide123@gmail.com>,
 Xin Liu <bird@lzu.edu.cn>, Yifan Wu <yifanwucs@gmail.com>,
 Yuan Tan <yuantan098@gmail.com>, Sven Eckelmann <sven@narfation.org>,
 stable@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2180; i=sven@narfation.org;
 h=from:subject:message-id; bh=og/KbJTzMBuS0M1D9ny3QC96ABI6fM7k015VpJIfs3c=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDJnf7WQ32n5Z//5qFfO5u7mOG/kcPN8kMnnqfeyeeuXin
 JITywoedpSyMIhxMciKKbLsuZJ/fjP7W/nP0z4ehZnDygQyhIGLUwAm8ukNw39/tRAB9hurBKdP
 mnH/wvObR9LOl94+1qm7L3eCue+Bb7dWMPyVUhO2X/dh+eVfxZ6L97wJ1Pd4fqrjw1ROa6bcaxf
 VAiezAgA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Hits: max-recipients
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-size;
 news-moderation; no-subject; digests; suspicious-header
Message-ID-Hash: IHKUIFVSLTZUXG34WJOB4OG6IKRE2U3W
X-Message-ID-Hash: IHKUIFVSLTZUXG34WJOB4OG6IKRE2U3W
X-Mailman-Approved-At: Sun, 03 May 2026 14:24:15 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/IHKUIFVSLTZUXG34WJOB4OG6IKRE2U3W/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The helpers to prepare the buffers for the local and global TT based
replies are trying to sum up all TT entries which can be found for each
VLAN. In theory, this sum can be too big for an u16 and therefore overflow.
A too small buffer would then be allocated for the TVLV.

The too small buffer will be handled gracefully by
batadv_tt_tvlv_generate() and is not causing a buffer overflow - just a
truncated reply. But this overflow shouldn't have happened in the first and
the too small buffer should never have been allocated when an overflow was
detected.

Cc: stable@kernel.org
Fixes: 7ea7b4a14275 ("batman-adv: make the TT CRC logic VLAN specific")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 5a005d4e6cc6..630ae8a66beb 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -804,11 +804,18 @@ batadv_tt_prepare_tvlv_global_data(struct batadv_orig_node *orig_node,
 	u16 total_entries = 0;
 	u8 *tt_change_ptr;
 	int vlan_entries;
+	u16 sum_entries;
 
 	spin_lock_bh(&orig_node->vlan_list_lock);
 	hlist_for_each_entry(vlan, &orig_node->vlan_list, list) {
 		vlan_entries = atomic_read(&vlan->tt.num_entries);
-		total_entries += vlan_entries;
+
+		if (check_add_overflow(vlan_entries, total_entries, &sum_entries)) {
+			*tt_len = 0;
+			goto out;
+		}
+
+		total_entries = sum_entries;
 		num_vlan++;
 	}
 
@@ -896,11 +903,18 @@ batadv_tt_prepare_tvlv_local_data(struct batadv_priv *bat_priv,
 	u16 total_entries = 0;
 	u16 tvlv_len;
 	u8 *tt_change_ptr;
+	u16 sum_entries;
 
 	spin_lock_bh(&bat_priv->meshif_vlan_list_lock);
 	hlist_for_each_entry(vlan, &bat_priv->meshif_vlan_list, list) {
 		vlan_entries = atomic_read(&vlan->tt.num_entries);
-		total_entries += vlan_entries;
+
+		if (check_add_overflow(vlan_entries, total_entries, &sum_entries)) {
+			tvlv_len = 0;
+			goto out;
+		}
+
+		total_entries = sum_entries;
 		num_vlan++;
 	}
 

-- 
2.47.3

