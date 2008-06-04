From: Sven Eckelmann <sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Batman-Advanced Kernel land
Date: Wed, 4 Jun 2008 18:11:31 +0200
References: <4846B27B.9020907@csp.it>
In-Reply-To: <4846B27B.9020907@csp.it>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart15959077.0KFyJDmU5K";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200806041811.38881.sven.eckelmann@gmx.de>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: cipollone@csp.it, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

--nextPart15959077.0KFyJDmU5K
Content-Type: multipart/mixed;
  boundary="Boundary-01=_z6rRI5mArF88KKx"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_z6rRI5mArF88KKx
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

> Someone can help me?
Can you please test it further?
I used uml with linux 2.6.22.5 and uml_switch configured as hub to produce =
the=20
same problem, but dotslash told me that he wasn't able to reproduce it with=
=20
his uml image (2.6.24 based). Maybe I can help him to get the same effect i=
t=20
so he can try to find the problem.

Best Regards
	Sven

--Boundary-01=_z6rRI5mArF88KKx
Content-Type: text/plain;
  charset="iso-8859-15";
  name="ping_of_death.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ping_of_death.txt"

backtrace:
#0  0x0805621a in from_irq_stack (nested=0) at arch/um/kernel/irq.c:574
#1  0x0806594a in handle_signal (sig=0, sc=0x8203d24) at arch/um/os-Linux/signal.c:156
#2  0x080674fb in hard_handler (sig=29) at arch/um/os-Linux/sys-i386/signal.c:12
#3  <signal handler called>
#4  0xf7f39592 in tcsetattr () from /lib32/libc.so.6
#5  0x0805ad4c in generic_console_write (fd=1, buf=0x821c797 "WARNING: at net/core/skbuff.c:326 __kfree_skb()\n", n=48) at arch/um/drivers/chan_user.c:45
#6  0x0805a595 in console_write_chan (chans=0x82056f0, buf=0x821c797 "WARNING: at net/core/skbuff.c:326 __kfree_skb()\n", len=48) at arch/um/drivers/chan_kern.c:352
#7  0x08059e56 in uml_console_write (console=0x8205ca0, string=0x821c797 "WARNING: at net/core/skbuff.c:326 __kfree_skb()\n", len=48) at arch/um/drivers/stdio_console.c:132
#8  0x0806f73f in __call_console_drivers (start=2935, end=2983) at kernel/printk.c:331
#9  0x0806f7b3 in _call_console_drivers (start=2935, end=2983, msg_log_level=4) at kernel/printk.c:361
#10 0x0806f888 in call_console_drivers (start=2932, end=2983) at kernel/printk.c:404
#11 0x0806fd68 in release_console_sem () at kernel/printk.c:827
#12 0x0806fbaf in vprintk (fmt=0x81d027b "WARNING: at %s:%d %s()\n", args=0x87f8094 "\216l\036\bF\001") at kernel/printk.c:613
#13 0x0806f9c3 in printk (fmt=0x81d027b "WARNING: at %s:%d %s()\n") at kernel/printk.c:507
#14 0x08150281 in __kfree_skb (skb=0x87fce40) at net/core/skbuff.c:326
#15 0x081502c4 in kfree_skb (skb=0x87f7e90) at net/core/skbuff.c:362
#16 0x0805d66d in uml_net_start_xmit (skb=0x87fce40, dev=0x2753e960) at arch/um/drivers/net_kern.c:208
#17 0x0815561a in dev_hard_start_xmit (skb=0x87fce40, dev=0x2753e960) at net/core/dev.c:1416
#18 0x08160372 in __qdisc_run (dev=0x2753e960) at net/sched/sch_generic.c:129
#19 0x0815575c in dev_queue_xmit (skb=0x87fce40) at include/net/pkt_sched.h:89
#20 0x081997d6 in packet_sendmsg (iocb=0x87f816c, sock=0x273d8050, msg=0x87f8280, len=121) at net/packet/af_packet.c:783
#21 0x0814c118 in sock_sendmsg (sock=0x273d8050, msg=0x87f8280, size=121) at net/socket.c:557
#22 0x0814c16a in kernel_sendmsg (sock=0x273d8050, msg=0x87f8280, vec=0x87f829c, num=2, size=121) at net/socket.c:587
#23 0x27883272 in send_raw_packet (pack_buff=0x269aad69 "\003\006\002", pack_buff_len=107, src_addr=0x5404 <Address 0x5404 out of bounds>, dst_addr=0x2689a500 "\002", batman_if=0x27334848)
    at /host/batman-adv-kernelland/batman-core/send.c:77
#24 0x27884f3c in interface_tx (skb=0x87fcad0, dev=0x8782d20) at /host/batman-adv-kernelland/batman-core/soft-interface.c:234
#25 0x0815561a in dev_hard_start_xmit (skb=0x87fcad0, dev=0x8782d20) at net/core/dev.c:1416
#26 0x08160372 in __qdisc_run (dev=0x8782d20) at net/sched/sch_generic.c:129
#27 0x0815575c in dev_queue_xmit (skb=0x87fcad0) at include/net/pkt_sched.h:89
#28 0x0815a413 in neigh_resolve_output (skb=0x87fcad0) at net/core/neighbour.c:1169
---Type <return> to continue, or q <return> to quit---
#29 0x0816a0a1 in ip_output (skb=<value optimized out>) at include/net/neighbour.h:319
#30 0x0816bab5 in ip_push_pending_frames (sk=0x8357b28) at include/net/dst.h:233
#31 0x0818574a in icmp_push_reply (icmp_param=0x87f8450, ipc=0x87f8424, rt=0x26ee7c60) at net/ipv4/icmp.c:370
#32 0x08185864 in icmp_reply (icmp_param=0x87f8450, skb=0x87fc290) at net/ipv4/icmp.c:415
#33 0x08185efc in icmp_echo (skb=0x5404) at net/ipv4/icmp.c:796
#34 0x08186203 in icmp_rcv (skb=0x87fc290) at net/ipv4/icmp.c:990
#35 0x08167838 in ip_local_deliver (skb=0x87fc290) at net/ipv4/ip_input.c:234
#36 0x08167bfd in ip_rcv (skb=<value optimized out>, dev=0x8782d20, pt=0x8216120, orig_dev=0x8782d20) at include/net/dst.h:242
#37 0x08155b29 in netif_receive_skb (skb=0x87fc290) at net/core/dev.c:1915
#38 0x08155be7 in process_backlog (backlog_dev=0x8228e1c, budget=0x87f855c) at net/core/dev.c:1949
#39 0x08155cba in net_rx_action (h=0x821fcb8) at net/core/dev.c:1997
#40 0x080739b8 in __do_softirq () at kernel/softirq.c:231
#41 0x08073a42 in do_softirq () at kernel/softirq.c:268
#42 0x08073924 in local_bh_enable () at kernel/softirq.c:155
#43 0x0815580b in dev_queue_xmit (skb=0x87fcad0) at net/core/dev.c:1604
#44 0x081997d6 in packet_sendmsg (iocb=0x87f85fc, sock=0x273d8050, msg=0x87f8710, len=121) at net/packet/af_packet.c:783
#45 0x0814c118 in sock_sendmsg (sock=0x273d8050, msg=0x87f8710, size=121) at net/socket.c:557
#46 0x0814c16a in kernel_sendmsg (sock=0x273d8050, msg=0x87f8710, vec=0x87f872c, num=2, size=121) at net/socket.c:587
#47 0x27883272 in send_raw_packet (pack_buff=0x87f8786 "\003\006\002", pack_buff_len=107, src_addr=0x5404 <Address 0x5404 out of bounds>, dst_addr=0x2689a500 "\002", batman_if=0x27334848)
    at /host/batman-adv-kernelland/batman-core/send.c:77
#48 0x278847c4 in packet_recv_thread (data=0x0) at /host/batman-adv-kernelland/batman-core/routing.c:675
#49 0x0807f9c8 in kthread (_create=0x87f7ef4) at kernel/kthread.c:78
#50 0x08064efd in run_kernel_thread (fn=0x807f985 <kthread>, arg=0x87f7ef4, jmp_ptr=0x2744f80c) at arch/um/os-Linux/process.c:295
#51 0x08059129 in new_thread_handler () at arch/um/kernel/skas/process.c:64
#52 0xa55a5a5a in ?? ()

dmesg:
batman-adv: B.A.T.M.A.N. Advanced 0.1-beta (compability version 6) loaded
WARNING: at net/core/skbuff.c:326 __kfree_skb()

--Boundary-01=_z6rRI5mArF88KKx--

--nextPart15959077.0KFyJDmU5K
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkhGvrMACgkQqQGwKVlMoDt6ZQCghRLBsEdmKjXlTsMwJyV/jKlA
xpYAnjNiCi1AuJV6oxo7C7c8P2/O0plX
=5TKD
-----END PGP SIGNATURE-----

--nextPart15959077.0KFyJDmU5K--
