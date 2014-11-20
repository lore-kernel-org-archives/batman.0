Return-Path: <martin@hundeboll.net>
Message-ID: <546DA710.2040802@hundeboll.net>
Date: Thu, 20 Nov 2014 09:32:16 +0100
From: =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>
MIME-Version: 1.0
References: <1416347918.9920.10.camel@gmail.com>
In-Reply-To: <1416347918.9920.10.camel@gmail.com>
Content-Type: multipart/mixed; boundary="------------010000090806080801080508"
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

This is a multi-part message in MIME format.
--------------010000090806080801080508
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Hi Philipp,

On 2014-11-18 22:58, Philipp Psurek wrote:
> Hi all,
>
> I hope, You can help me debug this issue. I’m running
> batman-adv 2014.3.0 included in 3.16.7 linux. Something provokes kernel
> panic on the VM. It might be a modified or regular packet. The crash
> occurs at “prime time” but the machine is not under heavy load.
>
> I hope you can localize the error. I provide you with some crash dumps
> from a vmcore dump. Please tell me if you need more or there is
> something I should do to provide you with more information about this
> issue.

Thanks for you report. The bug is probably triggered by some bogus data 
in an incoming packet. I have created a small debug patch that will 
detect if this is the case, and print some debug info if so.

Is it possible for you to checkout the source, add the patch, and 
compile the module?

Thanks,
Martin

>
> Thank you all for B.A.T.M.A.N.-adv!
>
> Best regards
>
> Philipp
>
>
>
> crash 7.0.7
>        KERNEL: /usr/src/linux-3.16.7-gentoo/vmlinux
>      DUMPFILE: vmcore_20141118174414
>          CPUS: 1
>          DATE: Tue Nov 18 16:17:01 2014
>        UPTIME: 16:30:32
> LOAD AVERAGE: 0.19, 0.22, 0.25
>         TASKS: 124
>      NODENAME: wolke
>       RELEASE: 3.16.7-gentoo
>       VERSION: #1 SMP Mon Nov 17 03:44:22 CET 2014
>       MACHINE: x86_64  (2593 Mhz)
>        MEMORY: 511.6 MB
>         PANIC: "kernel BUG at net/core/skbuff.c:100!"
>           PID: 2012
>       COMMAND: "fastd"
>          TASK: ffff880019c411a0  [THREAD_INFO: ffff880019200000]
>           CPU: 0
>         STATE: TASK_RUNNING (PANIC)
>
>
> crash> bt
> PID: 2012   TASK: ffff880019c411a0  CPU: 0   COMMAND: "fastd"
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
>      RAX: 000000000000008b  RBX: ffff8800100ccee0  RCX: 0000000000000092
>      RDX: 0000000000000062  RSI: 0000000000000046  RDI: 0000000000000246
>      RBP: ffff88001fc03d18   R8: 0000000000000000   R9: 0000000000000000
>      R10: 00000000000001ed  R11: 0000000000000006  R12: 0000000000000564
>      R13: ffff88001fc03da0  R14: ffff880013fd9100  R15: ffff880005948062
>      ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>   #8 [ffff88001fc03d20] skb_put at ffffffff81611bb1
>   #9 [ffff88001fc03d30] batadv_frag_skb_buffer at ffffffffa002fdfa [batman_adv]
> #10 [ffff88001fc03d90] batadv_recv_frag_packet at ffffffffa003a213 [batman_adv]
> #11 [ffff88001fc03dd0] batadv_batman_skb_recv at ffffffffa0033e95 [batman_adv]
> #12 [ffff88001fc03e10] __netif_receive_skb_core at ffffffff81621962
> #13 [ffff88001fc03e80] __netif_receive_skb at ffffffff81621e91
> #14 [ffff88001fc03ea0] process_backlog at ffffffff81621f7e
> #15 [ffff88001fc03ef0] net_rx_action at ffffffff81622731
> #16 [ffff88001fc03f50] __do_softirq at ffffffff81053ef8
> #17 [ffff88001fc03fb0] do_softirq_own_stack at ffffffff817f3a5c
> --- <IRQ stack> ---
> #18 [ffff880019203d10] do_softirq_own_stack at ffffffff817f3a5c
>      [exception RIP: tun_get_user+1056]
>      RIP: ffffffffa001d8f0  RSP: 0000000000000001  RFLAGS: 7fff00000586
>      RAX: ffffffff816210b4  RBX: ffff880019203d58  RCX: ffff8800193dc780
>      RDX: 0000000000000000  RSI: ffff8800193dc780  RDI: 0000000000000586
>      RBP: ffffffff81620de4   R8: ffff880019203d88   R9: ffff8800193dc780
>      R10: ffff8800193dc780  R11: ffffffff81054135  R12: ffff880019203d58
>      R13: 0000000000000586  R14: ffff88001932b900  R15: 0000000000000000
>      ORIG_RAX: ffff880019203e38  CS: 7fff018d3a90  SS: 0000
> bt: WARNING: possibly bogus exception frame
> #19 [ffff880019203e40] tun_chr_aio_write at ffffffffa001de0b [tun]
> #20 [ffff880019203e70] do_sync_write at ffffffff8115c665
> #21 [ffff880019203f00] vfs_write at ffffffff8115d38a
> #22 [ffff880019203f40] sys_write at ffffffff8115d89a
> #23 [ffff880019203f80] system_call_fastpath at ffffffff817f1f29
>      RIP: 00007fef80cbe37d  RSP: 00007fff018d3bd0  RFLAGS: 00000206
>      RAX: 0000000000000001  RBX: ffffffff817f1f29  RCX: 00000000000000b4
>      RDX: 0000000000000586  RSI: 00000000016e9ba0  RDI: 0000000000000009
>      RBP: 0000000000000586   R8: 00007fef80ca7400   R9: 00007fff018d31d8
>      R10: 00007fff018d391f  R11: 0000000000000293  R12: 00000000016e9358
>      R13: 0000000000000001  R14: 00000000016e9b90  R15: 00000000016e13a0
>      ORIG_RAX: 0000000000000001  CS: 0033  SS: 002b
>
>
> crash> log
> […]
> [59432.101578] skbuff: skb_over_panic: text:ffffffffa002fdfa len:1464 put:1380 head:ffff88000596f800 data:ffff88000596f862 tail:0x61a end:0x2c0 dev:fastd0
> [59432.101901] ------------[ cut here ]------------
> [59432.102014] kernel BUG at net/core/skbuff.c:100!
> [59432.102125] invalid opcode: 0000 [#1] SMP
> [59432.102225] Modules linked in: xt_nat batman_adv libcrc32c tun iptable_nat nf_nat_ipv4 nf_nat ipip crc32c_intel
> [59432.102490] CPU: 0 PID: 2012 Comm: fastd Not tainted 3.16.7-gentoo #1
> [59432.102519] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2007
> [59432.102519] task: ffff880019c411a0 ti: ffff880019200000 task.ti: ffff880019200000
> [59432.102519] RIP: 0010:[<ffffffff817eb99d>]  [<ffffffff817eb99d>] skb_panic+0x5e/0x60
> [59432.102519] RSP: 0018:ffff88001fc03cf8  EFLAGS: 00010296
> [59432.102519] RAX: 000000000000008b RBX: ffff8800100ccee0 RCX: 0000000000000092
> [59432.102519] RDX: 0000000000000062 RSI: 0000000000000046 RDI: 0000000000000246
> [59432.102519] RBP: ffff88001fc03d18 R08: 0000000000000000 R09: 0000000000000000
> [59432.102519] R10: 00000000000001ed R11: 0000000000000006 R12: 0000000000000564
> [59432.102519] R13: ffff88001fc03da0 R14: ffff880013fd9100 R15: ffff880005948062
> [59432.102519] FS:  00007fef8196a700(0000) GS:ffff88001fc00000(0000) knlGS:0000000000000000
> [59432.102519] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [59432.102519] CR2: 00007f5c610ac000 CR3: 0000000019352000 CR4: 00000000000006f0
> [59432.102519] Stack:
> [59432.102519]  ffff88000596f862 000000000000061a 00000000000002c0 ffff8800193dc000
> [59432.102519]  ffff88001fc03d28 ffffffff81611bb1 ffff88001fc03d88 ffffffffa002fdfa
> [59432.102519]  ffff8800193aa168 ffff88000594804e ffff88001fc03d78 ffff8800100ccee0
> [59432.102519] Call Trace:
> [59432.102519]  <IRQ>
> [59432.102519]
> [59432.102519]  [<ffffffff81611bb1>] skb_put+0x41/0x50
> [59432.102519]  [<ffffffffa002fdfa>] batadv_frag_skb_buffer+0x25a/0x410 [batman_adv]
> [59432.102519]  [<ffffffffa003a213>] batadv_recv_frag_packet+0x183/0x200 [batman_adv]
> [59432.102519]  [<ffffffffa0033e95>] batadv_batman_skb_recv+0xd5/0x110 [batman_adv]
> [59432.102519]  [<ffffffff81621962>] __netif_receive_skb_core+0x222/0x730
> [59432.102519]  [<ffffffff81621e91>] __netif_receive_skb+0x21/0x70
> [59432.102519]  [<ffffffff81621f7e>] process_backlog+0x9e/0x170
> [59432.102519]  [<ffffffff81622731>] net_rx_action+0x141/0x240
> [59432.102519]  [<ffffffff81053ef8>] __do_softirq+0xe8/0x280
> [59432.102519]  [<ffffffff817f3a5c>] do_softirq_own_stack+0x1c/0x30
> [59432.102519]  <EOI>
> [59432.102519]
> [59432.102519]  [<ffffffff81054135>] do_softirq+0x55/0x60
> [59432.102519]  [<ffffffff816210b4>] netif_rx_ni+0x34/0x70
> [59432.102519]  [<ffffffffa001d8f0>] tun_get_user+0x420/0x840 [tun]
> [59432.102519]  [<ffffffffa001de0b>] tun_chr_aio_write+0x7b/0xa0 [tun]
> [59432.102519]  [<ffffffff8115c665>] do_sync_write+0x55/0x90
> [59432.102519]  [<ffffffff8115d38a>] vfs_write+0xba/0x1f0
> [59432.102519]  [<ffffffff8115d89a>] SyS_write+0x4a/0xa0
> [59432.102519]  [<ffffffff817f1f29>] system_call_fastpath+0x16/0x1b
> [59432.102519] Code: 00 00 48 89 44 24 10 8b 87 c0 00 00 00 48 89 44 24 08 48 8b 87 d0 00 00 00 48 c7 c7 30 67 a3 81 48 89 04 24 31 c0 e8 0d 8b ff ff <0f> 0b 55 48 89 f8 48 8b 57 30 48 89 e5 48 8b 0f 5d 80 e5 80 48
> [59432.102519] RIP  [<ffffffff817eb99d>] skb_panic+0x5e/0x60
> [59432.102519]  RSP <ffff88001fc03cf8>
>
> crash> ps
>     PID    PPID  CPU       TASK        ST  %MEM     VSZ    RSS  COMM
>        0      0   0  ffffffff81c16480  RU   0.0       0      0  [swapper/0]
>        1      0   0  ffff88001f140000  IN   0.3    4232   1508  init
>        2      0   0  ffff88001f1408d0  IN   0.0       0      0  [kthreadd]
>        3      2   0  ffff88001f1411a0  IN   0.0       0      0  [ksoftirqd/0]
>        5      2   0  ffff88001f142340  IN   0.0       0      0  [kworker/0:0H]
>        7      2   0  ffff88001f1434e0  IN   0.0       0      0  [rcu_sched]
>        8      2   0  ffff88001f143db0  IN   0.0       0      0  [rcu_bh]
>        9      2   0  ffff88001f144680  IN   0.0       0      0  [migration/0]
>       10      2   0  ffff88001f144f50  IN   0.0       0      0  [khelper]
>       11      2   0  ffff88001f145820  IN   0.0       0      0  [kdevtmpfs]
>       12      2   0  ffff88001f1460f0  IN   0.0       0      0  [netns]
>       16      2   0  ffff88001f3408d0  IN   0.0       0      0  [writeback]
>       18      2   0  ffff88001f341a70  IN   0.0       0      0  [crypto]
>       20      2   0  ffff88001f342c10  IN   0.0       0      0  [bioset]
>       22      2   0  ffff88001f343db0  IN   0.0       0      0  [kblockd]
>       48      2   0  ffff88001f3469c0  IN   0.0       0      0  [ata_sff]
>       51      2   0  ffff88001f345820  IN   0.0       0      0  [khubd]
>       53      2   0  ffff88001f347290  IN   0.0       0      0  [md]
>       56      2   0  ffff88001f340000  IN   0.0       0      0  [cfg80211]
>       69      2   0  ffff88001f344680  IN   0.0       0      0  [rpciod]
>       74      2   0  ffff88001f342340  IN   0.0       0      0  [kswapd0]
>       78      2   0  ffff88001f147290  IN   0.0       0      0  [fsnotify_mark]
>       80      2   0  ffff8800000808d0  IN   0.0       0      0  [nfsiod]
>      117      2   0  ffff88001f3434e0  IN   0.0       0      0  [acpi_thermal_pm]
>      734      2   0  ffff88001f2260f0  IN   0.0       0      0  [scsi_eh_0]
>      735      2   0  ffff88001f2269c0  IN   0.0       0      0  [scsi_tmf_0]
>      737      2   0  ffff88001f224f50  IN   0.0       0      0  [scsi_eh_1]
>      739      2   0  ffff88001f223db0  IN   0.0       0      0  [scsi_tmf_1]
>      774      2   0  ffff88001a3d7290  IN   0.0       0      0  [kpsmoused]
>      781      2   0  ffff88001a3d4f50  IN   0.0       0      0  [ipv6_addrconf]
>      785      2   0  ffff88001a3d60f0  IN   0.0       0      0  [deferwq]
>      869      2   0  ffff88001f32cf50  IN   0.0       0      0  [kjournald]
>     1053      1   0  ffff88001f329a70  IN   0.6   36576   2916  systemd-udevd
>     1110      2   0  ffff88001f32e0f0  IN   0.0       0      0  [kworker/0:1H]
>     1493      1   0  ffff880019c47290  IN   0.3    4240   1544  acpid
>     1514      1   0  ffff880019c460f0  IN   0.4   17752   2316  crond
>     1860      1   0  ffff88001f32ac10  IN   7.9  749452  41644  ntop
>     1861      1   0  ffff88001f32d820  IN   7.9  749452  41644  ntop
>     1862      1   0  ffff88001f3291a0  IN   7.9  749452  41644  ntop
>     1863      1   0  ffff880019c43db0  IN   7.9  749452  41644  ntop
>     1864      1   0  ffff880019c45820  IN   7.9  749452  41644  ntop
>     1865      1   0  ffff880019c41a70  IN   7.9  749452  41644  ntop
>     1866      1   0  ffff880019c408d0  IN   7.9  749452  41644  ntop
>     1885      1   0  ffff880019c44f50  IN   7.9  749452  41644  ntop
>     1886      1   0  ffff880019c434e0  IN   7.9  749452  41644  ntop
>     1890      1   0  ffff880019c40000  IN   0.6   41536   3200  sshd
>     1935      1   0  ffff88001a39d820  IN   0.4   14232   2072  agetty
>     1939      1   0  ffff88001a398000  IN   7.9  749452  41644  ntop
>     1963      2   0  ffff88001037c680  IN   0.0       0      0  [kworker/u2:1]
>>   2012      1   0  ffff880019c411a0  RU   0.5  179496   2836  fastd
>     2028      2   0  ffff88001f225820  IN   0.0       0      0  [bat_events]
>     2043      1   0  ffff88001f224680  IN   0.5   11904   2664  alfred
>     2044      1   0  ffff88001f227290  IN   0.8   51388   3992  sudo
>     2045   2044   0  ffff88001f2211a0  IN   0.4    8684   1860  batadv-vis
>     2046   2043   0  ffff88001f221a70  IN   0.8   51388   3980  sudo
>     2047   2046   0  ffff88001f2208d0  IN   0.3    8484   1592  alfred
>     2093      1   0  ffff88001a399a70  IN   2.4   43536  12344  dhcpd
>     2133      1   0  ffff88001f222340  IN   0.3    7336   1692  vnstatd
>     2177      1   0  ffff88001f32b4e0  IN   7.5  177112  39340  named
>     2178      1   0  ffff88001f32e9c0  IN   7.5  177112  39340  named
>     2179      1   0  ffff88001f32bdb0  IN   7.5  177112  39340  named
>     2180      1   0  ffff88001f3288d0  IN   7.5  177112  39340  named
>     2230      1   0  ffff88001f220000  IN   4.5  300988  23680  apache2
>     2232   2230   0  ffff880019c42c10  IN   1.3  227520   6716  apache2
>     2247   2230   0  ffff880019c44680  IN  11.9 1066408  62252  apache2
>     2248   2230   0  ffff880019c469c0  IN  11.9 1066408  62524  apache2
>     2251   2230   0  ffff88001f32a340  IN  11.9 1066408  62524  apache2
>     2252   2230   0  ffff88001f344f50  IN  11.9 1066408  62524  apache2
>     2253   2230   0  ffff88001f3411a0  IN  11.9 1066408  62524  apache2
>     2254   2230   0  ffff88001a3991a0  IN  11.9 1066408  62524  apache2
>     2255   2230   0  ffff88001a39b4e0  IN  11.9 1066408  62524  apache2
>     2256   2230   0  ffff88001a2ed820  IN  11.9 1066408  62524  apache2
>     2257   2230   0  ffff88001a2ef290  IN  11.9 1066408  62524  apache2
>     2258   2230   0  ffff88001a2ecf50  IN  11.9 1066408  62524  apache2
>     2259   2230   0  ffff88001a2e9a70  IN  11.9 1066408  62524  apache2
>     2260   2230   0  ffff88001a2ec680  IN  11.9 1066408  62524  apache2
>     2261   2230   0  ffff88001a2e91a0  IN  11.9 1066408  62524  apache2
>     2262   2230   0  ffff88001a2ee0f0  IN  11.9 1066408  62524  apache2
>     2263   2230   0  ffff88001a2e88d0  IN  11.9 1066408  62524  apache2
>     2264   2230   0  ffff88001a2e8000  IN  11.9 1066408  62524  apache2
>     2265   2230   0  ffff88001a2ea340  IN  11.9 1066408  62524  apache2
>     2266   2230   0  ffff88001a2eac10  IN  11.9 1066408  62524  apache2
>     2267   2230   0  ffff88001a2eb4e0  IN  11.9 1066408  62524  apache2
>     2268   2230   0  ffff88001a2ebdb0  IN  11.9 1066408  62524  apache2
>     2269   2230   0  ffff88001a3d2c10  IN  11.9 1066408  62524  apache2
>     2270   2230   0  ffff88001a3d08d0  IN  11.9 1066408  62524  apache2
>     2271   2230   0  ffff88001a3d2340  IN  11.9 1066408  62524  apache2
>     2272   2230   0  ffff88001a3d1a70  IN  11.9 1066408  62524  apache2
>     2273   2230   0  ffff88001a3d11a0  IN  11.9 1066408  62252  apache2
>     2274   2230   0  ffff88001a3d0000  IN  11.9 1066408  62252  apache2
>     2275   2230   0  ffff88001a3d3db0  IN  11.9 1066408  62252  apache2
>     2276   2230   0  ffff88001a3d5820  IN  11.9 1066408  62252  apache2
>     2277   2230   0  ffff88001a3d69c0  IN  11.9 1066408  62252  apache2
>     2278   2230   0  ffff880000081a70  IN  11.9 1066408  62252  apache2
>     2279   2230   0  ffff880000082340  IN  11.9 1066408  62252  apache2
>     2280   2230   0  ffff880000082c10  IN  11.9 1066408  62252  apache2
>     2281   2230   0  ffff8800000834e0  IN  11.9 1066408  62252  apache2
>     2282   2230   0  ffff880000083db0  IN  11.9 1066408  62252  apache2
>     2283   2230   0  ffff880000084680  IN  11.9 1066408  62252  apache2
>     2284   2230   0  ffff880000084f50  IN  11.9 1066408  62252  apache2
>     2285   2230   0  ffff880000085820  IN  11.9 1066408  62252  apache2
>     2286   2230   0  ffff8800000860f0  IN  11.9 1066408  62252  apache2
>     2287   2230   0  ffff880000087290  IN  11.9 1066408  62524  apache2
>     2288   2230   0  ffff8800000811a0  IN  11.9 1066408  62524  apache2
>     2289   2230   0  ffff880000080000  IN  11.9 1066408  62524  apache2
>     2290   2230   0  ffff880013f18000  IN  11.9 1066408  62524  apache2
>     2291   2230   0  ffff8800000869c0  IN  11.9 1066408  62252  apache2
>     2292   2230   0  ffff880013f188d0  IN  11.9 1066408  62252  apache2
>     2293   2230   0  ffff880013f191a0  IN  11.9 1066408  62252  apache2
>     2294   2230   0  ffff880013f19a70  IN  11.9 1066408  62252  apache2
>     2295   2230   0  ffff880013f1a340  IN  11.9 1066408  62252  apache2
>     2296   2230   0  ffff880013f1ac10  IN  11.9 1066408  62252  apache2
>     2297   2230   0  ffff880013f1b4e0  IN  11.9 1066408  62252  apache2
>     2298   2230   0  ffff880013f1bdb0  IN  11.9 1066408  62252  apache2
>     2299   2230   0  ffff880013f1c680  IN  11.9 1066408  62252  apache2
>     2300   2230   0  ffff880013f1cf50  IN  11.9 1066408  62252  apache2
>     2301   2230   0  ffff880013f1d820  IN  11.9 1066408  62252  apache2
>     2302   2230   0  ffff880013f1e0f0  IN  11.9 1066408  62252  apache2
>     2318      1   0  ffff880013ff88d0  IN   0.5   11904   2680  runmap
>     4410      2   0  ffff88001a39f290  IN   0.0       0      0  [kworker/0:2]
>     5335      2   0  ffff88001037f290  IN   0.0       0      0  [kworker/u2:0]
>     6096      2   0  ffff88001037e0f0  IN   0.0       0      0  [kworker/0:1]
>     7792      2   0  ffff88001a39bdb0  IN   0.0       0      0  [kworker/0:0]
>     8412   2318   0  ffff88001037ac10  IN   0.2    4220   1308  sleep
>
> crash>  files
> PID: 2012   TASK: ffff880019c411a0  CPU: 0   COMMAND: "fastd"
> ROOT: /    CWD: /
>   FD       FILE            DENTRY           INODE       TYPE PATH
>    0 ffff88001f35f100 ffff88001a776c00 ffff880019a53440 CHR  /dev/pts/0
>    1 ffff88001f35f100 ffff88001a776c00 ffff880019a53440 CHR  /dev/pts/0
>    2 ffff88001f35f100 ffff88001a776c00 ffff880019a53440 CHR  /dev/pts/0
>    3 ffff88001935f300 ffff88001a7076c0 ffff88001f14fce0 CHR  /dev/urandom
>    5 ffff88001935f700 ffff880019a96600 ffff88001a77dbb0 SOCK UNIX
>    6 ffff88001935f900 ffff880019a96900 ffff88001a77d930 SOCK UNIX
>    7 ffff88001935f400 ffff880019a94f00 ffff88001a74fd40 UNKN [eventpoll]
>    8 ffff88001935f100 ffff880019a94e40 ffff88001a77d6b0 SOCK UDP
>    9 ffff880019376200 ffff88001a7ed0c0 ffff88001a3fba48 CHR  /dev/net/tun
>
> # batctl -v
> batctl gentoo-2014.3.0 [batman-adv: 2014.3.0]
>
> # fastd -v
> fastd v16
>
> # batctl if
> fastd0: active
>

-- 
Kind Regards,
Martin Hundebøll
Frederiks Allé 99A, 1.th
8000 Aarhus C

+45 61 65 54 61
martin@hundeboll.net

--------------010000090806080801080508
Content-Type: text/x-patch;
 name="frag_debug_size.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="frag_debug_size.patch"

diff --git a/fragmentation.c b/fragmentation.c
index 362e91a..f733b99 100644
--- a/fragmentation.c
+++ b/fragmentation.c
@@ -249,6 +249,24 @@ batadv_frag_merge_packets(struct hlist_head *chain, struct sk_buff *skb)
 	skb_out = entry->skb;
 	kfree(entry);
 
+	if (size < skb->len) {
+		printk(KERN_DEBUG "batadv_frag_merge_packets: skb total size too small: size=%i, skb->len=%u\n",
+		       size, skb->len);
+		print_hex_dump_bytes("", DUMP_PREFIX_NONE, skb->data - ETH_HLEN,
+				     ETH_HLEN + hdr_size + 16);
+
+		goto free;
+	}
+
+	if (size < skb_out->len) {
+		printk(KERN_DEBUG "batadv_frag_merge_packets: skb_out total size too small: size=%i, skb_out->len=%u\n",
+		       size, skb_out->len);
+		print_hex_dump_bytes("", DUMP_PREFIX_NONE, skb_out->data - ETH_HLEN,
+				     ETH_HLEN + hdr_size + 16);
+
+		goto free;
+	}
+
 	/* Make room for the rest of the fragments. */
 	if (pskb_expand_head(skb_out, 0, size - skb->len, GFP_ATOMIC) < 0) {
 		kfree_skb(skb_out);

--------------010000090806080801080508--
