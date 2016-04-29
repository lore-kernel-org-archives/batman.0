Return-Path: <andrew@lunn.ch>
Date: Fri, 29 Apr 2016 23:56:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20160429215626.GM17679@lunn.ch>
References: <1461875848-11720-1-git-send-email-andrew@lunn.ch>
 <1461875848-11720-11-git-send-email-andrew@lunn.ch>
 <5873283.ggJnZknB2g@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5873283.ggJnZknB2g@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCH 10/10] batman-adv: add B.A.T.M.A.N. Dump
 BLA claims via netlink
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

On Fri, Apr 29, 2016 at 11:07:37PM +0200, Sven Eckelmann wrote:
> On Thursday 28 April 2016 22:37:28 Andrew Lunn wrote:
> > +       hlist_for_each_entry_rcu(claim, head, hash_entry) {
> > +               if (idx++ < *idx_skip)
> > +                       continue;
> > +               if (batadv_bla_claim_dump_entry(msg, portid, seq,
> > +                                               primary_if, claim))
> > +                       *idx_skip = idx - 1;
> > +                       goto unlock;
> > +       }
> 
> This is buggy and will always jump to unlock after the first entry. Please 
> enclose the "*idx_skip = idx - 1;" and "goto unlock;" with { ... }

Hi Sven

Yep. As i said, untested and likely broken.

I will fix this, and it would be good if somebody could test the v2,
and maybe even fix it. Or i can drop this patch.

    Andrew
