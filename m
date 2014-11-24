Return-Path: <martin@hundeboll.net>
Message-ID: <5472EB56.8000700@hundeboll.net>
Date: Mon, 24 Nov 2014 09:24:54 +0100
From: =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>
MIME-Version: 1.0
References: <1416347918.9920.10.camel@gmail.com>
 <546DA710.2040802@hundeboll.net> <1416476912.2747.5.camel@gmail.com>
 <546DC214.6050908@hundeboll.net> <1416486149.2747.9.camel@gmail.com>
 <546DE067.8070807@hundeboll.net> <1416688754.2696.3.camel@gmail.com>
In-Reply-To: <1416688754.2696.3.camel@gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] kernel BUG at net/core/skbuff.c:100
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi Philiipp,

On 2014-11-22 21:39, Philipp Psurek wrote:
> This bug has not been recorded with your patch. There are no info in
> kernel ring buffer about it. I'd like to run the VM with nc disabled for
> a week and see if the bug happens again. I'm open for further patching
> and testing resolving this bug and glad to help. I can not give you the
> vmcore dump but you can tell me some commands for crash or we can meet
> in the IRC next week if you like to crawl live inside.

Can you help me do a quick sum-up?

1) At first it crashed with regular intervals (0 - 72 hours) with the 
backtrace you posted initially.
2) Then you disabled NC. Did it stop crashing at that point?
3) Then we enabled NC and added my patch, and it still does not crash?

I remeber you said it crashed with the distro-provided batman-adv 
module. Did you ensure to use the same version when running with my patch?

I haven't had time to dig into the reproduction of the crash, but I 
think I will do regardless.

Thanks,
Martin

>
> ________________________
> Freifunk Rheinland e. V.
> – Funkzelle Wuppertal –
>
>
>
>
>
>    SYSTEM MAP: /boot/System.map
> DEBUG KERNEL: /usr/src/linux-3.16.7-gentoo/vmlinux (3.16.7-gentoo)
>      DUMPFILE: vmcore_20141122201714
>          CPUS: 1
>          DATE: Sat Nov 22 17:52:11 2014
>        UPTIME: 1 days, 08:38:59
> LOAD AVERAGE: 0.23, 0.18, 0.15
>         TASKS: 125
>      NODENAME: wolke
>       RELEASE: 3.16.7-gentoo
>       VERSION: #1 SMP Mon Nov 17 03:44:22 CET 2014
>       MACHINE: x86_64  (2593 Mhz)
>        MEMORY: 511.6 MB
>         PANIC: "kernel BUG at net/core/skbuff.c:100!"
>           PID: 2041
>       COMMAND: "fastd"
>          TASK: ffff88001a3a7290  [THREAD_INFO: ffff8800192b0000]
>           CPU: 0
>         STATE: TASK_RUNNING (PANIC)
>
>
> crash> bt
> PID: 2041   TASK: ffff88001a3a7290  CPU: 0   COMMAND: "fastd"
>   #0 [ffff88001fc03980] machine_kexec at ffffffff8103a34e
>   #1 [ffff88001fc039e0] crash_kexec at ffffffff810be503
>   #2 [ffff88001fc03ab0] oops_end at ffffffff81005fc8
>   #3 [ffff88001fc03ae0] die at ffffffff81006463
>   #4 [ffff88001fc03b10] do_trap at ffffffff81002e12
>   #5 [ffff88001fc03b70] do_error_trap at ffffffff8100316d
>   #6 [ffff88001fc03c30] do_invalid_op at ffffffff8100394b
>   #7 [ffff88001fc03c40] invalid_op at ffffffff817f385e
>      [exception RIP: skb_panic+94]
>      RIP: ffffffff817eb99d  RSP: ffff88001fc03cf8  RFLAGS: 00010296
>      RAX: 000000000000008b  RBX: ffff8800191f8980  RCX: 0000000000000092
>      RDX: 000000000000002c  RSI: 0000000000000046  RDI: 0000000000000246
>      RBP: ffff88001fc03d18   R8: 0000000000000000   R9: 0000000000000000
>      R10: 00000000000001a8  R11: 0000000000000006  R12: 0000000000000564
>      R13: ffff88001fc03da0  R14: ffff880019cb0800  R15: ffff880019001862
>      ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>   #8 [ffff88001fc03d20] skb_put at ffffffff81611bb1
>   #9 [ffff88001fc03d30] batadv_frag_skb_buffer at ffffffffa001be12 [batman_adv]
> #10 [ffff88001fc03d90] batadv_recv_frag_packet at ffffffffa0026273 [batman_adv]
> #11 [ffff88001fc03dd0] batadv_batman_skb_recv at ffffffffa001fef5 [batman_adv]
> #12 [ffff88001fc03e10] __netif_receive_skb_core at ffffffff81621962
> #13 [ffff88001fc03e80] __netif_receive_skb at ffffffff81621e91
> #14 [ffff88001fc03ea0] process_backlog at ffffffff81621f7e
> #15 [ffff88001fc03ef0] net_rx_action at ffffffff81622731
> #16 [ffff88001fc03f50] __do_softirq at ffffffff81053ef8
> #17 [ffff88001fc03fb0] do_softirq_own_stack at ffffffff817f3a5c
> --- <IRQ stack> ---
> #18 [ffff8800192b3d10] do_softirq_own_stack at ffffffff817f3a5c
>      [exception RIP: tun_get_user+1056]
>      RIP: ffffffffa00098f0  RSP: 0000000000000001  RFLAGS: 7fff00000586
>      RAX: ffffffff816210b4  RBX: ffff8800192b3d58  RCX: ffff880019358780
>      RDX: 0000000000000000  RSI: ffff880019358780  RDI: 0000000000000586
>      RBP: ffffffff81620de4   R8: ffff8800192b3d88   R9: ffff880019358780
>      R10: ffff880019358780  R11: ffffffff81054135  R12: ffff8800192b3d58
>      R13: 0000000000000586  R14: ffff880013816900  R15: 0000000000000000
>      ORIG_RAX: ffff8800192b3e38  CS: 7fffd0cc11e0  SS: 0000
> bt: WARNING: possibly bogus exception frame
> #19 [ffff8800192b3e40] tun_chr_aio_write at ffffffffa0009e0b [tun]
> #20 [ffff8800192b3e70] do_sync_write at ffffffff8115c665
> #21 [ffff8800192b3f00] vfs_write at ffffffff8115d38a
> #22 [ffff8800192b3f40] sys_write at ffffffff8115d89a
> #23 [ffff8800192b3f80] system_call_fastpath at ffffffff817f1f29
>      RIP: 00007f773e3f637d  RSP: 00007fffd0cc0f78  RFLAGS: 00010246
>      RAX: 0000000000000001  RBX: ffffffff817f1f29  RCX: fffffffffffffffe
>      RDX: 0000000000000586  RSI: 00000000008b5370  RDI: 0000000000000009
>      RBP: 0000000000000586   R8: 00007f773e3df400   R9: 00007fffd0cc0928
>      R10: 00007fffd0cc106f  R11: 0000000000000293  R12: 00000000008b4d78
>      R13: 0000000000000001  R14: 00000000008b5360  R15: 00000000008a66a0
>      ORIG_RAX: 0000000000000001  CS: 0033  SS: 002b
>
>
>
>
> crash> log
> [          … ]
> [   82.041157] random: nonblocking pool is initialized
> [  879.805754] tun: Universal TUN/TAP device driver, 1.6
> [  879.805758] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
> [  881.827196] batman_adv: B.A.T.M.A.N. advanced 2014.3.0 (compatibility version 15) loaded
> [  882.061188] batman_adv: bat0: Adding interface: fastd0
> [  882.061193] batman_adv: bat0: The MTU of interface fastd0 is too small (1426) to handle the transport of batman-adv packets. Packets going over this interface will be fragmented on layer2 which could impact the performance. Setting the MTU to 1560 would solve the problem.
> [  882.061197] batman_adv: bat0: Interface activated: fastd0
> [  882.062273] batman_adv: bat0: orig_interval: Changing from: 1000 to: 5000
> [  882.063700] batman_adv: bat0: bridge_loop_avoidance: Changing from: disabled to: enabled
> [  882.064445] batman_adv: bat0: Changing gw mode from: off to: client
> [  901.324201] ipip: IPv4 over IPv4 tunneling driver
> [  981.754520] batman_adv: bat0: Changing gw mode from: client to: server
> [  981.754539] batman_adv: bat0: Changing gateway bandwidth from: '10.0/2.0 MBit' to: '100.0/100.0 MBit'
> [ 4489.358966] nf_conntrack: automatic helper assignment is deprecated and it will be removed soon. Use the iptables CT target to attach helpers instead.
> [65478.516847] rsync (19667) used greatest stack depth: 11608 bytes left
> [106847.227697] UDP: bad checksum. From <some_IP_in_the_net>:X to <some_ISP_IP_for_this_machine>:X ulen 21
> [117539.423168] skbuff: skb_over_panic: text:ffffffffa001be12 len:1445 put:1380 head:ffff88000fc85800 data:ffff88000fc85862 tail:0x607 end:0x2c0 dev:fastd0
> [117539.423502] ------------[ cut here ]------------
> [117539.423601] kernel BUG at net/core/skbuff.c:100!
> [117539.423695] invalid opcode: 0000 [#1] SMP
> [117539.423796] Modules linked in: xt_nat iptable_nat nf_nat_ipv4 nf_nat ipip batman_adv libcrc32c tun crc32c_intel
> [117539.424076] CPU: 0 PID: 2041 Comm: fastd Not tainted 3.16.7-gentoo #1
> [117539.424107] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2007
> [117539.424107] task: ffff88001a3a7290 ti: ffff8800192b0000 task.ti: ffff8800192b0000
> [117539.424107] RIP: 0010:[<ffffffff817eb99d>]  [<ffffffff817eb99d>] skb_panic+0x5e/0x60
> [117539.424107] RSP: 0018:ffff88001fc03cf8  EFLAGS: 00010296
> [117539.424107] RAX: 000000000000008b RBX: ffff8800191f8980 RCX: 0000000000000092
> [117539.424107] RDX: 000000000000002c RSI: 0000000000000046 RDI: 0000000000000246
> [117539.424107] RBP: ffff88001fc03d18 R08: 0000000000000000 R09: 0000000000000000
> [117539.424107] R10: 00000000000001a8 R11: 0000000000000006 R12: 0000000000000564
> [117539.424107] R13: ffff88001fc03da0 R14: ffff880019cb0800 R15: ffff880019001862
> [117539.424107] FS:  00007f773f0a2700(0000) GS:ffff88001fc00000(0000) knlGS:0000000000000000
> [117539.424107] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [117539.424107] CR2: 00007f8cc7ada430 CR3: 000000001921c000 CR4: 00000000000006f0
> [117539.424107] Stack:
> [117539.424107]  ffff88000fc85862 0000000000000607 00000000000002c0 ffff880019358000
> [117539.424107]  ffff88001fc03d28 ffffffff81611bb1 ffff88001fc03d88 ffffffffa001be12
> [117539.424107]  ffff880019c07d28 ffff88001900184e ffff88001fc03d78 ffff8800191f8980
> [117539.424107] Call Trace:
> [117539.424107]  <IRQ>
> [117539.424107]
> [117539.424107]  [<ffffffff81611bb1>] skb_put+0x41/0x50
> [117539.424107]  [<ffffffffa001be12>] batadv_frag_skb_buffer+0x272/0x470 [batman_adv]
> [117539.424107]  [<ffffffffa0026273>] batadv_recv_frag_packet+0x183/0x200 [batman_adv]
> [117539.424107]  [<ffffffffa001fef5>] batadv_batman_skb_recv+0xd5/0x110 [batman_adv]
> [117539.424107]  [<ffffffff81621962>] __netif_receive_skb_core+0x222/0x730
> [117539.424107]  [<ffffffff81621e91>] __netif_receive_skb+0x21/0x70
> [117539.424107]  [<ffffffff81621f7e>] process_backlog+0x9e/0x170
> [117539.424107]  [<ffffffff81622731>] net_rx_action+0x141/0x240
> [117539.424107]  [<ffffffff81053ef8>] __do_softirq+0xe8/0x280
> [117539.424107]  [<ffffffff817f3a5c>] do_softirq_own_stack+0x1c/0x30
> [117539.424107]  <EOI>
> [117539.424107]
> [117539.424107]  [<ffffffff81054135>] do_softirq+0x55/0x60
> [117539.424107]  [<ffffffff816210b4>] netif_rx_ni+0x34/0x70
> [117539.424107]  [<ffffffffa00098f0>] tun_get_user+0x420/0x840 [tun]
> [117539.424107]  [<ffffffffa0009e0b>] tun_chr_aio_write+0x7b/0xa0 [tun]
> [117539.424107]  [<ffffffff8115c665>] do_sync_write+0x55/0x90
> [117539.424107]  [<ffffffff8115d38a>] vfs_write+0xba/0x1f0
> [117539.424107]  [<ffffffff8115d89a>] SyS_write+0x4a/0xa0
> [117539.424107]  [<ffffffff817f1f29>] system_call_fastpath+0x16/0x1b
> [117539.424107] Code: 00 00 48 89 44 24 10 8b 87 c0 00 00 00 48 89 44 24 08 48 8b 87 d0 00 00 00 48 c7 c7 30 67 a3 81 48 89 04 24 31 c0 e8 0d 8b ff ff <0f> 0b 55 48 89 f8 48 8b 57 30 48 89 e5 48 8b 0f 5d 80 e5 80 48
> [117539.424107] RIP  [<ffffffff817eb99d>] skb_panic+0x5e/0x60
> [117539.424107]  RSP <ffff88001fc03cf8>
>

-- 
Kind Regards,
Martin Hundebøll
Frederiks Allé 99A, 1.th
8000 Aarhus C

+45 61 65 54 61
martin@hundeboll.net
