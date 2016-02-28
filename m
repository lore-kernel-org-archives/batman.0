Return-Path: <mschiffer@universe-factory.net>
References: <1456616348.1958.16.camel@gmail.com>
 <20160228132736.GI5481@otheros>
From: Matthias Schiffer <mschiffer@universe-factory.net>
Message-ID: <56D32423.4020800@universe-factory.net>
Date: Sun, 28 Feb 2016 17:45:23 +0100
MIME-Version: 1.0
In-Reply-To: <20160228132736.GI5481@otheros>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="1gxL2XVo0vb610Ga8UEc8qveovUijxAIw"
Subject: Re: [B.A.T.M.A.N.] batctl: page allocation failure
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Philipp Psurek <philipp.psurek@gmail.com>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1gxL2XVo0vb610Ga8UEc8qveovUijxAIw
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/28/2016 02:27 PM, Linus L=C3=BCssing wrote:
> Hi Philipp,
>=20
> Unfortunately, this is a known issue. The only workaround available
> right now is increasing RAM. Which I guess is not possible for you
> with your ARM device.

This is not correct, this issue has been fixed with kernel 4.4.

If you can't update your kernel to version 4.4, you need to backport the
following two commits:

5cec38ac866bfb8775638e71a86e4d8cac30caae
"fs, seq_file: fallback to vmalloc instead of oom kill processes"

0f930902eb8806cff8dcaef9ff9faf3cfa5fd748
"fs, seqfile: always allow oom killer"

(the second commit's log message is a bit misleading, I guess the author
meant "avoid" instead of "allow")

Regards,
Matthias


>=20
> Matthias Schiffer has been working on a solution:
>=20
> https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2015-June/013339.html=

>=20
> Not sure whether he would still be inclined to work on that after the
> lack of feedback he had gotten or whether he still has the time
> for that.
>=20
> Regards, Linus
>=20
> PS: How much (free and in total) RAM does your device have, which devic=
e is
> it exactly? Just that others know how much RAM is needed to read
> from debugfs with a 300+ nodes setup right now.
>=20
>=20
> On Sun, Feb 28, 2016 at 12:39:08AM +0100, Philipp Psurek wrote:
>> Hi all,
>>
>> I've got this error with
>>
>> # batctl -v
>> batctl 2016.0-4-g7a3d563 [batman-adv: 2016.0-83-g884fb2d]
>>
>> on
>>
>> # uname -rmpio
>> 3.4.107-01996-g67bdc52 armv7l ARMv7 Processor rev 4 (v7l) sun7i GNU/Li=
nux
>>
>> I know the kernel is old, I can take a recent one if needed, but maybe=

>> this is not necessary.=20
>>
>> The module has been compiled with
>> CONFIG_BATMAN_ADV_DEBUG=3Dy
>> CONFIG_BATMAN_ADV_BLA=3Dy
>> CONFIG_BATMAN_ADV_DAT=3Dy
>> CONFIG_BATMAN_ADV_NC=3Dy
>> CONFIG_BATMAN_ADV_MCAST=3Dy
>> CONFIG_BATMAN_ADV_BATMAN_V=3Dn
>>
>> and batctl as usual but without stripping. The problem occurs while
>> calling =E2=80=9Cbatctl o=E2=80=9D. There should be an output of 336 l=
ines =E2=80=A6
>>
>> Please tell me if you need more information. Thanx in advance and than=
k
>> you for B.A.T.M.A.N. advanced.
>>
>> Best regards,
>> Philipp
>>
>>
>> ----------------------------------
>>
>> [Feb28 00:10] batman_adv: B.A.T.M.A.N. advanced 2016.0-83-g884fb2d (co=
mpatibility version 15) loaded
>> [ +11,632829] batman_adv: bat0: Adding interface: eth0
>> [  +0,277590] batman_adv: bat0: The MTU of interface eth0 is too small=
 (1500) to handle the transport of batman-adv packets. Packets going over=
 this interface will be fragmented on layer2 which could impact the perfo=
rmance. Setting the MTU to 1560 would solve the problem.
>> [  +0,058799] batman_adv: bat0: Interface activated: eth0
>> [  +3,173715] batman_adv: bat0: Adding interface: fastd-wup
>> [  +0,279096] batman_adv: bat0: The MTU of interface fastd-wup is too =
small (1426) to handle the transport of batman-adv packets. Packets going=
 over this interface will be fragmented on layer2 which could impact the =
performance. Setting the MTU to 1560 would solve the problem.
>> [  +0,055496] batman_adv: bat0: Interface activated: fastd-wup
>> [ +23,247415] bat0: no IPv6 routers present
>> [Feb28 00:13] batctl: page allocation failure: order:4, mode:0x40d0
>> [  +0,100723] [<c00153a4>] (unwind_backtrace+0x0/0x134) from [<c00af79=
c>] (warn_alloc_failed+0xe0/0x118)
>> [  +0,113138] [<c00af79c>] (warn_alloc_failed+0xe0/0x118) from [<c00b1=
ff0>] (__alloc_pages_nodemask+0x574/0x7cc)
>> [  +0,110864] [<c00b1ff0>] (__alloc_pages_nodemask+0x574/0x7cc) from [=
<c00b22ac>] (__get_free_pages+0x10/0x24)
>> [  +0,094211] [<c00b22ac>] (__get_free_pages+0x10/0x24) from [<c0108bd=
8>] (seq_read+0x238/0x490)
>> [  +0,084540] [<c0108bd8>] (seq_read+0x238/0x490) from [<c00eb3f4>] (v=
fs_read+0x98/0x174)
>> [  +0,082817] [<c00eb3f4>] (vfs_read+0x98/0x174) from [<c00eb8a0>] (sy=
s_read+0x38/0x78)
>> [  +0,095673] [<c00eb8a0>] (sys_read+0x38/0x78) from [<c000ecc0>] (ret=
_fast_syscall+0x0/0x30)
>> [  +0,014683] Mem-info:
>> [  +0,015332] DMA per-cpu:
>> [  +0,042295] CPU    0: hi:   90, btch:  15 usd:   0
>> [  +0,043583] CPU    1: hi:   90, btch:  15 usd:   0
>> [  +0,019240] Normal per-cpu:
>> [  +0,042920] CPU    0: hi:  186, btch:  31 usd:   0
>> [  +0,046456] CPU    1: hi:  186, btch:  31 usd:   1
>> [  +0,030888] HighMem per-cpu:
>> [  +0,042776] CPU    0: hi:   90, btch:  15 usd:   0
>> [  +0,046066] CPU    1: hi:   90, btch:  15 usd:   0
>> [  +0,276204] active_anon:38221 inactive_anon:11325 isolated_anon:0
>> [  +0,000006]  active_file:95385 inactive_file:84158 isolated_file:0
>> [  +0,000006]  unevictable:0 dirty:4 writeback:0 unstable:0
>> [  +0,000004]  free:8954 slab_reclaimable:9981 slab_unreclaimable:2508=

>> [  +0,000005]  mapped:2159 shmem:153 pagetables:326 bounce:0
>> [  +0,467038] DMA free:10956kB min:1180kB low:1472kB high:1768kB activ=
e_anon:41260kB inactive_anon:4176kB active_file:96108kB inactive_file:908=
08kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:260096=
kB mlocked:0kB dirty:0kB writeback:0kB mapped:3224kB shmem:488kB slab_rec=
laimable:7228kB slab_unreclaimable:1340kB kernel_stack:176kB pagetables:0=
kB unstable:0kB bounce:0kB writeback_tmp:0kB pages_scanned:0 all_unreclai=
mable? no
>> [  +0,043062] lowmem_reserve[]: 0 500 762 762
>> [  +0,478788] Normal free:22160kB min:2324kB low:2904kB high:3484kB ac=
tive_anon:64100kB inactive_anon:10132kB active_file:183792kB inactive_fil=
e:159760kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:=
512064kB mlocked:0kB dirty:16kB writeback:0kB mapped:1472kB shmem:4kB sla=
b_reclaimable:32696kB slab_unreclaimable:8700kB kernel_stack:624kB pageta=
bles:1304kB unstable:0kB bounce:0kB writeback_tmp:0kB pages_scanned:0 all=
_unreclaimable? no
>> [  +0,041810] lowmem_reserve[]: 0 0 2095 2095
>> [  +0,485438] HighMem free:2692kB min:260kB low:564kB high:868kB activ=
e_anon:47524kB inactive_anon:30992kB active_file:101640kB inactive_file:8=
6064kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:2682=
24kB mlocked:0kB dirty:0kB writeback:0kB mapped:3940kB shmem:120kB slab_r=
eclaimable:0kB slab_unreclaimable:0kB kernel_stack:0kB pagetables:0kB uns=
table:0kB bounce:0kB writeback_tmp:0kB pages_scanned:0 all_unreclaimable?=
 no
>> [  +0,041504] lowmem_reserve[]: 0 0 0 0
>> [  +0,019167] DMA: 1167*4kB 178*8kB 80*16kB 32*32kB 18*64kB 5*128kB 3*=
256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 10956kB
>> [  +0,128889] Normal: 3738*4kB 576*8kB 112*16kB 21*32kB 2*64kB 0*128kB=
 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 22152kB
>> [  +0,141889] HighMem: 143*4kB 67*8kB 37*16kB 13*32kB 7*64kB 1*128kB 0=
*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 2692kB
>> [  +0,155726] 179706 total pagecache pages
>> [  +0,031546] 0 pages in swap cache
>> [  +0,075081] Swap cache stats: add 933557, delete 933557, find 273255=
/316856
>> [  +0,023894] Free swap  =3D 0kB
>> [  +0,027333] Total swap =3D 0kB
>> [  +0,039682] 262144 pages of RAM
>> [  +0,020541] 9168 free pages
>> [  +0,024887] 9338 reserved pages
>> [  +0,019097] 9130 slab pages
>> [  +0,025110] 116719 pages shared
>> [  +0,024278] 0 pages swap cached
>> [  +4,207166] batctl: page allocation failure: order:4, mode:0x40d0
>> [  +0,095872] [<c00153a4>] (unwind_backtrace+0x0/0x134) from [<c00af79=
c>] (warn_alloc_failed+0xe0/0x118)
>> [  +0,104340] [<c00af79c>] (warn_alloc_failed+0xe0/0x118) from [<c00b1=
ff0>] (__alloc_pages_nodemask+0x574/0x7cc)
>> [  +0,102166] [<c00b1ff0>] (__alloc_pages_nodemask+0x574/0x7cc) from [=
<c00b22ac>] (__get_free_pages+0x10/0x24)
>> [  +0,087528] [<c00b22ac>] (__get_free_pages+0x10/0x24) from [<c0108bd=
8>] (seq_read+0x238/0x490)
>> [  +0,080231] [<c0108bd8>] (seq_read+0x238/0x490) from [<c00eb3f4>] (v=
fs_read+0x98/0x174)
>> [  +0,078142] [<c00eb3f4>] (vfs_read+0x98/0x174) from [<c00eb8a0>] (sy=
s_read+0x38/0x78)
>> [  +0,084396] [<c00eb8a0>] (sys_read+0x38/0x78) from [<c000ecc0>] (ret=
_fast_syscall+0x0/0x30)
>> [  +0,011576] Mem-info:
>> [  +0,014689] DMA per-cpu:
>> [  +0,041725] CPU    0: hi:   90, btch:  15 usd:   0
>> [  +0,041762] CPU    1: hi:   90, btch:  15 usd:   0
>> [  +0,017817] Normal per-cpu:
>> [  +0,041821] CPU    0: hi:  186, btch:  31 usd:   0
>> [  +0,041736] CPU    1: hi:  186, btch:  31 usd:   0
>> [  +0,018844] HighMem per-cpu:
>> [  +0,041736] CPU    0: hi:   90, btch:  15 usd:   0
>> [  +0,041724] CPU    1: hi:   90, btch:  15 usd:   0
>> [  +0,274703] active_anon:38228 inactive_anon:11330 isolated_anon:0
>> [  +0,000006]  active_file:95390 inactive_file:84151 isolated_file:0
>> [  +0,000006]  unevictable:0 dirty:1 writeback:0 unstable:0
>> [  +0,000004]  free:8958 slab_reclaimable:9981 slab_unreclaimable:2512=

>> [  +0,000005]  mapped:2159 shmem:153 pagetables:326 bounce:0
>> [  +0,449747] DMA free:10956kB min:1180kB low:1472kB high:1768kB activ=
e_anon:41260kB inactive_anon:4176kB active_file:96108kB inactive_file:908=
08kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:260096=
kB mlocked:0kB dirty:0kB writeback:0kB mapped:3224kB shmem:488kB slab_rec=
laimable:7228kB slab_unreclaimable:1340kB kernel_stack:176kB pagetables:0=
kB unstable:0kB bounce:0kB writeback_tmp:0kB pages_scanned:0 all_unreclai=
mable? no
>> [  +0,017854] lowmem_reserve[]: 0 500 762 762
>> [  +0,474747] Normal free:22180kB min:2324kB low:2904kB high:3484kB ac=
tive_anon:64124kB inactive_anon:10152kB active_file:183800kB inactive_fil=
e:159744kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:=
512064kB mlocked:0kB dirty:0kB writeback:0kB mapped:1472kB shmem:4kB slab=
_reclaimable:32696kB slab_unreclaimable:8708kB kernel_stack:624kB pagetab=
les:1304kB unstable:0kB bounce:0kB writeback_tmp:0kB pages_scanned:0 all_=
unreclaimable? no
>> [  +0,017908] lowmem_reserve[]: 0 0 2095 2095
>> [  +0,460057] HighMem free:2696kB min:260kB low:564kB high:868kB activ=
e_anon:47528kB inactive_anon:30992kB active_file:101652kB inactive_file:8=
6052kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:2682=
24kB mlocked:0kB dirty:4kB writeback:0kB mapped:3940kB shmem:120kB slab_r=
eclaimable:0kB slab_unreclaimable:0kB kernel_stack:0kB pagetables:0kB uns=
table:0kB bounce:0kB writeback_tmp:0kB pages_scanned:0 all_unreclaimable?=
 no
>> [  +0,017830] lowmem_reserve[]: 0 0 0 0
>> [  +0,015840] DMA: 1167*4kB 178*8kB 80*16kB 32*32kB 18*64kB 5*128kB 3*=
256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 10956kB
>> [  +0,116928] Normal: 3745*4kB 582*8kB 111*16kB 20*32kB 2*64kB 0*128kB=
 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 22180kB
>> [  +0,117676] HighMem: 138*4kB 70*8kB 37*16kB 13*32kB 7*64kB 1*128kB 0=
*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 2696kB
>> [  +0,135363] 179706 total pagecache pages
>> [  +0,024050] 0 pages in swap cache
>> [  +0,067731] Swap cache stats: add 933557, delete 933557, find 273255=
/316856
>> [  +0,018842] Free swap  =3D 0kB
>> [  +0,018837] Total swap =3D 0kB
>> [  +0,034725] 262144 pages of RAM
>> [  +0,017828] 9175 free pages
>> [  +0,021957] 9338 reserved pages
>> [  +0,017803] 9130 slab pages
>> [  +0,021957] 116699 pages shared
>> [  +0,021958] 0 pages swap cached
>> [  +2,546832] batctl: page allocation failure: order:4, mode:0x40d0
>> [  +0,095887] [<c00153a4>] (unwind_backtrace+0x0/0x134) from [<c00af79=
c>] (warn_alloc_failed+0xe0/0x118)
>> [  +0,104208] [<c00af79c>] (warn_alloc_failed+0xe0/0x118) from [<c00b1=
ff0>] (__alloc_pages_nodemask+0x574/0x7cc)
>> [  +0,102153] [<c00b1ff0>] (__alloc_pages_nodemask+0x574/0x7cc) from [=
<c00b22ac>] (__get_free_pages+0x10/0x24)
>> [  +0,087828] [<c00b22ac>] (__get_free_pages+0x10/0x24) from [<c0108bd=
8>] (seq_read+0x238/0x490)
>> [  +0,080248] [<c0108bd8>] (seq_read+0x238/0x490) from [<c00eb3f4>] (v=
fs_read+0x98/0x174)
>> [  +0,078215] [<c00eb3f4>] (vfs_read+0x98/0x174) from [<c00eb8a0>] (sy=
s_read+0x38/0x78)
>> [  +0,084403] [<c00eb8a0>] (sys_read+0x38/0x78) from [<c000ecc0>] (ret=
_fast_syscall+0x0/0x30)
>> [  +0,011576] Mem-info:
>> [  +0,014684] DMA per-cpu:
>> [  +0,041729] CPU    0: hi:   90, btch:  15 usd:   0
>> [  +0,041796] CPU    1: hi:   90, btch:  15 usd:   0
>> [  +0,017822] Normal per-cpu:
>> [  +0,041724] CPU    0: hi:  186, btch:  31 usd:   0
>> [  +0,041730] CPU    1: hi:  186, btch:  31 usd:   0
>> [  +0,018883] HighMem per-cpu:
>> [  +0,041723] CPU    0: hi:   90, btch:  15 usd:   0
>> [  +0,041867] CPU    1: hi:   90, btch:  15 usd:   0
>> [  +0,274716] active_anon:38235 inactive_anon:11327 isolated_anon:0
>> [  +0,000007]  active_file:95391 inactive_file:84152 isolated_file:0
>> [  +0,000006]  unevictable:0 dirty:2 writeback:0 unstable:0
>> [  +0,000004]  free:8953 slab_reclaimable:9981 slab_unreclaimable:2512=

>> [  +0,000005]  mapped:2159 shmem:153 pagetables:326 bounce:0
>> [  +0,449493] DMA free:10956kB min:1180kB low:1472kB high:1768kB activ=
e_anon:41260kB inactive_anon:4176kB active_file:96108kB inactive_file:908=
08kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:260096=
kB mlocked:0kB dirty:0kB writeback:0kB mapped:3224kB shmem:488kB slab_rec=
laimable:7228kB slab_unreclaimable:1340kB kernel_stack:176kB pagetables:0=
kB unstable:0kB bounce:0kB writeback_tmp:0kB pages_scanned:0 all_unreclai=
mable? no
>> [  +0,017933] lowmem_reserve[]: 0 500 762 762
>> [  +0,474739] Normal free:22160kB min:2324kB low:2904kB high:3484kB ac=
tive_anon:64128kB inactive_anon:10140kB active_file:183804kB inactive_fil=
e:159748kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:=
512064kB mlocked:0kB dirty:4kB writeback:0kB mapped:1472kB shmem:4kB slab=
_reclaimable:32696kB slab_unreclaimable:8708kB kernel_stack:624kB pagetab=
les:1304kB unstable:0kB bounce:0kB writeback_tmp:0kB pages_scanned:0 all_=
unreclaimable? no
>> [  +0,017916] lowmem_reserve[]: 0 0 2095 2095
>> [  +0,460179] HighMem free:2696kB min:260kB low:564kB high:868kB activ=
e_anon:47552kB inactive_anon:30992kB active_file:101652kB inactive_file:8=
6052kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:2682=
24kB mlocked:0kB dirty:4kB writeback:0kB mapped:3940kB shmem:120kB slab_r=
eclaimable:0kB slab_unreclaimable:0kB kernel_stack:0kB pagetables:0kB uns=
table:0kB bounce:0kB writeback_tmp:0kB pages_scanned:0 all_unreclaimable?=
 no
>> [  +0,017960] lowmem_reserve[]: 0 0 0 0
>> [  +0,015846] DMA: 1167*4kB 178*8kB 80*16kB 32*32kB 18*64kB 5*128kB 3*=
256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 10956kB
>> [  +0,116798] Normal: 3742*4kB 583*8kB 112*16kB 19*32kB 2*64kB 0*128kB=
 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 22160kB
>> [  +0,117768] HighMem: 128*4kB 75*8kB 37*16kB 13*32kB 7*64kB 1*128kB 0=
*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 2696kB
>> [  +0,135597] 179708 total pagecache pages
>> [  +0,024101] 0 pages in swap cache
>> [  +0,067730] Swap cache stats: add 933557, delete 933557, find 273255=
/316856
>> [  +0,018843] Free swap  =3D 0kB
>> [  +0,018838] Total swap =3D 0kB
>> [  +0,034639] 262144 pages of RAM
>> [  +0,017816] 9170 free pages
>> [  +0,021964] 9338 reserved pages
>> [  +0,017874] 9130 slab pages
>> [  +0,021970] 116692 pages shared
>> [  +0,021963] 0 pages swap cached
>> [  +2,795628] batctl: page allocation failure: order:4, mode:0x40d0
>> [  +0,100163] [<c00153a4>] (unwind_backtrace+0x0/0x134) from [<c00af79=
c>] (warn_alloc_failed+0xe0/0x118)
>> [  +0,112606] [<c00af79c>] (warn_alloc_failed+0xe0/0x118) from [<c00b1=
ff0>] (__alloc_pages_nodemask+0x574/0x7cc)
>> [  +0,109882] [<c00b1ff0>] (__alloc_pages_nodemask+0x574/0x7cc) from [=
<c00b22ac>] (__get_free_pages+0x10/0x24)
>> [  +0,092898] [<c00b22ac>] (__get_free_pages+0x10/0x24) from [<c0108bd=
8>] (seq_read+0x238/0x490)
>> [  +0,081964] [<c0108bd8>] (seq_read+0x238/0x490) from [<c00eb3f4>] (v=
fs_read+0x98/0x174)
>> [  +0,080373] [<c00eb3f4>] (vfs_read+0x98/0x174) from [<c00eb8a0>] (sy=
s_read+0x38/0x78)
>> [  +0,095661] [<c00eb8a0>] (sys_read+0x38/0x78) from [<c000ecc0>] (ret=
_fast_syscall+0x0/0x30)
>> [  +0,018246] Mem-info:
>> [  +0,016190] DMA per-cpu:
>> [  +0,042907] CPU    0: hi:   90, btch:  15 usd:   0
>> [  +0,045696] CPU    1: hi:   90, btch:  15 usd:   0
>> [  +0,021567] Normal per-cpu:
>> [  +0,043237] CPU    0: hi:  186, btch:  31 usd:   0
>> [  +0,042809] CPU    1: hi:  186, btch:  31 usd:   1
>> [  +0,027782] HighMem per-cpu:
>> [  +0,044187] CPU    0: hi:   90, btch:  15 usd:   0
>> [  +0,044017] CPU    1: hi:   90, btch:  15 usd:   0
>> [  +0,276192] active_anon:38230 inactive_anon:11333 isolated_anon:0
>> [  +0,000006]  active_file:95396 inactive_file:84156 isolated_file:0
>> [  +0,000005]  unevictable:0 dirty:2 writeback:0 unstable:0
>> [  +0,000005]  free:8953 slab_reclaimable:9981 slab_unreclaimable:2512=

>> [  +0,000005]  mapped:2159 shmem:153 pagetables:326 bounce:0
>> [  +0,467447] DMA free:10956kB min:1180kB low:1472kB high:1768kB activ=
e_anon:41260kB inactive_anon:4176kB active_file:96108kB inactive_file:908=
08kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:260096=
kB mlocked:0kB dirty:0kB writeback:0kB mapped:3224kB shmem:488kB slab_rec=
laimable:7228kB slab_unreclaimable:1340kB kernel_stack:176kB pagetables:0=
kB unstable:0kB bounce:0kB writeback_tmp:0kB pages_scanned:0 all_unreclai=
mable? no
>> [  +0,024492] lowmem_reserve[]: 0 500 762 762
>> [  +0,475389] Normal free:22176kB min:2324kB low:2904kB high:3484kB ac=
tive_anon:64128kB inactive_anon:10164kB active_file:183824kB inactive_fil=
e:159764kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:=
512064kB mlocked:0kB dirty:4kB writeback:0kB mapped:1472kB shmem:4kB slab=
_reclaimable:32696kB slab_unreclaimable:8708kB kernel_stack:624kB pagetab=
les:1304kB unstable:0kB bounce:0kB writeback_tmp:0kB pages_scanned:0 all_=
unreclaimable? no
>> [  +0,024240] lowmem_reserve[]: 0 0 2095 2095
>> [  +0,461051] HighMem free:2680kB min:260kB low:564kB high:868kB activ=
e_anon:47532kB inactive_anon:30992kB active_file:101652kB inactive_file:8=
6052kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:2682=
24kB mlocked:0kB dirty:4kB writeback:0kB mapped:3940kB shmem:120kB slab_r=
eclaimable:0kB slab_unreclaimable:0kB kernel_stack:0kB pagetables:0kB uns=
table:0kB bounce:0kB writeback_tmp:0kB pages_scanned:0 all_unreclaimable?=
 no
>> [  +0,023810] lowmem_reserve[]: 0 0 0 0
>> [  +0,016839] DMA: 1167*4kB 178*8kB 80*16kB 32*32kB 18*64kB 5*128kB 3*=
256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 10956kB
>> [  +0,117735] Normal: 3738*4kB 584*8kB 113*16kB 22*32kB 1*64kB 0*128kB=
 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 22200kB
>> [  +0,118592] HighMem: 124*4kB 75*8kB 37*16kB 13*32kB 7*64kB 1*128kB 0=
*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 2680kB
>> [  +0,141032] 179710 total pagecache pages
>> [  +0,024246] 0 pages in swap cache
>> [  +0,067845] Swap cache stats: add 933557, delete 933557, find 273255=
/316856
>> [  +0,019040] Free swap  =3D 0kB
>> [  +0,018966] Total swap =3D 0kB
>> [  +0,035160] 262144 pages of RAM
>> [  +0,017932] 9177 free pages
>> [  +0,022041] 9338 reserved pages
>> [  +0,022998] 9127 slab pages
>> [  +0,022106] 116679 pages shared
>> [  +0,022100] 0 pages swap cached
>> [Feb28 00:14] batctl: page allocation failure: order:4, mode:0x40d0
>> [  +0,096010] [<c00153a4>] (unwind_backtrace+0x0/0x134) from [<c00af79=
c>] (warn_alloc_failed+0xe0/0x118)
>> [  +0,105164] [<c00af79c>] (warn_alloc_failed+0xe0/0x118) from [<c00b1=
ff0>] (__alloc_pages_nodemask+0x574/0x7cc)
>> [  +0,102095] [<c00b1ff0>] (__alloc_pages_nodemask+0x574/0x7cc) from [=
<c00b22ac>] (__get_free_pages+0x10/0x24)
>> [  +0,087646] [<c00b22ac>] (__get_free_pages+0x10/0x24) from [<c0108bd=
8>] (seq_read+0x238/0x490)
>> [  +0,080242] [<c0108bd8>] (seq_read+0x238/0x490) from [<c00eb3f4>] (v=
fs_read+0x98/0x174)
>> [  +0,078150] [<c00eb3f4>] (vfs_read+0x98/0x174) from [<c00eb8a0>] (sy=
s_read+0x38/0x78)
>> [  +0,084499] [<c00eb8a0>] (sys_read+0x38/0x78) from [<c000ecc0>] (ret=
_fast_syscall+0x0/0x30)
>> [  +0,011602] Mem-info:
>> [  +0,014690] DMA per-cpu:
>> [  +0,041744] CPU    0: hi:   90, btch:  15 usd:   0
>> [  +0,041755] CPU    1: hi:   90, btch:  15 usd:   0
>> [  +0,017817] Normal per-cpu:
>> [  +0,041737] CPU    0: hi:  186, btch:  31 usd:   0
>> [  +0,041729] CPU    1: hi:  186, btch:  31 usd:   0
>> [  +0,018845] HighMem per-cpu:
>> [  +0,041735] CPU    0: hi:   90, btch:  15 usd:   0
>> [  +0,041725] CPU    1: hi:   90, btch:  15 usd:   0
>> [  +0,274696] active_anon:38218 inactive_anon:11333 isolated_anon:0
>> [  +0,000005]  active_file:95399 inactive_file:84165 isolated_file:0
>> [  +0,000006]  unevictable:0 dirty:3 writeback:0 unstable:0
>> [  +0,000004]  free:8965 slab_reclaimable:9971 slab_unreclaimable:2505=

>> [  +0,000005]  mapped:2158 shmem:153 pagetables:326 bounce:0
>> [  +0,449546] DMA free:11020kB min:1180kB low:1472kB high:1768kB activ=
e_anon:41260kB inactive_anon:4176kB active_file:96108kB inactive_file:908=
08kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:260096=
kB mlocked:0kB dirty:0kB writeback:0kB mapped:3224kB shmem:488kB slab_rec=
laimable:7164kB slab_unreclaimable:1340kB kernel_stack:176kB pagetables:0=
kB unstable:0kB bounce:0kB writeback_tmp:0kB pages_scanned:0 all_unreclai=
mable? no
>> [  +0,018135] lowmem_reserve[]: 0 500 762 762
>> [  +0,474663] Normal free:21940kB min:2324kB low:2904kB high:3484kB ac=
tive_anon:64128kB inactive_anon:10164kB active_file:183836kB inactive_fil=
e:159796kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:=
512064kB mlocked:0kB dirty:4kB writeback:0kB mapped:1472kB shmem:4kB slab=
_reclaimable:32672kB slab_unreclaimable:8680kB kernel_stack:632kB pagetab=
les:1304kB unstable:0kB bounce:0kB writeback_tmp:0kB pages_scanned:0 all_=
unreclaimable? no
>> [  +0,017894] lowmem_reserve[]: 0 0 2095 2095
>> [  +0,460232] HighMem free:2632kB min:260kB low:564kB high:868kB activ=
e_anon:47508kB inactive_anon:30992kB active_file:101652kB inactive_file:8=
6056kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:2682=
24kB mlocked:0kB dirty:8kB writeback:0kB mapped:3936kB shmem:120kB slab_r=
eclaimable:0kB slab_unreclaimable:0kB kernel_stack:0kB pagetables:0kB uns=
table:0kB bounce:0kB writeback_tmp:0kB pages_scanned:0 all_unreclaimable?=
 no
>> [  +0,017921] lowmem_reserve[]: 0 0 0 0
>> [  +0,015956] DMA: 1167*4kB 186*8kB 80*16kB 32*32kB 18*64kB 5*128kB 3*=
256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 11020kB
>> [  +0,116870] Normal: 3667*4kB 586*8kB 112*16kB 23*32kB 1*64kB 0*128kB=
 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 21948kB
>> [  +0,117813] HighMem: 110*4kB 76*8kB 37*16kB 13*32kB 7*64kB 1*128kB 0=
*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 2632kB
>> [  +0,135376] 179719 total pagecache pages
>> [  +0,024043] 0 pages in swap cache
>> [  +0,067725] Swap cache stats: add 933557, delete 933557, find 273255=
/316856
>> [  +0,018915] Free swap  =3D 0kB
>> [  +0,018849] Total swap =3D 0kB
>> [  +0,034626] 262144 pages of RAM
>> [  +0,017849] 9194 free pages
>> [  +0,022185] 9338 reserved pages
>> [  +0,017842] 9115 slab pages
>> [  +0,021995] 116689 pages shared
>> [  +0,021957] 0 pages swap cached



--1gxL2XVo0vb610Ga8UEc8qveovUijxAIw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJW0yQjAAoJEBbvP2TLIB2cT+kP/02aUCbbqqA/c8CWumWGnuOz
6BatNBpuBzyXYOvRu+SqD8ximjLID7Rt1y9raV45uMaM1BLM3wiRSSK65cff1wPX
UFgI0wNBwyhp/I5HYLOOBILF43pRp2XQobIy2+kqp5mQfGCyiMsnlK2oWZuB8MeF
sswqKu9C26SU51bo6CMmYx5r6R6F+0p7VHp7O8fLaLG1FX7hSZ1LeZQ41cUMp3wJ
S6DOkVsoOjscRo5nV5C3bXcKb0I4vIHyaCjI18d9ts6c8bw9SUVxLbGC7Md6Gt2j
lHFfgexKp3Jyr/oE1VPO3ufrJPnZHnD3zGUAVvw+4igXBNqYW8Tq5LMq54Gjlxpi
QF/1jAkkfXYd2BxAJ9QeeEwDcEEyaTwdRdigv4CHkikOaj1q3MAVyohJ41y9YUhI
CIXNpRpwASiwPnyc2VHyge08ZWOL7j5px27dbcxLvEX9KHZVpLLNcA/mj/rSKnqm
9herSCC5bAJI5NUrarHnpbjYmV3E+b5HrkYBDTc/wQRaUtQfJyLQit8CUlJMUgXf
BaI+i0yZ4qqHhXVHP6Ie+du6JYoqU4YQe4rHJipOLUlyWP3Re2HnMbWHIp1VL7pb
FZcxh2OSbGPzv8yM7/Hh8uSdMyQ3rOIVGIllliGICbYVkcTOlV9o35YEvlw8Y4Uj
VdB7G8zji0ZfW+tcxJTC
=qlxy
-----END PGP SIGNATURE-----

--1gxL2XVo0vb610Ga8UEc8qveovUijxAIw--
