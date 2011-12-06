Return-Path: <ordex@autistici.org>
Date: Tue, 6 Dec 2011 16:06:04 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20111206150603.GE6839@ritirata.org>
References: <1323078985-1116-1-git-send-email-lindner_marek@yahoo.de>
	<201112051935.06611.lindner_marek@yahoo.de>
	<20111205121342.GD10131@lunn.ch>
	<201112052138.55069.lindner_marek@yahoo.de>
	<20111205142553.GE10131@lunn.ch>
	<20111206150134.GA12168@pandem0nium>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20111206150134.GA12168@pandem0nium>
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

On Tue, Dec 06, 2011 at 04:01:34PM +0100, Simon Wunderlich wrote:
> Hey there,
> 
> On Mon, Dec 05, 2011 at 03:25:53PM +0100, Andrew Lunn wrote:
> > > Here comes the chicken & egg problem: We can't have bat0 and its routing 
> > > algorithm selection before we did not add at least one hard-interface.
> 
> an alternative we may consider:
> 
> We could just write the name of the algorithm in a debugfs file called
> "routing_algorithm". It is filled with batmanIV as the default algorithm
> to start with, and whatever is written there is used for the next soft interface
> to be created.

sounds good IMHO! I think this would be a really nice solution.

> 
> This would be backward compatible and changes are only made upon creation of a
> soft interface. It would also allow different soft interfaces using different
> routing algorithms (if someone really needs it). Putting it into debugfs may be
> not the worst idea, as changing routing algorithms is (currently) only done for
> debugging purposes anyway.
> 
> What do you think?

I agree on this solution...it merges nearly all the ideas we discussed so far.

Cheers,

-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
