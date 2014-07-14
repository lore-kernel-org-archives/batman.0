Return-Path: <linus.luessing@web.de>
Date: Tue, 15 Jul 2014 01:30:49 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20140714233048.GV2675@Linus-Debian>
References: <538314FE.9020808@mindeye.net> <20140714222812.GU2675@Linus-Debian>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20140714222812.GU2675@Linus-Debian>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Init and use batman
 interface with correc netns.
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

On Tue, Jul 15, 2014 at 12:28:13AM +0200, Linus Lüssing wrote:
> But there's one more issue I'm having with PATCH 2/2, I'm getting
> the following warning when doing an "init 0" in the LXC host:
> 
> ---
> [  248.679142] batman_adv: bat1: Removing interface: eth1
> [  248.685206] ------------[ cut here ]------------
> [  248.688746] WARNING: CPU: 0 PID: 2694 at fs/sysfs/dir.c:31
> sysfs_warn_dup+0x5c/0x68()
> [  248.692551] sysfs: cannot create duplicate filename '/devices/pci0000:00/0000:00:03.0/net/eth1/batman_adv'
> ...
> ---
> 
> Going to add the full calltrace to #179.

Or going to add it here, right away since #179 doesn't reference
PATCH 2/2 yet anyways.

After that LXC shutdown and calltrace, the batman_adv sysfs folder is missing
for eth1 on the upper host.

Not sure why batman-adv tries to re-register eth1 on the upper
host before having unregistered it from within the LXC host. Maybe
a race condition caused by the hard-if-registering event being
done immediately while the unregistering gets scheduled in a
worker queue?

Cheers, Linus

---

[  248.679142] batman_adv: bat1: Removing interface: eth1
[  248.685206] ------------[ cut here ]------------
[  248.688746] WARNING: CPU: 0 PID: 2694 at fs/sysfs/dir.c:31 sysfs_warn_dup+0x5c/0x68()
[  248.692551] sysfs: cannot create duplicate filename '/devices/pci0000:00/0000:00:03.0/net/eth1/batman_adv'
[  248.697806] Modules linked in: batman_adv(O) bridge stp llc crc32c_generic libcrc32c crc16 dm_crypt md_mod ppdev kvm_amd kvm snd_pcm snd_timer snd soundcore psmouse evdev serio_raw pcspkr 8139too parport_pc parport i2c_piix4 i2c_core 8139cp processor mii thermal_sys button ata_generic 9p fscache ata_piix virtio_pci libata scsi_mod floppy dm_mirror dm_region_hash dm_log dm_mod 9pnet_virtio virtio_ring virtio 9pnet
[  248.704734] CPU: 0 PID: 2694 Comm: lxc-start Tainted: G           O  3.16.0-rc2+ #1
[  248.705824] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2007
[  248.706606]  0000000000000000 0000000000000009 ffffffff81399ffb ffff88000b53f598
[  248.707653]  ffffffff8103c183 ffffffff81682700 ffffffff81168f78 ffffffff81682700
[  248.708707]  ffff88000e3e7000 ffff88000d1d6a60 ffff880000057b88 ffff88000e325068
[  248.709761] Call Trace:
[  248.710104]  [<ffffffff81399ffb>] ? dump_stack+0x41/0x51
[  248.710907]  [<ffffffff8103c183>] ? warn_slowpath_common+0x78/0x90
[  248.711827]  [<ffffffff81168f78>] ? sysfs_warn_dup+0x5c/0x68
[  248.712633]  [<ffffffff8103c233>] ? warn_slowpath_fmt+0x45/0x4a
[  248.713331]  [<ffffffff811667c3>] ? kernfs_path+0x46/0x52
[  248.714065]  [<ffffffff81168f78>] ? sysfs_warn_dup+0x5c/0x68
[  248.714842]  [<ffffffff81168fdf>] ? sysfs_create_dir_ns+0x5b/0x72
[  248.715705]  [<ffffffff811d5412>] ? kobject_add_internal+0xd2/0x269
[  248.716571]  [<ffffffff811d5769>] ? kobject_add+0x8e/0xa2
[  248.717189]  [<ffffffff811d57b1>] ? kobject_create_and_add+0x34/0x63
[  248.718034]  [<ffffffffa024d633>] ? batadv_sysfs_add_hardif+0x24/0xb4 [batman_adv]
[  248.719048]  [<ffffffffa024713a>] ? batadv_hard_if_event+0x112/0x2f6 [batman_adv]
[  248.720142]  [<ffffffff81057efd>] ? notifier_call_chain+0x2e/0x59
[  248.720974]  [<ffffffff812ddedd>] ? call_netdevice_notifiers+0xe/0x13
[  248.721833]  [<ffffffff812e281e>] ? dev_change_net_namespace+0x1c4/0x1f8
[  248.722778]  [<ffffffff812ece71>] ? do_setlink+0x8d/0x794
[  248.723587]  [<ffffffffa00037ae>] ? p9pdu_writef+0x39/0x3e [9pnet]
[  248.724468]  [<ffffffff812efb79>] ? rtnl_newlink+0x378/0x5c7
[  248.725240]  [<ffffffff812ef909>] ? rtnl_newlink+0x108/0x5c7
[  248.726060]  [<ffffffff810e37a3>] ? zone_statistics+0x41/0x74
[  248.726910]  [<ffffffff810d3ec8>] ? get_page_from_freelist+0x620/0x722
[  248.727796]  [<ffffffff812ef7ee>] ? rtnetlink_rcv_msg+0x17e/0x191
[  248.728635]  [<ffffffff812ef670>] ? __rtnl_unlock+0xc/0xc
[  248.729417]  [<ffffffff81305970>] ? netlink_rcv_skb+0x36/0x7c
[  248.730199]  [<ffffffff812eca1f>] ? rtnetlink_rcv+0x1f/0x28
[  248.730960]  [<ffffffff8130541e>] ? netlink_unicast+0xff/0x17f
[  248.731872]  [<ffffffff8130579d>] ? netlink_sendmsg+0x2ff/0x32d
[  248.732805]  [<ffffffff812cf42d>] ? sock_sendmsg+0x49/0x64
[  248.733585]  [<ffffffff8111ffba>] ? do_last+0x923/0xa0f
[  248.734285]  [<ffffffff81124848>] ? dput+0x19/0x150
[  248.734943]  [<ffffffff812cfdcd>] ? move_addr_to_kernel+0x2e/0x53
[  248.735772]  [<ffffffff812d91be>] ? verify_iovec+0x4c/0x9a
[  248.736530]  [<ffffffff812cfd15>] ? ___sys_sendmsg+0x1e7/0x271
[  248.737329]  [<ffffffff81304892>] ? netlink_autobind.isra.23+0xc6/0xe7
[  248.738197]  [<ffffffff81304c79>] ? netlink_bind+0xed/0x199
[  248.738945]  [<ffffffff812ce716>] ? move_addr_to_user+0x5f/0x90
[  248.739753]  [<ffffffff812ce853>] ? SYSC_getsockname+0x7b/0x8c
[  248.740539]  [<ffffffff812d00a1>] ? __sys_sendmsg+0x39/0x57
[  248.741312]  [<ffffffff8139e4d2>] ? system_call_fastpath+0x16/0x1b
[  248.742146] ---[ end trace 3d613ca14aa39b99 ]---
[  248.742814] ------------[ cut here ]------------
[  248.743450] WARNING: CPU: 0 PID: 2694 at lib/kobject.c:240 kobject_add_internal+0x1e1/0x269()
[  248.744598] kobject_add_internal failed for batman_adv with -EEXIST, don't try to register things with the same name in the same directory.
[  248.746324] Modules linked in: batman_adv(O) bridge stp llc crc32c_generic libcrc32c crc16 dm_crypt md_mod ppdev kvm_amd kvm snd_pcm snd_timer snd soundcore psmouse evdev serio_raw pcspkr 8139too parport_pc parport i2c_piix4 i2c_core 8139cp processor mii thermal_sys button ata_generic 9p fscache ata_piix virtio_pci libata scsi_mod floppy dm_mirror dm_region_hash dm_log dm_mod 9pnet_virtio virtio_ring virtio 9pnet
[  248.751820] CPU: 0 PID: 2694 Comm: lxc-start Tainted: G        W  O  3.16.0-rc2+ #1
[  248.752858] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2007
[  248.753636]  0000000000000000 0000000000000009 ffffffff81399ffb ffff88000b53f5d8
[  248.754664]  ffffffff8103c183 ffff88000e3e7000 ffffffff811d5521 ffff88000b53f5f8
[  248.755707]  ffff88000b43bdc0 00000000ffffffef ffff88000d042498 ffff88000e325068
[  248.756769] Call Trace:
[  248.757107]  [<ffffffff81399ffb>] ? dump_stack+0x41/0x51
[  248.757844]  [<ffffffff8103c183>] ? warn_slowpath_common+0x78/0x90
[  248.758680]  [<ffffffff811d5521>] ? kobject_add_internal+0x1e1/0x269
[  248.759553]  [<ffffffff8103c233>] ? warn_slowpath_fmt+0x45/0x4a
[  248.760372]  [<ffffffff811d5521>] ? kobject_add_internal+0x1e1/0x269
[  248.761290]  [<ffffffff811d5769>] ? kobject_add+0x8e/0xa2
[  248.762035]  [<ffffffff811d57b1>] ? kobject_create_and_add+0x34/0x63
[  248.762918]  [<ffffffffa024d633>] ? batadv_sysfs_add_hardif+0x24/0xb4 [batman_adv]
[  248.763979]  [<ffffffffa024713a>] ? batadv_hard_if_event+0x112/0x2f6 [batman_adv]
[  248.765012]  [<ffffffff81057efd>] ? notifier_call_chain+0x2e/0x59
[  248.765846]  [<ffffffff812ddedd>] ? call_netdevice_notifiers+0xe/0x13
[  248.766746]  [<ffffffff812e281e>] ? dev_change_net_namespace+0x1c4/0x1f8
[  248.767710]  [<ffffffff812ece71>] ? do_setlink+0x8d/0x794
[  248.768462]  [<ffffffffa00037ae>] ? p9pdu_writef+0x39/0x3e [9pnet]
[  248.769355]  [<ffffffff812efb79>] ? rtnl_newlink+0x378/0x5c7
[  248.770236]  [<ffffffff812ef909>] ? rtnl_newlink+0x108/0x5c7
[  248.770885]  [<ffffffff810e37a3>] ? zone_statistics+0x41/0x74
[  248.771609]  [<ffffffff810d3ec8>] ? get_page_from_freelist+0x620/0x722
[  248.772569]  [<ffffffff812ef7ee>] ? rtnetlink_rcv_msg+0x17e/0x191
[  248.773455]  [<ffffffff812ef670>] ? __rtnl_unlock+0xc/0xc
[  248.774187]  [<ffffffff81305970>] ? netlink_rcv_skb+0x36/0x7c
[  248.774960]  [<ffffffff812eca1f>] ? rtnetlink_rcv+0x1f/0x28
[  248.775677]  [<ffffffff8130541e>] ? netlink_unicast+0xff/0x17f
[  248.776491]  [<ffffffff8130579d>] ? netlink_sendmsg+0x2ff/0x32d
[  248.777292]  [<ffffffff812cf42d>] ? sock_sendmsg+0x49/0x64
[  248.778056]  [<ffffffff8111ffba>] ? do_last+0x923/0xa0f
[  248.778777]  [<ffffffff81124848>] ? dput+0x19/0x150
[  248.779558]  [<ffffffff812cfdcd>] ? move_addr_to_kernel+0x2e/0x53
[  248.780437]  [<ffffffff812d91be>] ? verify_iovec+0x4c/0x9a
[  248.781218]  [<ffffffff812cfd15>] ? ___sys_sendmsg+0x1e7/0x271
[  248.782006]  [<ffffffff81304892>] ? netlink_autobind.isra.23+0xc6/0xe7
[  248.782924]  [<ffffffff81304c79>] ? netlink_bind+0xed/0x199
[  248.783878]  [<ffffffff812ce716>] ? move_addr_to_user+0x5f/0x90
[  248.784732]  [<ffffffff812ce853>] ? SYSC_getsockname+0x7b/0x8c
[  248.785549]  [<ffffffff812d00a1>] ? __sys_sendmsg+0x39/0x57
[  248.786304]  [<ffffffff8139e4d2>] ? system_call_fastpath+0x16/0x1b
[  248.787103] ---[ end trace 3d613ca14aa39b9a ]---
[  248.787773] kobject_create_and_add: kobject_add error: -17
[  248.788529] batman_adv: eth1: Can't add sysfs directory: eth1/batman_adv

---
