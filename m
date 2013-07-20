Return-Path: <andrew@lunn.ch>
Date: Sat, 20 Jul 2013 09:28:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20130720072855.GH5358@lunn.ch>
References: <68049499-9E98-436A-B86C-DDF8877C22D5@uirevolution.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68049499-9E98-436A-B86C-DDF8877C22D5@uirevolution.com>
Subject: Re: [B.A.T.M.A.N.] Location on the network
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

On Sat, Jul 20, 2013 at 04:17:10PM +1200, Brani Mead wrote:

> I'm wondering if its theoretically possible to locate a device
> physically on the network. The nodes may have some notion of
> distance between eachother and therefore time, and therefore can
> compute the fastest route. However can any information be gleaned or
> added that indicates which direction a node is in relation to north
> south east or west on a map?

> My challenge is to connect a local group of cellphones to a mesh but
> to also be able to define which phones are to the east of a central
> point which to the west, north and south.

Hi Brani

Are the cellphones using BATMAN, or are they just STA of an access
point co-located with a mesh node? And is your mesh static, or can the
mesh itself move around?

I'm assuming your mesh nodes are static. Thus you can determine there
location once, using GPS, etc, and assume they are not going to move.

If the cellphones are STA, you can tell from the tables that BATMAN
keeps which mesh node they are behind. Thus if you know the location
of the BATMAN mesh node, your know the approximate location of the
cellphone.

	Andrew
