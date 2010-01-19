Return-Path: <andrew@lunn.ch>
Date: Tue, 19 Jan 2010 18:44:17 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100119174417.GJ24649@lunn.ch>
References: <20100104182710.GA24091@pandem0nium>
	<20100118151552.GE7844@lunn.ch> <20100118152426.GG7844@lunn.ch>
	<201001190812.49887.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201001190812.49887.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Add bonding functionality
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

On Tue, Jan 19, 2010 at 08:12:49AM +0800, Marek Lindner wrote:
> On Monday 18 January 2010 23:24:26 Andrew Lunn wrote:
> > gw_node_update() is missing a rcu_read_unlock(); before the return
> > inside the list_for_each_entry_rcu() loop. The others are less
> > serious, but should be corrected as well.
> 
> Thanks - I just fixed it.
> 
> What does this error message want to tell us ?
> batman-adv-kernelland/routing.c:966:5: warning: context imbalance in 
> 'recv_unicast_packet' - different lock contexts for basic block

I've never spent the time to read the sparse documentation to figure
out exactly what this means. Just from experience i know it is trying
to tell us the locks don't balance in some code path. ie the number of
locks don't equal the number of unlocks. It is not the friendliest of
warning messages.

	Andrew
