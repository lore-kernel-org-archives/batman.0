Return-Path: <andrew@lunn.ch>
Date: Fri, 29 Apr 2016 20:53:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20160429185349.GI17679@lunn.ch>
References: <1461875848-11720-1-git-send-email-andrew@lunn.ch>
 <1461875848-11720-3-git-send-email-andrew@lunn.ch>
 <13793953.BNCcl5mI6H@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13793953.BNCcl5mI6H@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCH 02/10] batman-adv: Suppress debugfs
 entries for netns's
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

On Fri, Apr 29, 2016 at 08:07:18PM +0200, Sven Eckelmann wrote:
> On Thursday 28 April 2016 22:37:20 Andrew Lunn wrote:
> > Debugfs is not netns aware. It thus has problems when the same
> > interface name exists in multiple network name spaces.
> > 
> > Work around this by not creating entries for interfaces in name spaces
> > other than the default name space. This means meshes in network
> > namespaces cannot be managed via debugfs, but there will soon be a
> > netlink interface which is netns aware.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> [...]
> > -__printf(2, 3)
> > +_printf(2, 3)
> >  static int batadv_fdebug_log(struct batadv_priv_debug_log *debug_log,
> >  			     const char *fmt, ...)
> >  {
> 
> I would really like to give this patch a Reviewed-by but this part seems to be
> an accident.

Agreed. This should not be changed.

	Andrew
