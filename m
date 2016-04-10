Return-Path: <linus.luessing@c0d3.blue>
Date: Sun, 10 Apr 2016 14:43:30 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160410124329.GH19310@otheros>
References: <1458101205-26316-1-git-send-email-linus.luessing@c0d3.blue>
 <1458101205-26316-2-git-send-email-linus.luessing@c0d3.blue>
 <4820570.LxUU2Z3eNS@prime> <20160410120748.GG19310@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160410120748.GG19310@otheros>
Subject: Re: [B.A.T.M.A.N.] [PATCHv12 1/4] batman-adv: Always flood IGMP/MLD
 reports
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

On Sun, Apr 10, 2016 at 02:07:48PM +0200, Linus Lüssing wrote:
> On Thu, Apr 07, 2016 at 03:03:11PM +0200, Simon Wunderlich wrote:
> > > To avoid compatibility issues with older nodes not yet implementing this
> > > report handling, we need to force them to flood reports: We do this by
> > > bumping the multicast TVLV version to 2, effectively disabling their
> > > multicast optimization.
> > 
> > It looks like you register two containers, one with version 1 and version 2, 
> > both with the same content. Do we really need to have both containers? 
> > Wouldn't it be sufficient to register only version 2 and leave version 1 out?
> 
> The idea is to avoid unexpected regressions:
> 
[...]
> The registeration of two containers is probably a minor improvement.
> Haven't heard of any actual setups which would need it yet. On the
> other hand it's not that much extra code, so it felt like a good
> idea to add it for some extra compatibility courtesy.

My intention would be to have it just as a transitional mechanism,
too. Removing it in 2-4 years maybe.

Regards, Linus
