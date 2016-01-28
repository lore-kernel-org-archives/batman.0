Return-Path: <andrew@lunn.ch>
Date: Thu, 28 Jan 2016 02:40:07 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20160128014007.GA28633@lunn.ch>
References: <1453312110-32683-1-git-send-email-andrew@lunn.ch>
 <1453312110-32683-5-git-send-email-andrew@lunn.ch>
 <20160128012807.GA22112@prodigo.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160128012807.GA22112@prodigo.lan>
Subject: Re: [B.A.T.M.A.N.] [PATCH 4/4] batman-adv: debugfs: Add netns
	support
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Antonio Quartulli <a@unstable.cc>
Cc: b.a.t.m.a.n@lists.open-mesh.org

On Thu, Jan 28, 2016 at 09:28:07AM +0800, Antonio Quartulli wrote:
> On Wed, Jan 20, 2016 at 06:48:30PM +0100, Andrew Lunn wrote:
> 
> [...]
> 
> > +static DEFINE_MUTEX(batadv_debugfs_ns_mutex);
> 
> [...]
> 
> > +static void batadv_debugfs_ns_put(struct net *net)
> > +{
> > +	struct batadv_debugfs_ns_entry *ns_entry;
> > +
> > +	mutex_lock(&batadv_debugfs_ns_mutex);
> > +	list_for_each_entry(ns_entry, &batadv_debugfs_ns, link) {
> > +		if (ns_entry->net == net) {
> > +			kref_put(&ns_entry->refcount, batadv_ns_entry_release);
> > +			break;
> > +		}
> > +	}
> > +	mutex_unlock(&batadv_debugfs_ns_mutex);
> > +}
> >  
> 
> Andrew, is there any particular reason why in this case we use a mutex instead
> of a spinlock + RCU ? I imagine it is something related to debugfs..or just to
> make the code simpler as we don't really require a full-blown RCU strategy ?
 
I just wanted it to be KISS. We are on a very slow path, only called
when interfaces are added and removed. Keeping it KISS makes it easier
to review, make sure i have an unlock for every lock, etc. It is also
what is the kref documentation suggests.
 
> >  int batadv_debugfs_add_hardif(struct batadv_hard_iface *hard_iface)
> >  {
> > +	char *name = hard_iface->net_dev->name;
> > +	struct net *net = dev_net(hard_iface->net_dev);
> 
> here we should respect David's inverted Christmas tree rule :)

Yes, i will change this.

> >  	struct batadv_debuginfo **bat_debug;
> > +	struct dentry *debugfs_ns_dir;
> >  	struct dentry *file;
> >  
> >  	if (!batadv_debugfs)
> >  		goto out;
> >  
> > -	hard_iface->debug_dir = debugfs_create_dir(hard_iface->net_dev->name,
> > -						   batadv_debugfs);
> 
> how about:
> 
> 	debugfs_ns_dir = batadv_debugfs;
> 
> > +	if (net != &init_net) {
> > +		debugfs_ns_dir = batadv_debugfs_ns_get(net);
> > +		if (!debugfs_ns_dir)
> > +			goto out;
> 	}
> 
> 	hard_iface->debug_dir = debugfs_create_dir(name, debugfs_ns_dir);
> 
> isn't it nicer? :)

O.K, i will rearrange.

     Andrew
