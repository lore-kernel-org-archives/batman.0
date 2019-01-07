Return-Path: <linus.luessing@c0d3.blue>
Date: Mon, 7 Jan 2019 19:49:06 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20190107184906.GC5399@otheros>
References: <20181207135846.6152-1-sven@narfation.org>
 <20181207135846.6152-3-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181207135846.6152-3-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [RFC v3 02/19] batman-adv: Prepare framework for
 mesh genl config
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

On Fri, Dec 07, 2018 at 02:58:29PM +0100, Sven Eckelmann wrote:
> diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
> index b20801a3..d89761f8 100644
> --- a/net/batman-adv/netlink.c
> +++ b/net/batman-adv/netlink.c
[...]
> -static int
> -batadv_netlink_mesh_info_put(struct sk_buff *msg, struct net_device *soft_iface)
> +static int batadv_netlink_mesh_put(struct sk_buff *msg,
> +				   struct batadv_priv *bat_priv,
> +				   enum batadv_nl_commands cmd,
> +				   u32 portid, u32 seq, int flags)
>  {
> -	struct batadv_priv *bat_priv = netdev_priv(soft_iface);
> +	struct net_device *soft_iface = bat_priv->soft_iface;
>  	struct batadv_hard_iface *primary_if = NULL;
>  	struct net_device *hard_iface;
> -	int ret = -ENOBUFS;
> +	void *hdr;
> +
> +	hdr = genlmsg_put(msg, portid, seq, &batadv_netlink_family, flags, cmd);
> +	if (!hdr)
> +		return -ENOBUFS;
>  
>  	if (nla_put_string(msg, BATADV_ATTR_VERSION, BATADV_SOURCE_VERSION) ||
>  	    nla_put_string(msg, BATADV_ATTR_ALGO_NAME,
> @@ -162,16 +173,16 @@ batadv_netlink_mesh_info_put(struct sk_buff *msg, struct net_device *soft_iface)
>  		    soft_iface->dev_addr) ||
>  	    nla_put_u8(msg, BATADV_ATTR_TT_TTVN,
>  		       (u8)atomic_read(&bat_priv->tt.vn)))
> -		goto out;
> +		goto nla_put_failure;
>  
>  #ifdef CONFIG_BATMAN_ADV_BLA
>  	if (nla_put_u16(msg, BATADV_ATTR_BLA_CRC,
>  			ntohs(bat_priv->bla.claim_dest.group)))
> -		goto out;
> +		goto nla_put_failure;
>  #endif
>  
>  	if (batadv_mcast_mesh_info_put(msg, bat_priv))
> -		goto out;
> +		goto nla_put_failure;
>  
>  	primary_if = batadv_primary_if_get_selected(bat_priv);
>  	if (primary_if && primary_if->if_status == BATADV_IF_ACTIVE) {
> @@ -183,77 +194,94 @@ batadv_netlink_mesh_info_put(struct sk_buff *msg, struct net_device *soft_iface)
>  				   hard_iface->name) ||
>  		    nla_put(msg, BATADV_ATTR_HARD_ADDRESS, ETH_ALEN,
>  			    hard_iface->dev_addr))
> -			goto out;
> +			goto nla_put_failure;
>  	}
>  
> -	ret = 0;
> +	batadv_hardif_put(primary_if);

I seem to be able to trigger a null pointer dereference for this
batadv_hardif_put() call here. With the following steps I end up
with a primary_if == NULL:

$ batctl if add 1

root@Linus-Debian:~# batctl o
Error - interface bat0 is not present or not a batman-adv interface
root@Linus-Debian:~# batctl if add 1
Error - interface does not exist: 1
root@Linus-Debian:~# batctl o
Killed
root@Linus-Debian:~#
root@Linus-Debian:~#
root@Linus-Debian:~# batctl o

>  
> - out:
> +	genlmsg_end(msg, hdr);
> +	return 0;
> +
> +nla_put_failure:
>  	if (primary_if)
>  		batadv_hardif_put(primary_if);
>  
> -	return ret;
> +	genlmsg_cancel(msg, hdr);
> +	return -EMSGSIZE;
>  }

The panic looks like this then:

[ 2309.363754] batman_adv: bat0: Interface deactivated: ens3
[ 2309.364709] batman_adv: bat0: Removing interface: ens3
[ 2309.365662] batman_adv: bat0: Interface deactivated: ens5
[ 2309.366624] batman_adv: bat0: Removing interface: ens5
[ 2310.402540] batman_adv: B.A.T.M.A.N. advanced 2018.4-38-g25676ce7-dirty (compatibility version 15) loaded
[ 2321.727530] BUG: unable to handle kernel NULL pointer dereference at 0000000000000028
[ 2321.728869] IP: [<ffffffffc091df19>] batadv_netlink_mesh_put.constprop.13+0x459/0x630 [batman_adv]
[ 2321.730060] PGD 0 [ 2321.730311]
[ 2321.730533] Oops: 0002 [#1] SMP 
[ 2321.730952] Modules linked in: batman_adv(O) cfg80211 rfkill evdev joydev serio_raw pcspkr button nfsd bridge auth_rpcgss oid_registry stp nfs_acl lockd llc grace sunrpc crc16 ip_tables x_tables autofs4 btrfs raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c crc32c_generic raid1 raid0 multipath linear md_mod dm_mirror dm_region_hash dm_log dm_mod 9pnet_rdma rdma_cm configfs iw_cm ib_cm ib_core 9p fscache 8139too ata_generic 9pnet_virtio 9pnet psmouse floppy virtio_pci virtio_ring virtio 8139cp mii ata_piix e1000 i2c_piix4 libata scsi_mod [last unloaded: batman_adv] 
[ 2321.731472] CPU: 0 PID: 2948 Comm: batctl Tainted: G           O    4.9.0-7-amd64 #1 Debian 4.9.110-3+deb9u2
[ 2321.731472] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[ 2321.731472] task: ffff9fa5d9cde100 task.stack: ffffc0d7805e8000
[ 2321.731472] RIP: 0010:[<ffffffffc091df19>]  [<ffffffffc091df19>] batadv_netlink_mesh_put.constprop.13+0x459/0x630 [batman_adv]
[ 2321.731472] RSP: 0018:ffffc0d7805ebae0  EFLAGS: 00010282
[ 2321.731472] RAX: 0000000000000000 RBX: ffff9fa5dcf4c800 RCX: 00000000000003e8
[ 2321.731472] RDX: ffffffffc091a010 RSI: ffffc0d7805ebaec RDI: ffff9fa5db9c80f8
[ 2321.731472] RBP: ffff9fa5d9d538c0 R08: 00000000000003e8 R09: 0000000000000004
[ 2321.731472] R10: ffff9fa5db9c80fc R11: 0079747269642d37 R12: ffff9fa5db9c8014
[ 2321.731472] R13: 0000000000000028 R14: 0000000000000000 R15: ffffffff8bedbe00
[ 2321.731472] FS:  00007fa18cf5a740(0000) GS:ffff9fa5de800000(0000) knlGS:0000000000000000
[ 2321.731472] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2321.731472] CR2: 0000000000000028 CR3: 0000000018d9f000 CR4: 00000000000006f0
[ 2321.731472] Stack:
[ 2321.731472]  ffffffff8b6f6cb6 000003e88b6f5d3e 7c37bd74f749c6fc ffffc0d7805ebb90
[ 2321.731472]  ffff9fa5dcf4c800 ffff9fa5d9d538c0 ffff9fa5dfa6e500 ffff9fa5db925c00
[ 2321.731472]  ffffffff8bedbe00 ffffffffc091e138 ffffffffc092d180 ffffffffc092d180
[ 2321.731472] Call Trace:
[ 2321.731472]  [<ffffffff8b6f6cb6>] ? __alloc_skb+0x96/0x1e0
[ 2321.731472]  [<ffffffffc091e138>] ? batadv_netlink_get_mesh+0x48/0xa0 [batman_adv]
[ 2321.731472]  [<ffffffff8b7445f5>] ? genl_family_rcv_msg+0x1c5/0x360
[ 2321.731472]  [<ffffffff8b6f5d3e>] ? __kmalloc_reserve.isra.35+0x2e/0x80
[ 2321.731472]  [<ffffffff8b3e4906>] ? kmem_cache_alloc_node_trace+0x156/0x5a0
[ 2321.731472]  [<ffffffff8b744790>] ? genl_family_rcv_msg+0x360/0x360
[ 2321.731472]  [<ffffffff8b744812>] ? genl_rcv_msg+0x82/0xc0
[ 2321.731472]  [<ffffffff8b743d94>] ? netlink_rcv_skb+0xa4/0xc0
[ 2321.731472]  [<ffffffff8b744414>] ? genl_rcv+0x24/0x40
[ 2321.731472]  [<ffffffff8b74376a>] ? netlink_unicast+0x18a/0x230
[ 2321.731472]  [<ffffffff8b743b67>] ? netlink_sendmsg+0x357/0x3b0
[ 2321.731472]  [<ffffffff8b6ee946>] ? sock_sendmsg+0x36/0x40
[ 2321.731472]  [<ffffffff8b6ef3d8>] ? ___sys_sendmsg+0x2c8/0x2e0
[ 2321.731472]  [<ffffffff8b3fe078>] ? mem_cgroup_commit_charge+0x78/0x4b0
[ 2321.731472]  [<ffffffff8b3b8a6e>] ? handle_mm_fault+0xe7e/0x1280
[ 2321.731472]  [<ffffffff8b6ed905>] ? move_addr_to_user+0xb5/0xd0
[ 2321.731472]  [<ffffffff8b6efce1>] ? __sys_sendmsg+0x51/0x90
[ 2321.731472]  [<ffffffff8b203b7d>] ? do_syscall_64+0x8d/0xf0
[ 2321.731472]  [<ffffffff8b814c4e>] ? entry_SYSCALL_64_after_swapgs+0x58/0xc6
[ 2321.731472] Code: 00 00 be 39 00 00 00 48 89 df 89 44 24 0c e8 3f 03 c4 ca 85 c0 75 48 48 c7 c2 10 a0 91 c0 49 83 c5 28 48 85 d2 0f 84 ae 01 00 00 <f0> 41 83 6d 00 01 75 10 4c 89 ef 89 44 24 04 e8 e3 c0 ff ff 8b
[ 2321.731472] RIP  [<ffffffffc091df19>] batadv_netlink_mesh_put.constprop.13+0x459/0x630 [batman_adv]
[ 2321.731472]  RSP <ffffc0d7805ebae0>
[ 2321.731472] CR2: 0000000000000028
[ 2321.770447] ---[ end trace cdc14a8e37e47f7e ]---


Next to a missing bailout for a primary_if == NULL, it's also odd
that this "batctl if add" does seem to change something in the
kernel even though it returns an error. I haven't looked into why
that happens yet, though.

PS: In these tests I had also commented out all items in the *_attrs[] arrays
in sysfs.c to make sure that I'm using netlink for everything.
