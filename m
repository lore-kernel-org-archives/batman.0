Return-Path: <jens@viisauksena.de>
From: jens <jens@viisauksena.de>
References: <98a77a75-ac8e-455a-6060-343b9020cd27@viisauksena.de>
 <2809895.eiDvevZ9tY@bentobox>
Message-ID: <946ed248-8900-a0e2-4f35-ff288b04e360@viisauksena.de>
Date: Wed, 25 Jan 2017 03:21:58 +0100
MIME-Version: 1.0
In-Reply-To: <2809895.eiDvevZ9tY@bentobox>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] limit of if per batman
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

On 24.01.2017 14:39, Sven Eckelmann wrote:
> There is no artificial limit added by batman-adv. But transmitting a lot of
> broadcasts over 255 virtual links sharing the same physical link
> might get interesting (independent of batman-adv).

this made me curious , and i modified your script a bit - turns out
after the 127. IF you add to batman-adv you get an Error -
all 510 gretap links was succesfully build ...
# ifconfig |grep gre| wc -l
515
# batctl if|sort|wc -l
127
the error is mainly
*Error - can't write to file
'/sys/class/net/gre128/batman_adv/mesh_iface': Cannot allocate memory

*removing one previous IF from batman, and adding the next work fine,
but than going over 127 is not possible.
like this
# batctl if del gre127
# batctl if add gre128
and then # batctl if add gre129 (or whatever other if) fails again

script and dmesg are like this , maybe you can explain what happened,
in case its important, this is still batman-adv-v14
thx
jens


# add one if per 3 seconds and give dmesg output
dmesg -w &
for i in `seq 1 255`; do
      ip link add gre$i type gretap local 192.168.99.1 remote
192.168.3.$i ttl 255 dev wg0
      ip link set up dev gre$i
      batctl if add gre$i
      ip link add grex$i type gretap local 192.168.99.1 remote
192.168.4.$i ttl 255 dev wg0
      ip link set up dev grex$i
      batctl if add grex$i
      echo -n $(uptime|cut -d"," -f4-) $(ifconfig wg0|grep TX\ p) $i
      sleep 3
done


|Load average: 0.01, 0.00, 0.00 TX packets 80872676 bytes 43983093228
(40.9 GiB) 126 Error - can't write to file
'/sys/class/net/gre127/batman_adv/mesh_iface': Cannot allocate memory
[113990.684849] ------------[ cut here ]------------ [113990.684861]
WARNING: CPU: 0 PID: 12430 at
/build/linux-lIgGMF/linux-4.8.11/mm/slab_common.c:861
kmalloc_slab+0x90/0xa0 [113990.684867] Modules linked in: dm_mod ip_gre
ip_tunnel gre xt_hashlimit wireguard(OE) ip6_udp_tunnel udp_tunnel
intel_rapl x86_pkg_temp_thermal coretemp crct10dif_pclmul evdev
crc32_pclmul pcspkr ghash_clmulni_intel batman_adv(OE) libcrc32c ip_tabl
es x_tables autofs4 ext4 crc16 jbd2 crc32c_generic fscrypto ecb mbcache
crc32c_intel aesni_intel xen_netfront xen_blkfront aes_x86_64
glue_helper lrw gf128mul ablk_helper cryptd [113990.684907] CPU: 0 PID:
12430 Comm: batctl Tainted: G W OE 4.8.0-2-amd64 #1 Debian 4.8.11-1
[113990.684914] 0000000000000200 0000000052b690a8 ffffffff813269f5
0000000000000000 [113990.684921] 0000000000000000 ffffffff8107c16e
0000000002080020 fffffffffffffc00 [113990.684929] ffffffffc017a804
fffffffffffffc00 ffffffffffffff80 fffffffffffffbf8 [113990.684936] Call
Trace: [113990.684942] [<ffffffff813269f5>] ? dump_stack+0x5c/0x77
[113990.684947] [<ffffffff8107c16e>] ? __warn+0xbe/0xe0 [113990.684955]
[<ffffffffc017a804>] ? batadv_orig_hash_add_if+0x94/0x140 [batman_adv]
[113990.684961] [<ffffffff811a7b10>] ? kmalloc_slab+0x90/0xa0
[113990.684966] [<ffffffff811e08c5>] ? __kmalloc+0x25/0x580
[113990.684971] [<ffffffff815ef9d7>] ? _raw_spin_lock_irqsave+0x17/0x39
[113990.684977] [<ffffffff81432c11>] ? _crng_backtrack_protect+0x31/0x70
[113990.684981] [<ffffffff811e0ebc>] ? kmem_cache_alloc_trace+0x9c/0x540
[113990.684986] [<ffffffff814340b7>] ? get_random_bytes+0xe7/0x1c0
[113990.684991] [<ffffffffc017a804>] ?
batadv_orig_hash_add_if+0x94/0x140 [batman_adv] [113990.684999]
[<ffffffffc01779ac>] ? batadv_hardif_enable_interface+0x1cc/0x2e0
[batman_adv] [113990.685007] [<ffffffffc017f2c2>] ?
batadv_store_mesh_iface+0xb2/0x150 [batman_adv] [113990.685013]
[<ffffffff8127fa98>] ? kernfs_fop_write+0x118/0x1a0 [113990.685018]
[<ffffffff81202303>] ? vfs_write+0xb3/0x1a0 [113990.685022]
[<ffffffff812036e2>] ? SyS_write+0x52/0xc0 [113990.685039]
[<ffffffff815efa76>] ? system_call_fast_compare_end+0xc/0x96
[113990.685044] ---[ end trace 3e82ace6f98e8470 ]--- [113990.684849]
------------[ cut here ]------------ [113990.684861] WARNING: CPU: 0
PID: 12430 at /build/linux-lIgGMF/linux-4.8.11/mm/slab_common.c:861
kmalloc_slab+0x90/0xa0 [113990.684867] Modules linked in: dm_mod ip_gre
ip_tunnel gre xt_hashlimit wireguard(OE) ip6_udp_tunnel udp_tunnel
intel_rapl x86_pkg_temp_thermal coretemp crct10dif_pclmul evdev
crc32_pclmul pcspkr ghash_clmulni_intel batman_adv(OE) libcrc32c ip_tabl
es x_tables autofs4 ext4 crc16 jbd2 crc32c_generic fscrypto ecb mbcache
crc32c_intel aesni_intel xen_netfront xen_blkfront aes_x86_64
glue_helper lrw gf128mul ablk_helper cryptd [113990.684907] CPU: 0 PID:
12430 Comm: batctl Tainted: G W OE 4.8.0-2-amd64 #1 Debian 4.8.11-1
[113990.684914] 0000000000000200 0000000052b690a8 ffffffff813269f5
0000000000000000 [113990.684921] 0000000000000000 ffffffff8107c16e
0000000002080020 fffffffffffffc00 [113990.684929] ffffffffc017a804
fffffffffffffc00 ffffffffffffff80 fffffffffffffbf8 [113990.684936] Call
Trace: [113990.684942] [<ffffffff813269f5>] ? dump_stack+0x5c/0x77
[113990.684947] [<ffffffff8107c16e>] ? __warn+0xbe/0xe0 [113990.684955]
[<ffffffffc017a804>] ? batadv_orig_hash_add_if+0x94/0x140 [batman_adv]
[113990.684961] [<ffffffff811a7b10>] ? kmalloc_slab+0x90/0xa0
[113990.684966] [<ffffffff811e08c5>] ? __kmalloc+0x25/0x580
[113990.684971] [<ffffffff815ef9d7>] ? _raw_spin_lock_irqsave+0x17/0x39
[113990.684977] [<ffffffff81432c11>] ? _crng_backtrack_protect+0x31/0x70
[113990.684981] [<ffffffff811e0ebc>] ? kmem_cache_alloc_trace+0x9c/0x540
[113990.684986] [<ffffffff814340b7>] ? get_random_bytes+0xe7/0x1c0
[113990.684991] [<ffffffffc017a804>] ?
batadv_orig_hash_add_if+0x94/0x140 [batman_adv] [113990.684999]
[<ffffffffc01779ac>] ? batadv_hardif_enable_interface+0x1cc/0x2e0
[batman_adv] [113990.685007] [<ffffffffc017f2c2>] ?
batadv_store_mesh_iface+0xb2/0x150 [batman_adv] [113990.685013]
[<ffffffff8127fa98>] ? kernfs_fop_write+0x118/0x1a0 [113990.685018]
[<ffffffff81202303>] ? vfs_write+0xb3/0x1a0 [113990.685022]
[<ffffffff812036e2>] ? SyS_write+0x52/0xc0 [113990.685039]
[<ffffffff815efa76>] ? system_call_fast_compare_end+0xc/0x96
[113990.685044] ---[ end trace 3e82ace6f98e8470 ]--- Error - can't write
to file '/sys/class/net/gre127/batman_adv/mesh_iface': Cannot allocate
memory load average: 0.01, 0.00, 0.00 TX packets 80874265 bytes
43983761422 (40.9 GiB) 127 Error - can't write to file
'/sys/class/net/gre128/batman_adv/mesh_iface': Cannot allocate memory|




-- 
make the world nicer, please use PGP encryption

