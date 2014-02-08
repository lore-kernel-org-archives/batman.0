Return-Path: <cmsv@wirelesspt.net>
Message-ID: <52F59F90.7000204@wirelesspt.net>
Date: Fri, 07 Feb 2014 22:08:00 -0500
From: cmsv <cmsv@wirelesspt.net>
MIME-Version: 1.0
References: <1390299725-1873-1-git-send-email-antonio@meshcoding.com>	<86mwipch0u.fsf@coulee.tdb.com>
 <86lhy8pn5v.fsf@coulee.tdb.com>	<52DF7556.9090200@makrotopia.org>
 <86y527oqpl.fsf_-_@coulee.tdb.com>	<52E003DD.6040302@meshcoding.com>
 <52E02EDC.3080805@wirelesspt.net>	<86iotbo9hw.fsf@coulee.tdb.com>
 <52E05E0F.7010203@wirelesspt.net>	<52E08DFE.9030604@makrotopia.org>
 <52E5063E.3080408@makrotopia.org>	<52E51A04.8020800@meshcoding.com>
 <52E5322D.60202@wirelesspt.net>	<52E532D0.2000907@meshcoding.com>
 <52E5341F.30800@meshcoding.com>	<52E69D7D.80905@wirelesspt.net>
 <861tzsgaub.fsf@coulee.tdb.com>	<52E70836.3050502@wirelesspt.net>
 <867g9jciol.fsf@coulee.tdb.com> <52E97715.3060306@wirelesspt.net>
In-Reply-To: <52E97715.3060306@wirelesspt.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="lrAxkOSuUGB5o5O1SH7bdUPXH3ogM6wkw"
Subject: Re: [B.A.T.M.A.N.] batman-adv: memory leak?
Reply-To: cmsv@wirelesspt.net,
 The list for a Better Approach To Mobile Ad-hoc Networking
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
To: Russell Senior <russell@personaltelco.net>
Cc: Felix Fietkau <nbd@openwrt.org>, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lrAxkOSuUGB5o5O1SH7bdUPXH3ogM6wkw
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I have an update in regards to this matter and i have CC' ed Felix
Fietkau from openwrt (athk) here too since i am using
nbd.name/aa-mac80211.git

I decided to compile new images with the latest batman-adv stable
patches and in the process of testing the new image as well as the old
one i thought to be stable i got the routers to reboot.
This time i tested this with more routers in the mesh and was able to
replicate it.

It happens that the routers reboot when the gateway disappears either by
doing batctl gw client/off or rebooting the gw router.
This then causes the others to reboot  with Kernel panic - not syncing:
Fatal exception in interrupt.

Rebooting the gw router while maintaining gw off did not seem to reboot
the other routers. With me the problem is easy to replicate when the
router gateway which is providing gateway to the clients disappears. It'
s disappearance causes the clients to reboot.

Here is the reboot log:

[  239.410000] CPU 0 Unable to handle kernel paging request at virtual
address 0000000c, epc =3D=3D 80ea7914, ra =3D=3D 80ea7910
[  239.420000] Oops[#1]:
[  239.420000] Cpu 0
[  239.420000] $ 0   : 00000000 00000001 00000000 00000000
[  239.420000] $ 4   : 81b12380 80f7fb00 00000000 00000000
[  239.420000] $ 8   : 00000037 00000000 00000000 00000000
[  239.420000] $12   : 00000000 0000015f 80e82540 00000000
[  239.420000] $16   : 81adbc00 00000000 81b12380 80f3e802
[  239.420000] $20   : 80f7fb00 00000000 00000189 00000000
[  239.420000] $24   : 00000002 80e365f0
[  239.420000] $28   : 80fe6000 80fe7ae8 00000043 80ea7910
[  239.420000] Hi    : 000001d5
[  239.420000] Lo    : 0011e189
[  239.420000] epc   : 80ea7914 0x80ea7914
[  239.420000]     Tainted: G           O
[  239.420000] ra    : 80ea7910 0x80ea7910
[  239.420000] Status: 1000f403    KERNEL EXL IE
[  239.420000] Cause : 00800008
[  239.420000] BadVA : 0000000c
[  239.420000] PrId  : 00019374 (MIPS 24Kc)
[  239.420000] Modules linked in: ath79_wdt batman_adv(O) nf_nat_irc
nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp ipt_MASQUERADE iptable_nat
nf_nat xt_conntrack xt_CT xt_NOTRACK iptable


_raw xt_state nf_conntrack_ipv4 nf_defrag_ipv4 nf_conntrack ipt_REJECT
xt_TCPMSS ipt_LOG xt_comment xt_multiport xt_mac xt_limit iptable_mangle
iptable_filter ip_tables xt_tcpudp x_tabl


es ath9k(O) ath9k_common(O) ath9k_hw(O) ath(O) mac80211(O) libcrc32c
crc16 cfg80211(O) compat(O) arc4 aes_generic crc32c crypto_hash
crypto_algapi gpio_button_hotplug(O)
[  239.420000] Process udhcpc (pid: 1267, threadinfo=3D80fe6000,
task=3D81af8850, tls=3D77929440)
[  239.420000] Stack : 00000000 00000000 00000000 00000000 0000002a
81adbc00 00000000 81adbc00
[  239.420000]         81b12000 80f3e802 81b12380 00000000 00000189
80eb1fbc 81b12000 00000000
[  239.420000]         80e8bd00 80eb86c0 00000000 00000000 00000000
801e98ac 81adbc00 00000000
[  239.420000]         81b12000 00000000 80e8bd00 80eb86c0 00000000
801ec874 00000000 80dae000
[  239.420000]         00000000 00000014 80fb7ca8 0200bc00 00000001
00000001 802e0000 81adbc00
[  239.420000]         ...
[  239.420000] Call Trace:[<80eb1fbc>] 0x80eb1fbc
[  239.420000] [<801e98ac>] 0x801e98ac
[  239.420000] [<801ec874>] 0x801ec874
[  239.420000] [<801ecd5c>] 0x801ecd5c
[  239.420000] [<8026a388>] 0x8026a388
[  239.420000] [<80218750>] 0x80218750
[  239.420000] [<802689a4>] 0x802689a4
[  239.420000] [<801dbf88>] 0x801dbf88
[  239.420000] [<80218750>] 0x80218750
[  239.420000] [<801ec874>] 0x801ec874
[  239.420000] [<80216c50>] 0x80216c50
[  239.420000] [<80218750>] 0x80218750
[  239.420000] [<801ecd5c>] 0x801ecd5c
[  239.420000] [<80216c50>] 0x80216c50
[  239.420000] [<802689b4>] 0x802689b4
[  239.420000] [<80219eb0>] 0x80219eb0
[  239.420000] [<80237bb8>] 0x80237bb8
[  239.420000] [<80239734>] 0x80239734
[  239.420000] [<8024f668>] 0x8024f668
[  239.420000] [<801101d4>] 0x801101d4
[  239.420000] [<8020e3dc>] 0x8020e3dc
[  239.420000] [<801fd38c>] 0x801fd38c
[  239.420000] [<802179f8>] 0x802179f8
[  239.420000] [<8020ff04>] 0x8020ff04
[  239.420000] [<801d8154>] 0x801d8154
[  239.420000] [<80211184>] 0x80211184
[  239.420000] [<800d8890>] 0x800d8890
[  239.420000] [<800ec6f0>] 0x800ec6f0
[  239.420000] [<801d9f58>] 0x801d9f58
[  239.420000] [<801d93dc>] 0x801d93dc
[  239.420000] [<800d9114>] 0x800d9114
[  239.420000] [<800d93dc>] 0x800d93dc
[  239.420000] [<801d9a70>] 0x801d9a70
[  239.420000] [<8006a284>] 0x8006a284
[  239.420000]
[  239.420000]
[  239.420000] Code: 0c3a9ac3  00402821  0040a821 <8c42000c> 54400052
00008021  8e050054  10a00005  8fb10010
[  239.730000] ---[ end trace 7d873dc004108502 ]---
[  239.740000] Kernel panic - not syncing: Fatal exception in interrupt
[  239.740000] Rebooting in 3 seconds..


Routers used:
dir 601a & 615c1
tplink wr703n

aa: DISTRIB_REVISION=3D"r39154"
hostapd and mac80211 from git://nbd.name/aa-mac80211.git

hostapd: sync with trunk (as of r39155)
mac80211: sync with openwrt trunk (as of r39150)

I am able to confirm that this problem does not happen with
[batman-adv: 2013.4.0] but it does happen with 2014.0.0 and it is easy
to replicate.
currently my batman-adv 2014.0.0 package as the following patches:

$ ls feeds/routing/batman-adv/patches/
0001-batman-adv-fix-batman-adv-header-overhead-calculatio.patch
0003-batman-adv-fix-soft-interface-MTU-computation.patch
0005-batman-adv-release-vlan-object-after-checking-the-CR.patch
0002-batman-adv-fix-potential-kernel-paging-error-for-uni.patch
0004-batman-adv-fix-TT-TVLV-parsing-on-OGM-reception.patch
0007-batman-adv-use-vlan_-eth_hdr-instead-of-skb-data-in-.patch



On 01/29/2014 04:48 PM, cmsv wrote:
> inline reply:
>=20
> On 01/29/2014 03:10 AM, Russell Senior wrote:
>>>>>>> "cmsv" =3D=3D cmsv  <cmsv@wirelesspt.net> writes:
>>
>>
>>>> Can you paste your feeds.conf file?
>>
>> cmsv> Of course:
>>
>>
>> cmsv> for AA and batman-adv 2014.0.0 in feeds.default.conf
>>
>> cmsv> src-svn packages svn://svn.openwrt.org/openwrt/branches/packages=
_12.09=20
>> cmsv> src-git routing git://github.com/openwrt-routing/packages.git
>>
>>
>> cmsv> For the hostapd and mentioned mac80211 you will need to clone
>> cmsv> git clone  git://nbd.name/aa-mac80211.git
>>
>> cmsv> Then obtain the specific revisions and replace the original
>> cmsv> hostapd and mac80211 from AA.
>>
>> I am not following exactly.  Do you know which change in particular
>> makes the memory leak come and go? =20
> I do not know exactly what causes the leak because i don't have the lea=
k
> in my builds and have not found a better way than the ones mentioned
> before to try to find what may cause it.
>=20
>=20
>> AA implies an older kernel, 3.3.8
>> or something.
> Yes 3.3.8
>=20
>>
>> Also, obtain specific revisions from trunk? and then copy
>> them into the AA tree? =20
>=20
> Not from trunk.  I posted the wrong git before.
> git clone git://nbd.name/aa-mac80211.git
>=20
>> package/kernel/mac80211 r39150 =3D commit 886b3c876b71122ed9523834488f=
373908224663
>> package/network/services/hostapd r39155 =3D commit 64820db4b264472e03a=
cb9ea6b5536fa7633a8ca
>>
>> Is that right?  Do those mac80211/hostapd revisions come from
>> bisection (i.e. the last "good" rev) or happenstance?
> You have to ask the maintainer. To me they are in between AA and trunk
> in terms of stability.
>=20
>=20
>=20
>> Thanks for clarification!
>>
>>
>=20


--lrAxkOSuUGB5o5O1SH7bdUPXH3ogM6wkw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJS9Z+lAAoJENmyd4cVxLOCp8gQAKZDazKT6ZP9rK2OlraGfpTG
mTnv2tfKa1//ILr7gmso6eCJJMnxkbtZkFvo8OobCoJgrCKvwUqdzvMQQJ3Yxmdg
VBkTDLiQnCQAQ2z5xXt7Ej0d6vyYL5kMpObAuBVOe9u+VwXOdSOLfxPZ9xuYgbnh
JRocNVorUQgypiDrTUK9bJhl5lWXYP2jXw+bYpjNk7K3q/xYykBVk3jvirEfsyVw
CB2HBP7Dvg269VQan5AV6n7kGiWO5lSnmkKSW1T8Zx3feQFNmgUYbKVOYZRCULs0
iS/yEqnYreT3OLXVERhjw02nNc//DaKuSJBVljpP3izUmhYduA/8UbOr27vLf0hd
ytXgocAHOkd9Me31Hnt/ZE4lPfyQgnpS25vd4L3UZK6buO+uW2OLyV9AbK+vAZ2M
oBF4RTYw73XXaiI6oXK1uVMkXZ1B4CgbsqyTkDRKKtvFMUgch/OgV5r/83lUhUJG
fO0b3vtHgfIKkp9vA3S1qvfjwCgN2Nr7rMigWbgN9rNzDWZiN22GTgcCuxJWoo7R
HoioAH0nLU/hEpo+ZYReMun4RMXAGO+XuRomg17a+5pnRNrGfN6kf+9A2rH6OeGN
w2D8+X1okmaDkCVyhsJQWTUdep75rPEWk5BG//YR0d8IWiTYX6DWpPHH8V28T10J
8lHGqbUZBp7L0lejOqIP
=vO8J
-----END PGP SIGNATURE-----

--lrAxkOSuUGB5o5O1SH7bdUPXH3ogM6wkw--
