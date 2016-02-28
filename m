Return-Path: <philipp.psurek@gmail.com>
Message-ID: <1456678554.1958.40.camel@gmail.com>
From: Philipp Psurek <philipp.psurek@gmail.com>
Date: Sun, 28 Feb 2016 17:55:54 +0100
In-Reply-To: <20160228132736.GI5481@otheros>
References: <1456616348.1958.16.camel@gmail.com>
 <20160228132736.GI5481@otheros>
Content-Type: text/plain; charset="utf-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi Linus,

thank you for your answer. (Un)fortunately I can not reproduce the page
allocation failure any more after adding one more Batman device to the
Ethernet or moving some files through NFS. 

Am Sonntag, den 28.02.2016, 14:27 +0100 schrieb Linus Lüssing:
[…]
> PS: How much (free and in total) RAM does your device have, which
> device is

The ARM device is a Cubieboard with Allwinner A20 CPU and 1 GiB RAM.
The RAM usage was not different to this output [1], but I can not
assure this. Anyway the system has plenty of RAM and was idle

> it exactly? Just that others know how much RAM is needed to read
> from debugfs with a 300+ nodes setup right now.

There is no problem watching the originators on an 32 MiB RAM OpenWrt
router with 3.10.49 mips.

I'm sorry bothering you with this issue. Have a lot of fun developing
B.A.T.M.A.N. advanced.

Best regards,
  Philipp


[1] # cat /proc/meminfo
MemTotal:        1011224 kB
MemFree:           18044 kB
Buffers:           61100 kB
Cached:           825416 kB
SwapCached:            0 kB
Active:           383532 kB
Inactive:         548588 kB
Active(anon):      24220 kB
Inactive(anon):    21984 kB
Active(file):     359312 kB
Inactive(file):   526604 kB
Unevictable:           0 kB
Mlocked:               0 kB
HighTotal:        270336 kB
HighFree:            988 kB
LowTotal:         740888 kB
LowFree:           17056 kB
SwapTotal:       4194300 kB
SwapFree:        4194300 kB
Dirty:              1580 kB
Writeback:             0 kB
AnonPages:         45656 kB
Mapped:             3844 kB
Shmem:               616 kB
Slab:              47596 kB
SReclaimable:      37300 kB
SUnreclaim:        10296 kB
KernelStack:         792 kB
PageTables:         1004 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:     4699912 kB
Committed_AS:     117352 kB
VmallocTotal:     245760 kB
VmallocUsed:       14052 kB
VmallocChunk:     212928 kB
