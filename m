Return-Path: <andrew@lunn.ch>
Date: Mon, 26 Apr 2010 07:14:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100426051434.GB3734@lunn.ch>
References: <201004252136.25395.adebex@gmail.com>
	<8B0EF841-727E-4805-BB43-D779DB6948F3@gmail.com>
	<201004260124.22098.adebex@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201004260124.22098.adebex@gmail.com>
Subject: Re: [B.A.T.M.A.N.] Security & node authentication in BATMAN network
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

> However, I'm still concerned about issue of using fake nodes
> claiming they are someone else (e.g. sending fake OGMs) for sole
> reason of destroying the mesh.  Do you think this is important
> issue? Can it be somehow reduced?

There are much simpler ways of destroying the mesh, at last
locally. e.g, my wife has a cordless telephone which operates in the
2.4GHz band. Pick up the line and wireless in the area dies. That
phone quickly got replaced with a DECT phone operating in the USA DECT
band, 1.9GHz.

2.4GHz is in the so called ISM band, industrial, scientific and
medical. Bluetooth, WiFi, microwave ovens, ZigBee, sometimes radio car
keys all work in this band, and all potentially interfere with each
other. You are working in a medical environment, so you may find that
down by radiography, you can forget WiFi all together?

You really need to tell us your use cases. Do you need a network which
has 99.999% uptime? Then dig up the road and lay fibre. Can you live
with a best effort network, which will probably die every so often,
can easily to DOSed, and performance will probably very depending on
day/night, weekday/weekend and the phase of the moon?

	   Andrew

