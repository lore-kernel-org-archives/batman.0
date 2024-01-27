Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 216C5C46CD2
	for <batman@archiver.kernel.org>; Sat, 27 Jan 2024 17:50:47 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 72460810BA
	for <batman@archiver.kernel.org>; Sat, 27 Jan 2024 18:50:46 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1706377846;
 b=VnHKdcKOKw660E7CvqtH1RziDTG6xkYyPqZ7tMi56oGssFHk2WV1i15co8DuPB63b1TBF
 8V7UXIDDvL6x8XB/ySgH06XaB3lsa0dZwD9rs3IA25AjKeYTRl6L91ajkU08x/qEKfTCAPH
 1FJ1TemVYwMGV0THn8z15P/6vcix1Js=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1706377846; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=sienYtyOe0bZowCYlw5iFSE3n+Ew2Psp8LZteTENY3g=;
 b=hUvxzi+prgxes4di5thEp4t56zZ33Vi0/jYuImVfaEIaEuiJ2b6YMs7p2ZAP5DlBmhl3D
 U7w36Ky0NoJRgydv6xTY22cU2q1LgKIZsozogb/9n/Z2DuvsC7xCJRqjAFcepCFHrTmXmZq
 jvKDGU46kOgTx4eL4ynjuSyBZK5aczs=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 22AEC80BF7
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 27 Jan 2024 18:50:39 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1706377839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sienYtyOe0bZowCYlw5iFSE3n+Ew2Psp8LZteTENY3g=;
	b=pro03d6uiMsq3L39ZbfXLZy55I2sW+IXYtsuSBpxpajJqqAuRQSZyArv81k2XHM5KN23nn
	VNU0WH4dlIlshDufe5xz5kfAN+1d6iss0aQI/rMZ4Hz1V/t8Mjf/dIi/bfwQPR+YRMIRYO
	0T8JeodbJxtErjtF7I1q8/HIAI/u3VU=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1706377839; a=rsa-sha256;
	cv=none;
	b=hdxpF7k3FUeK2AeFwf2Um5amZJm3jhhN9K8IGOPosCQZAKofRsR9weW8f25gFRBzb17bGS
	PLUGIGcTtaG5ILdIGgzvm2HwtvtoPhFotQqIOazdO+dPDfHhB4ZZlDV5zUntTQs9U27JFO
	EpCFHBH6tJAaKpal4VoZTd2Pn6fW+ac=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 116.203.183.178 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue;
	dmarc=none
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7F18A40D6C;
	Sat, 27 Jan 2024 18:50:35 +0100 (CET)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux.dev,
	b.a.t.m.a.n@lists.open-mesh.org,
	linux-kernel@vger.kernel.org,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH net v2] bridge: mcast: fix disabled snooping after long uptime
Date: Sat, 27 Jan 2024 18:50:32 +0100
Message-ID: <20240127175033.9640-1-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: HUVVMISZQTFJIKJZKADKKCEGCSNOQKIS
X-Message-ID-Hash: HUVVMISZQTFJIKJZKADKKCEGCSNOQKIS
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/HUVVMISZQTFJIKJZKADKKCEGCSNOQKIS/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The original idea of the delay_time check was to not apply multicast
snooping too early when an MLD querier appears. And to instead wait at
least for MLD reports to arrive before switching from flooding to group
based, MLD snooped forwarding, to avoid temporary packet loss.

However in a batman-adv mesh network it was noticed that after 248 days of
uptime 32bit MIPS based devices would start to signal that they had
stopped applying multicast snooping due to missing queriers - even though
they were the elected querier and still sending MLD queries themselves.

While time_is_before_jiffies() generally is safe against jiffies
wrap-arounds, like the code comments in jiffies.h explain, it won't
be able to track a difference larger than ULONG_MAX/2. With a 32bit
large jiffies and one jiffies tick every 10ms (CONFIG_HZ=100) on these MIPS
devices running OpenWrt this would result in a difference larger than
ULONG_MAX/2 after 248 (= 2^32/100/60/60/24/2) days and
time_is_before_jiffies() would then start to return false instead of
true. Leading to multicast snooping not being applied to multicast
packets anymore.

Fix this issue by using a proper timer_list object which won't have this
ULONG_MAX/2 difference limitation.

Fixes: b00589af3b04 ("bridge: disable snooping if there is no querier")
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
Changelog v2:
* removed "inline" from br_multicast_query_delay_expired()

 net/bridge/br_multicast.c | 20 +++++++++++++++-----
 net/bridge/br_private.h   |  4 ++--
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index d7d021af1029..2d7b73242958 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1762,6 +1762,10 @@ static void br_ip6_multicast_querier_expired(struct timer_list *t)
 }
 #endif
 
+static void br_multicast_query_delay_expired(struct timer_list *t)
+{
+}
+
 static void br_multicast_select_own_querier(struct net_bridge_mcast *brmctx,
 					    struct br_ip *ip,
 					    struct sk_buff *skb)
@@ -3198,7 +3202,7 @@ br_multicast_update_query_timer(struct net_bridge_mcast *brmctx,
 				unsigned long max_delay)
 {
 	if (!timer_pending(&query->timer))
-		query->delay_time = jiffies + max_delay;
+		mod_timer(&query->delay_timer, jiffies + max_delay);
 
 	mod_timer(&query->timer, jiffies + brmctx->multicast_querier_interval);
 }
@@ -4041,13 +4045,11 @@ void br_multicast_ctx_init(struct net_bridge *br,
 	brmctx->multicast_querier_interval = 255 * HZ;
 	brmctx->multicast_membership_interval = 260 * HZ;
 
-	brmctx->ip4_other_query.delay_time = 0;
 	brmctx->ip4_querier.port_ifidx = 0;
 	seqcount_spinlock_init(&brmctx->ip4_querier.seq, &br->multicast_lock);
 	brmctx->multicast_igmp_version = 2;
 #if IS_ENABLED(CONFIG_IPV6)
 	brmctx->multicast_mld_version = 1;
-	brmctx->ip6_other_query.delay_time = 0;
 	brmctx->ip6_querier.port_ifidx = 0;
 	seqcount_spinlock_init(&brmctx->ip6_querier.seq, &br->multicast_lock);
 #endif
@@ -4056,6 +4058,8 @@ void br_multicast_ctx_init(struct net_bridge *br,
 		    br_ip4_multicast_local_router_expired, 0);
 	timer_setup(&brmctx->ip4_other_query.timer,
 		    br_ip4_multicast_querier_expired, 0);
+	timer_setup(&brmctx->ip4_other_query.delay_timer,
+		    br_multicast_query_delay_expired, 0);
 	timer_setup(&brmctx->ip4_own_query.timer,
 		    br_ip4_multicast_query_expired, 0);
 #if IS_ENABLED(CONFIG_IPV6)
@@ -4063,6 +4067,8 @@ void br_multicast_ctx_init(struct net_bridge *br,
 		    br_ip6_multicast_local_router_expired, 0);
 	timer_setup(&brmctx->ip6_other_query.timer,
 		    br_ip6_multicast_querier_expired, 0);
+	timer_setup(&brmctx->ip6_other_query.delay_timer,
+		    br_multicast_query_delay_expired, 0);
 	timer_setup(&brmctx->ip6_own_query.timer,
 		    br_ip6_multicast_query_expired, 0);
 #endif
@@ -4197,10 +4203,12 @@ static void __br_multicast_stop(struct net_bridge_mcast *brmctx)
 {
 	del_timer_sync(&brmctx->ip4_mc_router_timer);
 	del_timer_sync(&brmctx->ip4_other_query.timer);
+	del_timer_sync(&brmctx->ip4_other_query.delay_timer);
 	del_timer_sync(&brmctx->ip4_own_query.timer);
 #if IS_ENABLED(CONFIG_IPV6)
 	del_timer_sync(&brmctx->ip6_mc_router_timer);
 	del_timer_sync(&brmctx->ip6_other_query.timer);
+	del_timer_sync(&brmctx->ip6_other_query.delay_timer);
 	del_timer_sync(&brmctx->ip6_own_query.timer);
 #endif
 }
@@ -4643,13 +4651,15 @@ int br_multicast_set_querier(struct net_bridge_mcast *brmctx, unsigned long val)
 	max_delay = brmctx->multicast_query_response_interval;
 
 	if (!timer_pending(&brmctx->ip4_other_query.timer))
-		brmctx->ip4_other_query.delay_time = jiffies + max_delay;
+		mod_timer(&brmctx->ip4_other_query.delay_timer,
+			  jiffies + max_delay);
 
 	br_multicast_start_querier(brmctx, &brmctx->ip4_own_query);
 
 #if IS_ENABLED(CONFIG_IPV6)
 	if (!timer_pending(&brmctx->ip6_other_query.timer))
-		brmctx->ip6_other_query.delay_time = jiffies + max_delay;
+		mod_timer(&brmctx->ip6_other_query.delay_timer,
+			  jiffies + max_delay);
 
 	br_multicast_start_querier(brmctx, &brmctx->ip6_own_query);
 #endif
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index b0a92c344722..86ea5e6689b5 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -78,7 +78,7 @@ struct bridge_mcast_own_query {
 /* other querier */
 struct bridge_mcast_other_query {
 	struct timer_list		timer;
-	unsigned long			delay_time;
+	struct timer_list		delay_timer;
 };
 
 /* selected querier */
@@ -1159,7 +1159,7 @@ __br_multicast_querier_exists(struct net_bridge_mcast *brmctx,
 		own_querier_enabled = false;
 	}
 
-	return time_is_before_jiffies(querier->delay_time) &&
+	return !timer_pending(&querier->delay_timer) &&
 	       (own_querier_enabled || timer_pending(&querier->timer));
 }
 
-- 
2.43.0

