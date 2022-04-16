Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: Kernel crash when using batman-adv 2022.0 over VXLAN
Date: Sat, 16 Apr 2022 12:08:54 +0200
Message-ID: <3014612.pz5OENx0Be@sven-l14>
In-Reply-To: <3a4465b0-ddf6-151f-0082-0d4533a7eff0@kaechele.ca>
References: <3a4465b0-ddf6-151f-0082-0d4533a7eff0@kaechele.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2030628.CM80vvO7ju";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: Felix Kaechele <felix@kaechele.ca>
Cc: b.a.t.m.a.n@lists.open-mesh.org

 
--nextPart2030628.CM80vvO7ju
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Felix Kaechele <felix@kaechele.ca>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: Kernel crash when using batman-adv 2022.0 over VXLAN
Date: Sat, 16 Apr 2022 12:08:54 +0200
Message-ID: <3014612.pz5OENx0Be@sven-l14>
In-Reply-To: <3a4465b0-ddf6-151f-0082-0d4533a7eff0@kaechele.ca>
References: <3a4465b0-ddf6-151f-0082-0d4533a7eff0@kaechele.ca>

On Saturday, 16 April 2022 02:23:59 CEST Felix Kaechele wrote:
> Hi there,
> 
> I am seeing odd kernel crashes when using batman-adv over VXLAN.
> This is in a Freifunk environment on our VPN gateway side where clients 
> connect using L2TPv3 tunnels and the gateways are interconnected using 
> VXLAN.
> 
> The setup is as follows on both ends:
> 
> - Both machines are Hetzner Cloud VMs (CX11)
> - OS: Fedora 36 (Pre-release) / Kernel 5.17.2-300.fc36.x86_64

So it doesn't crash in batman-adv but the skbuff code complains about it when 
it went through the bridge. The code which crashes is:

    void *__pskb_pull_tail(struct sk_buff *skb, int delta)
    {
    	/* If skb has not enough free space at tail, get new one
    	 * plus 128 bytes for future expansions. If we have enough
    	 * room at tail, reallocate without expansion only if skb is cloned.
    	 */
    	int i, k, eat = (skb->tail + delta) - skb->end;
    
    	if (eat > 0 || skb_cloned(skb)) {
    		if (pskb_expand_head(skb, 0, eat > 0 ? eat + 128 : 0,
    				     GFP_ATOMIC))
    			return NULL;
    	}
    
    	BUG_ON(skb_copy_bits(skb, skb_headlen(skb),
    			     skb_tail_pointer(skb), delta));


So it seems like skb_copy_bits fails because it is unable to copy (delta) 
bytes from the skb at the start of the header to tail. Afaik, this can only 
happen when skb_headlen(skb) + delta is larger than the complete length of the 
skb. Or when the same thing is true for any of its fragments.

Question is now: what is calling the function with which parameter. So the 
first step was to try to decode the stacktrace (more or less well) via the
./scripts/decode_stacktrace.sh and the vmlinux from
https://kojipkgs.fedoraproject.org//packages/kernel/5.17.2/300.fc36/x86_64/kernel-debug-debuginfo-5.17.2-300.fc36.x86_64.rpm

    $ ~/linux-5.17.2/scripts/decode_stacktrace.sh  vmlinux < ~/decoded 
    [  240.816265] ------------[ cut here ]------------
    [  240.819307] kernel BUG at net/core/skbuff.c:2247!
    [  240.822038] invalid opcode: 0000 [#1] PREEMPT SMP PTI
    [  240.824163] CPU: 0 PID: 13 Comm: ksoftirqd/0 Kdump: loaded Not tainted 5.17.2-300.fc36.x86_64 #1
    [  240.827627] Hardware name: Hetzner vServer, BIOS 20171111 11/11/2017
    [  240.829406] RIP: 0010:__pskb_pull_tail (./include/linux/mm.h:717 ./include/linux/mm.h:723 ./include/linux/mm.h:1198 ./include/linux/mm.h:1237 ./include/linux/skbuff.h:3188 ./include/linux/skbuff.h:3200 net/core/skbuff.c:2327) 
    [ 240.830860] Code: 8b b4 24 bc 00 00 00 4d 8b 84 24 c0 00 00 00 49 8d 14 30 48 8b 7a 08 e9 2d fe ff ff 48 c7 c6 e8 bc 5e 8b e8 e2 30 83 ff 0f 0b <0f> 0b 29 c2 48 89 7c 24 08 42 8d 34 3a e8 3e fc ff ff 48 8b 7c 24
    All code
    ========
       0:   8b b4 24 bc 00 00 00    mov    0xbc(%rsp),%esi
       7:   4d 8b 84 24 c0 00 00    mov    0xc0(%r12),%r8
       e:   00 
       f:   49 8d 14 30             lea    (%r8,%rsi,1),%rdx
      13:   48 8b 7a 08             mov    0x8(%rdx),%rdi
      17:   e9 2d fe ff ff          jmpq   0xfffffffffffffe49
      1c:   48 c7 c6 e8 bc 5e 8b    mov    $0xffffffff8b5ebce8,%rsi
      23:   e8 e2 30 83 ff          callq  0xffffffffff83310a
      28:   0f 0b                   ud2    
      2a:*  0f 0b                   ud2             <-- trapping instruction
      2c:   29 c2                   sub    %eax,%edx
      2e:   48 89 7c 24 08          mov    %rdi,0x8(%rsp)
      33:   42 8d 34 3a             lea    (%rdx,%r15,1),%esi
      37:   e8 3e fc ff ff          callq  0xfffffffffffffc7a
      3c:   48                      rex.W
      3d:   8b                      .byte 0x8b
      3e:   7c 24                   jl     0x64
    
    Code starting with the faulting instruction
    ===========================================
       0:   0f 0b                   ud2    
       2:   29 c2                   sub    %eax,%edx
       4:   48 89 7c 24 08          mov    %rdi,0x8(%rsp)
       9:   42 8d 34 3a             lea    (%rdx,%r15,1),%esi
       d:   e8 3e fc ff ff          callq  0xfffffffffffffc50
      12:   48                      rex.W
      13:   8b                      .byte 0x8b
      14:   7c 24                   jl     0x3a
    [  240.837601] RSP: 0018:fffface380073830 EFLAGS: 00010282
    [  240.839764] RAX: 00000000fffffff2 RBX: ffff921d9f863b00 RCX: 0000000000000001
    [  240.842436] RDX: 0000000000000001 RSI: ffff921d8f145640 RDI: 0000000000000380
    [  240.844451] RBP: fffface380073868 R08: ffff921d84dd9cac R09: 0000000000000022
    [  240.846478] R10: 0000000000000001 R11: 00000000000002bf R12: ffff921d9f863b00
    [  240.848510] R13: 00000000000002eb R14: 0000000000000000 R15: 0000000000000001
    [  240.850622] FS:  0000000000000000(0000) GS:ffff921dfcc00000(0000) knlGS:0000000000000000
    [  240.852960] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    [  240.854570] CR2: 000056045b049188 CR3: 0000000004dd6004 CR4: 00000000007706f0
    [  240.856238] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
    [  240.857883] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
    [  240.859503] PKRU: 55555554
    [  240.861767] Call Trace:
    [  240.863187]  <TASK>
    [  240.864458] validate_xmit_skb (./include/linux/skbuff.h:3465 net/core/dev.c:3563) 
    [  240.866141] validate_xmit_skb_list (net/core/dev.c:3605) 
    [  240.868019] sch_direct_xmit (net/sched/sch_generic.c:330) 
    [  240.869946] __dev_queue_xmit (./include/net/pkt_sched.h:131 net/core/dev.c:3709 net/core/dev.c:4081) 
    [  240.871507] ? packet_rcv (net/packet/af_packet.c:2127) 
    [  240.872908] ? __br_forward (./include/linux/rcupdate.h:273 ./include/linux/rcupdate.h:727 ./include/linux/netfilter.h:264 ./include/linux/netfilter.h:305 net/bridge/br_forward.c:115) bridge
    [  240.874740] br_dev_queue_push_xmit (net/bridge/br_forward.c:53) bridge
    [  240.876785] br_dev_xmit (net/bridge/br_device.c:108) bridge
    [  240.878537] ? dev_queue_xmit_nit (./include/linux/skbuff.h:1471 ./include/linux/skbuff.h:1510 ./include/linux/skbuff.h:2895 net/core/dev.c:2242) 
    [  240.880264] dev_hard_start_xmit (./include/linux/netdevice.h:4684 ./include/linux/netdevice.h:4699 net/core/dev.c:3473 net/core/dev.c:3489) 
    [  240.881885] __dev_queue_xmit (net/core/dev.c:3700 net/core/dev.c:4081) 
    [  240.883393] ? nf_ct_deliver_cached_events (net/netfilter/nf_conntrack_ecache.c:234) nf_conntrack
    [  240.885479] ? __build_skb (net/core/skbuff.c:239) 
    [  240.886950] ? kmem_cache_alloc (mm/slub.c:3214 mm/slub.c:3238 mm/slub.c:3243) 
    [  240.888709] batadv_send_skb_packet (net/batman-adv/send.c:109) batman_adv
    [  240.890611] batadv_send_unicast_skb (net/batman-adv/send.c:150) batman_adv
    [  240.892551] batadv_frag_send_packet (net/batman-adv/fragmentation.c:424 net/batman-adv/fragmentation.c:508) batman_adv
    [  240.894473] batadv_send_skb_to_orig (net/batman-adv/send.c:197) batman_adv
    [  240.896484] batadv_route_unicast_packet (net/batman-adv/routing.c:706) batman_adv
    [  240.898417] batadv_recv_unicast_packet (net/batman-adv/routing.c:1020) batman_adv
    [  240.900277] batadv_batman_skb_recv (net/batman-adv/hard-interface.h:92 net/batman-adv/main.c:486) batman_adv
    [  240.902309] __netif_receive_skb_list_core (net/core/dev.c:5397 net/core/dev.c:5383 net/core/dev.c:5442) 
    [  240.904458] netif_receive_skb_list_internal (./include/linux/sched/mm.h:330 net/core/dev.c:5489 net/core/dev.c:5585) 
    [  240.906350] napi_complete_done (./include/linux/list.h:37 ./include/net/gro.h:426 ./include/net/gro.h:421 net/core/dev.c:5932) 
    [  240.908177] gro_cell_poll (net/core/gro_cells.c:54) 
    [  240.909499] __napi_poll+0x2b/0x160 
    [  240.910763] net_rx_action (net/core/dev.c:6538) 
    [  240.912082] __do_softirq (kernel/softirq.c:560) 
    [  240.913511] ? smpboot_register_percpu_thread (kernel/smpboot.c:107) 
    [  240.915107] run_ksoftirqd (kernel/softirq.c:916) 
    [  240.916346] smpboot_thread_fn (kernel/smpboot.c:144 (discriminator 3)) 
    [  240.917643] kthread (kernel/kthread.c:376) 
    [  240.919179] ? kthread_complete_and_exit (kernel/kthread.c:332) 
    [  240.921504] ret_from_fork (arch/x86/entry/entry_64.S:301) 
    [  240.923424]  </TASK>
    [  240.924914] Modules linked in: tun vxlan ip_gre ip_tunnel gre intel_rapl_msr intel_rapl_common isst_if_common nfit libnvdimm snd_pcm nft_nat snd_timer nft_masq snd virtio_net nft_meta_bridge nft_ct nft_chain_nat nf_nat bochs nf_conntrack soundcore joydev nf_defrag_ipv6 nf_defrag_ipv4 drm_vram_helper net_failover pcspkr drm_ttm_helper virtio_balloon ttm nf_tables failover i2c_piix4 nfnetlink l2tp_eth l2tp_netlink l2tp_core ip6_udp_tunnel udp_tunnel tcp_westwood batman_adv cfg80211 vfat fat bridge stp llc rfkill fuse crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel serio_raw virtio_console virtio_scsi ata_generic qemu_fw_cfg pata_acpi


As we can see, the __pskb_pull_tail comes from __skb_linearize. And its done 
using skb->data_len. According to our previous investigation for the non-
frag_list check, this would mean that
skb_headlen(skb) + skb->data_len > skb->len. And the definition of skb_headlen 
is skb->len - skb->data_len. So it can be transformed to:

     skb->len - skb->data_len + skb->data_len > skb->len

or

     skb->len > skb->len

Of course, this contradicts itself. So we have to assume that it either failed 
on the fragments or data_len changed - which I don't think that it does this 
in pskb_expand_head. But maybe someone can correct me.

But we can say that skb_needs_linearize in  net/core/dev.c:3562 returns true 
for some reason. batman-adv should not create any skb_fragments but will 
happily forward it to skb_split to create two skbs (and thus one batman-adv 
fragment packet might actually contain the skb fragments which were coming 
from the outside). So linearization by the dev_xmit code would be required 
when:

* skb is non linear (skb->data_len != 0)
* AND either:
  - skb has a skb fraglist (not batman-adv fraglist) && underlying interface 
    doesn't support NETIF_F_FRAGLIST
    (afaik, this can happen with skb_gro_receive but isn't handled by 
     skb_split)
  - skb has frags but underlying interface doesn't support support NETIF_F_SG

I am not sure what was used to receive the packet and what was then used to 
outgoing interface. But it seems like the receiving interface created either 
an skb with fraglist + the outgoing interface doesn't support it. Or the 
receiving interface created skb frags but the outgoing interface doesn't 
support scatter gather.

Still doesn't explain 100% why the skb_copy_bits fails. If you want then you 
can try to add a skb_linearize(skb) to the start of batadv_batman_skb_recv 
(directly after the variable declarations):

	/* keep skb linear */
	if (skb_linearize(skb) < 0)
		goto err_out;

to check if batman-adv is (indirectly) forwarding the problem with the skb or 
really introducing it (by incorrectly creating skb fragments somewhere). If 
this solves it, please remove the change and test if it also helps to just get 
rid of the fraglist:

	if (skb_has_frag_list(skb) && __skb_linearize(skb))
		goto err_out;

And if this really helps, please move this code code to 
batadv_frag_send_packet. This should look like this

    diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
    index 0899a729..5fc07263 100644
    --- a/net/batman-adv/fragmentation.c
    +++ b/net/batman-adv/fragmentation.c
    @@ -475,6 +475,15 @@ int batadv_frag_send_packet(struct sk_buff *skb,
     		goto free_skb;
     	}
     
    +	/* GRO might have added fragments to the fragment list instead of
    +	 * frags[]. But this is not handled by skb_split and must be
    +	 * linearized before it is given to it
    +	 */
    +	if (skb_has_frag_list(skb) && __skb_linearize(skb)) {
    +		ret = -ENOMEM;
    +		goto free_skb;
    +	}
    +
     	/* Create one header to be copied to all fragments */
     	frag_header.packet_type = BATADV_UNICAST_FRAG;
     	frag_header.version = BATADV_COMPAT_VERSION;


Thanks for the report and good luck with the testing - and I hope you find 
better easter eggs this year than this bug ;)

Kind regards,
	Sven
--nextPart2030628.CM80vvO7ju
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmJalbYACgkQXYcKB8Em
e0YVuxAAhymhMpf0wMz4aPzO1XKHzW31LkN98d5FwiUgyihxK2xQ5Ct0IdNdpdy2
9M0zl12wlV5p+ALEEd4ZF9PhY5swD9kIHYSBHutWe6bCUHlzJjXHowRqkNbkCnPW
/iIhlwNJAInkjcCHDSYcA7Pdtrmqn+IABqpoicZs75ig8fQTBglx1IyxuU5UPj9/
1sqRg6PLU3Lg72uhY6ZkxIb+o/qD91s4T0vVsRusQvehxVaS8FLiIKTyY3I1qATk
jKFWqxpK2mqokV1Xen6fyaJZhf2d0p+t+uBpR1bt99m99xqRlYaYsdIYKbACXr2s
hLSCOASIpZfS1aGTSkKS41w5FbhR0zTkMx2V+Owqzwuy0lNDKeYiJ7qhHdKCQpXs
7v6Iq48i8sf9CXMsmxYB/2h7QpjoDs9W4fDNBQpSYZvmJeyTCm2nQLQ0BOaW66tK
49z5LYwi5GIUty/ukOPQ42xPNQKNyla86NaaZkUS+y6Ol5Oa3rKXp+segIKESyrC
a6felM1vljuvWcLxfASvSvmtkMfqewD8wwM7xMSD+s2imTdnLPclmhly9iVCP8MB
qsW6sNrlRoJdpb7xjkGZWBvxfFCKt4it7m2QstGeE/5OoRwTscmybi8un9ZYa8ww
TK0L6MKhs/g6szEgJ0zM4BScq4SndldoKc7CeA4EPAHt4AE2OS8=
=kXnU
-----END PGP SIGNATURE-----

--nextPart2030628.CM80vvO7ju--


