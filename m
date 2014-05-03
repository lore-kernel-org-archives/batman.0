Return-Path: <antonio@meshcoding.com>
Message-ID: <5364ABB1.6050109@meshcoding.com>
Date: Sat, 03 May 2014 10:41:21 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <CAPXi+9-j-u6YbvhMjhLPxVOcdYPd0HVThH=SH7PacvakeYenDw@mail.gmail.com>
 <533CF7F5.1000801@meshcoding.com>
 <CAPXi+9_ovpYZMDreNBFCffakiCMWnzHHC_1MaOxYy5A_veqJ7w@mail.gmail.com>
 <CAPXi+9-4y3wG3=0OoL8hbWQAO6Gummaa4tM=cKMapNQRjxiO9w@mail.gmail.com>
 <CAPXi+99VgVyf7O8j8J+fLAF4AaKOFRxJTX1xpdnP3Q1JkBZE4Q@mail.gmail.com>
In-Reply-To: <CAPXi+99VgVyf7O8j8J+fLAF4AaKOFRxJTX1xpdnP3Q1JkBZE4Q@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="x6abI2Aixwokb0VMBctPwPdc9sA0RMlV2"
Subject: Re: [B.A.T.M.A.N.] batctl oops on batctl gateways call
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--x6abI2Aixwokb0VMBctPwPdc9sA0RMlV2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

FYI, we are rather confident that this patch
https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2014-May/011920.html
fixes the problem you have seen.

Cheers,

On 12/04/14 23:15, Fabrice Dossin wrote:
> Hi,
> I could not reproduce this. I keep you update if I see this again.
> Best regards,
> Fabrice
>=20
> On 3 April 2014 10:21, Fabrice Dossin <fabrice.dossin@gmail.com> wrote:=

>> (Sorry, reformatting again, leaving text mode)
>>
>>
>> Hi,
>>
>> Sorry, my mail client did this behind my  back. I did resend the stack=

>> here under for readability.
>>
>> For now, it has append only one time on one node. This particular node=

>> does not have any other node in his range. I execute a "batctl
>> gateways" each 5 minutes for monitoring. I will let you know if it
>> appends again today or if I found information for reproducibility.
>>
>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.500226] Unable to handle kern=
el
>> NULL pointer dereference at virtual address 00000022
>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.508175] pgd =3D d4918000
>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.514355] [00000022] *pgd=3D138=
f9831,
>> *pte=3D00000000, *ppte=3D00000000
>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.521733] Internal error: Oops:=
 17
>> [#5] PREEMPT ARM
>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.527131] Modules linked in: tu=
n
>> ipt_MASQUERADE iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv=
4
>> nf_nat nf_conntrack iptable_filter ip_tables x_tables ipv6 bcm2708_rng=

>> bcm2708_wdog batman_adv(O) rtc_ds1307 qmi_wwan option usb_wwan arc4
>> usbserial cdc_wdm rt2800usb rt2800lib rt2x00usb rt2x00lib mac80211 cfg=
80211
>> crc_ccitt sr_mod cdrom leds_gpio led_class rt5572sta(O) spi_bcm2708
>> i2c_bcm2708 btusb bluetooth rfkill
>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.544610] CPU: 0 PID: 7261 Comm=
:
>> batctl Tainted: G      D    O 3.10.30+ #1
>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.550263] task: d49f3180 ti: d3=
8d0000
>> task.ti: d38d0000
>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.556017] PC is at
>> batadv_orig_router_get+0x50/0x9c [batman_adv]
>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.561587] LR is at
>> batadv_orig_router_get+0x10/0x9c [batman_adv]
>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.566974] pc : [<bf35e218>]    =
lr :
>> [<bf35e1d8>]    psr: 20000013
>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.566974] sp : d38d1ea8  ip :
>> 0000000a  fp : dda60600
>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.577350] r10: cccccccd  r9 :
>> ddab7000  r8 : dda60600
>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.582439] r7 : 00000000  r6 :
>> 00000000  r5 : d4826e00  r4 : 00000000
>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.587535] r3 : d4ac0000  r2 :
>> 00000000  r1 : 00000000  r0 : 00000002
>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.592468] Flags: nzCv  IRQs on =
 FIQs
>> on  Mode SVC_32  ISA ARM  Segment user
>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.597357] Control: 00c5387d  Ta=
ble:
>> 14918008  DAC: 00000015
>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.602319] Process batctl (pid: =
7261,
>> stack limit =3D 0xd38d01b0)
>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.607230] Stack: (0xd38d1ea8 to=

>> 0xd38d2000)
>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.611903] 1ea0:
>> d49f3180 d49c2580 00000000 bf35a62c 000000ff bf368ed8
>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.616816] 1ec0: bf368ee0 bf368e=
ec
>> dc89b000 dbe3cd08 ddab7000 dc83bba0 dbd10900 00000000
>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.621720] 1ee0: 00100073 000000=
00
>> d25a0aa0 00000000 00000000 00000001 d38d1f20 00000001
>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.626477] 1f00: dda60600 c00f65=
3c
>> d1f20790 d38d1f80 00001000 b6f18000 dda60628 00000000
>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.631263] 1f20: 00000000 000000=
00
>> 00001000 dc83bba0 00000001 d25a0aa0 b6f18000 d38d0000
>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.636092] 1f40: d38d1f80 000010=
00
>> d38d0000 00001000 bea8eb54 c00d7530 00000000 00000003
>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.640834] 1f60: 00000000 000000=
00
>> 00000000 d25a0aa0 b6f18000 00000000 00001000 c00d77c4
>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.645450] 1f80: 00000000 000000=
00
>> ffffffff 00916008 fbad2488 00000000 00000003 c000dd68
>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.650123] 1fa0: 00000000 c000db=
c0
>> 00916008 fbad2488 00000003 b6f18000 00001000 00000000
>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.654758] 1fc0: 00916008 fbad24=
88
>> 00000000 00000003 00000000 00021450 b6f1f000 bea8eb54
>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.659333] 1fe0: 00000000 bea8e8=
c8
>> b6d945f8 b6de52bc 60000010 00000003 00000000 00000000
>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.664121] [<bf35e218>]
>> (batadv_orig_router_get+0x50/0x9c [batman_adv]) from [<bf35a62c>]
>> (batadv_gw_client_seq_print_text+0xac/0x220 [batman_adv])
>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.673531] [<bf35a62c>]
>> (batadv_gw_client_seq_print_text+0xac/0x220 [batman_adv]) from [<c00f6=
53c>]
>> (seq_read+0x1d0/0x4cc)
>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.678287] [<c00f653c>]
>> (seq_read+0x1d0/0x4cc) from [<c00d7530>] (vfs_read+0x98/0x17c)
>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.683071] [<c00d7530>]
>> (vfs_read+0x98/0x17c) from [<c00d77c4>] (SyS_read+0x3c/0x70)
>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.687982] [<c00d77c4>]
>> (SyS_read+0x3c/0x70) from [<c000dbc0>] (ret_fast_syscall+0x0/0x30)
>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.692822] Code: e8bd8038 e59300=
0c
>> e3500000 0afffff8 (e5902020)
>> Apr  2 11:45:08 pv2-1dnci kernel: [ 7432.718781] ---[ end trace
>> 1e5ba977f5516301 ]---
>>
>> Regards,
>> Fabrice
>>
>>>
>>>> Hi Fabrice,
>>>>
>>>> On 02/04/14 13:50, Fabrice Dossin wrote:
>>>>> Dear all,
>>>>>
>>>>> Hello.
>>>>> I am not sure it has been notified so I post this issue here.
>>>>> It is my first post, so tell me if I do it bad...
>>>>>
>>>>
>>>> no problem, it's fine! Maybe sending the stack trace without adding =
new
>>>> lines is better, but this is fine anyway :)
>>>>
>>>> Are you able to reproduce this problem somehow? Or it happened only =
once
>>>> under no particular conditions?
>>>>
>>>> Cheers,
>>>>
>>>>
>>>> --
>>>> Antonio Quartulli
>>>>
>>
>=20

--=20
Antonio Quartulli


--x6abI2Aixwokb0VMBctPwPdc9sA0RMlV2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCAAGBQJTZKu7AAoJEEKTMo6mOh1VajIP/3NWNXgwwTQ6E2Feyv5f5mV4
5Z1zkYgE1wsuboBgSpKNb2cEHb3FWl82Dp+wEUEtabJB21R0K559XWampg013YVo
Z9t2G3a55aSTnZxeDjnYLEPVCrblIE17mSfTlDDcwEixSx/LecLV27NqFp0OlmPA
sU93RV+RBSbHweS3oDYIU7aslzWWGXLXZ/6HIzl7lhLBNUhJoE0ZQomnIqwDELVR
Nhui0xTchMKxVXzwt1Z6LyEX9mmgUTBCW/nWKcB2Hvs+JBzagzqnpnDSr3HCa1ke
0XQKxuy5tIuo+HIsh/krayKJa8qWCQpjhXUYV1qpeW4UBdH4pTU0t9TFT8VivNLs
I+IFUN8euDNZfOfsCCizMwgP9KUZN2KXGoJ4hPaQYmjzHUhebyWm9rh4wKBBONU8
AdMnSmehKbXi63Lrta2FN4YgnzIwyHL09J5MtKB4NnP+nbYlUb37FgtPG4i1cTC0
VU5O5PkFyRgkPQG+r65Ka7KnvC2a1VZEwIhX6aK3cOQqA50MA3jaTUUs2psRtmIT
CCvD93jtSLddjFQ5iwTcmnyNNjVUvi6230lBinL+4g1wcDeHnA9Q/J1+9wP6MKHD
6SP87YOqwnYQ0y73JNDi+9tbwTNGsdFpzYEat8Xs5bA5LLPFzQYDQWu/iCqbDpBn
PlNNKeAEq8eU2kf2TEQX
=YYJO
-----END PGP SIGNATURE-----

--x6abI2Aixwokb0VMBctPwPdc9sA0RMlV2--
