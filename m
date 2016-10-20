Return-Path: <linus.luessing@c0d3.blue>
Date: Thu, 20 Oct 2016 20:33:03 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20161020183303.GD32033@otheros>
References: <20161018212125.32010-1-linus.luessing@c0d3.blue>
 <1555062.TzeBilqSPn@sven-edge> <20161018232239.GI6366@otheros>
 <9062705.AOdrQGRa4W@bentobox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9062705.AOdrQGRa4W@bentobox>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: compat: Substitute compat
 code for netlink constification
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

On Wed, Oct 19, 2016 at 08:31:03AM +0200, Sven Eckelmann wrote:
> On Mittwoch, 19. Oktober 2016 01:22:39 CEST Linus Lüssing wrote:
> > On Tue, Oct 18, 2016 at 11:28:23PM +0200, Sven Eckelmann wrote:
> > > Doesn't seem to scale. Especially when we think about batadv_netlink_ops
> > > which should also be const. It is currently not const because of the
> > > Linux <= 3.13 workaround.
> > 
> > Hm, okay, batadv_netlink_ops is a little more tricky/larger, yes.
> > What about a memcpy'ing approach with BUILD_BUG_ON()'s as
> > safe-guards like this:
> 
> Yes, this would also be an idea. But I would personally just use the 
> coccinelle approach because it needs less extra hacks. Or do you have any 
> problems with coccinelle?

Hm, no, dunno. Just haven't really looked at coccinelle yet and
thought your point 3. (cocinelle) were on place 4. instead.
Besides, I had fun creating this compat patch and was marvelled
that the BUILD_BUG_ON() worked even with function parameters :D
(maybe, actually because they were const now? You clever compiler
:D).

Also, it looks like the whole compat infrastructure is growing and
I'm wondering whether it is easier to maintain slightly larger
compat-includes vs. then two more places where compat changes
could come from.


But I don't feel strongly about it, if others think coccinelle is
easier to review and maintain, then I'm fine with it and will have
a closer look at coccinelle :).
