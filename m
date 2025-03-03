Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C033EC282D0
	for <batman-adv@archiver.kernel.org>; Tue,  4 Mar 2025 21:09:05 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C8833840FA
	for <batman-adv@archiver.kernel.org>; Tue,  4 Mar 2025 22:09:03 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1741122543;
 b=JYNXSiyy1AxzWm9fxYgu6RZDiH8bFU4UojVjjZylY/IPM4b9arzUYmXRUeLWtXpphBZJo
 uaYA0SeUZVuFaXFBua8CKWpPZk6vM+IBvb3iQVNCpDXMe9oRTKveeozAtnMUF1fRR+B5OGh
 7FCUP57mz9q/251LTbymvCXakv2yA5o=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1741122543; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=94B1AldC1Ra+VOi32bZczZH6eYO+XQiGIIy01bId2WI=;
 b=TGIpwkxByGPf/tp561C2VZ5kJCmeQJdwfN3KlqKbqil7oNjbXbVRdGOCd30sq7ssf/w2E
 YPiCSubjApPUZfR5QDSGd/qwfj8XI74scRt+2UhhV1e8J+Uz1ETmgXrLagTwtLy4v9SvV/h
 wfDyAb6+S7iU0XuBzpunhSxp6R9qJHc=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 5D1BC8145F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue,  4 Mar 2025 20:29:02 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1741116542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=94B1AldC1Ra+VOi32bZczZH6eYO+XQiGIIy01bId2WI=;
	b=ust10/L8kKCkqZ7MBBpqGSTN18MqX9Xth2hyvZzaJeFG6r+4Ko/Lh9uWZ4I1d8COh/nvFh
	K90X0sClz9d/GBikeP53VfTsv2gVi8xCihuc/2mx1D2QAw2JhFSkCNzRQWxySBtbRZig9n
	GS/zXUY6no2hVAAooBaugw1byQlzLbQ=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1741116542; a=rsa-sha256;
	cv=none;
	b=TRZDjHxfnOJOVSX3pvXAa0jZnJjmwg8Q+DO+cEWjxChPKUpR+RJqPlfQGR2p6pVqGwrpbr
	iae+N1yexHhowGblmwE4aW3S2u8a81Zlq3a0cDQ7MQuMgPmb3ymYH7oN0gliyyufYA4omP
	jJrkfDwKEbNFOSqdv9T8lgziF8lT5/8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed),
 No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (diktynna.open-mesh.org: domain of
 34IbFZwkbAEk39Avlwwp2l00to.rzzrwp53p2nzy4py4.nzx@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
 designates 209.85.216.70 as permitted sender)
 smtp.mailfrom=34IbFZwkbAEk39Avlwwp2l00to.rzzrwp53p2nzy4py4.nzx@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2fecf10e559so11904425a91.2
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Tue, 04 Mar 2025 11:29:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741116541; x=1741721341;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=94B1AldC1Ra+VOi32bZczZH6eYO+XQiGIIy01bId2WI=;
        b=qLva7bAhfHXCueiL1cq1xgxNg2/7ccGIaTySSdlI7rE//94aHVdCLB2PjjQyX6VimS
         DkSjWqQaqbzXfdZTcij2r8Q8kl7yog/fjl+wLpGKPdDYZtd/6qmgmw5xFut8w3tjkXhw
         T5bGN3KH4O6hth68L5pzG7tLodRj23EPZ6U73usyScYPW+1swEwuKwzL3nn3gMUkQRmn
         LaMNY5EWRBbygngvf3KuwxgZFFLsti2xlbAw+Gu3AWZycwhPFDHNYIi97Diij+sBqi2l
         GvMBpAECodjYGyTr3MsHWGMW1JeZMkNaThxxXnay39/wm+PMvIP8LuV/mNjByqjuoReL
         jFdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjTdyAd8tfGTPq4LVfxF1k77m/boqoRYjO5ZQ5R77zh4h4Oq33DHTicbbnELQRllQ3E/KQNLjYb9sRQg==@lists.open-mesh.org
X-Gm-Message-State: AOJu0Ywu3l+K/dH9OvrhTkTMddWZ29uxwOyf2OooCvO/WRuTTQfbKlMC
	/tVMROAQANjvBmLNtjVTeIYWMhLnpoQ+XpA5h6t47io2Fabi1d9y0BhSAwRSbFf+0+/uYDvy/hs
	LArB1Qv6gOTZ3lQCX8PtQgQQKN7cJ2HDajBgIbvUIgsVFaqsNVxPYnac=
X-Google-Smtp-Source: 
 AGHT+IHXGGfJycEVF1C0NA+tWbF57mYYWAfRa3uH7yonYPLILGd0Xs6oQjnQHhZiPUqQSby7mDcwV8F7CrVZ/77JAIhHK7ysIbjU
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3111:b0:3d3:ff5c:287 with SMTP id
 e9e14a558f8ab-3d3ff5c06f9mr41959675ab.14.1740998368052; Mon, 03 Mar 2025
 02:39:28 -0800 (PST)
Date: Mon, 03 Mar 2025 02:39:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c586e0.050a0220.1dee4d.0124.GAE@google.com>
Subject: [syzbot] Monthly batman report (Mar 2025)
From: syzbot <syzbot+list0f38ff37debbbda9dc0b@syzkaller.appspotmail.com>
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
	linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch,
	netdev@vger.kernel.org, sven@narfation.org, sw@simonwunderlich.de,
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-MailFrom: 
 34IbFZwkbAEk39Avlwwp2l00to.rzzrwp53p2nzy4py4.nzx@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: MGS6QXQUNP3MXDIKA6IXCRIXLD7HLYT6
X-Message-ID-Hash: MGS6QXQUNP3MXDIKA6IXCRIXLD7HLYT6
X-Mailman-Approved-At: Tue, 04 Mar 2025 22:08:51 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/MGS6QXQUNP3MXDIKA6IXCRIXLD7HLYT6/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hello batman maintainers/developers,

This is a 31-day syzbot report for the batman subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/batman

During the period, 2 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 26 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 555     Yes   INFO: rcu detected stall in batadv_nc_worker (3)
                  https://syzkaller.appspot.com/bug?extid=69904c3b4a09e8fa2e1b
<2> 136     No    INFO: rcu detected stall in sys_recvmmsg (3)
                  https://syzkaller.appspot.com/bug?extid=b079dc0aa6e992859e7c
<3> 14      Yes   INFO: rcu detected stall in rescuer_thread
                  https://syzkaller.appspot.com/bug?extid=76e180c757e9d589a79d
<4> 1       Yes   INFO: rcu detected stall in batadv_bla_periodic_work (2)
                  https://syzkaller.appspot.com/bug?extid=fc38cf2d6e727d8415c7

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
