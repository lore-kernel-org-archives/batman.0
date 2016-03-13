Return-Path: <andrew@lunn.ch>
Date: Sun, 13 Mar 2016 16:35:50 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20160313153550.GB9674@lunn.ch>
References: <1456867148-31883-1-git-send-email-andrew@lunn.ch>
 <1456867148-31883-3-git-send-email-andrew@lunn.ch>
 <1562656.nUcF8KtnQf@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562656.nUcF8KtnQf@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 2/4] batman-adv: Create batman soft
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
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>

> Just to be sure (and so that I don't have to test it here :) ): When this 
> patch is applied, batadv_softif_create would already fail when the two 
> namespaces have a batadv interface with the same name because the debugfs 
> function would fail. But it would work when the batman-adv interfaces + the 
> slave interfaces (for per-slave interface information) have different names. 
> Right?

That is correct. As far as i remember, it failed in a good way,
i.e. not an opps. Which is why i put this patch first. We could swap
the order, have the debugfs patch first, but i though the 'why' of the
debugfs patch is probably clearer to somebody who has just reviewed
this patch first.

> It is currently not prevented that a slave device changes the namespace after 
> it was added. But this should not be a problem because the device will be 
> first removed from the original namespace (so it will be removed from batX) 
> and later added to the target namespace (see dev_change_net_namespace).

Yes, and this is the same mechanism used for other master devices,
like bridges, teams/bonding. The slave is hot-unplugged from one name
space and hot-plugged into another name space.

> Reviewed-by: Sven Eckelmann <sven@narfation.org>

Thanks
	Andrew
