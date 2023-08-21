Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D86BDEE4996
	for <batman-adv@archiver.kernel.org>; Mon, 21 Aug 2023 19:49:43 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 17A8A8335E
	for <batman-adv@archiver.kernel.org>; Mon, 21 Aug 2023 21:49:42 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1692647382;
 b=i9LF3Dy4LoaDQWaCxlSMvrZuB9Cg+06vL/V/BXqL1H5YyTy/hKRMZd5MDAxEuO0X4IUrN
 DL99XekGoAmB8yT69JxnsYmaUhRJwgRjU8SihdHvQhXoUg5bUEgiwmZy98k4HuABr3XNeK7
 zsJBzpVbXw8/k7eS1ktNsYCFxt3EyPk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1692647382; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=DsJB+7sFuuWOoDx7Fh2DdE7VFZsdKo18N46Pkibr1aQ=;
 b=uzuwuJzglei4+/UKZT1hf7vURvlIJOigSt1Uk+OBrohXyeEv3x5tps/pCu1/1FysC1xqG
 lq/96UwkKcb4Tt3yDkmm/unwxAtG1T+MfFNsmsBSACsT82xzFzfdHL0WFRQJLjOGNd1H5w0
 XgwrnBy7mNu23nWb6GnrPXgY1SAEptU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 40A048097B
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 21 Aug 2023 21:49:02 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1692647342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=DsJB+7sFuuWOoDx7Fh2DdE7VFZsdKo18N46Pkibr1aQ=;
	b=J47544xWqENDVSe+zY7AlJ+m1BoJT7hALpD5W0lhb/zDI/gdk4XVUe14+SSgiFNEi8fIII
	MJKGYou15QOzJODu51Pw7P8Azplt+vGzkocqcasOrj4+1IYDYmKb9UOiQuDURPkw0yXtbR
	gvRqOvFqKt0jmtDxblTWg6Vxuuadn0I=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=nszFs4Bz;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1692647342; a=rsa-sha256;
	cv=none;
	b=NyDCfw/+6xsZ+hcPka+dTCnwFMo9SExKoOTwaMrSb/8DDdlRaifaNFIEFzHEZU+WykReMk
	/6ENG2S1+1kmu96sWj0RGlZ93qqHj+aNyMCpM5K2b4CkbQa+/jtl6t7G8x7+x0Yjq1cFvl
	Rw8srPCQf2G1O2w/FPaGz8Dg7U2clBQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1692647340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DsJB+7sFuuWOoDx7Fh2DdE7VFZsdKo18N46Pkibr1aQ=;
	b=nszFs4BzGq34b6Yjsot5JzSkTw1ejeU0MABi473U4BX8XaObmjL2bYZ9RvI0BNNTHZqR0i
	46lG7TuOYW6qhyOOSZ82AWu8fYZhQaizM7QROtE9SDodbG5DulVyUKWe4nAeyZlwSAgRA6
	NPbl7cLXvbVGEtmwb3+uuJ6/cg+tIhw=
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 21 Aug 2023 21:48:48 +0200
Subject: [PATCH net] batman-adv: Hold rtnl lock during MTU update via
 netlink
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: 
 <20230821-batadv-missing-mtu-rtnl-lock-v1-1-1c5a7bfe861e@narfation.org>
X-B4-Tracking: v=1; b=H4sIAJ+/42QC/x3MwQqDMAwA0F+RnBewVVT8FdmhttGFaZSmykD89
 xWP7/IuUIpMCn1xQaSTlTfJMK8C/MfJTMghG2xpq7KzBkeXXDhxZVWWGdd0YEyy4LL5L46+9kR
 N21YmQC72SBP/nn4AoQTv+/4D4KcifHMAAAA=
To: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1837; i=sven@narfation.org;
 h=from:subject:message-id; bh=nowgqTBeuSUsF0MkPq8VVljqJ1v/j0h46T2v8/GwWCY=;
 b=owEBbQKS/ZANAwAKAV2HCgfBJntGAcsmYgBk47+pbaqBTAlTRuPwSw65wtkGsj6wTPGtx4Qrm
 YflxfdZDAKJAjMEAAEKAB0WIQQXXSuHYSVz3OMy4AJdhwoHwSZ7RgUCZOO/qQAKCRBdhwoHwSZ7
 RmEWEADJTs2FMiNg3J2roovo8WjYYATlIbupo+AwWF7L+jRF2SlAj46b3UJFnM2+wriGdw+5s+U
 4cLKgsaBfHrDOCOvWWs+pjaREH2RVTxQQ+c43GCqHifiPwiSCwKy9IRt/bnIh+LwyJJ47pEwFD3
 0FXyw04gGO8ylJhMA9zcL498GQp3mns94L/OkrgYbW6nuzTYPw2xa1tdDQz3OpczcQjd4v11ix1
 PecLmX1yHd61NTfcT3wOSnENaQPeaMHAcFBzC45zAnkssAeBBPF2uwSj7aYo5VUNfTm3R8ETTg/
 dV6gjStVy2Wcs7sDwTOBo1UZOcTb5rx32AeygcYvEeMtmJ13qD0gl+RAYRBMzKy2Q62fAPt/Dw3
 VFhSVc1RIZuDOCJ9OBTVU6wocm4NjmQr8aApOlHsxhS657PgpfEF2s9DYk8oGwFErJRiYhs1Bsz
 ywOmkziRRKSHX4PdPNAFoNu3q54TbCltb382+78fS3Zi4I4Mv9/0Dqf5pjoMKk/A4lYesqbsyY+
 L7pKXpDCz0EhkgEExy7JkONEgzsIpBy2y1PL6Xhy0bLnDPyCUo2XE6saGHTfqVUXWfOYjxHdYS8
 P+9cC2umm9hEoUgbkOkJ8uXE6krACR6/NuKoUeYHBdZ5H5ebEMNjpTzyw8Z+jxUn2Xig170NwjR
 uvZBu5MnbSu0G9w==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: EMMRELIY2A3NOVZKABRPXZL6LAN4MYC2
X-Message-ID-Hash: EMMRELIY2A3NOVZKABRPXZL6LAN4MYC2
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 stable@vger.kernel.org, syzbot+f8812454d9b3ac00d282@syzkaller.appspotmail.com
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/EMMRELIY2A3NOVZKABRPXZL6LAN4MYC2/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The automatic recalculation of the maximum allowed MTU is usually triggered
by code sections which are already rtnl lock protected by callers outside
of batman-adv. But when the fragmentation setting is changed via
batman-adv's own batadv genl family, then the rtnl lock is not yet taken.

But dev_set_mtu requires that the caller holds the rtnl lock because it
uses netdevice notifiers. And this code will then fail the check for this
lock:

  RTNL: assertion failed at net/core/dev.c (1953)

Cc: stable@vger.kernel.org
Reported-by: syzbot+f8812454d9b3ac00d282@syzkaller.appspotmail.com
Fixes: c6a953cce8d0 ("batman-adv: Trigger events for auto adjusted MTU")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
This problem was just identified by syzbot [1]. I hope it is ok to directly
send this patch to netdev instead of creating a single-patch PR from
the batadv/net branch. If you still prefer a PR then we can also prepare
it.

[1] https://lore.kernel.org/r/0000000000009bbb4b0603717cde@google.com
---
 net/batman-adv/netlink.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index ad5714f737be..6efbc9275aec 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -495,7 +495,10 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 		attr = info->attrs[BATADV_ATTR_FRAGMENTATION_ENABLED];
 
 		atomic_set(&bat_priv->fragmentation, !!nla_get_u8(attr));
+
+		rtnl_lock();
 		batadv_update_min_mtu(bat_priv->soft_iface);
+		rtnl_unlock();
 	}
 
 	if (info->attrs[BATADV_ATTR_GW_BANDWIDTH_DOWN]) {

---
base-commit: 421d467dc2d483175bad4fb76a31b9e5a3d744cf
change-id: 20230821-batadv-missing-mtu-rtnl-lock-bc4cee67731d

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>

