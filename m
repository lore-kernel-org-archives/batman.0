Return-Path: <andrew@lunn.ch>
Date: Mon, 9 May 2016 18:51:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20160509165103.GB10508@lunn.ch>
References: <1462372207-28322-1-git-send-email-andrew@lunn.ch>
 <1689798.ZJlLjAlgFP@bentobox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1689798.ZJlLjAlgFP@bentobox>
Subject: Re: [B.A.T.M.A.N.] [PATCHv4] batctl: Use netlink to replace some of
 debugfs
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

On Mon, May 09, 2016 at 06:28:29PM +0200, Sven Eckelmann wrote:
> On Wednesday 04 May 2016 16:30:07 Andrew Lunn wrote:
> > +       [BATADV_ATTR_THROUGHPUT]        = { .type = NLA_FLAG },
> 
> Why is throughput a flag when you access it with 
> 
>     throughput_kbits = nla_get_u32(attrs[BATADV_ATTR_THROUGHPUT]);
> 
> Most likely just a copy+paste error and it should be NLA_U32.

Yep, thanks.

     Andrew
