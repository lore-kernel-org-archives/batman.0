Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D652C3DA59
	for <batman-adv@archiver.kernel.org>; Tue, 16 Jul 2024 07:27:51 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 864AF83B0F
	for <batman-adv@archiver.kernel.org>; Tue, 16 Jul 2024 09:27:49 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1721114869;
 b=NXohkQLIJXxkGLld3NYdV+rJvu48E989r+rHT1GIqG7WKKfHYf5CTHqws8idWnqXgNv6X
 /xM14ltQOg1KBIpEBwDLoGFf0Jxclh/YRHAplkvp9lUPPvmGQElMZEy7GojqFPPnn23njfn
 2eo1X1Aczzfqeg3FHBezqREed/V5tcU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1721114869; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=CLFH2JBjewy4ABEXyNEx3SEk+w8nbuEWu0g6qYvBIvg=;
 b=3XXi6EtKqOhXOcubuhVnm9+ihwJ6R7ShhG3E3oidsvLxZvcNI6xOl9StW7kpJS+ZWg03A
 +ULRJ8lyVF1DEbyw67QzY4x6/67e1leHbP4gh3XZ3wfeySZ9J6h/NPoZNYeIjFDeiWVIR+j
 jAshGW5bxisTfr1WPNGWWmgyejmBsFQ=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 96BBB81A10
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 15 Jul 2024 20:58:28 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1721069908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=CLFH2JBjewy4ABEXyNEx3SEk+w8nbuEWu0g6qYvBIvg=;
	b=xTtMLwTsVG1XHtwN4ItfSS+0e6uvymBXiPMqEbz8/ajYR4+JvCCVMw0jJI4xk4Na8LQBJM
	TtXWw0KBWDFTHNoRa9XySkZvodAQ8r7Jw9ZW8H/mEBXZDJTaniK9hqlNEnCre3ScReBLOQ
	FMkNn/6jsTI6vld+UKyb0VNmJnzzxIw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of
 3U3GVZgkbAMY4ABwmxxq3m11up.s00sxq64q3o0z5qz5.o0y@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
 designates 209.85.166.200 as permitted sender)
 smtp.mailfrom=3U3GVZgkbAMY4ABwmxxq3m11up.s00sxq64q3o0z5qz5.o0y@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	dmarc=fail reason="SPF not aligned (relaxed),
 No valid DKIM" header.from=appspotmail.com (policy=none)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1721069908; a=rsa-sha256;
	cv=none;
	b=M3mwzJlJ+Zjdkmf+pArTEHT3LvblwKoC07JgKgRU6XIA4vEitm0gSBZnHBL8zfxq74VpEo
	DFbgcqPrvswXZu7HzRtFvenhhQ6PtCz/g/NmW/ZQVVBoADYJ3CY+Qg/oCI7+0jUqzcH9E/
	tJbCtFZCe3oPzgzn9jPoK06fespezyA=
Received: by mail-il1-f200.google.com with SMTP id
 e9e14a558f8ab-3835c6e5763so54760835ab.3
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Mon, 15 Jul 2024 11:58:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721069907; x=1721674707;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CLFH2JBjewy4ABEXyNEx3SEk+w8nbuEWu0g6qYvBIvg=;
        b=SgYNjI9YfYDdbCD9hKIMi2AD0BLmuzwtWbOcO+2SL+3Hs/8Kbicsbr3FxlB3QAU+03
         2uNJnsgGC2RAM+fIQSBZV8vG5fHMrKlkedAiH1kVo5jMKv2HPBwculFqnELtO8AIAzKG
         UYZDXY6nHe+2X0z6oSqhH3IAnAunrwDAjBqycoV09+qZ+Terin21RDjRaikXGd3StbFm
         eSV+BTRtAuP9Wata/QYg0zmkILxHvhcf8uG6etA6eDlrIr4FdlBGrsp9LoQDiClpgJ3g
         Ncm8zGXdEnRbDjrwEbKOSZ8T6GBp69OclaIUMchPsZrcfBjaynatqJbC1QAmwKe76nH8
         cngw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVR8GXlZW0fXofSxo1QtPaWjpaq/VeKy5pCTLABw06TVmuQGlBoSQ0EI8k3hujlHAQuXFHV5TjGNH/3CCwI4Q5QAJKbEiS7YOKq94vgWK+m
X-Gm-Message-State: AOJu0YwNlZoRHlPjjzP+ljga8k1boAHkplExopKmiJUMpS2ZTONBrZZD
	lCAv+4dtZaIcZxG9glBYq8TvhYz46sohUqy+WbKoS/cuMgf1KSZyQj2fDsEXJeiQCc3i6FajuqP
	EcyWOqlQwHjeDqI2CM96/tkCFcbC/OQHBOFLYaQSArD6AfOBSx02vwaA=
X-Google-Smtp-Source: 
 AGHT+IG5gnwO+2PNyj24HiTL4E5/5if1gDwVATLMA9Vwy4dawML/hf5wVhjnmhELMScFZcHeC9MRJ4EjKNSXQrMFIWf01H5IIKLN
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218a:b0:375:9cb9:9d04 with SMTP id
 e9e14a558f8ab-393d2f7eda0mr26745ab.3.1721069907170; Mon, 15 Jul 2024 11:58:27
 -0700 (PDT)
Date: Mon, 15 Jul 2024 11:58:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000736b1e061d4dd0b6@google.com>
Subject: [syzbot] Monthly batman report (Jul 2024)
From: syzbot <syzbot+list04e0bfa034e581a03989@syzkaller.appspotmail.com>
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
	linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch,
	netdev@vger.kernel.org, sven@narfation.org, sw@simonwunderlich.de,
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-MailFrom: 
 3U3GVZgkbAMY4ABwmxxq3m11up.s00sxq64q3o0z5qz5.o0y@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: DDTHBL5L333B7NSBHLZMOXKSZOTCY3V6
X-Message-ID-Hash: DDTHBL5L333B7NSBHLZMOXKSZOTCY3V6
X-Mailman-Approved-At: Tue, 16 Jul 2024 09:27:28 +0200
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/DDTHBL5L333B7NSBHLZMOXKSZOTCY3V6/>
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

During the period, 1 new issues were detected and 0 were fixed.
In total, 3 issues are still open and 26 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1297    Yes   INFO: rcu detected stall in worker_thread (9)
                  https://syzkaller.appspot.com/bug?extid=225bfad78b079744fd5e
<2> 381     Yes   INFO: rcu detected stall in batadv_nc_worker (3)
                  https://syzkaller.appspot.com/bug?extid=69904c3b4a09e8fa2e1b
<3> 10      No    BUG: soft lockup in batadv_iv_send_outstanding_bat_ogm_packet
                  https://syzkaller.appspot.com/bug?extid=572f6e36bc6ee6f16762

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
