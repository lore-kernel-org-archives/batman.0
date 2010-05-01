Return-Path: <andrew@lunn.ch>
Date: Sat, 1 May 2010 18:48:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100501164833.GQ3734@lunn.ch>
References: <1272719410-406-1-git-send-email-andrew@lunn.ch>
	<1272719410-406-3-git-send-email-andrew@lunn.ch>
	<201005011837.42615.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201005011837.42615.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/4] batman-adv: Import sparse fixes from
 mainline.
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
To: Sven Eckelmann <sven.eckelmann@gmx.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org, lindner_marek@yahoo.de, b.a.t.m.a.n@lists.open-mesh.net

On Sat, May 01, 2010 at 06:34:56PM +0200, Sven Eckelmann wrote:
> Andrew Lunn wrote:
> > diff --git a/bat_sysfs.c b/bat_sysfs.c
> > index 7acf8d8..e2c000b 100644
> > --- a/bat_sysfs.c
> > +++ b/bat_sysfs.c
> > @@ -357,7 +357,8 @@ void sysfs_del_meshif(struct net_device *dev)
> >  static ssize_t show_mesh_iface(struct kobject *kobj, struct attribute
> > *attr, char *buff)
> >  {
> > -	struct net_device *net_dev = to_net_dev(to_dev(kobj->parent));
> > +	struct device *dev = to_dev(kobj->parent);
> > +	struct net_device *net_dev = to_net_dev(dev);
> >  	struct batman_if *batman_if = get_batman_if_by_netdev(net_dev);
> 
> This has not real something to do with this patch (which is good), but 
> to_net_dev was added in v2.6.20-236-g43cb76d and the README still states that 
> we are compatible with linux 2.6.20. I think we must change that to 2.6.25 
> (explanation below).
> 
> I did a build test with 2.6.19-2.6.28 (have to update my buildenv...):
> 
>  * 2.6.19: fails in many ways
>  * 2.6.20: fails in bat_sys.c
>  * 2.6.21: warnings in bat_sys.c (better call it fail)
>  * 2.6.22: warnings in bat_sys.c (better call it fail)
>  * 2.6.23: fails
>  * 2.6.24: fails
>  * 2.6.25: ok
>  * 2.6.26: ok
>  * 2.6.27: ok
>  * 2.6.28: ok

Simon is good at testing with older kernels and fixing problems. I
guess we can expect a patch to compat.h sometime soon to fix this....

> But to your patch:
> 
> Acked-by: Sven Eckelmann <sven.eckelmann@gmx.de>

Thanks
	Andrew
