Return-Path: <linus.luessing@c0d3.blue>
Date: Sun, 10 Apr 2016 14:07:48 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160410120748.GG19310@otheros>
References: <1458101205-26316-1-git-send-email-linus.luessing@c0d3.blue>
 <1458101205-26316-2-git-send-email-linus.luessing@c0d3.blue>
 <4820570.LxUU2Z3eNS@prime>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4820570.LxUU2Z3eNS@prime>
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

On Thu, Apr 07, 2016 at 03:03:11PM +0200, Simon Wunderlich wrote:
> > To avoid compatibility issues with older nodes not yet implementing this
> > report handling, we need to force them to flood reports: We do this by
> > bumping the multicast TVLV version to 2, effectively disabling their
> > multicast optimization.
> 
> It looks like you register two containers, one with version 1 and version 2, 
> both with the same content. Do we really need to have both containers? 
> Wouldn't it be sufficient to register only version 2 and leave version 1 out?

The idea is to avoid unexpected regressions:

The advantage of registering two containers lies in a setup where you have a
non-bridged network with multicast TVLV v1 and rely on these optimizations.
If a new node with both containers is added, then the old nodes
won't mind. If only container v2 were registered, old nodes would
switch to flooding. Which might be seen as an undesired
regression, depending on the requirements of the network.

Note that if the new node has a bridge, then the TVLV v1 container
gets unregistered and only the v2 one is announced (see PATCH 2/4).
This is because we have to, otherwise we might have packet loss
(which is even worse than flooding).


The registeration of two containers is probably a minor improvement.
Haven't heard of any actual setups which would need it yet. On the
other hand it's not that much extra code, so it felt like a good
idea to add it for some extra compatibility courtesy.


I don't feel that strongly for it though. Let me know what you or
others would prefer.

Regards, Linus
