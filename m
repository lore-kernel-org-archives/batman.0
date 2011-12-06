Return-Path: <andrew@lunn.ch>
Date: Tue, 6 Dec 2011 16:21:06 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20111206152106.GJ10131@lunn.ch>
References: <1323078985-1116-1-git-send-email-lindner_marek@yahoo.de>
	<201112051935.06611.lindner_marek@yahoo.de>
	<20111205121342.GD10131@lunn.ch>
	<201112052138.55069.lindner_marek@yahoo.de>
	<20111205142553.GE10131@lunn.ch>
	<20111206150134.GA12168@pandem0nium>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
> 
> This would be backward compatible and changes are only made upon creation of a
> soft interface. It would also allow different soft interfaces using different
> routing algorithms (if someone really needs it). Putting it into debugfs may be
> not the worst idea, as changing routing algorithms is (currently) only done for
> debugging purposes anyway.

Hi Simon

When it is in debugfs, it implies that the user has no choice, it is a
debug tool only. So when the development is finished, one day batman
will just swap from IV to V, and the user gets no choice?

For the moment, i think it is O.K. in debugfs. However, there should
be some sort of idea how this is going to work when it comes to
actually mainstream use of V. Is it simply that IV is dead, you need
to use V now. Or do we give the user a choice and some file under /sys
to make this choice?

 Also, i would suggest not adding batctl support for this file in
/debugfs, since then routing_algorithm is on the first steps towards
becoming part of the ABI, even thought it is in debugfs and should not
be part of an ABI.

       Andrew
