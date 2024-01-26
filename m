Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACAFCC48260
	for <batman@archiver.kernel.org>; Fri, 26 Jan 2024 14:36:49 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 90F9183E11
	for <batman@archiver.kernel.org>; Fri, 26 Jan 2024 15:36:47 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1706279807;
 b=g1nS5jRyKfrKp+WhzzJAGGWO48hChPM2HuncHfyH4gPUxqiGKmUnTAqKMZN1928eT+qpb
 2zHBOpIdBlp+2lhyMAeMzR+6/zcyL5kuFOhrn7ByfI9VQziKacV3d658IlbTO0O7JNT92if
 P7xwie5kQ0EGlPZ1Q5dX+aAvJLJApJ0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1706279807; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=YSh0pxawl9jn40E6SdFZFc6giUIchWJMmV6FLhrYGIM=;
 b=u4LOiJFg1TloW5I5LsHs5adIxAujB/Kn3KBbjakidL1cUv7rXM9+3YWRouQHH8A0CzNgI
 6ddoygYX6wYd/8Sau83utBy9jRldfXuXr4ks7/M51bqx9DJcXryf0iL3sKzBRln8+aWIgCH
 boT528ng6KOpovNi0pYFVjSIYDsLzQM=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de
 [IPv6:2a01:4f8:c2c:665b::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id D799380DE2
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 26 Jan 2024 15:36:40 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1706279800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YSh0pxawl9jn40E6SdFZFc6giUIchWJMmV6FLhrYGIM=;
	b=l5dg2d5ElpWtaIg2UoEK7aQhntGE/nCrXJrp464rj7rWVo2y/WAHiwM9Qs+dL0mRE0Ki+3
	+8YZbaPW8NTjeXB2KX5RJiGgbkWU99WotjG/xn/FkjvAsQbhgYvUpa6FMmwH6IYLCvqhpL
	h99fg5M6XmKWje2C0ZExkU0WccjJ2fk=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1706279800; a=rsa-sha256;
	cv=none;
	b=0rl120gksuc+SQnO4Z5lSmiFP59Vd8tgIp8Jxxv0HRtDQu4+k7AYAlWknGq89aTdWqMjO4
	Ya4CGD2Y344drKWNb5yJ/Z87UWiNCamAcQvDHpQymHpOrEe8YAeq5L030ai8Ere5zvc/VW
	IrW0ds9O/dmmGsD8hF3PwHh+WjcTUgM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 2a01:4f8:c2c:665b::1 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue;
	dmarc=none
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 25D5040B8F;
	Fri, 26 Jan 2024 15:36:37 +0100 (CET)
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
Subject: [PATCH net] bridge: mcast: fix disabled snooping after long uptime
Date: Fri, 26 Jan 2024 15:36:07 +0100
Message-ID: <20240126143607.5649-1-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: OOHYBC7DBDLUSM3KQM4VFYLFQPE4LDQT
X-Message-ID-Hash: OOHYBC7DBDLUSM3KQM4VFYLFQPE4LDQT
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/OOHYBC7DBDLUSM3KQM4VFYLFQPE4LDQT/>
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
 net/bridge/br_multicast.c | 20 +++++++++++++++-----
 net/bridge/br_private.h   |  4 ++--
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index d7d021af1029..df14ee36ea20 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1762,6 +1762,10 @@ static void br_ip6_multicast_querier_expired(struct timer_list *t)
 }
 #endif
 
+static inline void br_multicast_query_delay_expired(struct timer_list *t)
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

