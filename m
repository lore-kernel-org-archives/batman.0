Return-Path: <linus.luessing@c0d3.blue>
Date: Fri, 24 Nov 2017 22:48:16 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20171124214816.GA10087@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] Interpreting a Mem-Info Section of an OOM
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: gluon@luebeck.freifunk.net

Hi,

With some larger mesh networks running Gluon some Out-of-Memory
cases on 32MB RAM devices were reported [0].

For the following Mem-Info section, the number of free pages
confuses me a little:

[...]
[  236.529242] Mem-Info:
[  236.531561] active_anon:691 inactive_anon:9 isolated_anon:0
[  236.531561]  active_file:131 inactive_file:138 isolated_file:0
[  236.531561]  unevictable:0 dirty:0 writeback:0 unstable:0
[  236.531561]  slab_reclaimable:205 slab_unreclaimable:3105
[  236.531561]  mapped:39 shmem:28 pagetables:80 bounce:0
[  236.531561]  free:289 free_pcp:0 free_cma:0
[  236.563259] Normal free:1156kB min:1024kB low:1280kB high:1536kB active_anon:2764kB inactive_anon:36kB active_file:524kB inactive_file:552kB unevictable:0kB isolated(anon):0kB isolated(file):0kB present:32768kB managed:27776kB mlocked:0kB dirty:0kB writeback:0kB mapped:156kB shmem:112kB slab_reclaimable:820kB slab_unreclaimable:12420kB kernel_stack:424kB pagetables:320kB unstable:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB writeback_tmp:0kB pages_scanned:6492 all_unreclaimable? yes
[  236.607070] lowmem_reserve[]: 0 0
[  236.610425] Normal: 125*4kB (UME) 34*8kB (UME) 16*16kB (UME) 4*32kB (ME) 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 1156kB
[  236.623157] 297 total pagecache pages
[  236.626852] 0 pages in swap cache
[  236.630189] Swap cache stats: add 0, delete 0, find 0/0
[  236.635455] Free swap  = 0kB
[  236.638355] Total swap = 0kB
[  236.641251] 8192 pages RAM
[  236.643971] 0 pages HighMem/MovableOnly
[  236.647837] 1248 pages reserved
[...]

(Full log here[1], including some slabinfo; with a backport of
these slabinfo related patches applied [2])

It says that only 289 pages are left. However those numbers listed
in the Mem-Info section do not seem to add up to 8192 minus 1289 reserved
minus 289 free pages.

Any idea why it might list only 289 free pages?

Regards, Linus

[0]: https://github.com/freifunk-gluon/gluon/issues/1243
     https://github.com/freifunk-gluon/gluon/issues/1197
[1]: https://paste.linuxlounge.net/#/GUMP_cQOKwgqQhf5_gBfPU1Vv0A!7bT80KaCMPcUC_zIBbw6h5s3ewQ27IFuYW5_H42HWC0
[2]: https://lkml.org/lkml/2017/10/4/788
