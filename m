Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34942D68BF2
	for <batman@archiver.kernel.org>; Sun, 17 Nov 2024 07:27:46 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0CF3A83F5E
	for <batman@archiver.kernel.org>; Sun, 17 Nov 2024 08:27:44 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1731828464;
 b=C200nFsur11hm7iTNZiXCSVcHNptWux4P+63qlGIkNdUrx0g2h8tTjr1leb9thN7nCXZq
 YO6I4LISEityNcrenLihJ+w+IDq4zf5+zBQ295hmCW3AkWmMvSkYaMKtZmH9khZ1uPtFHEl
 8GTeCmaIXtACIgrhn8UoNrgu3W1hNrs=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1731828464; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=7oyecJiOssSBBoJCd6XMmVEaJiQ/3EifAuLVF5bLMJ0=;
 b=rB1Y02f4PhfVM1u7kOee1VKm2wd4BnaLUNUjvWJ1bBpKf/PzMtU1fjNxKbXYSdmtx7Ytd
 N4WBiuN364T/RTg19obN1eosJrnUORm6ca1r9PLXGqwXOqJ9e3tA98fXrP3b7uuh8yRFnhF
 t1l6c0CHtdmmBurdyUXXIx4YjeCOMLU=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used Org Domain Record) header.from=syzkaller.appspotmail.com
 policy.dmarc=none
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id D5FB38151F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 16 Nov 2024 22:50:37 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1731793838; a=rsa-sha256;
	cv=none;
	b=04aahGI1+7Xd1vlu7OnzzhZ2/WV/XY3l5ginU7fN82rCt6bZXq73X+gZ9qslAYDh1j7qsU
	rgJcL8d92tdBZGd8aXqjnD8QfADska+kpA+XpwFlRT4ApR8wAXoz8hwhYuLqqZS0ACed12
	aq2rg9XJ3e0D/8taIvToelJJBpMiDCI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed),
 No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (diktynna.open-mesh.org: domain of
 3rBM5ZwkbAPcrxyjZkkdqZoohc.fnnfkdtrdqbnmsdms.bnl@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
 designates 209.85.166.71 as permitted sender)
 smtp.mailfrom=3rBM5ZwkbAPcrxyjZkkdqZoohc.fnnfkdtrdqbnmsdms.bnl@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1731793838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=7oyecJiOssSBBoJCd6XMmVEaJiQ/3EifAuLVF5bLMJ0=;
	b=KW1JXTb2+6ska0t9Ng08iPfaEwuJ5PmkhlCjKX0w4gHmElJ5pj8+CFNG24zndjpp/kuu22
	bA22aD3HxxOJVI4u55DtsA6WsiQgCP7WF5mksaAmz2VtVw0GSSoX9dK8rHUlC0oO7aOf88
	FI07fbUoy67fcRXntjfuTGbonPA7Wko=
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-83dff8bc954so300882639f.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Sat, 16 Nov 2024 13:50:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731793836; x=1732398636;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7oyecJiOssSBBoJCd6XMmVEaJiQ/3EifAuLVF5bLMJ0=;
        b=A32IVukyikR91y48JJlhmupQX2S09Ylthd5/vDiBAokC9Ow0JgPc0g8FY5oayD3YDD
         Vi+flKe6wirt0i7CmbTY8n69FaDKzibZhm/meeK/CTpBtbV+t7kA7tZlielZqBpsJ085
         O4F4FJ5SB0v6wWlh2EGQOcVQOoefpW7Zq0ESGZmy2mYwFfpeq6g9l+P5mwnPUpAd3AxL
         X5bvMBZAR1qcXnD9wRK//Kiyx+tDOZ2XhUvsKG5LdgfI6En7v2NbKkmse5VV32JGQKaY
         WNei88snpHxcNhD30oJzOff9c8JOHkhjr2kN9xdygv0KDYr1xfsN9kNR71QEfWcTaju5
         o6gQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJHtn+FgU66AF7NMxtXQFQJH1cn48Bf5C3Ws6WKQeNYj20d7tKe+qhiTnjxZ9K+q0opq2GUIuKPYcY3Q==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YykJFVpzMR2SPeX/FaAFpURpppCCu7GgV1/+R8L6z+uk9sEVjQQ
	8nSRfTj6azIOxAZhz2/YOzyX73/+WA+cJL9dI9pFO/gOmoxp+J6O5KOTl7klVaMoGJH+oatNOp1
	WvWEKGIfXUk/EHYE2l0dw/kyDLSg19M+FRbjqiFWm54GfZ0wO7GNVRzQ=
X-Google-Smtp-Source: 
 AGHT+IF63qTw7T41RbSxEllmUqC4E8PBmnfqn59Fa9fS2jiNBuT07LhdDzStTn1uPGlgJnUVxNUhmq4tGhsOFw8y2WQ2MwCxwzmJ
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8d:b0:3a7:43db:2b63 with SMTP id
 e9e14a558f8ab-3a747ff8a45mr62192675ab.4.1731793836555; Sat, 16 Nov 2024
 13:50:36 -0800 (PST)
Date: Sat, 16 Nov 2024 13:50:36 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673913ac.050a0220.e8d8d.016b.GAE@google.com>
Subject: [syzbot] [batman?] [mm?] [ext4?] INFO: rcu detected stall in
 rescuer_thread
From: syzbot <syzbot+76e180c757e9d589a79d@syzkaller.appspotmail.com>
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net,
	edumazet@google.com, horms@kernel.org, kuba@kernel.org,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	mareklindner@neomailbox.ch, netdev@vger.kernel.org, pabeni@redhat.com,
	sven@narfation.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-MailFrom: 
 3rBM5ZwkbAPcrxyjZkkdqZoohc.fnnfkdtrdqbnmsdms.bnl@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: WCE6KIMRBNL7A5LGF4S6OTMIWRU4QZBD
X-Message-ID-Hash: WCE6KIMRBNL7A5LGF4S6OTMIWRU4QZBD
X-Mailman-Approved-At: Sun, 17 Nov 2024 08:27:33 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/WCE6KIMRBNL7A5LGF4S6OTMIWRU4QZBD/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hello,

syzbot found the following issue on:

HEAD commit:    cfaaa7d010d1 Merge tag 'net-6.12-rc8' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=175523f7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2aeec8c0b2e420c
dashboard link: https://syzkaller.appspot.com/bug?extid=76e180c757e9d589a79d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14486b5f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=112182e8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5ab991f9cba7/disk-cfaaa7d0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b840e35f87ab/vmlinux-cfaaa7d0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0b16dd5db314/bzImage-cfaaa7d0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+76e180c757e9d589a79d@syzkaller.appspotmail.com

yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	(detected by 1, t=10502 jiffies, g=7965, q=779 ncpus=2)
rcu: All QSes seen, last rcu_preempt kthread activity 9833 (4294968589-4294958756), jiffies_till_next_fqs=1, root ->qsmask 0x0
rcu: rcu_preempt kthread starved for 9833 jiffies! g7965 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R
  running task    
 stack:25784 pid:17    tgid:17    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5328 [inline]
 __schedule+0x184f/0x4c30 kernel/sched/core.c:6693
 __schedule_loop kernel/sched/core.c:6770 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6785
 schedule_timeout+0x1be/0x310 kernel/time/timer.c:2615
 rcu_gp_fqs_loop+0x2df/0x1330 kernel/rcu/tree.c:2045
 rcu_gp_kthread+0xa7/0x3b0 kernel/rcu/tree.c:2247
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
Sending NMI from CPU 1 to CPUs 0:
yealink 5-1:36.0: urb_irq_callback - urb status -71
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 3389 Comm: kworker/R-bat_e Not tainted 6.12.0-rc7-syzkaller-00125-gcfaaa7d010d1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Workqueue: bat_events batadv_iv_send_outstanding_bat_ogm_packet
RIP: 0010:io_serial_in+0x76/0xb0 drivers/tty/serial/8250/8250_port.c:406
Code: 80 a1 49 fc 89 e9 41 d3 e6 48 83 c3 40 48 89 d8 48 c1 e8 03 42 80 3c 38 00 74 08 48 89 df e8 c1 7d b3 fc 44 03 33 44 89 f2 ec <0f> b6 c0 5b 41 5e 41 5f 5d c3 cc cc cc cc 89 e9 80 e1 07 38 c1 7c
RSP: 0018:ffffc90000006f58 EFLAGS: 00000006
RAX: 1ffffffff34e3905 RBX: ffffffff9a71cee0 RCX: 0000000000000000
RDX: 00000000000003f9 RSI: 0000000000000000 RDI: 0000000000000020
RBP: 0000000000000000 R08: ffffffff854b4886 R09: fffff52000000dcc
R10: dffffc0000000000 R11: ffffffff854b4840 R12: dffffc0000000000
R13: 1ffff92000000e08 R14: 00000000000003f9 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8f12451198 CR3: 000000007a13a000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 serial_port_in include/linux/serial_core.h:787 [inline]
 serial8250_console_write+0x4de/0x1ed0 drivers/tty/serial/8250/8250_port.c:3357
 console_emit_next_record kernel/printk/printk.c:3092 [inline]
 console_flush_all+0x869/0xeb0 kernel/printk/printk.c:3180
 __console_flush_and_unlock kernel/printk/printk.c:3239 [inline]
 console_unlock+0x14f/0x3b0 kernel/printk/printk.c:3279
 vprintk_emit+0x730/0xa10 kernel/printk/printk.c:2407
 dev_vprintk_emit+0x2ae/0x330 drivers/base/core.c:4942
 dev_printk_emit+0xdd/0x120 drivers/base/core.c:4953
 _dev_err+0x122/0x170 drivers/base/core.c:5008
 urb_irq_callback+0x37e/0x5b0 drivers/input/misc/yealink.c:418
 __usb_hcd_giveback_urb+0x42c/0x6e0 drivers/usb/core/hcd.c:1650
 dummy_timer+0x856/0x4620 drivers/usb/gadget/udc/dummy_hcd.c:1993
 __run_hrtimer kernel/time/hrtimer.c:1691 [inline]
 __hrtimer_run_queues+0x59b/0xd50 kernel/time/hrtimer.c:1755
 hrtimer_run_softirq+0x19a/0x2c0 kernel/time/hrtimer.c:1772
 handle_softirqs+0x2c5/0x980 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:lock_acquire+0x264/0x550 kernel/locking/lockdep.c:5829
Code: 2b 00 74 08 4c 89 f7 e8 ea 6c 8e 00 f6 44 24 61 02 0f 85 85 01 00 00 41 f7 c7 00 02 00 00 74 01 fb 48 c7 44 24 40 0e 36 e0 45 <4b> c7 44 25 00 00 00 00 00 43 c7 44 25 09 00 00 00 00 43 c7 44 25
RSP: 0018:ffffc9000c1bf7e0 EFLAGS: 00000206
RAX: 0000000000000001 RBX: 1ffff92001837f08 RCX: 0126c5196ddeef00
RDX: dffffc0000000000 RSI: ffffffff8c0adc40 RDI: ffffffff8c610ce0
RBP: ffffc9000c1bf928 R08: ffffffff942d0807 R09: 1ffffffff285a100
R10: dffffc0000000000 R11: fffffbfff285a101 R12: 1ffff92001837f04
R13: dffffc0000000000 R14: ffffc9000c1bf840 R15: 0000000000000246
 rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 rcu_read_lock include/linux/rcupdate.h:849 [inline]
 batadv_iv_ogm_slide_own_bcast_window net/batman-adv/bat_iv_ogm.c:754 [inline]
 batadv_iv_ogm_schedule_buff net/batman-adv/bat_iv_ogm.c:825 [inline]
 batadv_iv_ogm_schedule+0x43f/0x10a0 net/batman-adv/bat_iv_ogm.c:868
 batadv_iv_send_outstanding_bat_ogm_packet+0x6fe/0x810 net/batman-adv/bat_iv_ogm.c:1712
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 rescuer_thread+0x63f/0x10a0 kernel/workqueue.c:3487
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 1-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 1-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 1-1:36.0: unexpected respo

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
