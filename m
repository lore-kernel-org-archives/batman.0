Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F88CCD188
	for <batman-adv@archiver.kernel.org>; Wed, 18 Sep 2024 07:40:54 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E126083E82
	for <batman-adv@archiver.kernel.org>; Wed, 18 Sep 2024 09:40:52 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1726645252;
 b=iML9rYcSAtGKhDI6zN5RmYdSrIlvEQpwenJ5lpRTqQnyXXGPqNZi7TlSHZ5nPpkHAlGCr
 vTfsZgf4NuKvnjB5uEFPVgDlOVJDn6bZttqSAvQa1fqGiwhlSV26ODs1IYa/A13uoRa8vqw
 zs6IqvOy9gnJ84Bfz9V2lfWInlZZu/I=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1726645252; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=vtND32/SYm0OgRTQZPOmIj3ViiVDp+IloAgloyjqPZM=;
 b=dcGpdf9qKUCvJEBN6Mp0cMD4+GszJOoge5ISvmrVMQbQZUeh9tbBlivDxJflKwqx5cAQr
 EwuSihzNfCX4uTwZlY1u6JJAE1es5UQk7gwPdvzakmkEWnF1lkc0/yZ1CnyO1zJZ4KYKGbp
 I14XKwKC+AdCsMBShk0wv+nJ21iUNck=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id EE01D81D8E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 17 Sep 2024 17:14:23 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1726586064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=vtND32/SYm0OgRTQZPOmIj3ViiVDp+IloAgloyjqPZM=;
	b=jG5uJBSXGlykT6JUQdEygijEYgvAmYRwx9joRpTYv8hjQObGVxcJ1Oo74s4GXrsgT8ZpCU
	xlA/RE0YAx+92AgLRrHuzdsa668h2C7vIgew0D2Aew28FBbgJe2WD06vTrb+JlJtX0qH8z
	3y4U9WIATX0UXKiSEr8mMPOvBBV8yoE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of
 3zpzpZgkbAOsflmXNYYReNccVQ.TbbTYRhfRePbagRag.PbZ@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
 designates 209.85.166.199 as permitted sender)
 smtp.mailfrom=3zpzpZgkbAOsflmXNYYReNccVQ.TbbTYRhfRePbagRag.PbZ@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	dmarc=fail reason="SPF not aligned (relaxed),
 No valid DKIM" header.from=appspotmail.com (policy=none)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1726586064; a=rsa-sha256;
	cv=none;
	b=FCR/wz6kZOCw6ZcjalHvvrXBsuYkw68VLSJbLkhwuTBOiU9OZMWEt4aGr4x5r+pI7E4+OR
	jyrhLf9oXOPCTh18TNtvbAj/XuCXYsP9tnxcV26aA35ozQF3rsePv5+4Ug8RJLBZRoXLxB
	AXzGijPB2SZ4584z81nPMsoE5jV0vyY=
Received: by mail-il1-f199.google.com with SMTP id
 e9e14a558f8ab-3a04bf03b1aso111510025ab.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Tue, 17 Sep 2024 08:14:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726586062; x=1727190862;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vtND32/SYm0OgRTQZPOmIj3ViiVDp+IloAgloyjqPZM=;
        b=X5JFUFEK7ErWrkZDfrLHOPXVJF4ks32MDEq0vCeJ4crDoClZgNR8skI5mE5QY4xNe0
         uN6ESeNwlCcnijxqKIVAMNya4pjXfnKjXZtFxpoIipN92q958yz/Vt/AtWA8B32RqKkh
         cd2lzp+wAeRzSYVMPNYvh6tsuTat3oouJ6vbfRBV0CvNQJUFXLO3Os+so3SfOiutJ0zu
         BtENw8spZlntjmxaCEyoYmklp5iohGmKjQzJ7NgmgKsFBWn2lpV7cW+ZSqOOfthQ71Vn
         5MMf//oOMLqeZtiFQd33j673Vu8MXfqKAEe9cnwRPj4p4h7A78tSikOUIFJQAO/WevYq
         wsIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8teInHBhvwyaUtT0/fyVUNzqUQu4s9fuV+n8jfFf538cfDGXQnfzAetWRD9HRt7EVegyLyRJ1Y6r4DQ==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YzrwEyi2Cwd5Opp/CXcobjbHWq1OEy+rrBDabJ7s8FZpR//017j
	E8ASo/wzhHMjeEN7xffgitb6XH5r6rwk1T1igK5tgHIo76bNhO59Vwh2wSgpkmlCzWbC009RmTe
	88NTD0ByScU8O6PgUxzXpIZDr/yu02ES4P0tiLOR+j/DWZ5Dg8YwrsXo=
X-Google-Smtp-Source: 
 AGHT+IETDPpkSfbGfGgnqnk4VyZm99w66bk6EGEmt45LYmvODtc5mgVFx7WeKNKGlGuH8JFsqbUqV00/AXGl10W5qD3jfroAa9ts
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d85:b0:3a0:8dc8:4cd with SMTP id
 e9e14a558f8ab-3a08dc80569mr134333065ab.23.1726586062618; Tue, 17 Sep 2024
 08:14:22 -0700 (PDT)
Date: Tue, 17 Sep 2024 08:14:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000efd5da06225224a6@google.com>
Subject: [syzbot] [batman?] INFO: rcu detected stall in
 batadv_bla_periodic_work
 (2)
From: syzbot <syzbot+fc38cf2d6e727d8415c7@syzkaller.appspotmail.com>
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
	mareklindner@neomailbox.ch, netdev@vger.kernel.org, pabeni@redhat.com,
	sven@narfation.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-MailFrom: 
 3zpzpZgkbAOsflmXNYYReNccVQ.TbbTYRhfRePbagRag.PbZ@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: GDPODWAPDVHDGI2RLYJARJOB2AQH2R22
X-Message-ID-Hash: GDPODWAPDVHDGI2RLYJARJOB2AQH2R22
X-Mailman-Approved-At: Wed, 18 Sep 2024 09:40:11 +0200
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/GDPODWAPDVHDGI2RLYJARJOB2AQH2R22/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hello,

syzbot found the following issue on:

HEAD commit:    196145c606d0 Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13eb27c7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28869f34c32848cf
dashboard link: https://syzkaller.appspot.com/bug?extid=fc38cf2d6e727d8415c7
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15be7807980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/94719b44a92c/disk-196145c6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bc25f4396b64/vmlinux-196145c6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d587a9ecda3e/bzImage-196145c6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fc38cf2d6e727d8415c7@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 0-...D } 2684 jiffies s: 3397 root: 0x1/.
rcu: blocking rcu_node structures (internal RCU debug):
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 29 Comm: kworker/u8:2 Not tainted 6.11.0-rc7-syzkaller-00097-g196145c606d0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: bat_events batadv_bla_periodic_work
RIP: 0010:kasan_check_range+0x14f/0x1a0 mm/kasan/generic.c:190
Code: 83 c0 01 49 89 d3 48 39 d0 74 11 80 38 00 74 ef 4d 8d 1c 2c 48 85 c0 48 89 c2 75 93 48 89 da 4c 89 d8 4c 29 da e9 2c ff ff ff <5b> b8 01 00 00 00 5d 41 5c c3 cc cc cc cc b8 01 00 00 00 c3 cc cc
RSP: 0018:ffffc90000007a68 EFLAGS: 00000046
RAX: fffffbfff2d248e1 RBX: fffffbfff2d248e1 RCX: ffffffff8168d93e
RDX: fffffbfff2d248e1 RSI: 0000000000000008 RDI: ffffffff96924700
RBP: fffffbfff2d248e0 R08: 0000000000000000 R09: fffffbfff2d248e0
R10: ffffffff96924707 R11: 0000000000000000 R12: 0000000000000002
R13: ffff88801d698b58 R14: 0000000000000001 R15: ffff88801d698000
FS:  0000000000000000(0000) GS:ffff8880b8800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000557158cde858 CR3: 000000000db7c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 hlock_class+0x4e/0x130 kernel/locking/lockdep.c:227
 check_wait_context kernel/locking/lockdep.c:4772 [inline]
 __lock_acquire+0x415/0x3cb0 kernel/locking/lockdep.c:5092
 lock_acquire kernel/locking/lockdep.c:5759 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5724
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
 debug_object_activate+0x199/0x540 lib/debugobjects.c:709
 debug_hrtimer_activate kernel/time/hrtimer.c:423 [inline]
 debug_activate kernel/time/hrtimer.c:478 [inline]
 enqueue_hrtimer+0x25/0x3c0 kernel/time/hrtimer.c:1085
 __run_hrtimer kernel/time/hrtimer.c:1706 [inline]
 __hrtimer_run_queues+0xaac/0xcc0 kernel/time/hrtimer.c:1753
 hrtimer_interrupt+0x31b/0x800 kernel/time/hrtimer.c:1815
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
 __sysvec_apic_timer_interrupt+0x10f/0x450 arch/x86/kernel/apic/apic.c:1049
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x90/0xb0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:87 [inline]
RIP: 0010:memory_is_nonzero mm/kasan/generic.c:104 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:129 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/generic.c:161 [inline]
RIP: 0010:check_region_inline mm/kasan/generic.c:180 [inline]
RIP: 0010:kasan_check_range+0x111/0x1a0 mm/kasan/generic.c:189
Code: 44 89 c2 e8 a1 ea ff ff 83 f0 01 5b 5d 41 5c c3 cc cc cc cc 48 85 d2 74 4f 48 01 ea eb 09 48 83 c0 01 48 39 d0 74 41 80 38 00 <74> f2 eb b2 41 bc 08 00 00 00 45 29 dc 49 8d 14 2c eb 0c 48 83 c0
RSP: 0018:ffffc90000a57a58 EFLAGS: 00000246
RAX: fffffbfff20289b3 RBX: fffffbfff20289b4 RCX: ffffffff8169d04b
RDX: fffffbfff20289b4 RSI: 0000000000000008 RDI: ffffffff90144d98
RBP: fffffbfff20289b3 R08: 0000000000000000 R09: fffffbfff20289b3
R10: ffffffff90144d9f R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: ffffffff8ddb9fe0 R15: 0000000000000000
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 cpumask_test_cpu include/linux/cpumask.h:562 [inline]
 cpu_online include/linux/cpumask.h:1105 [inline]
 trace_lock_acquire include/trace/events/lock.h:24 [inline]
 lock_acquire+0xbb/0x560 kernel/locking/lockdep.c:5730
 rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 rcu_read_lock include/linux/rcupdate.h:838 [inline]
 batadv_bla_purge_claims+0x160/0x780 net/batman-adv/bridge_loop_avoidance.c:1289
 batadv_bla_periodic_work+0x51/0x9e0 net/batman-adv/bridge_loop_avoidance.c:1444
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
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
