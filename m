From: Sven Eckelmann <sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Batman gateway lock ups
Date: Tue, 9 Sep 2008 10:03:56 +0200
References: <5635aa0d0809050801k1c5f0bd5wa366574efedd910f@mail.gmail.com>
	<200809082318.54082.sven.eckelmann@gmx.de>
	<200809082345.55714.sven.eckelmann@gmx.de>
In-Reply-To: <200809082345.55714.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2203884.SaXQW5S3Pm";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200809091004.02772.sven.eckelmann@gmx.de>
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

--nextPart2203884.SaXQW5S3Pm
Content-Type: multipart/mixed;
  boundary="Boundary-01=_s3ixI/ePQxhp6+k"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_s3ixI/ePQxhp6+k
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 08 September 2008 23:45:55 Sven Eckelmann wrote:
> I got the System.map right now. So we can convert the kernel oops into
> something more readable. It doesn't help that much now, but... just for
> sake of completeness
Sry, forgot the second oops with the interesting address of the paging=20
failure.

Best regards
	Sven Eckelmann


--Boundary-01=_s3ixI/ePQxhp6+k
Content-Type: text/plain; charset="iso-8859-15"; name="informative_ooops2.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="informative_ooops2.txt"

CPU 0 Unable to handle kernel paging request at virtual address 00200200, epc == c00c8aa4, ra == c00c8a90
Cpu 0
$ 0   : 00000000 10009c00 00100100 00100100
$ 4   : 00200200 00000001 00000000 00000000
$ 8   : 00000000 8071aa28 0000000b 127a3980
$12   : 0000000b ebc20000 0000045d 67350e80
$16   : 80ac1600 00000000 c00c9a28 00000064
$20   : c00d0000 00000000 0006ab6e 8071d93d
$24   : 8071d730 00008000
$28   : 8071c000 8071d890 00000000 c00c8a90
Hi    : 00000140
Lo    : 68fdd3c0
epc   : c00c8aa4     Tainted: P
Cause : 3080000c
        8071d9a0 000005dc 8071d93d 00000054 000210d2 05a82b6e 00000000 00000000
        00020000 c00505f1 8026dd80 8071db60 000210d2 00000000 00000000 801ca5e8
        00000000 8071a9f8 8007d41c 8071d8fc 8071d8fc 8071d8c0 00000010 8071d8b0
        00000001 00000000 00000000 00004040 8071d8d0 00000010 8071d8b8 00000001
Call Trace:[<801ca5e8>][<8007d41c>][<801c018c>][<801ba0d0>][<801bbf74>][<8020f0d4>][<8020f95c>][<8020f95c>][<c015b2f4>][<c0161e80>][<8008bfe0>][<8008dfac>][<801ca110>][<800431e8>][<800437a4>][<c0106840>][<80050000>][<c01549f0>][<c015f7b0>][<c015f7f0>][<c0161e80>][<80079f5c>][<8006f8d0>][<8008bfe0>][<8006b778>][<8006b1e0>][<8006b2c4>][<c015f694>][<800437a4>][<80279960>][<8005fa64>][<800ba4d4>][<8005e8d4>][<8005cd38>][<8005d578>][<800b6d24>][<800b6d1c>][<802276d8>][<8022656c>][<8006704c>][<80067044>][<800691d4>][<80072f64>][<80072e54>][<80069290>][<80073a00>][<8005e5f0>][<80046aa0>][<8005e5f0>][<8005cd04>][<8005e8d4>][<8005e0e4>][<8005cd38>][<8005d578>][<8007d0b0>][<8022656c>][<c00c8650>][<8007d108>][<8007d0e8>][<80045698>][<80045688>]
Code: 3c020010  34420100  8e110008 <ac830000> ae020000  3c020020  34420200  ac640004  16200011


>>???; c00c8aa4 <END_OF_CODE+3fe1d474/????>   <=====

Trace; 801ca5e8 <ip_local_deliver_finish+0/2c0>
Trace; 8007d41c <autoremove_wake_function+0/44>
Trace; 801c018c <udp_packet+f0/114>
Trace; 801ba0d0 <nf_conntrack_find_get+c8/dc>
Trace; 801bbf74 <nf_conntrack_in+4ac/6f8>
Trace; 8020f0d4 <ipt_do_table+50c/588>
Trace; 8020f95c <nf_nat_fn+20c/244>
Trace; 8020f95c <nf_nat_fn+20c/244>
Trace; c015b2f4 <END_OF_CODE+3feafcc4/????>
Trace; c0161e80 <END_OF_CODE+3feb6850/????>
Trace; 8008bfe0 <handle_IRQ_event+64/d4>
Trace; 8008dfac <handle_level_irq+c0/114>
Trace; 801ca110 <ip_rcv_finish+0/4d8>
Trace; 800431e8 <ar5315_irq_dispatch+26c/2a4>
Trace; 800437a4 <ret_from_irq+0/4>
Trace; c0106840 <END_OF_CODE+3fe5b210/????>
Trace; 80050000 <blast_icache64_page_indexed+0/e4>
Trace; c01549f0 <END_OF_CODE+3fea93c0/????>
Trace; c015f7b0 <END_OF_CODE+3feb4180/????>
Trace; c015f7f0 <END_OF_CODE+3feb41c0/????>
Trace; c0161e80 <END_OF_CODE+3feb6850/????>
Trace; 80079f5c <rcu_process_callbacks+1c/38>
Trace; 8006f8d0 <run_timer_softirq+20/1fc>
Trace; 8008bfe0 <handle_IRQ_event+64/d4>
Trace; 8006b778 <tasklet_action+118/198>
Trace; 8006b1e0 <__do_softirq+78/100>
Trace; 8006b2c4 <do_softirq+5c/94>
Trace; c015f694 <END_OF_CODE+3feb4064/????>
Trace; 800437a4 <ret_from_irq+0/4>
Trace; 80279960 <cpu_probe+584/994>
Trace; 8005fa64 <__wake_up_sync+3c/74>
Trace; 800ba4d4 <__fput+188/1cc>
Trace; 8005e8d4 <dequeue_entity+98/d8>
Trace; 8005cd38 <dequeue_task+1c/30>
Trace; 8005d578 <pick_next_task_fair+38/78>
Trace; 800b6d24 <filp_close+74/90>
Trace; 800b6d1c <filp_close+6c/90>
Trace; 802276d8 <cond_resched+44/5c>
Trace; 8022656c <schedule+1e0/7d4>
Trace; 8006704c <put_files_struct+188/208>
Trace; 80067044 <put_files_struct+180/208>
Trace; 800691d4 <do_exit+960/96c>
Trace; 80072f64 <dequeue_signal+13c/17c>
Trace; 80072e54 <dequeue_signal+2c/17c>
Trace; 80069290 <sys_exit_group+0/c>
Trace; 80073a00 <get_signal_to_deliver+444/498>
Trace; 8005e5f0 <enqueue_entity+2fc/33c>
Trace; 80046aa0 <do_notify_resume+64/3ec>
Trace; 8005e5f0 <enqueue_entity+2fc/33c>
Trace; 8005cd04 <enqueue_task+1c/34>
Trace; 8005e8d4 <dequeue_entity+98/d8>
Trace; 8005e0e4 <try_to_wake_up+84/d8>
Trace; 8005cd38 <dequeue_task+1c/30>
Trace; 8005d578 <pick_next_task_fair+38/78>
Trace; 8007d0b0 <kthread+0/b0>
Trace; 8022656c <schedule+1e0/7d4>
Trace; c00c8650 <END_OF_CODE+3fe1d020/????>
Trace; 8007d108 <kthread+58/b0>
Trace; 8007d0e8 <kthread+38/b0>
Trace; 80045698 <kernel_thread_helper+10/18>
Trace; 80045688 <kernel_thread_helper+0/18>


--Boundary-01=_s3ixI/ePQxhp6+k--

--nextPart2203884.SaXQW5S3Pm
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkjGLewACgkQqQGwKVlMoDtx0wCg/r15ybU8kR3fd5a4xCSOhOkQ
2xAAoKglaP4qdzCKzAl84fYi9WsvXrWG
=mA5u
-----END PGP SIGNATURE-----

--nextPart2203884.SaXQW5S3Pm--
