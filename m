Return-Path: <a@unstable.cc>
Date: Sat, 7 May 2016 03:00:56 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160506190056.GB3907@prodigo.lan>
References: <20160506085016.GA2811@otheros>
 <5286456.Pk1RDFysCR@voltaire>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="DIOMP1UsTsWJauNi"
Content-Disposition: inline
In-Reply-To: <5286456.Pk1RDFysCR@voltaire>
Subject: Re: [B.A.T.M.A.N.] Kernel panic by BATMAN_V @WBMv9
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


--DIOMP1UsTsWJauNi
Content-Type: multipart/mixed; boundary="LpQ9ahxlCli8rRTG"
Content-Disposition: inline


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Attached you have the crash log with way more debugging
information after reproducing the issue on my VM with my debugging kernel.

The crash was reproduced using maint.


Cheers,

On Fri, May 06, 2016 at 07:21:59PM +0800, Marek Lindner wrote:
> On Friday, May 06, 2016 09:50:16 Linus L=FCssing wrote:
> > Just dumping this here, got a plane to catch.
> >=20
> > Guido can explain how you can trigger this.
>=20
> Thanks Linus! Unfortunately, this kernel backtrace does not yield much=20
> information. We'll continue deep diving into the matter today.
>=20
> Safe travels!
>=20
> Cheers,
> Marek



--=20
Antonio Quartulli

--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="use-after-free.txt"

root@localhost:~# ==================================================================    [1739/1771]
BUG: KASAN: use-after-free in _batadv_purge_orig+0x298/0x920 [batman_adv] at addr ffff88000b9ac7c0
Read of size 8 by task kworker/u2:0/6
=============================================================================
BUG kmalloc-192 (Tainted: G           O   ): kasan: bad access detected
-----------------------------------------------------------------------------

Disabling lock debugging due to kernel taint
INFO: Allocated in batadv_neigh_node_new+0x24b/0x780 [batman_adv] age=633 cpu=0 pid=1
        ___slab_alloc.constprop.28+0x37c/0x3a0
        __slab_alloc.constprop.27+0x40/0x90
        kmem_cache_alloc+0x117/0x150
        batadv_neigh_node_new+0x24b/0x780 [batman_adv]
        batadv_v_elp_packet_recv+0x22f/0x3e0 [batman_adv]
        batadv_batman_skb_recv+0x1e7/0x210 [batman_adv]
        __netif_receive_skb_core+0x8d9/0xb60
        __netif_receive_skb+0x32/0xc0
        netif_receive_skb_internal+0x65/0x150
        napi_gro_receive+0xa3/0x110
        virtnet_receive+0x414/0xe40
        virtnet_poll+0x1d/0xa0
        net_rx_action+0x3a6/0x500
        __do_softirq+0x168/0x2e9
        irq_exit+0x90/0xa0
        do_IRQ+0x6d/0x130
INFO: Freed in __rcu_process_callbacks+0xaa/0x1f0 age=16 cpu=0 pid=3
        __slab_free+0x247/0x3a0
        kfree+0x1a2/0x1c0
        __rcu_process_callbacks+0xaa/0x1f0
        rcu_process_callbacks+0x10/0x20
        __do_softirq+0x168/0x2e9
        run_ksoftirqd+0x1f/0x60
        smpboot_thread_fn+0x1d2/0x2f0
        kthread+0x193/0x1b0
        ret_from_fork+0x22/0x50
INFO: Slab 0xffffea00002e6b00 objects=8 used=6 fp=0xffff88000b9ac7c0 flags=0x4000000000000080
INFO: Object 0xffff88000b9ac7c0 @offset=1984 fp=0xffff88000b9ac5d0

Bytes b4 ffff88000b9ac7b0: 00 00 00 00 03 00 00 00 03 e5 fe ff 00 00 00 00  ................
Object ffff88000b9ac7c0: d0 c5 9a 0b 00 88 ff ff f0 b1 1a 09 00 88 ff ff  ................
Object ffff88000b9ac7d0: 80 c9 8a 0b 00 88 ff ff 00 ad be ef 02 02 00 00  ................
Object ffff88000b9ac7e0: 20 e3 12 0a 00 88 ff ff 01 00 00 00 ad 4e ad de   ............N..
Object ffff88000b9ac7f0: ff ff ff ff 00 00 00 00 ff ff ff ff ff ff ff ff  ................
Object ffff88000b9ac800: 60 43 05 a0 ff ff ff ff 50 6e 81 82 ff ff ff ff  `C......Pn......
Object ffff88000b9ac810: 00 00 00 00 00 00 00 00 00 fd 03 a0 ff ff ff ff  ................
Object ffff88000b9ac820: 00 00 00 00 00 00 00 00 d3 04 02 a0 ff ff ff ff  ................
Object ffff88000b9ac830: f0 59 1f 0c 00 88 ff ff 02 e5 fe ff 00 00 00 00  .Y..............
Object ffff88000b9ac840: d0 c5 9a 0b 00 88 ff ff 00 00 00 00 00 00 00 00  ................
Object ffff88000b9ac850: 00 00 00 00 00 00 00 00 90 00 00 00 00 00 00 00  ................
Object ffff88000b9ac860: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
Object ffff88000b9ac870: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
CPU: 0 PID: 6 Comm: kworker/u2:0 Tainted: G    B      O    4.6.0-rc5+ #78
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.8.2-20150714_191116- 04/01/2014
Workqueue: bat_events batadv_purge_orig [batman_adv]
 ffffea00002e6b00 0000000042350634 ffff88000d12fa40 ffffffff81322869
 ffff88000d12fa70 ffffffff8116f06d ffff88000d002000 ffffea00002e6b00
 ffff88000b9ac7c0 0000000000000000 ffff88000d12fa98 ffffffff81170fdf
Call Trace:
 [<ffffffff81322869>] dump_stack+0x19/0x20
 [<ffffffff8116f06d>] print_trailer+0x10d/0x1a0
 [<ffffffff81170fdf>] object_err+0x2f/0x40
 [<ffffffff811754bc>] kasan_report_error+0x22c/0x550
 [<ffffffff810a63e6>] ? mark_held_locks+0x96/0xc0
 [<ffffffff81062266>] ? __local_bh_enable_ip+0x66/0xb0
 [<ffffffff81175d52>] kasan_report+0x52/0x60
 [<ffffffffa001f128>] ? _batadv_purge_orig+0x298/0x920 [batman_adv]
 [<ffffffff811745fd>] __asan_load8+0x5d/0x70
 [<ffffffffa001f128>] _batadv_purge_orig+0x298/0x920 [batman_adv]
 [<ffffffffa001f7c4>] batadv_purge_orig+0x14/0x40 [batman_adv]
 [<ffffffff8107fd62>] process_one_work+0x3e2/0x7e0
 [<ffffffff8107fccc>] ? process_one_work+0x34c/0x7e0
 [<ffffffff8107f980>] ? cancel_delayed_work_sync+0x10/0x10
 [<ffffffff810a98b5>] ? check_flags.part.26+0x65/0x280
 [<ffffffff810801e5>] worker_thread+0x85/0x720
 [<ffffffff81080160>] ? process_one_work+0x7e0/0x7e0
 [<ffffffff81088a53>] kthread+0x193/0x1b0
 [<ffffffff810888c0>] ? kthread_create_on_node+0x340/0x340
 [<ffffffff8108de9c>] ? finish_task_switch+0xdc/0x280
 [<ffffffff81745b32>] ret_from_fork+0x22/0x50
 [<ffffffff810888c0>] ? kthread_create_on_node+0x340/0x340
Memory state around the buggy address:
 ffff88000b9ac680: fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88000b9ac700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88000b9ac780: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
                                           ^
 ffff88000b9ac800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88000b9ac880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
==================================================================                      [1651/1771]
BUG: KASAN: use-after-free in _batadv_purge_orig+0x2a5/0x920 [batman_adv] at addr ffff88000b9ac838
Read of size 8 by task kworker/u2:0/6
=============================================================================
BUG kmalloc-192 (Tainted: G    B      O   ): kasan: bad access detected
-----------------------------------------------------------------------------

INFO: Allocated in batadv_neigh_node_new+0x24b/0x780 [batman_adv] age=634 cpu=0 pid=1
        ___slab_alloc.constprop.28+0x37c/0x3a0
        __slab_alloc.constprop.27+0x40/0x90
        kmem_cache_alloc+0x117/0x150
        batadv_neigh_node_new+0x24b/0x780 [batman_adv]
        batadv_v_elp_packet_recv+0x22f/0x3e0 [batman_adv]
        batadv_batman_skb_recv+0x1e7/0x210 [batman_adv]
        __netif_receive_skb_core+0x8d9/0xb60
        __netif_receive_skb+0x32/0xc0
        netif_receive_skb_internal+0x65/0x150
        napi_gro_receive+0xa3/0x110
        virtnet_receive+0x414/0xe40
        virtnet_poll+0x1d/0xa0
        net_rx_action+0x3a6/0x500
        __do_softirq+0x168/0x2e9
        irq_exit+0x90/0xa0
        do_IRQ+0x6d/0x130
INFO: Freed in __rcu_process_callbacks+0xaa/0x1f0 age=17 cpu=0 pid=3
        __slab_free+0x247/0x3a0
        kfree+0x1a2/0x1c0
        __rcu_process_callbacks+0xaa/0x1f0
        rcu_process_callbacks+0x10/0x20
        __do_softirq+0x168/0x2e9
        run_ksoftirqd+0x1f/0x60
        smpboot_thread_fn+0x1d2/0x2f0
        kthread+0x193/0x1b0
        ret_from_fork+0x22/0x50
INFO: Slab 0xffffea00002e6b00 objects=8 used=6 fp=0xffff88000b9ac7c0 flags=0x4000000000000080
INFO: Object 0xffff88000b9ac7c0 @offset=1984 fp=0xffff88000b9ac5d0

Bytes b4 ffff88000b9ac7b0: 00 00 00 00 03 00 00 00 03 e5 fe ff 00 00 00 00  ................
Object ffff88000b9ac7c0: d0 c5 9a 0b 00 88 ff ff f0 b1 1a 09 00 88 ff ff  ................
Object ffff88000b9ac7d0: 80 c9 8a 0b 00 88 ff ff 00 ad be ef 02 02 00 00  ................
Object ffff88000b9ac7e0: 20 e3 12 0a 00 88 ff ff 01 00 00 00 ad 4e ad de   ............N..
Object ffff88000b9ac7f0: ff ff ff ff 00 00 00 00 ff ff ff ff ff ff ff ff  ................
Object ffff88000b9ac800: 60 43 05 a0 ff ff ff ff 50 6e 81 82 ff ff ff ff  `C......Pn......
Object ffff88000b9ac810: 00 00 00 00 00 00 00 00 00 fd 03 a0 ff ff ff ff  ................
Object ffff88000b9ac820: 00 00 00 00 00 00 00 00 d3 04 02 a0 ff ff ff ff  ................
Object ffff88000b9ac830: f0 59 1f 0c 00 88 ff ff 02 e5 fe ff 00 00 00 00  .Y..............
Object ffff88000b9ac840: d0 c5 9a 0b 00 88 ff ff 00 00 00 00 00 00 00 00  ................
Object ffff88000b9ac850: 00 00 00 00 00 00 00 00 90 00 00 00 00 00 00 00  ................
Object ffff88000b9ac860: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
Object ffff88000b9ac870: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
CPU: 0 PID: 6 Comm: kworker/u2:0 Tainted: G    B      O    4.6.0-rc5+ #78
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.8.2-20150714_191116- 04/01/2014
Workqueue: bat_events batadv_purge_orig [batman_adv]
 ffffea00002e6b00 0000000042350634 ffff88000d12fa40 ffffffff81322869
 ffff88000d12fa70 ffffffff8116f06d ffff88000d002000 ffffea00002e6b00
 ffff88000b9ac7c0 0000000000000000 ffff88000d12fa98 ffffffff81170fdf
Call Trace:
 [<ffffffff81322869>] dump_stack+0x19/0x20
 [<ffffffff8116f06d>] print_trailer+0x10d/0x1a0
 [<ffffffff81170fdf>] object_err+0x2f/0x40
 [<ffffffff811754bc>] kasan_report_error+0x22c/0x550
 [<ffffffff81175d52>] kasan_report+0x52/0x60                                            [1590/1771]
 [<ffffffffa001f135>] ? _batadv_purge_orig+0x2a5/0x920 [batman_adv]
 [<ffffffff811745fd>] __asan_load8+0x5d/0x70
 [<ffffffffa001f135>] _batadv_purge_orig+0x2a5/0x920 [batman_adv]
 [<ffffffffa001f7c4>] batadv_purge_orig+0x14/0x40 [batman_adv]
 [<ffffffff8107fd62>] process_one_work+0x3e2/0x7e0
 [<ffffffff8107fccc>] ? process_one_work+0x34c/0x7e0
 [<ffffffff8107f980>] ? cancel_delayed_work_sync+0x10/0x10
 [<ffffffff810a98b5>] ? check_flags.part.26+0x65/0x280
 [<ffffffff810801e5>] worker_thread+0x85/0x720
 [<ffffffff81080160>] ? process_one_work+0x7e0/0x7e0
 [<ffffffff81088a53>] kthread+0x193/0x1b0
 [<ffffffff810888c0>] ? kthread_create_on_node+0x340/0x340
 [<ffffffff8108de9c>] ? finish_task_switch+0xdc/0x280
 [<ffffffff81745b32>] ret_from_fork+0x22/0x50
 [<ffffffff810888c0>] ? kthread_create_on_node+0x340/0x340
Memory state around the buggy address:
 ffff88000b9ac700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88000b9ac780: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
>ffff88000b9ac800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                        ^
 ffff88000b9ac880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88000b9ac900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
==================================================================
BUG: KASAN: use-after-free in _batadv_purge_orig+0x2b2/0x920 [batman_adv] at addr ffff88000b9ac830
Read of size 8 by task kworker/u2:0/6
=============================================================================
BUG kmalloc-192 (Tainted: G    B      O   ): kasan: bad access detected
-----------------------------------------------------------------------------

INFO: Allocated in batadv_neigh_node_new+0x24b/0x780 [batman_adv] age=635 cpu=0 pid=1
        ___slab_alloc.constprop.28+0x37c/0x3a0
        __slab_alloc.constprop.27+0x40/0x90
        kmem_cache_alloc+0x117/0x150
        batadv_neigh_node_new+0x24b/0x780 [batman_adv]
        batadv_v_elp_packet_recv+0x22f/0x3e0 [batman_adv]
        batadv_batman_skb_recv+0x1e7/0x210 [batman_adv]
        __netif_receive_skb_core+0x8d9/0xb60
        __netif_receive_skb+0x32/0xc0
        netif_receive_skb_internal+0x65/0x150
        napi_gro_receive+0xa3/0x110
        virtnet_receive+0x414/0xe40
        virtnet_poll+0x1d/0xa0
        net_rx_action+0x3a6/0x500
        __do_softirq+0x168/0x2e9
        irq_exit+0x90/0xa0
        do_IRQ+0x6d/0x130
INFO: Freed in __rcu_process_callbacks+0xaa/0x1f0 age=18 cpu=0 pid=3
        __slab_free+0x247/0x3a0
        kfree+0x1a2/0x1c0
        __rcu_process_callbacks+0xaa/0x1f0
        rcu_process_callbacks+0x10/0x20
        __do_softirq+0x168/0x2e9
        run_ksoftirqd+0x1f/0x60
        smpboot_thread_fn+0x1d2/0x2f0
        kthread+0x193/0x1b0
        ret_from_fork+0x22/0x50
INFO: Slab 0xffffea00002e6b00 objects=8 used=6 fp=0xffff88000b9ac7c0 flags=0x4000000000000080
INFO: Object 0xffff88000b9ac7c0 @offset=1984 fp=0xffff88000b9ac5d0

Bytes b4 ffff88000b9ac7b0: 00 00 00 00 03 00 00 00 03 e5 fe ff 00 00 00 00  ............[1529/1771]
Object ffff88000b9ac7c0: d0 c5 9a 0b 00 88 ff ff f0 b1 1a 09 00 88 ff ff  ................
Object ffff88000b9ac7d0: 80 c9 8a 0b 00 88 ff ff 00 ad be ef 02 02 00 00  ................
Object ffff88000b9ac7e0: 20 e3 12 0a 00 88 ff ff 01 00 00 00 ad 4e ad de   ............N..
Object ffff88000b9ac7f0: ff ff ff ff 00 00 00 00 ff ff ff ff ff ff ff ff  ................
Object ffff88000b9ac800: 60 43 05 a0 ff ff ff ff 50 6e 81 82 ff ff ff ff  `C......Pn......
Object ffff88000b9ac810: 00 00 00 00 00 00 00 00 00 fd 03 a0 ff ff ff ff  ................
Object ffff88000b9ac820: 00 00 00 00 00 00 00 00 d3 04 02 a0 ff ff ff ff  ................
Object ffff88000b9ac830: f0 59 1f 0c 00 88 ff ff 02 e5 fe ff 00 00 00 00  .Y..............
Object ffff88000b9ac840: d0 c5 9a 0b 00 88 ff ff 00 00 00 00 00 00 00 00  ................
Object ffff88000b9ac850: 00 00 00 00 00 00 00 00 90 00 00 00 00 00 00 00  ................
Object ffff88000b9ac860: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
Object ffff88000b9ac870: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
CPU: 0 PID: 6 Comm: kworker/u2:0 Tainted: G    B      O    4.6.0-rc5+ #78
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.8.2-20150714_191116- 04/01/2014
Workqueue: bat_events batadv_purge_orig [batman_adv]
 ffffea00002e6b00 0000000042350634 ffff88000d12fa40 ffffffff81322869
 ffff88000d12fa70 ffffffff8116f06d ffff88000d002000 ffffea00002e6b00
 ffff88000b9ac7c0 0000000000000000 ffff88000d12fa98 ffffffff81170fdf
Call Trace:
 [<ffffffff81322869>] dump_stack+0x19/0x20
 [<ffffffff8116f06d>] print_trailer+0x10d/0x1a0
 [<ffffffff81170fdf>] object_err+0x2f/0x40
 [<ffffffff811754bc>] kasan_report_error+0x22c/0x550
 [<ffffffff81175d52>] kasan_report+0x52/0x60
 [<ffffffffa001f142>] ? _batadv_purge_orig+0x2b2/0x920 [batman_adv]
 [<ffffffff811745fd>] __asan_load8+0x5d/0x70
 [<ffffffffa001f142>] _batadv_purge_orig+0x2b2/0x920 [batman_adv]
 [<ffffffffa001f7c4>] batadv_purge_orig+0x14/0x40 [batman_adv]
 [<ffffffff8107fd62>] process_one_work+0x3e2/0x7e0
 [<ffffffff8107fccc>] ? process_one_work+0x34c/0x7e0
 [<ffffffff8107f980>] ? cancel_delayed_work_sync+0x10/0x10
 [<ffffffff810a98b5>] ? check_flags.part.26+0x65/0x280
 [<ffffffff810801e5>] worker_thread+0x85/0x720
 [<ffffffff81080160>] ? process_one_work+0x7e0/0x7e0
 [<ffffffff81088a53>] kthread+0x193/0x1b0
 [<ffffffff810888c0>] ? kthread_create_on_node+0x340/0x340
 [<ffffffff8108de9c>] ? finish_task_switch+0xdc/0x280
 [<ffffffff81745b32>] ret_from_fork+0x22/0x50
 [<ffffffff810888c0>] ? kthread_create_on_node+0x340/0x340
Memory state around the buggy address:
 ffff88000b9ac700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88000b9ac780: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
>ffff88000b9ac800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff88000b9ac880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88000b9ac900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
==================================================================
BUG: KASAN: use-after-free in do_raw_spin_trylock+0x11/0x80 at addr ffff88000b9ac7e8
Read of size 4 by task kworker/u2:0/6
=============================================================================
BUG kmalloc-192 (Tainted: G    B      O   ): kasan: bad access detected
-----------------------------------------------------------------------------

INFO: Allocated in batadv_neigh_node_new+0x24b/0x780 [batman_adv] age=636 cpu=0 pid=1
        ___slab_alloc.constprop.28+0x37c/0x3a0
        __slab_alloc.constprop.27+0x40/0x90
        kmem_cache_alloc+0x117/0x150
        batadv_neigh_node_new+0x24b/0x780 [batman_adv]
        batadv_v_elp_packet_recv+0x22f/0x3e0 [batman_adv]
        batadv_batman_skb_recv+0x1e7/0x210 [batman_adv]                                 [1468/1771]
        __netif_receive_skb_core+0x8d9/0xb60
        __netif_receive_skb+0x32/0xc0
        netif_receive_skb_internal+0x65/0x150
        napi_gro_receive+0xa3/0x110
        virtnet_receive+0x414/0xe40
        virtnet_poll+0x1d/0xa0
        net_rx_action+0x3a6/0x500
        __do_softirq+0x168/0x2e9
        irq_exit+0x90/0xa0
        do_IRQ+0x6d/0x130
INFO: Freed in __rcu_process_callbacks+0xaa/0x1f0 age=19 cpu=0 pid=3
        __slab_free+0x247/0x3a0
        kfree+0x1a2/0x1c0
        __rcu_process_callbacks+0xaa/0x1f0
        rcu_process_callbacks+0x10/0x20
        __do_softirq+0x168/0x2e9
        run_ksoftirqd+0x1f/0x60
        smpboot_thread_fn+0x1d2/0x2f0
        kthread+0x193/0x1b0
        ret_from_fork+0x22/0x50
INFO: Slab 0xffffea00002e6b00 objects=8 used=6 fp=0xffff88000b9ac7c0 flags=0x4000000000000080
INFO: Object 0xffff88000b9ac7c0 @offset=1984 fp=0xffff88000b9ac5d0

Bytes b4 ffff88000b9ac7b0: 00 00 00 00 03 00 00 00 03 e5 fe ff 00 00 00 00  ................
Object ffff88000b9ac7c0: d0 c5 9a 0b 00 88 ff ff f0 b1 1a 09 00 88 ff ff  ................
Object ffff88000b9ac7d0: 80 c9 8a 0b 00 88 ff ff 00 ad be ef 02 02 00 00  ................
Object ffff88000b9ac7e0: 20 e3 12 0a 00 88 ff ff 01 00 00 00 ad 4e ad de   ............N..
Object ffff88000b9ac7f0: ff ff ff ff 00 00 00 00 ff ff ff ff ff ff ff ff  ................
Object ffff88000b9ac800: 60 43 05 a0 ff ff ff ff 50 6e 81 82 ff ff ff ff  `C......Pn......
Object ffff88000b9ac810: 00 00 00 00 00 00 00 00 00 fd 03 a0 ff ff ff ff  ................
Object ffff88000b9ac820: 00 00 00 00 00 00 00 00 d3 04 02 a0 ff ff ff ff  ................
Object ffff88000b9ac830: f0 59 1f 0c 00 88 ff ff 02 e5 fe ff 00 00 00 00  .Y..............
Object ffff88000b9ac840: d0 c5 9a 0b 00 88 ff ff 00 00 00 00 00 00 00 00  ................
Object ffff88000b9ac850: 00 00 00 00 00 00 00 00 90 00 00 00 00 00 00 00  ................
Object ffff88000b9ac860: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
Object ffff88000b9ac870: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
CPU: 0 PID: 6 Comm: kworker/u2:0 Tainted: G    B      O    4.6.0-rc5+ #78
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.8.2-20150714_191116- 04/01/2014
Workqueue: bat_events batadv_purge_orig [batman_adv]
 ffffea00002e6b00 0000000042350634 ffff88000d12f9f0 ffffffff81322869
 ffff88000d12fa20 ffffffff8116f06d ffff88000d002000 ffffea00002e6b00
 ffff88000b9ac7c0 0000000000000000 ffff88000d12fa48 ffffffff81170fdf
Call Trace:
 [<ffffffff81322869>] dump_stack+0x19/0x20
 [<ffffffff8116f06d>] print_trailer+0x10d/0x1a0
 [<ffffffff81170fdf>] object_err+0x2f/0x40
 [<ffffffff811754bc>] kasan_report_error+0x22c/0x550
 [<ffffffff81745066>] ? _raw_spin_unlock_irqrestore+0x36/0x60
 [<ffffffff81175d52>] kasan_report+0x52/0x60
 [<ffffffff810b0ce1>] ? do_raw_spin_trylock+0x11/0x80
 [<ffffffff81174510>] __asan_load4+0x60/0x70
 [<ffffffff810b0ce1>] do_raw_spin_trylock+0x11/0x80
 [<ffffffff81744d58>] _raw_spin_lock_bh+0x48/0x80
 [<ffffffffa001f18c>] ? _batadv_purge_orig+0x2fc/0x920 [batman_adv]
 [<ffffffffa001f18c>] _batadv_purge_orig+0x2fc/0x920 [batman_adv]
 [<ffffffffa001f7c4>] batadv_purge_orig+0x14/0x40 [batman_adv]
 [<ffffffff8107fd62>] process_one_work+0x3e2/0x7e0
 [<ffffffff8107fccc>] ? process_one_work+0x34c/0x7e0
 [<ffffffff8107f980>] ? cancel_delayed_work_sync+0x10/0x10
 [<ffffffff810a98b5>] ? check_flags.part.26+0x65/0x280
 [<ffffffff810801e5>] worker_thread+0x85/0x720                                          [1407/1771]
 [<ffffffff81080160>] ? process_one_work+0x7e0/0x7e0
 [<ffffffff81088a53>] kthread+0x193/0x1b0
 [<ffffffff810888c0>] ? kthread_create_on_node+0x340/0x340
 [<ffffffff8108de9c>] ? finish_task_switch+0xdc/0x280
 [<ffffffff81745b32>] ret_from_fork+0x22/0x50
 [<ffffffff810888c0>] ? kthread_create_on_node+0x340/0x340
Memory state around the buggy address:
 ffff88000b9ac680: fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88000b9ac700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88000b9ac780: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
                                                          ^
 ffff88000b9ac800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88000b9ac880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
==================================================================
BUG: KASAN: use-after-free in do_raw_spin_trylock+0x1c/0x80 at addr ffff88000b9ac7e8
Write of size 4 by task kworker/u2:0/6
=============================================================================
BUG kmalloc-192 (Tainted: G    B      O   ): kasan: bad access detected
-----------------------------------------------------------------------------

INFO: Allocated in batadv_neigh_node_new+0x24b/0x780 [batman_adv] age=637 cpu=0 pid=1
        ___slab_alloc.constprop.28+0x37c/0x3a0
        __slab_alloc.constprop.27+0x40/0x90
        kmem_cache_alloc+0x117/0x150
        batadv_neigh_node_new+0x24b/0x780 [batman_adv]
        batadv_v_elp_packet_recv+0x22f/0x3e0 [batman_adv]
        batadv_batman_skb_recv+0x1e7/0x210 [batman_adv]
        __netif_receive_skb_core+0x8d9/0xb60
        __netif_receive_skb+0x32/0xc0
        netif_receive_skb_internal+0x65/0x150
        napi_gro_receive+0xa3/0x110
        virtnet_receive+0x414/0xe40
        virtnet_poll+0x1d/0xa0
        net_rx_action+0x3a6/0x500
        __do_softirq+0x168/0x2e9
        irq_exit+0x90/0xa0
        do_IRQ+0x6d/0x130
INFO: Freed in __rcu_process_callbacks+0xaa/0x1f0 age=20 cpu=0 pid=3
        __slab_free+0x247/0x3a0
        kfree+0x1a2/0x1c0
        __rcu_process_callbacks+0xaa/0x1f0
        rcu_process_callbacks+0x10/0x20
        __do_softirq+0x168/0x2e9
        run_ksoftirqd+0x1f/0x60
        smpboot_thread_fn+0x1d2/0x2f0
        kthread+0x193/0x1b0
        ret_from_fork+0x22/0x50
INFO: Slab 0xffffea00002e6b00 objects=8 used=6 fp=0xffff88000b9ac7c0 flags=0x4000000000000080
INFO: Object 0xffff88000b9ac7c0 @offset=1984 fp=0xffff88000b9ac5d0

Bytes b4 ffff88000b9ac7b0: 00 00 00 00 03 00 00 00 03 e5 fe ff 00 00 00 00  ................
Object ffff88000b9ac7c0: d0 c5 9a 0b 00 88 ff ff f0 b1 1a 09 00 88 ff ff  ................
Object ffff88000b9ac7d0: 80 c9 8a 0b 00 88 ff ff 00 ad be ef 02 02 00 00  ................
Object ffff88000b9ac7e0: 20 e3 12 0a 00 88 ff ff 01 00 00 00 ad 4e ad de   ............N..
Object ffff88000b9ac7f0: ff ff ff ff 00 00 00 00 ff ff ff ff ff ff ff ff  ................
Object ffff88000b9ac800: 60 43 05 a0 ff ff ff ff 50 6e 81 82 ff ff ff ff  `C......Pn......
Object ffff88000b9ac810: 00 00 00 00 00 00 00 00 00 fd 03 a0 ff ff ff ff  ................
Object ffff88000b9ac820: 00 00 00 00 00 00 00 00 d3 04 02 a0 ff ff ff ff  ................
Object ffff88000b9ac830: f0 59 1f 0c 00 88 ff ff 02 e5 fe ff 00 00 00 00  .Y..............
Object ffff88000b9ac840: d0 c5 9a 0b 00 88 ff ff 00 00 00 00 00 00 00 00  ..............[1346/1771]
Object ffff88000b9ac850: 00 00 00 00 00 00 00 00 90 00 00 00 00 00 00 00  ................
Object ffff88000b9ac860: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
Object ffff88000b9ac870: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
CPU: 0 PID: 6 Comm: kworker/u2:0 Tainted: G    B      O    4.6.0-rc5+ #78
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.8.2-20150714_191116- 04/01/2014
Workqueue: bat_events batadv_purge_orig [batman_adv]
 ffffea00002e6b00 0000000042350634 ffff88000d12f9f0 ffffffff81322869
 ffff88000d12fa20 ffffffff8116f06d ffff88000d002000 ffffea00002e6b00
 ffff88000b9ac7c0 0000000000000000 ffff88000d12fa48 ffffffff81170fdf
Call Trace:
 [<ffffffff81322869>] dump_stack+0x19/0x20
 [<ffffffff8116f06d>] print_trailer+0x10d/0x1a0
 [<ffffffff81170fdf>] object_err+0x2f/0x40
 [<ffffffff811754bc>] kasan_report_error+0x22c/0x550
 [<ffffffff81175d52>] kasan_report+0x52/0x60
 [<ffffffff810b0cec>] ? do_raw_spin_trylock+0x1c/0x80
 [<ffffffff81174583>] __asan_store4+0x63/0x80
 [<ffffffff810b0cec>] do_raw_spin_trylock+0x1c/0x80
 [<ffffffff81744d58>] _raw_spin_lock_bh+0x48/0x80
 [<ffffffffa001f18c>] ? _batadv_purge_orig+0x2fc/0x920 [batman_adv]
 [<ffffffffa001f18c>] _batadv_purge_orig+0x2fc/0x920 [batman_adv]
 [<ffffffffa001f7c4>] batadv_purge_orig+0x14/0x40 [batman_adv]
 [<ffffffff8107fd62>] process_one_work+0x3e2/0x7e0
 [<ffffffff8107fccc>] ? process_one_work+0x34c/0x7e0
 [<ffffffff8107f980>] ? cancel_delayed_work_sync+0x10/0x10
 [<ffffffff810a98b5>] ? check_flags.part.26+0x65/0x280
 [<ffffffff810801e5>] worker_thread+0x85/0x720
 [<ffffffff81080160>] ? process_one_work+0x7e0/0x7e0
 [<ffffffff81088a53>] kthread+0x193/0x1b0
 [<ffffffff810888c0>] ? kthread_create_on_node+0x340/0x340
 [<ffffffff8108de9c>] ? finish_task_switch+0xdc/0x280
 [<ffffffff81745b32>] ret_from_fork+0x22/0x50
 [<ffffffff810888c0>] ? kthread_create_on_node+0x340/0x340
Memory state around the buggy address:
 ffff88000b9ac680: fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88000b9ac700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88000b9ac780: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
                                                          ^
 ffff88000b9ac800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88000b9ac880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
==================================================================
BUG: KASAN: use-after-free in do_raw_spin_trylock+0x3f/0x80 at addr ffff88000b9ac7f0
Write of size 4 by task kworker/u2:0/6
=============================================================================
BUG kmalloc-192 (Tainted: G    B      O   ): kasan: bad access detected
-----------------------------------------------------------------------------

INFO: Allocated in batadv_neigh_node_new+0x24b/0x780 [batman_adv] age=638 cpu=0 pid=1
        ___slab_alloc.constprop.28+0x37c/0x3a0
        __slab_alloc.constprop.27+0x40/0x90
        kmem_cache_alloc+0x117/0x150
        batadv_neigh_node_new+0x24b/0x780 [batman_adv]
        batadv_v_elp_packet_recv+0x22f/0x3e0 [batman_adv]
        batadv_batman_skb_recv+0x1e7/0x210 [batman_adv]
        __netif_receive_skb_core+0x8d9/0xb60
        __netif_receive_skb+0x32/0xc0
        netif_receive_skb_internal+0x65/0x150
        napi_gro_receive+0xa3/0x110
        virtnet_receive+0x414/0xe40
        virtnet_poll+0x1d/0xa0                                                          [1285/1771]
        net_rx_action+0x3a6/0x500
        __do_softirq+0x168/0x2e9
        irq_exit+0x90/0xa0
        do_IRQ+0x6d/0x130
INFO: Freed in __rcu_process_callbacks+0xaa/0x1f0 age=21 cpu=0 pid=3
        __slab_free+0x247/0x3a0
        kfree+0x1a2/0x1c0
        __rcu_process_callbacks+0xaa/0x1f0
        rcu_process_callbacks+0x10/0x20
        __do_softirq+0x168/0x2e9
        run_ksoftirqd+0x1f/0x60
        smpboot_thread_fn+0x1d2/0x2f0
        kthread+0x193/0x1b0
        ret_from_fork+0x22/0x50
INFO: Slab 0xffffea00002e6b00 objects=8 used=6 fp=0xffff88000b9ac7c0 flags=0x4000000000000080
INFO: Object 0xffff88000b9ac7c0 @offset=1984 fp=0xffff88000b9ac5d0

Bytes b4 ffff88000b9ac7b0: 00 00 00 00 03 00 00 00 03 e5 fe ff 00 00 00 00  ................
Object ffff88000b9ac7c0: d0 c5 9a 0b 00 88 ff ff f0 b1 1a 09 00 88 ff ff  ................
Object ffff88000b9ac7d0: 80 c9 8a 0b 00 88 ff ff 00 ad be ef 02 02 00 00  ................
Object ffff88000b9ac7e0: 20 e3 12 0a 00 88 ff ff 00 00 00 00 ad 4e ad de   ............N..
Object ffff88000b9ac7f0: ff ff ff ff 00 00 00 00 ff ff ff ff ff ff ff ff  ................
Object ffff88000b9ac800: 60 43 05 a0 ff ff ff ff 50 6e 81 82 ff ff ff ff  `C......Pn......
Object ffff88000b9ac810: 00 00 00 00 00 00 00 00 00 fd 03 a0 ff ff ff ff  ................
Object ffff88000b9ac820: 00 00 00 00 00 00 00 00 d3 04 02 a0 ff ff ff ff  ................
Object ffff88000b9ac830: f0 59 1f 0c 00 88 ff ff 02 e5 fe ff 00 00 00 00  .Y..............
Object ffff88000b9ac840: d0 c5 9a 0b 00 88 ff ff 00 00 00 00 00 00 00 00  ................
Object ffff88000b9ac850: 00 00 00 00 00 00 00 00 90 00 00 00 00 00 00 00  ................
Object ffff88000b9ac860: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
Object ffff88000b9ac870: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
CPU: 0 PID: 6 Comm: kworker/u2:0 Tainted: G    B      O    4.6.0-rc5+ #78
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.8.2-20150714_191116- 04/01/2014
Workqueue: bat_events batadv_purge_orig [batman_adv]
 ffffea00002e6b00 0000000042350634 ffff88000d12f9f0 ffffffff81322869
 ffff88000d12fa20 ffffffff8116f06d ffff88000d002000 ffffea00002e6b00
 ffff88000b9ac7c0 0000000000000000 ffff88000d12fa48 ffffffff81170fdf
Call Trace:
 [<ffffffff81322869>] dump_stack+0x19/0x20
 [<ffffffff8116f06d>] print_trailer+0x10d/0x1a0
 [<ffffffff81170fdf>] object_err+0x2f/0x40
 [<ffffffff811754bc>] kasan_report_error+0x22c/0x550
 [<ffffffff81175d52>] kasan_report+0x52/0x60
 [<ffffffff810b0d0f>] ? do_raw_spin_trylock+0x3f/0x80
 [<ffffffff81174583>] __asan_store4+0x63/0x80
 [<ffffffff810b0d0f>] do_raw_spin_trylock+0x3f/0x80
 [<ffffffff81744d58>] _raw_spin_lock_bh+0x48/0x80
 [<ffffffffa001f18c>] ? _batadv_purge_orig+0x2fc/0x920 [batman_adv]
 [<ffffffffa001f18c>] _batadv_purge_orig+0x2fc/0x920 [batman_adv]
 [<ffffffffa001f7c4>] batadv_purge_orig+0x14/0x40 [batman_adv]
 [<ffffffff8107fd62>] process_one_work+0x3e2/0x7e0
 [<ffffffff8107fccc>] ? process_one_work+0x34c/0x7e0
 [<ffffffff8107f980>] ? cancel_delayed_work_sync+0x10/0x10
 [<ffffffff810a98b5>] ? check_flags.part.26+0x65/0x280
 [<ffffffff810801e5>] worker_thread+0x85/0x720
 [<ffffffff81080160>] ? process_one_work+0x7e0/0x7e0
 [<ffffffff81088a53>] kthread+0x193/0x1b0
 [<ffffffff810888c0>] ? kthread_create_on_node+0x340/0x340
 [<ffffffff8108de9c>] ? finish_task_switch+0xdc/0x280
 [<ffffffff81745b32>] ret_from_fork+0x22/0x50
 [<ffffffff810888c0>] ? kthread_create_on_node+0x340/0x340
Memory state around the buggy address:                                                  [1224/1771]
 ffff88000b9ac680: fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88000b9ac700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88000b9ac780: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
                                                             ^
 ffff88000b9ac800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88000b9ac880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
==================================================================
BUG: KASAN: use-after-free in do_raw_spin_trylock+0x4f/0x80 at addr ffff88000b9ac7f8
Write of size 8 by task kworker/u2:0/6
=============================================================================
BUG kmalloc-192 (Tainted: G    B      O   ): kasan: bad access detected
-----------------------------------------------------------------------------

INFO: Allocated in batadv_neigh_node_new+0x24b/0x780 [batman_adv] age=639 cpu=0 pid=1
        ___slab_alloc.constprop.28+0x37c/0x3a0
        __slab_alloc.constprop.27+0x40/0x90
        kmem_cache_alloc+0x117/0x150
        batadv_neigh_node_new+0x24b/0x780 [batman_adv]
        batadv_v_elp_packet_recv+0x22f/0x3e0 [batman_adv]
        batadv_batman_skb_recv+0x1e7/0x210 [batman_adv]
        __netif_receive_skb_core+0x8d9/0xb60
        __netif_receive_skb+0x32/0xc0
        netif_receive_skb_internal+0x65/0x150
        napi_gro_receive+0xa3/0x110
        virtnet_receive+0x414/0xe40
        virtnet_poll+0x1d/0xa0
        net_rx_action+0x3a6/0x500
        __do_softirq+0x168/0x2e9
        irq_exit+0x90/0xa0
        do_IRQ+0x6d/0x130
INFO: Freed in __rcu_process_callbacks+0xaa/0x1f0 age=22 cpu=0 pid=3
        __slab_free+0x247/0x3a0
        kfree+0x1a2/0x1c0
        __rcu_process_callbacks+0xaa/0x1f0
        rcu_process_callbacks+0x10/0x20
        __do_softirq+0x168/0x2e9
        run_ksoftirqd+0x1f/0x60
        smpboot_thread_fn+0x1d2/0x2f0
        kthread+0x193/0x1b0
        ret_from_fork+0x22/0x50
INFO: Slab 0xffffea00002e6b00 objects=8 used=6 fp=0xffff88000b9ac7c0 flags=0x4000000000000080
INFO: Object 0xffff88000b9ac7c0 @offset=1984 fp=0xffff88000b9ac5d0

Bytes b4 ffff88000b9ac7b0: 00 00 00 00 03 00 00 00 03 e5 fe ff 00 00 00 00  ................
Object ffff88000b9ac7c0: d0 c5 9a 0b 00 88 ff ff f0 b1 1a 09 00 88 ff ff  ................
Object ffff88000b9ac7d0: 80 c9 8a 0b 00 88 ff ff 00 ad be ef 02 02 00 00  ................
Object ffff88000b9ac7e0: 20 e3 12 0a 00 88 ff ff 00 00 00 00 ad 4e ad de   ............N..
Object ffff88000b9ac7f0: 00 00 00 00 00 00 00 00 ff ff ff ff ff ff ff ff  ................
Object ffff88000b9ac800: 60 43 05 a0 ff ff ff ff 50 6e 81 82 ff ff ff ff  `C......Pn......
Object ffff88000b9ac810: 00 00 00 00 00 00 00 00 00 fd 03 a0 ff ff ff ff  ................
Object ffff88000b9ac820: 00 00 00 00 00 00 00 00 d3 04 02 a0 ff ff ff ff  ................
Object ffff88000b9ac830: f0 59 1f 0c 00 88 ff ff 02 e5 fe ff 00 00 00 00  .Y..............
Object ffff88000b9ac840: d0 c5 9a 0b 00 88 ff ff 00 00 00 00 00 00 00 00  ................
Object ffff88000b9ac850: 00 00 00 00 00 00 00 00 90 00 00 00 00 00 00 00  ................
Object ffff88000b9ac860: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
Object ffff88000b9ac870: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
CPU: 0 PID: 6 Comm: kworker/u2:0 Tainted: G    B      O    4.6.0-rc5+ #78
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.8.2-20150714_191116- 04/01/2014
Workqueue: bat_events batadv_purge_orig [batman_adv]
 ffffea00002e6b00 0000000042350634 ffff88000d12f9f0 ffffffff81322869                    [1163/1771]
 ffff88000d12fa20 ffffffff8116f06d ffff88000d002000 ffffea00002e6b00
 ffff88000b9ac7c0 0000000000000000 ffff88000d12fa48 ffffffff81170fdf
Call Trace:
 [<ffffffff81322869>] dump_stack+0x19/0x20
 [<ffffffff8116f06d>] print_trailer+0x10d/0x1a0
 [<ffffffff81170fdf>] object_err+0x2f/0x40
 [<ffffffff811754bc>] kasan_report_error+0x22c/0x550
 [<ffffffff81175d52>] kasan_report+0x52/0x60
 [<ffffffff810b0d1f>] ? do_raw_spin_trylock+0x4f/0x80
 [<ffffffff81174670>] __asan_store8+0x60/0x70
 [<ffffffff810b0d1f>] do_raw_spin_trylock+0x4f/0x80
 [<ffffffff81744d58>] _raw_spin_lock_bh+0x48/0x80
 [<ffffffffa001f18c>] ? _batadv_purge_orig+0x2fc/0x920 [batman_adv]
 [<ffffffffa001f18c>] _batadv_purge_orig+0x2fc/0x920 [batman_adv]
 [<ffffffffa001f7c4>] batadv_purge_orig+0x14/0x40 [batman_adv]
 [<ffffffff8107fd62>] process_one_work+0x3e2/0x7e0
 [<ffffffff8107fccc>] ? process_one_work+0x34c/0x7e0
 [<ffffffff8107f980>] ? cancel_delayed_work_sync+0x10/0x10
 [<ffffffff810a98b5>] ? check_flags.part.26+0x65/0x280
 [<ffffffff810801e5>] worker_thread+0x85/0x720
 [<ffffffff81080160>] ? process_one_work+0x7e0/0x7e0
 [<ffffffff81088a53>] kthread+0x193/0x1b0
 [<ffffffff810888c0>] ? kthread_create_on_node+0x340/0x340
 [<ffffffff8108de9c>] ? finish_task_switch+0xdc/0x280
 [<ffffffff81745b32>] ret_from_fork+0x22/0x50
 [<ffffffff810888c0>] ? kthread_create_on_node+0x340/0x340
Memory state around the buggy address:
 ffff88000b9ac680: fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88000b9ac700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88000b9ac780: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
                                                                ^
 ffff88000b9ac800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88000b9ac880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
==================================================================
BUG: KASAN: use-after-free in _batadv_purge_orig+0x305/0x920 [batman_adv] at addr ffff88000b9ac7e0
Read of size 8 by task kworker/u2:0/6
=============================================================================
BUG kmalloc-192 (Tainted: G    B      O   ): kasan: bad access detected
-----------------------------------------------------------------------------

INFO: Allocated in batadv_neigh_node_new+0x24b/0x780 [batman_adv] age=640 cpu=0 pid=1
        ___slab_alloc.constprop.28+0x37c/0x3a0
        __slab_alloc.constprop.27+0x40/0x90
        kmem_cache_alloc+0x117/0x150
        batadv_neigh_node_new+0x24b/0x780 [batman_adv]
        batadv_v_elp_packet_recv+0x22f/0x3e0 [batman_adv]
        batadv_batman_skb_recv+0x1e7/0x210 [batman_adv]
        __netif_receive_skb_core+0x8d9/0xb60
        __netif_receive_skb+0x32/0xc0
        netif_receive_skb_internal+0x65/0x150
        napi_gro_receive+0xa3/0x110
        virtnet_receive+0x414/0xe40
        virtnet_poll+0x1d/0xa0
        net_rx_action+0x3a6/0x500
        __do_softirq+0x168/0x2e9
        irq_exit+0x90/0xa0
        do_IRQ+0x6d/0x130
INFO: Freed in __rcu_process_callbacks+0xaa/0x1f0 age=23 cpu=0 pid=3
        __slab_free+0x247/0x3a0
        kfree+0x1a2/0x1c0                                                               [1102/1771]
        __rcu_process_callbacks+0xaa/0x1f0
        rcu_process_callbacks+0x10/0x20
        __do_softirq+0x168/0x2e9
        run_ksoftirqd+0x1f/0x60
        smpboot_thread_fn+0x1d2/0x2f0
        kthread+0x193/0x1b0
        ret_from_fork+0x22/0x50
INFO: Slab 0xffffea00002e6b00 objects=8 used=6 fp=0xffff88000b9ac7c0 flags=0x4000000000000080
INFO: Object 0xffff88000b9ac7c0 @offset=1984 fp=0xffff88000b9ac5d0

Bytes b4 ffff88000b9ac7b0: 00 00 00 00 03 00 00 00 03 e5 fe ff 00 00 00 00  ................
Object ffff88000b9ac7c0: d0 c5 9a 0b 00 88 ff ff f0 b1 1a 09 00 88 ff ff  ................
Object ffff88000b9ac7d0: 80 c9 8a 0b 00 88 ff ff 00 ad be ef 02 02 00 00  ................
Object ffff88000b9ac7e0: 20 e3 12 0a 00 88 ff ff 00 00 00 00 ad 4e ad de   ............N..
Object ffff88000b9ac7f0: 00 00 00 00 00 00 00 00 00 00 12 0d 00 88 ff ff  ................
Object ffff88000b9ac800: 60 43 05 a0 ff ff ff ff 50 6e 81 82 ff ff ff ff  `C......Pn......
Object ffff88000b9ac810: 00 00 00 00 00 00 00 00 00 fd 03 a0 ff ff ff ff  ................
Object ffff88000b9ac820: 00 00 00 00 00 00 00 00 d3 04 02 a0 ff ff ff ff  ................
Object ffff88000b9ac830: f0 59 1f 0c 00 88 ff ff 02 e5 fe ff 00 00 00 00  .Y..............
Object ffff88000b9ac840: d0 c5 9a 0b 00 88 ff ff 00 00 00 00 00 00 00 00  ................
Object ffff88000b9ac850: 00 00 00 00 00 00 00 00 90 00 00 00 00 00 00 00  ................
Object ffff88000b9ac860: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
Object ffff88000b9ac870: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
CPU: 0 PID: 6 Comm: kworker/u2:0 Tainted: G    B      O    4.6.0-rc5+ #78
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.8.2-20150714_191116- 04/01/2014
Workqueue: bat_events batadv_purge_orig [batman_adv]
 ffffea00002e6b00 0000000042350634 ffff88000d12fa40 ffffffff81322869
 ffff88000d12fa70 ffffffff8116f06d ffff88000d002000 ffffea00002e6b00
 ffff88000b9ac7c0 0000000000000000 ffff88000d12fa98 ffffffff81170fdf
Call Trace:
 [<ffffffff81322869>] dump_stack+0x19/0x20
 [<ffffffff8116f06d>] print_trailer+0x10d/0x1a0
 [<ffffffff81170fdf>] object_err+0x2f/0x40
 [<ffffffff811754bc>] kasan_report_error+0x22c/0x550
 [<ffffffff81175d52>] ? kasan_report+0x52/0x60
 [<ffffffff81175d52>] kasan_report+0x52/0x60
 [<ffffffffa001f195>] ? _batadv_purge_orig+0x305/0x920 [batman_adv]
 [<ffffffff811745fd>] __asan_load8+0x5d/0x70
 [<ffffffffa001f195>] _batadv_purge_orig+0x305/0x920 [batman_adv]
 [<ffffffffa001f7c4>] batadv_purge_orig+0x14/0x40 [batman_adv]
 [<ffffffff8107fd62>] process_one_work+0x3e2/0x7e0
 [<ffffffff8107fccc>] ? process_one_work+0x34c/0x7e0
 [<ffffffff8107f980>] ? cancel_delayed_work_sync+0x10/0x10
 [<ffffffff810a98b5>] ? check_flags.part.26+0x65/0x280
 [<ffffffff810801e5>] worker_thread+0x85/0x720
 [<ffffffff81080160>] ? process_one_work+0x7e0/0x7e0
 [<ffffffff81088a53>] kthread+0x193/0x1b0
 [<ffffffff810888c0>] ? kthread_create_on_node+0x340/0x340
 [<ffffffff8108de9c>] ? finish_task_switch+0xdc/0x280
 [<ffffffff81745b32>] ret_from_fork+0x22/0x50
 [<ffffffff810888c0>] ? kthread_create_on_node+0x340/0x340
Memory state around the buggy address:
 ffff88000b9ac680: fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88000b9ac700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88000b9ac780: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
                                                       ^
 ffff88000b9ac800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88000b9ac880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


--LpQ9ahxlCli8rRTG--

--DIOMP1UsTsWJauNi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXLOnoAAoJEJ4aZjxxc6bKr14P/RJCj/j0mCtLjK/4ph3ZOn73
fWs9CUwxqFbpSMyzXF3Gej364aW6DyFA8afJMY03LelHQGR76EnZ871uddV6kE1w
1XfNgl2QNq/ntvPGkC05tYkn+gJZpZ6CqrFaCokwDOyFOLIa2t+j4mPloAFLvuu/
FZFvMECLZ93LHUVakjp5nDKD/RWeWG0P4dL42ZJoeF6k/Z6sFA/lEz052/mplFBG
jKYmMS9Wf00H8Q2LLPccgIGKsO2CSyYc3uE+JIqfnrH4cOWupOcjlt4RIaLbsWTu
PRjF9BiaX0MXHBm9ZCMypLlhu6OoTI06/i6n+mptL7O5ZOGT/MWlmiamnMZkdRYb
GTqHpaGLYx1kSsSOWmgnGz85eP+GopO46Bud9RdMzG9+Ll6CPGcykpMMuoFUm8nS
LyLKVNjJdVWZ/m4ql2/13of/3TyckOolYEL1aVtKoZvvpo0J5P0gk1kvs+aOdGKu
RFmdrSuOkqBlaJ0tsZ7cucLVqYkUluMKsUDrQr4zgMkPaTG9CPbLHTp1VTTijMRB
dkIfoFO2d3xneQKiRYsLK88NtycVnpeW4wCSnKhthYRiP0weTKyXAKEBRxJo4ezU
d/aaFWhJH15l/oJLjIz3c+dyHIoQLcplZcBNIlxleA6lhG0wGrvenE1rg+faG7sT
D/f8M61SK9h7+dNegVe/
=skdR
-----END PGP SIGNATURE-----

--DIOMP1UsTsWJauNi--
