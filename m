Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C756C02187
	for <batman-adv@archiver.kernel.org>; Sun, 19 Jan 2025 23:03:30 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 15CA483D5E
	for <batman-adv@archiver.kernel.org>; Mon, 20 Jan 2025 00:03:29 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1737327809;
 b=gHAHozoclXGIViGnAwwiBbzFqoEZfdHOQPgQuNvLpG5TRlq9jARRb89URl1wwaZAxqsXq
 8DEoooh71ZSKn7pBndqlAxD++YtkyQHmKfQIM9AA81ORY9bqZGrKZf1EE0iNVeGcd/rnrk2
 hVYNgyiNnutzGOQ2fIe9vsYR2odj/1I=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1737327809; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=2z4bYp/G+57eVlDhdIHQGLibwUshwtncYygZtAxWtXg=;
 b=SCzaRE/d0mzzhMU6yKSSuJGd+HzVP14ebmR8z7q99U+mIbDhMlY8y+XkAdhq80JZt9Eal
 vFtRZCYvvRZw/3eFSiOGxDvIL/CPaeLs7voDg4Gwjg+I2EQ0OVwFiVXqcgRLmS0MMoa0dNQ
 e4g5dvd6jvuWsYoh5MRj0lSJbBRRLBU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 4D30480A45
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 20 Jan 2025 00:03:17 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1737327797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=2z4bYp/G+57eVlDhdIHQGLibwUshwtncYygZtAxWtXg=;
	b=f3DDrS36gmlmr9wvflz2XAYTN+sLCRZ/2PCMbpewvttrMQ4H7m9ZmDMSu1FSvx+/LdfmAo
	gbrhN68Oe53lAK+4SYrRi7fhbWFCXAca7bDAq3XCyJP80XZRepPf+F7fjpqJasEBPe0b4i
	39OoItn1QMbW2322y9UOL/OrwOqvBi8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=CAZbPGw2;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1737327797; a=rsa-sha256;
	cv=none;
	b=ugIGjKhbI0sv5HON2qC9eQ1yzx91aYVbsVPVyPCJolf9OXS8d1lS7F3fuFurXRn17+7VB2
	IzABVqkeBqwN5H2V89oc825Rkhe8UB/fW6rx/CsRv+YDvzRM2W9VTTfMTWwQZf1u9XFMPf
	CMAI0dnVE2kY9wesDUvofbX7/DpldRo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1737327796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2z4bYp/G+57eVlDhdIHQGLibwUshwtncYygZtAxWtXg=;
	b=CAZbPGw2e1jw0qMrk6eV4eawi47Yp3Rf1Z0aBvSUkrtkkIM+L3SJedbDtNu9Z6pmMho1x7
	YxkmVdfRs4A5SuabaawL/uNdkTcjKN87p1BFOjHxq6bKsIHTFDHKsGgGx9jaaV8wIuBJX1
	hcFk0OtjrFBZaWuCohJyJDTL5Bia438=
From: Sven Eckelmann <sven@narfation.org>
To: Andrew Strohman <andrew@andrewstrohman.com>
Cc: Remi Pommarel <repk@triplefau.lt>, b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH] batman-adv: fix panic during interface removal
Date: Mon, 20 Jan 2025 00:03:10 +0100
Message-ID: <15411496.tv2OnDr8pf@sven-l14>
In-Reply-To: 
 <CAA8ajJ=etpv--YNTww2uuYvNnoe2tCSNqas2cVLdZodHnqZb_g@mail.gmail.com>
References: 
 <20250109022756.1138030-1-andrew@andrewstrohman.com>
 <Z4EcPQOMU1BUtO07@pilgrim>
 <CAA8ajJ=etpv--YNTww2uuYvNnoe2tCSNqas2cVLdZodHnqZb_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4305532.1IzOArtZ34";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: HL7327V5HHN6A4RZ5NZHB7UGEZ2ZIHE2
X-Message-ID-Hash: HL7327V5HHN6A4RZ5NZHB7UGEZ2ZIHE2
X-MailFrom: sven@narfation.org
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/HL7327V5HHN6A4RZ5NZHB7UGEZ2ZIHE2/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart4305532.1IzOArtZ34
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Andrew Strohman <andrew@andrewstrohman.com>
Cc: Remi Pommarel <repk@triplefau.lt>, b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [PATCH] batman-adv: fix panic during interface removal
Date: Mon, 20 Jan 2025 00:03:10 +0100
Message-ID: <15411496.tv2OnDr8pf@sven-l14>
MIME-Version: 1.0

On Monday, 13 January 2025 08:35:05 GMT+1 Andrew Strohman wrote:
> Sven, does this change your opinion about how this
> issue should be handled? I'm not sure yet if it's safe
> to temporarily release RTNL lock during the
> duration of the cancel_work_sync() call.

No, it isn't

I understand my fault in thinking that it is safe to call 
cancel_work_sync in exactly this place. But you must still call this function 
for every bat_v.metric_work to ensure that this work is not running when the 
interface gets stopped.

Directly in batadv_v_elp_iface_disable was wrong because of the rtnl locking 
problem (by batadv_v_elp_get_throughput which requires it before calling 
__ethtool_get_link_ksettings). Which is in conflict with the backtrace:

#0  batadv_v_elp_iface_disable (hard_iface=hard_iface@entry=0xffff888009515800) at ../batman-adv/net/batman-adv/bat_v_elp.c:393
#1  0xffffffffa000a42e in batadv_v_iface_disable (hard_iface=0xffff888009515800) at ../batman-adv/net/batman-adv/bat_v.c:82
#2  0xffffffffa0028b7e in batadv_hardif_disable_interface (hard_iface=hard_iface@entry=0xffff888009515800) at ../batman-adv/net/batman-adv/hard-interface.c:848
#3  0xffffffffa0046dc0 in batadv_softif_destroy_netlink (soft_iface=0xffff88800c500000, head=0xffff88800b34fc90) at ../batman-adv/net/batman-adv/soft-interface.c:1125
#4  0xffffffff8216deaf in __rtnl_kill_links (net=0xffffffff84ff2c00 <init_net>, ops=<optimized out>) at net/core/rtnetlink.c:486
#5  __rtnl_link_unregister (ops=ops@entry=0xffffffffa006b4e0 <batadv_link_ops>) at net/core/rtnetlink.c:504
#6  0xffffffff82190442 in rtnl_link_unregister (ops=<optimized out>) at net/core/rtnetlink.c:541

batadv_softif_destroy_netlink is called with rtnl_lock held as you correctly 
pointed out. Causing the conflict.

In this case, we need to delay the call to cancel_work_sync in another 
context. For example, batadv_hardif_neigh_release is responsible to clean up 
resources and at the end is just calling kfree_rcu because it assumes that 
there is no pending work anywhere. If we want to change this, we unfortunately 
don't have access to the bat_algo anymore. And of course, it is also wrong 
because you are not allowed to sleep inside inside a call_rcu callback. So, 
something like this will also not work:


diff --git a/net/batman-adv/bat_algo.c b/net/batman-adv/bat_algo.c
index 4eee53d19eb047bea986184498a3ef98ed6c84df..84b20640861b3e2df5dbf2906e2374b49670201b 100644
--- a/net/batman-adv/bat_algo.c
+++ b/net/batman-adv/bat_algo.c
@@ -77,6 +77,7 @@ int batadv_algo_register(struct batadv_algo_ops *bat_algo_ops)
 	    !bat_algo_ops->iface.update_mac ||
 	    !bat_algo_ops->iface.primary_set ||
 	    !bat_algo_ops->neigh.cmp ||
+	    !bat_algo_ops->neigh.hardif_init ||
 	    !bat_algo_ops->neigh.is_similar_or_better) {
 		pr_info("Routing algo '%s' does not implement required ops\n",
 			bat_algo_ops->name);
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 07ae5dd1f150b062e97897b269d45b041e8b4dfe..6356ac0ac761b8a2e62fd4d5e1ae7319ab24db85 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -2497,6 +2497,18 @@ static void batadv_iv_gw_dump(struct sk_buff *msg, struct netlink_callback *cb,
 	cb->args[0] = idx_skip;
 }
 
+static void
+batadv_iv_hardif_neigh_init(struct batadv_hardif_neigh_node *hardif_neigh)
+{
+#ifdef CONFIG_BATMAN_ADV_BATMAN_V
+	/* initialize the metric work to ensure that batadv_hardif_neigh_release
+	 * can cancel the pending work independent of the used routing
+	 * algorithm implementation
+	 */
+	INIT_WORK(&hardif_neigh->bat_v.metric_work, NULL);
+#endif
+}
+
 static struct batadv_algo_ops batadv_batman_iv __read_mostly = {
 	.name = "BATMAN_IV",
 	.iface = {
@@ -2507,6 +2519,7 @@ static struct batadv_algo_ops batadv_batman_iv __read_mostly = {
 		.primary_set = batadv_iv_ogm_primary_iface_set,
 	},
 	.neigh = {
+		.hardif_init = batadv_iv_hardif_neigh_init,
 		.cmp = batadv_iv_ogm_neigh_cmp,
 		.is_similar_or_better = batadv_iv_ogm_neigh_is_sob,
 		.dump = batadv_iv_ogm_neigh_dump,
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index bcc2e20e0cd6c7077f3d148f8c77b0947561ed3d..51b19c2782fb780aeb160d9054f5b370fd1f3fe0 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -258,6 +258,23 @@ void batadv_neigh_ifinfo_release(struct kref *ref)
 	kfree_rcu(neigh_ifinfo, rcu);
 }
 
+/**
+ * batadv_hardif_neigh_free_rcu() - free the hardif_neigh
+ * @rcu: rcu pointer of the hardif_neigh
+ */
+static void batadv_hardif_neigh_free_rcu(struct rcu_head *rcu)
+{
+	struct batadv_hardif_neigh_node *hardif_neigh;
+
+	hardif_neigh = container_of(rcu, struct batadv_hardif_neigh_node, rcu);
+
+#ifdef CONFIG_BATMAN_ADV_BATMAN_V
+	cancel_work_sync(&hardif_neigh->bat_v.metric_work);
+#endif
+
+	kfree(hardif_neigh);
+}
+
 /**
  * batadv_hardif_neigh_release() - release hardif neigh node from lists and
  *  queue for free after rcu grace period
@@ -275,7 +292,7 @@ void batadv_hardif_neigh_release(struct kref *ref)
 	spin_unlock_bh(&hardif_neigh->if_incoming->neigh_list_lock);
 
 	batadv_hardif_put(hardif_neigh->if_incoming);
-	kfree_rcu(hardif_neigh, rcu);
+	call_rcu(&hardif_neigh->rcu, batadv_hardif_neigh_free_rcu);
 }
 
 /**
@@ -590,8 +607,7 @@ batadv_hardif_neigh_create(struct batadv_hard_iface *hard_iface,
 
 	kref_init(&hardif_neigh->refcount);
 
-	if (bat_priv->algo_ops->neigh.hardif_init)
-		bat_priv->algo_ops->neigh.hardif_init(hardif_neigh);
+	bat_priv->algo_ops->neigh.hardif_init(hardif_neigh);
 
 	hlist_add_head_rcu(&hardif_neigh->list, &hard_iface->neigh_list);
 




At this point, it starts to become complicated. For example by using a two phase deletion. The first part cleans the main resources and adds it to a free list. This free list is then cleaned up in a better context. But doing something like requires a major rework of the codebase


Attempting to work around the rtnl_lock by trylocking, sounded "good" when thinking about it:


diff --git a/net/batman-adv/bat_algo.c b/net/batman-adv/bat_algo.c
index 4eee53d19eb047bea986184498a3ef98ed6c84df..84b20640861b3e2df5dbf2906e2374b49670201b 100644
--- a/net/batman-adv/bat_algo.c
+++ b/net/batman-adv/bat_algo.c
@@ -77,6 +77,7 @@ int batadv_algo_register(struct batadv_algo_ops *bat_algo_ops)
 	    !bat_algo_ops->iface.update_mac ||
 	    !bat_algo_ops->iface.primary_set ||
 	    !bat_algo_ops->neigh.cmp ||
+	    !bat_algo_ops->neigh.hardif_init ||
 	    !bat_algo_ops->neigh.is_similar_or_better) {
 		pr_info("Routing algo '%s' does not implement required ops\n",
 			bat_algo_ops->name);
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 07ae5dd1f150b062e97897b269d45b041e8b4dfe..6356ac0ac761b8a2e62fd4d5e1ae7319ab24db85 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -2497,6 +2497,18 @@ static void batadv_iv_gw_dump(struct sk_buff *msg, struct netlink_callback *cb,
 	cb->args[0] = idx_skip;
 }
 
+static void
+batadv_iv_hardif_neigh_init(struct batadv_hardif_neigh_node *hardif_neigh)
+{
+#ifdef CONFIG_BATMAN_ADV_BATMAN_V
+	/* initialize the metric work to ensure that batadv_hardif_neigh_release
+	 * can cancel the pending work independent of the used routing
+	 * algorithm implementation
+	 */
+	INIT_WORK(&hardif_neigh->bat_v.metric_work, NULL);
+#endif
+}
+
 static struct batadv_algo_ops batadv_batman_iv __read_mostly = {
 	.name = "BATMAN_IV",
 	.iface = {
@@ -2507,6 +2519,7 @@ static struct batadv_algo_ops batadv_batman_iv __read_mostly = {
 		.primary_set = batadv_iv_ogm_primary_iface_set,
 	},
 	.neigh = {
+		.hardif_init = batadv_iv_hardif_neigh_init,
 		.cmp = batadv_iv_ogm_neigh_cmp,
 		.is_similar_or_better = batadv_iv_ogm_neigh_is_sob,
 		.dump = batadv_iv_ogm_neigh_dump,
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 03d5d19306b5b1399523397e7b443ec563766fa0..61b3edd4bb1631e3be1102863c47eab1a69a5400 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -131,9 +131,7 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 	/* if not a wifi interface, check if this device provides data via
 	 * ethtool (e.g. an Ethernet adapter)
 	 */
-	rtnl_lock();
 	ret = __ethtool_get_link_ksettings(hard_iface->net_dev, &link_settings);
-	rtnl_unlock();
 	if (ret == 0) {
 		/* link characteristics might change over time */
 		if (link_settings.base.duplex == DUPLEX_FULL)
@@ -175,8 +173,14 @@ void batadv_v_elp_throughput_metric_update(struct work_struct *work)
 	neigh = container_of(neigh_bat_v, struct batadv_hardif_neigh_node,
 			     bat_v);
 
-	ewma_throughput_add(&neigh->bat_v.throughput,
-			    batadv_v_elp_get_throughput(neigh));
+        if (!rtnl_trylock()) {
+                queue_work(batadv_event_workqueue, work);
+                return;
+        }
+
+        ewma_throughput_add(&neigh->bat_v.throughput,
+                            batadv_v_elp_get_throughput(neigh));
+        rtnl_unlock();
 
 	/* decrement refcounter to balance increment performed before scheduling
 	 * this task
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index bcc2e20e0cd6c7077f3d148f8c77b0947561ed3d..eb0ddaade08f876ea079dd91489e15145e00f246 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -270,6 +270,10 @@ void batadv_hardif_neigh_release(struct kref *ref)
 	hardif_neigh = container_of(ref, struct batadv_hardif_neigh_node,
 				    refcount);
 
+#ifdef CONFIG_BATMAN_ADV_BATMAN_V
+	cancel_work_sync(&hardif_neigh->bat_v.metric_work);
+#endif
+
 	spin_lock_bh(&hardif_neigh->if_incoming->neigh_list_lock);
 	hlist_del_init_rcu(&hardif_neigh->list);
 	spin_unlock_bh(&hardif_neigh->if_incoming->neigh_list_lock);
@@ -590,8 +594,7 @@ batadv_hardif_neigh_create(struct batadv_hard_iface *hard_iface,
 
 	kref_init(&hardif_neigh->refcount);
 
-	if (bat_priv->algo_ops->neigh.hardif_init)
-		bat_priv->algo_ops->neigh.hardif_init(hardif_neigh);
+	bat_priv->algo_ops->neigh.hardif_init(hardif_neigh);
 
 	hlist_add_head_rcu(&hardif_neigh->list, &hard_iface->neigh_list);
 


But I directly get a "possible recursive locking detected":

[   12.495682][  T299] ============================================
[   12.496199][  T299] WARNING: possible recursive locking detected
[   12.496610][  T299] 6.12.0 #1 Tainted: G           O
[   12.496932][  T299] --------------------------------------------
[   12.497419][  T299] kworker/u8:3/299 is trying to acquire lock:
[   12.497810][  T299] ffff88800a50ac68 ((work_completion)(&(&hardif_neigh->bat_v.metric_work)->work)){+.+.}-{0:0}, at: start_flush_work+0x3b7/0x9b0
[   12.498541][  T299]
[   12.498541][  T299] but task is already holding lock:
[   12.498961][  T299] ffff88800d417d80 ((work_completion)(&(&hardif_neigh->bat_v.metric_work)->work)){+.+.}-{0:0}, at: process_one_work+0x7fc/0x15a0
[   12.499698][  T299]
[   12.499698][  T299] other info that might help us debug this:
[   12.500123][  T299]  Possible unsafe locking scenario:
[   12.500123][  T299]
[   12.500539][  T299]        CPU0
[   12.500760][  T299]        ----
[   12.500976][  T299]   lock((work_completion)(&(&hardif_neigh->bat_v.metric_work)->work));
[   12.501391][  T299]   lock((work_completion)(&(&hardif_neigh->bat_v.metric_work)->work));
[   12.501843][  T299]
[   12.501843][  T299]  *** DEADLOCK ***
[   12.501843][  T299]
[   12.502256][  T299]  May be due to missing lock nesting notation
[   12.502256][  T299]
[   12.502679][  T299] 3 locks held by kworker/u8:3/299:
[   12.502967][  T299]  #0: ffff88800a6b8958 ((wq_completion)bat_events){+.+.}-{0:0}, at: process_one_work+0xd04/0x15a0
[   12.503535][  T299]  #1: ffff88800d417d80 ((work_completion)(&(&hardif_neigh->bat_v.metric_work)->work)){+.+.}-{0:0}, at: process_one_work+0x7fc/0x15a0
[   12.504341][  T299]  #2: ffffffff83608000 (rcu_read_lock){....}-{1:2}, at: start_flush_work+0x2d/0x9b0



And it is getting too late to look at this in more detail. But it seems like 
the relevant batadv_hardif_neigh_put happened inside 
batadv_v_elp_throughput_metric_update. And of course then we would try to 
cancel the work when still in the work. And this too obvious in hindsight.

I would therefore prefer to have the worker inside the hard_iface and cancel 
it there. The worker must then iterate over the batadv_hardif_neigh_node. 
Otherwise, iterating over the rcu list in 
batadv_v_elp_throughput_metric_update would potentially miss entries. But at 
the same time, you would then potentially sleep in rcu_read_lock() - which is 
not allowed. See (batadv_v_elp_periodic_work for details).



To work around this problem, we could do something like this in
batadv_v_elp_periodic_work:

diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index ac11f1f0..d35479c4 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -113,8 +113,6 @@ static void
 batadv_v_hardif_neigh_init(struct batadv_hardif_neigh_node *hardif_neigh)
 {
 	ewma_throughput_init(&hardif_neigh->bat_v.throughput);
-	INIT_WORK(&hardif_neigh->bat_v.metric_work,
-		  batadv_v_elp_throughput_metric_update);
 }
 
 /**
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index fbf499bc..a752f564 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -131,9 +131,13 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 	/* if not a wifi interface, check if this device provides data via
 	 * ethtool (e.g. an Ethernet adapter)
 	 */
-	rtnl_lock();
-	ret = __ethtool_get_link_ksettings(hard_iface->net_dev, &link_settings);
-	rtnl_unlock();
+	if (!rtnl_trylock()) {
+		// TODO would be better not to safe the default value in this case
+		ret = -EBUSY;
+	} else {
+		ret = __ethtool_get_link_ksettings(hard_iface->net_dev, &link_settings);
+		rtnl_unlock();
+	}
 	if (ret == 0) {
 		/* link characteristics might change over time */
 		if (link_settings.base.duplex == DUPLEX_FULL)
@@ -165,23 +169,10 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
  *  metric of a single hop neighbour
  * @work: the work queue item
  */
-void batadv_v_elp_throughput_metric_update(struct work_struct *work)
+static void batadv_v_elp_throughput_metric_update(struct batadv_hardif_neigh_node *neigh)
 {
-	struct batadv_hardif_neigh_node_bat_v *neigh_bat_v;
-	struct batadv_hardif_neigh_node *neigh;
-
-	neigh_bat_v = container_of(work, struct batadv_hardif_neigh_node_bat_v,
-				   metric_work);
-	neigh = container_of(neigh_bat_v, struct batadv_hardif_neigh_node,
-			     bat_v);
-
 	ewma_throughput_add(&neigh->bat_v.throughput,
 			    batadv_v_elp_get_throughput(neigh));
-
-	/* decrement refcounter to balance increment performed before scheduling
-	 * this task
-	 */
-	batadv_hardif_neigh_put(neigh);
 }
 
 /**
@@ -247,6 +238,11 @@ batadv_v_elp_wifi_neigh_probe(struct batadv_hardif_neigh_node *neigh)
 	return true;
 }
 
+struct batadv_v_metric_queue_entry {
+	struct batadv_hardif_neigh_node *hardif_neigh;
+	struct list_head list;
+};
+
 /**
  * batadv_v_elp_periodic_work() - ELP periodic task per interface
  * @work: work queue item
@@ -255,14 +251,16 @@ batadv_v_elp_wifi_neigh_probe(struct batadv_hardif_neigh_node *neigh)
  */
 static void batadv_v_elp_periodic_work(struct work_struct *work)
 {
+	struct batadv_v_metric_queue_entry *metric_entry;
+	struct batadv_v_metric_queue_entry *metric_safe;
 	struct batadv_hardif_neigh_node *hardif_neigh;
 	struct batadv_hard_iface *hard_iface;
 	struct batadv_hard_iface_bat_v *bat_v;
 	struct batadv_elp_packet *elp_packet;
+	struct list_head metric_queue;
 	struct batadv_priv *bat_priv;
 	struct sk_buff *skb;
 	u32 elp_interval;
-	bool ret;
 
 	bat_v = container_of(work, struct batadv_hard_iface_bat_v, elp_wq.work);
 	hard_iface = container_of(bat_v, struct batadv_hard_iface, bat_v);
@@ -298,6 +296,8 @@ static void batadv_v_elp_periodic_work(struct work_struct *work)
 
 	atomic_inc(&hard_iface->bat_v.elp_seqno);
 
+	INIT_LIST_HEAD(&metric_queue);
+
 	/* The throughput metric is updated on each sent packet. This way, if a
 	 * node is dead and no longer sends packets, batman-adv is still able to
 	 * react timely to its death.
@@ -320,18 +320,25 @@ static void batadv_v_elp_periodic_work(struct work_struct *work)
 		if (!kref_get_unless_zero(&hardif_neigh->refcount))
 			continue;
 
-		/* Reading the estimated throughput from cfg80211 is a task that
-		 * may sleep and that is not allowed in an rcu protected
-		 * context. Therefore schedule a task for that.
-		 */
-		ret = queue_work(batadv_event_workqueue,
-				 &hardif_neigh->bat_v.metric_work);
-
-		if (!ret)
+		metric_entry = kzalloc(sizeof(*metric_entry), GFP_ATOMIC);
+		if (!metric_entry) {
 			batadv_hardif_neigh_put(hardif_neigh);
+			continue;
+		}
+
+		metric_entry->hardif_neigh = hardif_neigh;
+		list_add(&metric_entry->list, &metric_queue);
 	}
 	rcu_read_unlock();
 
+	list_for_each_entry_safe(metric_entry, metric_safe, &metric_queue, list) {
+		batadv_v_elp_throughput_metric_update(metric_entry->hardif_neigh);
+
+		batadv_hardif_neigh_put(metric_entry->hardif_neigh);
+		list_del(&metric_entry->list);
+		kfree(metric_entry);
+	}
+
 restart_timer:
 	batadv_v_elp_start_timer(hard_iface);
 out:
diff --git a/net/batman-adv/bat_v_elp.h b/net/batman-adv/bat_v_elp.h
index 9e274019..29e4177b 100644
--- a/net/batman-adv/bat_v_elp.h
+++ b/net/batman-adv/bat_v_elp.h
@@ -19,6 +19,5 @@ void batadv_v_elp_iface_activate(struct batadv_hard_iface *primary_iface,
 void batadv_v_elp_primary_iface_set(struct batadv_hard_iface *primary_iface);
 int batadv_v_elp_packet_recv(struct sk_buff *skb,
 			     struct batadv_hard_iface *if_incoming);
-void batadv_v_elp_throughput_metric_update(struct work_struct *work);
 
 #endif /* _NET_BATMAN_ADV_BAT_V_ELP_H_ */
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index f491bff8..fe89f085 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -596,9 +596,6 @@ struct batadv_hardif_neigh_node_bat_v {
 	 *  neighbor
 	 */
 	unsigned long last_unicast_tx;
-
-	/** @metric_work: work queue callback item for metric update */
-	struct work_struct metric_work;
 };
 
 /**



Kind regards,
	Sven
--nextPart4305532.1IzOArtZ34
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZ42ErgAKCRBND3cr0xT1
yycaAQClZaFJ5LWti1XAUFlM3i2Bv9zPJ1eetOxuHpaDogxuSQD+JEZqh2HEk07O
dLuewJfd0CajM0wU3uOLYK/LhAYwlwk=
=yw2T
-----END PGP SIGNATURE-----

--nextPart4305532.1IzOArtZ34--



