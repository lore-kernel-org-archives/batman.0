Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46BCBFEEF38
	for <batman@archiver.kernel.org>; Tue,  7 Apr 2026 13:47:23 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7873F85A13
	for <batman@archiver.kernel.org>; Tue, 07 Apr 2026 15:47:21 +0200 (CEST)
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1775569641;
 b=2ieycOtNhKV9LobkDHn2rY7xcFQgXwx1BXJGbe8m4cRtU6c8+MvIbQd7hH1QJHahm+UM/
 t4CPg002IYDmZcc1aZhImqpAv2fd0N7Q18uO3cm2OGmyCwGnX+9s5CUsiirjXSi451BxSdU
 AiBQmbQT7bJIlwD31cVItZO1UkcQwkM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1775569641; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=DCjz17ewHfu8Yr+SV6U7S1CqIqYVFXv8Ix1xoVywBf0=;
 b=jsGrWPbzp43QAaGUFs1gFKR3HhZXr37cnHnkEc9uBgxXPdB0d5TU0O1zzqU3bIkOThsz7
 Ipj788JrDmzPjv46Cxmbn2TjIv2aGRYg2c48V2IQRejRlEoZqJqb320w1IPVkqUA6LNrnq8
 Ws7hLjJlWdKbBdKAcuf2N+1fKpJcsng=
ARC-Authentication-Results: i=1; open-mesh.org;
 dkim=fail;
 arc=none;
 dmarc=fail header.from=gmail.com policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail;
 arc=none (Message is not ARC signed);
 dmarc=fail (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 61FB18044F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 07 Apr 2026 15:46:59 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: Gateway shut down detection takes too time from other nodes
From: martinvdberg@gmail.com
To: b.a.t.m.a.n@lists.open-mesh.org
Date: Tue, 07 Apr 2026 13:46:59 -0000
Message-ID: <177556961939.1631.5621807886524407791@diktynna.open-mesh.org>
In-Reply-To: <3735338.hdfAi7Kttb@prime>
References: <3735338.hdfAi7Kttb@prime>
User-Agent: HyperKitty on http://lists.open-mesh.org/
Message-ID-Hash: 6TYRWEMVWFV7WMQB7ZYKHWQIUFRRS7X2
X-Message-ID-Hash: 6TYRWEMVWFV7WMQB7ZYKHWQIUFRRS7X2
X-MailFrom: martinvdberg@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/6TYRWEMVWFV7WMQB7ZYKHWQIUFRRS7X2/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

I think I have a similar use-case as the original poster and ran into the same problem. 

Let me try to explain:

- Given a mesh network where each node is assigned a *static IP*.
- In the mesh network there are some nodes acting as a Gateway.
- The other nodes in the mesh are clients.
- Using BATMAN-V

Each client node has a script running, when it detects "batctl gwl" to elect another gateway, the script will set the gateway's IP-address as default route: "ip route replace default via $gateway_ip dev bat0".

Now whenever a mesh-gateway is turned off, it will take 200 seconds before it is removed from the originators and only then "batctl gwl" will elect another gateway. This results in some client nodes have no internet for 200 seconds.

So far, I haven't been able to get batman-adv (using batctl) to switch to another gateway sooner, e.g. after 10 or 20 seconds.


Using DHCP is not an option in my use-case.

Is there somehow a way to reduce the 200 seconds? Possibly by switching to BATMAN-IV?

Regards, Martin
