Return-Path: <error27@gmail.com>
Date: Mon, 8 Mar 2010 19:11:07 +0300
From: Dan Carpenter <error27@gmail.com>
Message-ID: <20100308161107.GL6469@bicker>
References: <20100308151244.GA4468@lunn.ch>
	<201003081615.49579.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201003081615.49579.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] FWD: batman: potential null dereference
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
Cc: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.net>

On Mon, Mar 08, 2010 at 04:15:30PM +0100, Sven Eckelmann wrote:
> Andrew Lunn wrote:
> > Does somebody have time to look at this?
> > ----- Forwarded message from Dan Carpenter <error27@gmail.com> -----
> [...]
> > drivers/staging/batman-adv/routing.c
> >     88          } else if ((orig_node->router == NULL) && (neigh_node !=
> >  NULL)) { ^^^^^^^^^^^^^^^^^^^^^^^^^
> >     89
> >     90                  bat_dbg(DBG_ROUTES,
> >     91                          "Adding route towards: %pM (via %pM)\n",
> >     92                          orig_node->orig, neigh_node->addr);
> >     93                  hna_global_add_orig(orig_node, hna_buff,
> >  hna_buff_len); 94
> >     95                  /* route changed */
> >     96          } else {
> >     97                  bat_dbg(DBG_ROUTES, "Changing route towards: %pM
> >  (now via %pM - was via %pM)\n", orig_node->orig, neigh_node->addr,
> >  orig_node->router->addr);
> >                                    ^^^^^^^^^^^^^^^^^^^^^^^
> >     98          }
> > 
> > This could fail if debugging is enabled and neigh_node is null.
> 
> It looks a little bit like checked with clang's static analyzer. This analyzer 
> has problems to track constraints at all. This means that it doesn't catch the 
> update_routes constraint "orig_node->router != neigh_node".
> 
> But I am also not good at tracking that kind of constraints and reported this 
> or a similar "bug" in batmand a while ago.
> 
> So it is not a real bug, but maybe not easy to read.
> 

Yeah.  I see what you mean...

regards,
dan carpenter

> Best regards,
> 	Sven


