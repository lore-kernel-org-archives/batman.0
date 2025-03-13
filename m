Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C64C0C282EC
	for <batman-adv@archiver.kernel.org>; Thu, 13 Mar 2025 16:18:22 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 60012842EE
	for <batman-adv@archiver.kernel.org>; Thu, 13 Mar 2025 17:18:21 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1741882701;
 b=nv4cG8lmkOJhgzEUZWprF2US3WD5ex53r+LFqmLy8kQUF9wWk5XXZukjBcvU/7HpCgXgj
 lc0zQmgc1vUV0tB0DGVbSVx8YT4nHPs2lf845xC0U+Hr7Lt+wcHFDxWnvS9ObI0eoaxdPVS
 kM9mPd7kMIXWnbLqBFiUgs1D3QQWRYg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1741882701; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=TYYOJ3ru+lfyMj+KH3Gz1l4OP+IWN7bRXNGl1OZ6nCQ=;
 b=v7fxU7p8XPg18M2IFNrYNKn4G3XFvsh1DwKnpYb4yybbJhdtogAGhpCujUi7GrXst1IyP
 TErYTjfzNMb9t1+GLkse56JI8QI7o+z5bsVjCUmoavPMzEYkmchiP0fy4A8jTib7rM6qnnF
 phJLuEklY8gBOBRixawffqN5JG7jeBo=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 8C4CB841F0
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 13 Mar 2025 17:17:42 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1741882662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TYYOJ3ru+lfyMj+KH3Gz1l4OP+IWN7bRXNGl1OZ6nCQ=;
	b=ajO8OA/SzAgnXssdgZ0S5uhEdfnsJzZmauxWYyKbgk2Vzqp9cfukVhqGads9Yyr3gRDDpW
	vVWN9t9SXNNmm2IrlV5Y8NXaXq4B//d2pzSonrAIKJNJcZaG1AMHPSQhRs1rCAfgpt5+tZ
	l2+0MnrC1691QHNOq1ZBsze8+CdNBbU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1741882662; a=rsa-sha256;
	cv=none;
	b=hVGKQRufN0txoFKOGRDBXj3Ti6Nd5QfVPDJff3b7QvpuJk0pOHvs2LTDLYllJjX5exjDjh
	8C07PatIqpWX0unkrL4SM4iLI5NHuXeCpi7IHlZj2Y4lymohK56z3wN3u39S3d2tAVi4FX
	U0S+rsMjPwZDNSFkYpmuSHOmtx9JUTs=
Received: from kero.packetmixer.de
 (p200300fa272413901a38a4bC9c0De305.dip0.t-ipconnect.de
 [IPv6:2003:fa:2724:1390:1a38:a4bc:9c0d:e305])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 8687EFA132;
	Thu, 13 Mar 2025 17:17:41 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Andy Strohman <andrew@andrewstrohman.com>,
	stable@vger.kernel.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 1/5] batman-adv: fix panic during interface removal
Date: Thu, 13 Mar 2025 17:17:34 +0100
Message-Id: <20250313161738.71299-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250313161738.71299-1-sw@simonwunderlich.de>
References: <20250313161738.71299-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: GE7JBZYT3KRAQ47DAMJCV6KFOOXIQNKP
X-Message-ID-Hash: GE7JBZYT3KRAQ47DAMJCV6KFOOXIQNKP
X-MailFrom: sw@simonwunderlich.de
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/GE7JBZYT3KRAQ47DAMJCV6KFOOXIQNKP/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Andy Strohman <andrew@andrewstrohman.com>

Reference counting is used to ensure that
batadv_hardif_neigh_node and batadv_hard_iface
are not freed before/during
batadv_v_elp_throughput_metric_update work is
finished.

But there isn't a guarantee that the hard if will
remain associated with a soft interface up until
the work is finished.

This fixes a crash triggered by reboot that looks
like this:

Call trace:
 batadv_v_mesh_free+0xd0/0x4dc [batman_adv]
 batadv_v_elp_throughput_metric_update+0x1c/0xa4
 process_one_work+0x178/0x398
 worker_thread+0x2e8/0x4d0
 kthread+0xd8/0xdc
 ret_from_fork+0x10/0x20

(the batadv_v_mesh_free call is misleading,
and does not actually happen)

I was able to make the issue happen more reliably
by changing hardif_neigh->bat_v.metric_work work
to be delayed work. This allowed me to track down
and confirm the fix.

Cc: stable@vger.kernel.org
Fixes: c833484e5f38 ("batman-adv: ELP - compute the metric based on the estimated throughput")
Signed-off-by: Andy Strohman <andrew@andrewstrohman.com>
[sven@narfation.org: prevent entering batadv_v_elp_get_throughput without
 soft_iface]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_v_elp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 1d704574e6bf..fbf499bcc671 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -66,12 +66,19 @@ static void batadv_v_elp_start_timer(struct batadv_hard_iface *hard_iface)
 static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 {
 	struct batadv_hard_iface *hard_iface = neigh->if_incoming;
+	struct net_device *soft_iface = hard_iface->soft_iface;
 	struct ethtool_link_ksettings link_settings;
 	struct net_device *real_netdev;
 	struct station_info sinfo;
 	u32 throughput;
 	int ret;
 
+	/* don't query throughput when no longer associated with any
+	 * batman-adv interface
+	 */
+	if (!soft_iface)
+		return BATADV_THROUGHPUT_DEFAULT_VALUE;
+
 	/* if the user specified a customised value for this interface, then
 	 * return it directly
 	 */
@@ -141,7 +148,7 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 
 default_throughput:
 	if (!(hard_iface->bat_v.flags & BATADV_WARNING_DEFAULT)) {
-		batadv_info(hard_iface->soft_iface,
+		batadv_info(soft_iface,
 			    "WiFi driver or ethtool info does not provide information about link speeds on interface %s, therefore defaulting to hardcoded throughput values of %u.%1u Mbps. Consider overriding the throughput manually or checking your driver.\n",
 			    hard_iface->net_dev->name,
 			    BATADV_THROUGHPUT_DEFAULT_VALUE / 10,
-- 
2.39.5

