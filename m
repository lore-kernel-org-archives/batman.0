Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D2EC02185
	for <batman-adv@archiver.kernel.org>; Sat, 18 Jan 2025 00:36:00 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 596E583FA5
	for <batman-adv@archiver.kernel.org>; Sat, 18 Jan 2025 01:35:58 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1737160558;
 b=r7XAtSgFPnDAypl8YKjUrPqgyMRn5YxsFpD2a8ShR3vdCiolaPxas4fkF0VBYIpSaoeVK
 p5dV71EAUHA558C9rpfhWyWCtkz0sE6t46mSVnvFyOVUP2skM/X1rw6Bi/L/ti1e9G4GVq7
 v2sGCk4cEACRDxtJTu2dklmNi5jTnMs=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1737160558; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=DaXWjsqbiKUu8jydLbLlt/YcrxoQwKZmYPJYG9zpsSs=;
 b=Fs+s1uzaGHvJvo4R5pyvaZF47EnZxKcbUvBQR8xAii8XJqq6HLiiKcSky4mCr2vvkoJnQ
 WtinAIZUQMimKcodUPtqDzA123MHfTMskQKwJ3QNBNaHAn9zKRRW9eqc0jkI0Sa6nLaS78f
 qJGiibQoDgGJiAPCM2/1oA91eWTsun8=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de
 [IPv6:2a01:4f8:c2c:665b::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 4152280651
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 18 Jan 2025 01:35:45 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1737160545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DaXWjsqbiKUu8jydLbLlt/YcrxoQwKZmYPJYG9zpsSs=;
	b=meG4wv4spisl+ZdmadbVekBriXvY6pBbz/MdEtMbKYAWDid86TQa2wZcpzRgjDwe80xiNh
	tKkZQU18iFppS58/fuR9ejCl7YNb9T+Krchhq5kMERv/oMkMipVdM2b5GdUSgoIN+28OGg
	S4Wx5sMG9QzBFEP3qb+krf8HmvQgDdg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 2a01:4f8:c2c:665b::1 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue;
	dmarc=none
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1737160545; a=rsa-sha256;
	cv=none;
	b=tdUg/HNQ3othpfddAzHMWWsagD/SApEN4mTa6r0ni92sMxv/H3Z4FawQkKtDcWUCHlgh4c
	8RTqkgbgTH1VaAW2+TqS+2d8G02Yi8L6U9l8Z6N13+BmJH5Ld8SmUkl+2d408wSDnw1OOm
	WSyIQDoMYWXzdxJ1xc8hLFVBQ3XICUk=
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 21C19540DDE;
	Sat, 18 Jan 2025 01:35:44 +0100 (CET)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?UTF-8?q?Ren=C3=A9=20Treffer?= <treffer@measite.de>,
	=?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH RFC] batman-adv: BATMAN V: use/prefer 11s airtime link metric
Date: Sat, 18 Jan 2025 01:35:27 +0100
Message-ID: <20250118003528.6843-1-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: 4XO5HGZLSVDKEKVEYR6VRZPCQSR5R3YB
X-Message-ID-Hash: 4XO5HGZLSVDKEKVEYR6VRZPCQSR5R3YB
X-MailFrom: linus.luessing@c0d3.blue
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/4XO5HGZLSVDKEKVEYR6VRZPCQSR5R3YB/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

With an 11s interface and HWMP then this keeps track of a throughput
estimation internally already, as specified by 802.11-2020, section 14.9.2.
The HWMP code even makes use of the Minstrel provided expected throughput
if available and is therefore very close to this expected throughput value,
except the specification adds some constant penalty for:
"Channel access overhead (in μs), which includes frame headers,
training sequences, access protocol frames, etc."

When no expected throughput is available then HWMP keeps track of the
average packet delivery error rate and average phy rate to calculate its
own expected throughput value.

So the 11s airtime link metric should be a slightly better estimate than
the expected throughput provided by Minstrel. And should be significantly
better than our raw PHY rate divided by 3 guestimate fallback.

Therefore this should significantly improve the accuracy for BATMAN V
when using drivers like ath10k/ath11k/ath12k/mt76 which all do not
implement/export an expected throughput information.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
RFC because:
* only tested in a VM with mac80211_hwsim, checked that the value
  from sinfo.airtime_link_metric is used and that
  "batctl o"/"batctl n" still (nearly) matches the "expected throughput"
  in "iw dev wlan0 station dump"
* still needs testing / verification on real devices
* I'm a bit confused about the extra "* 100" I had to apply to make the
  values match, not quite sure where that comes from?

 net/batman-adv/bat_v_elp.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 1d704574e6bf..014489f7f947 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -18,6 +18,7 @@
 #include <linux/if_ether.h>
 #include <linux/jiffies.h>
 #include <linux/kref.h>
+#include <linux/limits.h>
 #include <linux/minmax.h>
 #include <linux/netdevice.h>
 #include <linux/nl80211.h>
@@ -56,6 +57,25 @@ static void batadv_v_elp_start_timer(struct batadv_hard_iface *hard_iface)
 			   msecs_to_jiffies(msecs));
 }
 
+/**
+ * batadv_v_elp_get_throughput_from_11s() - get the throughput from 11s link
+ * @airtime: airtime link metric to a neighbor from an 11s link
+ *
+ * Return: The throughput towards the given neighbour in multiples of 100kpbs
+ *         (a value of '1' equals 0.1Mbps, '10' equals 1Mbps, etc).
+ */
+static u32 batadv_v_elp_get_throughput_from_11s(u32 airtime)
+{
+	const int tu_to_airtime_unit = 100;
+	const int test_frame_len = 8192;
+	const int tu_to_us = 1024;
+
+	if (!airtime)
+		return U32_MAX;
+
+	return test_frame_len * 100 * tu_to_airtime_unit / (airtime * tu_to_us);
+}
+
 /**
  * batadv_v_elp_get_throughput() - get the throughput towards a neighbour
  * @neigh: the neighbour for which the throughput has to be obtained
@@ -69,7 +89,7 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 	struct ethtool_link_ksettings link_settings;
 	struct net_device *real_netdev;
 	struct station_info sinfo;
-	u32 throughput;
+	u32 throughput, airtime;
 	int ret;
 
 	/* if the user specified a customised value for this interface, then
@@ -109,6 +129,11 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 		if (ret)
 			goto default_throughput;
 
+		if (sinfo.filled & BIT(NL80211_STA_INFO_AIRTIME_LINK_METRIC)) {
+			airtime = sinfo.airtime_link_metric;
+			return batadv_v_elp_get_throughput_from_11s(airtime);
+		}
+
 		if (sinfo.filled & BIT(NL80211_STA_INFO_EXPECTED_THROUGHPUT))
 			return sinfo.expected_throughput / 100;
 
-- 
2.47.1

