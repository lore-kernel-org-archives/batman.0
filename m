Return-Path: <nbd@openwrt.org>
Message-ID: <52F60CB0.8010101@openwrt.org>
Date: Sat, 08 Feb 2014 11:53:36 +0100
From: Felix Fietkau <nbd@openwrt.org>
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
 <52F59F90.7000204@wirelesspt.net>
In-Reply-To: <52F59F90.7000204@wirelesspt.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] batman-adv: memory leak?
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
To: cmsv@wirelesspt.net, Russell Senior <russell@personaltelco.net>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On 2014-02-08 04:08, cmsv wrote:
> [  239.410000] CPU 0 Unable to handle kernel paging request at virtual
> address 0000000c, epc == 80ea7914, ra == 80ea7910
> [  239.420000] Oops[#1]:
> [  239.420000] Cpu 0
> [  239.420000] $ 0   : 00000000 00000001 00000000 00000000
> [  239.420000] $ 4   : 81b12380 80f7fb00 00000000 00000000
> [  239.420000] $ 8   : 00000037 00000000 00000000 00000000
> [  239.420000] $12   : 00000000 0000015f 80e82540 00000000
> [  239.420000] $16   : 81adbc00 00000000 81b12380 80f3e802
> [  239.420000] $20   : 80f7fb00 00000000 00000189 00000000
> [  239.420000] $24   : 00000002 80e365f0
> [  239.420000] $28   : 80fe6000 80fe7ae8 00000043 80ea7910
> [  239.420000] Hi    : 000001d5
> [  239.420000] Lo    : 0011e189
> [  239.420000] epc   : 80ea7914 0x80ea7914
> [  239.420000]     Tainted: G           O
> [  239.420000] ra    : 80ea7910 0x80ea7910
> [  239.420000] Status: 1000f403    KERNEL EXL IE
> [  239.420000] Cause : 00800008
> [  239.420000] BadVA : 0000000c
> [  239.420000] PrId  : 00019374 (MIPS 24Kc)
> [  239.420000] Modules linked in: ath79_wdt batman_adv(O) nf_nat_irc
> nf_conntrack_irc nf_nat_ftp nf_conntrack_ftp ipt_MASQUERADE iptable_nat
> nf_nat xt_conntrack xt_CT xt_NOTRACK iptable
> 
> 
> _raw xt_state nf_conntrack_ipv4 nf_defrag_ipv4 nf_conntrack ipt_REJECT
> xt_TCPMSS ipt_LOG xt_comment xt_multiport xt_mac xt_limit iptable_mangle
> iptable_filter ip_tables xt_tcpudp x_tabl
> 
> 
> es ath9k(O) ath9k_common(O) ath9k_hw(O) ath(O) mac80211(O) libcrc32c
> crc16 cfg80211(O) compat(O) arc4 aes_generic crc32c crypto_hash
> crypto_algapi gpio_button_hotplug(O)
> [  239.420000] Process udhcpc (pid: 1267, threadinfo=80fe6000,
> task=81af8850, tls=77929440)
> [  239.420000] Stack : 00000000 00000000 00000000 00000000 0000002a
> 81adbc00 00000000 81adbc00
> [  239.420000]         81b12000 80f3e802 81b12380 00000000 00000189
> 80eb1fbc 81b12000 00000000
> [  239.420000]         80e8bd00 80eb86c0 00000000 00000000 00000000
> 801e98ac 81adbc00 00000000
> [  239.420000]         81b12000 00000000 80e8bd00 80eb86c0 00000000
> 801ec874 00000000 80dae000
> [  239.420000]         00000000 00000014 80fb7ca8 0200bc00 00000001
> 00000001 802e0000 81adbc00
> [  239.420000]         ...
> [  239.420000] Call Trace:[<80eb1fbc>] 0x80eb1fbc
> [  239.420000] [<801e98ac>] 0x801e98ac
> [  239.420000] [<801ec874>] 0x801ec874
[...]
Just a quick note about logs like this: They're completely worthless
unless you enable CONFIG_KERNEL_KALLSYMS in your .config. Without that
option, the kernel does not resolve function names, and the addresses
shown with a custom build usually do not match the addresses of other
builds.

- Felix
