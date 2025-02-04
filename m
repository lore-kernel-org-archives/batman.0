Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FD6C02198
	for <batman-adv@archiver.kernel.org>; Wed,  5 Feb 2025 07:04:03 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5EA4083CDE
	for <batman-adv@archiver.kernel.org>; Wed,  5 Feb 2025 08:04:01 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1738739041;
 b=KvDvouVS8SVOpR5kHtnVn5lZwisWdh5TR3ceiub6Jsxo5zb1+vBhaa519s1LV6NK5V6j9
 LrD/q0NyYrmnmP7SyN8KjMkX3Z5yyAdLnp3VVG8zfovquuP1UuY/l3tLTb4LeUYSbTe41u4
 8zCDyvOtuaQPQOS0O8cPqxpk7J+CUew=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1738739041; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ns36zhmEd8OWtoV79SVotwphVvopr7HCjwhmtCKqZRs=;
 b=vem+WM3jg20CyrlU2kYnKjV79A9fOtJl87Eyu6K6iAwOSabZbzIVgjr70uTxGQt6I8Ix0
 M2m1MEeUxZHTTgCbAqDwEzQ4QcpYr8+xvHai38s3xdg8VyIBGQobQ0SVZSyczNYefZlBYTu
 BH/AziSiY5o6HkOhIfHsB/fvV6ZYwR4=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com
 [209.85.166.205])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 51B0F81B88
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue,  4 Feb 2025 23:30:21 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1738708221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=ns36zhmEd8OWtoV79SVotwphVvopr7HCjwhmtCKqZRs=;
	b=uiyso9AkINwmtBcy24XQ4bGB2CVSqwpGDLQzrPbMtVCJ3HWs0F8d2S/Va6y0KTbZ/rY3hQ
	bwZ3mg6H2as7rmG2DDbKg6KR/i+cRUxtLjljjeAoprksAoazt3QfsWew8EWAm1q5KvkwRX
	5Qb6faTPR+W6zSgUjgPe0uv8AQ2UMYU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of
 3-5SiZwkbAPImsteUffYlUjjcX.aiiafYomYlWihnYhn.Wig@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
 designates 209.85.166.205 as permitted sender)
 smtp.mailfrom=3-5SiZwkbAPImsteUffYlUjjcX.aiiafYomYlWihnYhn.Wig@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	dmarc=fail reason="SPF not aligned (relaxed),
 No valid DKIM" header.from=appspotmail.com (policy=none)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1738708221; a=rsa-sha256;
	cv=none;
	b=SJIgXfK4f2nDJPQ3ECQkz+jRUpPBb5vAaEIKPRWaNomvkjeLApz1yMyFQCp+3jbDMqJp9j
	cWCl3Nho9QnAJddQYR3B9jT+Q36I9VipeTtoOA7y5LI4UgK0GpE6CeTy/tf5Ljc3U9jIMV
	W3yjDnoXy/fiYGFiBvX1SRHjoLOBhsQ=
Received: by mail-il1-f205.google.com with SMTP id
 e9e14a558f8ab-3cfb3c4fc77so2299405ab.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Tue, 04 Feb 2025 14:30:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738708220; x=1739313020;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ns36zhmEd8OWtoV79SVotwphVvopr7HCjwhmtCKqZRs=;
        b=aFabnTidRaja4mKOMIMx5G5PXoHSjp+zoa4soGXxSBgBZYxQPqsz9FHeQzLZd/jL8N
         pXA7UPpCbF+iK4kaXprgOOqOxFYtRVeQM1yf1ZvKhDxm4haRczlDtEbHdTQ3M4EaQkab
         eoWK7IqwEkGCqgtZjJQIvS8EzBqFAXrVqpFhLmpW5+23btGFzJnUC39w1qvfKgJDZ5qe
         CQqeJC0CNsrg9ZQTrG+WKroWuSu7ZSRsJmlBvnfoHo0dX0m8bjH6eVZZ1nx3zOAHnVLP
         Egtn4GEZMnZWIw5GEWqta2yc6vKE0ZFg/7rDLp32fG95V+HwQJ9UhCa3ORsf4DBFDq3N
         QWtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAWq1NHr1vOCU1+yz/X9W9VQ7HvGuyUzUhAy8cihkChsVG5B5cbvs6e00ROwy6PPXHoQlpfetA6UrjFw==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YxTji7BMjTl8ttAsUl4/u9AJNmFQMlsj4lfVs2mB8yJq4SzCLm1
	421sQLo5J6BMImYMkbVjIaGOvg47mwkXXe/A0UVUmZeT/GjWkcBm9OpIPeLf1u2SSEsH2ZWNcKv
	7LO33K/WHpnxBFJsFJCTh4DrYaEjwVLAV/vk5wgdDSvQTVbFWerfmb3k=
X-Google-Smtp-Source: 
 AGHT+IHSzmhD9qvdw5y293zv7MTfkt0hfgtnq7BAQeCJ4sLxR7yBycvaAVtMAVltiVwaHX5uBXTU+Jfa7lmf3TcsKIjS8GHBH3k6
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1528:b0:3d0:47ad:dc86 with SMTP id
 e9e14a558f8ab-3d047addd19mr25558025ab.10.1738708219926; Tue, 04 Feb 2025
 14:30:19 -0800 (PST)
Date: Tue, 04 Feb 2025 14:30:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67a294fb.050a0220.50516.0002.GAE@google.com>
Subject: [syzbot] [batman?] [bcachefs?] BUG: unable to handle kernel paging
 request in __run_timer_base
From: syzbot <syzbot+ab2fd19057fa822e71c6@syzkaller.appspotmail.com>
To: a@unstable.cc, antonio@mandelbit.com, b.a.t.m.a.n@lists.open-mesh.org,
	davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	kent.overstreet@linux.dev, kuba@kernel.org, linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org, marek.lindner@mailbox.org,
	mareklindner@neomailbox.ch, netdev@vger.kernel.org, pabeni@redhat.com,
	sven@narfation.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-MailFrom: 
 3-5SiZwkbAPImsteUffYlUjjcX.aiiafYomYlWihnYhn.Wig@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: YPB7ZXBMSSTGGNCPARYYR2JEKWIRSEKO
X-Message-ID-Hash: YPB7ZXBMSSTGGNCPARYYR2JEKWIRSEKO
X-Mailman-Approved-At: Wed, 05 Feb 2025 08:03:47 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/YPB7ZXBMSSTGGNCPARYYR2JEKWIRSEKO/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hello,

syzbot found the following issue on:

HEAD commit:    69e858e0b8b2 Merge tag 'uml-for-linus-6.14-rc1' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1714c518580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d033b14aeef39158
dashboard link: https://syzkaller.appspot.com/bug?extid=ab2fd19057fa822e71c6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=144ff6b0580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-69e858e0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a53b888c1f3f/vmlinux-69e858e0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6b5e17edafc0/bzImage-69e858e0.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/d96853f65a99/mount_6.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ab2fd19057fa822e71c6@syzkaller.appspotmail.com

kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
BUG: unable to handle page fault for address: ffff8880465c3da0
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0011) - permissions violation
PGD 1aa01067 P4D 1aa01067 PUD 1aa04067 PMD 80000000464001e3 
Oops: Oops: 0011 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 3089 Comm: kworker/u4:10 Not tainted 6.13.0-syzkaller-09760-g69e858e0b8b2 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: bat_events batadv_nc_worker
RIP: 0010:0xffff8880465c3da0
Code: 00 00 00 00 00 00 00 00 00 00 01 03 06 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 a8 3e 5c 46 80 88 ff ff <08> 3e 5c 46 80 88 ff ff b8 6f 54 59 80 88 ff ff 5b 15 00 00 f3 02
RSP: 0018:ffffc90000007b98 EFLAGS: 00010246
RAX: ffffffff81ac83d1 RBX: 0000000000000001 RCX: ffff88803b080000
RDX: 0000000000000100 RSI: ffffffff8c608040 RDI: ffff888059546f28
RBP: ffffc90000007c90 R08: ffffffff81ac83be R09: 1ffffffff203680e
R10: dffffc0000000000 R11: ffff8880465c3da0 R12: 1ffff92000000f78
R13: ffff888059546f28 R14: 0000000000000001 R15: 0000000000000100
FS:  0000000000000000(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff8880465c3da0 CR3: 0000000054b64000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 expire_timers kernel/time/timer.c:1840 [inline]
 __run_timers kernel/time/timer.c:2414 [inline]
 __run_timer_base+0x66a/0x8e0 kernel/time/timer.c:2426
 run_timer_base kernel/time/timer.c:2435 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2445
 handle_softirqs+0x2d4/0x9b0 kernel/softirq.c:561
 __do_softirq kernel/softirq.c:595 [inline]
 invoke_softirq kernel/softirq.c:435 [inline]
 __irq_exit_rcu+0xf7/0x220 kernel/softirq.c:662
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:678
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:lock_acquire+0x264/0x550 kernel/locking/lockdep.c:5855
Code: 2b 00 74 08 4c 89 f7 e8 8a 2b 8b 00 f6 44 24 61 02 0f 85 85 01 00 00 41 f7 c7 00 02 00 00 74 01 fb 48 c7 44 24 40 0e 36 e0 45 <4b> c7 44 25 00 00 00 00 00 43 c7 44 25 09 00 00 00 00 43 c7 44 25
RSP: 0018:ffffc9000db47940 EFLAGS: 00000206
RAX: 0000000000000001 RBX: 1ffff92001b68f34 RCX: ffff88803b080ae8
RDX: dffffc0000000000 RSI: ffffffff8c0ab8e0 RDI: ffffffff8c608060
RBP: ffffc9000db47aa0 R08: ffffffff942f6847 R09: 1ffffffff285ed08
R10: dffffc0000000000 R11: fffffbfff285ed09 R12: 1ffff92001b68f30
R13: dffffc0000000000 R14: ffffc9000db479a0 R15: 0000000000000246
 rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 rcu_read_lock include/linux/rcupdate.h:849 [inline]
 batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:408 [inline]
 batadv_nc_worker+0xec/0x610 net/batman-adv/network-coding.c:719
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3317
 worker_thread+0x870/0xd30 kernel/workqueue.c:3398
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
CR2: ffff8880465c3da0
---[ end trace 0000000000000000 ]---
RIP: 0010:0xffff8880465c3da0
Code: 00 00 00 00 00 00 00 00 00 00 01 03 06 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 a8 3e 5c 46 80 88 ff ff <08> 3e 5c 46 80 88 ff ff b8 6f 54 59 80 88 ff ff 5b 15 00 00 f3 02
RSP: 0018:ffffc90000007b98 EFLAGS: 00010246
RAX: ffffffff81ac83d1 RBX: 0000000000000001 RCX: ffff88803b080000
RDX: 0000000000000100 RSI: ffffffff8c608040 RDI: ffff888059546f28
RBP: ffffc90000007c90 R08: ffffffff81ac83be R09: 1ffffffff203680e
R10: dffffc0000000000 R11: ffff8880465c3da0 R12: 1ffff92000000f78
R13: ffff888059546f28 R14: 0000000000000001 R15: 0000000000000100
FS:  0000000000000000(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff8880465c3da0 CR3: 0000000054b64000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	2b 00                	sub    (%rax),%eax
   2:	74 08                	je     0xc
   4:	4c 89 f7             	mov    %r14,%rdi
   7:	e8 8a 2b 8b 00       	call   0x8b2b96
   c:	f6 44 24 61 02       	testb  $0x2,0x61(%rsp)
  11:	0f 85 85 01 00 00    	jne    0x19c
  17:	41 f7 c7 00 02 00 00 	test   $0x200,%r15d
  1e:	74 01                	je     0x21
  20:	fb                   	sti
  21:	48 c7 44 24 40 0e 36 	movq   $0x45e0360e,0x40(%rsp)
  28:	e0 45
* 2a:	4b c7 44 25 00 00 00 	movq   $0x0,0x0(%r13,%r12,1) <-- trapping instruction
  31:	00 00
  33:	43 c7 44 25 09 00 00 	movl   $0x0,0x9(%r13,%r12,1)
  3a:	00 00
  3c:	43                   	rex.XB
  3d:	c7                   	.byte 0xc7
  3e:	44                   	rex.R
  3f:	25                   	.byte 0x25


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
