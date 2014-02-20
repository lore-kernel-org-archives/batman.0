Return-Path: <andrew@lunn.ch>
Date: Thu, 20 Feb 2014 10:09:03 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20140220090903.GF11878@lunn.ch>
References: <4F5A043B-6BFB-46F0-9D14-BDF07F2533E0@gmx.de>
 <530521C0.8060705@meshcoding.com>
 <2BC074F4-9F03-4D7D-A0CD-AF66ABB7DAB9@gmx.de>
 <5305308C.5090605@meshcoding.com> <20140220085433.GD11878@lunn.ch>
 <5305C4C5.8090504@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5305C4C5.8090504@meshcoding.com>
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
To: Antonio Quartulli <antonio@meshcoding.com>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Thu, Feb 20, 2014 at 10:03:01AM +0100, Antonio Quartulli wrote:
> On 20/02/14 09:54, Andrew Lunn wrote:
> > The routing protocol is known to have problems when a node suddenly
> > disappears. A received OGM is what triggers updates to the metric. If
> > you stop receiving OGMs the metric is no longer updated until the node
> > is purged as dead. This for example causes problems with
> > nomadic/mobile nodes. They can go around a corner, loss line of sight,
> > but still be considered the best route until purged as dead.
> 
> But if you keep receiving OGMs via another neighbour you will have a
> route switch *before* the old nexthop is considered as dead.

Hi Antonio

That is not what i have seen in practice. Because the metric is good,
and does not degrade, it stays as the best route. That is one of the
reasons Linus developed NDP while at Ascom.

	  Andrew
