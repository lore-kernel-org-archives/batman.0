Return-Path: <philipp.psurek@gmail.com>
Message-ID: <1416831279.2678.10.camel@gmail.com>
From: Philipp Psurek <philipp.psurek@gmail.com>
Date: Mon, 24 Nov 2014 13:14:39 +0100
In-Reply-To: <1416825873.2678.2.camel@gmail.com>
References: <1416347918.9920.10.camel@gmail.com>
 <546DA710.2040802@hundeboll.net> <1416476912.2747.5.camel@gmail.com>
 <546DC214.6050908@hundeboll.net> <1416486149.2747.9.camel@gmail.com>
 <546DE067.8070807@hundeboll.net> <1416688754.2696.3.camel@gmail.com>
 <5472EB56.8000700@hundeboll.net> <1416825873.2678.2.camel@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature"; 
 boundary="=-Ra2NMcvmlav59A3QdKoj"
Mime-Version: 1.0
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


--=-Ra2NMcvmlav59A3QdKoj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Martin! Hi all!

Here we go again: same bug with disabled NC.

Now I run the VM with NC and MM disabled until next Monday.

Is this bug Batman-adv or kernel related?

Best regards

Philipp

________________________
Freifunk Rheinland e. V.
=E2=80=93 Funkzelle Wuppertal =E2=80=93



  SYSTEM MAP: /boot/System.map                                        =20
DEBUG KERNEL: /usr/src/linux-3.16.7-gentoo/vmlinux (3.16.7-gentoo)
    DUMPFILE: vmcore_20141124124133
        CPUS: 1
        DATE: Mon Nov 24 12:35:05 2014
      UPTIME: 1 days, 16:17:07
LOAD AVERAGE: 0.15, 0.21, 0.20
       TASKS: 144
    NODENAME: wolke
     RELEASE: 3.16.7-gentoo
     VERSION: #1 SMP Mon Nov 17 03:44:22 CET 2014
     MACHINE: x86_64  (2593 Mhz)
      MEMORY: 511.6 MB
       PANIC: "kernel BUG at net/core/skbuff.c:100!"
         PID: 2008
     COMMAND: "fastd"
        TASK: ffff88001f3dbdb0  [THREAD_INFO: ffff880019214000]
         CPU: 0
       STATE: TASK_RUNNING (PANIC)

crash> bt
PID: 2008   TASK: ffff88001f3dbdb0  CPU: 0   COMMAND: "fastd"
 #0 [ffff88001fc03980] machine_kexec at ffffffff8103a34e
 #1 [ffff88001fc039e0] crash_kexec at ffffffff810be503
 #2 [ffff88001fc03ab0] oops_end at ffffffff81005fc8
 #3 [ffff88001fc03ae0] die at ffffffff81006463
 #4 [ffff88001fc03b10] do_trap at ffffffff81002e12
 #5 [ffff88001fc03b70] do_error_trap at ffffffff8100316d
 #6 [ffff88001fc03c30] do_invalid_op at ffffffff8100394b
 #7 [ffff88001fc03c40] invalid_op at ffffffff817f385e
    [exception RIP: skb_panic+94]
    RIP: ffffffff817eb99d  RSP: ffff88001fc03cf8  RFLAGS: 00010296
    RAX: 000000000000008b  RBX: ffff880000011a40  RCX: 0000000000000092
    RDX: 0000000000000083  RSI: 0000000000000046  RDI: 0000000000000246
    RBP: ffff88001fc03d18   R8: 0000000000000000   R9: 0000000000000000
    R10: 00000000000001af  R11: 0000000000000006  R12: 0000000000000564
    R13: ffff88001fc03da0  R14: ffff88001f19d600  R15: ffff880013d55062
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #8 [ffff88001fc03d20] skb_put at ffffffff81611bb1
 #9 [ffff88001fc03d30] batadv_frag_skb_buffer at ffffffffa001be12 [batman_a=
dv]
#10 [ffff88001fc03d90] batadv_recv_frag_packet at ffffffffa0026273 [batman_=
adv]
#11 [ffff88001fc03dd0] batadv_batman_skb_recv at ffffffffa001fef5 [batman_a=
dv]
#12 [ffff88001fc03e10] __netif_receive_skb_core at ffffffff81621962
#13 [ffff88001fc03e80] __netif_receive_skb at ffffffff81621e91
#14 [ffff88001fc03ea0] process_backlog at ffffffff81621f7e
#15 [ffff88001fc03ef0] net_rx_action at ffffffff81622731
#16 [ffff88001fc03f50] __do_softirq at ffffffff81053ef8
#17 [ffff88001fc03fb0] do_softirq_own_stack at ffffffff817f3a5c
--- <IRQ stack> ---
#18 [ffff880019217d10] do_softirq_own_stack at ffffffff817f3a5c
    [exception RIP: tun_get_user+1056]
    RIP: ffffffffa00098f0  RSP: 0000000000000001  RFLAGS: 7fff00000586
    RAX: ffffffff816210b4  RBX: ffff880019217d58  RCX: ffff88001932c780
    RDX: 0000000000000000  RSI: ffff88001932c780  RDI: 0000000000000586
    RBP: ffffffff81620de4   R8: ffff880019217d88   R9: ffff88001932c780
    R10: ffff88001932c780  R11: ffffffff81054135  R12: ffff880019217d58
    R13: 0000000000000586  R14: ffff88001f19d800  R15: 0000000000000000
    ORIG_RAX: ffff880019217e38  CS: 7fff3207c250  SS: 0000
bt: WARNING: possibly bogus exception frame
#19 [ffff880019217e40] tun_chr_aio_write at ffffffffa0009e0b [tun]
#20 [ffff880019217e70] do_sync_write at ffffffff8115c665
#21 [ffff880019217f00] vfs_write at ffffffff8115d38a
#22 [ffff880019217f40] sys_write at ffffffff8115d89a
#23 [ffff880019217f80] system_call_fastpath at ffffffff817f1f29
    RIP: 00007ffe0dbc637d  RSP: 00007fff3207c4d8  RFLAGS: 00010202
    RAX: 0000000000000001  RBX: ffffffff817f1f29  RCX: 0000000000000084
    RDX: 0000000000000586  RSI: 00000000007c0f00  RDI: 0000000000000009
    RBP: 0000000000000586   R8: 00007ffe0dbaf400   R9: 00007fff3207b998
    R10: 00007fff3207c0df  R11: 0000000000000293  R12: 00000000007c8278
    R13: 0000000000000001  R14: 00000000007c0ef0  R15: 00000000007b96a0
    ORIG_RAX: 0000000000000001  CS: 0033  SS: 002b

crash> log
[          =E2=80=A6 ]
[   85.585384] random: nonblocking pool is initialized
[  344.074524] tun: Universal TUN/TAP device driver, 1.6
[  344.074529] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[  345.437185] batman_adv: B.A.T.M.A.N. advanced 2014.3.0 (compatibility ve=
rsion 15) loaded
[  345.586455] batman_adv: bat0: Adding interface: fastd0
[  345.586459] batman_adv: bat0: The MTU of interface fastd0 is too small (=
1426) to handle the transport of batman-adv packets. Packets going over thi=
s interface will be fragmented on layer2 which could impact the performance=
. Setting the MTU to 1560 would solve the problem.
[  345.586463] batman_adv: bat0: Interface activated: fastd0
[  345.587575] batman_adv: bat0: orig_interval: Changing from: 1000 to: 500=
0
[  345.589193] batman_adv: bat0: bridge_loop_avoidance: Changing from: disa=
bled to: enabled
[  345.590126] batman_adv: bat0: Changing gw mode from: off to: client
[  385.143545] ipip: IPv4 over IPv4 tunneling driver
[  387.153331] dhcpd (2100) used greatest stack depth: 11944 bytes left
[  420.953976] batman_adv: bat0: Changing gw mode from: client to: server
[  420.954124] batman_adv: bat0: Changing gateway bandwidth from: '10.0/2.0=
 MBit' to: '100.0/100.0 MBit'
[  442.064172] batman_adv: bat0: network_coding: Changing from: enabled to:=
 disabled
[  737.948219] nf_conntrack: automatic helper assignment is deprecated and =
it will be removed soon. Use the iptables CT target to attach helpers inste=
ad.
[ 6441.957012] dig (23207) used greatest stack depth: 11832 bytes left
[24933.266728] UDP: bad checksum. From _._._._:137 to _._._._ ulen 58
[24933.267969] UDP: bad checksum. From _._._._:137 to _._._._ ulen 58
[79218.832519] UDP: short packet: From _._._._:0 6117/1480 to _._._._:0
[88652.433174] UDP: short packet: From _._._._:0 6117/1480 to _._._._:0
[145027.089070] skbuff: skb_over_panic: text:ffffffffa001be12 len:1448 put:=
1380 head:ffff88000e4c0c00 data:ffff88000e4c0c62 tail:0x60a end:0x2c0 dev:f=
astd0
[145027.089388] ------------[ cut here ]------------
[145027.089492] kernel BUG at net/core/skbuff.c:100!
[145027.089590] invalid opcode: 0000 [#1] SMP=20
[145027.089691] Modules linked in: xt_nat iptable_nat nf_nat_ipv4 nf_nat ip=
ip batman_adv libcrc32c tun crc32c_intel
[145027.089977] CPU: 0 PID: 2008 Comm: fastd Not tainted 3.16.7-gentoo #1
[145027.090003] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2007
[145027.090003] task: ffff88001f3dbdb0 ti: ffff880019214000 task.ti: ffff88=
0019214000
[145027.090003] RIP: 0010:[<ffffffff817eb99d>]  [<ffffffff817eb99d>] skb_pa=
nic+0x5e/0x60
[145027.090003] RSP: 0018:ffff88001fc03cf8  EFLAGS: 00010296
[145027.090003] RAX: 000000000000008b RBX: ffff880000011a40 RCX: 0000000000=
000092
[145027.090003] RDX: 0000000000000083 RSI: 0000000000000046 RDI: 0000000000=
000246
[145027.090003] RBP: ffff88001fc03d18 R08: 0000000000000000 R09: 0000000000=
000000
[145027.090003] R10: 00000000000001af R11: 0000000000000006 R12: 0000000000=
000564
[145027.090003] R13: ffff88001fc03da0 R14: ffff88001f19d600 R15: ffff880013=
d55062
[145027.090003] FS:  00007ffe0e872700(0000) GS:ffff88001fc00000(0000) knlGS=
:0000000000000000
[145027.090003] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[145027.090003] CR2: 00007f410b4a24b0 CR3: 0000000019282000 CR4: 0000000000=
0006f0
[145027.090003] Stack:
[145027.090003]  ffff88000e4c0c62 000000000000060a 00000000000002c0 ffff880=
01932c000
[145027.090003]  ffff88001fc03d28 ffffffff81611bb1 ffff88001fc03d88 fffffff=
fa001be12
[145027.090003]  ffff880019cf59c8 ffff880013d5504e ffff88001fc03d78 ffff880=
000011a40
[145027.090003] Call Trace:
[145027.090003]  <IRQ>=20
[145027.090003]=20
[145027.090003]  [<ffffffff81611bb1>] skb_put+0x41/0x50
[145027.090003]  [<ffffffffa001be12>] batadv_frag_skb_buffer+0x272/0x470 [b=
atman_adv]
[145027.090003]  [<ffffffffa0026273>] batadv_recv_frag_packet+0x183/0x200 [=
batman_adv]
[145027.090003]  [<ffffffffa001fef5>] batadv_batman_skb_recv+0xd5/0x110 [ba=
tman_adv]
[145027.090003]  [<ffffffff81621962>] __netif_receive_skb_core+0x222/0x730
[145027.090003]  [<ffffffff81621e91>] __netif_receive_skb+0x21/0x70
[145027.090003]  [<ffffffff81621f7e>] process_backlog+0x9e/0x170
[145027.090003]  [<ffffffff81622731>] net_rx_action+0x141/0x240
[145027.090003]  [<ffffffff81053ef8>] __do_softirq+0xe8/0x280
[145027.090003]  [<ffffffff817f3a5c>] do_softirq_own_stack+0x1c/0x30
[145027.090003]  <EOI>=20
[145027.090003]=20
[145027.090003]  [<ffffffff81054135>] do_softirq+0x55/0x60
[145027.090003]  [<ffffffff816210b4>] netif_rx_ni+0x34/0x70
[145027.090003]  [<ffffffffa00098f0>] tun_get_user+0x420/0x840 [tun]
[145027.090003]  [<ffffffffa0009e0b>] tun_chr_aio_write+0x7b/0xa0 [tun]
[145027.090003]  [<ffffffff8115c665>] do_sync_write+0x55/0x90
[145027.090003]  [<ffffffff8115d38a>] vfs_write+0xba/0x1f0
[145027.090003]  [<ffffffff8115d89a>] SyS_write+0x4a/0xa0
[145027.090003]  [<ffffffff817f1f29>] system_call_fastpath+0x16/0x1b
[145027.090003] Code: 00 00 48 89 44 24 10 8b 87 c0 00 00 00 48 89 44 24 08=
 48 8b 87 d0 00 00 00 48 c7 c7 30 67 a3 81 48 89 04 24 31 c0 e8 0d 8b ff ff=
 <0f> 0b 55 48 89 f8 48 8b 57 30 48 89 e5 48 8b 0f 5d 80 e5 80 48=20
[145027.090003] RIP  [<ffffffff817eb99d>] skb_panic+0x5e/0x60
[145027.090003]  RSP <ffff88001fc03cf8>


--=-Ra2NMcvmlav59A3QdKoj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABAgAGBQJUcyEvAAoJENpWdD1eHU4JmgIQAI6MKpVRjlmFMeeRZp0gRq5W
W7ipncdD44+/XXqNm0vwluEcGecEX4kdBQ9KZVDAkPPGz3B1M0emNWT3DtPaUafl
JIp2ZZSnZXwN5WXkOAzR7PTjsR1uI1v5EpE2C21CGKYrLk0RRpaOiEDMBwh5SjwC
TWNybAmOmN8CcELIuIfCqcteX3rVhjd7snH2EChQTPAH7ID5NFC3Ub34hckw8C03
tleuaZterXdqX+tbSaRndwYrw7uKo5XKcwoFhXV25oPUVFncjqtul3JLqS1JNfVK
0ua95kSFwrX95YAuABgIlg6Wp0lFszSShoCdLfQYWmZFdzu7q/W+q3zl+dSCISA7
Dn3HB4Yg4peC5CkNdgXZkPDj8/31Xfw7Fq3nFdij3EQiiF9kqGoQlZoX7mAUkQL/
oKr/cf1dEuN+IpRLapOyDEiM02yy0v7Od0vP4Cyw0bvSXwC4JRRdXqGEQ37QsGp0
VAK2YV+KhwHnxwHEtIqbeCSKnw/ohstkujMqNNyM33DeNwrjt+NzfOM0lGIZipKs
Nd2AZMHrqLDHKwthNqMpgBjDd8VqHIpoNXeLuJLovj0ILaxA9MmEAtLrceb9Q/6s
adLFk6/RSfFYzSSuBpzJFdvN5ium6aZgOcVtEHuJCwWZEpKi98QUj/uVamkcaKBW
dzzT2RlCPnWNjTlIlMa+
=VHVI
-----END PGP SIGNATURE-----

--=-Ra2NMcvmlav59A3QdKoj--

