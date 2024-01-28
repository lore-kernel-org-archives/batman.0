Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 000AEC47258
	for <batman-adv@archiver.kernel.org>; Sun, 28 Jan 2024 22:29:22 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 23EB183F64
	for <batman-adv@archiver.kernel.org>; Sun, 28 Jan 2024 23:29:21 +0100 (CET)
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1706480961;
 b=f/wDmbzSrIq/kkngIBsTFqU7EwNX9v13UhAsWQjIuEDLnHc+6w+WGdI5+59yB2yqHEAIM
 6S8iNjEqJrFEEy8kGPxrUYtt5vK4Th1VYCIqwKn5+jRytd1EIkW6Z1+4lOdOplAhu2XAcpg
 0DYKXmfqJx4UGbVzyKHORVlxJsj6P7U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1706480961; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=3pFoEkY2tZAvZ9E2zFhqEIyqMZppJAPv78sfolzTWQM=;
 b=nhPBrF/Yt2/Nu1DN2Zvsrb9hTMzTh9X7T9tuzOX224davxlPXnV9lXum9Wd5pFrNQttu1
 kZ7c2ehegjh6V5nEV2vNs2RiFKPOm/UttFG6QzGcqvMzSB8PfG5xMOLHKtxlXvdfvRR2sGk
 RB9hw6o1xoTGFNOck1boigv3HN3amjw=
ARC-Authentication-Results: i=1; open-mesh.org; dkim=fail;
  arc=none (Message is not ARC signed);
  dmarc=fail (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail;
 arc=none (Message is not ARC signed);
 dmarc=fail (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2474681236
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 28 Jan 2024 23:29:00 +0100 (CET)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Problem starting A.L.F.R.E.D on batman-adv?
From: doug.fajardo@gmail.com
To: b.a.t.m.a.n@lists.open-mesh.org
Date: Sun, 28 Jan 2024 22:29:00 -0000
Message-ID: <170648094014.1056.17522976996217024998@diktynna.open-mesh.org>
User-Agent: HyperKitty on https://lists.open-mesh.org/
Message-ID-Hash: YGJRO2CCK7ITJAV3MWI43MVCLBPNWLPE
X-Message-ID-Hash: YGJRO2CCK7ITJAV3MWI43MVCLBPNWLPE
X-MailFrom: doug.fajardo@gmail.com
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/YGJRO2CCK7ITJAV3MWI43MVCLBPNWLPE/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

I cant seem to get A.L.F.R.E.D. to start:
doug@dougwork:~/sdshome/alfred$ sudo alfred -b bat0
Can't start server: interface missing

batman-adv module is from the Unix kernel distribution (Alfred was added thru the apt package manager, identified as version  2022.0-1  ( I also tried downloading and compiling; no warnings or errors compiling, I saw identical symptoms).
The batman-adv network seems to be working properly. It correctly sees two other nodes.
Can anyone point out what I am missing ?

Thanks!
*** Doug  
OS is Ubuntu  bookworm, with latest patches as of today (1/28/2023)
doug@dougwork: uname -a
Linux dougwork 6.5.0-15-generic #15~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Fri Jan 12 18:54:30 UTC 2 x86_64 x86_64 x86_64 GNU/Linux

doug@dougwork: sudo batctl n
[B.A.T.M.A.N. adv 2023.1, MainIF/MAC: enp6s0/5c:62:8b:ea:33:b8 (bat0/6e:d4:b2:77:d1:85 BATMAN_IV)]
IF             Neighbor              last-seen
       enp6s0     d8:3a:dd:4d:35:c4    0.192s
       enp6s0     dc:a6:32:0b:49:35    0.392s

doug@dougwork: ifconfig  enp6s0
enp6s0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        ether 5c:62:8b:ea:33:b8  txqueuelen 1000  (Ethernet)
        RX packets 85660  bytes 5364556 (5.3 MB)
        RX errors 0  dropped 4109  overruns 0  frame 0
        TX packets 75996  bytes 104561707 (104.5 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
