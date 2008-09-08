From: Sven Eckelmann <sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Batman gateway lock ups
Date: Mon, 8 Sep 2008 23:45:55 +0200
References: <5635aa0d0809050801k1c5f0bd5wa366574efedd910f@mail.gmail.com>
	<200809082318.54082.sven.eckelmann@gmx.de>
In-Reply-To: <200809082318.54082.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2451959.Wur44SCcCL";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200809082345.55714.sven.eckelmann@gmx.de>
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

--nextPart2451959.Wur44SCcCL
Content-Type: multipart/mixed;
  boundary="Boundary-01=_T0ZxILHD/aR11jz"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_T0ZxILHD/aR11jz
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 08 September 2008 23:18:42 Sven Eckelmann wrote:
> Ok, I got the /proc/modules file now. Current situation is following: it
> crashes inside the the batman module add position 0x00000aa4
> [..]
I got the System.map right now. So we can convert the kernel oops into=20
something more readable. It doesn't help that much now, but... just for sak=
e=20
of completeness

END_OF_CODE+3fe1d020 is the batgat.ko when we search for c00c8650 inside=20
/proc/modules

Best regards
	Sven Eckelmann

--Boundary-01=_T0ZxILHD/aR11jz
Content-Type: text/plain; charset="iso-8859-15"; name="informative_ooops.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="informative_ooops.txt"

CPU 0 Unable to handle kernel paging request at virtual address 00000000, epc == c00c8aa4, ra == c00c8a90
Cpu 0
$ 0   : 00000000 10009c00 00100100 802bb600
$ 4   : 00000000 00000001 00000000 00000000
$ 8   : 00000000 806e7a28 00000007 a106af00
$12   : 00000007 270e0000 000006d0 7d96d080
$16   : 80a23500 00000000 c00c9a28 00000064
$20   : c00d0000 00000000 000b0f4f 8071193d
$24   : 80711730 00008000
$28   : 80710000 80711890 00000000 c00c8a90
Hi    : 00000140
Lo    : 68fdd3c0
epc   : c00c8aa4     Tainted: P
Cause : 3080000c
        807119a0 000005dc 8071193d 000004c0 000210d2 05a82b1a 00000000 00000000
        00020000 185352d0 2ac668cc 2ac668d4 000210d2 00000000 2ac668dc 2ac668e4
        00000000 806e79f8 8007d41c 807118fc 807118fc 807118c0 00000010 807118b0
        00000001 00000000 00000000 00004040 807118d0 00000010 807118b8 00000001
Call Trace:[<8007d41c>][<8005e5f0>][<8005cd04>][<8005e8d4>][<8005e0e4>][<8005cd38>][<8005d578>][<8007d0b0>][<8022656c>][<c00c8650>][<8007d108>][<8007d0e8>][<80045698>][<80045688>]
Code: 3c020010  34420100  8e110008 <ac830000> ae020000  3c020020  34420200  ac640004  16200011

Trace; 8007d41c <autoremove_wake_function+0/44>
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
--Boundary-01=_T0ZxILHD/aR11jz
Content-Type: text/plain;
  charset="iso-8859-15";
  name="proc_modules"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="proc_modules"

sch_htb 14048 2 - Live 0xc00e5000
ath_ahb 103616 0 - Live 0xc0150000
wlan_xauth 480 0 - Live 0xc00dc000
wlan_wep 4000 0 - Live 0xc00cf000
wlan_tkip 9856 0 - Live 0xc00d8000
wlan_ccmp 5440 3 - Live 0xc00d5000
wlan_acl 1920 0 - Live 0xc00af000
ath_rate_minstrel 8352 1 - Live 0xc00d1000
ath_hal 136832 3 ath_ahb,ath_rate_minstrel, Live 0xc012d000 (P)
wlan_scan_sta 8768 1 - Live 0xc00c1000
wlan_scan_ap 6656 0 - Live 0xc00c5000
wlan 152464 10 ath_ahb,wlan_xauth,wlan_wep,wlan_tkip,wlan_ccmp,wlan_acl,ath_rate_minstrel,wlan_scan_sta,wlan_scan_ap,Live 0xc0106000
batgat 10944 1 - Live 0xc00c8000
ipt_iprange 672 0 - Live 0xc00bf000
ipt_TOS 832 0 - Live 0xc00bd000
ipt_TTL 928 0 - Live 0xc00bb000
xt_MARK 960 0 - Live 0xc00b9000
ipt_ECN 1472 0 - Live 0xc00b7000
xt_CLASSIFY 640 0 - Live 0xc00b5000
ipt_ttl 704 0 - Live 0xc00b3000
ipt_tos 544 0 - Live 0xc00b1000
ipt_time 1568 0 - Live 0xc009d000
xt_tcpmss 1088 0 - Live 0xc00ad000
xt_statistic 832 0 - Live 0xc00ab000
xt_mark 672 7 - Live 0xc00a9000
xt_mac 736 0 - Live 0xc00a7000
xt_length 736 0 - Live 0xc00a5000
ipt_ecn 1024 0 - Live 0xc00a3000
xt_DSCP 1056 0 - Live 0xc00a1000
xt_dscp 832 0 - Live 0xc009f000
imq 2096 0 - Live 0xc0097000
ipt_IMQ 672 2 - Live 0xc009b000
xt_string 896 0 - Live 0xc0099000
xt_layer7 9840 0 - Live 0xc008f000
ipt_ipp2p 6784 0 - Live 0xc0094000
ipt_LOG 4640 0 - Live 0xc0088000
xt_CHAOS 1792 0 - Live 0xc008d000
xt_DELUDE 2624 1 - Live 0xc008b000
xt_TARPIT 2816 1 - Live 0xc0084000
xt_quota 800 0 - Live 0xc0086000
xt_portscan 2016 0 - Live 0xc0066000
xt_pkttype 704 0 - Live 0xc0082000
xt_physdev 1488 0 - Live 0xc0080000
ipt_owner 800 0 - Live 0xc007e000
iptable_raw 832 0 - Live 0xc007c000
xt_NOTRACK 832 0 - Live 0xc0076000
xt_CONNMARK 1088 0 - Live 0xc0074000
ipt_recent 4992 0 - Live 0xc0079000
xt_helper 992 0 - Live 0xc0072000
xt_conntrack 1312 0 - Live 0xc0070000
xt_connmark 832 0 - Live 0xc006e000
xt_connbytes 1312 0 - Live 0xc0068000
tun 6592 0 - Live 0xc006b000

--Boundary-01=_T0ZxILHD/aR11jz--

--nextPart2451959.Wur44SCcCL
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkjFnRMACgkQqQGwKVlMoDtq4QCg4MDUHsF4I4cP/WW+XMJijiYU
gRcAnRECdO55IWgnT/tiRHqSW0Ft58qa
=W6sw
-----END PGP SIGNATURE-----

--nextPart2451959.Wur44SCcCL--
