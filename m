Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6379C021AD
	for <batman-adv@archiver.kernel.org>; Thu, 20 Feb 2025 08:02:26 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id EE28681D57
	for <batman-adv@archiver.kernel.org>; Thu, 20 Feb 2025 09:02:24 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1740038544;
 b=b8NKPkNiJxzqMvNR5mNyth5JSKubZvH/KXs3FKAwHpInz+WFyGy8jhxVHiPidxBafRv+P
 Igy7esCX90ev+/rpcDuAOdu8xxwm7wmzrHdmKe5JktcIjB8zYFXlC26eyhfxKjs4rXAlXJG
 8sGtOySakXYpaniRoytd5hWnI7KaLfY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1740038544; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=WMYI6ti4AQSr1Rxyf3QXt1wFZpcNduqxnseU/edZOhw=;
 b=leEXzITuLWqlca0S6S6vU1mzGbG09te3lv5B8mjFf14nUGFf55w3/fOFRsH4v4M/fpnB3
 /NyZ8BirEijOPK69EF6PhVou3xCCj56lgqEIFlrhACjpKgFUJse+JA6+w77M/XXHfMYgCZo
 XFigFWJTfZak+tcCUfqoaolF8yFTxhk=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com
 [209.85.166.206])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id A511E81415
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 20 Feb 2025 08:37:27 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1740037047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=WMYI6ti4AQSr1Rxyf3QXt1wFZpcNduqxnseU/edZOhw=;
	b=X/1VON1ZXyEWRCLjxm38KFUpLs7u0uYxkhPRvTQB4YDQK87KI8Uu2wds0tCwfxLA6kRihW
	kT/UBW/rGC6KQ1NqyYg5AUnShJ5Ao1w/CXKS+sGjHm/8oLfQMDL8vvEhN65aQkboetwx3T
	Wb+tAgL5TdWTrAbLvT59zNGkirfhaD0=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1740037047; a=rsa-sha256;
	cv=none;
	b=Jx1I14HrK4f6WjVXgFEDrGXY0F6qAjxEoGIXOImr1UK4Ho5iVYjYM49J8NNvCM5d05KbQ0
	5gX7UKek2YgG75A3JLPkntLT2XoOoQS20upygF9xBmrumEHorkmobp7/gbZm73oX0i8i9k
	Vn0WCW5SQl64QpkT12wKecSUcGTkp2U=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed),
 No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (diktynna.open-mesh.org: domain of
 3ttu2ZwkbAI09FG1r22v8r66zu.x55x2vB9v8t54Av4A.t53@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
 designates 209.85.166.206 as permitted sender)
 smtp.mailfrom=3ttu2ZwkbAI09FG1r22v8r66zu.x55x2vB9v8t54Av4A.t53@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id
 e9e14a558f8ab-3d2b6d933a3so10603825ab.3
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Wed, 19 Feb 2025 23:37:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740037046; x=1740641846;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WMYI6ti4AQSr1Rxyf3QXt1wFZpcNduqxnseU/edZOhw=;
        b=BlueZTjFWku3vkI5uGh+rdCwB7pnZMB7KJLqA1jjrB4Ai+EN5SbJkNm69Y6mwGztqc
         pgcsdy3iHtJAcgD60t7qoNejElIVyCEu4ru9a9f7SuK1K8mJqXvfAzdGHLXUbmIQbCIg
         71+QnfYK/2d+I4bYZdWXoW0nuRCCW8HySvRXFOCPWh2mop8X7JmVrONl9jL4y7m8oSXf
         mT8urJ/0qXN8P47Pv0JsOXTuXQHEvD/HIWDpxVZiPxFbacmhUMT7luRhOMGvVkbDlvNS
         FqDkhVlFkFXPlAadtANAOlxF6pWvseec2a4obNUK4hJ18Qc1pM1OrKAJROdtp6VtHiqy
         2LGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXstCHrjP1VWIXe8/rn1ynhJwBRSNWgn97gds/mwj7bmzSkYHfNUbRfOEfzffKakKjj+yCjx5cIh453WA==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YzMT/AYFW32l9PVDA0CjpBBomlzq8WsI6B1v+Tg2h4SLhKYgYRF
	t0Q1Udwnp75ZJh4NlbcBr3L16w1Z9b6Ar8kd542bry5nD1YQGPYENHeM8Q3keqGLPYXyqYpriFU
	TAIhmlFlvhk4uCzybC3KUBR0AsnJIzC2Np4LL721qMAHA8WibAztlmQU=
X-Google-Smtp-Source: 
 AGHT+IF0Z3TX34vBZ+BlW3GZaFJWOTucxOlZhnRdPfNomVepqDqDXro1IV2A7WQVaWRgT5OB4eVNObGrUDKvA4vj3PgO3eyavQjv
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ed:b0:3d0:123e:fbdd with SMTP id
 e9e14a558f8ab-3d2b52de02dmr68301295ab.11.1740037046331; Wed, 19 Feb 2025
 23:37:26 -0800 (PST)
Date: Wed, 19 Feb 2025 23:37:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b6dbb6.050a0220.14d86d.015d.GAE@google.com>
Subject: [syzbot] [batman?] WARNING: locking bug in batadv_nc_purge_paths
From: syzbot <syzbot+0fcf6f9bc18978d651d4@syzkaller.appspotmail.com>
To: a@unstable.cc, antonio@mandelbit.com, b.a.t.m.a.n@lists.open-mesh.org,
	davem@davemloft.net, edumazet@google.com, horms@kernel.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, marek.lindner@mailbox.org,
	mareklindner@neomailbox.ch, netdev@vger.kernel.org, pabeni@redhat.com,
	sven@narfation.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-MailFrom: 
 3ttu2ZwkbAI09FG1r22v8r66zu.x55x2vB9v8t54Av4A.t53@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: 3R4BGMEHJQ5MJ4YINYAROLNW7AHZTSYY
X-Message-ID-Hash: 3R4BGMEHJQ5MJ4YINYAROLNW7AHZTSYY
X-Mailman-Approved-At: Thu, 20 Feb 2025 09:02:11 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/3R4BGMEHJQ5MJ4YINYAROLNW7AHZTSYY/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hello,

syzbot found the following issue on:

HEAD commit:    ad1b832bf1cf Merge tag 'devicetree-fixes-for-6.14-1' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13cf0898580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c776e555cfbdb82d
dashboard link: https://syzkaller.appspot.com/bug?extid=0fcf6f9bc18978d651d4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-ad1b832b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/64103cb6fc45/vmlinux-ad1b832b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9bc34ac014d0/bzImage-ad1b832b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0fcf6f9bc18978d651d4@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(!test_bit(class_idx, lock_classes_in_use))
WARNING: CPU: 0 PID: 3034 at kernel/locking/lockdep.c:5198 __lock_acquire+0x165b/0x2100 kernel/locking/lockdep.c:5198
Modules linked in:
CPU: 0 UID: 0 PID: 3034 Comm: kworker/u4:11 Not tainted 6.14.0-rc2-syzkaller-00303-gad1b832bf1cf #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: bat_events batadv_nc_worker
RIP: 0010:__lock_acquire+0x165b/0x2100 kernel/locking/lockdep.c:5198
Code: 0f b6 04 08 84 c0 0f 85 31 0a 00 00 83 3d 20 46 a0 0e 00 75 19 90 48 c7 c7 e0 a2 2a 8c 48 c7 c6 20 cc 2a 8c e8 96 b1 e4 ff 90 <0f> 0b 90 90 90 e9 be fd ff ff 90 0f 0b 90 e9 16 fd ff ff 90 e8 ec
RSP: 0018:ffffc9000db2f7b0 EFLAGS: 00010046
RAX: fa1dc7e27e145700 RBX: 000000000ac7c7f7 RCX: ffff88804021a440
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff88804021af80 R08: ffffffff81817e32 R09: 1ffff11003f8519a
R10: dffffc0000000000 R11: ffffed1003f8519b R12: ffff88804021af14
R13: ffff88804021a440 R14: 0000000000000000 R15: ffff88804021afa0
FS:  0000000000000000(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055aa7d195048 CR3: 000000001f62c000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
 _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
 spin_lock_bh include/linux/spinlock.h:356 [inline]
 batadv_nc_purge_paths+0xe8/0x3b0 net/batman-adv/network-coding.c:442
 batadv_nc_worker+0x328/0x610 net/batman-adv/network-coding.c:720
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xabe/0x18e0 kernel/workqueue.c:3317
 worker_thread+0x870/0xd30 kernel/workqueue.c:3398
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
