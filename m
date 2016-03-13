Return-Path: <andrew@lunn.ch>
Date: Sun, 13 Mar 2016 16:38:08 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20160313153808.GC9674@lunn.ch>
References: <1456867148-31883-1-git-send-email-andrew@lunn.ch>
 <1456867148-31883-4-git-send-email-andrew@lunn.ch>
 <42883547.GmOm9E46Iz@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42883547.GmOm9E46Iz@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 3/4] batman-adv: Handle parent
 interfaces in a different netns
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>

> > +	const struct net *dev1_parent_net = net1;
> > +	const struct net *dev2_parent_net = net2;
> > +
> > +	if (dev1->rtnl_link_ops && dev1->rtnl_link_ops->get_link_net)
> > +		dev1_parent_net = dev1->rtnl_link_ops->get_link_net(dev1);
> > +	if (dev2->rtnl_link_ops && dev2->rtnl_link_ops->get_link_net)
> > +		dev2_parent_net = dev2->rtnl_link_ops->get_link_net(dev2);
> [...]
> > +       struct net *parent_net = net;
> [...]
> > +	if (net_dev->rtnl_link_ops && net_dev->rtnl_link_ops->get_link_net)
> > +		parent_net = net_dev->rtnl_link_ops->get_link_net(net_dev);
> > +
> 
> My proposal is there to move this in an extra function [1] so adding compat
> code is easier [2].

Hi Sven

Do you want to squash your compact changes in and add your own
Signed-off-by?

	Andrew
