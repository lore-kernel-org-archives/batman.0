Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD1FD44162
	for <batman-adv@archiver.kernel.org>; Tue, 19 Nov 2024 15:03:21 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B73AC84216
	for <batman-adv@archiver.kernel.org>; Tue, 19 Nov 2024 16:03:19 +0100 (CET)
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1732028599;
 b=TD58yaypzoWHzzMQx7IjPIo4sGldrLHNjFs9p3Q1Md5pd0/Bbjul2tsjpgKh0gbkYXhwp
 wwluUV+DChUCHn2Co5eD7s8VW2D9YnQfqDROM0ljhc5vDCQWZBG7u0ovNXkKUg95xuJLLwA
 cBzlw6ZZViRglDVXtIihrecwAmcrw7Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1732028599; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=5dfY3a0Fo2pAFubDkixGCs+mv1d9P81kXypaGSLIT4M=;
 b=UBDF/lByY6D7sxB8ndbiE67mYjTJlhXFf3Ts2LIbEJ7n2Wc5hesOFonyRI9UBtHefLxeN
 rKS2LDTtiL9gYzROUytdCrBf54NBc9Imc4i4gV8vkf+0cnBukr8AAqQB1pK2O1dJgAAMemc
 CXyPbLjYVyO6Fy47FMeDawWJlln2GF0=
ARC-Authentication-Results: i=1; open-mesh.org; dkim=fail;
  arc=none (Message is not ARC signed);
  dmarc=fail (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail;
 arc=none (Message is not ARC signed);
 dmarc=fail (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0B60882351
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 19 Nov 2024 16:02:22 +0100 (CET)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: IP connectivity issue at openwrt nodes
From: soanican@gmail.com
To: b.a.t.m.a.n@lists.open-mesh.org
Date: Tue, 19 Nov 2024 15:02:22 -0000
Message-ID: <173202854203.676947.11109824084026524432@diktynna.open-mesh.org>
In-Reply-To: <3253206.5fSG56mABF@ripper>
References: <3253206.5fSG56mABF@ripper>
User-Agent: HyperKitty on https://lists.open-mesh.org/
X-MailFrom: soanican@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: 33BUCDXRMNDB2XHILB5ZSG3WUB7Z7FYE
X-Message-ID-Hash: 33BUCDXRMNDB2XHILB5ZSG3WUB7Z7FYE
X-Mailman-Approved-At: Tue, 19 Nov 2024 16:02:55 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/33BUCDXRMNDB2XHILB5ZSG3WUB7Z7FYE/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi Sven,
Yes: "Ok, ethernet bridge to mesh"
Yes, for redundancy, enabling alternative links, expecting batman handling the best links, best routes (enabling the loop avoidance): " Ok, the underlying interfaces for bat0 have "redundancy"?"
Yes, IP is only assigned to bridge interface. Making sure that interfaces are up, ensuring layer 2 connection establishment at all related nodes.

My issue is just here: I can not ping neither from local nor eth0 PC to other nodes/external client. "batctl o" shows empty table. No logs at dmesg. All bat0 sub interfaces are "active".
Any clue for troubleshooting helps a lot.

Best regards,
