Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 876A8D0D170
	for <batman@archiver.kernel.org>; Wed,  7 Jan 2026 21:33:05 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id BCFBA85966
	for <batman@archiver.kernel.org>; Wed, 07 Jan 2026 22:33:03 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1767821583;
 b=QrvzW8PIMEy3XY1stLfz/ajOv7uGmtRlrLyqheoQbHflBV6ziwO2MWAo08wEKfk5QlRld
 rwHBzs0aUUyKVet9kl7C3h5jTZrJ/m7sQUrVbdDlmhCNLXJ5+n1a0Mp+KRhKbiNItVg+ldA
 aK2UYCUSqXIIJPrSv9VC0KZXDgHVa8M=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1767821583; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=YXJ9WC2NmU9YEErBDW4d1c4BSngY0akKh966eavx5Fk=;
 b=G9XVzO6mMrWoPH6TJBpdXh8BIwxHglnCnyP+glEfDdfAugn6p6k3JP4qvtJ5Fba2szLTF
 nNtk4kc1cGF6rzCEnpO/ecCT5u5y9ZYkTSuzY0V7sjj7exIV3n2j2yejnXV2EEUDwCju14c
 gTb3NWzoa6yCGfjxtshvn8PIuPH0mQc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=fail header.from=syzkaller.appspotmail.com policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Received: from mail-ot1-f77.google.com (mail-ot1-f77.google.com
 [209.85.210.77])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 9E5EB843CC
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 07 Jan 2026 18:34:29 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1767807269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=YXJ9WC2NmU9YEErBDW4d1c4BSngY0akKh966eavx5Fk=;
	b=FO2XfPa7r+05b5DLEbxm8eQ05P/yH81OLr53/VxgLHFKeaQbO2Z1VoT21F5RIfuNuZC1TA
	KC3eM7CDhs7k5kOPdm+OAExkUGv/BrLnaEqr7yfQZus08+5nAiIeAEPHw7Qkls/lX8cb/t
	j6kkturex8OUsB+DaHdQL3pReoUyCbU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of
 3I5leaQkbACIQWXI8JJCP8NNGB.EMMEJCSQCPAMLRCLR.AMK@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
 designates 209.85.210.77 as permitted sender)
 smtp.mailfrom=3I5leaQkbACIQWXI8JJCP8NNGB.EMMEJCSQCPAMLRCLR.AMK@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	dmarc=fail reason="SPF not aligned (relaxed),
 No valid DKIM" header.from=appspotmail.com (policy=none)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1767807269;
	b=rCD8O1ZP3gAzl9nXb+ai4K4LmzPJZ2WS+AVBPwATEi3RJUcwBRJH53yb/ss3asn0S+0ppD
	tMxyqxyDRg/lAVaL8WZQwgc0TjeCl/Q6zrqfQ385RsamqWQ+hHM6wZU7GGPhkg5/SJk8aF
	JFexL8hUFYguAedaa0gdvVpyvOa7s9w=
Received: by mail-ot1-f77.google.com with SMTP id
 46e09a7af769-7ce031c61ccso2121892a34.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Wed, 07 Jan 2026 09:34:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767807268; x=1768412068;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YXJ9WC2NmU9YEErBDW4d1c4BSngY0akKh966eavx5Fk=;
        b=j63RB9Z0EEylNgqPq5pWKkv0+YcEqUAsdsu/Oc0MCiCiKmkz66IN5QCDQq3Sz4IS3w
         tD8D8GafjorheFo4eM62XV2nvaOF2Gvm+yCzz6d7lxDzX3zdJyp8BIJBkvwPlRuzu7qP
         8ZyESt19GreIiOXIM0v+Rkcugp2V0IJ6gsvfC8TKpEz10BCL9ORkvRzmITj79BgthanY
         fe7A//1/RZoxl5fmlt8VZtwMMo6GFjVcyl95YSGHHTx7DcjplHvOwMe+uhict2E5WDhE
         EblqAJ+A3AvXjIlFgJdE/eR3ECHj63NF7Lp2wjgm+yKu0VbkD4H4lxEQYfXIctZDc2ua
         P0Kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMhzHyhpzo1LyTDlFBJP4ybvruvpi7hWsG9NC28g6BPFhssi0vs25/LAlJWtfhVRbkB91XXGHWXzlckg==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YyVcFgcJXzYMs8xLOLyBQpsncdk4f/G182uBFNWHR4DJNC01jqA
	yG9u356klq9K0g6NVuQ5NusRY4m8w6oJVdxFR0xsEYUUFivS36dm+HIYuoVn6fRVU0EMLJKXnv+
	SjHusE1lLAmHoPiPdYsPjgXp3nGYdcCCXVVUj8WYzIsPyfT7Txv8KaTU5ucY=
X-Google-Smtp-Source: 
 AGHT+IH4AnecHwe1eU+seiZT8AASstncmzFKC7GVs7sp+BqLT+rUYXqD/TFtAndib/yxC1B/VhUmEO2OoS2WpKMEmKAy6Syz4FVi
MIME-Version: 1.0
X-Received: by 2002:a4a:e645:0:b0:65b:299f:8947 with SMTP id
 006d021491bc7-65f481e96e9mr3009818eaf.14.1767807267978; Wed, 07 Jan 2026
 09:34:27 -0800 (PST)
Date: Wed, 07 Jan 2026 09:34:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <695e9923.050a0220.1c677c.0370.GAE@google.com>
Subject: [syzbot] [batman?] [bluetooth?] memory leak in skb_clone (3)
From: syzbot <syzbot+6e76aa21aaf2d8be6034@syzkaller.appspotmail.com>
To: antonio@mandelbit.com, b.a.t.m.a.n@lists.open-mesh.org,
	johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org,
	marek.lindner@mailbox.org, netdev@vger.kernel.org, sven@narfation.org,
	sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-MailFrom: 
 3I5leaQkbACIQWXI8JJCP8NNGB.EMMEJCSQCPAMLRCLR.AMK@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: 5V3H5CN42XY7DF75OULQM2PEOG2WHPSF
X-Message-ID-Hash: 5V3H5CN42XY7DF75OULQM2PEOG2WHPSF
X-Mailman-Approved-At: Wed, 07 Jan 2026 22:32:41 +0100
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

Hello,

syzbot found the following issue on:

HEAD commit:    4a26e7032d7d Merge tag 'core-bugs-2025-12-01' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=116a9512580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbf343972ee89096
dashboard link: https://syzkaller.appspot.com/bug?extid=6e76aa21aaf2d8be6034
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=179be192580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15cd92b4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3f4ff8b7d65f/disk-4a26e703.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2fbb585ef1ac/vmlinux-4a26e703.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dfdc58db78d3/bzImage-4a26e703.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6e76aa21aaf2d8be6034@syzkaller.appspotmail.com

2025/12/03 00:25:54 executed programs: 5
BUG: memory leak
unreferenced object 0xffff88811a1e1100 (size 240):
  comm "kworker/u9:0", pid 51, jiffies 4294944590
  hex dump (first 32 bytes):
    90 50 50 42 81 88 ff ff 90 50 50 42 81 88 ff ff  .PPB.....PPB....
    00 00 00 00 00 00 00 00 00 50 50 42 81 88 ff ff  .........PPB....
  backtrace (crc eed28d2d):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4983 [inline]
    slab_alloc_node mm/slub.c:5288 [inline]
    kmem_cache_alloc_noprof+0x397/0x5a0 mm/slub.c:5295
    skb_clone+0xae/0x2b0 net/core/skbuff.c:2050
    __skb_tstamp_tx+0x3a0/0x4c0 net/core/skbuff.c:5636
    hci_conn_tx_queue+0x11c/0x1d0 net/bluetooth/hci_conn.c:3026
    hci_send_conn_frame net/bluetooth/hci_core.c:3086 [inline]
    hci_sched_acl_pkt net/bluetooth/hci_core.c:3701 [inline]
    hci_sched_acl net/bluetooth/hci_core.c:3726 [inline]
    hci_tx_work+0x437/0x570 net/bluetooth/hci_core.c:3820
    process_one_work+0x26b/0x620 kernel/workqueue.c:3263
    process_scheduled_works kernel/workqueue.c:3346 [inline]
    worker_thread+0x2c4/0x4f0 kernel/workqueue.c:3427
    kthread+0x15b/0x310 kernel/kthread.c:463
    ret_from_fork+0x2af/0x2e0 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
