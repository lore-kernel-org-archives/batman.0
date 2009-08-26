Return-Path: <andrew@lunn.ch>
Date: Wed, 26 Aug 2009 20:08:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20090826180810.GF16067@lunn.ch>
References: <20090826064151.GE21827@ma.tech.ascom.ch>
	<200908261001.31814.sven.eckelmann@gmx.de>
	<200908261119.22173.onelektra@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200908261119.22173.onelektra@gmx.net>
Subject: Re: [B.A.T.M.A.N.] List policy for none subscribers
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

> This is a good and important question. Even more so because Marek and I were 
> having a initial discussion via VOIP about ideas and changes to the algorithm 
> for the next generation mark 5 of the protocol algorithm. Our aim is (again) 
> reduced computational and data overhead, faster convergence speed, a 
> simplification of the protocol  and added support for IPv6. This step will 
> again call for a higher packet version number

How many of these goals can be reached without changing the packet
format? I've implemented regenerating lost OGMs without changing the
protocol to a degree it needs to bump the version number. Does
removing the averaging of TQ from remote neighbors change the message
format?

My question would be, does not changing the message format so that the
version number can stay the same impose too high a penalty in terms of
design restrictions?

       Andrew
