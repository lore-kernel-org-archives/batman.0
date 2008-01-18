References: <BLU134-W199EC580346187E750B911E1470@phx.gbl>	<BLU134-W3993EA83B0AA37D57C1E69E1470@phx.gbl>	<20080115150800.GA7589@hrz.tu-chemnitz.de>
	<200801151845.43446.lindner_marek@yahoo.de> 
In-Reply-To: 
Date: Fri, 18 Jan 2008 14:46:21 -0000
Message-ID: <000001c859e0$e7be64a0$b73b2de0$@com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
From: Predrag Balorda <predrag.balorda@gmail.com>
Subject: [B.A.T.M.A.N.] RE: Multiple wireless interfaces
Reply-To: pele@balorda.com,
	The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: 'The list for a Better Approach To Mobile Ad-hoc Networking' <b.a.t.m.a.n@open-mesh.net>

Another thing - think of this as quasi-asynchronous links, i.e. B can talk to A
on both interfaces (call them int1 and int2), but only chooses int1, and A does
the opposite, chooses the other (int2) to talk back to B.
If B has to talk to both A and C at the same time and can see A and C on both
int1 and int2 then it will choose int1 to talk to A and int2 to talk to C.

Maybe it makes sense now....

P.S. or maybe I'm just missing something

> -----Original Message-----
> From: Predrag Balorda [mailto:pele@balorda.com]
> Sent: Friday, January 18, 2008 2:42 PM
> To: 'The list for a Better Approach To Mobile Ad-hoc Networking'
> Subject: Multiple wireless interfaces
> 
> Ok. Here is something batman doesn't provision for - dual-interface setup
> where you want to create a duplex link (tx on one and rx on another).
> Duplex link to one other node is simple (and has to be done manually), but
> how would we go about creating a duplex link to 2 or more nodes? Or one
> simplex link to downstream node and one simplex link to upstream node?
> Example:
> 
> A = B   C duplex link (for example I need to talk from B to A fast and I
> use both interfaces to talk to A)
> A - B - C simplex links (I use one interface to talk to A and one to talk
> to B)
> A = B/B = C duplex links for all links (I talk to both A and C duplex, but
> not at the same time of course)
> 
> How do we do this with batman easily and dynamically (without having to
> manually mess around with routing tables etc)?

