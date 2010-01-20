Return-Path: <andrew@lunn.ch>
Date: Wed, 20 Jan 2010 10:49:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100120094922.GH7844@lunn.ch>
References: <20100119145806.275330@gmx.net>
	<201001201015.59477.lindner_marek@yahoo.de>
	<20100120092904.181520@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100120092904.181520@gmx.net>
Subject: Re: [B.A.T.M.A.N.] batman-adv on different archs
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

On Wed, Jan 20, 2010 at 10:29:04AM +0100, "Juha Yl?nen" wrote:
> 
> -------- Original-Nachricht --------
> > Datum: Wed, 20 Jan 2010 10:15:59 +0800
> > Von: Marek Lindner <lindner_marek@yahoo.de>
> >
> > Complete configuration means: brctl show, ifconfig, cat /proc/net/batman-
> > adv/interfaces (or batctl if) and ping output. 
> 
> Could be the first one in the list as brctl fails. CONFIG_BRIDGE is
> not configured in the device kernel. Is batman-adv dependent on
> this? I'll recompile the kernel and see what happens (it's a slow
> process), in the meanwhile, what other kernel configurations are
> needed for batman-adv?

Bridging is not a requirement. 

However many uses typically use bridging to build bigger
networks. They bridge bat0 with eth0 to form one big layer 2 network.

However you don't have to do this. I've run OSPF on the bat0 interface
and just routed traffic over it just like any other network link in
the network.

    Andrew
