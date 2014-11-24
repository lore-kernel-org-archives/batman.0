Return-Path: <philipp.psurek@gmail.com>
Message-ID: <1416863721.1632.3.camel@gmail.com>
From: Philipp Psurek <philipp.psurek@gmail.com>
Date: Mon, 24 Nov 2014 22:15:21 +0100
In-Reply-To: <1416831279.2678.10.camel@gmail.com>
References: <1416347918.9920.10.camel@gmail.com>
 <546DA710.2040802@hundeboll.net> <1416476912.2747.5.camel@gmail.com>
 <546DC214.6050908@hundeboll.net> <1416486149.2747.9.camel@gmail.com>
 <546DE067.8070807@hundeboll.net> <1416688754.2696.3.camel@gmail.com>
 <5472EB56.8000700@hundeboll.net> <1416825873.2678.2.camel@gmail.com>
 <1416831279.2678.10.camel@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-XyqTU/cL4hmIvL6pg04z"
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


--=-XyqTU/cL4hmIvL6pg04z
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello again

Now it becomes a running gag, ;-) but I really try to provide you with
some information about this bug.

Now we needn't to wait until next Monday. The bug appears also with NC
and MM disabled.

Do you need this back-traces? Can you see something inside besides magic
numbers? Somehow it should be possible to extract the bogus packages
from vmcore with crash or some other utility to reproduce the bug.

Please tell me what to do.

Best regards

Philipp

________________________
Freifunk Rheinland e. V.
=E2=80=93 Funkzelle Wuppertal =E2=80=93





  SYSTEM MAP: /boot/System.map                                        =20
DEBUG KERNEL: /usr/src/linux-3.16.7-gentoo/vmlinux (3.16.7-gentoo)
    DUMPFILE: vmcore_20141124212740
        CPUS: 1
        DATE: Mon Nov 24 21:01:11 2014
      UPTIME: 08:13:54
LOAD AVERAGE: 0.27, 0.28, 0.23
       TASKS: 125
    NODENAME: wolke
     RELEASE: 3.16.7-gentoo
     VERSION: #1 SMP Mon Nov 17 03:44:22 CET 2014
     MACHINE: x86_64  (2593 Mhz)
      MEMORY: 511.6 MB
       PANIC: "kernel BUG at net/core/skbuff.c:100!"
         PID: 1993
     COMMAND: "fastd"
        TASK: ffff88001f3369c0  [THREAD_INFO: ffff880019ff0000]
         CPU: 0
       STATE: TASK_RUNNING (PANIC)

crash> bt
PID: 1993   TASK: ffff88001f3369c0  CPU: 0   COMMAND: "fastd"
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
    RAX: 000000000000008b  RBX: ffff88000f9a4e80  RCX: 0000000000000092
    RDX: 000000000000001f  RSI: 0000000000000046  RDI: 0000000000000246
    RBP: ffff88001fc03d18   R8: 0000000000000000   R9: 0000000000000000
    R10: 00000000000001b0  R11: 0000000000000006  R12: 0000000000000564
    R13: ffff88001fc03da0  R14: ffff880019f69000  R15: ffff880007130062
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
#18 [ffff880019ff3d10] do_softirq_own_stack at ffffffff817f3a5c
    [exception RIP: tun_get_user+1056]
    RIP: ffffffffa00098f0  RSP: 0000000000000001  RFLAGS: 7fff00000586
    RAX: ffffffff816210b4  RBX: ffff880019ff3d58  RCX: ffff880017710780
    RDX: 0000000000000000  RSI: ffff880017710780  RDI: 0000000000000586
    RBP: ffffffff81620de4   R8: ffff880019ff3d88   R9: ffff880017710780
    R10: ffff880017710780  R11: ffffffff81054135  R12: ffff880019ff3d58
    R13: 0000000000000586  R14: ffff880019f69e00  R15: 0000000000000000
    ORIG_RAX: ffff880019ff3e38  CS: 7ffffd27ec80  SS: 0000
bt: WARNING: possibly bogus exception frame
#19 [ffff880019ff3e40] tun_chr_aio_write at ffffffffa0009e0b [tun]
#20 [ffff880019ff3e70] do_sync_write at ffffffff8115c665
#21 [ffff880019ff3f00] vfs_write at ffffffff8115d38a
#22 [ffff880019ff3f40] sys_write at ffffffff8115d89a
#23 [ffff880019ff3f80] system_call_fastpath at ffffffff817f1f29
    RIP: 00007f24ad2c037d  RSP: 00007ffffd27ea18  RFLAGS: 00010246
    RAX: 0000000000000001  RBX: ffffffff817f1f29  RCX: 0000000000000003
    RDX: 0000000000000586  RSI: 00000000008c9ff0  RDI: 0000000000000009
    RBP: 0000000000000586   R8: 00007f24ad2a9400   R9: 00007ffffd27e3c8
    R10: 00007ffffd27eb0f  R11: 0000000000000293  R12: 00000000008c99f8
    R13: 0000000000000001  R14: 00000000008c9fe0  R15: 00000000008b86e0
    ORIG_RAX: 0000000000000001  CS: 0033  SS: 002b
crash> log
[          =E2=80=A6 ]
[   46.421671] Adding 1571836k swap on /dev/vda2.  Priority:-1 extents:1 ac=
ross:1571836k=20
[   61.663553] crond (1525) used greatest stack depth: 11944 bytes left
[   94.611478] device eth0 entered promiscuous mode
[   95.050264] random: nonblocking pool is initialized
[   97.767718] sshd (1896) used greatest stack depth: 11848 bytes left
[  155.371394] tun: Universal TUN/TAP device driver, 1.6
[  155.371402] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[  160.085539] batman_adv: B.A.T.M.A.N. advanced 2014.3.0 (compatibility ve=
rsion 15) loaded
[  161.520244] batman_adv: bat0: Adding interface: fastd0
[  161.520248] batman_adv: bat0: The MTU of interface fastd0 is too small (=
1426) to handle the transport of batman-adv packets. Packets going over thi=
s interface will be fragmented on layer2 which could impact the performance=
. Setting the MTU to 1560 would solve the problem.
[  161.520251] batman_adv: bat0: Interface activated: fastd0
[  161.521317] batman_adv: bat0: orig_interval: Changing from: 1000 to: 500=
0
[  161.522871] batman_adv: bat0: bridge_loop_avoidance: Changing from: disa=
bled to: enabled
[  161.523606] batman_adv: bat0: Changing gw mode from: off to: client
[  163.534130] ipip: IPv4 over IPv4 tunneling driver
[  240.083770] batman_adv: bat0: Changing gw mode from: client to: server
[  240.083793] batman_adv: bat0: Changing gateway bandwidth from: '10.0/2.0=
 MBit' to: '100.0/100.0 MBit'
[  240.089611] batman_adv: bat0: network_coding: Changing from: enabled to:=
 disabled
[  632.809027] nf_conntrack: automatic helper assignment is deprecated and =
it will be removed soon. Use the iptables CT target to attach helpers inste=
ad.
[  878.974740] batman_adv: bat0: multicast_mode: Changing from: enabled to:=
 disabled
[ 7311.887428] named (9682) used greatest stack depth: 11720 bytes left
[25080.989287] UDP: bad checksum. From _._._._:26085 to _._._._:25901 ulen =
76
[25081.134015] UDP: bad checksum. From _._._._:26085 to _._._._:25901 ulen =
75
[25125.828688] UDP: bad checksum. From _._._._:26085 to _._._._:31502 ulen =
79
[25225.232627] UDP: bad checksum. From _._._._:26085 to _._._._:25901 ulen =
75
[25323.805796] UDP: bad checksum. From _._._._:26085 to _._._._:25901 ulen =
76
[25355.026288] UDP: bad checksum. From _._._._:26085 to _._._._:25901 ulen =
76
[29634.048268] skbuff: skb_over_panic: text:ffffffffa001be12 len:1459 put:1=
380 head:ffff8800049c4000 data:ffff8800049c4062 tail:0x615 end:0x2c0 dev:fa=
std0
[29634.048580] ------------[ cut here ]------------
[29634.048686] kernel BUG at net/core/skbuff.c:100!
[29634.048781] invalid opcode: 0000 [#1] SMP=20
[29634.048881] Modules linked in: xt_nat iptable_nat nf_nat_ipv4 nf_nat ipi=
p batman_adv libcrc32c tun crc32c_intel
[29634.049175] CPU: 0 PID: 1993 Comm: fastd Not tainted 3.16.7-gentoo #1
[29634.049198] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2007
[29634.049198] task: ffff88001f3369c0 ti: ffff880019ff0000 task.ti: ffff880=
019ff0000
[29634.049198] RIP: 0010:[<ffffffff817eb99d>]  [<ffffffff817eb99d>] skb_pan=
ic+0x5e/0x60
[29634.049198] RSP: 0018:ffff88001fc03cf8  EFLAGS: 00010296
[29634.049198] RAX: 000000000000008b RBX: ffff88000f9a4e80 RCX: 00000000000=
00092
[29634.049198] RDX: 000000000000001f RSI: 0000000000000046 RDI: 00000000000=
00246
[29634.049198] RBP: ffff88001fc03d18 R08: 0000000000000000 R09: 00000000000=
00000
[29634.049198] R10: 00000000000001b0 R11: 0000000000000006 R12: 00000000000=
00564
[29634.049198] R13: ffff88001fc03da0 R14: ffff880019f69000 R15: ffff8800071=
30062
[29634.049198] FS:  00007f24adf6c700(0000) GS:ffff88001fc00000(0000) knlGS:=
0000000000000000
[29634.049198] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[29634.049198] CR2: 00007f9b1be31000 CR3: 00000000175ff000 CR4: 00000000000=
006f0
[29634.049198] Stack:
[29634.049198]  ffff8800049c4062 0000000000000615 00000000000002c0 ffff8800=
17710000
[29634.049198]  ffff88001fc03d28 ffffffff81611bb1 ffff88001fc03d88 ffffffff=
a001be12
[29634.049198]  ffff8800176f21c8 ffff88000713004e ffff88001fc03d78 ffff8800=
0f9a4e80
[29634.049198] Call Trace:
[29634.049198]  <IRQ>=20
[29634.049198]=20
[29634.049198]  [<ffffffff81611bb1>] skb_put+0x41/0x50
[29634.049198]  [<ffffffffa001be12>] batadv_frag_skb_buffer+0x272/0x470 [ba=
tman_adv]
[29634.049198]  [<ffffffffa0026273>] batadv_recv_frag_packet+0x183/0x200 [b=
atman_adv]
[29634.049198]  [<ffffffffa001fef5>] batadv_batman_skb_recv+0xd5/0x110 [bat=
man_adv]
[29634.049198]  [<ffffffff81621962>] __netif_receive_skb_core+0x222/0x730
[29634.049198]  [<ffffffff81621e91>] __netif_receive_skb+0x21/0x70
[29634.049198]  [<ffffffff81621f7e>] process_backlog+0x9e/0x170
[29634.049198]  [<ffffffff81622731>] net_rx_action+0x141/0x240
[29634.049198]  [<ffffffff81053ef8>] __do_softirq+0xe8/0x280
[29634.049198]  [<ffffffff817f3a5c>] do_softirq_own_stack+0x1c/0x30
[29634.049198]  <EOI>=20
[29634.049198]=20
[29634.049198]  [<ffffffff81054135>] do_softirq+0x55/0x60
[29634.049198]  [<ffffffff816210b4>] netif_rx_ni+0x34/0x70
[29634.049198]  [<ffffffffa00098f0>] tun_get_user+0x420/0x840 [tun]
[29634.049198]  [<ffffffffa0009e0b>] tun_chr_aio_write+0x7b/0xa0 [tun]
[29634.049198]  [<ffffffff8115c665>] do_sync_write+0x55/0x90
[29634.049198]  [<ffffffff8115d38a>] vfs_write+0xba/0x1f0
[29634.049198]  [<ffffffff8115d89a>] SyS_write+0x4a/0xa0
[29634.049198]  [<ffffffff817f1f29>] system_call_fastpath+0x16/0x1b
[29634.049198] Code: 00 00 48 89 44 24 10 8b 87 c0 00 00 00 48 89 44 24 08 =
48 8b 87 d0 00 00 00 48 c7 c7 30 67 a3 81 48 89 04 24 31 c0 e8 0d 8b ff ff =
<0f> 0b 55 48 89 f8 48 8b 57 30 48 89 e5 48 8b 0f 5d 80 e5 80 48=20
[29634.049198] RIP  [<ffffffff817eb99d>] skb_panic+0x5e/0x60
[29634.049198]  RSP <ffff88001fc03cf8>



--=-XyqTU/cL4hmIvL6pg04z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJUc5/wAAoJENpWdD1eHU4J+lEP/3C7gAU7zoTkS6GmG1dWZNEj
Z3TdGtkvdDde19xyR2Jjw5A483X+3UDS+uRgneIE3IexDzSuh5R2V5r7krvR94Tp
x+FKnK6aYlpKlpTit7RlClYdf8v3Vu5t2OoPTEUjEH9fDoePQYJmikVOIs/LKwXj
qV5q9PAgOrqZYnPSZM7Qu08plk4el89U3zoX3YfodgMxIaO0wjvYmVn/5xtVkwC2
KIYkqdCCpruEZCiQlOZ0//z7rKJcbvUUzfoPWKg/u1uUCs9M6i063SU5r+fbhP6a
hGpYEYpVb8/M0Y+CG7sZzdmNlNyUovvrtJ50s4OtyiamVKFc5H3ExOkv9Jxg0xLc
/QvedWI6jYgI/I3784GpwkffHutQgwxfk0hgQN76oIL6H5Q9Vc+qasobRb0OMw2j
urKpFBzh/sJuXbWrboc6k6vN+lhvaII1Gj7g4Hrr2I0ZEcdQanuqbPk5TosOwovV
6Wn6z0iuQxJ+3K8RvH5pwuXBale6S7qQYUkaeIwuL03TCuH5Q5zb+jqgJ1esc3VO
Jb9TebTwNAuzfSvGp10vsMfXhJyAXHeP4I6ihGjsc/cS3CmZkaj2gT4W+gxeMQ8B
pHj0kL3cO8atRw3DhhFnZW4keHr2Kq5/6KLwzk3hE9GDUuIwgrXTDBqlLxJW+xkd
h9yuings4Px8kPujVw//
=Orsr
-----END PGP SIGNATURE-----

--=-XyqTU/cL4hmIvL6pg04z--

