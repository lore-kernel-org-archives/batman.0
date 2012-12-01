Return-Path: <eric.dumazet@gmail.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <1354382991-31350-1-git-send-email-siwu@hrz.tu-chemnitz.de>
References: <1354382991-31350-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 01 Dec 2012 10:36:12 -0800
Message-ID: <1354386972.20109.523.camel@edumazet-glaptop>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] net: fix possible deadlocks in
	rtnl_trylock/unlock
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
To: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

On Sat, 2012-12-01 at 18:29 +0100, Simon Wunderlich wrote:
> If rtnl_trylock() is used to prevent circular dependencies, rtnl_unlock()
> may destroy this attempt because it first unlocks rtnl_mutex but may
> lock it again later. The callgraph roughly looks like:
> 
> rtnl_unlock()
>    netdev_run_todo()
>       __rtnl_unlock()
>       netdev_wait_allrefs()
>          rtnl_lock()
>          ...
>          __rtnl_unlock()
> 
> There are two users which have possible deadlocks and are fixed in this
> patch: batman-adv and bridge. Their problematic access pattern is the same:
> 
> notifier_call handler:
>  * holds rtnl lock when called
>  * calls sysfs code at some point (acquiring sysfs locks)
> 
> sysfs code:
>  * holds sysfs lock when called
>  * calls rtnl_trylock() and rtnl_unlock(), rtnl_unlock() calls rtnl_lock
>    implicitly
> 
> Fix this by exporting __rtnl_unlock() to just unlock the mutex without
> implicitly locking again.
> 
> Reported-by: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> 
> ---
> Of course, an alternative would be to not lock again after unlocking
> within rtnl_unlock(), or put the todo handling into the locked section.
> I'm not familiar enough with this code to know what would be best.
> 
> There are others using rtnl_trylock(), but I'm not sure if they
> are affected.
> ---
>  net/batman-adv/sysfs.c   |    2 +-
>  net/bridge/br_sysfs_br.c |    2 +-
>  net/bridge/br_sysfs_if.c |    2 +-
>  net/core/rtnetlink.c     |    1 +
>  4 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
> index 66518c7..41b74aa 100644
> --- a/net/batman-adv/sysfs.c
> +++ b/net/batman-adv/sysfs.c
> @@ -635,7 +635,7 @@ static ssize_t batadv_store_mesh_iface(struct kobject *kobj,
>  	ret = batadv_hardif_enable_interface(hard_iface, buff);
>  
>  unlock:
> -	rtnl_unlock();
> +	__rtnl_unlock();
>  out:
>  	batadv_hardif_free_ref(hard_iface);
>  	return ret;
> diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
> index c5c0593..c122782 100644
> --- a/net/bridge/br_sysfs_br.c
> +++ b/net/bridge/br_sysfs_br.c
> @@ -142,7 +142,7 @@ static ssize_t store_stp_state(struct device *d,
>  	if (!rtnl_trylock())
>  		return restart_syscall();
>  	br_stp_set_enabled(br, val);
> -	rtnl_unlock();
> +	__rtnl_unlock();
>  
>  	return len;
>  }

I have no idea of why you believe there is a problem here.

Could you explain how net_todo_list could be not empty ?

As long as no device is unregistered between
rtnl_trylock()/rtnl_unlock(), there is no possible deadlock.



