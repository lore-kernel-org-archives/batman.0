Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ECFBE6781F
	for <batman-adv@archiver.kernel.org>; Mon, 22 Dec 2025 19:47:01 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D7FC185501
	for <batman-adv@archiver.kernel.org>; Mon, 22 Dec 2025 20:46:59 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1766432819;
 b=yEZuqVF6pwfyWDBUplOht3qOOred9FUiufexyNcSfqmG7IbUMoc+PHaDjOZiDbcm+H/Op
 OEsDmN4UJPagvmOtu/SM7sCr/R6SrqZ/NUivs3hsKLzCEmPAGIGbictCcEDIT1pPRjG2nYK
 GDNeXSFYKgJJS5LrV5mR4jXVXL2wS6k=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1766432819; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=PNIiAjMZYFs+VOx0YLE0UBArZWoEny7hkKH1tDnXLfk=;
 b=kMZicB6rAb1JmH7qshEAYCzokKoisu3dc1R28XWs6OTz19U4oAkIVsozNMn2j5eM9HZJN
 OuyN/YZHRSiXrGfwYeTXO8uMKujBhZVB4rj6fvnm1HDznQnPf/ujnxKpjV6n45pCpIkUaYz
 KLuMyjhMNxjl++5/BnYYxQQig55eA6c=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=fail header.from=syzkaller.appspotmail.com policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 79D48815E1
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 22 Dec 2025 14:07:41 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1766408872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=PNIiAjMZYFs+VOx0YLE0UBArZWoEny7hkKH1tDnXLfk=;
	b=UQWNP2uZY8F9M6s3j8JdArcHSWH+qec0sd64mSGfs1TlcMDT9RIA6L4zxw+dChAR/Bhaxr
	BgXzYewMSrsMVvnWsX7A79nNrVel94aWF2o2VC5lx39qccun677vdcfTc2jNqVB8zNipXS
	96A7h4UblK4GUYQwqITgMRN351pz89Q=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed),
 No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (diktynna.open-mesh.org: domain of
 3nEJJaQkbAJcJPQB1CC5I1GG94.7FF7C5LJ5I3FEK5EK.3FD@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
 designates 209.85.167.199 as permitted sender)
 smtp.mailfrom=3nEJJaQkbAJcJPQB1CC5I1GG94.7FF7C5LJ5I3FEK5EK.3FD@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1766408872;
	b=kpaVIFkD86Ta7Fu25Rhfvdg+sK9h3k0ANFL9zMY1ER9dKl6eb2ZYmynW9yzpm8e4LRT346
	p+sEnYWQjoKijyivnr9O3S1WB4MB5TU37s+Xdoh8/WijuuLFTJPQHpro8y/vpSPWCjqi8i
	5lpnJKgVeukCqa6tT3wmV4xRVLRfxsA=
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-450b5afd932so2362774b6e.2
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Mon, 22 Dec 2025 05:07:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766408860; x=1767013660;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PNIiAjMZYFs+VOx0YLE0UBArZWoEny7hkKH1tDnXLfk=;
        b=ExxRBC6lVcnjczlD3gk8lU7nBrbayxq6/bNmukLscb7jSAg5GZ8pL/Y73zC1ROqsol
         8job891vxe2qw5+J8SdOkYbs20iQKVho/bS22GgWlphhZVs8TEGzNwpIvQGthhlecYAi
         7Lr4Rcv9uY8xveGVSSi7KNkjf85vMScb3IJntL7ktQEDZLOmgUqSrLlDVBMSufGGFnxF
         2KQBmMIwHOnkesG8KX7qx4oA6kTViYQWoyLKSYK0T9cZelzRXmLlL/7IdxBGvar8XsVu
         rsS9pI/VSxnH3cpwTq7xof2hvB4awpuwbH86jriocyq3ScyHBc9YbgYKMQT4YEMO2/bT
         /Y7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWz6ZzbfO9nVSBI7iIPO3mJ34Vge3fs2P7SRoqC4sTTDFeckFkVm78oMv3A8+Bbja8iEgd3AF8Vxjnq6A==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YzY/dROEm1jKmGh6eMlzwkZcNTO2FNB/sonvapv5i8/kdHNWj97
	4fo1rF151EWmscJ7vcUt4O2wNJY8Mg2fik8bFVDu0FLKIlHEcuBSe/FgbhNDb0h3FkTkyDV/yl5
	LIM7uJq3mV+IlRaxBSOEmLTiJU2uLFRjtsvdcd+G5QbLrpI4UPjzXmfLz9zE=
X-Google-Smtp-Source: 
 AGHT+IHHQPDlWnqdFPXmsDDu2QANjD10YfdwStLWCvV9Eciu/0tI3wH+FaoIQR/pfKZ1LSJTXcxU+WRap3iyU4Oasa8ZuI0nkyQa
MIME-Version: 1.0
X-Received: by 2002:a4a:ef89:0:b0:65b:32b4:8403 with SMTP id
 006d021491bc7-65d0eb1f81emr3089764eaf.48.1766408860416; Mon, 22 Dec 2025
 05:07:40 -0800 (PST)
Date: Mon, 22 Dec 2025 05:07:40 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6949429c.a70a0220.25eec0.008a.GAE@google.com>
Subject: [syzbot] Monthly batman report (Dec 2025)
From: syzbot <syzbot+list471f2d695c5f42c85635@syzkaller.appspotmail.com>
To: antonio@mandelbit.com, b.a.t.m.a.n@lists.open-mesh.org,
	linux-kernel@vger.kernel.org, marek.lindner@mailbox.org,
	netdev@vger.kernel.org, sven@narfation.org, sw@simonwunderlich.de,
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-MailFrom: 
 3nEJJaQkbAJcJPQB1CC5I1GG94.7FF7C5LJ5I3FEK5EK.3FD@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: WP3S5R4L33G2JHM43RRNB4MAZASNVMHD
X-Message-ID-Hash: WP3S5R4L33G2JHM43RRNB4MAZASNVMHD
X-Mailman-Approved-At: Mon, 22 Dec 2025 20:46:50 +0100
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: <>
List-Archive: <>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hello batman maintainers/developers,

This is a 31-day syzbot report for the batman subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/batman

During the period, 1 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 25 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 30      Yes   INFO: rcu detected stall in batadv_iv_send_outstanding_bat_ogm_packet (6)
                  https://syzkaller.appspot.com/bug?extid=62348313fb96b25955aa
<2> 6       No    KMSAN: uninit-value in __run_timer_base (2)
                  https://syzkaller.appspot.com/bug?extid=7d660d9b8bd5efc7ee6e
<3> 3       Yes   INFO: rcu detected stall in batadv_mcast_mla_update (2)
                  https://syzkaller.appspot.com/bug?extid=0a80c6499b110dbf88b7
<4> 2       Yes   INFO: rcu detected stall in batadv_bla_periodic_work (2)
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
