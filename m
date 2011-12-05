Return-Path: <ordex@autistici.org>
Date: Mon, 5 Dec 2011 15:44:38 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20111205144437.GB15946@ritirata.org>
References: <1323078985-1116-1-git-send-email-lindner_marek@yahoo.de>
	<201112051935.06611.lindner_marek@yahoo.de>
	<20111205121342.GD10131@lunn.ch>
	<201112052138.55069.lindner_marek@yahoo.de>
	<20111205140915.GA15946@ritirata.org>
	<20111205143848.GF10131@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20111205143848.GF10131@lunn.ch>
Subject: Re: [B.A.T.M.A.N.] switch routing algorithm at runtime
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

On Mon, Dec 05, 2011 at 03:38:48 +0100, Andrew Lunn wrote:
> > What about specifying the routing algorithm directly on "soft-iface creation"
> > and deny any further change?
> 
> Emails crossed in the post....
> 
> > 1) specify the soft-iface name => create the interface and allocate all the
> > structure (that are not dependant on the routing algo)
> > 
> >    1.1) the interface is in ALGO-WAITING state, any action that tries to enable it
> >    is denied and EBUSY (?) is returned.
> 
> We should try to keep backwards compatibility. So rather than having
> ALGO-WAITING, i would suggest using the first available routing
> algorithm as the default.
> 
> So the backwards compatible way would be:
> 
> 1) Add a hard interface, which automagically creates the soft
>    interface with the first available routing algorithm.
> 
> For those who want to play with new routing algorithms:
> 
> 1) Create the soft interface
> 2) Change the routing algorithm away from the default
> 3) Add the first hard interface.

I think that currently point 1) and 3) are joint. So adding something in between
means redesign the initialisation part.


Cheers,

-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
