Return-Path: <andrew@lunn.ch>
Date: Thu, 20 Feb 2014 09:54:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20140220085433.GD11878@lunn.ch>
References: <4F5A043B-6BFB-46F0-9D14-BDF07F2533E0@gmx.de>
 <530521C0.8060705@meshcoding.com>
 <2BC074F4-9F03-4D7D-A0CD-AF66ABB7DAB9@gmx.de>
 <5305308C.5090605@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5305308C.5090605@meshcoding.com>
Subject: Re: [B.A.T.M.A.N.] Suggestion for routing improvement on poor links
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

On Wed, Feb 19, 2014 at 11:30:36PM +0100, Antonio Quartulli wrote:
> On 19/02/14 23:12, whangarei & opua wrote:
> > Hi Antonio,
> > 
> > have only a live environment, so only have access to my own router, but
> > anyway,
> > looks you aware of this issue...
> > 
> > But I have seen no change of the TQ over the time ( up to 180 sec) on my
> > side with my (maybe old) version of batman.
> > Is it an new feature, or it is maybe not working like expected, in my
> > old version? :(
> > 
> 
> I think this is something that is part of batman-adv since the beginning
> (somebody else can confirm this).

The routing protocol is known to have problems when a node suddenly
disappears. A received OGM is what triggers updates to the metric. If
you stop receiving OGMs the metric is no longer updated until the node
is purged as dead. This for example causes problems with
nomadic/mobile nodes. They can go around a corner, loss line of sight,
but still be considered the best route until purged as dead.

This design problem will be fixed with the BATMAN V. It has a second
protocol which is used between one hop peers and should quickly detect
if a peer has disappeared.

   Andrew
