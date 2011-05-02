Return-Path: <linus.luessing@web.de>
Date: Mon, 2 May 2011 20:50:47 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20110502185047.GH12500@Sellars>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 1/3] batman-adv: Fix crash on module
 shutdown with multiple ifaces
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

On Sat, Apr 30, 2011 at 06:56:58PM +0200, Sven Eckelmann wrote:
> From: Linus Lüssing <linus.luessing@web.de>
> 
> hardif_remove_interfaces() removes all hard interfaces from the
> hardif_list before freeing and cleaning up any device. However the clean
> up procedures in orig_hash_del_if()
> (hardif_remove_interface()->hardif_disable_interface()->
> orig_hash_del_if()) need the other interfaces still to be present in the
> hardif_list. Otherwise it won't renumber any preceding interfaces, which
> leads to an unhandled kernel paging request in orig_node_del_if()'s
> "/* copy second part */" due to wrong hard_if->if_num's.
> 
> With this commit the interface removal on module shutdown will be down
> in the same way as removing single interfaces from batman only: One
> interface will be removed and cleaned at a time.
> 
> Signed-off-by: Linus Lüssing <linus.luessing@web.de>
> [sven@narfation.org: Keep locking around list_for_each_entry_safe]
Hmm, though that does not seem to work for me like that anyway:

----
[61975.933652] BUG: sleeping function called from invalid context at
kernel/mutex.c:278
[61975.938166] in_atomic(): 1, irqs_disabled(): 0, pid: 9199,
name: rmmod
[61975.941408] INFO: lockdep is turned off.
[61975.943655] Pid: 9199, comm: rmmod Not tainted 2.6.38+ #4
[61975.946518] Call Trace:
[61975.948360]  [<c105888a>] __might_sleep+0xd9/0xe0
[61975.951975]  [<c151ea00>] mutex_lock_nested+0x1a/0x33
[61975.954679]  [<c1148cfb>] sysfs_addrm_start+0x24/0x29
[61975.957446]  [<c11493f1>] sysfs_remove_dir+0x39/0x6c
[61975.960000]  [<c11e141c>] kobject_del+0xf/0x2c
[61975.962872]  [<c11e146b>] kobject_release+0x32/0x50
[61975.966295]  [<c11e1439>] ? kobject_del+0x2c/0x2c
[61975.969065]  [<c11e2181>] kref_put+0x39/0x44
[61975.971416]  [<c11e13b5>] kobject_put+0x37/0x3c
[61975.973921]  [<f9e06591>] sysfs_del_hardif+0xd/0x16
[batman_adv]
[61975.976845]  [<f9e0848c>] hardif_remove_interface+0x23/0x2d
[batman_adv]
[61975.979936]  [<f9e086d7>] hardif_remove_interfaces+0x35/0x53
[batman_adv]
[61975.984400]  [<f9e10945>] batman_exit+0x17/0x3c [batman_adv]
[61975.987189]  [<c1094242>] sys_delete_module+0x184/0x1dc
[61975.989893]  [<c10eb988>] ? remove_vma+0x52/0x58
[61975.992387]  [<c10ec6c2>] ? do_munmap+0x245/0x261
[61975.994849]  [<c151fd9d>] syscall_call+0x7/0xb
[61975.997361] batman_adv: bat0: Interface deactivated: eth1
[61976.000117] batman_adv: bat0: Removing interface: eth1
----

So looks like we may not hold a spin_lock() during the
hardif_remove_interface(). Of course, that issue is not present
with your next patch anymore. Thanks for good intention to keep my
fame++, but, hmm, maybe it actually only makes sense to have the
two patches merged.

> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> Splitted the first patch to keep Linus' fame. There should be no difference
> (after all patches are applied) between the first and the second version.
> 
>  hard-interface.c |   11 ++---------
>  1 files changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/hard-interface.c b/hard-interface.c
> index b3058e4..c6edf0a 100644
> --- a/hard-interface.c
> +++ b/hard-interface.c
> @@ -490,22 +490,15 @@ static void hardif_remove_interface(struct hard_iface *hard_iface)
>  void hardif_remove_interfaces(void)
>  {
>  	struct hard_iface *hard_iface, *hard_iface_tmp;
> -	struct list_head if_queue;
> -
> -	INIT_LIST_HEAD(&if_queue);
>  
> +	rtnl_lock();
>  	spin_lock(&hardif_list_lock);
>  	list_for_each_entry_safe(hard_iface, hard_iface_tmp,
>  				 &hardif_list, list) {
>  		list_del_rcu(&hard_iface->list);
> -		list_add_tail(&hard_iface->list, &if_queue);
> -	}
> -	spin_unlock(&hardif_list_lock);
> -
> -	rtnl_lock();
> -	list_for_each_entry_safe(hard_iface, hard_iface_tmp, &if_queue, list) {
>  		hardif_remove_interface(hard_iface);
>  	}
> +	spin_unlock(&hardif_list_lock);
>  	rtnl_unlock();
>  }
>  
> -- 
> 1.7.4.4
> 
