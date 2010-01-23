Return-Path: <linus.luessing@web.de>
Date: Sat, 23 Jan 2010 18:46:16 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100123174616.GA4795@Sellars>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] bat_events: page allocation failure (batman-adv
	maint)
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


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hey guys,

I've been installing a 9 node setup here in our cellar. They are
all running B.A.T.M.A.N. adv 0.2.1-beta r1545 (so the current
batman-adv maintance version in OpenWRT).

The result over night:
- 1x: bat_events: page allocation failure
- 3x: WARNING: at net/sched/sch_generic.c:226 0x801c3554()
	(those 3 had TQ values of about 10-15 in batctl)

For the last error, I'm not sure if this is related to batman-adv
or to the madwifi driver. I was using OpenWRT trunk 18405 on all
routers.

I'm attaching some backtraces. Sorry again I can't get more out of
them than that with ksymoops. The first two ones are the
bat_events problem, the others the scheduling thingy.

Cheers, Linus

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="kernel-panic-1752-23-01-10.log"

root@OpenWrt:~# dmesg
01a8664>] 0x801a8664
[<801a9120>] 0x801a9120
[<8018c4b8>] 0x8018c4b8
[<80b42088>] 0x80b42088
[<80b42070>] 0x80b42070
[<80b419d4>] 0x80b419d4
[<8007425c>] 0x8007425c
[<800745c8>] 0x800745c8
[<800789b4>] 0x800789b4
[<800790a8>] 0x800790a8
[<8007441c>] 0x8007441c
[<80078a10>] 0x80078a10
[<8004e988>] 0x8004e988

Mem-Info:
Normal per-cpu: 
CPU    0: hi:    0, btch:   1 usd:   0
Active_anon:149 active_file:564 inactive_anon:159
 inactive_file:828 dirty:0 writeback:0 unstable:0
 free:48 slab:1126 mapped:279 pagetables:55 bounce:0
Normal free:192kB min:508kB low:632kB high:760kB active_anon:596kB inactive_anon:636kB active_file:2256kB inactive_file:3312kB present:16256kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0
Normal: 0*4kB 0*8kB 0*16kB 0*32kB 1*64kB 1*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 192kB
1417 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
4096 pages RAM  
699 pages reserved
1395 pages shared
2630 pages non-shared
bat_events: page allocation failure. order:0, mode:0x20
Call Trace:[<800493bc>] 0x800493bc
[<800493bc>] 0x800493bc
[<8009ac88>] 0x8009ac88
[<800bcf78>] 0x800bcf78
[<800bd538>] 0x800bd538
[<80b41a58>] 0x80b41a58
[<80074b5c>] 0x80074b5c
[<80b42674>] 0x80b42674
[<80b479f8>] 0x80b479f8
[<8052129c>] 0x8052129c
[<8051c178>] 0x8051c178
[<80525a20>] 0x80525a20
[<8022329c>] 0x8022329c
[<8022329c>] 0x8022329c
[<805269e0>] 0x805269e0
[<80525ed8>] 0x80525ed8
[<8022329c>] 0x8022329c
[<80503f50>] 0x80503f50
[<8051910c>] 0x8051910c
[<801b0fb8>] 0x801b0fb8
[<801ae580>] 0x801ae580
[<80066d84>] 0x80066d84
[<80066e90>] 0x80066e90
[<8009ac90>] 0x8009ac90
[<80041444>] 0x80041444
[<801784a0>] 0x801784a0
[<800bd450>] 0x800bd450
[<800bd470>] 0x800bd470
[<801a8664>] 0x801a8664
[<801a9120>] 0x801a9120
[<8018c4b8>] 0x8018c4b8
[<80b42088>] 0x80b42088
[<80b42070>] 0x80b42070
[<80b419d4>] 0x80b419d4
[<8007425c>] 0x8007425c
[<800745c8>] 0x800745c8
[<800789b4>] 0x800789b4
[<800790a8>] 0x800790a8
[<8007441c>] 0x8007441c
[<80078a10>] 0x80078a10
[<8004e988>] 0x8004e988

Mem-Info:
Normal per-cpu: 
CPU    0: hi:    0, btch:   1 usd:   0
Active_anon:149 active_file:564 inactive_anon:159
 inactive_file:828 dirty:0 writeback:0 unstable:0
 free:48 slab:1126 mapped:279 pagetables:55 bounce:0
Normal free:192kB min:508kB low:632kB high:760kB active_anon:596kB inactive_anon:636kB active_file:2256kB inactive_file:3312kB present:16256kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0
Normal: 0*4kB 0*8kB 0*16kB 0*32kB 1*64kB 1*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 192kB
1417 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
4096 pages RAM  
699 pages reserved
1395 pages shared
2630 pages non-shared
bat_events: page allocation failure. order:0, mode:0x20
Call Trace:[<800493bc>] 0x800493bc
[<800493bc>] 0x800493bc
[<8009ac88>] 0x8009ac88
[<800bcf78>] 0x800bcf78
[<800bd538>] 0x800bd538
[<80b41a58>] 0x80b41a58
[<80074b5c>] 0x80074b5c
[<80b42674>] 0x80b42674
[<80b479f8>] 0x80b479f8
[<8052129c>] 0x8052129c
[<8051c178>] 0x8051c178
[<80525a20>] 0x80525a20
[<8022329c>] 0x8022329c
[<8022329c>] 0x8022329c
[<805269e0>] 0x805269e0
[<80525ed8>] 0x80525ed8
[<8022329c>] 0x8022329c
[<80503f50>] 0x80503f50
[<8051910c>] 0x8051910c
[<801b0fb8>] 0x801b0fb8
[<801ae580>] 0x801ae580
[<80066d84>] 0x80066d84
[<80066e90>] 0x80066e90
[<8009ac90>] 0x8009ac90
[<80041444>] 0x80041444
[<801784a0>] 0x801784a0
[<800bd450>] 0x800bd450
[<800bd470>] 0x800bd470
[<801a8664>] 0x801a8664
[<801a9120>] 0x801a9120
[<8018c4b8>] 0x8018c4b8
[<80b42088>] 0x80b42088
[<80b42070>] 0x80b42070
[<80b419d4>] 0x80b419d4
[<8007425c>] 0x8007425c
[<800745c8>] 0x800745c8
[<800789b4>] 0x800789b4
[<800790a8>] 0x800790a8
[<8007441c>] 0x8007441c
[<80078a10>] 0x80078a10
[<8004e988>] 0x8004e988

Mem-Info:
Normal per-cpu: 
CPU    0: hi:    0, btch:   1 usd:   0
Active_anon:149 active_file:564 inactive_anon:159
 inactive_file:828 dirty:0 writeback:0 unstable:0
 free:48 slab:1126 mapped:279 pagetables:55 bounce:0
Normal free:192kB min:508kB low:632kB high:760kB active_anon:596kB inactive_anon:636kB active_file:2256kB inactive_file:3312kB present:16256kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0
Normal: 0*4kB 0*8kB 0*16kB 0*32kB 1*64kB 1*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 192kB
1417 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
4096 pages RAM  
699 pages reserved
1395 pages shared
2630 pages non-shared
bat_events: page allocation failure. order:0, mode:0x20
Call Trace:[<800493bc>] 0x800493bc
[<800493bc>] 0x800493bc
[<8009ac88>] 0x8009ac88
[<800bcf78>] 0x800bcf78
[<800bd538>] 0x800bd538
[<80b41a58>] 0x80b41a58
[<80074b5c>] 0x80074b5c
[<80b42674>] 0x80b42674
[<80b479f8>] 0x80b479f8
[<8052129c>] 0x8052129c
[<8051c178>] 0x8051c178
[<80525a20>] 0x80525a20
[<800bd450>] 0x800bd450
[<8022329c>] 0x8022329c
[<805269e0>] 0x805269e0
[<80525ed8>] 0x80525ed8
[<8022329c>] 0x8022329c
[<80503f50>] 0x80503f50
[<8051910c>] 0x8051910c
[<801b0fb8>] 0x801b0fb8
[<801ae580>] 0x801ae580
[<80066d84>] 0x80066d84
[<80066e90>] 0x80066e90
[<8009ac90>] 0x8009ac90
[<80041444>] 0x80041444
[<801784a0>] 0x801784a0
[<800bd450>] 0x800bd450
[<800bd470>] 0x800bd470
[<801a8664>] 0x801a8664
[<801a9120>] 0x801a9120
[<8018c4b8>] 0x8018c4b8
[<80b42088>] 0x80b42088
[<80b42070>] 0x80b42070
[<80b419d4>] 0x80b419d4
[<8007425c>] 0x8007425c
[<800745c8>] 0x800745c8
[<800789b4>] 0x800789b4
[<800790a8>] 0x800790a8
[<8007441c>] 0x8007441c
[<80078a10>] 0x80078a10
[<8004e988>] 0x8004e988

Mem-Info:
Normal per-cpu: 
CPU    0: hi:    0, btch:   1 usd:   0
Active_anon:149 active_file:564 inactive_anon:159
 inactive_file:828 dirty:0 writeback:0 unstable:0
 free:48 slab:1126 mapped:279 pagetables:55 bounce:0
Normal free:192kB min:508kB low:632kB high:760kB active_anon:596kB inactive_anon:636kB active_file:2256kB inactive_file:3312kB present:16256kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0
Normal: 0*4kB 0*8kB 0*16kB 0*32kB 1*64kB 1*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 192kB
1417 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
4096 pages RAM  
699 pages reserved
1395 pages shared
2630 pages non-shared
bat_events: page allocation failure. order:0, mode:0x20
Call Trace:[<800493bc>] 0x800493bc
[<800493bc>] 0x800493bc
[<8009ac88>] 0x8009ac88
[<800bcf78>] 0x800bcf78
[<800bd538>] 0x800bd538
[<80b41a58>] 0x80b41a58
[<80074b5c>] 0x80074b5c
[<80b42674>] 0x80b42674
[<80b479f8>] 0x80b479f8
[<8052129c>] 0x8052129c
[<8051c178>] 0x8051c178
[<80525a20>] 0x80525a20
[<800bd450>] 0x800bd450
[<8022329c>] 0x8022329c
[<805269e0>] 0x805269e0
[<80525ed8>] 0x80525ed8
[<8022329c>] 0x8022329c
[<80503f50>] 0x80503f50
[<8051910c>] 0x8051910c
[<801b0fb8>] 0x801b0fb8
[<801ae580>] 0x801ae580
[<80066d84>] 0x80066d84
[<80066e90>] 0x80066e90
[<8009ac90>] 0x8009ac90
[<80041444>] 0x80041444
[<801784a0>] 0x801784a0
[<800bd450>] 0x800bd450
[<800bd470>] 0x800bd470
[<801a8664>] 0x801a8664
[<801a9120>] 0x801a9120
[<8018c4b8>] 0x8018c4b8
[<80b42088>] 0x80b42088
[<80b42070>] 0x80b42070
[<80b419d4>] 0x80b419d4
[<8007425c>] 0x8007425c
[<800745c8>] 0x800745c8
[<800789b4>] 0x800789b4
[<800790a8>] 0x800790a8
[<8007441c>] 0x8007441c
[<80078a10>] 0x80078a10
[<8004e988>] 0x8004e988

Mem-Info:
Normal per-cpu:
CPU    0: hi:    0, btch:   1 usd:   0
Active_anon:149 active_file:564 inactive_anon:159
 inactive_file:828 dirty:0 writeback:0 unstable:0
 free:48 slab:1126 mapped:279 pagetables:55 bounce:0
Normal free:192kB min:508kB low:632kB high:760kB active_anon:596kB inactive_anon:636kB active_file:2256kB inactive_file:3312kB present:16256kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0
Normal: 0*4kB 0*8kB 0*16kB 0*32kB 1*64kB 1*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 192kB
1417 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
4096 pages RAM
699 pages reserved
1395 pages shared
2630 pages non-shared
bat_events: page allocation failure. order:0, mode:0x20
Call Trace:[<800493bc>] 0x800493bc
[<800493bc>] 0x800493bc
[<8009ac88>] 0x8009ac88
[<800bcf78>] 0x800bcf78
[<800bd538>] 0x800bd538
[<80b41a58>] 0x80b41a58
[<80074b5c>] 0x80074b5c
[<80b42674>] 0x80b42674
[<80b479f8>] 0x80b479f8
[<8052129c>] 0x8052129c
[<8051c178>] 0x8051c178
[<80525a20>] 0x80525a20
[<800bd450>] 0x800bd450
[<8022329c>] 0x8022329c
[<805269e0>] 0x805269e0
[<80525ed8>] 0x80525ed8
[<8022329c>] 0x8022329c
[<80503f50>] 0x80503f50
[<8051910c>] 0x8051910c
[<801b0fb8>] 0x801b0fb8
[<801ae580>] 0x801ae580
[<80066d84>] 0x80066d84
[<80066e90>] 0x80066e90
[<8009ac90>] 0x8009ac90
[<80041444>] 0x80041444
[<801784a0>] 0x801784a0
[<800bd450>] 0x800bd450
[<800bd470>] 0x800bd470
[<801a8664>] 0x801a8664
[<801a9120>] 0x801a9120
[<8018c4b8>] 0x8018c4b8
[<80b42088>] 0x80b42088
[<80b42070>] 0x80b42070
[<80b419d4>] 0x80b419d4
[<8007425c>] 0x8007425c
[<800745c8>] 0x800745c8
[<800789b4>] 0x800789b4
[<800790a8>] 0x800790a8
[<8007441c>] 0x8007441c
[<80078a10>] 0x80078a10
[<8004e988>] 0x8004e988

Mem-Info:
Normal per-cpu:
CPU    0: hi:    0, btch:   1 usd:   0
Active_anon:149 active_file:564 inactive_anon:159
 inactive_file:828 dirty:0 writeback:0 unstable:0
 free:48 slab:1126 mapped:279 pagetables:55 bounce:0
Normal free:192kB min:508kB low:632kB high:760kB active_anon:596kB inactive_anon:636kB active_file:2256kB inactive_file:3312kB present:16256kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0
Normal: 0*4kB 0*8kB 0*16kB 0*32kB 1*64kB 1*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 192kB
1417 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
4096 pages RAM
699 pages reserved
1395 pages shared
2630 pages non-shared
bat_events: page allocation failure. order:0, mode:0x20
Call Trace:[<800493bc>] 0x800493bc
[<800493bc>] 0x800493bc
[<8009ac88>] 0x8009ac88
[<800bcf78>] 0x800bcf78
[<800bd538>] 0x800bd538
[<80b41a58>] 0x80b41a58
[<80074b5c>] 0x80074b5c
[<80b42674>] 0x80b42674
[<80b479f8>] 0x80b479f8
[<8052129c>] 0x8052129c
[<8051c178>] 0x8051c178
[<80525a20>] 0x80525a20
[<800bd450>] 0x800bd450
[<8022329c>] 0x8022329c
[<805269e0>] 0x805269e0
[<80525ed8>] 0x80525ed8
[<8022329c>] 0x8022329c
[<80503f50>] 0x80503f50
[<8051910c>] 0x8051910c
[<801b0fb8>] 0x801b0fb8
[<801ae580>] 0x801ae580
[<80066d84>] 0x80066d84
[<80066e90>] 0x80066e90
[<8009ac90>] 0x8009ac90
[<80041444>] 0x80041444
[<801784a0>] 0x801784a0
[<800bd450>] 0x800bd450
[<800bd470>] 0x800bd470
[<801a8664>] 0x801a8664
[<801a9120>] 0x801a9120
[<8018c4b8>] 0x8018c4b8
[<80b42088>] 0x80b42088
[<80b42070>] 0x80b42070
[<80b419d4>] 0x80b419d4
[<8007425c>] 0x8007425c
[<800745c8>] 0x800745c8
[<800789b4>] 0x800789b4
[<800790a8>] 0x800790a8
[<8007441c>] 0x8007441c
[<80078a10>] 0x80078a10
[<8004e988>] 0x8004e988

Mem-Info:
Normal per-cpu:
CPU    0: hi:    0, btch:   1 usd:   0
Active_anon:149 active_file:564 inactive_anon:159
 inactive_file:828 dirty:0 writeback:0 unstable:0
 free:48 slab:1126 mapped:279 pagetables:55 bounce:0
Normal free:192kB min:508kB low:632kB high:760kB active_anon:596kB inactive_anon:636kB active_file:2256kB inactive_file:3312kB present:16256kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0
Normal: 0*4kB 0*8kB 0*16kB 0*32kB 1*64kB 1*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 192kB
1417 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
4096 pages RAM
699 pages reserved
1395 pages shared
2630 pages non-shared
wifi0: ath_uapsd_processtriggers: Dropping; skb is NULL in received ath_buf.
wifi0: ath_uapsd_processtriggers: Dropping; skb is NULL in received ath_buf.
bat_events: page allocation failure. order:0, mode:0x20
Call Trace:[<800493bc>] 0x800493bc
[<800493bc>] 0x800493bc
[<8009ac88>] 0x8009ac88
[<8007d3e4>] 0x8007d3e4
[<800bcf78>] 0x800bcf78
[<800bd538>] 0x800bd538
[<80b41a58>] 0x80b41a58
[<80b42674>] 0x80b42674
[<80b479f8>] 0x80b479f8
[<8052129c>] 0x8052129c
[<80525a20>] 0x80525a20
[<800bd450>] 0x800bd450
[<80041444>] 0x80041444
[<805269e0>] 0x805269e0
[<80525ed8>] 0x80525ed8
[<80503f50>] 0x80503f50
[<8051910c>] 0x8051910c
[<801b0fb8>] 0x801b0fb8
[<801ae580>] 0x801ae580
[<80066d84>] 0x80066d84
[<80066e90>] 0x80066e90
[<8009ac90>] 0x8009ac90
[<80041444>] 0x80041444
[<801784a0>] 0x801784a0
[<800bd450>] 0x800bd450
[<800bd470>] 0x800bd470
[<801a8664>] 0x801a8664
[<801a9120>] 0x801a9120
[<8018c4b8>] 0x8018c4b8
[<80b42088>] 0x80b42088
[<80b42070>] 0x80b42070
[<80b419d4>] 0x80b419d4
[<8007425c>] 0x8007425c
[<800745c8>] 0x800745c8
[<800789b4>] 0x800789b4
[<800790a8>] 0x800790a8
[<8007441c>] 0x8007441c
[<80078a10>] 0x80078a10
[<8004e988>] 0x8004e988

Mem-Info:
Normal per-cpu:
CPU    0: hi:    0, btch:   1 usd:   0
Active_anon:149 active_file:564 inactive_anon:159
 inactive_file:828 dirty:0 writeback:0 unstable:0
 free:48 slab:1126 mapped:279 pagetables:55 bounce:0
Normal free:192kB min:508kB low:632kB high:760kB active_anon:596kB inactive_anon:636kB active_file:2256kB inactive_file:3312kB present:16256kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0
Normal: 0*4kB 0*8kB 0*16kB 0*32kB 1*64kB 1*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 192kB
1417 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
4096 pages RAM
699 pages reserved
1395 pages shared
2630 pages non-shared
bat_events: page allocation failure. order:0, mode:0x20
Call Trace:[<800493bc>] 0x800493bc
[<800493bc>] 0x800493bc
[<8009ac88>] 0x8009ac88
[<8018c538>] 0x8018c538
[<800bcf78>] 0x800bcf78
[<800bd450>] 0x800bd450
[<801a8664>] 0x801a8664
[<801a9120>] 0x801a9120
[<80074174>] 0x80074174
[<80b42070>] 0x80b42070
[<8007425c>] 0x8007425c
[<800745c8>] 0x800745c8
[<800789b4>] 0x800789b4
[<800790a8>] 0x800790a8
[<8007441c>] 0x8007441c
[<80078a10>] 0x80078a10
[<8004e988>] 0x8004e988

Mem-Info:
Normal per-cpu:
CPU    0: hi:    0, btch:   1 usd:   0
Active_anon:149 active_file:564 inactive_anon:159
 inactive_file:828 dirty:0 writeback:0 unstable:0
 free:48 slab:1126 mapped:279 pagetables:55 bounce:0
Normal free:192kB min:508kB low:632kB high:760kB active_anon:596kB inactive_anon:636kB active_file:2256kB inactive_file:3312kB present:16256kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0
Normal: 0*4kB 0*8kB 0*16kB 0*32kB 1*64kB 1*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 192kB
1417 total pagecache pages
0 pages in swap cache
Swap cache stats: add 0, delete 0, find 0/0
Free swap  = 0kB
Total swap = 0kB
4096 pages RAM
699 pages reserved
1395 pages shared
2630 pages non-shared
device VPN entered promiscuous mode
br-wan_vpn: topology change detected, propagating
br-wan_vpn: port 2(VPN) entering forwarding state
root@OpenWrt:~#

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="kernel-panic-1752-23-01-10.ksymoops"

ksymoops 2.4.11 on x86_64 2.6.31-1-amd64.  Options used
     -v /home/linus/lff-test/kamikaze/build_dir/linux-atheros/linux-2.6.30.9/vmlinux (specified)
     -K (specified)
     -L (specified)
     -o /home/linus/lff-test/kamikaze/build_dir/linux-atheros -o /home/linus/lff-test/kamikaze/build_dir/target-mips_uClibc-0.9.30.1 (specified)
     -m /home/linus/lff-test/kamikaze/build_dir/linux-atheros/linux-2.6.30.9/System.map (specified)

No modules in ksyms, skipping objects
01a8664>] 0x801a8664
[<801a9120>] 0x801a9120
[<8018c4b8>] 0x8018c4b8
[<80b42088>] 0x80b42088
[<80b42070>] 0x80b42070
[<80b419d4>] 0x80b419d4
[<8007425c>] 0x8007425c
[<800745c8>] 0x800745c8
[<800789b4>] 0x800789b4
[<800790a8>] 0x800790a8
[<8007441c>] 0x8007441c
[<80078a10>] 0x80078a10
[<8004e988>] 0x8004e988
CPU    0: hi:    0, btch:   1 usd:   0
1417 total pagecache pages
4096 pages RAM  
1395 pages shared
2630 pages non-shared
Call Trace:[<800493bc>] 0x800493bc
[<800493bc>] 0x800493bc
[<8009ac88>] 0x8009ac88
[<800bcf78>] 0x800bcf78
[<800bd538>] 0x800bd538
[<80b41a58>] 0x80b41a58
[<80074b5c>] 0x80074b5c
[<80b42674>] 0x80b42674
[<80b479f8>] 0x80b479f8
[<8052129c>] 0x8052129c
[<8051c178>] 0x8051c178
[<80525a20>] 0x80525a20
[<8022329c>] 0x8022329c
[<8022329c>] 0x8022329c
[<805269e0>] 0x805269e0
[<80525ed8>] 0x80525ed8
[<8022329c>] 0x8022329c
[<80503f50>] 0x80503f50
[<8051910c>] 0x8051910c
[<801b0fb8>] 0x801b0fb8
[<801ae580>] 0x801ae580
[<80066d84>] 0x80066d84
[<80066e90>] 0x80066e90
[<8009ac90>] 0x8009ac90
[<80041444>] 0x80041444
[<801784a0>] 0x801784a0
[<800bd450>] 0x800bd450
[<800bd470>] 0x800bd470
[<801a8664>] 0x801a8664
[<801a9120>] 0x801a9120
[<8018c4b8>] 0x8018c4b8
[<80b42088>] 0x80b42088
[<80b42070>] 0x80b42070
[<80b419d4>] 0x80b419d4
[<8007425c>] 0x8007425c
[<800745c8>] 0x800745c8
[<800789b4>] 0x800789b4
[<800790a8>] 0x800790a8
[<8007441c>] 0x8007441c
[<80078a10>] 0x80078a10
[<8004e988>] 0x8004e988
CPU    0: hi:    0, btch:   1 usd:   0
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; 800493bc <dump_stack+20/50>
Trace; 800493bc <dump_stack+20/50>
Trace; 8009ac88 <__alloc_pages_internal+3ec/434>
Trace; 800bcf78 <cache_alloc_refill+2d8/6fc>
Trace; 800bd538 <kmem_cache_alloc+78/e8>
Trace; 80b41a58 <END_OF_CODE+88c328/????>
Trace; 80074b5c <queue_delayed_work_on+f8/108>
Trace; 80b42674 <END_OF_CODE+88cf44/????>
Trace; 80b479f8 <END_OF_CODE+8922c8/????>
Trace; 8052129c <END_OF_CODE+26bb6c/????>
Trace; 8051c178 <END_OF_CODE+266a48/????>
Trace; 80525a20 <END_OF_CODE+2702f0/????>
Trace; 8022329c <br_handle_frame_finish+0/1a4>
Trace; 8022329c <br_handle_frame_finish+0/1a4>
Trace; 805269e0 <END_OF_CODE+2712b0/????>
Trace; 80525ed8 <END_OF_CODE+2707a8/????>
Trace; 8022329c <br_handle_frame_finish+0/1a4>
Trace; 80503f50 <END_OF_CODE+24e820/????>
Trace; 8051910c <END_OF_CODE+2639dc/????>
Trace; 801b0fb8 <net_rx_action+a8/24c>
Trace; 801ae580 <net_tx_action+1c8/1f0>
Trace; 80066d84 <__do_softirq+a4/154>
Trace; 80066e90 <do_softirq+5c/98>
Trace; 8009ac90 <__alloc_pages_internal+3f4/434>
Trace; 80041444 <ret_from_irq+0/4>
Trace; 801784a0 <mem_serial_out+0/20>
Trace; 800bd450 <__kmalloc+b4/124>
Trace; 800bd470 <__kmalloc+d4/124>
Trace; 801a8664 <__alloc_skb+70/148>
Trace; 801a9120 <skb_copy+40/c8>
Trace; 8018c4b8 <ar231x_start_xmit+0/d0>
Trace; 80b42088 <END_OF_CODE+88c958/????>
Trace; 80b42070 <END_OF_CODE+88c940/????>
Trace; 80b419d4 <END_OF_CODE+88c2a4/????>
Trace; 8007425c <queue_work_on+90/a0>
Trace; 800745c8 <worker_thread+1ac/260>
Trace; 800789b4 <kthread+0/a0>
Trace; 800790a8 <autoremove_wake_function+0/4c>
Trace; 8007441c <worker_thread+0/260>
Trace; 80078a10 <kthread+5c/a0>
Trace; 8004e988 <kernel_thread_helper+10/18>

1417 total pagecache pages
4096 pages RAM  
1395 pages shared
2630 pages non-shared
Call Trace:[<800493bc>] 0x800493bc
[<800493bc>] 0x800493bc
[<8009ac88>] 0x8009ac88
[<800bcf78>] 0x800bcf78
[<800bd538>] 0x800bd538
[<80b41a58>] 0x80b41a58
[<80074b5c>] 0x80074b5c
[<80b42674>] 0x80b42674
[<80b479f8>] 0x80b479f8
[<8052129c>] 0x8052129c
[<8051c178>] 0x8051c178
[<80525a20>] 0x80525a20
[<8022329c>] 0x8022329c
[<8022329c>] 0x8022329c
[<805269e0>] 0x805269e0
[<80525ed8>] 0x80525ed8
[<8022329c>] 0x8022329c
[<80503f50>] 0x80503f50
[<8051910c>] 0x8051910c
[<801b0fb8>] 0x801b0fb8
[<801ae580>] 0x801ae580
[<80066d84>] 0x80066d84
[<80066e90>] 0x80066e90
[<8009ac90>] 0x8009ac90
[<80041444>] 0x80041444
[<801784a0>] 0x801784a0
[<800bd450>] 0x800bd450
[<800bd470>] 0x800bd470
[<801a8664>] 0x801a8664
[<801a9120>] 0x801a9120
[<8018c4b8>] 0x8018c4b8
[<80b42088>] 0x80b42088
[<80b42070>] 0x80b42070
[<80b419d4>] 0x80b419d4
[<8007425c>] 0x8007425c
[<800745c8>] 0x800745c8
[<800789b4>] 0x800789b4
[<800790a8>] 0x800790a8
[<8007441c>] 0x8007441c
[<80078a10>] 0x80078a10
[<8004e988>] 0x8004e988
CPU    0: hi:    0, btch:   1 usd:   0
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; 800493bc <dump_stack+20/50>
Trace; 800493bc <dump_stack+20/50>
Trace; 8009ac88 <__alloc_pages_internal+3ec/434>
Trace; 800bcf78 <cache_alloc_refill+2d8/6fc>
Trace; 800bd538 <kmem_cache_alloc+78/e8>
Trace; 80b41a58 <END_OF_CODE+88c328/????>
Trace; 80074b5c <queue_delayed_work_on+f8/108>
Trace; 80b42674 <END_OF_CODE+88cf44/????>
Trace; 80b479f8 <END_OF_CODE+8922c8/????>
Trace; 8052129c <END_OF_CODE+26bb6c/????>
Trace; 8051c178 <END_OF_CODE+266a48/????>
Trace; 80525a20 <END_OF_CODE+2702f0/????>
Trace; 8022329c <br_handle_frame_finish+0/1a4>
Trace; 8022329c <br_handle_frame_finish+0/1a4>
Trace; 805269e0 <END_OF_CODE+2712b0/????>
Trace; 80525ed8 <END_OF_CODE+2707a8/????>
Trace; 8022329c <br_handle_frame_finish+0/1a4>
Trace; 80503f50 <END_OF_CODE+24e820/????>
Trace; 8051910c <END_OF_CODE+2639dc/????>
Trace; 801b0fb8 <net_rx_action+a8/24c>
Trace; 801ae580 <net_tx_action+1c8/1f0>
Trace; 80066d84 <__do_softirq+a4/154>
Trace; 80066e90 <do_softirq+5c/98>
Trace; 8009ac90 <__alloc_pages_internal+3f4/434>
Trace; 80041444 <ret_from_irq+0/4>
Trace; 801784a0 <mem_serial_out+0/20>
Trace; 800bd450 <__kmalloc+b4/124>
Trace; 800bd470 <__kmalloc+d4/124>
Trace; 801a8664 <__alloc_skb+70/148>
Trace; 801a9120 <skb_copy+40/c8>
Trace; 8018c4b8 <ar231x_start_xmit+0/d0>
Trace; 80b42088 <END_OF_CODE+88c958/????>
Trace; 80b42070 <END_OF_CODE+88c940/????>
Trace; 80b419d4 <END_OF_CODE+88c2a4/????>
Trace; 8007425c <queue_work_on+90/a0>
Trace; 800745c8 <worker_thread+1ac/260>
Trace; 800789b4 <kthread+0/a0>
Trace; 800790a8 <autoremove_wake_function+0/4c>
Trace; 8007441c <worker_thread+0/260>
Trace; 80078a10 <kthread+5c/a0>
Trace; 8004e988 <kernel_thread_helper+10/18>

1417 total pagecache pages
4096 pages RAM  
1395 pages shared
2630 pages non-shared
Call Trace:[<800493bc>] 0x800493bc
[<800493bc>] 0x800493bc
[<8009ac88>] 0x8009ac88
[<800bcf78>] 0x800bcf78
[<800bd538>] 0x800bd538
[<80b41a58>] 0x80b41a58
[<80074b5c>] 0x80074b5c
[<80b42674>] 0x80b42674
[<80b479f8>] 0x80b479f8
[<8052129c>] 0x8052129c
[<8051c178>] 0x8051c178
[<80525a20>] 0x80525a20
[<800bd450>] 0x800bd450
[<8022329c>] 0x8022329c
[<805269e0>] 0x805269e0
[<80525ed8>] 0x80525ed8
[<8022329c>] 0x8022329c
[<80503f50>] 0x80503f50
[<8051910c>] 0x8051910c
[<801b0fb8>] 0x801b0fb8
[<801ae580>] 0x801ae580
[<80066d84>] 0x80066d84
[<80066e90>] 0x80066e90
[<8009ac90>] 0x8009ac90
[<80041444>] 0x80041444
[<801784a0>] 0x801784a0
[<800bd450>] 0x800bd450
[<800bd470>] 0x800bd470
[<801a8664>] 0x801a8664
[<801a9120>] 0x801a9120
[<8018c4b8>] 0x8018c4b8
[<80b42088>] 0x80b42088
[<80b42070>] 0x80b42070
[<80b419d4>] 0x80b419d4
[<8007425c>] 0x8007425c
[<800745c8>] 0x800745c8
[<800789b4>] 0x800789b4
[<800790a8>] 0x800790a8
[<8007441c>] 0x8007441c
[<80078a10>] 0x80078a10
[<8004e988>] 0x8004e988
CPU    0: hi:    0, btch:   1 usd:   0
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; 800493bc <dump_stack+20/50>
Trace; 800493bc <dump_stack+20/50>
Trace; 8009ac88 <__alloc_pages_internal+3ec/434>
Trace; 800bcf78 <cache_alloc_refill+2d8/6fc>
Trace; 800bd538 <kmem_cache_alloc+78/e8>
Trace; 80b41a58 <END_OF_CODE+88c328/????>
Trace; 80074b5c <queue_delayed_work_on+f8/108>
Trace; 80b42674 <END_OF_CODE+88cf44/????>
Trace; 80b479f8 <END_OF_CODE+8922c8/????>
Trace; 8052129c <END_OF_CODE+26bb6c/????>
Trace; 8051c178 <END_OF_CODE+266a48/????>
Trace; 80525a20 <END_OF_CODE+2702f0/????>
Trace; 800bd450 <__kmalloc+b4/124>
Trace; 8022329c <br_handle_frame_finish+0/1a4>
Trace; 805269e0 <END_OF_CODE+2712b0/????>
Trace; 80525ed8 <END_OF_CODE+2707a8/????>
Trace; 8022329c <br_handle_frame_finish+0/1a4>
Trace; 80503f50 <END_OF_CODE+24e820/????>
Trace; 8051910c <END_OF_CODE+2639dc/????>
Trace; 801b0fb8 <net_rx_action+a8/24c>
Trace; 801ae580 <net_tx_action+1c8/1f0>
Trace; 80066d84 <__do_softirq+a4/154>
Trace; 80066e90 <do_softirq+5c/98>
Trace; 8009ac90 <__alloc_pages_internal+3f4/434>
Trace; 80041444 <ret_from_irq+0/4>
Trace; 801784a0 <mem_serial_out+0/20>
Trace; 800bd450 <__kmalloc+b4/124>
Trace; 800bd470 <__kmalloc+d4/124>
Trace; 801a8664 <__alloc_skb+70/148>
Trace; 801a9120 <skb_copy+40/c8>
Trace; 8018c4b8 <ar231x_start_xmit+0/d0>
Trace; 80b42088 <END_OF_CODE+88c958/????>
Trace; 80b42070 <END_OF_CODE+88c940/????>
Trace; 80b419d4 <END_OF_CODE+88c2a4/????>
Trace; 8007425c <queue_work_on+90/a0>
Trace; 800745c8 <worker_thread+1ac/260>
Trace; 800789b4 <kthread+0/a0>
Trace; 800790a8 <autoremove_wake_function+0/4c>
Trace; 8007441c <worker_thread+0/260>
Trace; 80078a10 <kthread+5c/a0>
Trace; 8004e988 <kernel_thread_helper+10/18>

1417 total pagecache pages
4096 pages RAM  
1395 pages shared
2630 pages non-shared
Call Trace:[<800493bc>] 0x800493bc
[<800493bc>] 0x800493bc
[<8009ac88>] 0x8009ac88
[<800bcf78>] 0x800bcf78
[<800bd538>] 0x800bd538
[<80b41a58>] 0x80b41a58
[<80074b5c>] 0x80074b5c
[<80b42674>] 0x80b42674
[<80b479f8>] 0x80b479f8
[<8052129c>] 0x8052129c
[<8051c178>] 0x8051c178
[<80525a20>] 0x80525a20
[<800bd450>] 0x800bd450
[<8022329c>] 0x8022329c
[<805269e0>] 0x805269e0
[<80525ed8>] 0x80525ed8
[<8022329c>] 0x8022329c
[<80503f50>] 0x80503f50
[<8051910c>] 0x8051910c
[<801b0fb8>] 0x801b0fb8
[<801ae580>] 0x801ae580
[<80066d84>] 0x80066d84
[<80066e90>] 0x80066e90
[<8009ac90>] 0x8009ac90
[<80041444>] 0x80041444
[<801784a0>] 0x801784a0
[<800bd450>] 0x800bd450
[<800bd470>] 0x800bd470
[<801a8664>] 0x801a8664
[<801a9120>] 0x801a9120
[<8018c4b8>] 0x8018c4b8
[<80b42088>] 0x80b42088
[<80b42070>] 0x80b42070
[<80b419d4>] 0x80b419d4
[<8007425c>] 0x8007425c
[<800745c8>] 0x800745c8
[<800789b4>] 0x800789b4
[<800790a8>] 0x800790a8
[<8007441c>] 0x8007441c
[<80078a10>] 0x80078a10
[<8004e988>] 0x8004e988
CPU    0: hi:    0, btch:   1 usd:   0
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; 800493bc <dump_stack+20/50>
Trace; 800493bc <dump_stack+20/50>
Trace; 8009ac88 <__alloc_pages_internal+3ec/434>
Trace; 800bcf78 <cache_alloc_refill+2d8/6fc>
Trace; 800bd538 <kmem_cache_alloc+78/e8>
Trace; 80b41a58 <END_OF_CODE+88c328/????>
Trace; 80074b5c <queue_delayed_work_on+f8/108>
Trace; 80b42674 <END_OF_CODE+88cf44/????>
Trace; 80b479f8 <END_OF_CODE+8922c8/????>
Trace; 8052129c <END_OF_CODE+26bb6c/????>
Trace; 8051c178 <END_OF_CODE+266a48/????>
Trace; 80525a20 <END_OF_CODE+2702f0/????>
Trace; 800bd450 <__kmalloc+b4/124>
Trace; 8022329c <br_handle_frame_finish+0/1a4>
Trace; 805269e0 <END_OF_CODE+2712b0/????>
Trace; 80525ed8 <END_OF_CODE+2707a8/????>
Trace; 8022329c <br_handle_frame_finish+0/1a4>
Trace; 80503f50 <END_OF_CODE+24e820/????>
Trace; 8051910c <END_OF_CODE+2639dc/????>
Trace; 801b0fb8 <net_rx_action+a8/24c>
Trace; 801ae580 <net_tx_action+1c8/1f0>
Trace; 80066d84 <__do_softirq+a4/154>
Trace; 80066e90 <do_softirq+5c/98>
Trace; 8009ac90 <__alloc_pages_internal+3f4/434>
Trace; 80041444 <ret_from_irq+0/4>
Trace; 801784a0 <mem_serial_out+0/20>
Trace; 800bd450 <__kmalloc+b4/124>
Trace; 800bd470 <__kmalloc+d4/124>
Trace; 801a8664 <__alloc_skb+70/148>
Trace; 801a9120 <skb_copy+40/c8>
Trace; 8018c4b8 <ar231x_start_xmit+0/d0>
Trace; 80b42088 <END_OF_CODE+88c958/????>
Trace; 80b42070 <END_OF_CODE+88c940/????>
Trace; 80b419d4 <END_OF_CODE+88c2a4/????>
Trace; 8007425c <queue_work_on+90/a0>
Trace; 800745c8 <worker_thread+1ac/260>
Trace; 800789b4 <kthread+0/a0>
Trace; 800790a8 <autoremove_wake_function+0/4c>
Trace; 8007441c <worker_thread+0/260>
Trace; 80078a10 <kthread+5c/a0>
Trace; 8004e988 <kernel_thread_helper+10/18>

1417 total pagecache pages
4096 pages RAM
1395 pages shared
2630 pages non-shared
Call Trace:[<800493bc>] 0x800493bc
[<800493bc>] 0x800493bc
[<8009ac88>] 0x8009ac88
[<800bcf78>] 0x800bcf78
[<800bd538>] 0x800bd538
[<80b41a58>] 0x80b41a58
[<80074b5c>] 0x80074b5c
[<80b42674>] 0x80b42674
[<80b479f8>] 0x80b479f8
[<8052129c>] 0x8052129c
[<8051c178>] 0x8051c178
[<80525a20>] 0x80525a20
[<800bd450>] 0x800bd450
[<8022329c>] 0x8022329c
[<805269e0>] 0x805269e0
[<80525ed8>] 0x80525ed8
[<8022329c>] 0x8022329c
[<80503f50>] 0x80503f50
[<8051910c>] 0x8051910c
[<801b0fb8>] 0x801b0fb8
[<801ae580>] 0x801ae580
[<80066d84>] 0x80066d84
[<80066e90>] 0x80066e90
[<8009ac90>] 0x8009ac90
[<80041444>] 0x80041444
[<801784a0>] 0x801784a0
[<800bd450>] 0x800bd450
[<800bd470>] 0x800bd470
[<801a8664>] 0x801a8664
[<801a9120>] 0x801a9120
[<8018c4b8>] 0x8018c4b8
[<80b42088>] 0x80b42088
[<80b42070>] 0x80b42070
[<80b419d4>] 0x80b419d4
[<8007425c>] 0x8007425c
[<800745c8>] 0x800745c8
[<800789b4>] 0x800789b4
[<800790a8>] 0x800790a8
[<8007441c>] 0x8007441c
[<80078a10>] 0x80078a10
[<8004e988>] 0x8004e988
CPU    0: hi:    0, btch:   1 usd:   0
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; 800493bc <dump_stack+20/50>
Trace; 800493bc <dump_stack+20/50>
Trace; 8009ac88 <__alloc_pages_internal+3ec/434>
Trace; 800bcf78 <cache_alloc_refill+2d8/6fc>
Trace; 800bd538 <kmem_cache_alloc+78/e8>
Trace; 80b41a58 <END_OF_CODE+88c328/????>
Trace; 80074b5c <queue_delayed_work_on+f8/108>
Trace; 80b42674 <END_OF_CODE+88cf44/????>
Trace; 80b479f8 <END_OF_CODE+8922c8/????>
Trace; 8052129c <END_OF_CODE+26bb6c/????>
Trace; 8051c178 <END_OF_CODE+266a48/????>
Trace; 80525a20 <END_OF_CODE+2702f0/????>
Trace; 800bd450 <__kmalloc+b4/124>
Trace; 8022329c <br_handle_frame_finish+0/1a4>
Trace; 805269e0 <END_OF_CODE+2712b0/????>
Trace; 80525ed8 <END_OF_CODE+2707a8/????>
Trace; 8022329c <br_handle_frame_finish+0/1a4>
Trace; 80503f50 <END_OF_CODE+24e820/????>
Trace; 8051910c <END_OF_CODE+2639dc/????>
Trace; 801b0fb8 <net_rx_action+a8/24c>
Trace; 801ae580 <net_tx_action+1c8/1f0>
Trace; 80066d84 <__do_softirq+a4/154>
Trace; 80066e90 <do_softirq+5c/98>
Trace; 8009ac90 <__alloc_pages_internal+3f4/434>
Trace; 80041444 <ret_from_irq+0/4>
Trace; 801784a0 <mem_serial_out+0/20>
Trace; 800bd450 <__kmalloc+b4/124>
Trace; 800bd470 <__kmalloc+d4/124>
Trace; 801a8664 <__alloc_skb+70/148>
Trace; 801a9120 <skb_copy+40/c8>
Trace; 8018c4b8 <ar231x_start_xmit+0/d0>
Trace; 80b42088 <END_OF_CODE+88c958/????>
Trace; 80b42070 <END_OF_CODE+88c940/????>
Trace; 80b419d4 <END_OF_CODE+88c2a4/????>
Trace; 8007425c <queue_work_on+90/a0>
Trace; 800745c8 <worker_thread+1ac/260>
Trace; 800789b4 <kthread+0/a0>
Trace; 800790a8 <autoremove_wake_function+0/4c>
Trace; 8007441c <worker_thread+0/260>
Trace; 80078a10 <kthread+5c/a0>
Trace; 8004e988 <kernel_thread_helper+10/18>

1417 total pagecache pages
4096 pages RAM
1395 pages shared
2630 pages non-shared
Call Trace:[<800493bc>] 0x800493bc
[<800493bc>] 0x800493bc
[<8009ac88>] 0x8009ac88
[<800bcf78>] 0x800bcf78
[<800bd538>] 0x800bd538
[<80b41a58>] 0x80b41a58
[<80074b5c>] 0x80074b5c
[<80b42674>] 0x80b42674
[<80b479f8>] 0x80b479f8
[<8052129c>] 0x8052129c
[<8051c178>] 0x8051c178
[<80525a20>] 0x80525a20
[<800bd450>] 0x800bd450
[<8022329c>] 0x8022329c
[<805269e0>] 0x805269e0
[<80525ed8>] 0x80525ed8
[<8022329c>] 0x8022329c
[<80503f50>] 0x80503f50
[<8051910c>] 0x8051910c
[<801b0fb8>] 0x801b0fb8
[<801ae580>] 0x801ae580
[<80066d84>] 0x80066d84
[<80066e90>] 0x80066e90
[<8009ac90>] 0x8009ac90
[<80041444>] 0x80041444
[<801784a0>] 0x801784a0
[<800bd450>] 0x800bd450
[<800bd470>] 0x800bd470
[<801a8664>] 0x801a8664
[<801a9120>] 0x801a9120
[<8018c4b8>] 0x8018c4b8
[<80b42088>] 0x80b42088
[<80b42070>] 0x80b42070
[<80b419d4>] 0x80b419d4
[<8007425c>] 0x8007425c
[<800745c8>] 0x800745c8
[<800789b4>] 0x800789b4
[<800790a8>] 0x800790a8
[<8007441c>] 0x8007441c
[<80078a10>] 0x80078a10
[<8004e988>] 0x8004e988
CPU    0: hi:    0, btch:   1 usd:   0
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; 800493bc <dump_stack+20/50>
Trace; 800493bc <dump_stack+20/50>
Trace; 8009ac88 <__alloc_pages_internal+3ec/434>
Trace; 800bcf78 <cache_alloc_refill+2d8/6fc>
Trace; 800bd538 <kmem_cache_alloc+78/e8>
Trace; 80b41a58 <END_OF_CODE+88c328/????>
Trace; 80074b5c <queue_delayed_work_on+f8/108>
Trace; 80b42674 <END_OF_CODE+88cf44/????>
Trace; 80b479f8 <END_OF_CODE+8922c8/????>
Trace; 8052129c <END_OF_CODE+26bb6c/????>
Trace; 8051c178 <END_OF_CODE+266a48/????>
Trace; 80525a20 <END_OF_CODE+2702f0/????>
Trace; 800bd450 <__kmalloc+b4/124>
Trace; 8022329c <br_handle_frame_finish+0/1a4>
Trace; 805269e0 <END_OF_CODE+2712b0/????>
Trace; 80525ed8 <END_OF_CODE+2707a8/????>
Trace; 8022329c <br_handle_frame_finish+0/1a4>
Trace; 80503f50 <END_OF_CODE+24e820/????>
Trace; 8051910c <END_OF_CODE+2639dc/????>
Trace; 801b0fb8 <net_rx_action+a8/24c>
Trace; 801ae580 <net_tx_action+1c8/1f0>
Trace; 80066d84 <__do_softirq+a4/154>
Trace; 80066e90 <do_softirq+5c/98>
Trace; 8009ac90 <__alloc_pages_internal+3f4/434>
Trace; 80041444 <ret_from_irq+0/4>
Trace; 801784a0 <mem_serial_out+0/20>
Trace; 800bd450 <__kmalloc+b4/124>
Trace; 800bd470 <__kmalloc+d4/124>
Trace; 801a8664 <__alloc_skb+70/148>
Trace; 801a9120 <skb_copy+40/c8>
Trace; 8018c4b8 <ar231x_start_xmit+0/d0>
Trace; 80b42088 <END_OF_CODE+88c958/????>
Trace; 80b42070 <END_OF_CODE+88c940/????>
Trace; 80b419d4 <END_OF_CODE+88c2a4/????>
Trace; 8007425c <queue_work_on+90/a0>
Trace; 800745c8 <worker_thread+1ac/260>
Trace; 800789b4 <kthread+0/a0>
Trace; 800790a8 <autoremove_wake_function+0/4c>
Trace; 8007441c <worker_thread+0/260>
Trace; 80078a10 <kthread+5c/a0>
Trace; 8004e988 <kernel_thread_helper+10/18>

1417 total pagecache pages
4096 pages RAM
1395 pages shared
2630 pages non-shared
Call Trace:[<800493bc>] 0x800493bc
[<800493bc>] 0x800493bc
[<8009ac88>] 0x8009ac88
[<8007d3e4>] 0x8007d3e4
[<800bcf78>] 0x800bcf78
[<800bd538>] 0x800bd538
[<80b41a58>] 0x80b41a58
[<80b42674>] 0x80b42674
[<80b479f8>] 0x80b479f8
[<8052129c>] 0x8052129c
[<80525a20>] 0x80525a20
[<800bd450>] 0x800bd450
[<80041444>] 0x80041444
[<805269e0>] 0x805269e0
[<80525ed8>] 0x80525ed8
[<80503f50>] 0x80503f50
[<8051910c>] 0x8051910c
[<801b0fb8>] 0x801b0fb8
[<801ae580>] 0x801ae580
[<80066d84>] 0x80066d84
[<80066e90>] 0x80066e90
[<8009ac90>] 0x8009ac90
[<80041444>] 0x80041444
[<801784a0>] 0x801784a0
[<800bd450>] 0x800bd450
[<800bd470>] 0x800bd470
[<801a8664>] 0x801a8664
[<801a9120>] 0x801a9120
[<8018c4b8>] 0x8018c4b8
[<80b42088>] 0x80b42088
[<80b42070>] 0x80b42070
[<80b419d4>] 0x80b419d4
[<8007425c>] 0x8007425c
[<800745c8>] 0x800745c8
[<800789b4>] 0x800789b4
[<800790a8>] 0x800790a8
[<8007441c>] 0x8007441c
[<80078a10>] 0x80078a10
[<8004e988>] 0x8004e988
CPU    0: hi:    0, btch:   1 usd:   0
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; 800493bc <dump_stack+20/50>
Trace; 800493bc <dump_stack+20/50>
Trace; 8009ac88 <__alloc_pages_internal+3ec/434>
Trace; 8007d3e4 <ktime_get+18/3c>
Trace; 800bcf78 <cache_alloc_refill+2d8/6fc>
Trace; 800bd538 <kmem_cache_alloc+78/e8>
Trace; 80b41a58 <END_OF_CODE+88c328/????>
Trace; 80b42674 <END_OF_CODE+88cf44/????>
Trace; 80b479f8 <END_OF_CODE+8922c8/????>
Trace; 8052129c <END_OF_CODE+26bb6c/????>
Trace; 80525a20 <END_OF_CODE+2702f0/????>
Trace; 800bd450 <__kmalloc+b4/124>
Trace; 80041444 <ret_from_irq+0/4>
Trace; 805269e0 <END_OF_CODE+2712b0/????>
Trace; 80525ed8 <END_OF_CODE+2707a8/????>
Trace; 80503f50 <END_OF_CODE+24e820/????>
Trace; 8051910c <END_OF_CODE+2639dc/????>
Trace; 801b0fb8 <net_rx_action+a8/24c>
Trace; 801ae580 <net_tx_action+1c8/1f0>
Trace; 80066d84 <__do_softirq+a4/154>
Trace; 80066e90 <do_softirq+5c/98>
Trace; 8009ac90 <__alloc_pages_internal+3f4/434>
Trace; 80041444 <ret_from_irq+0/4>
Trace; 801784a0 <mem_serial_out+0/20>
Trace; 800bd450 <__kmalloc+b4/124>
Trace; 800bd470 <__kmalloc+d4/124>
Trace; 801a8664 <__alloc_skb+70/148>
Trace; 801a9120 <skb_copy+40/c8>
Trace; 8018c4b8 <ar231x_start_xmit+0/d0>
Trace; 80b42088 <END_OF_CODE+88c958/????>
Trace; 80b42070 <END_OF_CODE+88c940/????>
Trace; 80b419d4 <END_OF_CODE+88c2a4/????>
Trace; 8007425c <queue_work_on+90/a0>
Trace; 800745c8 <worker_thread+1ac/260>
Trace; 800789b4 <kthread+0/a0>
Trace; 800790a8 <autoremove_wake_function+0/4c>
Trace; 8007441c <worker_thread+0/260>
Trace; 80078a10 <kthread+5c/a0>
Trace; 8004e988 <kernel_thread_helper+10/18>

1417 total pagecache pages
4096 pages RAM
1395 pages shared
2630 pages non-shared
Call Trace:[<800493bc>] 0x800493bc
[<800493bc>] 0x800493bc
[<8009ac88>] 0x8009ac88
[<8018c538>] 0x8018c538
[<800bcf78>] 0x800bcf78
[<800bd450>] 0x800bd450
[<801a8664>] 0x801a8664
[<801a9120>] 0x801a9120
[<80074174>] 0x80074174
[<80b42070>] 0x80b42070
[<8007425c>] 0x8007425c
[<800745c8>] 0x800745c8
[<800789b4>] 0x800789b4
[<800790a8>] 0x800790a8
[<8007441c>] 0x8007441c
[<80078a10>] 0x80078a10
[<8004e988>] 0x8004e988
CPU    0: hi:    0, btch:   1 usd:   0
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; 800493bc <dump_stack+20/50>
Trace; 800493bc <dump_stack+20/50>
Trace; 8009ac88 <__alloc_pages_internal+3ec/434>
Trace; 8018c538 <ar231x_start_xmit+80/d0>
Trace; 800bcf78 <cache_alloc_refill+2d8/6fc>
Trace; 800bd450 <__kmalloc+b4/124>
Trace; 801a8664 <__alloc_skb+70/148>
Trace; 801a9120 <skb_copy+40/c8>
Trace; 80074174 <__queue_work+7c/b8>
Trace; 80b42070 <END_OF_CODE+88c940/????>
Trace; 8007425c <queue_work_on+90/a0>
Trace; 800745c8 <worker_thread+1ac/260>
Trace; 800789b4 <kthread+0/a0>
Trace; 800790a8 <autoremove_wake_function+0/4c>
Trace; 8007441c <worker_thread+0/260>
Trace; 80078a10 <kthread+5c/a0>
Trace; 8004e988 <kernel_thread_helper+10/18>

1417 total pagecache pages
4096 pages RAM
1395 pages shared
2630 pages non-shared

8 warnings issued.  Results may not be reliable.

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset="utf-8"
Content-Disposition: attachment; filename="kernel-panic-1825-23-01-10.log"
Content-Transfer-Encoding: 8bit

BusyBox v1.14.4 (2010-01-22 23:22:23 CET) built-in shell (ash)
Enter 'help' for a list of built-in commands.

  _______                     ________        __
 |       |.-----.-----.-----.|  |  |  |.----.|  |_
 |   -   ||  _  |  -__|     ||  |  |  ||   _||   _|
 |_______||   __|_____|__|__||________||__|  |____|
          |__| W I R E L E S S   F R E E D O M
 KAMIKAZE (bleeding edge, r18405) ------------------
  * 10 oz Vodka       Shake well with ice and strain
  * 10 oz Triple sec  mixture into 10 shot glasses.
  * 10 oz lime juice  Salute!
 ---------------------------------------------------
root@OpenWrt:~# batctl o -b
  Originator     (#/255)           Nexthop [outgoingIF]:   Potential nexthops ... [B.A.T.M.A.N. adv 0.2.1-beta r1545, MainIF/MAC: ath2/0a:24:01:b7:6a:d1]
06:22:b0:98:87:f9  (  3) 0a:24:01:b7:61:1b [      ath2]: 06:22:b0:98:87:f9 (  0) 0a:24:01:b7:61:1b (  3) 06:24:01:b7:69:c1 (  1)
06:24:01:b7:69:c1  ( 11) 06:24:01:b7:69:c1 [      ath2]: 06:24:01:b7:69:c1 ( 11)
0a:24:01:b7:61:19  (  3) 0a:24:01:b7:6a:fd [      ath2]: 0a:24:01:b7:61:19 (  0) 0a:24:01:b7:6a:fd (  3)
0a:24:01:b7:61:1b  ( 19) 0a:24:01:b7:61:1b [      ath2]: 0a:24:01:b7:61:1b ( 19) 06:24:01:b7:69:c1 (  0) 06:22:b0:98:87:f9 (  0)
0a:24:01:b7:6a:fd  ( 10) 0a:24:01:b7:6a:fd [      ath2]: 0a:24:01:b7:6a:fd ( 10) 0a:24:01:b7:61:49 (  0)
0a:24:01:b7:61:49  ( 10) 0a:24:01:b7:61:49 [      ath2]: 0a:24:01:b7:61:49 ( 10) 0a:24:01:b7:61:1b (  1)
root@OpenWrt:~# dmesg
Linux version 2.6.30.9 (linus@Linus-Debian) (gcc version 4.3.3 (GCC) ) #56 Fri Jan 22 23:24:25 CET 2010
CPU revision is: 00019064 (MIPS 4KEc)
Determined physical RAM map:
 memory: 01000000 @ 00000000 (usable)
Initrd not found or empty - disabling initrd
Zone PFN ranges:
  Normal   0x00000000 -> 0x00001000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00001000
On node 0 totalpages: 4096
free_area_init_node: node 0, pgdat 8027ef40, node_mem_map 802b7000
  Normal zone: 32 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 4064 pages, LIFO batch:0
Built 1 zonelists in Zone order, mobility grouping off.  Total pages: 4064
Kernel command line: console=ttyS0,9600 rootfstype=squashfs,jffs2
Primary instruction cache 16kB, VIPT, 4-way, linesize 16 bytes.
Primary data cache 16kB, 4-way, VIPT, no aliases, linesize 16 bytes
NR_IRQS:128
PID hash table entries: 64 (order: 6, 256 bytes)
console [ttyS0] enabled
Dentry cache hash table entries: 2048 (order: 1, 8192 bytes)
Inode-cache hash table entries: 1024 (order: 0, 4096 bytes)
Memory: 13460k/16384k available (1976k kernel code, 2924k reserved, 324k data, 128k init, 0k highmem)
Calibrating delay loop... 183.50 BogoMIPS (lpj=917504)
Mount-cache hash table entries: 512
net_namespace: 732 bytes
NET: Registered protocol family 16
bio: create slab <bio-0> at 0
Switched to high resolution mode on CPU 0
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 512 (order: 0, 4096 bytes)
TCP bind hash table entries: 512 (order: -1, 2048 bytes)
TCP: Hash tables configured (established 512 bind 512)
TCP reno registered
NET: Registered protocol family 1
Radio config found at offset 0xf8(0x1f8)
squashfs: version 4.0 (2009/01/31) Phillip Lougher
Registering mini_fo version $Id$
JFFS2 version 2.2. (NAND) (SUMMARY)  © 2001-2006 Red Hat, Inc.
msgmni has been set to 26
io scheduler noop registered
io scheduler deadline registered (default)
gpiodev: gpio device registered with major 254
gpiodev: gpio platform device registered with access mask FFFFFFFF
Serial: 8250/16550 driver, 1 ports, IRQ sharing disabled
serial8250: ttyS0 at MMIO 0xb1100003 (irq = 37) is a 16550A
eth0: Atheros AR231x: 00:24:01:b7:6a:d2, irq 4
ar231x_eth_mii: probed
eth0: attached PHY driver [IC+ IP175C] (mii_bus:phy_addr=0:00)
cmdlinepart partition parsing not available
Searching for RedBoot partition table in spiflash at offset 0x3d0000
Searching for RedBoot partition table in spiflash at offset 0x3e0000
6 RedBoot partitions found on MTD device spiflash
Creating 6 MTD partitions on "spiflash":
0x000000000000-0x000000030000 : "RedBoot"
0x000000030000-0x0000002f0000 : "rootfs"
mtd: partition "rootfs" set to be root filesystem
mtd: partition "rootfs_data" created automatically, ofs=250000, len=A0000
0x000000250000-0x0000002f0000 : "rootfs_data"
0x0000002f0000-0x0000003d0000 : "vmlinux.bin.l7"
0x0000003e0000-0x0000003ef000 : "FIS directory"
0x0000003ef000-0x0000003f0000 : "RedBoot config"
0x0000003f0000-0x000000400000 : "boardconfig"
TCP westwood registered
NET: Registered protocol family 17
Bridge firewalling registered
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
VFS: Mounted root (squashfs filesystem) readonly on device 31:1.
Freeing unused kernel memory: 128k freed
Please be patient, while OpenWrt loads ...
mini_fo: using base directory: /
mini_fo: using storage directory: /tmp/root
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
device eth0.1 entered promiscuous mode
device eth0 entered promiscuous mode
br-mesh: port 1(eth0.1) entering forwarding state
ip_tables: (C) 2000-2006 Netfilter Core Team
Ebtables v2.0 registered
ip6_tables: (C) 2000-2006 Netfilter Core Team
batman-adv:B.A.T.M.A.N. advanced 0.2.1-beta r1545 (compatibility version 8) loaded
device eth0.4 entered promiscuous mode
br-wan_vpn: port 1(eth0.4) entering forwarding state
ath_hal: module license 'Proprietary' taints kernel.
Disabling lock debugging due to kernel taint
ath_hal: 2009-05-08 (AR5212, AR5312, RF5111, RF5112, RF2316, RF2317, REGOPS_FUNC, TX_DESC_SWAP, XR)
br-wan_vpn: starting userspace STP failed, starting kernel STP
eth0.1: no IPv6 routers present
ath_ahb: trunk
wlan: trunk
wlan: mac acl policy registered
ath_rate_minstrel: Minstrel automatic rate control algorithm 1.2 (trunk)
br-mesh: no IPv6 routers present
ath_rate_minstrel: look around rate set to 10%
ath_rate_minstrel: EWMA rolloff level set to 75%
ath_rate_minstrel: max segment size in the mrr set to 6000 us
Atheros HAL provided by OpenWrt, DD-WRT and MakSat Technologies
wifi0: 11b rates: 1Mbps 2Mbps 5.5Mbps 11Mbps
wifi0: 11g rates: 1Mbps 2Mbps 5.5Mbps 11Mbps 6Mbps 9Mbps 12Mbps 18Mbps 24Mbps 36Mbps 48Mbps 54Mbps
wifi0: turboG rates: 6Mbps 12Mbps 18Mbps 24Mbps 36Mbps 48Mbps 54Mbps
wifi0: H/W encryption support: WEP AES AES_CCM TKIP
ath_ahb: wifi0: Atheros 2317 WiSoC REV1: mem=0xb0000000, irq=3
IRQ 3/wifi0: IRQF_DISABLED is not guaranteed on shared IRQs
eth0.2: no IPv6 routers present
device bat0 entered promiscuous mode
br-mesh: port 2(bat0) entering forwarding state
eth0.3: no IPv6 routers present
eth0.4: no IPv6 routers present
device ath0 entered promiscuous mode
br-mesh: port 3(ath0) entering forwarding state
device ath0 left promiscuous mode
br-mesh: port 3(ath0) entering disabled state
device ath0 entered promiscuous mode
br-mesh: port 3(ath0) entering forwarding state
bat0: no IPv6 routers present
device ath1 entered promiscuous mode
br-wan_vpn: topology change detected, sending tcn bpdu
br-wan_vpn: port 2(ath1) entering forwarding state
device ath1 left promiscuous mode
br-wan_vpn: port 2(ath1) entering disabled state
device ath1 entered promiscuous mode
br-wan_vpn: topology change detected, sending tcn bpdu
br-wan_vpn: port 2(ath1) entering forwarding state
ath0: no IPv6 routers present
ath1: no IPv6 routers present
br-wan_vpn: port 2(ath1) entering disabled state
br-wan_vpn: port 1(eth0.4) entering disabled state
br-wan_vpn: topology change detected, propagating
br-wan_vpn: topology change detected, propagating
br-wan_vpn: port 2(ath1) entering forwarding state
br-wan_vpn: topology change detected, propagating
br-wan_vpn: port 1(eth0.4) entering forwarding state
br-mesh: port 3(ath0) entering disabled state
br-mesh: port 2(bat0) entering disabled state
br-mesh: port 1(eth0.1) entering disabled state
br-mesh: port 3(ath0) entering forwarding state
br-mesh: port 2(bat0) entering forwarding state
br-mesh: port 1(eth0.1) entering forwarding state
ath2: no IPv6 routers present
br-mesh: no IPv6 routers present
------------[ cut here ]------------
WARNING: at net/sched/sch_generic.c:226 0x801c3554()
NETDEV WATCHDOG: wifi0 (): transmit timed out
Modules linked in: ath_ahb ath_hal(P) batman_adv ip6t_REJECT ip6t_LOG ip6t_rt ip6t_hbh ip6t_mh ip6t_ipv6header ip6t_frag ip6t_eui64 ip6t_ah ip6table_raw ip6_queue ip6table_mangle ip6table_filter ip6_tables ebt_redirect ebt_mark ebt_vlan ebt_stp ebt_pkttype ebt_mark_m ebt_limit ebt_among ebt_802_3 ebtable_nat ebtable_filter ebtable_broute ebtables xt_quota xt_pkttype xt_physdev ipt_REJECT xt_TCPMSS ipt_LOG xt_multiport xt_mac xt_limit iptable_mangle iptable_filter ip_tables xt_tcpudp x_tables tun ipv6
Call Trace:[<800493bc>] 0x800493bc
[<800493bc>] 0x800493bc
[<80060914>] 0x80060914
[<801c3554>] 0x801c3554
[<80060994>] 0x80060994
[<800790bc>] 0x800790bc
[<801c3554>] 0x801c3554
[<8005aaf8>] 0x8005aaf8
[<800741b0>] 0x800741b0
[<80222220>] 0x80222220
[<8007d674>] 0x8007d674
[<80222138>] 0x80222138
[<801c33b8>] 0x801c33b8
[<8006c01c>] 0x8006c01c
[<80066d84>] 0x80066d84
[<80066e90>] 0x80066e90
[<80041444>] 0x80041444

---[ end trace 31db24b68cfbba59 ]---
batman-adv:Adding interface: ath2
batman-adv:Interface activated: ath2
batman-adv:Adding interface: eth0.2
batman-adv:Interface activated: eth0.2
batman-adv:Adding interface: eth0.3
batman-adv:The newly added mac address (00:24:01:b7:6a:d2) already exists on: eth0.2
batman-adv:It is strongly recommended to keep mac addresses unique to avoid problems!
batman-adv:Interface activated: eth0.3
jffs2_scan_eraseblock(): End of filesystem marker found at 0x0
jffs2_build_filesystem(): unlocking the mtd device... done.
jffs2_build_filesystem(): erasing all blocks after the end marker... done.
mini_fo: using base directory: /
mini_fo: using storage directory: /jffs
device VPN entered promiscuous mode
br-wan_vpn: topology change detected, sending tcn bpdu
br-wan_vpn: port 3(VPN) entering forwarding state
br-wan_vpn: neighbor 8000.00:22:b0:98:8c:34 lost on port 1(eth0.4)
br-wan_vpn: topology change detected, propagating
root@OpenWrt:~#

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="kernel-panic-1825-23-01-10.ksymoops"

ksymoops 2.4.11 on x86_64 2.6.31-1-amd64.  Options used
     -v /home/linus/lff-test/kamikaze/build_dir/linux-atheros/linux-2.6.30.9/vmlinux (specified)
     -K (specified)
     -L (specified)
     -o /home/linus/lff-test/kamikaze/build_dir/linux-atheros -o /home/linus/lff-test/kamikaze/build_dir/target-mips_uClibc-0.9.30.1 (specified)
     -m /home/linus/lff-test/kamikaze/build_dir/linux-atheros/linux-2.6.30.9/System.map (specified)

No modules in ksyms, skipping objects
lo: Disabled Privacy Extensions
WARNING: at net/sched/sch_generic.c:226 0x801c3554()
Call Trace:[<800493bc>] 0x800493bc
[<800493bc>] 0x800493bc
[<80060914>] 0x80060914
[<801c3554>] 0x801c3554
[<80060994>] 0x80060994
[<800790bc>] 0x800790bc
[<801c3554>] 0x801c3554
[<8005aaf8>] 0x8005aaf8
[<800741b0>] 0x800741b0
[<80222220>] 0x80222220
[<8007d674>] 0x8007d674
[<80222138>] 0x80222138
[<801c33b8>] 0x801c33b8
[<8006c01c>] 0x8006c01c
[<80066d84>] 0x80066d84
[<80066e90>] 0x80066e90
[<80041444>] 0x80041444
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; 800493bc <dump_stack+20/50>
Trace; 800493bc <dump_stack+20/50>
Trace; 80060914 <warn_slowpath_common+70/b0>
Trace; 801c3554 <dev_watchdog+19c/338>
Trace; 80060994 <warn_slowpath_fmt+24/30>
Trace; 800790bc <autoremove_wake_function+14/4c>
Trace; 801c3554 <dev_watchdog+19c/338>
Trace; 8005aaf8 <__wake_up_common+58/c0>
Trace; 800741b0 <delayed_work_timer_fn+0/1c>
Trace; 80222220 <br_fdb_cleanup+e8/124>
Trace; 8007d674 <hrtimer_interrupt+26c/2a4>
Trace; 80222138 <br_fdb_cleanup+0/124>
Trace; 801c33b8 <dev_watchdog+0/338>
Trace; 8006c01c <run_timer_softirq+17c/234>
Trace; 80066d84 <__do_softirq+a4/154>
Trace; 80066e90 <do_softirq+5c/98>
Trace; 80041444 <ret_from_irq+0/4>


1 warning issued.  Results may not be reliable.

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset="utf-8"
Content-Disposition: attachment; filename="kernel-panic-1831-23-01-10.log"
Content-Transfer-Encoding: 8bit

root@OpenWrt:~# batctl o -b
  Originator     (#/255)           Nexthop [outgoingIF]:   Potential nexthops ... [B.A.T.M.A.N. adv 0.2.1-beta r1545, MainIF/MAC: ath2/0a:24:01:b7:61:1b]
06:22:b0:98:87:f9  ( 23) 06:22:b0:98:87:f9 [      ath2]: 06:22:b0:98:87:f9 ( 23)
06:24:01:b7:69:c1  ( 21) 06:24:01:b7:69:c1 [      ath2]: 06:24:01:b7:69:c1 ( 21) 0a:24:01:b7:6a:d1 (  1)
0a:24:01:b7:61:19  (  4) 0a:24:01:b7:61:49 [      ath2]: 0a:24:01:b7:61:19 (  0) 0a:24:01:b7:6a:d1 (  1) 0a:24:01:b7:61:49 (  4)
0a:24:01:b7:6a:d1  ( 35) 0a:24:01:b7:6a:d1 [      ath2]: 0a:24:01:b7:6a:d1 ( 35) 06:24:01:b7:69:c1 (  0)
0a:24:01:b7:6a:fd  ( 10) 0a:24:01:b7:6a:fd [      ath2]: 0a:24:01:b7:6a:fd ( 10) 0a:24:01:b7:6a:d1 (  0) 0a:24:01:b7:61:49 (  0)
0a:24:01:b7:61:49  ( 10) 0a:24:01:b7:61:49 [      ath2]: 0a:24:01:b7:61:49 ( 10) 0a:24:01:b7:6a:fd (  6)
root@OpenWrt:~# dmesg
Linux version 2.6.30.9 (linus@Linus-Debian) (gcc version 4.3.3 (GCC) ) #49 Fri Jan 22 18:48:49 CET 2010
CPU revision is: 00019064 (MIPS 4KEc)
Determined physical RAM map:
 memory: 01000000 @ 00000000 (usable)
Initrd not found or empty - disabling initrd
Zone PFN ranges:
  Normal   0x00000000 -> 0x00001000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00001000
On node 0 totalpages: 4096
free_area_init_node: node 0, pgdat 8027ef40, node_mem_map 802b7000
  Normal zone: 32 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 4064 pages, LIFO batch:0
Built 1 zonelists in Zone order, mobility grouping off.  Total pages: 4064
Kernel command line: console=ttyS0,9600 rootfstype=squashfs,jffs2
Primary instruction cache 16kB, VIPT, 4-way, linesize 16 bytes.
Primary data cache 16kB, 4-way, VIPT, no aliases, linesize 16 bytes
NR_IRQS:128
PID hash table entries: 64 (order: 6, 256 bytes)
console [ttyS0] enabled
Dentry cache hash table entries: 2048 (order: 1, 8192 bytes)
Inode-cache hash table entries: 1024 (order: 0, 4096 bytes)
Memory: 13460k/16384k available (1976k kernel code, 2924k reserved, 324k data, 128k init, 0k highmem)
Calibrating delay loop... 183.50 BogoMIPS (lpj=917504)
Mount-cache hash table entries: 512
net_namespace: 732 bytes
NET: Registered protocol family 16
bio: create slab <bio-0> at 0
Switched to high resolution mode on CPU 0
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 512 (order: 0, 4096 bytes)
TCP bind hash table entries: 512 (order: -1, 2048 bytes)
TCP: Hash tables configured (established 512 bind 512)
TCP reno registered
NET: Registered protocol family 1
Radio config found at offset 0xf8(0x1f8)
squashfs: version 4.0 (2009/01/31) Phillip Lougher
Registering mini_fo version $Id$
JFFS2 version 2.2. (NAND) (SUMMARY)  © 2001-2006 Red Hat, Inc.
msgmni has been set to 26
io scheduler noop registered
io scheduler deadline registered (default)
gpiodev: gpio device registered with major 254
gpiodev: gpio platform device registered with access mask FFFFFFFF
Serial: 8250/16550 driver, 1 ports, IRQ sharing disabled
serial8250: ttyS0 at MMIO 0xb1100003 (irq = 37) is a 16550A
eth0: Atheros AR231x: 00:24:01:b7:61:1c, irq 4
ar231x_eth_mii: probed
eth0: attached PHY driver [IC+ IP175C] (mii_bus:phy_addr=0:00)
cmdlinepart partition parsing not available
Searching for RedBoot partition table in spiflash at offset 0x3d0000
Searching for RedBoot partition table in spiflash at offset 0x3e0000
6 RedBoot partitions found on MTD device spiflash
Creating 6 MTD partitions on "spiflash":
0x000000000000-0x000000030000 : "RedBoot"
0x000000030000-0x0000002f0000 : "rootfs"
mtd: partition "rootfs" set to be root filesystem
mtd: partition "rootfs_data" created automatically, ofs=250000, len=A0000
0x000000250000-0x0000002f0000 : "rootfs_data"
0x0000002f0000-0x0000003d0000 : "vmlinux.bin.l7"
0x0000003e0000-0x0000003ef000 : "FIS directory"
0x0000003ef000-0x0000003f0000 : "RedBoot config"
0x0000003f0000-0x000000400000 : "boardconfig"
TCP westwood registered
NET: Registered protocol family 17
Bridge firewalling registered
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
VFS: Mounted root (squashfs filesystem) readonly on device 31:1.
Freeing unused kernel memory: 128k freed
Please be patient, while OpenWrt loads ...
mini_fo: using base directory: /
mini_fo: using storage directory: /jffs
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
device eth0.1 entered promiscuous mode
device eth0 entered promiscuous mode
br-mesh: port 1(eth0.1) entering forwarding state
ip_tables: (C) 2000-2006 Netfilter Core Team
Ebtables v2.0 registered
ip6_tables: (C) 2000-2006 Netfilter Core Team
batman-adv:B.A.T.M.A.N. advanced 0.2.1-beta r1545 (compatibility version 8) loaded
device eth0.4 entered promiscuous mode
br-wan_vpn: port 1(eth0.4) entering forwarding state
br-wan_vpn: starting userspace STP failed, starting kernel STP
ath_hal: module license 'Proprietary' taints kernel.
Disabling lock debugging due to kernel taint
ath_hal: 2009-05-08 (AR5212, AR5312, RF5111, RF5112, RF2316, RF2317, REGOPS_FUNC, TX_DESC_SWAP, XR)
eth0.1: no IPv6 routers present
br-mesh: no IPv6 routers present
ath_ahb: trunk
wlan: trunk
wlan: mac acl policy registered
ath_rate_minstrel: Minstrel automatic rate control algorithm 1.2 (trunk)
ath_rate_minstrel: look around rate set to 10%
ath_rate_minstrel: EWMA rolloff level set to 75%
ath_rate_minstrel: max segment size in the mrr set to 6000 us
Atheros HAL provided by OpenWrt, DD-WRT and MakSat Technologies
wifi0: 11b rates: 1Mbps 2Mbps 5.5Mbps 11Mbps
wifi0: 11g rates: 1Mbps 2Mbps 5.5Mbps 11Mbps 6Mbps 9Mbps 12Mbps 18Mbps 24Mbps 36Mbps 48Mbps 54Mbps
wifi0: turboG rates: 6Mbps 12Mbps 18Mbps 24Mbps 36Mbps 48Mbps 54Mbps
wifi0: H/W encryption support: WEP AES AES_CCM TKIP
ath_ahb: wifi0: Atheros 2317 WiSoC REV1: mem=0xb0000000, irq=3
IRQ 3/wifi0: IRQF_DISABLED is not guaranteed on shared IRQs
eth0.2: no IPv6 routers present
device bat0 entered promiscuous mode
br-mesh: port 2(bat0) entering forwarding state
eth0.3: no IPv6 routers present
br-wan_vpn: no IPv6 routers present
eth0.4: no IPv6 routers present
device ath0 entered promiscuous mode
br-mesh: port 3(ath0) entering forwarding state
bat0: no IPv6 routers present
device ath0 left promiscuous mode
br-mesh: port 3(ath0) entering disabled state
device ath0 entered promiscuous mode
br-mesh: port 3(ath0) entering forwarding state
device ath1 entered promiscuous mode
br-wan_vpn: topology change detected, sending tcn bpdu
br-wan_vpn: port 2(ath1) entering forwarding state
device ath1 left promiscuous mode
br-wan_vpn: port 2(ath1) entering disabled state
device ath1 entered promiscuous mode
br-wan_vpn: topology change detected, sending tcn bpdu
br-wan_vpn: port 2(ath1) entering forwarding state
ath0: no IPv6 routers present
br-wan_vpn: port 2(ath1) entering disabled state
br-wan_vpn: port 1(eth0.4) entering disabled state
br-wan_vpn: topology change detected, propagating
br-wan_vpn: topology change detected, propagating
br-wan_vpn: port 2(ath1) entering forwarding state
br-wan_vpn: topology change detected, propagating
br-wan_vpn: port 1(eth0.4) entering forwarding state
br-mesh: port 3(ath0) entering disabled state
br-mesh: port 2(bat0) entering disabled state
br-mesh: port 1(eth0.1) entering disabled state
br-mesh: port 3(ath0) entering forwarding state
br-mesh: port 2(bat0) entering forwarding state
br-mesh: port 1(eth0.1) entering forwarding state
ath1: no IPv6 routers present
ath2: no IPv6 routers present
br-mesh: no IPv6 routers present
batman-adv:Adding interface: ath2
batman-adv:Interface activated: ath2
batman-adv:Adding interface: eth0.2
batman-adv:Interface activated: eth0.2
batman-adv:Adding interface: eth0.3
batman-adv:The newly added mac address (00:24:01:b7:61:1c) already exists on: eth0.2
batman-adv:It is strongly recommended to keep mac addresses unique to avoid problems!
batman-adv:Interface activated: eth0.3
br-wan_vpn: port 2(ath1) entering disabled state
device VPN entered promiscuous mode
br-wan_vpn: topology change detected, sending tcn bpdu
br-wan_vpn: port 3(VPN) entering forwarding state
br-wan_vpn: port 3(VPN) entering disabled state
br-wan_vpn: topology change detected, sending tcn bpdu
br-wan_vpn: port 3(VPN) entering forwarding state
br-wan_vpn: neighbor 8000.00:22:b0:98:8c:34 lost on port 1(eth0.4)
br-wan_vpn: topology change detected, propagating
------------[ cut here ]------------
WARNING: at net/sched/sch_generic.c:226 0x801c3554()
NETDEV WATCHDOG: wifi0 (): transmit timed out
Modules linked in: ath_ahb ath_hal(P) batman_adv ip6t_REJECT ip6t_LOG ip6t_rt ip6t_hbh ip6t_mh ip6t_ipv6header ip6t_frag ip6t_eui64 ip6t_ah ip6table_raw ip6_queue ip6table_mangle ip6table_filter ip6_tables ebt_redirect ebt_mark ebt_vlan ebt_stp ebt_pkttype ebt_mark_m ebt_limit ebt_among ebt_802_3 ebtable_nat ebtable_filter ebtable_broute ebtables xt_quota xt_pkttype xt_physdev ipt_REJECT xt_TCPMSS ipt_LOG xt_multiport xt_mac xt_limit iptable_mangle iptable_filter ip_tables xt_tcpudp x_tables tun ipv6
Call Trace:[<800493bc>] 0x800493bc
[<800493bc>] 0x800493bc
[<80060914>] 0x80060914
[<801c3554>] 0x801c3554
[<80060994>] 0x80060994
[<801c3554>] 0x801c3554
[<80086bf4>] 0x80086bf4
[<8007d674>] 0x8007d674
[<801b0838>] 0x801b0838
[<801c33b8>] 0x801c33b8
[<8006c01c>] 0x8006c01c
[<80066d84>] 0x80066d84
[<80066e90>] 0x80066e90
[<80041444>] 0x80041444
[<80041660>] 0x80041660
[<8018c4b8>] 0x8018c4b8
[<8004e85c>] 0x8004e85c
[<80041680>] 0x80041680
[<80281a4c>] 0x80281a4c
[<80281370>] 0x80281370

---[ end trace bf8b652a122b3db4 ]---
root@OpenWrt:~#

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="kernel-panic-1831-23-01-10.ksymoops"

ksymoops 2.4.11 on x86_64 2.6.31-1-amd64.  Options used
     -v /home/linus/lff-test/kamikaze/build_dir/linux-atheros/linux-2.6.30.9/vmlinux (specified)
     -K (specified)
     -L (specified)
     -o /home/linus/lff-test/kamikaze/build_dir/linux-atheros -o /home/linus/lff-test/kamikaze/build_dir/target-mips_uClibc-0.9.30.1 (specified)
     -m /home/linus/lff-test/kamikaze/build_dir/linux-atheros/linux-2.6.30.9/System.map (specified)

No modules in ksyms, skipping objects
lo: Disabled Privacy Extensions
WARNING: at net/sched/sch_generic.c:226 0x801c3554()
Call Trace:[<800493bc>] 0x800493bc
[<800493bc>] 0x800493bc
[<80060914>] 0x80060914
[<801c3554>] 0x801c3554
[<80060994>] 0x80060994
[<801c3554>] 0x801c3554
[<80086bf4>] 0x80086bf4
[<8007d674>] 0x8007d674
[<801b0838>] 0x801b0838
[<801c33b8>] 0x801c33b8
[<8006c01c>] 0x8006c01c
[<80066d84>] 0x80066d84
[<80066e90>] 0x80066e90
[<80041444>] 0x80041444
[<80041660>] 0x80041660
[<8018c4b8>] 0x8018c4b8
[<8004e85c>] 0x8004e85c
[<80041680>] 0x80041680
[<80281a4c>] 0x80281a4c
[<80281370>] 0x80281370
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; 800493bc <dump_stack+20/50>
Trace; 800493bc <dump_stack+20/50>
Trace; 80060914 <warn_slowpath_common+70/b0>
Trace; 801c3554 <dev_watchdog+19c/338>
Trace; 80060994 <warn_slowpath_fmt+24/30>
Trace; 801c3554 <dev_watchdog+19c/338>
Trace; 80086bf4 <tick_program_event+28/34>
Trace; 8007d674 <hrtimer_interrupt+26c/2a4>
Trace; 801b0838 <process_backlog+d4/14c>
Trace; 801c33b8 <dev_watchdog+0/338>
Trace; 8006c01c <run_timer_softirq+17c/234>
Trace; 80066d84 <__do_softirq+a4/154>
Trace; 80066e90 <do_softirq+5c/98>
Trace; 80041444 <ret_from_irq+0/4>
Trace; 80041660 <r4k_wait+0/40>
Trace; 8018c4b8 <ar231x_start_xmit+0/d0>
Trace; 8004e85c <cpu_idle+24/4c>
Trace; 80041680 <r4k_wait+20/40>
Trace; 80281a4c <start_kernel+36c/384>
Trace; 80281370 <unknown_bootoption+0/2fc>


1 warning issued.  Results may not be reliable.

--OXfL5xGRrasGEqWY--
