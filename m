Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9CCCAC5B8
	for <batman-adv@archiver.kernel.org>; Sat, 27 Sep 2025 18:03:24 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id AE58683F46
	for <batman-adv@archiver.kernel.org>; Sat, 27 Sep 2025 20:03:22 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1758996202;
 b=lHQ+DRpqgBImf/19M5T2DzsQSfDowDl/0hCmD0LYxVTea9DnDeVLpJJIKqKRFApv58B/R
 aCxswEh9zP/oCH3gHjyeBZHikQ4PxPKvjXwNEFgP465lPfl9OQUzT1SpxgtnIp4wKjB9IR2
 YHsy/O8IcQG006fKbDoFUtNH4NuRqOE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1758996202; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=6eNtUve00s4xghuZMrmWgRzIN1oXXAv2eVuGe9TQYrg=;
 b=u8WPPsxeBrP8kvSRWfyxSIJ3+6DssmUwlDx/5qzEBGbVDCRZyzs2vq9KKYbZ9O9UT1uT1
 PIK/TnAM51Aib5ki9N9WJDwi32VH/fQSbrpU+mulXGjvpCSl7sXvfM5MRIcsY3T53/ioFQM
 pNIQ9iE9rkObTwo3d5BtS3h4w4PDkbM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 0CCD98040B
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 27 Sep 2025 20:02:44 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1758996175; a=rsa-sha256;
	cv=none;
	b=Pp/VvoH2qAZVHGr5iyXwuSZrq5sxpIbuMGTt43fIpMt1vJsu+qS4e37Vr3QrWi4MqzcfnP
	K6MxCrYV5GrgKgxaAb4ViRHLI7ASwnTU68Cq2gKgIPxUxhwfv88wyvRr0qaPfkSsE5ykGi
	k3cDu0VSouuMYqV3qeQIbFZYz97zTuI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=wxM7+XPD;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1758996175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=6eNtUve00s4xghuZMrmWgRzIN1oXXAv2eVuGe9TQYrg=;
	b=ECzRaKeBqFhDFkA4N5QFCBq+Xqwr0KkXXc4T5X2l4QdeHk9DUnimRMNa+ixBK8I7foa5Bp
	jHjmbut2PmNV8+iUVQajz3m97rj7R1hMCGHsIGeHEsWcQCakvaEHnkcYyTEczDtuTuGDQv
	aexeut80fjl4qcetBUupNT7ACa+gT1E=
Received: by dvalin.narfation.org (Postfix) id 3C2FF200DE;
	Sat, 27 Sep 2025 18:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1758996164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6eNtUve00s4xghuZMrmWgRzIN1oXXAv2eVuGe9TQYrg=;
	b=wxM7+XPD7HApKCZKeT8spd09SR9D73apgxsLNiljnhgM0AdZCapqvFpB5N8cq1V51aqncz
	F8cAo8cZvxVf5QInJxUfM0AA6KWdjTuDX0I8DuoLKm6584MBysdUXxH4S1AcgtHnaD2PSm
	gcXhMC0O+PObOgMUXiVepMYb33ko89g=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 27 Sep 2025 20:01:29 +0200
Subject: [PATCH] batman-adv: Release references to inactive interfaces
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: 
 <20250927-netlink-free-inactive-if-v1-1-8f109d2104f7@narfation.org>
X-B4-Tracking: v=1; b=H4sIAHgm2GgC/x2MQQqAMAwEvyI5W2iLVvQr4qFqqkGJ0koRxL8bv
 M0w7D6QMBIm6IoHImZKdLCIKQuYVs8LKprFwWpb69Y2ivHaiTcVIkpjP12UBYIy1sza+Wp0xoH
 Mz4iB7v+6H973A0QkqgNqAAAA
X-Change-ID: 20250927-netlink-free-inactive-if-121d06a4b616
To: b.a.t.m.a.n@lists.open-mesh.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2850; i=sven@narfation.org;
 h=from:subject:message-id; bh=e8cSoHx18CrIM9uuYSkR4hp/AxaRC2cgop/R1Ns1DHw=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDBk31LZtjLn6Y9mKyeUNzWHlxxO41zTzTMyrX3ptxevo5
 QKn/kyv7ShlYRDjYpAVU2TZcyX//Gb2t/Kfp308CjOHlQlkCAMXpwBMhKeW4Z/Zxhtfg4/lfdbw
 sXnfqHr6dbz4ffX2A3fmvjpqfcLJT282w/+c/24L/zYb/Nhvd97Lx3HtxiUXbkwRF/xsGdF0ZdZ
 WKU9eAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 4I4ICVIWYCP5V6CE4RDG6XLNX5MHMQXG
X-Message-ID-Hash: 4I4ICVIWYCP5V6CE4RDG6XLNX5MHMQXG
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
CC: syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/4I4ICVIWYCP5V6CE4RDG6XLNX5MHMQXG/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Trying to dump the originators or the neighbors via netlink for a meshif
with an inactive primary interface is not allowed. The dump functions were
checking this correctly but they didn't handle non-existing primary
interfaces and existing _inactive_ interfaces differently.

(Primary) batadv_hard_ifaces hold a references to a net_device. And
accessing them is only allowed when either being in a RCU/spinlock
protected section or when holding a valid reference to them. The netlink
dump functions use the latter.

But because the missing specific error handling for inactive primary
interfaces, the reference was never dropped. This reference counting error
was only detected when the interface should have been removed from the
system:

  unregister_netdevice: waiting for batadv_slave_0 to become free. Usage count = 2

Fixes: 50eddf397ac3 ("batman-adv: netlink: reduce duplicate code by returning interfaces")
Reported-by: syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com
Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/originator.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index c84420cb410d5d948c6612cf27e320e7e0af017e..a662408ad8673c3f5532201bb6e47caa5779b627 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -763,11 +763,16 @@ int batadv_hardif_neigh_dump(struct sk_buff *msg, struct netlink_callback *cb)
 	bat_priv = netdev_priv(mesh_iface);
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
-	if (!primary_if || primary_if->if_status != BATADV_IF_ACTIVE) {
+	if (!primary_if) {
 		ret = -ENOENT;
 		goto out_put_mesh_iface;
 	}
 
+	if (primary_if->if_status != BATADV_IF_ACTIVE) {
+		ret = -ENOENT;
+		goto out_put_primary_if;
+	}
+
 	hard_iface = batadv_netlink_get_hardif(bat_priv, cb);
 	if (IS_ERR(hard_iface) && PTR_ERR(hard_iface) != -ENONET) {
 		ret = PTR_ERR(hard_iface);
@@ -1327,11 +1332,16 @@ int batadv_orig_dump(struct sk_buff *msg, struct netlink_callback *cb)
 	bat_priv = netdev_priv(mesh_iface);
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
-	if (!primary_if || primary_if->if_status != BATADV_IF_ACTIVE) {
+	if (!primary_if) {
 		ret = -ENOENT;
 		goto out_put_mesh_iface;
 	}
 
+	if (primary_if->if_status != BATADV_IF_ACTIVE) {
+		ret = -ENOENT;
+		goto out_put_primary_if;
+	}
+
 	hard_iface = batadv_netlink_get_hardif(bat_priv, cb);
 	if (IS_ERR(hard_iface) && PTR_ERR(hard_iface) != -ENONET) {
 		ret = PTR_ERR(hard_iface);

---
base-commit: def64eeace3150b88d5823fcb733dadd79d7562a
change-id: 20250927-netlink-free-inactive-if-121d06a4b616

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>

