Return-Path: <andrew@lunn.ch>
Date: Mon, 25 Jan 2016 14:12:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20160125131239.GY3880@lunn.ch>
References: <1453312110-32683-1-git-send-email-andrew@lunn.ch>
 <1453312110-32683-3-git-send-email-andrew@lunn.ch>
 <20160125032853.GA15121@prodigo.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160125032853.GA15121@prodigo.lan>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/4] batman-adv: Create batman soft
 interfaces within correct netns.
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

On Mon, Jan 25, 2016 at 11:28:53AM +0800, Antonio Quartulli wrote:
> On Wed, Jan 20, 2016 at 06:48:28PM +0100, Andrew Lunn wrote:
> >  int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
> > -				   const char *iface_name)
> > +				   struct net *net, const char *iface_name)
> 
> Andrew,
> minor style note here: instead of passing the namespace as argument, could we
> just invoke dev_net() on hard_iface->net_dev inside
> batadv_hardif_enable_interface() ?

Hi Antonio

The problem with that is register_netdevice() is used to register the
soft interface in batadv_softif_create(). Calling it after
registrations would mean it needs to change netns. The default
namespace might already have a bat0, so it is given the name bat1, but
then gets moved to the target netns, and will keeps its name, unless
there already is a bat1 interface. But people expect the newly created
interface to be called bat0.

I think passing the namespace is correct, so the softif can be created
in the correct place to start with.

   Andrew
