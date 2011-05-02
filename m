Return-Path: <linus.luessing@web.de>
Date: Mon, 2 May 2011 20:05:57 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20110502180557.GD12500@Sellars>
References: <1304182620-12637-1-git-send-email-sven@narfation.org>
	<1304182620-12637-3-git-send-email-sven@narfation.org>
	<20110502172728.GC12500@Sellars>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20110502172728.GC12500@Sellars>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 3/3] batman-adv: Avoid deadlock between
 rtnl_lock and s_active
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

Ok, could reproduce and verify it now (latest master branch
_without_ patches 1/3 and 2/3, with that version I can still
reproduce that issue reliably). Putting only patch 3/3 on top the
master branch then fixes that locking dependancy. Thanks, Sven!

Cheers, Linus

On Mon, May 02, 2011 at 07:27:28PM +0200, Linus Lüssing wrote:
> Looks good, seems to make sense and tried it. Works so far with no
> call traces or other uggly stuff. However I'm still trying to
> reproduce the initial issue of ticket #145 to confirm that this
> patch fixes it (used a different kernel and batman-adv version
> back then, of course... so somehow the 'always' stated there does
> not seem to be valid anymore :) ).
> 
> PS: Ok, just sometimes I'm still getting a locking dependancy call
> trace, but that one involves two different locks
> ((&(&bat_priv->hna_ghash_lock)->rlock){+.-...}, at: [<f83a3dd6>]
> hna_global_del_orig+0x22/0x90 [batman_adv]
> (&(&hash->list_locks[i])->rlock){+.-...}, at: [<f839fe4b>]
> _purge_orig+0x45/0x1be [batman_adv]) and therefore seems to be
> unrelated - I'll open a new ticket for that.
> 
> On Sat, Apr 30, 2011 at 06:57:00PM +0200, Sven Eckelmann wrote:
> > The hard_if_event is called by the notifier with rtnl_lock and tries to
> > remove sysfs entries when a NETDEV_UNREGISTER event is received. This
> > will automatically take the s_active lock.
> > 
> > The s_active lock is also used when a new interface is added to a meshif
> > through sysfs. In that situation we cannot wait for the rntl_lock before
> > creating the actual batman-adv interface to prevent a deadlock. It is
> > still possible to try to get the rtnl_lock and immediately abort the
> > current operation when the trylock call failed.
> > 
> > Signed-off-by: Sven Eckelmann <sven@narfation.org>
> > ---
> > Remove '{' '}' after 'if (hard_iface->if_status != IF_NOT_IN_USE)'
> > 
> >  bat_sysfs.c      |   16 +++++++++-------
> >  soft-interface.c |    2 +-
> >  2 files changed, 10 insertions(+), 8 deletions(-)
> > 
> > diff --git a/bat_sysfs.c b/bat_sysfs.c
> > index e449bf6..497a070 100644
> > --- a/bat_sysfs.c
> > +++ b/bat_sysfs.c
> > @@ -488,22 +488,24 @@ static ssize_t store_mesh_iface(struct kobject *kobj, struct attribute *attr,
> >  	    (strncmp(hard_iface->soft_iface->name, buff, IFNAMSIZ) == 0))
> >  		goto out;
> >  
> > +	if (!rtnl_trylock()) {
> > +		ret = -ERESTARTSYS;
> > +		goto out;
> > +	}
> > +
> >  	if (status_tmp == IF_NOT_IN_USE) {
> > -		rtnl_lock();
> >  		hardif_disable_interface(hard_iface);
> > -		rtnl_unlock();
> > -		goto out;
> > +		goto unlock;
> >  	}
> >  
> >  	/* if the interface already is in use */
> > -	if (hard_iface->if_status != IF_NOT_IN_USE) {
> > -		rtnl_lock();
> > +	if (hard_iface->if_status != IF_NOT_IN_USE)
> >  		hardif_disable_interface(hard_iface);
> > -		rtnl_unlock();
> > -	}
> >  
> >  	ret = hardif_enable_interface(hard_iface, buff);
> >  
> > +unlock:
> > +	rtnl_unlock();
> >  out:
> >  	hardif_free_ref(hard_iface);
> >  	return ret;
> > diff --git a/soft-interface.c b/soft-interface.c
> > index f4d80ad..bf53aa3 100644
> > --- a/soft-interface.c
> > +++ b/soft-interface.c
> > @@ -613,7 +613,7 @@ struct net_device *softif_create(char *name)
> >  		goto out;
> >  	}
> >  
> > -	ret = register_netdev(soft_iface);
> > +	ret = register_netdevice(soft_iface);
> >  	if (ret < 0) {
> >  		pr_err("Unable to register the batman interface '%s': %i\n",
> >  		       name, ret);
> > -- 
> > 1.7.4.4
> > 
> 
