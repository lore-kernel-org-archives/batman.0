Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 29 Nov 2015 01:37:21 +0100
Message-ID: <29580650.TaMGDDyOBU@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1915428.CvDHVItrSJ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] Invalid memory access during if add/del with
	multiple interfaces
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart1915428.CvDHVItrSJ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

I've just configured two kvm nodes [1] and interconnected them via ethernet
and gretap. The used batman-adv version was v2015.1-115-g5b0b10e.

The first node initialized via:

    insmod /host/batman-adv/net/batman-adv/batman-adv.ko
    /host/batctl/batctl if add eth0
    ifconfig bat0 up
    
    ip link add testgre type gretap remote 192.168.2.52 local 192.168.2.51 ttl 255
    ifconfig testgre 192.168.3.51
    ifconfig bat0 192.168.4.51
    /host/batctl/batctl if add testgre


The second node was initialized via:

    insmod /host/batman-adv/net/batman-adv/batman-adv.ko
    /host/batctl/batctl if add eth0
    ifconfig bat0 up
    
    ip link add testgre type gretap remote 192.168.2.51 local 192.168.2.52 ttl 255
    ifconfig testgre 192.168.3.52
    ifconfig bat0 192.168.4.52
    /host/batctl/batctl if add testgre


The workload of the second node was generated via:

    ping 192.168.4.51

The first node was running:

    while true; do /host/batctl/batctl if del testgre; /host/batctl/batctl if add testgre; done

Later (when the invalid memory access happened) it was switched to

    while true; do /host/batctl/batctl if del eth0; /host/batctl/batctl if add eth0; done

The output on the first node was:

    batman_adv: bat0: Interface deactivated: eth0
    batman_adv: bat0: Removing interface: eth0
    ==================================================================
    BUG: KASAN: slab-out-of-bounds in memcpy+0x1d/0x40 at addr ffff880007e1e680
    Read of size 8 by task batctl/1422
    =============================================================================
    BUG kmalloc-16 (Tainted: G           O   ): kasan: bad access detected
    -----------------------------------------------------------------------------
    
    Disabling lock debugging due to kernel taint
    INFO: Allocated in batadv_iv_ogm_orig_add_if+0x68/0x1bf [batman_adv] age=7876 cpu=0 pid=1417
            ___slab_alloc.constprop.28+0x36f/0x3a0
            __slab_alloc.constprop.27+0x40/0x90
            __kmalloc+0x190/0x1d0
            batadv_iv_ogm_orig_add_if+0x68/0x1bf [batman_adv]
            batadv_orig_hash_add_if+0x1db/0x31e [batman_adv]
            batadv_hardif_enable_interface+0x301/0x812 [batman_adv]
            batadv_store_mesh_iface+0x1d8/0x206 [batman_adv]
            kobj_attr_store+0x36/0x70
            sysfs_kf_write+0x110/0x180
            kernfs_fop_write+0x270/0x390
            __vfs_write+0xea/0x400
            vfs_write+0x13d/0x480
            SyS_write+0x11b/0x250
            entry_SYSCALL_64_fastpath+0x12/0x72
    INFO: Freed in batadv_iv_ogm_orig_del_if+0x103/0x2b1 [batman_adv] age=7904 cpu=0 pid=1410
            __slab_free+0x310/0x440
            kfree+0x19b/0x1b0
            batadv_iv_ogm_orig_del_if+0x103/0x2b1 [batman_adv]
            batadv_orig_hash_del_if+0x227/0x5a1 [batman_adv]
            batadv_hardif_disable_interface+0x16d/0x58e [batman_adv]
            batadv_store_mesh_iface+0x18d/0x206 [batman_adv]
            kobj_attr_store+0x36/0x70
            sysfs_kf_write+0x110/0x180
            kernfs_fop_write+0x270/0x390
            __vfs_write+0xea/0x400
            vfs_write+0x13d/0x480
            SyS_write+0x11b/0x250
            entry_SYSCALL_64_fastpath+0x12/0x72
    INFO: Slab 0xffffea00001f8780 objects=12 used=6 fp=0xffff880007e1ea00 flags=0x4000000000000080
    INFO: Object 0xffff880007e1e640 @offset=1600 fp=0x          (null)
    
    Bytes b4 ffff880007e1e630: 00 00 00 00 88 05 00 00 83 2b 01 00 01 00 00 00  .........+......
    Object ffff880007e1e640: 00 00 00 00 00 00 00 00 ff ff ff 7f 00 00 00 00  ................
    CPU: 1 PID: 1422 Comm: batctl Tainted: G    B      O    4.4.0-rc2-next-20151127 #20
    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Debian-1.8.2-1 04/01/2014
     ffff880007e1e640 00000000beca4caa ffff88000aed7948 ffffffff815fc597
     ffff88000c803c00 ffff88000aed7978 ffffffff812e2204 ffff88000c803c00
     ffffea00001f8780 ffff880007e1e640 ffff88000b91d850 ffff88000aed79a0
    Call Trace:
     [<ffffffff815fc597>] dump_stack+0x4b/0x64
     [<ffffffff812e2204>] print_trailer+0xf4/0x150
     [<ffffffff812e6d5f>] object_err+0x2f/0x40
     [<ffffffff812e88db>] kasan_report_error+0x22b/0x550
     [<ffffffff812e4c1d>] ? __slab_alloc.constprop.27+0x4d/0x90
     [<ffffffffa00005be>] ? batadv_iv_ogm_orig_del_if+0x67/0x2b1 [batman_adv]
     [<ffffffff812e9173>] kasan_report+0x53/0x60
     [<ffffffff812e815d>] ? memcpy+0x1d/0x40
     [<ffffffff812e7c1a>] __asan_loadN+0x12a/0x180
     [<ffffffff812e815d>] memcpy+0x1d/0x40
     [<ffffffffa000064e>] batadv_iv_ogm_orig_del_if+0xf7/0x2b1 [batman_adv]
     [<ffffffffa0000557>] ? batadv_iv_ogm_orig_add_if+0x1bf/0x1bf [batman_adv]
     [<ffffffffa002af5c>] batadv_orig_hash_del_if+0x227/0x5a1 [batman_adv]
     [<ffffffffa002ae69>] ? batadv_orig_hash_del_if+0x134/0x5a1 [batman_adv]
     [<ffffffffa001d20a>] batadv_hardif_disable_interface+0x16d/0x58e [batman_adv]
     [<ffffffffa0038108>] batadv_store_mesh_iface+0x18d/0x206 [batman_adv]
     [<ffffffff81601400>] ? kobj_attr_show+0x60/0x60
     [<ffffffff81601436>] kobj_attr_store+0x36/0x70
     [<ffffffff8140c3e3>] ? sysfs_file_ops+0x113/0x170
     [<ffffffff8140c550>] sysfs_kf_write+0x110/0x180
     [<ffffffff8140c440>] ? sysfs_file_ops+0x170/0x170
     [<ffffffff81409ee0>] kernfs_fop_write+0x270/0x390
     [<ffffffff812f328a>] __vfs_write+0xea/0x400
     [<ffffffff812f31a0>] ? __vfs_read+0x3f0/0x3f0
     [<ffffffff811a5ed3>] ? rcu_read_lock_sched_held+0xe3/0x120
     [<ffffffff811a6480>] ? rcu_sync_lockdep_assert+0x70/0xb0
     [<ffffffff81163ffd>] ? update_fast_ctr+0x1d/0xa0
     [<ffffffff811640f2>] ? percpu_down_read+0x52/0x90
     [<ffffffff812fc15f>] ? __sb_start_write+0xaf/0xf0
     [<ffffffff812f46ed>] vfs_write+0x13d/0x480
     [<ffffffff81343c1e>] ? __fget_light+0x13e/0x1f0
     [<ffffffff812f6e3b>] SyS_write+0x11b/0x250
     [<ffffffff812f6d20>] ? SyS_read+0x250/0x250
     [<ffffffff810020e4>] ? lockdep_sys_exit_thunk+0x12/0x14
     [<ffffffff81d938f2>] entry_SYSCALL_64_fastpath+0x12/0x72
    Memory state around the buggy address:
     ffff880007e1e580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
     ffff880007e1e600: fc fc fc fc fc fc fc fc 00 00 fc fc fc fc fc fc
    >ffff880007e1e680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                       ^
     ffff880007e1e700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
     ffff880007e1e780: fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc fc
    ==================================================================
    ==================================================================
    BUG: KASAN: slab-out-of-bounds in memcpy+0x1d/0x40 at addr ffff880007e1e540
    Read of size 8 by task batctl/1422
    =============================================================================
    BUG kmalloc-16 (Tainted: G    B      O   ): kasan: bad access detected
    -----------------------------------------------------------------------------
    
    INFO: Allocated in batadv_iv_ogm_orig_add_if+0x68/0x1bf [batman_adv] age=7900 cpu=0 pid=1417
            ___slab_alloc.constprop.28+0x36f/0x3a0
            __slab_alloc.constprop.27+0x40/0x90
            __kmalloc+0x190/0x1d0
            batadv_iv_ogm_orig_add_if+0x68/0x1bf [batman_adv]
            batadv_orig_hash_add_if+0x1db/0x31e [batman_adv]
            batadv_hardif_enable_interface+0x301/0x812 [batman_adv]
            batadv_store_mesh_iface+0x1d8/0x206 [batman_adv]
            kobj_attr_store+0x36/0x70
            sysfs_kf_write+0x110/0x180
            kernfs_fop_write+0x270/0x390
            __vfs_write+0xea/0x400
            vfs_write+0x13d/0x480
            SyS_write+0x11b/0x250
            entry_SYSCALL_64_fastpath+0x12/0x72
    INFO: Freed in batadv_iv_ogm_orig_del_if+0x103/0x2b1 [batman_adv] age=7905 cpu=0 pid=1416
            __slab_free+0x310/0x440
            kfree+0x19b/0x1b0
            batadv_iv_ogm_orig_del_if+0x103/0x2b1 [batman_adv]
            batadv_orig_hash_del_if+0x227/0x5a1 [batman_adv]
            batadv_hardif_disable_interface+0x16d/0x58e [batman_adv]
            batadv_store_mesh_iface+0x18d/0x206 [batman_adv]
            kobj_attr_store+0x36/0x70
            sysfs_kf_write+0x110/0x180
            kernfs_fop_write+0x270/0x390
            __vfs_write+0xea/0x400
            vfs_write+0x13d/0x480
            SyS_write+0x11b/0x250
            entry_SYSCALL_64_fastpath+0x12/0x72
    INFO: Slab 0xffffea00001f8780 objects=12 used=5 fp=0xffff880007e1e640 flags=0x4000000000000080
    INFO: Object 0xffff880007e1e500 @offset=1280 fp=0xffffffffffffffff
    
    Bytes b4 ffff880007e1e4f0: 00 00 00 00 89 05 00 00 85 2b 01 00 01 00 00 00  .........+......
    Object ffff880007e1e500: ff ff ff ff ff ff ff ff 00 00 00 00 00 00 00 00  ................
    CPU: 1 PID: 1422 Comm: batctl Tainted: G    B      O    4.4.0-rc2-next-20151127 #20
    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Debian-1.8.2-1 04/01/2014
     ffff880007e1e500 00000000beca4caa ffff88000aed7948 ffffffff815fc597
     ffff88000c803c00 ffff88000aed7978 ffffffff812e2204 ffff88000c803c00
     ffffea00001f8780 ffff880007e1e500 ffff88000ad885a0 ffff88000aed79a0
    Call Trace:
     [<ffffffff815fc597>] dump_stack+0x4b/0x64
     [<ffffffff812e2204>] print_trailer+0xf4/0x150
     [<ffffffff812e6d5f>] object_err+0x2f/0x40
     [<ffffffff812e88db>] kasan_report_error+0x22b/0x550
     [<ffffffff812e9173>] kasan_report+0x53/0x60
     [<ffffffff812e815d>] ? memcpy+0x1d/0x40
     [<ffffffff812e7c1a>] __asan_loadN+0x12a/0x180
     [<ffffffff812e815d>] memcpy+0x1d/0x40
     [<ffffffffa000064e>] batadv_iv_ogm_orig_del_if+0xf7/0x2b1 [batman_adv]
     [<ffffffffa0000557>] ? batadv_iv_ogm_orig_add_if+0x1bf/0x1bf [batman_adv]
     [<ffffffffa002af5c>] batadv_orig_hash_del_if+0x227/0x5a1 [batman_adv]
     [<ffffffffa002ae69>] ? batadv_orig_hash_del_if+0x134/0x5a1 [batman_adv]
     [<ffffffffa001d20a>] batadv_hardif_disable_interface+0x16d/0x58e [batman_adv]
     [<ffffffffa0038108>] batadv_store_mesh_iface+0x18d/0x206 [batman_adv]
     [<ffffffff81601400>] ? kobj_attr_show+0x60/0x60
     [<ffffffff81601436>] kobj_attr_store+0x36/0x70
     [<ffffffff8140c3e3>] ? sysfs_file_ops+0x113/0x170
     [<ffffffff8140c550>] sysfs_kf_write+0x110/0x180
     [<ffffffff8140c440>] ? sysfs_file_ops+0x170/0x170
     [<ffffffff81409ee0>] kernfs_fop_write+0x270/0x390
     [<ffffffff812f328a>] __vfs_write+0xea/0x400
     [<ffffffff812f31a0>] ? __vfs_read+0x3f0/0x3f0
     [<ffffffff811a5ed3>] ? rcu_read_lock_sched_held+0xe3/0x120
     [<ffffffff811a6480>] ? rcu_sync_lockdep_assert+0x70/0xb0
     [<ffffffff81163ffd>] ? update_fast_ctr+0x1d/0xa0
     [<ffffffff811640f2>] ? percpu_down_read+0x52/0x90
     [<ffffffff812fc15f>] ? __sb_start_write+0xaf/0xf0
     [<ffffffff812f46ed>] vfs_write+0x13d/0x480
     [<ffffffff81343c1e>] ? __fget_light+0x13e/0x1f0
     [<ffffffff812f6e3b>] SyS_write+0x11b/0x250
     [<ffffffff812f6d20>] ? SyS_read+0x250/0x250
     [<ffffffff810020e4>] ? lockdep_sys_exit_thunk+0x12/0x14
     [<ffffffff81d938f2>] entry_SYSCALL_64_fastpath+0x12/0x72
    Memory state around the buggy address:
     ffff880007e1e400: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
     ffff880007e1e480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
    >ffff880007e1e500: 00 00 fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                               ^
     ffff880007e1e580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
     ffff880007e1e600: fc fc fc fc fc fc fc fc fb fb fc fc fc fc fc fc
    ==================================================================
    batman_adv: bat0: Adding interface: eth0

[...]

    ==================================================================
    BUG: KASAN: slab-out-of-bounds in batadv_iv_ogm_slide_own_bcast_window+0x298/0x376 [batman_adv] at addr fff
    
    Write of size 1 by task kworker/u4:2/67
    =============================================================================
    BUG kmalloc-8 (Tainted: G    B      O   ): kasan: bad access detected
    -----------------------------------------------------------------------------
    
    INFO: Allocated in batadv_iv_ogm_orig_del_if+0x1bc/0x392 [batman_adv] age=307 cpu=1 pid=399
     ___slab_alloc.constprop.28+0x36f/0x3a0
     __slab_alloc.constprop.27+0x40/0x90
     __kmalloc+0x190/0x1d0
     batadv_iv_ogm_orig_del_if+0x1bc/0x392 [batman_adv]
     batadv_orig_hash_del_if+0x227/0x5a1 [batman_adv]
     batadv_hardif_disable_interface+0x16d/0x58e [batman_adv]
     batadv_softif_slave_del+0x55/0x8b [batman_adv]
     do_setlink+0x9b8/0x2900
     rtnl_newlink+0xb05/0x1260
     rtnetlink_rcv_msg+0x241/0x680
     netlink_rcv_skb+0x236/0x340
     rtnetlink_rcv+0x25/0x30
     netlink_unicast+0x3f6/0x580
     netlink_sendmsg+0x89e/0xb30
     sock_sendmsg+0x70/0xc0
     ___sys_sendmsg+0x583/0x670
    INFO: Freed in batadv_iv_ogm_orig_add_if+0x1dd/0x22b [batman_adv] age=513 cpu=1 pid=398
     __slab_free+0x310/0x440
     kfree+0x19b/0x1b0
     batadv_iv_ogm_orig_add_if+0x1dd/0x22b [batman_adv]
     batadv_orig_hash_add_if+0x1db/0x31e [batman_adv]
     batadv_hardif_enable_interface+0x301/0x812 [batman_adv]
     batadv_softif_slave_add+0x54/0x87 [batman_adv]
     do_setlink+0x1bbd/0x2900
     rtnl_newlink+0xb05/0x1260
     rtnetlink_rcv_msg+0x241/0x680
     netlink_rcv_skb+0x236/0x340
     rtnetlink_rcv+0x25/0x30
     netlink_unicast+0x3f6/0x580
     netlink_sendmsg+0x89e/0xb30
     sock_sendmsg+0x70/0xc0
     ___sys_sendmsg+0x583/0x670
     __sys_sendmsg+0xcd/0x160
    INFO: Slab 0xffffea0000007200 objects=13 used=11 fp=0xffff8800001c8af8 flags=0x0080
    INFO: Object 0xffff8800001c83a8 @offset=936 fp=0xffff8800001c8429
    
    Bytes b4 ffff8800001c8398: 01 00 00 00 8b 01 00 00 85 f2 fe ff 00 00 00 00  ................
    Object ffff8800001c83a8: 29 84 1c 00 00 88 ff ff                          ).......
    CPU: 0 PID: 67 Comm: kworker/u4:2 Tainted: G    B      O    4.4.0-rc2-next-20151127 #20
    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Debian-1.8.2-1 04/01/2014
    Workqueue: bat_events batadv_send_outstanding_bat_ogm_packet [batman_adv]
     ffff8800001c83a8 00000000fce739f9 ffff88000bb97990 ffffffff815fc597
     ffff88000c802200 ffff88000bb979c0 ffffffff812e2204 ffff88000c802200
     ffffea0000007200 ffff8800001c83a8 0000000000000026 ffff88000bb979e8
    Call Trace:
     [<ffffffff815fc597>] dump_stack+0x4b/0x64
     [<ffffffff812e2204>] print_trailer+0xf4/0x150
     [<ffffffff812e6d5f>] object_err+0x2f/0x40
     [<ffffffff812e88db>] kasan_report_error+0x22b/0x550
     [<ffffffff812e8e8c>] __asan_report_store1_noabort+0x5c/0x70
     [<ffffffffa0007401>] ? _GLOBAL__sub_I_65535_1_batadv_ring_buffer_set+0x13/0x17 [batman_adv]
     [<ffffffffa00036a1>] ? batadv_iv_ogm_slide_own_bcast_window+0x298/0x376 [batman_adv]
     [<ffffffffa00036a1>] batadv_iv_ogm_slide_own_bcast_window+0x298/0x376 [batman_adv]
     [<ffffffffa0003510>] ? batadv_iv_ogm_slide_own_bcast_window+0x107/0x376 [batman_adv]
     [<ffffffffa0003a84>] batadv_iv_ogm_schedule+0x305/0x608 [batman_adv]
     [<ffffffffa00037d2>] ? batadv_iv_ogm_schedule+0x53/0x608 [batman_adv]
     [<ffffffffa0032dfe>] batadv_schedule_bat_ogm+0xc8/0xcf [batman_adv]
     [<ffffffffa0033c33>] batadv_send_outstanding_bat_ogm_packet+0x25f/0x2ac [batman_adv]
     [<ffffffff810edb04>] process_one_work+0x674/0x1090
     [<ffffffff810eda87>] ? process_one_work+0x5f7/0x1090
     [<ffffffff8116de0d>] ? trace_hardirqs_on+0xd/0x10
     [<ffffffff810ed490>] ? cancel_delayed_work_sync+0x10/0x10
     [<ffffffff810ee5f2>] worker_thread+0xd2/0xdf0
     [<ffffffff810ee520>] ? process_one_work+0x1090/0x1090
     [<ffffffff810fdfee>] kthread+0x21e/0x2e0
     [<ffffffff810fddd0>] ? kthread_create_on_node+0x400/0x400
     [<ffffffff81109639>] ? finish_task_switch+0x1c9/0x5b0
     [<ffffffff810fddd0>] ? kthread_create_on_node+0x400/0x400
     [<ffffffff81d93c5f>] ret_from_fork+0x3f/0x70
     [<ffffffff810fddd0>] ? kthread_create_on_node+0x400/0x400
    Memory state around the buggy address:
     ffff8800001c8280: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
     ffff8800001c8300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
    >ffff8800001c8380: fc fc fc fc fc 01 fc fc fc fc fc fc fc fc fc fc
                                      ^
     ffff8800001c8400: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
     ffff8800001c8480: fc fc fc fc fc fc fc fc fc fc fc fc 01 fc fc fc
    ==================================================================

This was repeated without rebooting the node and caused following error:

    batman_adv: bat0: Removing interface: eth0
    kasan: CONFIG_KASAN_INLINE enabled
    kasan: GPF could be caused by NULL-ptr deref or user memory accessgeneral protection fault: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN
    Modules linked in: batman_adv(O)
    CPU: 0 PID: 2033 Comm: batctl Tainted: G    B      O    4.4.0-rc2-next-20151127 #20
    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Debian-1.8.2-1 04/01/2014
    task: ffff88000bb6c5c0 ti: ffff880007df0000 task.ti: ffff880007df0000
    RIP: 0010:[<ffffffffa0033e65>]  [<ffffffffa0033e65>] batadv_purge_outstanding_packets+0x332/0x36a [batman_adv]
    RSP: 0018:ffff880007df7b38  EFLAGS: 00010a02
    RAX: 1bd5a00000000020 RBX: dead000000000100 RCX: 0000000000000014
    RDX: 0000000000000004 RSI: 0000000000000000 RDI: ffff88000ac48100
    RBP: ffff880007df7b78 R08: ffffffffa0000000 R09: 0000000000000000
    R10: 0000000000000000 R11: 0000000000000001 R12: ffff88000bb72fd0
    R13: dffffc0000000000 R14: dead000000000100 R15: ffff88000ac49650
    FS:  00007fa3b4a3a700(0000) GS:ffff88000ce00000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
    CR2: 000000000040369f CR3: 000000000aec6000 CR4: 00000000000006b0
    Stack:
     ffff88000ba02980 ffff88000ba02aa8 ffff88000ba02ac0 ffff88000bb72fd0
     ffff88000ba02980 ffff88000bb73040 ffff88000ae77c90 ffff88000ba02140
     ffff880007df7be0 ffffffffa001d4a4 ffffffffa001d211 ffffffffa005a940
    Call Trace:
     [<ffffffffa001d4a4>] batadv_hardif_disable_interface+0x407/0x58e [batman_adv]
     [<ffffffffa001d211>] ? batadv_hardif_disable_interface+0x174/0x58e [batman_adv]
     [<ffffffffa0038108>] batadv_store_mesh_iface+0x18d/0x206 [batman_adv]
     [<ffffffff81601400>] ? kobj_attr_show+0x60/0x60
     [<ffffffff81601436>] kobj_attr_store+0x36/0x70
     [<ffffffff8140c550>] sysfs_kf_write+0x110/0x180
     [<ffffffff8140c440>] ? sysfs_file_ops+0x170/0x170
     [<ffffffff81409ee0>] kernfs_fop_write+0x270/0x390
     [<ffffffff812f328a>] __vfs_write+0xea/0x400
     [<ffffffff812f31a0>] ? __vfs_read+0x3f0/0x3f0
     [<ffffffff812e5957>] ? __slab_free+0x397/0x440
     [<ffffffff812fc15f>] ? __sb_start_write+0xaf/0xf0
     [<ffffffff811a641d>] ? rcu_sync_lockdep_assert+0xd/0xb0
     [<ffffffff81163ffd>] ? update_fast_ctr+0x1d/0xa0
     [<ffffffff811640f2>] ? percpu_down_read+0x52/0x90
     [<ffffffff812fc15f>] ? __sb_start_write+0xaf/0xf0
     [<ffffffff812f46ed>] vfs_write+0x13d/0x480
     [<ffffffff81343c1e>] ? __fget_light+0x13e/0x1f0
     [<ffffffff812f6e3b>] SyS_write+0x11b/0x250
     [<ffffffff812f6d20>] ? SyS_read+0x250/0x250
     [<ffffffff810020e4>] ? lockdep_sys_exit_thunk+0x12/0x14
     [<ffffffff81d938f2>] entry_SYSCALL_64_fastpath+0x12/0x72
    Code: 00 ad de 48 89 03 48 b8 00 02 00 00 00 00 ad de 48 89 43 08 48 89 df e8 62 ee ff ff 4d 85 f6 74 2a 4c 89 f3 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 df e8 dc 4e 2b e1 4c 8b 33 4d 85 e4
    RIP  [<ffffffffa0033e65>] batadv_purge_outstanding_packets+0x332/0x36a [batman_adv]
     RSP <ffff880007df7b38>
    ---[ end trace 761c71262b1ed40c ]---
    Kernel panic - not syncing: Fatal exception in interrupt
    Kernel Offset: disabled


It also happened when using the rtnetlink interface instead of batctl/sysfs:

    while true; do ip link set nomaster dev eth0; ip link set master bat0 dev eth0; done

Kind regards,
	Sven

[1] https://www.open-mesh.org/projects/open-mesh/wiki/Emulation_Debug/7
    + CONFIG_NET_IPGRE_DEMUX=y
    + CONFIG_NET_IP_TUNNEL=y
    + CONFIG_NET_IPGRE=y

--nextPart1915428.CvDHVItrSJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWWkjBAAoJEF2HCgfBJntGMc4P/RtkbYLzhiRhtRCACAMRvzHs
ZZwl1WlK5MR18g6FEiUnCmQah4f306ReI6avnq12jcQ7+a5yek9PYl2g19Z5rzBh
raGNBlP2JbmMRhyudF6fPS2wV6TOH1EJSeA3x1BHVWyqvO7ketyVrQ1rSGr5TNU5
we2laW2EByHxA/jQpi4lgRHznsC4HgFWvHqXhrA+D6rvIUPkk5RKxhoVefTi8E+X
MmKcBQXi5BetzApwKZ8XdkJB8gk/o6xqsMhcafO5VRbAlww46PdPe1nHhoGnJ7Sc
3VVRrpLRZ8f05byWpTPyOqbaosLjXe0sidyPN6bC5YVwUVtRHRnZpCnhGfDK2d38
yzudjIzdZgSzswVCtyTGqWUiNMk2GVOQleYfyljmStS4nMl/t+gc6/0Lx/lQiW9u
vhsBhZ7pRW4ZTEM4vphGPsyNeHA913xkheY2Rp7/NxKz7vHGVy+BO0FPaPRBW+NH
4sKmpUIlGnSoq//iMku8+serq9KaeC9rB9y6MxBMpsCVeRPLBPuCNgpid+1HVXgC
Su1NCskF2T5DGPZ24ws7GnKRJQFa5H1WXhCUYig2HjNmwGVe8SFjdj2ZKmP8MtZq
GylJYe6GZ0Qnxbb8ZFiOnYE5gucRLhVm9rbxAwdoE5kkkj0JrlVFZp65QblCpm0j
Z4HmC3AZtHDC12n3dxxG
=otPW
-----END PGP SIGNATURE-----

--nextPart1915428.CvDHVItrSJ--

