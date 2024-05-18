Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B808C25B74
	for <batman@archiver.kernel.org>; Sat, 18 May 2024 15:51:09 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7703A82578
	for <batman@archiver.kernel.org>; Sat, 18 May 2024 17:51:07 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1716047467;
 b=cK+ELdmIPgjSxBoPWr/fWdybPoCckf2aWXcn8ZcMld+iMb6qcQwRGypyrUrHDxTq/m0jM
 8etbDtF1T5QKOfnL1LAQ6uZSG26Oms8Q9w3CqQgp0k4Cs537yGWLUMI04QMGoK3dBb8ky4I
 gxHG8vovQTuhTXOiiO7d0aXxnH/9bd0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1716047467; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=aVjGFOCAHvImyu4XwHG9uBYm+CQZs6Me22ijxmIiYYs=;
 b=G04BT/8P3THgI6jnDKEFyDd8sEGbaVEM8GlMgj1CHhisqf5cahwnkCU9o/zIbT6iXLz5d
 AG9LXcnooPEeH6CZjbzHw9P6AnFmspGAXNAM1yrvkDSdF31E+n3Yyc5FieFlfPq4owE063z
 6VRXwtmenNiCh8cnL+l4b6WBKC60ZaY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail header.d=triplefau.lt;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=triplefau.lt
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail header.d=triplefau.lt;
 arc=pass;
 dmarc=fail (Used From Domain Record) header.from=triplefau.lt policy.dmarc=quarantine
Received: from mailo.com (msg-4.mailo.com [213.182.54.15])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 6077581202
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 18 May 2024 17:50:54 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1716047454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=aVjGFOCAHvImyu4XwHG9uBYm+CQZs6Me22ijxmIiYYs=;
	b=FOzGkC6E4wvZsROBGp1FDk+BFbQltDjhMgPderKZHA2JE5iwKOVAUpRKJqi4nsPl9psz9Q
	UICELYvhtptu36cBx5RciYn54S29KNfuWSkDTwfZ/MBmsGviyG3TcCcP1HqGqSrxLCbB8J
	O017DSuSfe7cacYRrb14OC4/Hl2VRp8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=triplefau.lt header.s=mailo header.b=wALniPN+;
	spf=pass (diktynna.open-mesh.org: domain of repk@triplefau.lt designates
 213.182.54.15 as permitted sender) smtp.mailfrom=repk@triplefau.lt;
	dmarc=pass (policy=quarantine) header.from=triplefau.lt
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1716047454; a=rsa-sha256;
	cv=none;
	b=HVABVEincShUWC0bznpPp4P5G5elN6sYt3FmlQlaNh5Jm824IS8aeV7DnIsNDoH7Al7wpC
	DlMYZmZgbzPFwXuGPwR4frLdQrbm0le2CEyvKR2lj06eqqmxZ/am+JmIk6GlfeT9caaxkJ
	v/7+rLI/R/vzcqTGUCnnYrmrn90YKHU=
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=triplefau.lt; s=mailo;
	t=1716047339; bh=yJgMAB00K/FlurJgytOCJtxdy+ZdolCNi8+4MDZgLoc=;
	h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	b=wALniPN+bVwxijNrkG8JuvegfILjPYNqQEk211QUO22N+WVlZroAkRnHiUWC01Esz
	 0G6BoxR1sFkXzuxAScebYFmU4mQawbsoMMRw/WXoWOQMoIURe4cOCR+dij4aEc/+nC
	 nsH3M/Vbxg6+ZwbS+dN82ln3UfN9J/Yd6A1xhmic=
Received: by b221-3.in.mailobj.net [192.168.90.23] with ESMTP
	via ip-20.mailobj.net [213.182.54.20]
	Sat, 18 May 2024 17:48:59 +0200 (CEST)
X-EA-Auth: 
 ZP31XRQrGZhIWItoW+MR7A+JOI/EFMDjNIt7W7rkwCnZ7C05T9Nhl6S8yO3/NhIZfYHybvuup6gB+cDlexR92ygHLaHjZJSd
From: Remi Pommarel <repk@triplefau.lt>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Antonio Quartulli <antonio@open-mesh.com>,
	linux-wireless@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	linux-kernel@vger.kernel.org,
	Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH] wifi: cfg80211: Lock wiphy in cfg80211_get_station
Date: Sat, 18 May 2024 17:50:46 +0200
Message-Id: 
 <983b24a6a176e0800c01aedcd74480d9b551cb13.1716046653.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: LWGQ6XX7TQJUJT6XVN7Z56HUHYR65OUO
X-Message-ID-Hash: LWGQ6XX7TQJUJT6XVN7Z56HUHYR65OUO
X-MailFrom: repk@triplefau.lt
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/LWGQ6XX7TQJUJT6XVN7Z56HUHYR65OUO/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Wiphy should be locked before calling rdev_get_station() (see lockdep
assert in ieee80211_get_station()).

This fixes the following kernel NULL dereference:

 Unable to handle kernel NULL pointer dereference at virtual address 0000000000000050
 Mem abort info:
   ESR = 0x0000000096000006
   EC = 0x25: DABT (current EL), IL = 32 bits
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
   FSC = 0x06: level 2 translation fault
 Data abort info:
   ISV = 0, ISS = 0x00000006
   CM = 0, WnR = 0
 user pgtable: 4k pages, 48-bit VAs, pgdp=0000000003001000
 [0000000000000050] pgd=0800000002dca003, p4d=0800000002dca003, pud=08000000028e9003, pmd=0000000000000000
 Internal error: Oops: 0000000096000006 [#1] SMP
 Modules linked in: netconsole dwc3_meson_g12a dwc3_of_simple dwc3 ip_gre gre ath10k_pci ath10k_core ath9k ath9k_common ath9k_hw ath
 CPU: 0 PID: 1091 Comm: kworker/u8:0 Not tainted 6.4.0-02144-g565f9a3a7911-dirty #705
 Hardware name: RPT (r1) (DT)
 Workqueue: bat_events batadv_v_elp_throughput_metric_update
 pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : ath10k_sta_statistics+0x10/0x2dc [ath10k_core]
 lr : sta_set_sinfo+0xcc/0xbd4
 sp : ffff000007b43ad0
 x29: ffff000007b43ad0 x28: ffff0000071fa900 x27: ffff00000294ca98
 x26: ffff000006830880 x25: ffff000006830880 x24: ffff00000294c000
 x23: 0000000000000001 x22: ffff000007b43c90 x21: ffff800008898acc
 x20: ffff00000294c6e8 x19: ffff000007b43c90 x18: 0000000000000000
 x17: 445946354d552d78 x16: 62661f7200000000 x15: 57464f445946354d
 x14: 0000000000000000 x13: 00000000000000e3 x12: d5f0acbcebea978e
 x11: 00000000000000e3 x10: 000000010048fe41 x9 : 0000000000000000
 x8 : ffff000007b43d90 x7 : 000000007a1e2125 x6 : 0000000000000000
 x5 : ffff0000024e0900 x4 : ffff800000a0250c x3 : ffff000007b43c90
 x2 : ffff00000294ca98 x1 : ffff000006831920 x0 : 0000000000000000
 Call trace:
  ath10k_sta_statistics+0x10/0x2dc [ath10k_core]
  sta_set_sinfo+0xcc/0xbd4
  ieee80211_get_station+0x2c/0x44
  cfg80211_get_station+0x80/0x154
  batadv_v_elp_get_throughput+0x138/0x1fc
  batadv_v_elp_throughput_metric_update+0x1c/0xa4
  process_one_work+0x1ec/0x414
  worker_thread+0x70/0x46c
  kthread+0xdc/0xe0
  ret_from_fork+0x10/0x20
 Code: a9bb7bfd 910003fd a90153f3 f9411c40 (f9402814)

Fixes: 7406353d43c8 ("cfg80211: implement cfg80211_get_station cfg80211 API")
Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 net/wireless/util.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index 2bde8a354631..082c6f9c5416 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -2549,6 +2549,7 @@ int cfg80211_get_station(struct net_device *dev, const u8 *mac_addr,
 {
 	struct cfg80211_registered_device *rdev;
 	struct wireless_dev *wdev;
+	int ret;
 
 	wdev = dev->ieee80211_ptr;
 	if (!wdev)
@@ -2560,7 +2561,11 @@ int cfg80211_get_station(struct net_device *dev, const u8 *mac_addr,
 
 	memset(sinfo, 0, sizeof(*sinfo));
 
-	return rdev_get_station(rdev, dev, mac_addr, sinfo);
+	wiphy_lock(&rdev->wiphy);
+	ret = rdev_get_station(rdev, dev, mac_addr, sinfo);
+	wiphy_unlock(&rdev->wiphy);
+
+	return ret;
 }
 EXPORT_SYMBOL(cfg80211_get_station);
 
-- 
2.40.0



