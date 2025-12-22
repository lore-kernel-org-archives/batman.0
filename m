Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12FA4D711D5
	for <batman-adv@archiver.kernel.org>; Mon, 22 Dec 2025 08:48:30 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 46B8785911
	for <batman-adv@archiver.kernel.org>; Mon, 22 Dec 2025 09:48:29 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1766393309;
 b=z7Z6NH+HrJJLWMNomJ6xT1U3NOROa0zy88OaUIKKWXTrUT0y0cenbD0Wwlt1UEDsip6XJ
 Y4BzVqJo61SAkWyIZOjW4K3o2ntsVBiPwfBZcqDA0PGbxJuFpQ/NTmNHMSI46YG1BVryDqD
 qcM5Twn1PJCj9LD59FPr8r4ZlRXYqMw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1766393309; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=rVTogvMdRrp+177UPu0mkVnw4JPQa72tIscPDmrwGsQ=;
 b=myq+VCtoqp7gn9kNiBF++zpSJRcnswtE0FbkmR809Nfldxgla32abmFUvPgleyUdPzGtS
 xwcyvl1G20hzXIMvm8MwzIfJhqcMz0ql5j7f0IJD5UEdtQq6fgrzs/w+P9P0PffmYtcqTRs
 wOQcCAl9STe74VvTvqFrYNcPHutRDfQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=fail header.from=syzkaller.appspotmail.com policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com
 [209.85.161.79])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 8458F83E65
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 22 Dec 2025 06:27:32 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1766381252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=rVTogvMdRrp+177UPu0mkVnw4JPQa72tIscPDmrwGsQ=;
	b=tGC1rO9ULcSVladutVia2LQ3JeKetQrgFjoOgOiTBpGyc5RsRbVPvGjZVmcvOEM+mkHHUe
	6B/ihl0Pm566/kdL+HMzDKvoWeSwnjuNcVPLaf99Fc95B18sHjnxbTSQs8TR23iauhMMH0
	oMPWP/xYRmX9rO69mA7xSYaqcX7lacU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed),
 No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (diktynna.open-mesh.org: domain of
 3wtZIaQkbAOMXdePFQQJWFUUNI.LTTLQJZXJWHTSYJSY.HTR@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
 designates 209.85.161.79 as permitted sender)
 smtp.mailfrom=3wtZIaQkbAOMXdePFQQJWFUUNI.LTTLQJZXJWHTSYJSY.HTR@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1766381252;
	b=yTPui+Zw/4jlG+ki4epXo6yLxB5wWaR7kQlEXk83kldn1pMO8FJOcYBnwwp4okfgSQTFdD
	QhVBo74gGx6t1pD5oWBi/UB5kz9jFxoQQxFqL2lsol5AukI3oxjWT4sQNQAOrIWHA40eAR
	UK+K0U7zyZjgwnNs2pU6sW2bb0G3tfs=
Received: by mail-oo1-f79.google.com with SMTP id
 006d021491bc7-65cfea2cedeso3309360eaf.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Sun, 21 Dec 2025 21:27:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766381251; x=1766986051;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rVTogvMdRrp+177UPu0mkVnw4JPQa72tIscPDmrwGsQ=;
        b=TrHYFgFCdRZgYuUdnVO/GayBv21YNBblK4giGrS7HdCDPt4CJ23Rt24pr7vAY6Vryd
         EtGr/AfiPMIzN9JkHpiBbTs8XibWm/CoiSJkRy9NMJ4jqVdv7Wj2G/CEBY705KRj4aAw
         BZn/UCmLyu0ubS2FYXddlcOQL8t82T+R9jBp3PobVKvRzOixDh8DIYGEyYL83cMW7FOS
         J4mxlLSb++G1xS0OUD2xTif9oeb5Lpr6eDYFq+E/1+lL71N/TkYQRocNqfuIulHIJdS/
         jP8ws3XQtOuQi1BgjEHZ/KmcIgkTEodS9Um8KATIRV6iqh69lylbrynwRnruEK5tdjNd
         3WkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkUTVfmwIWKgxtkGE0wqHU7PDApMJ/6IbT81SFkqs1TMtSlefigKcRMilNg+BHs49sfqngXzU9y5wTuw==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YxrFVbh3MCroLNXsdHRDTQF5tRDS602VEvF7Zys5CKHlQYrAqzV
	PnMybCoyK2EnciP4HG8BJRAYZiFeXD1iRNTIetTCWMdc0BWfGsqtPc/G0Gegj0nlg13nrMV73IS
	1FgT0aflCa3gNCeCBtJuZqnXRzysGzzfelOzs8Fu8OsMTetYYyNOAzMV/6wk=
X-Google-Smtp-Source: 
 AGHT+IFE4zFxjAPsXIoOdd2IcldDNzsNlyzLo99MXfI1oa1VqqwZd1/eJLssEysdT4MxHNojDsy6BvX9DKgxD8GO/J1vBwiekqeC
MIME-Version: 1.0
X-Received: by 2002:a05:6820:16a1:b0:65d:5ce:869d with SMTP id
 006d021491bc7-65d0e9b71e6mr4113965eaf.19.1766381250754; Sun, 21 Dec 2025
 21:27:30 -0800 (PST)
Date: Sun, 21 Dec 2025 21:27:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6948d6c2.a70a0220.25eec0.0082.GAE@google.com>
Subject: [syzbot] [batman?] INFO: rcu detected stall in
 batadv_mcast_mla_update
 (2)
From: syzbot <syzbot+0a80c6499b110dbf88b7@syzkaller.appspotmail.com>
To: antonio@mandelbit.com, b.a.t.m.a.n@lists.open-mesh.org,
	davem@davemloft.net, edumazet@google.com, horms@kernel.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, marek.lindner@mailbox.org,
	netdev@vger.kernel.org, pabeni@redhat.com, sven@narfation.org,
	sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-MailFrom: 
 3wtZIaQkbAOMXdePFQQJWFUUNI.LTTLQJZXJWHTSYJSY.HTR@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: GQ3RJGABENTI5OBBIG4VX3KQ6GVVNSJ7
X-Message-ID-Hash: GQ3RJGABENTI5OBBIG4VX3KQ6GVVNSJ7
X-Mailman-Approved-At: Mon, 22 Dec 2025 09:48:19 +0100
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

HEAD commit:    dd9b004b7ff3 Merge tag 'trace-v6.19-rc1' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15781392580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a11e0f726bfb6765
dashboard link: https://syzkaller.appspot.com/bug?extid=0a80c6499b110dbf88b7
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13f1b77c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17209db4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/561ed9cd9b06/disk-dd9b004b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a65e1769c76f/vmlinux-dd9b004b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b6ed295e0a08/bzImage-dd9b004b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0a80c6499b110dbf88b7@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P4912/1:b..l
rcu: 	(detected by 0, t=10503 jiffies, g=9721, q=383 ncpus=2)
task:kworker/u8:16   state:R  running task     stack:25480 pid:4912  tgid:4912  ppid:2      task_flags:0x4208060 flags:0x00080000
Workqueue: bat_events batadv_mcast_mla_update
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5256 [inline]
 __schedule+0x1139/0x6150 kernel/sched/core.c:6863
 preempt_schedule_irq+0x51/0x90 kernel/sched/core.c:7190
 irqentry_exit+0x1d8/0x8c0 kernel/entry/common.c:216
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:__update_cpu_freelist_fast mm/slub.c:4385 [inline]
RIP: 0010:__slab_alloc_node mm/slub.c:4873 [inline]
RIP: 0010:slab_alloc_node mm/slub.c:5251 [inline]
RIP: 0010:__kmalloc_cache_noprof+0x4de/0x800 mm/slub.c:5771
Code: c9 74 b9 48 85 db 75 a9 eb b2 4d 85 c9 74 ad 48 85 db 74 a8 bf ff ff ff ff 41 8b 44 24 40 49 8b 34 24 48 8d 4a 08 49 8b 1c 01 <4c> 89 c8 65 48 0f c7 0e 0f 85 51 ff ff ff 41 8b 44 24 40 0f 0d 0c
RSP: 0018:ffffc9000ebe79a0 EFLAGS: 00000246
RAX: 0000000000000010 RBX: ffff8880792c5a00 RCX: 000000000010c861
RDX: 000000000010c859 RSI: ffffffff93b4a250 RDI: 00000000ffffffff
RBP: ffffc9000ebe7a00 R08: 0000000000000018 R09: ffff8880792c5840
R10: 0000000000000000 R11: ffff888036e5aff0 R12: ffff88813ff26780
R13: 0000000000000820 R14: 00000000aaff3300 R15: 0000000000000018
 kmalloc_noprof include/linux/slab.h:957 [inline]
 batadv_mcast_mla_meshif_get_ipv6 net/batman-adv/multicast.c:475 [inline]
 batadv_mcast_mla_meshif_get net/batman-adv/multicast.c:533 [inline]
 __batadv_mcast_mla_update net/batman-adv/multicast.c:909 [inline]
 batadv_mcast_mla_update+0x1937/0x31b0 net/batman-adv/multicast.c:946
 process_one_work+0x9ba/0x1b20 kernel/workqueue.c:3257
 process_scheduled_works kernel/workqueue.c:3340 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3421
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x983/0xb10 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
rcu: rcu_preempt kthread starved for 9521 jiffies! g9721 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:28440 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5256 [inline]
 __schedule+0x1139/0x6150 kernel/sched/core.c:6863
 preempt_schedule_common+0x44/0xc0 kernel/sched/core.c:7047
 preempt_schedule_thunk+0x16/0x30 arch/x86/entry/thunk.S:12
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
 _raw_spin_unlock_irqrestore+0x61/0x80 kernel/locking/spinlock.c:194
 rcu_gp_fqs_loop+0x216/0xaf0 kernel/rcu/tree.c:2083
 rcu_gp_kthread+0x26d/0x380 kernel/rcu/tree.c:2285
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x983/0xb10 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 5905 Comm: kworker/u9:3 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Workqueue: hci4 hci_conn_timeout
RIP: 0010:restore_regs_and_return_to_kernel+0x10/0x2e
Code: ef 3f 48 81 cf 00 08 00 00 48 81 cf 00 10 00 00 0f 22 df 58 5f e9 6e ff ff ff f6 84 24 88 00 00 00 03 74 02 0f 0b 41 5f 41 5e <41> 5d 41 5c 5d 5b 41 5b 41 5a 41 59 41 58 58 59 5a 5e 5f 48 83 c4
RSP: 0018:ffffc9000469f4c8 EFLAGS: 00000046
RAX: 00000000000f1699 RBX: 0000000000000000 RCX: 0000000000000007
RDX: 0000000000000000 RSI: ffffffff8dacde18 RDI: ffffffff8bf2b380
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff9088b3d7 R11: ffff8880265f8b30 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8881249f5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000058 CR3: 000000005b778000 CR4: 00000000003526f0
Call Trace:
 <TASK>
RIP: 0010:rcu_is_watching+0x80/0xc0 kernel/rcu/tree.c:752
Code: 89 da 48 c1 ea 03 0f b6 14 02 48 89 d8 83 e0 07 83 c0 03 38 d0 7c 04 84 d2 75 24 8b 03 c1 e8 02 83 e0 01 65 ff 0d 30 9e 0f 12 <74> 07 5b 5d e9 97 21 d8 09 e8 e2 f4 88 ff 5b 5d e9 8b 21 d8 09 48
RSP: 0018:ffffc9000469f560 EFLAGS: 00000286
RAX: 0000000000000001 RBX: ffff8880b85339e8 RCX: 0000000000000002
RDX: 0000000000000000 RSI: ffffffff8bf2b300 RDI: ffffffff8dd7bf28
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000002 R11: 00000000000128d3 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 trace_lock_acquire include/trace/events/lock.h:24 [inline]
 lock_acquire+0x2cd/0x330 kernel/locking/lockdep.c:5831
 rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 rcu_read_lock include/linux/rcupdate.h:867 [inline]
 class_rcu_constructor include/linux/rcupdate.h:1195 [inline]
 unwind_next_frame+0xd1/0x20b0 arch/x86/kernel/unwind_orc.c:495
 arch_stack_walk+0x94/0x100 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x8e/0xc0 kernel/stacktrace.c:122
 save_stack+0x160/0x1f0 mm/page_owner.c:165
 __reset_page_owner+0x84/0x1a0 mm/page_owner.c:320
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0x7df/0x1170 mm/page_alloc.c:2943
 discard_slab mm/slub.c:3346 [inline]
 __put_partials+0x130/0x170 mm/slub.c:3886
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4c/0xf0 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x195/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:349
 kasan_slab_alloc include/linux/kasan.h:252 [inline]
 slab_post_alloc_hook mm/slub.c:4953 [inline]
 slab_alloc_node mm/slub.c:5263 [inline]
 __kmalloc_cache_noprof+0x282/0x800 mm/slub.c:5771
 kmalloc_noprof include/linux/slab.h:957 [inline]
 hci_cmd_sync_submit+0xbc/0x330 net/bluetooth/hci_sync.c:714
 hci_cmd_sync_run+0x93/0xf0 net/bluetooth/hci_sync.c:807
 hci_cmd_sync_run_once+0x1b5/0x200 net/bluetooth/hci_sync.c:823
 hci_abort_conn+0x182/0x360 net/bluetooth/hci_conn.c:3004
 hci_conn_timeout+0x1f3/0x230 net/bluetooth/hci_conn.c:579
 process_one_work+0x9ba/0x1b20 kernel/workqueue.c:3257
 process_scheduled_works kernel/workqueue.c:3340 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3421
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x983/0xb10 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:pv_native_safe_halt+0xf/0x20 arch/x86/kernel/paravirt.c:82
Code: c6 5f 02 c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d 13 49 12 00 fb f4 <e9> cc 35 03 00 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90
RSP: 0018:ffffc90000197de8 EFLAGS: 000002c6
RAX: 00000000000725eb RBX: 0000000000000001 RCX: ffffffff8b7816d9
RDX: 0000000000000000 RSI: ffffffff8dacde18 RDI: ffffffff8bf2b380
RBP: ffffed1003b58498 R08: 0000000000000001 R09: ffffed10170a673d
R10: ffff8880b85339eb R11: ffff88801dac2ff0 R12: 0000000000000001
R13: ffff88801dac24c0 R14: ffffffff9088b3d0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8881249f5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa8c8f2a6b0 CR3: 00000000650ec000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 arch_safe_halt arch/x86/include/asm/paravirt.h:107 [inline]
 default_idle+0x13/0x20 arch/x86/kernel/process.c:767
 default_idle_call+0x6c/0xb0 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:191 [inline]
 do_idle+0x38d/0x510 kernel/sched/idle.c:332
 cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:430
 start_secondary+0x21d/0x2d0 arch/x86/kernel/smpboot.c:312
 common_startup_64+0x13e/0x148
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
