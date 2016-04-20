Return-Path: <andrew@lunn.ch>
Date: Wed, 20 Apr 2016 04:31:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20160420023136.GA13247@lunn.ch>
References: <cover.1458231707.git.mschiffer@universe-factory.net>
 <3565172.dz0c0eMaPu@prime>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3565172.dz0c0eMaPu@prime>
Subject: Re: [B.A.T.M.A.N.] [RFC v2 0/5] batman-adv netlink query API
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

> > The following files are still missing:
> > 
> > * gateways
> > * bla_claim_table
> > * bla_backbone_table
> > * dat_cache
> > * nc_nodes
> > 
> > Obviously, documentation is also a TODO. Comments about the API design are
> > very welcome...
> > 
> > Regards,
> > Matthias
> 
> Hi Matthias,
> 
> thanks for reposting this and sorry for the long silence. Since we have the 
> namespace work from Andrew now which would require netlink support, I think 
> its a good time to integrate this. :)

Hi Simon, Matthias

I picked up your patches and played with them when combined with my
netns patches. All works well.

I also started on integrating the user space code with batctl. I've
got as far as integrating netlink user space code for what you had,
and i added gateways, and started on bla_claim_table.

I'm on vacation this week, and i'm not likely to be reading emails
again this week. 

I should be able to post code next week.

  Andrew
