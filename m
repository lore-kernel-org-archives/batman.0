Return-Path: <andrew@lunn.ch>
Date: Mon, 28 Feb 2011 13:37:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20110228123720.GG4698@lunn.ch>
References: <AANLkTim+tN9NKUUHJqcaaxS-RpWeLQqrUoB0D+=sA0J7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTim+tN9NKUUHJqcaaxS-RpWeLQqrUoB0D+=sA0J7@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] OGM overhead and routing metric proposal
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

> In attachment you will also find a draft/proposals of a new routing
> approach. It is based on the collection of more link parameters (the
> current TQ, bit-rate and node-load) to write in OGM at each hop. This
> permit to develop a more thorough metric and can open new room of
> improvement such multi-path routing.

Hi Daniele

Do you have any suggestions how to collect this bit-rate information?
Do you suggest measuring it, or asking the wireless LAN driver?  Is
there an API in the kernel to allow access to this information?

Also, how do you see this interacting with the hidden node problem? In
order to reduce the hidden node problem, you ideally want to use the
lowest coding rate and transmit power possible to get your packets
through. Currently this is not being done. Current wireless systems
optimize for maximum bandwidth between two nodes, which may not be the
optimum for the complete mesh bandwidth, due to inter node
interference.

Will you be at the WBMv4 next Month?

     Andrew
