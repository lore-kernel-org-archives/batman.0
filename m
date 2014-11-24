Return-Path: <philipp.psurek@gmail.com>
Message-ID: <1416867973.1632.9.camel@gmail.com>
From: Philipp Psurek <philipp.psurek@gmail.com>
Date: Mon, 24 Nov 2014 23:26:13 +0100
In-Reply-To: <1416863721.1632.3.camel@gmail.com>
References: <1416347918.9920.10.camel@gmail.com>
 <546DA710.2040802@hundeboll.net> <1416476912.2747.5.camel@gmail.com>
 <546DC214.6050908@hundeboll.net> <1416486149.2747.9.camel@gmail.com>
 <546DE067.8070807@hundeboll.net> <1416688754.2696.3.camel@gmail.com>
 <5472EB56.8000700@hundeboll.net> <1416825873.2678.2.camel@gmail.com>
 <1416831279.2678.10.camel@gmail.com> <1416863721.1632.3.camel@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-OGhhBVwrkpU+MtE2h6uZ"
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


--=-OGhhBVwrkpU+MtE2h6uZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

it's me again. There is another back-trace.

I can't help myself. Now I switch to 3.17.3 with your patch:

# cd net/batman-adv/=20
# patch < /usr/src/frag_debug_size.patch=20
patching file fragmentation.c
Hunk #1 succeeded at 250 (offset 1 line).
# cd /usr/src/linux
# make
  CHK     include/config/kernel.release
  CHK     include/generated/uapi/linux/version.h
  CHK     include/generated/utsrelease.h
  CALL    scripts/checksyscalls.sh
  CHK     include/generated/compile.h
  CC [M]  net/batman-adv/fragmentation.o
  LD [M]  net/batman-adv/batman-adv.o
Kernel: arch/x86/boot/bzImage is ready  (#1)
  Building modules, stage 2.
  MODPOST 29 modules
  CC      net/batman-adv/batman-adv.mod.o
  LD [M]  net/batman-adv/batman-adv.ko
# make modules_install
[ =E2=80=A6 ]

3.17.4 compiles now for the next crash.

Best regards

Philipp

________________________
Freifunk Rheinland e. V.
=E2=80=93 Funkzelle Wuppertal =E2=80=93



  SYSTEM MAP: /boot/System.map                                        =20
DEBUG KERNEL: /usr/src/linux-3.16.7-gentoo/vmlinux (3.16.7-gentoo)
    DUMPFILE: vmcore_20141124222013
        CPUS: 1
        DATE: Mon Nov 24 22:15:06 2014
      UPTIME: 00:46:49
LOAD AVERAGE: 0.14, 0.16, 0.14
       TASKS: 137
    NODENAME: wolke
     RELEASE: 3.16.7-gentoo
     VERSION: #1 SMP Mon Nov 17 03:44:22 CET 2014
     MACHINE: x86_64  (2593 Mhz)
      MEMORY: 511.6 MB
       PANIC: "kernel BUG at net/core/skbuff.c:100!"
         PID: 1971
     COMMAND: "fastd"
        TASK: ffff88001a31e0f0  [THREAD_INFO: ffff880019c5c000]
         CPU: 0
       STATE: TASK_RUNNING (PANIC)

crash> bt
PID: 1971   TASK: ffff88001a31e0f0  CPU: 0   COMMAND: "fastd"
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
    RAX: 000000000000008b  RBX: ffff8800057c9860  RCX: 0000000000000092
    RDX: 000000000000003c  RSI: 0000000000000046  RDI: 0000000000000246
    RBP: ffff88001fc03d18   R8: 0000000000000000   R9: 0000000000000000
    R10: 00000000000001a5  R11: 0000000000000006  R12: 0000000000000564
    R13: ffff88001fc03da0  R14: ffff8800191def00  R15: ffff880019200062
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
#18 [ffff880019c5fd10] do_softirq_own_stack at ffffffff817f3a5c
    [exception RIP: tun_get_user+1056]
    RIP: ffffffffa00098f0  RSP: 0000000000000001  RFLAGS: 7fff00000586
    RAX: ffffffff816210b4  RBX: ffff880019c5fd58  RCX: ffff8800192f0780
    RDX: 0000000000000000  RSI: ffff8800192f0780  RDI: 0000000000000586
    RBP: ffffffff81620de4   R8: ffff880019c5fd88   R9: ffff8800192f0780
    R10: ffff8800192f0780  R11: ffffffff81054135  R12: ffff880019c5fd58
    R13: 0000000000000586  R14: ffff8800191de000  R15: 0000000000000000
    ORIG_RAX: ffff880019c5fe38  CS: 7fff4026c120  SS: 0000
bt: WARNING: possibly bogus exception frame
#19 [ffff880019c5fe40] tun_chr_aio_write at ffffffffa0009e0b [tun]
#20 [ffff880019c5fe70] do_sync_write at ffffffff8115c665
#21 [ffff880019c5ff00] vfs_write at ffffffff8115d38a
#22 [ffff880019c5ff40] sys_write at ffffffff8115d89a
#23 [ffff880019c5ff80] system_call_fastpath at ffffffff817f1f29
    RIP: 00007fcaf8b9537d  RSP: 00007fff4026c3a8  RFLAGS: 00010202
    RAX: 0000000000000001  RBX: ffffffff817f1f29  RCX: 0000000000000084
    RDX: 0000000000000586  RSI: 00000000013e2f00  RDI: 0000000000000009
    RBP: 0000000000000586   R8: 00007fcaf8b7e400   R9: 00007fff4026b868
    R10: 00007fff4026bfaf  R11: 0000000000000293  R12: 00000000013d64d8
    R13: 0000000000000001  R14: 00000000013e2ef0  R15: 00000000013c46e0
    ORIG_RAX: 0000000000000001  CS: 0033  SS: 002b

crash> log
[   81.953301] tun: Universal TUN/TAP device driver, 1.6
[   81.953305] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[   83.183042] batman_adv: B.A.T.M.A.N. advanced 2014.3.0 (compatibility ve=
rsion 15) loaded
[   83.444516] batman_adv: bat0: Adding interface: fastd0
[   83.444520] batman_adv: bat0: The MTU of interface fastd0 is too small (=
1426) to handle the transport of batman-adv packets. Packets going over thi=
s interface will be fragmented on layer2 which could impact the performance=
. Setting the MTU to 1560 would solve the problem.
[   83.444524] batman_adv: bat0: Interface activated: fastd0
[   83.445515] batman_adv: bat0: orig_interval: Changing from: 1000 to: 500=
0
[   83.446957] batman_adv: bat0: bridge_loop_avoidance: Changing from: disa=
bled to: enabled
[   83.447682] batman_adv: bat0: Changing gw mode from: off to: client
[  132.723904] ipip: IPv4 over IPv4 tunneling driver
[  188.931093] batman_adv: bat0: Changing gw mode from: client to: server
[  188.931117] batman_adv: bat0: Changing gateway bandwidth from: '10.0/2.0=
 MBit' to: '100.0/100.0 MBit'
[  317.574742] nf_conntrack: automatic helper assignment is deprecated and =
it will be removed soon. Use the iptables CT target to attach helpers inste=
ad.
[ 2809.763665] skbuff: skb_over_panic: text:ffffffffa001be12 len:1472 put:1=
380 head:ffff88000719b400 data:ffff88000719b462 tail:0x622 end:0x2c0 dev:fa=
std0
[ 2809.763978] ------------[ cut here ]------------
[ 2809.764097] kernel BUG at net/core/skbuff.c:100!
[ 2809.764195] invalid opcode: 0000 [#1] SMP=20
[ 2809.764297] Modules linked in: xt_nat iptable_nat nf_nat_ipv4 nf_nat ipi=
p batman_adv libcrc32c tun crc32c_intel
[ 2809.764604] CPU: 0 PID: 1971 Comm: fastd Not tainted 3.16.7-gentoo #1
[ 2809.764604] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2007
[ 2809.764604] task: ffff88001a31e0f0 ti: ffff880019c5c000 task.ti: ffff880=
019c5c000
[ 2809.764604] RIP: 0010:[<ffffffff817eb99d>]  [<ffffffff817eb99d>] skb_pan=
ic+0x5e/0x60
[ 2809.764604] RSP: 0018:ffff88001fc03cf8  EFLAGS: 00010296
[ 2809.764604] RAX: 000000000000008b RBX: ffff8800057c9860 RCX: 00000000000=
00092
[ 2809.764604] RDX: 000000000000003c RSI: 0000000000000046 RDI: 00000000000=
00246
[ 2809.764604] RBP: ffff88001fc03d18 R08: 0000000000000000 R09: 00000000000=
00000
[ 2809.764604] R10: 00000000000001a5 R11: 0000000000000006 R12: 00000000000=
00564
[ 2809.764604] R13: ffff88001fc03da0 R14: ffff8800191def00 R15: ffff8800192=
00062
[ 2809.764604] FS:  00007fcaf9841700(0000) GS:ffff88001fc00000(0000) knlGS:=
0000000000000000
[ 2809.764604] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2809.764604] CR2: 00007f0953452000 CR3: 00000000191da000 CR4: 00000000000=
006f0
[ 2809.764604] Stack:
[ 2809.764604]  ffff88000719b462 0000000000000622 00000000000002c0 ffff8800=
192f0000
[ 2809.764604]  ffff88001fc03d28 ffffffff81611bb1 ffff88001fc03d88 ffffffff=
a001be12
[ 2809.764604]  ffff88001f33d168 ffff88001920004e ffff88001fc03d78 ffff8800=
057c9860
[ 2809.764604] Call Trace:
[ 2809.764604]  <IRQ>=20
[ 2809.764604]=20
[ 2809.764604]  [<ffffffff81611bb1>] skb_put+0x41/0x50
[ 2809.764604]  [<ffffffffa001be12>] batadv_frag_skb_buffer+0x272/0x470 [ba=
tman_adv]
[ 2809.764604]  [<ffffffffa0026273>] batadv_recv_frag_packet+0x183/0x200 [b=
atman_adv]
[ 2809.764604]  [<ffffffffa001fef5>] batadv_batman_skb_recv+0xd5/0x110 [bat=
man_adv]
[ 2809.764604]  [<ffffffff81621962>] __netif_receive_skb_core+0x222/0x730
[ 2809.764604]  [<ffffffff81621e91>] __netif_receive_skb+0x21/0x70
[ 2809.764604]  [<ffffffff81621f7e>] process_backlog+0x9e/0x170
[ 2809.764604]  [<ffffffff81622731>] net_rx_action+0x141/0x240
[ 2809.764604]  [<ffffffff81053ef8>] __do_softirq+0xe8/0x280
[ 2809.764604]  [<ffffffff817f3a5c>] do_softirq_own_stack+0x1c/0x30
[ 2809.764604]  <EOI>=20
[ 2809.764604]=20
[ 2809.764604]  [<ffffffff81054135>] do_softirq+0x55/0x60
[ 2809.764604]  [<ffffffff816210b4>] netif_rx_ni+0x34/0x70
[ 2809.764604]  [<ffffffffa00098f0>] tun_get_user+0x420/0x840 [tun]
[ 2809.764604]  [<ffffffffa0009e0b>] tun_chr_aio_write+0x7b/0xa0 [tun]
[ 2809.764604]  [<ffffffff8115c665>] do_sync_write+0x55/0x90
[ 2809.764604]  [<ffffffff8115d38a>] vfs_write+0xba/0x1f0
[ 2809.764604]  [<ffffffff8115d89a>] SyS_write+0x4a/0xa0
[ 2809.764604]  [<ffffffff817f1f29>] system_call_fastpath+0x16/0x1b
[ 2809.764604] Code: 00 00 48 89 44 24 10 8b 87 c0 00 00 00 48 89 44 24 08 =
48 8b 87 d0 00 00 00 48 c7 c7 30 67 a3 81 48 89 04 24 31 c0 e8 0d 8b ff ff =
<0f> 0b 55 48 89 f8 48 8b 57 30 48 89 e5 48 8b 0f 5d 80 e5 80 48=20
[ 2809.764604] RIP  [<ffffffff817eb99d>] skb_panic+0x5e/0x60
[ 2809.764604]  RSP <ffff88001fc03cf8>


--=-OGhhBVwrkpU+MtE2h6uZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJUc7CMAAoJENpWdD1eHU4JhYgP/RjlCPcvxO8wVDPUNxrRsR1t
b55aQzhARXJmYu2Y7a91JFPusQShpYIUjmLlLx4NkXxVGX3f07WPiIwfV+qjdym2
jxKcrWeQkaAR9FkNUHtpvJD8K+cOrDfta5UULgoqaeAqe8v3jdJ9cz/eQWnlxo3e
raZYTdw7kxq/V/5CyFNSMndgqHS1YsvIf/sv+ZQKv9IBfczWaKdlZvjPVz1jDFPk
5KrR4URLAoBj+KZPzTxaTw3ol3znPhIWkvVtgMtnscr5ttyp/wc3+HT/x05xnAl9
vnuNhvvF1wUeaMpA8wP665m9jRhbbUqNRoaPZioWpjUSyXWX0jr+cC49Kzws/R8m
bVJVzVpHSXgpI2kSyMOkCcFvCljFe1w0SXHLzIY0EGNp7TU8mmb3eW1pm9PU4Dym
zRVQZOAYv/AWziNpChYqSUpSh3Bcp0n1pGvSNAw0Q9rhEoYCGnbW64SEG7OD3US7
iwBMCKJJdmMw/Fq3AE8/5TtXuj6RmVmWjrdLmfwoU47mkdUWa6Fvvln1I8VvdtWl
3cNotsg8UOJWmnrfxgPEx3fOkuxZKbSZdqI2I2Ycx8PF84RVodJ2g5s7CnrQ6PWN
9FHpT55uPMhJHH+CtF5NnJUyBxLPxWY/DUJk9ipBLPoyMJ+OFqOnheaOA8oA271N
XG7Qa1pcjm5I+ZMWjC0q
=nD19
-----END PGP SIGNATURE-----

--=-OGhhBVwrkpU+MtE2h6uZ--

