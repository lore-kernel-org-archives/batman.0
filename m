Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1049E77198
	for <batman@archiver.kernel.org>; Tue,  7 Jan 2025 15:12:15 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3663784091
	for <batman@archiver.kernel.org>; Tue,  7 Jan 2025 16:12:14 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1736262734;
 b=RK+Nqx3q8wTMtGILDyq0xWlyj2ReCk2X7opSFo+6/U3heIb9KWh3auwG8RYbc70edyxtu
 V6DMqbkXwp0hKRx0BFGosl/NttSZYe8RK/ByAVNXFVdi01P7O3GrAPfy+SES9nBsPqmgP5r
 30L3XFyVfa64K99jaC9v/rZT2pJwPwo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1736262734; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=kzqP3KWquCSCvitwLtozsomdOR3PJTWU3++JR+6rcS0=;
 b=m40V8V62sGrPM1/xDr6l4L9i4nvOTW4v9PSLMdVviFSo98TrSX6HRCYkKjDOq1cycqUj4
 nFPQPwbXto7rXaZPzLov7lxw30XRzRLPAOrfstBKcK+UsOF+0tUUE1Q5Qpj0x8WzaNpjMhH
 JytrfINiMV6/fd4ZzL7f3DQhAEpo3LY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=amazon.com header.i=@amazon.com;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=amazon.com header.i=@amazon.com; arc=pass; dmarc=none
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com
 [52.119.213.150])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id C9862817A8
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue,  7 Jan 2025 15:47:38 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1736261259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=kzqP3KWquCSCvitwLtozsomdOR3PJTWU3++JR+6rcS0=;
	b=2EklS621rBWgttUrObhdctir4bBJ7e2QdqPAaTpsLGTuZZzM7bSj40eivey4btVRAcnlcI
	O1L6ycU1sCErWiVcB0LEVfMzfkDajp9WgH34lHQWEm+ePY3sNKZT1zcBT5J9f8uMzvqb5b
	YL6TGE2q/Tafl+LJaVod8EReEpgnNSQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=amazon.com header.s=amazon201209 header.b=OrUAWnXR;
	dmarc=pass (policy=quarantine) header.from=amazon.com;
	spf=pass (diktynna.open-mesh.org: domain of
 "prvs=09534159b=kuniyu@amazon.co.jp" designates 52.119.213.150 as permitted
 sender) smtp.mailfrom="prvs=09534159b=kuniyu@amazon.co.jp"
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1736261259; a=rsa-sha256;
	cv=none;
	b=VYVpBtB0V6VVJtmP8vBVHxZN4s/o9m4BlHLbtQHHklEd4XPYmcPuxcBheXVuSEIntYNVMw
	KAn5SFds5U1Y/DPJVzE6pvKhmOu0WuvSUQQJEvnRHuP0grbJSI0BcTAlcQCl/7YYk7h0j/
	gI7XEsXWkiNweyKDBz/zmWB2kfiGg4I=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736261258; x=1767797258;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kzqP3KWquCSCvitwLtozsomdOR3PJTWU3++JR+6rcS0=;
  b=OrUAWnXRrURQQuBOWBguVp9babg+GITHNQJUXvVVUPXVvjbJU/m4czDY
   2INa7wSJ9vJkGNI5dsf65S0IUOhYXhFq9nCkVelI8N+g+B/ksiqG6lyMj
   wdejsU15dUprK+SimleOSLiyz58MxHo+9j/g9XV3EnjQL0JRbltRAl90S
   c=;
X-IronPort-AV: E=Sophos;i="6.12,295,1728950400";
   d="scan'208";a="687495332"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 14:47:34 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:43223]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.48:2525]
 with esmtp (Farcaster)
 id 9b48386a-8619-40f1-8b35-660ddef4cf53; Tue, 7 Jan 2025 14:47:33 +0000 (UTC)
X-Farcaster-Flow-ID: 9b48386a-8619-40f1-8b35-660ddef4cf53
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 7 Jan 2025 14:47:33 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.249.113) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 7 Jan 2025 14:47:24 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <shaw.leon@gmail.com>
CC: <andrew+netdev@lunn.ch>, <b.a.t.m.a.n@lists.open-mesh.org>,
	<bpf@vger.kernel.org>, <bridge@lists.linux.dev>, <davem@davemloft.net>,
	<donald.hunter@gmail.com>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <idosch@nvidia.com>, <jiri@resnulli.us>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <linux-can@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-ppp@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-wireless@vger.kernel.org>, <linux-wpan@vger.kernel.org>,
	<liuhangbin@gmail.com>, <netdev@vger.kernel.org>,
	<osmocom-net-gprs@lists.osmocom.org>, <pabeni@redhat.com>,
	<shuah@kernel.org>, <wireguard@lists.zx2c4.com>
Subject: Re: [PATCH net-next v7 00/11] net: Improve netns handling in
 rtnetlink
Date: Tue, 7 Jan 2025 23:47:14 +0900
Message-ID: <20250107144714.74446-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: 
 <CABAhCOQdBL6h9M2C+kd+bGivRJ9Q72JUxW+-gur0nub_=PmFPA@mail.gmail.com>
References: 
 <CABAhCOQdBL6h9M2C+kd+bGivRJ9Q72JUxW+-gur0nub_=PmFPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.118.249.113]
X-ClientProxiedBy: EX19D045UWC004.ant.amazon.com (10.13.139.203) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-MailFrom: prvs=09534159b=kuniyu@amazon.co.jp
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: HC2K2CTKJMQVKM4BWWW4DPQ2IAYC3ZHU
X-Message-ID-Hash: HC2K2CTKJMQVKM4BWWW4DPQ2IAYC3ZHU
X-Mailman-Approved-At: Tue, 07 Jan 2025 16:11:15 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/HC2K2CTKJMQVKM4BWWW4DPQ2IAYC3ZHU/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Xiao Liang <shaw.leon@gmail.com>
Date: Tue, 7 Jan 2025 20:53:19 +0800
> On Tue, Jan 7, 2025 at 4:57 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> [...]
> >
> > We can fix this by linking the dev to the socket's netns and
> > clean them up in __net_exit hook as done in bareudp and geneve.
> >
> > ---8<---
> > diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
> > index 89a996ad8cd0..77638a815873 100644
> > --- a/drivers/net/gtp.c
> > +++ b/drivers/net/gtp.c
> > @@ -70,6 +70,7 @@ struct pdp_ctx {
> >  /* One instance of the GTP device. */
> >  struct gtp_dev {
> >         struct list_head        list;
> > +       struct list_head        sock_list;
> >
> >         struct sock             *sk0;
> >         struct sock             *sk1u;
> > @@ -102,6 +103,7 @@ static unsigned int gtp_net_id __read_mostly;
> >
> >  struct gtp_net {
> >         struct list_head gtp_dev_list;
> > +       struct list_head gtp_sock_list;
> 
> After a closer look at the GTP driver, I'm confused about
> the gtp_dev_list here. GTP device is linked to this list at
> creation time, but netns can be changed afterwards.
> The list is used in gtp_net_exit_batch_rtnl(), but to my
> understanding net devices can already be deleted in
> default_device_exit_batch() by default.
> And I wonder if the use in gtp_genl_dump_pdp() can be
> replaced by something like for_each_netdev_rcu().

Right, it should be, or we need to set netns_local.
Will include this diff in the fix series.

---8<---
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 2460a2c13c32..f9186eda36f0 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -2278,6 +2278,7 @@ static int gtp_genl_dump_pdp(struct sk_buff *skb,
 	struct gtp_dev *last_gtp = (struct gtp_dev *)cb->args[2], *gtp;
 	int i, j, bucket = cb->args[0], skip = cb->args[1];
 	struct net *net = sock_net(skb->sk);
+	struct net_device *dev;
 	struct pdp_ctx *pctx;
 	struct gtp_net *gn;
 
@@ -2287,7 +2288,10 @@ static int gtp_genl_dump_pdp(struct sk_buff *skb,
 		return 0;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(gtp, &gn->gtp_dev_list, list) {
+	for_each_netdev_rcu(net, dev) {
+		if (dev->rtnl_link_ops != &gtp_link_ops)
+			continue;
+
 		if (last_gtp && last_gtp != gtp)
 			continue;
 		else
---8<---

Otherwise, we need to move it manually like this, which is
apparently overkill and unnecessary :p

---8<---
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 2460a2c13c32..90b410b73c89 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -2501,6 +2501,46 @@ static struct pernet_operations gtp_net_ops = {
 	.size	= sizeof(struct gtp_net),
 };
 
+static int gtp_device_event(struct notifier_block *nb,
+			    unsigned long event, void *ptr)
+{
+	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	struct gtp_dev *gtp;
+	struct gtp_net *gn;
+
+	if (dev->rtnl_link_ops != &gtp_link_ops)
+		goto out;
+
+	gtp = netdev_priv(dev);
+
+	switch (event) {
+	case NETDEV_UNREGISTER:
+		if (dev->reg_state != NETREG_REGISTERED)
+			goto out;
+
+		/* dev_net(dev) is changed, see __dev_change_net_namespace().
+		 * rcu_barrier() after NETDEV_UNREGISTER guarantees that no
+		 * one traversing a list in the old netns jumps to another
+		 * list in the new netns.
+		 */
+		list_del_rcu(&gtp->list);
+		break;
+	case NETDEV_REGISTER:
+		if (gtp->list.prev != LIST_POISON2)
+			goto out;
+
+		/* complete netns change. */
+		gn = net_generic(dev_net(dev), gtp_net_id);
+		list_add_rcu(&gtp->list, &gn->gtp_dev_list);
+	}
+out:
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block gtp_notifier_block = {
+	.notifier_call = gtp_device_event,
+};
+
 static int __init gtp_init(void)
 {
 	int err;
@@ -2511,10 +2551,14 @@ static int __init gtp_init(void)
 	if (err < 0)
 		goto error_out;
 
-	err = rtnl_link_register(&gtp_link_ops);
+	err = register_netdevice_notifier(&gtp_notifier_block);
 	if (err < 0)
 		goto unreg_pernet_subsys;
 
+	err = rtnl_link_register(&gtp_link_ops);
+	if (err < 0)
+		goto unreg_netdev_notifier;
+
 	err = genl_register_family(&gtp_genl_family);
 	if (err < 0)
 		goto unreg_rtnl_link;
@@ -2525,6 +2569,8 @@ static int __init gtp_init(void)
 
 unreg_rtnl_link:
 	rtnl_link_unregister(&gtp_link_ops);
+unreg_netdev_notifier:
+	register_netdevice_notifier(&gtp_notifier_block);
 unreg_pernet_subsys:
 	unregister_pernet_subsys(&gtp_net_ops);
 error_out:
@@ -2537,6 +2583,7 @@ static void __exit gtp_fini(void)
 {
 	genl_unregister_family(&gtp_genl_family);
 	rtnl_link_unregister(&gtp_link_ops);
+	register_netdevice_notifier(&gtp_notifier_block);
 	unregister_pernet_subsys(&gtp_net_ops);
 
 	pr_info("GTP module unloaded\n");
---8<---
