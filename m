Return-Path: <russell@personaltelco.net>
References: <52E51A04.8020800@meshcoding.com>
 <1390746256-551-1-git-send-email-antonio@meshcoding.com>
From: Russell Senior <russell@personaltelco.net>
Date: Mon, 27 Jan 2014 10:43:19 -0800
In-Reply-To: <1390746256-551-1-git-send-email-antonio@meshcoding.com> (Antonio
 Quartulli's message of "Sun\, 26 Jan 2014 15\:24\:16 +0100")
Message-ID: <86zjmhfepk.fsf@coulee.tdb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: release vlan object
	after checking the CRC
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

>>>>> "Antonio" == Antonio Quartulli <antonio@meshcoding.com> writes:

Antonio> There is a refcounter unbalance in the CRC checking routine
Antonio> invoked on OGM reception. A vlan object is retrieved (thus
Antonio> its refcounter is increased by one) but it is never properly
Antonio> released. This leads to a memleak because the vlan object
Antonio> will never be free'd.

Antonio> Fix this by releasing the vlan object after having read the
Antonio> CRC.

Antonio> Reported-by: Russell Senior <russell@personaltelco.net>
Antonio> [...]

I am still seeing a kernel memory leak, even with this patch.

My test configuration is a Ubiquiti AirRouter (ar71xx) on OpenWrt r39397 with
this patch and the MTU patch on one end, and a Soekris net4826 (x86)
on the same OpenWrt r39397 revision and patchs on the other end
(kmemleak also enabled on the x86 end, not on the ar71xx end).  

The airrouter, with the bat0 interface disabled, has a /proc/meminfo
that looks like this right after boot:

  root@ar0:/# cat /proc/meminfo 
  MemTotal:          29044 kB
  MemFree:            8220 kB
  Buffers:            2164 kB
  Cached:             6176 kB
  SwapCached:            0 kB
  Active:             4624 kB
  Inactive:           5672 kB
  Active(anon):       1984 kB
  Inactive(anon):       20 kB
  Active(file):       2640 kB
  Inactive(file):     5652 kB
  Unevictable:           0 kB
  Mlocked:               0 kB
  SwapTotal:             0 kB
  SwapFree:              0 kB
  Dirty:                 0 kB
  Writeback:             0 kB
  AnonPages:          1972 kB
  Mapped:             1872 kB
  Shmem:                48 kB
  Slab:               4928 kB
  SReclaimable:        932 kB
  SUnreclaim:         3996 kB
  KernelStack:         272 kB
  PageTables:          188 kB
  NFS_Unstable:          0 kB
  Bounce:                0 kB
  WritebackTmp:          0 kB
  CommitLimit:       14520 kB
  Committed_AS:       3992 kB
  VmallocTotal:    1048372 kB
  VmallocUsed:        1476 kB
  VmallocChunk:    1043448 kB

With bat0 enabled, however, the AirRouter will begin to become
unresponsive at around 7m15s after boot and then OOM and reboot within
9 minutes of uptime.  Using "watch -d cat /proc/meminfo", I see
MemFree first erode, then it begin to chew into Buffers and Cached
until supreme unhappiness ensues.

On the x86 side, I see some activity from kmemleak, which
substantially goes away when batman-adv does not have a peer.  The
unreferenced objects that show up in /sys/kernel/debug/kmemleak look
like this (only a sample):

  unreferenced object 0xc2eab000 (size 184):
    comm "softirq", pid 0, jiffies 33396 (age 692.960s)
    hex dump (first 32 bytes):
      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
      00 00 00 00 00 00 3c c2 00 00 00 00 00 00 00 00  ......<.........
    backtrace:
      [<c10039b9>] print_context_stack+0x99/0xb0
      [<c108cf00>] kmem_cache_alloc+0xd0/0xf0
      [<c12eedc9>] build_skb+0x29/0x140
      [<c12eedc9>] build_skb+0x29/0x140
      [<c12f1a86>] __netdev_alloc_skb+0x56/0xd0
      [<c4c020b2>] ath_rxbuf_alloc+0x22/0x80 [ath]
      [<c1372619>] free_debug_processing+0x14c/0x190
      [<c4c42204>] ath5k_stop+0xd4/0xc90 [ath5k]
      [<c4c43773>] ath5k_beacon_update_timers+0x9b3/0x9d0 [ath5k]
      [<c4c02a8f>] ath_hw_cycle_counters_update+0xcf/0x130 [ath]
      [<c108c727>] kmem_cache_free+0xe7/0x100
      [<c105ccfa>] __rcu_process_callbacks+0x5a/0x70
      [<c102d62e>] tasklet_action+0x3e/0x70
      [<c102dac5>] __do_softirq+0x85/0x140
      [<c102da40>] __do_softirq+0x0/0x140
      [<c102dc42>] irq_exit+0x32/0x50
  unreferenced object 0xc0c1c600 (size 184):
    comm "softirq", pid 0, jiffies 33490 (age 692.020s)
    hex dump (first 32 bytes):
      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
      00 00 00 00 00 00 3c c2 00 00 00 00 00 00 00 00  ......<.........
    backtrace:
      [<c10039b9>] print_context_stack+0x99/0xb0
      [<c108cf00>] kmem_cache_alloc+0xd0/0xf0
      [<c12eedc9>] build_skb+0x29/0x140
      [<c12eedc9>] build_skb+0x29/0x140
      [<c12f1a86>] __netdev_alloc_skb+0x56/0xd0
      [<c4c020b2>] ath_rxbuf_alloc+0x22/0x80 [ath]
      [<c1372619>] free_debug_processing+0x14c/0x190
      [<c4c42204>] ath5k_stop+0xd4/0xc90 [ath5k]
      [<c4c43773>] ath5k_beacon_update_timers+0x9b3/0x9d0 [ath5k]
      [<c108c727>] kmem_cache_free+0xe7/0x100
      [<c105ccfa>] __rcu_process_callbacks+0x5a/0x70
      [<c102d62e>] tasklet_action+0x3e/0x70
      [<c102dac5>] __do_softirq+0x85/0x140
      [<c102da40>] __do_softirq+0x0/0x140
      [<c102dc42>] irq_exit+0x32/0x50
      [<c1002b4d>] do_IRQ+0x8d/0xb0

Memory is disappearing at a faster rate than is accounted for here
(size 184 bytes at a time).  The OOM-reboot rate indicates memory is
being consumed at a rate on the order of 30-40 kB per second.

My OpenWrt diffconfig is as follows:

  CONFIG_TARGET_x86=y
  CONFIG_TARGET_x86_generic=y
  CONFIG_TARGET_x86_generic_Soekris48xx=y
  CONFIG_DEVEL=y
  CONFIG_ALFRED_NEEDS_lua=y
  CONFIG_BUILD_LOG=y
  CONFIG_DOWNLOAD_FOLDER="/usr/portage/distfiles"
  CONFIG_KMOD_BATMAN_ADV_BATCTL=y
  CONFIG_KMOD_BATMAN_ADV_BLA=y
  CONFIG_KMOD_BATMAN_ADV_DAT=y
  CONFIG_KMOD_BATMAN_ADV_DEBUG_LOG=y
  CONFIG_LIBCURL_FILE=y
  CONFIG_LIBCURL_FTP=y
  CONFIG_LIBCURL_HTTP=y
  CONFIG_LIBCURL_POLARSSL=y
  CONFIG_OPENSSL_WITH_EC=y
  CONFIG_PACKAGE_ALFRED_BATHOSTS=y
  CONFIG_PACKAGE_ALFRED_VIS=y
  CONFIG_PACKAGE_MAC80211_DEBUGFS=y
  CONFIG_PACKAGE_MAC80211_MESH=y
  CONFIG_PACKAGE_alfred=y
  CONFIG_PACKAGE_bridge=y
  CONFIG_PACKAGE_crda=y
  CONFIG_PACKAGE_curl=y
  CONFIG_PACKAGE_diffutils=y
  # CONFIG_PACKAGE_dnsmasq is not set
  # CONFIG_PACKAGE_firewall is not set
  CONFIG_PACKAGE_horst=y
  CONFIG_PACKAGE_hostapd-common=y
  CONFIG_PACKAGE_iftop=y
  CONFIG_PACKAGE_ip=y
  CONFIG_PACKAGE_iw=y
  CONFIG_PACKAGE_iwinfo=y
  CONFIG_PACKAGE_kmod-ath=y
  CONFIG_PACKAGE_kmod-ath5k=y
  CONFIG_PACKAGE_kmod-batman-adv=y
  CONFIG_PACKAGE_kmod-bridge=y
  CONFIG_PACKAGE_kmod-cfg80211=y
  CONFIG_PACKAGE_kmod-crypto-aes=y
  CONFIG_PACKAGE_kmod-crypto-arc4=y
  CONFIG_PACKAGE_kmod-crypto-core=y
  CONFIG_PACKAGE_kmod-crypto-crc32c=y
  CONFIG_PACKAGE_kmod-crypto-hash=y
  # CONFIG_PACKAGE_kmod-lib-crc-ccitt is not set
  CONFIG_PACKAGE_kmod-lib-crc16=y
  CONFIG_PACKAGE_kmod-lib-crc32c=y
  CONFIG_PACKAGE_kmod-llc=y
  CONFIG_PACKAGE_kmod-mac80211=y
  # CONFIG_PACKAGE_kmod-ppp is not set
  CONFIG_PACKAGE_kmod-stp=y
  CONFIG_PACKAGE_libcurl=y
  CONFIG_PACKAGE_libelf1=y
  CONFIG_PACKAGE_libiwinfo=y
  CONFIG_PACKAGE_liblua=y
  CONFIG_PACKAGE_libncurses=y
  CONFIG_PACKAGE_libnetsnmp=y
  CONFIG_PACKAGE_libopenssl=y
  CONFIG_PACKAGE_libpcap=y
  CONFIG_PACKAGE_libpcre=y
  CONFIG_PACKAGE_libpolarssl=y
  CONFIG_PACKAGE_libpopt=y
  CONFIG_PACKAGE_libpthread=y
  CONFIG_PACKAGE_librt=y
  CONFIG_PACKAGE_lua=y
  CONFIG_PACKAGE_missnet-node=y
  # CONFIG_PACKAGE_odhcp6c is not set
  # CONFIG_PACKAGE_ppp is not set
  CONFIG_PACKAGE_procps=y
  CONFIG_PACKAGE_procps-free=y
  CONFIG_PACKAGE_procps-pgrep=y
  CONFIG_PACKAGE_procps-pkill=y
  CONFIG_PACKAGE_procps-pmap=y
  CONFIG_PACKAGE_procps-ps=y
  CONFIG_PACKAGE_procps-pwdx=y
  CONFIG_PACKAGE_procps-skill=y
  CONFIG_PACKAGE_procps-slabtop=y
  CONFIG_PACKAGE_procps-snice=y
  CONFIG_PACKAGE_procps-tload=y
  CONFIG_PACKAGE_procps-top=y
  CONFIG_PACKAGE_procps-vmstat=y
  CONFIG_PACKAGE_procps-w=y
  CONFIG_PACKAGE_procps-watch=y
  CONFIG_PACKAGE_rsync=y
  CONFIG_PACKAGE_snmpd=y
  CONFIG_PACKAGE_tcpdump=y
  CONFIG_PACKAGE_terminfo=y
  CONFIG_PACKAGE_traceroute6=y
  CONFIG_PACKAGE_wget=y
  CONFIG_PACKAGE_wireless-tools=y
  CONFIG_PACKAGE_wpad-mini=y
  CONFIG_PACKAGE_zlib=y
  # CONFIG_TARGET_ROOTFS_EXT4FS is not set
  # CONFIG_TARGET_ROOTFS_TARGZ is not set

Anything you are interested in that I left out, I'm happy to provide
on request.


-- 
Russell Senior, President
russell@personaltelco.net
