Return-Path: <fw@strlen.de>
Date: Mon, 21 Nov 2016 12:09:15 +0100
From: Florian Westphal <fw@strlen.de>
Message-ID: <20161121110915.GB22120@breakpoint.cc>
References: <1479725922-5112-1-git-send-email-fgao@ikuai8.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1479725922-5112-1-git-send-email-fgao@ikuai8.com>
Subject: Re: [B.A.T.M.A.N.] [PATCH net v2 1/1] net: batman-adv: Treat
 NET_XMIT_CN as transmit successfully
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: fgao@ikuai8.com
Cc: mareklindner@neomailbox.ch, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, a@unstable.cc, gfree.wind@gmail.com, davem@davemloft.net

fgao@ikuai8.com <fgao@ikuai8.com> wrote:
> From: Gao Feng <fgao@ikuai8.com>
> 
> The tc could return NET_XMIT_CN as one congestion notification, but
> it does not mean the packet is lost. Other modules like ipvlan,
> macvlan, and others treat NET_XMIT_CN as success too.
> 
> So batman-adv should add the NET_XMIT_CN check.

"The tc could return NET_XMIT_CN as one congestion notification, but
it means another packet got dropped. Other modules like batman do not
treat NET_XMIT_CN as success, so modules like ipvlan, macvlan, ..
should ignore it as well."

What I am asking is:
Are you sure adding NET_XMIT_CN handling everywhere is the right way to
resolve the inconsistency?
