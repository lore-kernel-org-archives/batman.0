Return-Path: <andrew@lunn.ch>
Date: Fri, 8 Nov 2013 12:24:37 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20131108112437.GH4440@lunn.ch>
References: <CAAxzKbRQ-ZPZ8vQUu8GevK+gC-J16EZ-WDkyTcpVxqPZbYg5gw@mail.gmail.com>
 <527E152F.5090708@wirelesspt.net>
 <20131108110740.GM970@neomailbox.net>
 <527E189A.4060000@wirelesspt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <527E189A.4060000@wirelesspt.net>
Subject: Re: [B.A.T.M.A.N.] Replacing OLSRD with batman-adv?
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
To: cmsv@wirelesspt.net, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Antonio Quartulli <antonio@meshcoding.com>

On Sat, Nov 09, 2013 at 06:12:26AM -0500, cmsv wrote:
> Perhaps i misunderstood.
> 
> On 11/08/2013 06:07 AM, Antonio Quartulli wrote:
> > On Sat, Nov 09, 2013 at 05:57:51AM -0500, cmsv wrote:
> >>> 2) Must every client to a batman-adv mesh have a daemon installed?
> >> Every node must have batman-adv
> > 
> > Be careful to do not confuse him. He asked about *clients*, and clients are not
> > required to run batman-adv.
> 
> Does he mean clients as the people connecting to the access points with
> their computer or node clients that connect to mesh node routers that
> are servers and or gateways and are part of the backbone?

With BATMAN you can split the network into two parts. The mesh
infrastructure, a.k.a the mesh nodes, and devices using the
infrastructure, a.k.a, the clients.

All nodes in the mesh infrastructure need to run batman-adv, so that
they play an active part in the mesh. With the hardware described
here, one of the two interfaces is running in Adhoc mode and is part
of the mesh.

The other interface is run in plain old access point mode. The devices
using the mesh infrastructure connect to the access point as a
station. Thus they don't need batman-adv. They can also roam from
access point to access point, and the mesh infrastructure will work
out delivering the frames to the right access point and so to the
client.

	Andrew
