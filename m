Return-Path: <linus.luessing@c0d3.blue>
Date: Wed, 26 Nov 2014 17:37:43 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20141126163743.GB3837@odroid>
References: <1410068560-7829-1-git-send-email-linus.luessing@web.de>
 <1410068560-7829-5-git-send-email-linus.luessing@web.de>
 <5961070.CapjBEeMcY@prime>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5961070.CapjBEeMcY@prime>
Subject: Re: [B.A.T.M.A.N.] [PATCHv9 4/4] batman-adv: Forward IGMP/MLD
 reports to selected querier (only)
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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

On Mon, Nov 24, 2014 at 03:56:06PM +0100, Simon Wunderlich wrote:
> As a general note: This patch adds ~400 lines for mainly processing IGMP/MLD 
> stuff, right? Shouldn't this kind of IP/IGMP/MLD report detection and 
> memorizing the Querier rather go in the bridge code instead of batman-adv, or 
> is there any functionality there already? IMHO the preferred position would be 
> the bridge code since its more general/used by more people on one hand, and 
> does not bloat batman-adv on the other hand. :)
> 
> Could you give us some comments regarding who should do IGMP/MLD processing in 
> the kernel so we are prepared for these kind of upstream questions?

Currently, with this patch, the decisions about where to forward IGMP/MLD
reports in batman-adv is done on the multicast listener / report sender side.

With this approach, as seen in the picture, even a node without
the bridge (the blue node 'L') needs to snoop reports. It can't
rely on a bridge.


On the other hand, the current upstream implementation without
bridge support does not (necessarily) need it (will add an
explanation to the wiki page).

Though there is no (does not seem to be) any conceptual issue with
either the current upstream implementation or this proposition as is,
you just made me realize that there are issues with mixed setups...
backwards compatibility issues... For instance if node 'L' were of
a post-multicast but pre-multicast-bridge optimizations version.
