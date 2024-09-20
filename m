Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DCF0CF9C5B
	for <batman@archiver.kernel.org>; Sat, 21 Sep 2024 09:44:12 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4F8AE83EA3
	for <batman@archiver.kernel.org>; Sat, 21 Sep 2024 11:44:10 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1726911850;
 b=gMUzsbXw3qgAWoGGCwSzilqjFuqHjjaxlm1dKk75aJGEBUBJnloXCVqzbLTVB8INXqM8N
 +AN1QGBffukwMTA7BFyVPypxbtBxu5IoHQ7v3P3HKlYAWyfQJ+18tXCV/0vipNRbZ5aHcnd
 UapuxTnDIcY1Kw//b5ZY0w/cRaJoi08=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1726911850; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=zH4CGun5FdXs5sVSKWrYadSnvsfpjmcreRzHvorZMe8=;
 b=JTlLjoYApO9O68Vi3nksBsznN3oGKhUkxQir8C5LuNGWc9My9aFdoRBR302q9u6SS+0St
 tK2pMBXQwmki5O5AM62EgAc/W2a5zzbA8Si1GoWlV8vEDqJniPGb06gl7QJ+QAgIxMOUtFL
 Fs2rcg6OjoRIi56LD2GwJ3XRhRMyHu4=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id D4D3B81C57
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 20 Sep 2024 22:32:23 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1726864344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=zH4CGun5FdXs5sVSKWrYadSnvsfpjmcreRzHvorZMe8=;
	b=FNCb/Xt0qCLNlbQ/5IMjJApgLYa4OI384L8YrXpyuuyLbH4lSP37ay676X5fmYGvxgXlB+
	VloWwLW8OFkMP1Rykocd8yN865mxgSnyqehFIVFCUbtiGN7Ki+cEIvzdFiikfWShiTd5wl
	nUrreudcVn9GoEjFj792NBMtCfMnGOQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of
 31tvtZgkbAIMz56rhsslyhwwpk.nvvnsl1zlyjvu0lu0.jvt@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
 designates 209.85.166.69 as permitted sender)
 smtp.mailfrom=31tvtZgkbAIMz56rhsslyhwwpk.nvvnsl1zlyjvu0lu0.jvt@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	dmarc=fail reason="SPF not aligned (relaxed),
 No valid DKIM" header.from=appspotmail.com (policy=none)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1726864344; a=rsa-sha256;
	cv=none;
	b=tYTels5/z3zNL12mCRqLHDaDGbmemHjahbehNVKV6/jj/BlLB9916TncGpFj3UBnPzLdvq
	hCNnJaAKwx6dO0JIO22k+llsmC8VyTb5EgRajYbXic/qa/CvtFYiKFQwy7cKLXzc7HThvi
	NLtb6uu85eLiREc1XCMD4Ek3ZE0mbyI=
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-831e873e4e4so252322239f.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Fri, 20 Sep 2024 13:32:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726864342; x=1727469142;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zH4CGun5FdXs5sVSKWrYadSnvsfpjmcreRzHvorZMe8=;
        b=sf8jE5UcwVkgVDD9HHEGuoLj2x0P9bXlUBWtKhKfALNeCWvWv3Kq9wAsaKbuz5v7qm
         H7wQdM2Um1VpRhMnjsUYDrnfBgHBhAixgL+MD3SnUXCg6/sZKsP13hsHcMzprEiSDDpl
         wOOX0vd6D2eWx5KVpMbLfMAEPb8L5N7ZiW0FebTv4hZ/DFqgVkAhUwEOWItitxQb5LLA
         P8tCdyLsf3u8ySMdURRibecjGMNN8BYHOqIPz9Xqw35YCXTW2a3GAoE816hh81DY1VqK
         4trhNR5ixRfYXDRZc5PBCOIvIfHmmLB014G6Hx1lHrRDeNkuzTHT3XDqI6ZXskG5NBmj
         9cbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDYYBFihbDar/57zFfv9pDWVulzc55/sbIJKuDFQlkx1XTXhuU27cRt6T8MaB7MtoJ8sUjnxuJdpoF/g==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YxhDrCcopFHBHuIgg+Odf8am94Ozmhd2Lmbj1VzsRAs2uTiNFsR
	sXDjQ6XXMIV5PaTZZGrJL4FLNtFtUAJau0U9TMEeaWxBL1vUi9IRW/rwafFypFaa7X9kTEBh5Hx
	ewnB/J6bnP5y7N9fJIvpVOfPF3wUPS2nMsV9/tdI37Mfg0SzLGh57QIc=
X-Google-Smtp-Source: 
 AGHT+IGLD46nYhdO8KHMYv0/RE/yy1oHfRbkBTtWpimknnuvwzEg3rHsq6LbvOBKgnMU+J5M4eoVj8xQFtv5zM7LILo+KGKbk+Vf
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a0e:b0:3a0:922f:8e9a with SMTP id
 e9e14a558f8ab-3a0c9d6f2ffmr42851735ab.17.1726864342460; Fri, 20 Sep 2024
 13:32:22 -0700 (PDT)
Date: Fri, 20 Sep 2024 13:32:22 -0700
In-Reply-To: <000000000000ce6fdb061cc7e5b2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66eddbd6.050a0220.3195df.0013.GAE@google.com>
Subject: Re: [syzbot] [netfilter] BUG: soft lockup in
 batadv_iv_send_outstanding_bat_ogm_packet
From: syzbot <syzbot+572f6e36bc6ee6f16762@syzkaller.appspotmail.com>
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net,
	edumazet@google.com, kadlec@netfilter.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch,
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, pabeni@redhat.com,
	pablo@netfilter.org, sven@narfation.org, sw@simonwunderlich.de,
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-MailFrom: 
 31tvtZgkbAIMz56rhsslyhwwpk.nvvnsl1zlyjvu0lu0.jvt@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: LYLDF6YGZ4SBG4GGAB637QIJVHYASQ7P
X-Message-ID-Hash: LYLDF6YGZ4SBG4GGAB637QIJVHYASQ7P
X-Mailman-Approved-At: Sat, 21 Sep 2024 11:43:29 +0200
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/LYLDF6YGZ4SBG4GGAB637QIJVHYASQ7P/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

syzbot has found a reproducer for the following issue on:

HEAD commit:    a430d95c5efa Merge tag 'lsm-pr-20240911' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17e87f00580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=44d46e514184cd24
dashboard link: https://syzkaller.appspot.com/bug?extid=572f6e36bc6ee6f16762
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1481cca9980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14929607980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bdf130384fad/disk-a430d95c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c62ff195641a/vmlinux-a430d95c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4069702199e2/bzImage-a430d95c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+572f6e36bc6ee6f16762@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P1119/1:b..l
rcu: 	(detected by 0, t=10503 jiffies, g=23913, q=347 ncpus=2)
task:kworker/u8:6    state:R  running task     stack:24576 pid:1119  tgid:1119  ppid:2      flags:0x00004000
Workqueue: bat_events batadv_iv_send_outstanding_bat_ogm_packet
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0xe37/0x5490 kernel/sched/core.c:6529
 preempt_schedule_irq+0x51/0x90 kernel/sched/core.c:6851
 irqentry_exit+0x36/0x90 kernel/entry/common.c:354
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:lock_acquire+0x1f2/0x560 kernel/locking/lockdep.c:5727
Code: c1 05 ea b0 98 7e 83 f8 01 0f 85 ea 02 00 00 9c 58 f6 c4 02 0f 85 d5 02 00 00 48 85 ed 74 01 fb 48 b8 00 00 00 00 00 fc ff df <48> 01 c3 48 c7 03 00 00 00 00 48 c7 43 08 00 00 00 00 48 8b 84 24
RSP: 0018:ffffc900045b7a70 EFLAGS: 00000206
RAX: dffffc0000000000 RBX: 1ffff920008b6f50 RCX: 0000000000000001
RDX: 0000000000000001 RSI: ffffffff8b4cddc0 RDI: ffffffff8bb118a0
RBP: 0000000000000200 R08: 0000000000000000 R09: fffffbfff2d39ae0
R10: ffffffff969cd707 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: ffffffff8ddba6a0 R15: 0000000000000000
 rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 rcu_read_lock include/linux/rcupdate.h:838 [inline]
 batadv_iv_ogm_slide_own_bcast_window net/batman-adv/bat_iv_ogm.c:754 [inline]
 batadv_iv_ogm_schedule_buff+0x5ac/0x14d0 net/batman-adv/bat_iv_ogm.c:825
 batadv_iv_ogm_schedule net/batman-adv/bat_iv_ogm.c:868 [inline]
 batadv_iv_ogm_schedule net/batman-adv/bat_iv_ogm.c:861 [inline]
 batadv_iv_send_outstanding_bat_ogm_packet+0x31e/0x8d0 net/batman-adv/bat_iv_ogm.c:1712
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: rcu_preempt kthread starved for 10529 jiffies! g23913 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:27680 pid:17    tgid:17    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0xe37/0x5490 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6621
 schedule_timeout+0x136/0x2a0 kernel/time/timer.c:2581
 rcu_gp_fqs_loop+0x1eb/0xb00 kernel/rcu/tree.c:2034
 rcu_gp_kthread+0x271/0x380 kernel/rcu/tree.c:2236
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.11.0-syzkaller-02574-ga430d95c5efa #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:native_irq_disable arch/x86/include/asm/irqflags.h:37 [inline]
RIP: 0010:arch_local_irq_disable arch/x86/include/asm/irqflags.h:92 [inline]
RIP: 0010:acpi_safe_halt+0x1a/0x20 drivers/acpi/processor_idle.c:112
Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 65 48 8b 05 78 a2 eb 74 48 8b 00 a8 08 75 0c 66 90 0f 00 2d 68 56 a4 00 fb f4 <fa> c3 cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffffff8da07d70 EFLAGS: 00000246
RAX: 0000000000004000 RBX: 0000000000000001 RCX: ffffffff8b181979
RDX: 0000000000000001 RSI: ffff8880212b3000 RDI: ffff8880212b3064
RBP: ffff8880212b3064 R08: 0000000000000001 R09: ffffed1017106fd9
R10: ffff8880b8837ecb R11: 0000000000000000 R12: ffff8880212be800
R13: ffffffff8e9faa20 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b8800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff2dde0dd58 CR3: 000000002ad40000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 </IRQ>
 <TASK>
 acpi_idle_enter+0xc5/0x160 drivers/acpi/processor_idle.c:702
 cpuidle_enter_state+0xaa/0x4f0 drivers/cpuidle/cpuidle.c:264
 cpuidle_enter+0x4e/0xa0 drivers/cpuidle/cpuidle.c:385
 cpuidle_idle_call kernel/sched/idle.c:230 [inline]
 do_idle+0x313/0x3f0 kernel/sched/idle.c:326
 cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:424
 rest_init+0x16b/0x2b0 init/main.c:747
 start_kernel+0x3e4/0x4d0 init/main.c:1105
 x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:507
 x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:488
 common_startup_64+0x13e/0x148
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
