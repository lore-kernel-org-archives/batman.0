Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Thu, 15 Aug 2013 15:13:07 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130815131307.GA2042@pandem0nium>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] Regression in VLAN sysfs patches
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
To: Antonio Quartulli <ordex@autistici.org>, b.a.t.m.a.n@lists.open-mesh.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

it seems there is an regression in the VLAN sysfs patches. I've tracked
the issue a little bit, it seems to be somewhere between:

6f27447 Antonio Quartulli  batman-adv: fix vlan compat code (broken)

=2E.. (few more patches i can't test because vlan compat is broken)

cc14598 Linus L=C3=BCssing  batman-adv: (style) fix for switched vid-ifiind=
ex parameter order (works)

The regression is probably in some of Antonios VLAN/sysfs patches.

It can be triggered by calling:

ifconfig bat0 down ; ifconfig bat0 up

Which will lead to a WARNING [1]. This can be reproduced every time
I call it. Note that I've not explicitly configured a VLAN on bat0,
this is automatically created/added. I'm using a fairly old OpenWRT
revision (29637) on kernel 2.6.39.4 here in virtual machines.

Cheers,
	Simon

[1]

[   39.317111] 8021q: adding VLAN 0 to HW filter on device bat0
[   39.322208] ------------[ cut here ]------------
[   39.324213] WARNING: at fs/sysfs/dir.c:455 sysfs_add_one+0x8b/0xb0()
[   39.325378] sysfs: cannot create duplicate filename '/devices/virtual/ne=
t/bat0/mesh/vlan0'
[   39.326955] Modules linked in: virtio_net batman_adv ebt_snat ebt_dnat e=
bt_arpreply ebt_ip ebt_arp ebt_redirect ebt_mark ebt_vlan ebt_stp ebt_pktty=
pe ebt_mark_m ebt_limit ebt_among ebt_802_3 ebtable_nat ebtable_filter ebta=
ble_broute nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp xt_strin=
g xt_layer7 ipt_MASQUERADE iptable_nat nf_nat xt_CT xt_conntrack xt_NOTRACK=
 iptable_raw xt_state nf_conntrack_ipv4 nf_defrag_ipv4 nf_conntrack ipt_REJ=
ECT xt_TCPMSS ipt_LOG xt_comment xt_multiport xt_mac xt_limit iptable_mangl=
e iptable_filter ts_fsm ts_bm ts_kmp libcrc32c ipv6 virtio_rng crc32c crypt=
o_hash crypto_algapi
[   39.340649] Pid: 1166, comm: ifconfig Not tainted 2.6.39.4 #180
[   39.342140] Call Trace:
[   39.342686]  [<c10d557b>] ? sysfs_add_one+0x8b/0xb0
[   39.343899]  [<c10284af>] warn_slowpath_common+0x5f/0x80
[   39.345480]  [<c10d557b>] ? sysfs_add_one+0x8b/0xb0
[   39.347153]  [<c102854e>] warn_slowpath_fmt+0x2e/0x30
[   39.348504]  [<c10d557b>] sysfs_add_one+0x8b/0xb0
[   39.349761]  [<c10d55fb>] create_dir+0x5b/0x90
[   39.351197]  [<c10d56ee>] sysfs_create_dir+0x8e/0xa0
[   39.352558]  [<c11386c5>] kobject_add_internal+0xc5/0x1d0
[   39.353945]  [<c1138ad5>] kobject_add+0x75/0x90
[   39.355177]  [<c1138c86>] kobject_create_and_add+0x36/0x70
[   39.356550]  [<c4b8293e>] batadv_sysfs_add_vlan+0x62/0x216 [batman_adv]
[   39.358314]  [<c108ce09>] ? __kmalloc+0x119/0x130
[   39.359554]  [<c4b8051d>] batadv_softif_create_vlan+0xb6/0xa25 [batman_a=
dv]
[   39.361571]  [<c4b806b9>] batadv_softif_create_vlan+0x252/0xa25 [batman_=
adv]
[   39.363355]  [<c4b80672>] batadv_softif_create_vlan+0x20b/0xa25 [batman_=
adv]
[   39.365227]  [<c127f925>] vlan_device_event+0xc5/0x510
[   39.366578]  [<c126f39c>] ? packet_notifier+0x19c/0x1b0
[   39.368010]  [<c126f200>] ? packet_dev_mc+0xd0/0xd0
[   39.369239]  [<c10425a0>] notifier_call_chain+0x30/0x60
[   39.370600]  [<c104266a>] raw_notifier_call_chain+0x1a/0x20
[   39.372089]  [<c120d04e>] call_netdevice_notifiers+0x4e/0x60
[   39.373468]  [<c121b855>] ? rtmsg_ifinfo+0xb5/0xe0
[   39.374713]  [<c121055e>] __dev_notify_flags+0x2e/0x70
[   39.376240]  [<c12105e3>] dev_change_flags+0x43/0x60
[   39.377803]  [<c1258665>] devinet_ioctl+0x285/0x670
[   39.378985]  [<c1210ec5>] ? dev_ioctl+0x665/0x6c0
[   39.379871]  [<c1210be5>] ? dev_ioctl+0x385/0x6c0
[   39.380797]  [<c12597f2>] inet_ioctl+0x72/0xa0
[   39.381689]  [<c11fea88>] sock_ioctl+0x218/0x250
[   39.382603]  [<c11fe870>] ? sock_fasync+0x80/0x80
[   39.383550]  [<c109e09e>] do_vfs_ioctl+0x4ee/0x530
[   39.384488]  [<c108df28>] ? fd_install+0x48/0x60
[   39.385606]  [<c11ff738>] ? sys_socket+0x48/0x70
[   39.386665]  [<c120054a>] ? sys_socketcall+0x6a/0x270
[   39.387666]  [<c109e119>] sys_ioctl+0x39/0x60
[   39.388541]  [<c128d325>] syscall_call+0x7/0xb
[   39.389417] ---[ end trace c59b34f09c69e69f ]---
[   39.390323] kobject_add_internal failed for vlan0 with -EEXIST, don't tr=
y to register things with the same name in the same directory.
[   39.392757] Pid: 1166, comm: ifconfig Tainted: G        W   2.6.39.4 #180
[   39.394234] Call Trace:
[   39.395176]  [<c128a7fc>] ? printk+0x18/0x1c
[   39.396080]  [<c11387a8>] kobject_add_internal+0x1a8/0x1d0
[   39.397123]  [<c1138ad5>] kobject_add+0x75/0x90
[   39.398037]  [<c1138c86>] kobject_create_and_add+0x36/0x70
[   39.399241]  [<c4b8293e>] batadv_sysfs_add_vlan+0x62/0x216 [batman_adv]
[   39.400455]  [<c108ce09>] ? __kmalloc+0x119/0x130
[   39.401382]  [<c4b8051d>] batadv_softif_create_vlan+0xb6/0xa25 [batman_a=
dv]
[   39.402634]  [<c4b806b9>] batadv_softif_create_vlan+0x252/0xa25 [batman_=
adv]
[   39.404345]  [<c4b80672>] batadv_softif_create_vlan+0x20b/0xa25 [batman_=
adv]
[   39.405675]  [<c127f925>] vlan_device_event+0xc5/0x510
[   39.406671]  [<c126f39c>] ? packet_notifier+0x19c/0x1b0
[   39.407821]  [<c126f200>] ? packet_dev_mc+0xd0/0xd0
[   39.408836]  [<c10425a0>] notifier_call_chain+0x30/0x60
[   39.410132]  [<c104266a>] raw_notifier_call_chain+0x1a/0x20
[   39.411492]  [<c120d04e>] call_netdevice_notifiers+0x4e/0x60
[   39.412554]  [<c121b855>] ? rtmsg_ifinfo+0xb5/0xe0
[   39.413485]  [<c121055e>] __dev_notify_flags+0x2e/0x70
[   39.414473]  [<c12105e3>] dev_change_flags+0x43/0x60
[   39.415752]  [<c1258665>] devinet_ioctl+0x285/0x670
[   39.416716]  [<c1210ec5>] ? dev_ioctl+0x665/0x6c0
[   39.417651]  [<c1210be5>] ? dev_ioctl+0x385/0x6c0
[   39.418691]  [<c12597f2>] inet_ioctl+0x72/0xa0
[   39.419606]  [<c11fea88>] sock_ioctl+0x218/0x250
[   39.420642]  [<c11fe870>] ? sock_fasync+0x80/0x80
[   39.421544]  [<c109e09e>] do_vfs_ioctl+0x4ee/0x530
[   39.422456]  [<c108df28>] ? fd_install+0x48/0x60
[   39.423348]  [<c11ff738>] ? sys_socket+0x48/0x70
[   39.424641]  [<c120054a>] ? sys_socketcall+0x6a/0x270
[   39.426055]  [<c109e119>] sys_ioctl+0x39/0x60
[   39.426982]  [<c128d325>] syscall_call+0x7/0xb
[   39.427944] kobject_create_and_add: kobject_add error: -17
[   39.428999] batman_adv: bat0: Can't add sysfs directory: bat0/vlan0


--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlIM0+MACgkQrzg/fFk7axZeogCg4lohL3klMOo1b4LJyRex4eTC
r9AAoLQ3ZtLBzR1lM3irTYEcF98+wLHY
=pYdP
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
