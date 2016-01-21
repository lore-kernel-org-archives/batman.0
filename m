Return-Path: <sven@open-mesh.com>
From: Sven Eckelmann <sven@open-mesh.com>
Date: Thu, 21 Jan 2016 12:56:01 +0100
Message-ID: <6825353.GnzNjs5eRJ@bentobox>
In-Reply-To: <8047297.0qIFjkW2bL@voltaire>
References: <8047297.0qIFjkW2bL@voltaire>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [B.A.T.M.A.N.] B.A.T.M.A.N. V leaves the nest v2
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

Just installed in on some hardware (2x OM5P + OpenWrt 44654 + compat-wi=
reless
2015-10-26) and enabled BATMAN_V.

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

The result was:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

[  168.540000] CPU 0 Unable to handle kernel paging request at virtual =
address fffffff0, epc =3D=3D 86d8301c, ra =3D=3D 86d8301c
[  168.550000] Oops[#1]:
[  168.550000] CPU: 0 PID: 265 Comm: kworker/u2:2 Tainted: P           =
    3.18.8 #1
[  168.550000] Workqueue: bat_events batadv_v_elp_throughput_metric_upd=
ate [batman_adv]
[  168.550000] task: 878826c0 ti: 87a24000 task.ti: 87a24000
[  168.550000] $ 0   : 00000000 00000001 00000000 fffffffe
[  168.550000] $ 4   : 86a5cf00 00000000 00000000 00000000
[  168.550000] $ 8   : 00000011 c4653600 ffffffff 00000001
[  168.550000] $12   : 00000000 0000000c 00000000 00000000
[  168.550000] $16   : 00000000 00000000 87804a1e 868f5000
[  168.550000] $20   : 00000000 00000000 87804a10 87804a00
[  168.550000] $24   : 00000002 86d1a0e4                 =20
[  168.550000] $28   : 87a24000 87a25e40 00000088 86d8301c
[  168.550000] Hi    : 00000000
[  168.550000] Lo    : 00000000
[  168.550000] epc   : 86d8301c batadv_v_elp_throughput_metric_update+0=
x20/0x58 [batman_adv]
[  168.550000]     Tainted: P             =20
[  168.550000] ra    : 86d8301c batadv_v_elp_throughput_metric_update+0=
x20/0x58 [batman_adv]
[  168.550000] Status: 1100fc03 KERNEL EXL IE=20
[  168.550000] Cause : 00800008
[  168.550000] BadVA : fffffff0
[  168.550000] PrId  : 00019750 (MIPS 74Kc)
[  168.550000] Modules linked in: iptable_nat ath9k nf_nat_pptp nf_nat_=
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
[  168.550000] Process kworker/u2:2 (pid: 265, threadinfo=3D87a24000, t=
ask=3D878826c0, tls=3D00000000)
[  168.550000] Stack : 00000000 00000000 00000000 00000000 00000000 000=
00000 00000000 00000000
          803496de 800665ac 00000000 00000000 00000000 00000000 0000000=
0 00000000
          87804a00 879cf198 8030bb3e 00000001 00000000 00000000 0000000=
0 00000000
          00000010 80123ad4 879fa100 801232d0 879cf21e 879cf180 0000000=
0 00000000
          00000000 00000000 00000000 00000000 00000000 00000000 fffffff=
e 00000002
          ...
[  168.550000] Call Trace:
[  168.550000] [<86d8301c>] batadv_v_elp_throughput_metric_update+0x20/=
0x58 [batman_adv]
[  168.550000]=20
[  168.550000]
