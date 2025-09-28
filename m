Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E81B0CAC5B5
	for <batman-adv@archiver.kernel.org>; Sun, 28 Sep 2025 06:22:46 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 6614A84509
	for <batman-adv@archiver.kernel.org>; Sun, 28 Sep 2025 08:22:45 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1759040565;
 b=nqrP7EauChVAeBbO0imc6yh5MJk0v9yOdkVjSl+oAgkE7znsbq9mHSrnWoP9ezSHeyvVc
 sBMgKAAssb158HQ/AneCGH1HH7HhWkmdeqtKU/auG+cI4rd9+AxNQ73q0E9xwJkAPgAH0vM
 F1nD/YSaNCwh5mOEaxh0kI2mNuLCRoM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1759040565; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=H7NNxl6VWaozmUR3XVKD/Tk2/6qe1iE73DQDTeA7nFc=;
 b=gVg4vKqNgVuHgoMrg831uyD9QrQAfuaV5RM6LhwUNnN3EPljWWAOWwS+8b18ffdBEWI+S
 BmWz3bgrmi3oAbdU7u8zPWnsR2XjhxhOaUUiiMgfrAn7/MD6RJfyfFr3T73nKGMYRF7YF55
 QbsAgr+cFdPQL8fCjN2pkQMceLL4sss=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 6294B83CBA
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 28 Sep 2025 03:06:29 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1759021601; a=rsa-sha256;
	cv=none;
	b=e8Fk+yu6jy+eqNYjOcnAwJqbXAc/j4+6o/ox5s3lOpds27bZz79BiTn1TRGYjEYkFs6POZ
	aIgkf0XwnO2evOSU0san79oqL1lOLJYTQKwtikMbGBgSuSCSLY9pItL4Hl2DX9TagAEDO8
	X5fLiDpmcolNYUMYCSobw0DuA7mw89o=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of
 penguin-kernel@I-love.SAKURA.ne.jp designates 202.181.97.72 as permitted
 sender) smtp.mailfrom=penguin-kernel@I-love.SAKURA.ne.jp
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1759021601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H7NNxl6VWaozmUR3XVKD/Tk2/6qe1iE73DQDTeA7nFc=;
	b=Y9dqW5rInln1ZsyKPcJn4qORLW5LrB7//CZvF1PGUXsLvS1Qg3vR1Wqj6PgMT4EOVBWmbo
	i710L6zeBzb90UuPMBLDBJg0oF9NOUBzwHi4+eX5J8T672oV0NSlIFMjZqwRFzACIhStrg
	Blwng2tV8JAxzrxToxaxb3CvOQ78wi8=
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 58S165Ad006793;
	Sun, 28 Sep 2025 10:06:05 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 58S165LM006787
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 28 Sep 2025 10:06:05 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <9f999251-8132-414e-9ea1-f83ecc41dfdd@I-love.SAKURA.ne.jp>
Date: Sun, 28 Sep 2025 10:06:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: unregister_netdevice: waiting for batadv_slave_0 to become free.
 Usage count = 2
To: Sven Eckelmann <sven@narfation.org>,
        Marek Lindner <marek.lindner@mailbox.org>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Antonio Quartulli <antonio@mandelbit.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        b.a.t.m.a.n@lists.open-mesh.org,
        Network Development <netdev@vger.kernel.org>,
        =?UTF-8?Q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>
References: <e50546d9-f86f-426b-9cd3-d56a368d56a8@I-love.SAKURA.ne.jp>
 <1731a084-79fb-4bc6-9e0b-9b17f3345c4b@I-love.SAKURA.ne.jp>
 <2754825.KlZ2vcFHjT@sven-desktop>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <2754825.KlZ2vcFHjT@sven-desktop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav405.rs.sakura.ne.jp
X-Virus-Status: clean
X-MailFrom: penguin-kernel@I-love.SAKURA.ne.jp
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; emergency; member-moderation
Message-ID-Hash: IKHJCWGRYU7UR7X7MSEDDMYBNP7TWIEI
X-Message-ID-Hash: IKHJCWGRYU7UR7X7MSEDDMYBNP7TWIEI
X-Mailman-Approved-At: Sun, 28 Sep 2025 08:21:32 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/IKHJCWGRYU7UR7X7MSEDDMYBNP7TWIEI/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Thank you for responding quickly.

On 2025/09/28 2:21, Sven Eckelmann wrote:
> The question would now be: what is the actual problem? 

Sorry, my explanation was not clear enough.

What I thought as a problem is the difference between

	netlink_device_change(&nlmsg, sock, "batadv_slave_0", true, "batadv0", 0, 0);
	//netlink_device_change(&nlmsg, sock, "batadv_slave_0", true, 0, &macaddr, ETH_ALEN);

and

	netlink_device_change(&nlmsg, sock, "batadv_slave_0", false, "batadv0", 0, 0);
	netlink_device_change(&nlmsg, sock, "batadv_slave_0", true, 0, &macaddr, ETH_ALEN);

. The former makes hard_iface->if_status == BATADV_IF_ACTIVE while the latter makes
hard_iface->if_status == BATADV_IF_TO_BE_ACTIVATED (because batadv_iv_ogm_schedule_buff()
is not called).

This difference makes operations that depend on hard_iface->if_status == BATADV_IF_ACTIVE
impossible to work properly. You can confirm this difference using diff show below.

--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -761,6 +761,7 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,

        batadv_check_known_mac_addr(hard_iface);

+       pr_info("step 1: %d\n", hard_iface->if_status);
        if (batadv_hardif_is_iface_up(hard_iface))
                batadv_hardif_activate_interface(hard_iface);
        else
@@ -768,10 +769,12 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
                           "Not using interface %s (retrying later): interface not active\n",
                           hard_iface->net_dev->name);

+       pr_info("step 2: %d\n", hard_iface->if_status);
        batadv_hardif_recalc_extra_skbroom(mesh_iface);

        if (bat_priv->algo_ops->iface.enabled)
                bat_priv->algo_ops->iface.enabled(hard_iface);
+       pr_info("step 3: %d\n", hard_iface->if_status);

 out:
        return 0;
@@ -961,7 +964,9 @@ static int batadv_hard_if_event(struct notifier_block *this,

        switch (event) {
        case NETDEV_UP:
+               pr_info("step 4: %d\n", hard_iface->if_status);
                batadv_hardif_activate_interface(hard_iface);
+               pr_info("step 5: %d\n", hard_iface->if_status);
                break;
        case NETDEV_GOING_DOWN:
        case NETDEV_DOWN:

The former case:

  batman_adv: batadv0: Adding interface: batadv_slave_0
  batman_adv: batadv0: The MTU of interface batadv_slave_0 is too small (1500) to handle the transport of batman-adv packets. Packets going over this interface will be fragmented on layer2 which could impact the performance. Setting the MTU to 1560 would solve the problem.
  batman_adv: step 1: 2
  batman_adv: batadv0: Interface activated: batadv_slave_0
  batman_adv: step 2: 4
  batman_adv: step 3: 3
  batman_adv: batadv0: Interface deactivated: batadv_slave_0
  batman_adv: batadv0: Removing interface: batadv_slave_0

The latter case:

  batman_adv: step 1: 2
  batman_adv: batadv0: Not using interface batadv_slave_0 (retrying later): interface not actve
  batman_adv: step 2: 2
  batman_adv: step 3: 2
  batman_adv: step 4: 2
  batman_adv: batadv0: Interface activated: batadv_slave_0
  batman_adv: step 5: 4
  batman_adv: batadv0: Interface deactivated: batadv_slave_0
  batman_adv: batadv0: Removing interface: batadv_slave_0



> --- i/net/batman-adv/originator.c
> +++ w/net/batman-adv/originator.c
> @@ -763,7 +763,7 @@ int batadv_hardif_neigh_dump(struct sk_buff *msg, struct netlink_callback *cb)
>  	bat_priv = netdev_priv(mesh_iface);
>  
>  	primary_if = batadv_primary_if_get_selected(bat_priv);
> -	if (!primary_if || primary_if->if_status != BATADV_IF_ACTIVE) {
> +	if (!primary_if) {
>  		ret = -ENOENT;
>  		goto out_put_mesh_iface;
>  	}
> 
> 
> And now we are most likely on the right path... primary_if is holding a 
> reference to an hardif and therefore also a reference to the netdev. And the 
> error handling is only taking care of releasing the reference to the meshif 
> but not the primary_if.

Ah, indeed. Since batadv_primary_if_get_selected() is calling kref_get_unless_zero(),
primary_if->if_status != BATADV_IF_ACTIVE case needs to call kref_put().
Also, this matches my what I thought as a problem (BATADV_IF_TO_BE_ACTIVATED prevents
operations that depends on BATADV_IF_ACTIVE from working as expected).

> I will later send a fix for this with you and 
> syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com as Reported-by. Is this
> okay for you?

Yes, the reproducer no longer shows the problem.

Thank you.

