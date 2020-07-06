Return-Path: 
  <3C8ACXwkbAJQGMN8y992FyDD61.4CC492IG2F0CBH2BH.0CA@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>
MIME-Version: 1.0
Date: Sun, 05 Jul 2020 23:09:15 -0700
In-Reply-To: <0000000000000a8e8605a22a1ae0@google.com>
Message-ID: <000000000000e5b5bb05a9bfb63c@google.com>
Subject: Re: INFO: rcu detected stall in netlink_sendmsg (4)
From: syzbot <syzbot+0fb70e87d8e0ac278fe9@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch, netdev@vger.kernel.org, sven@narfation.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com, tglx@linutronix.de

syzbot has found a reproducer for the following crash on:

HEAD commit:    9e50b94b Add linux-next specific files for 20200703
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13e6ec33100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f99cc0faa1476ed6
dashboard link: https://syzkaller.appspot.com/bug?extid=0fb70e87d8e0ac278fe9
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=168ab5d5100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1771c5d5100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0fb70e87d8e0ac278fe9@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	0-...0: (3 ticks this GP) idle=ff2/1/0x4000000000000000 softirq=8592/8593 fqs=5250 
	(detected by 1, t=10502 jiffies, g=8273, q=66)
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 6802 Comm: syz-executor688 Not tainted 5.8.0-rc3-next-20200703-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__preempt_count_dec_and_test arch/x86/include/asm/preempt.h:94 [inline]
RIP: 0010:rcu_lockdep_current_cpu_online kernel/rcu/tree.c:1144 [inline]
RIP: 0010:rcu_lockdep_current_cpu_online+0xc8/0x110 kernel/rcu/tree.c:1131
Code: 59 48 8d 7d 70 48 8b 5b 20 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 41 48 8b 45 70 48 85 c3 0f 95 c0 <65> ff 0d d1 18 a1 7e 74 07 48 83 c4 08 5b 5d c3 e8 52 93 9f ff eb
RSP: 0018:ffffc90000007db8 EFLAGS: 00000002
RAX: 0000000000000001 RBX: 0000000000000001 RCX: 1ffffffff1303b28
RDX: 1ffffffff1378c1e RSI: 0000000000010204 RDI: ffffffff89bc60f0
RBP: ffffffff89bc6080 R08: 0000000000000000 R09: ffffffff8aaf028f
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
R13: ffff8880ae627840 R14: ffff888094512340 R15: dffffc0000000000
FS:  00000000017fe880(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000610 CR3: 000000009aba2000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 rcu_read_lock_held_common kernel/rcu/update.c:110 [inline]
 rcu_read_lock_held_common kernel/rcu/update.c:100 [inline]
 rcu_read_lock_sched_held+0x25/0xb0 kernel/rcu/update.c:121
 trace_hrtimer_expire_exit include/trace/events/timer.h:279 [inline]
 __run_hrtimer kernel/time/hrtimer.c:1523 [inline]
 __hrtimer_run_queues+0xd13/0xfc0 kernel/time/hrtimer.c:1584
 hrtimer_interrupt+0x32a/0x930 kernel/time/hrtimer.c:1646
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1080 [inline]
 __sysvec_apic_timer_interrupt+0x142/0x5e0 arch/x86/kernel/apic/apic.c:1097
 asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:706
 </IRQ>
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:22 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:48 [inline]
 sysvec_apic_timer_interrupt+0xe0/0x120 arch/x86/kernel/apic/apic.c:1091
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:596
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:765 [inline]
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x8c/0xe0 kernel/locking/spinlock.c:191
Code: 48 c7 c0 00 ff b4 89 48 ba 00 00 00 00 00 fc ff df 48 c1 e8 03 80 3c 10 00 75 37 48 83 3d 9b 74 c8 01 00 74 22 48 89 df 57 9d <0f> 1f 44 00 00 bf 01 00 00 00 e8 95 fb 62 f9 65 8b 05 fe 73 15 78
RSP: 0018:ffffc900010872c0 EFLAGS: 00000282
RAX: 1ffffffff1369fe0 RBX: 0000000000000282 RCX: 0000000000000002
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000282
RBP: ffff8880945122e8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000282
R13: 161f14abb88be58f R14: ffff888094512000 R15: 0000000000000000
 spin_unlock_irqrestore include/linux/spinlock.h:409 [inline]
 taprio_change+0x1fdc/0x2960 net/sched/sch_taprio.c:1556
 taprio_init+0x52e/0x670 net/sched/sch_taprio.c:1669
 qdisc_create+0x4b6/0x12e0 net/sched/sch_api.c:1245
 tc_modify_qdisc+0x4c8/0x1990 net/sched/sch_api.c:1661
 rtnetlink_rcv_msg+0x44e/0xad0 net/core/rtnetlink.c:5460
 netlink_rcv_skb+0x15a/0x430 net/netlink/af_netlink.c:2469
 netlink_unicast_kernel net/netlink/af_netlink.c:1303 [inline]
 netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1329
 netlink_sendmsg+0x856/0xd90 net/netlink/af_netlink.c:1918
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:672
 ____sys_sendmsg+0x6e8/0x810 net/socket.c:2352
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2406
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2439
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:367
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x443799
Code: Bad RIP value.
RSP: 002b:00007ffceabd28c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000443799
RDX: 0000000000000000 RSI: 00000000200007c0 RDI: 0000000000000004
RBP: 00007ffceabd28d0 R08: 0000000001bbbbbb R09: 0000000001bbbbbb
R10: 0000000001bbbbbb R11: 0000000000000246 R12: 00007ffceabd28e0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 0.000 msecs

