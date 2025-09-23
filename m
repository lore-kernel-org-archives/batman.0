Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 200E6CAC5AC
	for <batman-adv@archiver.kernel.org>; Tue, 23 Sep 2025 14:51:35 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 67621849EE
	for <batman-adv@archiver.kernel.org>; Tue, 23 Sep 2025 16:51:33 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1758639093;
 b=bnbaHHDIElGmFUSYfA6FRl0lDFQN0pQhbT2lR7SisQ+kFBUkvdeet7a5DULe0Kjck9Pjt
 NOXh05Pec8RvO90ShfywuwtfQ+Wyhs/wAEh7uUCKujPrzi+LJt+XiSmasoyl7ZHhrcHHv12
 qNzMxGpcPhNrXKgGqaGuvXUZKx0tcGA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1758639093; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=HpRoQHAsJoggTLmKROVbmhqCT57Q7TGx0QbeCkrJFDo=;
 b=jhMgZmWhqjATK/2iNJOdSk8aVoKfOehha70k5W2VraW/LGvxw4T8SJQ9sRZH+bhfKEyWH
 vT08Kxt+WYBMS3p19I2MfHFDN4BwFX8EN8DnalBMLZO3RLRZWuCfk78Dk2Mw0wkORdCcNbU
 Dg91og4zVwOr81TsJaz7k8ho3p8UVFc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id D20A5845B5
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 23 Sep 2025 16:46:17 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1758638789; a=rsa-sha256;
	cv=none;
	b=iYfi1MWYmnZhH9S+uncz2gYRq78kJWIbxGM9y5a8+AlEByOKHrDRT1Xo7jZMUPb8ifCl0N
	Qt12JUxCWb/8Q0S2zVNgD5rrGvFIypmNElS44uL9YsUP39UjPUib979jYgmh4pjb+9lOZG
	uACOuJ7reFq14N2JmwLT+sdvgwKL3tg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of
 penguin-kernel@I-love.SAKURA.ne.jp designates 202.181.97.72 as permitted
 sender) smtp.mailfrom=penguin-kernel@I-love.SAKURA.ne.jp
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1758638789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HpRoQHAsJoggTLmKROVbmhqCT57Q7TGx0QbeCkrJFDo=;
	b=h2wXlWw7FKNwz3mAWoa70e7nyYjYSKr333yk90Qq0l0MRrp+qpO3Yx1rbidRBYs+Ekyyxh
	Q89GHuXpsg9RBssLORedt5IVkTevjc7D0SPOOhOVOVvF5M/8uiCaOGOWohVMyFAQwDIYik
	3BZcwYms0KyDtqLlaqWon5htDfN1s1M=
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 58NEjmgE043278;
	Tue, 23 Sep 2025 23:45:48 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 58NEjmPA043275
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 23 Sep 2025 23:45:48 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <1731a084-79fb-4bc6-9e0b-9b17f3345c4b@I-love.SAKURA.ne.jp>
Date: Tue, 23 Sep 2025 23:45:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: unregister_netdevice: waiting for batadv_slave_0 to become free.
 Usage count = 2
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Marek Lindner <marek.lindner@mailbox.org>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Antonio Quartulli <antonio@mandelbit.com>,
        Sven Eckelmann <sven@narfation.org>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        b.a.t.m.a.n@lists.open-mesh.org,
        Network Development <netdev@vger.kernel.org>,
        =?UTF-8?Q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>
References: <e50546d9-f86f-426b-9cd3-d56a368d56a8@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <e50546d9-f86f-426b-9cd3-d56a368d56a8@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav203.rs.sakura.ne.jp
X-Virus-Status: clean
X-MailFrom: penguin-kernel@I-love.SAKURA.ne.jp
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; emergency; member-moderation
Message-ID-Hash: RSOZAY2ZY5XLSZVYHSJ7LIAVSOYXRMCY
X-Message-ID-Hash: RSOZAY2ZY5XLSZVYHSJ7LIAVSOYXRMCY
X-Mailman-Approved-At: Tue, 23 Sep 2025 16:51:06 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RSOZAY2ZY5XLSZVYHSJ7LIAVSOYXRMCY/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

On 2025/09/22 23:09, Tetsuo Handa wrote:
> I suspect that batadv_hard_if_event_meshif() has something to do upon
> NETDEV_UNREGISTER event because batadv_hard_if_event_meshif() receives
> NETDEV_POST_INIT / NETDEV_REGISTER / NETDEV_UNREGISTER / NETDEV_PRE_UNINIT
> events when this reproducer is executed, but I don't know what to do...

With a change show bottom, the reproducer no longer triggers this problem.
But is this change correct?



Commit 9e6b5648bbc4 ("batman-adv: Fix duplicated OGMs on NETDEV_UP")
replaced batadv_iv_iface_activate() (which is called via iface.activate()
 from batadv_hardif_activate_interface()) with batadv_iv_iface_enabled()
(which is called via iface.enabled() from batadv_hardif_enable_interface()).
But that commit missed that batadv_hardif_activate_interface() is called from
both batadv_hardif_enable_interface() and batadv_hard_if_event().

Since batadv_iv_ogm_schedule_buff() updates if_status to BATADV_IF_ACTIVE
only when if_status was BATADV_IF_TO_BE_ACTIVATED, we need to call
batadv_iv_ogm_schedule_buff() from batadv_iv_ogm_schedule() from
batadv_iv_iface_enabled() via iface.enabled() with
if_status == BATADV_IF_TO_BE_ACTIVATED if we want iface.enabled() from
batadv_hardif_enable_interface() to update if_status to BATADV_IF_ACTIVE.

But when IFF_UP is not set upon creation, batadv_hardif_enable_interface()
does not call batadv_hardif_activate_interface(), which means that
if_status remains BATADV_IF_INACTIVE despite
batadv_iv_ogm_schedule_buff() is called via iface.enabled().

And when IFF_UP is set after creation, batadv_hard_if_event() calls
batadv_hardif_activate_interface(). But despite "Interface activated: %s\n"
message being printed, if_status remains BATADV_IF_TO_BE_ACTIVATED because
iface.activate == NULL due to above-mentioned commit.

Since we need to call iface.enabled() instead of iface.activate() so that
batadv_iv_ogm_schedule_buff() will update if_status to BATADV_IF_ACTIVE,
move iface.enabled() from batadv_hardif_enable_interface() to
batadv_hardif_activate_interface().



diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index bace57e4f9a5..403785f649ff 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -673,6 +673,8 @@ batadv_hardif_activate_interface(struct batadv_hard_iface *hard_iface)
 
 	if (bat_priv->algo_ops->iface.activate)
 		bat_priv->algo_ops->iface.activate(hard_iface);
+	if (bat_priv->algo_ops->iface.enabled)
+		bat_priv->algo_ops->iface.enabled(hard_iface);
 
 out:
 	batadv_hardif_put(primary_if);
@@ -770,9 +772,6 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 
 	batadv_hardif_recalc_extra_skbroom(mesh_iface);
 
-	if (bat_priv->algo_ops->iface.enabled)
-		bat_priv->algo_ops->iface.enabled(hard_iface);
-
 out:
 	return 0;
 


