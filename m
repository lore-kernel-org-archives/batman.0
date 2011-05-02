Return-Path: <linus.luessing@web.de>
Date: Mon, 2 May 2011 19:16:45 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20110502171645.GB12500@Sellars>
References: <1304182620-12637-2-git-send-email-sven@narfation.org>
	<1304196854-28141-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1304196854-28141-1-git-send-email-sven@narfation.org>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 2/3] batman-adv: Remove unnecessary
 hardif_list_lock
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Looks quite good and seems to make sense to avoid the
double-locking. Tested it here and together with patch 1/3 fixes
the initial issue, too.

Just one minor thing:
----
[58518.225154] batman_adv: bat0: The MTU of interface eth1 is too
small (1500) to handle the transport of batman-adv packets.
Packets going over this interface will be fragmented on layer2
which could impact the performance. Setting the MTU to 1527 would
solve the problem.
[58518.278111] RTNL: assertion failed at
/home/mesh-node/incoming/batman-adv-git-builddir/hard-interface.c
(136)
[58518.293167] Pid: 6366, comm: bash Not tainted 2.6.38+ #4
[58518.299142] Call Trace:
[58518.300953]  [<f8cb91f3>] primary_if_select+0x2f/0x9f
[batman_adv]
[58518.447844]  [<f8cb8e9c>] ? rcu_read_unlock+0x1c/0x1e
[batman_adv]
[58518.452572]  [<f8cb9146>] ? primary_if_get_selected+0x6a/0x71
[batman_adv]
[58518.455759]  [<f8cb92c6>] hardif_activate_interface+0x63/0x91
[batman_adv]
[58518.459168]  [<f8cb98e4>] hardif_enable_interface+0x1cc/0x21e
[batman_adv]
[58518.462481]  [<f8cb7bca>] store_mesh_iface+0xed/0x113
[batman_adv]
[58518.465564]  [<f8cb7add>] ? store_aggregated_ogms+0x28/0x28
[batman_adv]
[58518.468714]  [<c11e1121>] kobj_attr_store+0x1a/0x22
[58518.472277]  [<c11481dc>] sysfs_write_file+0xbc/0xe7
[58518.613128]  [<c1148120>] ? sysfs_open_file+0x205/0x205
[58518.616400]  [<c10ff7a7>] vfs_write+0x84/0xde
[58518.660437]  [<c10ff89a>] sys_write+0x3b/0x60
[58518.667248]  [<c151fd9d>] syscall_call+0x7/0xb
[58518.672117] batman_adv: bat0: Interface activated: eth1
----

So maybe it makes sense to add the assertion in
primary_if_select() in patch 3/3 instead?

Hmm, and I'm wondering if it might make sense to also document it
with a little comment above the struct list_head hardif_list;,
like:
/* List additions and deletions have to be rtnl_lock()'ed,
 * list traversals just rcu-locked */
(or is that overdoing it?)

On Sat, Apr 30, 2011 at 10:54:14PM +0200, Sven Eckelmann wrote:
> hardif_list_lock is unneccessary because we already ensure that no
> multiple admin operations can take place through rtnl_lock.
> hardif_list_lock only adds additional overhead and complexity.
> 
> Critical functions now check whether they are called with rtnl_lock
> using ASSERT_RTNL.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> Rebased patch on top of "batman-adv: Make bat_priv->primary_if an rcu
> protected pointer"
> 
> 
>  hard-interface.c |   21 ++++++---------------
>  1 files changed, 6 insertions(+), 15 deletions(-)
> 
> diff --git a/hard-interface.c b/hard-interface.c
> index 6636d2f..7e2f772 100644
> --- a/hard-interface.c
> +++ b/hard-interface.c
> @@ -31,9 +31,6 @@
>  
>  #include <linux/if_arp.h>
>  
> -/* protect update critical side of hardif_list - but not the content */
> -static DEFINE_SPINLOCK(hardif_list_lock);
> -
>  
>  static int batman_skb_recv(struct sk_buff *skb,
>  			   struct net_device *dev,
> @@ -136,7 +133,7 @@ static void primary_if_select(struct bat_priv *bat_priv,
>  	struct hard_iface *curr_hard_iface;
>  	struct batman_packet *batman_packet;
>  
> -	spin_lock_bh(&hardif_list_lock);
> +	ASSERT_RTNL();
>  
>  	if (new_hard_iface && !atomic_inc_not_zero(&new_hard_iface->refcount))
>  		new_hard_iface = NULL;
> @@ -148,7 +145,7 @@ static void primary_if_select(struct bat_priv *bat_priv,
>  		hardif_free_ref(curr_hard_iface);
>  
>  	if (!new_hard_iface)
> -		goto out;
> +		return;
>  
>  	batman_packet = (struct batman_packet *)(new_hard_iface->packet_buff);
>  	batman_packet->flags = PRIMARIES_FIRST_HOP;
> @@ -161,9 +158,6 @@ static void primary_if_select(struct bat_priv *bat_priv,
>  	 * our new primary interface
>  	 */
>  	atomic_set(&bat_priv->hna_local_changed, 1);
> -
> -out:
> -	spin_unlock_bh(&hardif_list_lock);
>  }
>  
>  static bool hardif_is_iface_up(struct hard_iface *hard_iface)
> @@ -456,6 +450,8 @@ static struct hard_iface *hardif_add_interface(struct net_device *net_dev)
>  	struct hard_iface *hard_iface;
>  	int ret;
>  
> +	ASSERT_RTNL();
> +
>  	ret = is_valid_iface(net_dev);
>  	if (ret != 1)
>  		goto out;
> @@ -482,10 +478,7 @@ static struct hard_iface *hardif_add_interface(struct net_device *net_dev)
>  	atomic_set(&hard_iface->refcount, 2);
>  
>  	check_known_mac_addr(hard_iface->net_dev);
> -
> -	spin_lock(&hardif_list_lock);
>  	list_add_tail_rcu(&hard_iface->list, &hardif_list);
> -	spin_unlock(&hardif_list_lock);
>  
>  	return hard_iface;
>  
> @@ -499,6 +492,8 @@ out:
>  
>  static void hardif_remove_interface(struct hard_iface *hard_iface)
>  {
> +	ASSERT_RTNL();
> +
>  	/* first deactivate interface */
>  	if (hard_iface->if_status != IF_NOT_IN_USE)
>  		hardif_disable_interface(hard_iface);
> @@ -516,13 +511,11 @@ void hardif_remove_interfaces(void)
>  	struct hard_iface *hard_iface, *hard_iface_tmp;
>  
>  	rtnl_lock();
> -	spin_lock(&hardif_list_lock);
>  	list_for_each_entry_safe(hard_iface, hard_iface_tmp,
>  				 &hardif_list, list) {
>  		list_del_rcu(&hard_iface->list);
>  		hardif_remove_interface(hard_iface);
>  	}
> -	spin_unlock(&hardif_list_lock);
>  	rtnl_unlock();
>  }
>  
> @@ -549,9 +542,7 @@ static int hard_if_event(struct notifier_block *this,
>  		hardif_deactivate_interface(hard_iface);
>  		break;
>  	case NETDEV_UNREGISTER:
> -		spin_lock(&hardif_list_lock);
>  		list_del_rcu(&hard_iface->list);
> -		spin_unlock(&hardif_list_lock);
>  
>  		hardif_remove_interface(hard_iface);
>  		break;
> -- 
> 1.7.4.4
> 
