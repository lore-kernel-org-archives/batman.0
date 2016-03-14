Return-Path: <andrew@lunn.ch>
Date: Mon, 14 Mar 2016 20:20:38 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20160314192038.GB10040@lunn.ch>
References: <3465881.llCNFeNLl4@sven-edge> <15512323.RRrA1BdBoh@bentobox>
 <20160314140624.GA5636@lunn.ch> <58321025.0PBgHVCilp@bentobox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58321025.0PBgHVCilp@bentobox>
Subject: Re: [B.A.T.M.A.N.] [PATCH v3 6/6] batman-adv: debugfs: Add netns
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
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

On Mon, Mar 14, 2016 at 04:56:57PM +0100, Sven Eckelmann wrote:
> On Monday 14 March 2016 15:06:24 Andrew Lunn wrote:
> > > Matthias is against applying [1] patch 6 because it would require that
> > > batman-adv supports this interface for a long(tm) time. He proposes to use
> > > netlink instead.
> > > 
> > > Andrew, do you want to change patch 6 to avoid creating the debugfs stuff in
> > > non-init_net netns?
> > 
> > I'm not sure how well that is going to work, from the user space side
> > of things.
> > 
> > In the kernel, we know if we are in init_net, or some other netns.
> > 
> > In user space, it is not so simple. Ideally, when in some other netns
> > than the default, we need all reads/writes to debugfs to fail.
> 
> Hm, this would require some checks via the the current pid on open:
> 
>     net = get_net_ns_by_pid(current->pid);
>     ... checky check via neteq(net, &init_net)...
>     put_net(pd->net);

I suppose this could be made to work. Not sure what error code to
return, maybe ENXIO if batctl is not in the default netns.
 
> > What we
> > don't want is it seeing the default name spaces files, because it is
> > going to get very confusing. These files refer to something which does
> > not exist in the current netns.
> 
> Wait, but thats exactly what you are doing already with your default behavior
> (which only creates a symlink to netns/${FUNNY_ID}/. Legacy tools will still
> read the wrong information because they don't know about the new netns paths.

Correct. And this is unfixable, as far as i can see. You need the
contents of debugfs to be dependent on the observer. The requires core
debugfs support to calls like readdir() and open().

> I thought that the debugfs stuff will be replaced with netlink  and that the
> current debugfs files are only there for non-namespace setups with legacy tools.

Legacy tools are always going to be broken when they are used in the
non-default netns. Probably the best we can do is have the kernel
return ENXIO or whatever when they access files from a different
netns.

We have two options for non-default netns debugfs

1) Extend debugfs and the tools as i suggested patches for.

2) Only support default netns in debugfs, and use netlink for full
   netns aware tools.

   Andrew
