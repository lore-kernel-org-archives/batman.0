Return-Path: <andrew@lunn.ch>
Date: Thu, 20 Feb 2014 11:10:45 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20140220101045.GK11878@lunn.ch>
References: <4F5A043B-6BFB-46F0-9D14-BDF07F2533E0@gmx.de>
 <530521C0.8060705@meshcoding.com>
 <2BC074F4-9F03-4D7D-A0CD-AF66ABB7DAB9@gmx.de>
 <5305308C.5090605@meshcoding.com> <20140220085433.GD11878@lunn.ch>
 <5305C4C5.8090504@meshcoding.com> <20140220090903.GF11878@lunn.ch>
 <5305CE85.6020201@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5305CE85.6020201@meshcoding.com>
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

> Hi Andrew,
> 
> > 
> > That is not what i have seen in practice. Because the metric is good,
> > and does not degrade, 
> 
> The missing degradation is the part where I don't agree.
> 
> Just to be sure we are understanding each other, I am talking about the
> scenario depicted in this picture:
> 
> http://www.open-mesh.org/attachments/download/52/triangle.png

Thanks for the diagram. Yes, Linus and I had a somewhat similar setup.
We had more nodes involved, and B was walking around the inside of a
building.
 
> 'A' is the source node and 'B' is our destination. B moves and breaks
> the line-of-sight with A, thus making the A<->B link unusable at all (we
> assume that now packet loss on A<->B is 100%).
> 
> At this point A still receives B's OGMs via N1.
> 
> According to batadv_iv_ogm_orig_update() (in bat_iv_ogm.c) each time a
> packet with a _new_seqno_ is received the global window of _each_
> neighbour for the given originator is shifted by one slot and the
> averages are computed again.
 
It is a couple of years since Linus investigated this. So maybe things
have changed. If it does work like this, great, that helps solves a
problem we had. I don't currently have access to a system to test this
though.

	Andrew

