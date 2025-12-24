Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB7CEE74903
	for <batman-adv@archiver.kernel.org>; Wed, 24 Dec 2025 05:56:49 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B9A5E83AB1
	for <batman-adv@archiver.kernel.org>; Wed, 24 Dec 2025 06:56:47 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1766555807;
 b=D1VptNYuCMPbBpdKoHj0j4reC635l3W2YvKe85ZxKV+P8YXVUWUDEGhqwmsqY8VspaM9s
 yOE52YmOge+t0i90jbn/movCJlQTSL21nYmHKIDKE8D6NM0jckTOp/GjcpjNlNqO349GY4z
 0UmLPDf3vb+l+zZIzG225cKtVF6Imd8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1766555807; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=E6sBvUevn032zQbb+UPs/u8EmyurNxVk6+IGKsWQi/o=;
 b=K8UJDU4z9vV0cqKNt1TWNSbVeG8sMARlw9r4RJiUq/4cfTEDwxu6evb+1NaBM0LysVu2v
 QlpnpvKjL6hkKLoyQo67OfXjCK8KL5ezVGAZMBsiVx1PFin/Qy9pYtLnhiYBm4/gVTm+A05
 tofiIKZMGm3iGsaCbtLBUGrJip4Qx9I=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=fail header.from=syzkaller.appspotmail.com policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com
 [209.85.161.77])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id C4D1A81383
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 24 Dec 2025 04:15:18 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1766546128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=E6sBvUevn032zQbb+UPs/u8EmyurNxVk6+IGKsWQi/o=;
	b=P5Q9Ap/Jn8FDpwTOB7ii6t33uQvtCU3BwnF+lkyrg88G+Dgs1KjZqxIi6Wgmk+8ZfQvSeJ
	Gq+or0dKDxy/FmTfYqbQ892r/iv5BGWzutfTJ1NXS/8QBZ8tHTzS1n9zwReEKfox7St0Js
	Mf7oxApxV+N4FLfC5Eo3v3aBgrp4wXw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed),
 No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (diktynna.open-mesh.org: domain of
 3xFpLaQkbAPcrxyjZkkdqZoohc.fnnfkdtrdqbnmsdms.bnl@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
 designates 209.85.161.77 as permitted sender)
 smtp.mailfrom=3xFpLaQkbAPcrxyjZkkdqZoohc.fnnfkdtrdqbnmsdms.bnl@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1766546128;
	b=E6iGpAoiWVVQvloS0mAxggaOxcpvFXY4LgK8/WLpxjXkW5slUbg9+WPMxNrFc+QTAgRV1i
	DkWPj2DGPCu1THtHh7WVwjFJqSt3VVucbJ1rQakJocyxR9dB7PkvRsJ2KfKRexbL30mJeE
	h8MYkD8OqySaiID8HyLkPCLXds9YCC0=
Received: by mail-oo1-f77.google.com with SMTP id
 006d021491bc7-65b73eb22d2so5246953eaf.2
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Tue, 23 Dec 2025 19:15:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766546117; x=1767150917;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E6sBvUevn032zQbb+UPs/u8EmyurNxVk6+IGKsWQi/o=;
        b=liwRHPibimBA5hPc+RBCJXuuFU62sUmBn8lRAG0NOkeWRawP31emKVcUK85b9ekQf4
         B1chDpgpsDcOpIc3GB+NHmVfvogW936g0TVVRmMUQlix5jYgEjHxNzLRNoCdqnXtz2Cm
         /HGlrz8J862skIToh+QSUtqEgyB07lHxQAcN7HZBBf+HKyZDcBg8CLaHfDp4fdZWgU1p
         GQ09zrNdrGTMdLWoTT+f1GEq5521zumVaCk6KG1+RlHQL8i+TeNQ59/QsLolf9X+xZP9
         AyatY7iEqRAmT6p6/l9VgNjwod56mUsg5bewriG3HV26VkdzsaJOwIsBQU7Cr20rjm3m
         wC1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDqDKptOyiYeifgnX07M5g8c4MvU0gOKSagmNzz3B5oq5DNldtFBU/Tc7/RMqH3hoP/D0fGy6mH031Xg==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YwUez3PdkRQDC8C4jDqWJd0yQrRf11v6c+f9Gk++PUdSj3etwXE
	VQS3cf0fFWXN76yibFg3U2e4YHJuyrrrJZ53TRbKu4w7FaDyoWkAzQ8JbL16wtsVgDTeMUbwi7s
	k4XopeWcmpfbpEmCIKmTQfw5rJ4HCwzDKRo5+kUE0VXx41sZmqr8PL1zv/HE=
X-Google-Smtp-Source: 
 AGHT+IGc7o5YJ8zAy6RI6DPNzw/802F4ALJsRTEuDN9JFQfjzW4tTQLhHt5lKHiwqfUkK+sZDyiEZ0ZbV0Uu9fUWqFIf561lg+aJ
MIME-Version: 1.0
X-Received: by 2002:a05:6820:60f:b0:659:9a49:8e7e with SMTP id
 006d021491bc7-65d0eb46fe2mr7150910eaf.78.1766546116877; Tue, 23 Dec 2025
 19:15:16 -0800 (PST)
Date: Tue, 23 Dec 2025 19:15:16 -0800
In-Reply-To: <6948d6c2.a70a0220.25eec0.0083.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <694b5ac4.050a0220.35954c.000f.GAE@google.com>
Subject: Re: [syzbot] [batman?] INFO: rcu detected stall in
 batadv_iv_send_outstanding_bat_ogm_packet (6)
From: syzbot <syzbot+62348313fb96b25955aa@syzkaller.appspotmail.com>
To: antonio@mandelbit.com, b.a.t.m.a.n@lists.open-mesh.org,
	davem@davemloft.net, edumazet@google.com, horms@kernel.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, marek.lindner@mailbox.org,
	netdev@vger.kernel.org, pabeni@redhat.com, sven@narfation.org,
	sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-MailFrom: 
 3xFpLaQkbAPcrxyjZkkdqZoohc.fnnfkdtrdqbnmsdms.bnl@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: 5LOW4TFAQ6BOUCMWVP7A7FI6ISLS2G5H
X-Message-ID-Hash: 5LOW4TFAQ6BOUCMWVP7A7FI6ISLS2G5H
X-Mailman-Approved-At: Wed, 24 Dec 2025 06:56:38 +0100
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    cc3aa43b44bd Add linux-next specific files for 20251219
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12b62022580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=da1bc82c6189c463
dashboard link: https://syzkaller.appspot.com/bug?extid=62348313fb96b25955aa
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12abdf1a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=118eef1a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/30bf539e6f28/disk-cc3aa43b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0e2f8b08e342/vmlinux-cc3aa43b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ec7ee6ece11f/bzImage-cc3aa43b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+62348313fb96b25955aa@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P198/1:b..l P5961/1:b..l
rcu: 	(detected by 1, t=10502 jiffies, g=13701, q=705 ncpus=2)
task:udevd           state:R  running task     stack:24376 pid:5961  tgid:5961  ppid:5200   task_flags:0x400140 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5258 [inline]
 __schedule+0x150e/0x5070 kernel/sched/core.c:6866
 preempt_schedule_irq+0xb5/0x150 kernel/sched/core.c:7193
 irqentry_exit+0x5d8/0x660 kernel/entry/common.c:216
 asm_sysvec_reschedule_ipi+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:lock_release+0x2a6/0x3b0 kernel/locking/lockdep.c:5893
Code: 4d 48 c7 44 24 20 00 00 00 00 9c 8f 44 24 20 f7 44 24 20 00 02 00 00 75 52 f7 c3 00 02 00 00 74 01 fb 65 48 8b 05 2a 0f 01 11 <48> 3b 44 24 28 75 75 48 83 c4 30 5b 41 5c 41 5d 41 5e 41 5f 5d e9
RSP: 0018:ffffc90003aa78b0 EFLAGS: 00000206
RAX: 6d71d4c1a37b0900 RBX: 0000000000000202 RCX: 6d71d4c1a37b0900
RDX: 0000000000000000 RSI: ffffffff8db7ed49 RDI: ffffffff8be07960
RBP: ffff88802e53a9b0 R08: ffffc90003aa7b20 R09: 0000000000000000
R10: ffffc90003aa7a38 R11: fffff52000754f49 R12: 0000000000000000
R13: 0000000000000000 R14: ffffffff8e13f2e0 R15: ffff88802e539e80
 rcu_lock_release include/linux/rcupdate.h:341 [inline]
 rcu_read_unlock include/linux/rcupdate.h:897 [inline]
 class_rcu_destructor include/linux/rcupdate.h:1195 [inline]
 unwind_next_frame+0x1ab1/0x23d0 arch/x86/kernel/unwind_orc.c:695
 arch_stack_walk+0x11c/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x9c/0xe0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2540 [inline]
 slab_free mm/slub.c:6674 [inline]
 kmem_cache_free+0x197/0x620 mm/slub.c:6785
 do_readlinkat+0x293/0x500 fs/stat.c:596
 __do_sys_readlink fs/stat.c:613 [inline]
 __se_sys_readlink fs/stat.c:610 [inline]
 __x64_sys_readlink+0x7f/0x90 fs/stat.c:610
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd103b153a7
RSP: 002b:00007ffefbfc23a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000059
RAX: ffffffffffffffda RBX: 00007ffefbfc2880 RCX: 00007fd103b153a7
RDX: 0000000000000400 RSI: 00007ffefbfc23b0 RDI: 00007ffefbfc2880
RBP: 00007ffefbfc23b0 R08: 000055a62739fc90 R09: 0000000000000020
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000400
R13: 00007ffefbfc30b5 R14: 000055a5fb7d0ca4 R15: 000055a5fb7d0bcc
 </TASK>
task:kworker/u8:6    state:R  running task     stack:23512 pid:198   tgid:198   ppid:2      task_flags:0x4208060 flags:0x00080000
Workqueue: bat_events batadv_iv_send_outstanding_bat_ogm_packet
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5258 [inline]
 __schedule+0x150e/0x5070 kernel/sched/core.c:6866
 preempt_schedule_irq+0xb5/0x150 kernel/sched/core.c:7193
 irqentry_exit+0x5d8/0x660 kernel/entry/common.c:216
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:lock_acquire+0x16c/0x340 kernel/locking/lockdep.c:5872
Code: 00 00 00 00 9c 8f 44 24 30 f7 44 24 30 00 02 00 00 0f 85 cd 00 00 00 f7 44 24 08 00 02 00 00 74 01 fb 65 48 8b 05 44 41 01 11 <48> 3b 44 24 58 0f 85 e5 00 00 00 48 83 c4 60 5b 41 5c 41 5d 41 5e
RSP: 0018:ffffc900030177e0 EFLAGS: 00000206
RAX: 9c7a27e9643fc600 RBX: 0000000000000000 RCX: 9c7a27e9643fc600
RDX: 00000000814aee25 RSI: ffffffff8db7ed49 RDI: ffffffff8be07960
RBP: ffffffff8b269940 R08: ffffffff8b269940 R09: ffffffff8e13f2e0
R10: dffffc0000000000 R11: ffffed100f2f1517 R12: 0000000000000002
R13: ffffffff8e13f2e0 R14: 0000000000000000 R15: 0000000000000246
 rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 rcu_read_lock include/linux/rcupdate.h:867 [inline]
 batadv_iv_ogm_slide_own_bcast_window net/batman-adv/bat_iv_ogm.c:761 [inline]
 batadv_iv_ogm_schedule_buff net/batman-adv/bat_iv_ogm.c:833 [inline]
 batadv_iv_ogm_schedule+0x454/0xf00 net/batman-adv/bat_iv_ogm.c:873
 batadv_iv_send_outstanding_bat_ogm_packet+0x6c6/0x7e0 net/batman-adv/bat_iv_ogm.c:1709
 process_one_work+0x93a/0x15a0 kernel/workqueue.c:3279
 process_scheduled_works kernel/workqueue.c:3362 [inline]
 worker_thread+0x9b0/0xee0 kernel/workqueue.c:3443
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
rcu: rcu_preempt kthread starved for 10314 jiffies! g13701 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:27232 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5258 [inline]
 __schedule+0x150e/0x5070 kernel/sched/core.c:6866
 __schedule_loop kernel/sched/core.c:6948 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6963
 schedule_timeout+0x12b/0x270 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x301/0x1540 kernel/rcu/tree.c:2083
 rcu_gp_kthread+0x99/0x390 kernel/rcu/tree.c:2285
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:pv_native_safe_halt+0x13/0x20 arch/x86/kernel/paravirt.c:82
Code: cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d 33 9e 2a 00 f3 0f 1e fa fb f4 <e9> 48 ee 02 00 cc cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90000197de0 EFLAGS: 000002c6
RAX: af5d4f71fc268f00 RBX: ffffffff819786ba RCX: af5d4f71fc268f00
RDX: 0000000000000001 RSI: ffffffff8d997e54 RDI: ffffffff8be07960
RBP: ffffc90000197f10 R08: ffff8880b87336db R09: 1ffff110170e66db
R10: dffffc0000000000 R11: ffffed10170e66dc R12: ffffffff8fa22f70
R13: 1ffff11003adab70 R14: 0000000000000001 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff888125d25000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007efd7aea1f98 CR3: 0000000032c9a000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 arch_safe_halt arch/x86/include/asm/paravirt.h:107 [inline]
 default_idle+0x13/0x20 arch/x86/kernel/process.c:767
 default_idle_call+0x73/0xb0 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:191 [inline]
 do_idle+0x1ea/0x520 kernel/sched/idle.c:332
 cpu_startup_entry+0x44/0x60 kernel/sched/idle.c:430
 start_secondary+0x101/0x110 arch/x86/kernel/smpboot.c:312
 common_startup_64+0x13e/0x147
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
