Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu, 12 Aug 2010 12:32:15 +0200
References: <4C63C96F.8070001@web.de>
In-Reply-To: <4C63C96F.8070001@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2441474.JDfs2iOife";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201008121232.18496.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Problem openWRT "backfire" and "kmod-batman-adv"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Tim Glaremin <Tim.Glaremin@web.de>

--nextPart2441474.JDfs2iOife
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Tim Glaremin wrote:
[...]
> CPU 0 Unable to handle kernel paging request at virtual address
> 00003aa1, epc =3D=3D 80a982f4, ra =3D=3D 80a982dc
> Oops[#1]:
> Cpu 0
> $ 0   : 00000000 10009800 3c9c2500 80d9e800
> $ 4   : 803df888 00003a9e 00003a98 00000000
> $ 8   : 00000004 00000001 00000000 fffffffb
> $12   : 0000000f 80238688 ffffffff 80c47bc8
> $16   : 80435e80 80d9e800 80a9c314 80cd26c0
> $20   : 00000008 7fd6fd80 7fd6fcd0 00000001
> $24   : 0000003c 8f1bbcdc
> $28   : 80c46000 80c47d58 00475028 80a982dc
> Hi    : 00000103
> Lo    : 68655100
> epc   : 80a982f4 0x80a982f4
>      Not tainted
> ra    : 80a982dc 0x80a982dc
> Status: 10009803    KERNEL EXL IE
> Cause : 0080000c
> BadVA : 00003aa1
> PrId  : 00029008 (Broadcom BCM3302)
> Modules linked in: batman_adv nf_nat_tftp nf_conntrack_tftp nf_nat_irc
> nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp ipt_MASQUERADE iptable_nat
> nf_nat xt_NOTRACK iptable_raw xt_state nf_conntrack_ipv4 nf_defrag_ipv4
> nf_conntrack pppoe pppox ipt_REJECT xt_TCPMSS ipt_LOG xt_comment
> xt_multiport xt_mac xt_limit iptable_mangle iptable_filter ip_tables
> xt_tcpudp x_tables ppp_async ppp_generic slhc b43legacy b43 mac80211
> crc_ccitt cfg80211 compat_firmware_class compat arc4 aes_generic deflate
> ecb cbc switch_robo switch_core diag [last unloaded: batman_adv]
> Process hostapd (pid: 2057, threadinfo=3D80c46000, task=3D80739048,
> tls=3D00000000)
> Stack : 80435e80 80d9e800 80a9c314 80cd26c0 80435e80 80a98a5c 80e712a8
> fffffff2
>          00000000 80d9e800 00000000 fffffff0 00000000 80d9e800 00000008
> 800430c0
>          00000000 80d9e800 00000000 801a2eb0 00000000 80d9e800 7fd6fcf0
> 00000000
>          80c47e18 8004325c 00000000 7fd6fcf0 00008914 00000000 00000000
> ffffffed
>          80d9e800 801a6e18 802c4c90 801a7e40 00000000 0000001d 00008924
> 00008924
>          ...
> Call Trace:[<80a98a5c>] 0x80a98a5c
> [<800430c0>] 0x800430c0
> [<801a2eb0>] 0x801a2eb0
> [<8004325c>] 0x8004325c
> [<801a6e18>] 0x801a6e18
> [<801a7e40>] 0x801a7e40
> [<801a8aa4>] 0x801a8aa4
> [<80190a00>] 0x80190a00
> [<800a2858>] 0x800a2858
> [<800a6270>] 0x800a6270
> [<800a2f90>] 0x800a2f90
> [<80192028>] 0x80192028
> [<80191330>] 0x80191330
> [<800a3034>] 0x800a3034
> [<80192878>] 0x80192878
> [<80003230>] 0x80003230
>=20
>=20
> Code: 24c50006  88820003  98820000 <a8a20003> b8a20000  90830004
> a0a30004  90820005  a0a20005
> Disabling lock debugging due to kernel taint"
>=20
> Hope all this info helps you, for me it's only confusing :)

you must provide the symbols file for us to create any useful information f=
or=20
us. But I would think that my guess about the netdev notification was right.

thanks,
	Sven

--nextPart2441474.JDfs2iOife
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMY82xAAoJEF2HCgfBJntGVhsP/RAfDfnj7YGqNWF1rekiIUkc
BGqV8RGjlXu4FDtrw5SYmsh6tqkM3kk5Cd1ruMaRoC4Tu70MZLX5bCeWd7SXPb0P
utuIBYRw9yRUSn9gGu2ICcXScjS83Tl3RmXS9j0ZfS6QfFs6IHwiLnZzXUifCoE3
U6XnNeISvtAskY+vOo84j4nUAEZY35//uyDUxSIO/85hiWolw25UEukSl2DTddTd
8XXdn1q9OyDUqYBAg8ubz26JtRDnsmj/2zMmJ7QbcvwQkC3F0g94u2we0dUfH2c4
o4ojuz9aKzkcPLd3Sn1mbAlFNJbmutSrOMmYwi/hLe1s6oCclA6eHo/nTLmD8ePe
n+9XmVY5r8Dzl2Flwqh1rpDCYwV/bZhsPbtqoaLEVaV719J5ORDcV0wcxh1mrVOv
UXhF53DSsgTsOm7r6ivHBqOfewEaG+ny0pi6lVcdBQgx2AQ3OModmcbJ5J7VnM8c
z7lompJ6JEc9SjThlk8Jio/pEUGgzywUNvffedA2P2EbHeFSRd/zaF7kON2MSDzS
xWlgR1pocKzZbEC8hhFasaU/y9TklZVvVAPJGxA4UzqUOqg5fB4VW6ufxEJ6ebe2
hiGsU9+BIVdxg0pjoSMxMesT1p40C0oXnQCCZaWLmbi1yDGECuBsKjSYnGfn6rAL
xrUQjjoFLPhBRhDDtpaa
=EvOy
-----END PGP SIGNATURE-----

--nextPart2441474.JDfs2iOife--
