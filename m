Return-Path: <sven.eckelmann@open-mesh.com>
From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Date: Fri, 12 Feb 2016 09:51:59 +0100
Message-ID: <103949657.7suUY09B7s@bentobox>
In-Reply-To: <1454336498-2621-1-git-send-email-sw@simonwunderlich.de>
References: <1454336498-2621-1-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 1/2] batman-adv: move and restructure
	batadv_v_ogm_forward
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
Cc: Simon Wunderlich <simon@open-mesh.com>

On Monday 01 February 2016 15:21:37 Simon Wunderlich wrote:
> From: Simon Wunderlich <simon@open-mesh.com>
>=20
> To match our code better to the protocol description of B.A.T.M.A.N. =
V,
> move batadv_v_ogm_forward() out into batadv_v_ogm_process_per_outif()=

> and move all checks directly deciding whether the OGM should be
> forwarded into batadv_v_ogm_forward().
>=20
> Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
> ---
> Changes to PATCH:
>  * fix some embarassing compile issues and style issues (thanks Marek=
)
> ---

This patch crashes my two node test setup (2xOM2P-HS).

/etc/config/wireless:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

config wifi-iface 'wmesh'
        option device 'radio0'
        option ifname 'adhoc0'
        option network 'batnet'
        option mode 'adhoc'
        option ssid 'mesh'
        option 'mcast_rate' '18000'
        option bssid '02:CA:FE:CA:CA:40'


/etc/config/network
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

config interface 'batnet'
        option mtu '1532'
        option proto 'batadv'
        option mesh 'bat0'
        option routing_algo 'BATMAN_V'


[   21.690000] CPU 0 Unable to handle kernel paging request at virtual =
address 0000000c, epc =3D=3D 83183d04, ra =3D=3D 83183cf8
[   21.700000] Oops[#1]:
[   21.700000] CPU: 0 PID: 1152 Comm: udhcpc Tainted: P               3=
.18.8 #1
[   21.700000] task: 83987070 ti: 8298e000 task.ti: 8298e000
[   21.700000] $ 0   : 00000000 00000001 8297b400 00000001
[   21.700000] $ 4   : 00000001 00000000 00000002 82980100
[   21.700000] $ 8   : 00000001 0000ed7e 8297b380 c881c661
[   21.700000] $12   : 00000000 832cf499 00000000 7fc3a8d0
[   21.700000] $16   : 82808090 00000000 82980100 8297b400
[   21.700000] $20   : 82951a00 8297b680 0000001c 00000000
[   21.700000] $24   : 00000000 8021f434                 =20
[   21.700000] $28   : 8298e000 8298f968 82951a00 83183cf8
[   21.700000] Hi    : 000003b7
[   21.700000] Lo    : 003f2fb0
[   21.700000] epc   : 83183d04 batadv_v_ogm_orig_get+0x65c/0x738 [batm=
an_adv]
[   21.700000]     Tainted: P             =20
[   21.700000] ra    : 83183cf8 batadv_v_ogm_orig_get+0x650/0x738 [batm=
an_adv]
[   21.700000] Status: 1100f403 KERNEL EXL IE=20
[   21.700000] Cause : 00800008
[   21.700000] BadVA : 0000000c
[   21.700000] PrId  : 0001974c (MIPS 74Kc)
[   21.700000] Modules linked in: iptable_nat ath9k nf_nat_pptp nf_nat_=
ipv4 nf_nat_amanda nf_conntrack_pptp nf_conntrack_ipv6 nf_conntrack_ipv=
4 nf_conntrack_amanda ipt_REJECT ipt_MASQUERADE ath9k_common xt_time xt=
_tcpudp xt_tcpmss xt_string xt_statistic xt_state xt_recent xt_quota xt=
_pkttype xt_physdev xt_owner xt_nat xt_multiport xt_mark xt_mac xt_limi=
t xt_length xt_id xt_hl xt_helper xt_ecn xt_dscp xt_conntrack xt_connma=
rk xt_connlimit xt_connbytes xt_comment xt_addrtype xt_TCPMSS xt_REDIRE=
CT xt_NETMAP xt_LOG xt_HL xt_DSCP xt_CT xt_CLASSIFY ts_kmp ts_fsm ts_bm=
 nf_reject_ipv4 nf_nat_tftp nf_nat_snmp_basic nf_nat_sip nf_nat_proto_g=
re nf_nat_masquerade_ipv4 nf_nat_irc nf_nat_h323 nf_nat_ftp nf_nat nf_l=
og_ipv4 nf_defrag_ipv6 nf_defrag_ipv4 nf_conntrack_tftp nf_conntrack_sn=
mp nf_conntrack_sip nf_conntrack_rtcache nf_conntrack_proto_gre nf_conn=
track_irc nf_conntrack_h323 nf_conntrack_ftp nf_conntrack_broadcast ipt=
able_raw iptable_mangle iptable_filter ipt_ECN ip_tables crc_ccitt ath9=
k_hw em_nbyte sch_codel sch_prio sch_dsmark act_ipt sch_gred em_meta sc=
h_htb cls_basic sch_netem act_police em_text sch_tbf sch_sfq em_cmp sch=
_red act_skbedit act_mirred em_u32 cls_u32 cls_tcindex cls_flow cls_rou=
te cls_fw sch_hfsc sch_ingress tmp421 hwmon batman_adv libcrc32c crc16 =
ath10k_pci ath10k_core ath mac80211 cfg80211 compat UDSMARK udsmac i2c_=
dev tc_classid_mapper(P) filter_group classifier_dns(P) classifier_netb=
lock(P) classifier_bittorrent(P) classifier_rtmp(P) classifier_ssl(P) c=
lassifier_content(P) classifier_skype(P) kernel_classifier nf_conntrack=
 xt_set ip_set_list_set ip_set_hash_netport ip_set_hash_netiface ip_set=
_hash_net ip_set_hash_ipportnet ip_set_hash_ipportip ip_set_hash_ipport=
 ip_set_hash_ip ip_set_bitmap_port ip_set_bitmap_ipmac ip_set_bitmap_ip=
 ip_set nfnetlink ip6t_REJECT nf_reject_ipv6 nf_log_ipv6 nf_log_common =
ip6table_raw ip6table_mangle ip6table_filter ip6_tables x_tables ifb tu=
n ipv6 arc4 crypto_blkcipher input_polldev gpio_button_hotplug button_h=
otplug input_core ag71xx crc32c_generic crypto_hash
[   21.700000] Process udhcpc (pid: 1152, threadinfo=3D8298e000, task=3D=
83987070, tls=3D77051440)
[   21.700000] Stack : 003617ec 80090cb4 80391000 839a8800 00000000 828=
080a4 0000001c 8340c240
          0140c280 8340c2c0 00000000 8340c4c0 832cf480 831aff00 000fcc6=
6 82980100
          82951a00 82808090 82980080 828d3420 82808082 83184088 839a885=
8 82808082
          00000d85 00000400 82980100 831aff00 00000000 80094034 0000100=
0 00000000
          82808090 828d3000 00000014 8340c580 832cf480 00000001 831aff1=
c 00000001
          ...
[   21.700000] Call Trace:
[   21.700000] [<83183d04>] batadv_v_ogm_orig_get+0x65c/0x738 [batman_a=
dv]
[   21.700000]=20
[   21.700000]=20
Code: 10400022  00409821  9616000e <8c04000c> 24060020  0c028338  26c50=
022  1040001c  00408821=20
[   22.050000] ---[ end trace 2f89500f9609fb9e ]---
[   22.050000] Kernel panic - not syncing: Fatal exception in interrupt
