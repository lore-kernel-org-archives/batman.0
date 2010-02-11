Return-Path: <linus.luessing@web.de>
Date: Thu, 11 Feb 2010 03:39:09 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100211023909.GB6493@Linus-Debian>
References: <4B6F288E.8050406@muc.ccc.de> <20100210024321.GB2112@Linus-Debian>
	<4B7301BC.7080809@muc.ccc.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cmJC7u66zC7hs+87"
Content-Disposition: inline
In-Reply-To: <4B7301BC.7080809@muc.ccc.de>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] batman-adv 0.2 on openwrt
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Argh, okay. I guess, you had batman-adv on your laptops already
running and the wifi interfaces up when starting batman-adv on
your laptop, right?

Could you have a look, if this kernel panic also occures, when you
start batman-adv on your router first? I'd like to know if this
might be related to the bug stated here [0].


If I remember right, then you were saying that you're using the
8.09.2 release of OpenWRT. Otherwise you could have activated
"Compile the kernel with symbol table information" under "make
menuconfig" --> "Global build settings" to add some function names
to those nice numbers :)

Or does anyone of the others know if/how ksymoops could be
useful/used in this situation to extract the function names
afterwards?

Cheers, Linus

[0]:
https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2010-February/002281.html

On Wed, Feb 10, 2010 at 07:58:04PM +0100, x@muc.ccc.de wrote:
> hi!
>=20
> Linus L=C3=BCssing wrote:
> > please try the patch I've posted here:
>=20
> i tested the patch, and the box doesn't freeze anymore when loading the m=
odule!
> then i bring up the interfaces (bat0 and ath1) - ok.
> then i echo ath1 >/proc/net/batman-adv/interfaces - then this happens:
>=20
> ------------[ cut here ]------------
> WARNING: at net/core/dev.c:1454 ()
> Modules linked in: batman_adv w1_therm cdc_ether usb_storage usbserial us=
bnet wire ehci_hcd ath_pci ath_hal(P) ip6t_mh nf_nat_tftp nf_conntrack_tftp=
 nf_nat_irc
> nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp ipt_MASQUERADE iptable_nat n=
f_nat xt_state nf_conntrack_ipv4 nf_conntrack sd_mod ipt_REJECT xt_TCPMSS i=
pt_LOG xt_multiport xt_mac xt_limit iptable_mangle iptable_filter ip_tables=
 xt_tcpudp x_tables tun ppp_async ppp_generic slhc crc_ccitt usbcore scsi_m=
od [last unloaded: batman_adv]
> Function entered at [<c0023890>] from [<c0030234>]
> Function entered at [<c00301f0>] from [<c013c348>]
>  r6:00004305 r5:c7216d80 r4:c7216d80
> Function entered at [<c013c2c0>] from [<c013c60c>]
>  r7:c71bd000 r6:c7f997c0 r5:c7216d80 r4:c71bd000
> Function entered at [<c013c484>] from [<c013f154>]
>  r7:bf081ba0 r6:c7f997c0 r5:c7216d80 r4:c71bd000
> Function entered at [<c013ef7c>] from [<bf078f8c>]
>  r8:bf081ba0 r7:bf081ba0 r6:c7f997c0 r5:c7216d80 r4:c71efe60
> Function entered at [<bf078ec8>] from [<bf07900c>]
>  r7:c7f997c0 r6:c7f5b200 r5:00000016 r4:c7216d80
> Function entered at [<bf078fa8>] from [<bf07917c>]
>  r8:00000000 r7:00000000 r6:00000001 r5:c7f997c0 r4:c715dba0
> Function entered at [<bf079010>] from [<c003f830>]
>  r6:c00401a0 r5:c71e8000 r4:c7167cc0
> Function entered at [<c003f784>] from [<c0040248>]
>  r5:c7167cc0 r4:c7167cc8
> Function entered at [<c00401a0>] from [<c00432b8>]
>  r5:c7167cc0 r4:c71e8000
> Function entered at [<c0043260>] from [<c0033214>]
>  r6:00000000 r5:00000000 r4:00000000
> ---[ end trace da97f061c7bedcb9 ]---
> Unable to handle kernel paging request at virtual address 6e2d6164
> pgd =3D c0004000
> [6e2d6164] *pgd=3D00000000
> Internal error: Oops: f5 [#1]
> Modules linked in: batman_adv w1_therm cdc_ether usb_storage usbserial us=
bnet wire ehci_hcd ath_pci ath_hal(P) ip6t_mh nf_nat_tftp nf_conntrack_tftp=
 nf_nat_irc nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp ipt_MASQUERADE ipt=
able_nat nf_nat xt_state nf_conntrack_ipv4 nf_conntrack sd_mod ipt_REJECT x=
t_TCPMSS ipt_LOG xt_multiport xt_mac xt_limit iptable_mangle iptable_filter=
 ip_tables xt_tcpudp x_tables tun ppp_async ppp_generic slhc crc_ccitt usbc=
ore scsi_mod [last unloaded: batman_adv]
> CPU: 0    Tainted: P        W  (2.6.26.8 #5)
> pc : [<c005e634>]    lr : [<c0136788>]    psr: 80000013
> sp : c71e9e8c  ip : c71e9e9c  fp : c71e9e98
> r10: 00000000  r9 : 00000000  r8 : bf081ba0
> r7 : c71bd000  r6 : c7f997c0  r5 : c7216d80  r4 : 00000001
> r3 : 0000ffff  r2 : c71efe60  r1 : c71efe1e  r0 : 6e2d6164
> Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
> Control: 000039ff  Table: 07ed8000  DAC: 00000017
> Process bat_events (pid: 3001, stack limit =3D 0xc71e8260)
> Stack: (0xc71e9e8c to 0xc71ea000)
> 9e80:                            c71e9eb0 c71e9e9c c0136788 c005e634 c721=
6d80
> 9ea0: c7216d80 c71e9ec4 c71e9eb4 c0136e98 c0136724 c7216d80 c71e9ed8 c71e=
9ec8
> 9ec0: c0136598 c0136e00 c71bd000 c71e9ee8 c71e9edc c0136694 c0136590 c71e=
9f10
> 9ee0: c71e9eec c013c6ec c0136654 c0136724 c7216d80 c71bd000 c7216d80 c7f9=
97c0
> 9f00: bf081ba0 c71e9f34 c71e9f14 c013f154 c013c490 c71efe60 c7216d80 c7f9=
97c0
> 9f20: bf081ba0 bf081ba0 c71e9f54 c71e9f38 bf078f8c c013ef88 c7216d80 0000=
0016
> 9f40: c7f5b200 c7f997c0 c71e9f78 c71e9f58 bf07900c bf078ed4 c715dba0 c7f9=
97c0
> 9f60: 00000001 00000000 00000000 c71e9f94 c71e9f7c bf07917c bf078fb4 c716=
7cc0
> 9f80: c71e8000 c00401a0 c71e9fac c71e9f98 c003f830 bf07901c c7167cc8 c716=
7cc0
> 9fa0: c71e9fd8 c71e9fb0 c0040248 c003f790 00000000 c7f6b200 c00435f4 c71e=
9fbc
> 9fc0: c71e9fbc c71e8000 c7167cc0 c71e9ff4 c71e9fdc c00432b8 c00401ac 0000=
0000
> 9fe0: 00000000 00000000 00000000 c71e9ff8 c0033214 c004326c 00000000 0000=
0000
> Backtrace:
> Function entered at [<c005e628>] from [<c0136788>]
> Function entered at [<c0136718>] from [<c0136e98>]
>  r5:c7216d80 r4:c7216d80
> Function entered at [<c0136df4>] from [<c0136598>]
>  r4:c7216d80
> Function entered at [<c0136584>] from [<c0136694>]
>  r4:c71bd000
> Function entered at [<c0136648>] from [<c013c6ec>]
> Function entered at [<c013c484>] from [<c013f154>]
>  r7:bf081ba0 r6:c7f997c0 r5:c7216d80 r4:c71bd000
> Function entered at [<c013ef7c>] from [<bf078f8c>]
>  r8:bf081ba0 r7:bf081ba0 r6:c7f997c0 r5:c7216d80 r4:c71efe60
> Function entered at [<bf078ec8>] from [<bf07900c>]
>  r7:c7f997c0 r6:c7f5b200 r5:00000016 r4:c7216d80
> Function entered at [<bf078fa8>] from [<bf07917c>]
>  r8:00000000 r7:00000000 r6:00000001 r5:c7f997c0 r4:c715dba0
> Function entered at [<bf079010>] from [<c003f830>]
>  r6:c00401a0 r5:c71e8000 r4:c7167cc0
> Function entered at [<c003f784>] from [<c0040248>]
>  r5:c7167cc0 r4:c7167cc8
> Function entered at [<c00401a0>] from [<c00432b8>]
>  r5:c7167cc0 r4:c71e8000
> Function entered at [<c0043260>] from [<c0033214>]
>  r6:00000000 r5:00000000 r4:00000000
> Code: e89da800 e1a0c00d e92dd800 e24cb004 (e5903000)
> Kernel panic - not syncing: Fatal exception in interrupt
>=20
> hope this helps in some way.
>=20
> regards,
>=20
> 	Chris
>=20

--cmJC7u66zC7hs+87
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJLc23NAAoJEBKw7u43QNpfZToP/RLcftZeeXVl0oxthSdK8x8a
4LPC8g/uL4uA8RVqFrBZRjNOKAd61udjKEz6ax3hCwmtrVXfyTZtzJNhb74wPrv4
bkm3RqKTlffW2i6DicfqS9rm2bh09I1w5bH5t/P/+Vhik6GUkHz+uvmk15OtbVrl
TBEnsROqg3qdqjxfEntl4lKZgQr4atKg5YcOdXmkj/UtVlm3GfNM/IQGF77VQrmu
PaVEREnPa82XHzaJnREHOQZFsRqUSmqDUk/bwbQHRGUMILRrE5Vihg9sO1oIA5mr
7GCsmJQZatTPrZCAF373Gnp44o1l6BCxIhv4IuEDoxNVKOHwuV0OhDtu2YiUt3F+
s8EFsfuyDytj4etdu6hRzMBpmMA5PXhMoUAc3OeAfTFGaPw3i5B0D6sAqrj31lud
ffzonUibnzJNvjvo8VcvuacyobqxpG/ke0uG1UcI9QA/fZTqhZvxCISeC7LJXA+P
6M2vfRePFhjdaE04LXSXagkX2tlIasBWaaeqIGcpjIkn3yMxsNQVZs+UYKu/Betn
0gmgdIP+pqDigNgexGC0CTGrSHNhY+R5E5V1EcQ+qhPlYffr6dYl1U5aK7PfVQf9
kwafjZwyD7yfc0y8RTUPv3F0P5QCyzDboAI/pe9VB+Gwe0iX/Ug+/yWU35aMLL9E
jdRRnHjD5QlikdiCntJ4
=BufT
-----END PGP SIGNATURE-----

--cmJC7u66zC7hs+87--
