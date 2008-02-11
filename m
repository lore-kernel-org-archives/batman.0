From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] RE: Multiple wireless interfaces
Date: Mon, 11 Feb 2008 13:00:09 +0100
References: <BLU134-W199EC580346187E750B911E1470@phx.gbl>
	<200801151845.43446.lindner_marek@yahoo.de>
	<000601c86c95$5b1bbad0$11533070$@com>
In-Reply-To: <000601c86c95$5b1bbad0$11533070$@com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200802111300.09927.axel@open-mesh.net>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
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
To: pele@balorda.com, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Hi Predrag,

BATMAN does not really support that for multihop mesh networks. If you want 
this behavior only for single hop connections you can cheat with batmand-exp 
using the options:
--asymmetric-weight and the interface specific option /c

A smaller /c value (than the default) will apply a penalty to the detected 
link transmit quality of an interface and the --asymmetric-weight switch can 
then be used to tell the algorithm to be more reluctant to use links with a 
bad transmit quality.

I successfully tested this in a simple wired two-node setup each with two 
interfaces as illustrated below. Afterwards batman did set up the routing 
table that a ping between node A and node B always chooses the upper link 
from A to B and the lower link from B to A.

node A               node B
 eth0  -------------> eth0
 eth1  <------------- eth1
 
therefore I started on node A:
batmand --asymmetric-weight 2  eth0 /c 100 eth1 /c 50

and on node B:
batmand --asymmetric-weight 2  eth0 /c 50 eth1 /c 100

But be aware, that this will change the default behavior of batman and may 
have negative side effects on the overall path detection in you mesh.

ciao,
axel

On Montag 11 Februar 2008, Predrag Balorda wrote:
> Has anyone thought about this "problem" recently?
>
> To simplify - 3 routers, 2 adapters each, how do we establish duplex links
> between each of those by using batman alone?
>
> Or, 3 routers, 2 adapters each, how do we establish simplex links between
> each of those such that one adapter links "upstream" and one "downstream"
> using batman alone?
>
> > Another thing - think of this as quasi-asynchronous links, i.e. B can
> > talk to A on both interfaces (call them int1 and int2), but only chooses
> > int1, and A does the opposite, chooses the other (int2) to talk back to
> > B. If B has to talk to both A and C at the same time and can see A and C
> > on both int1 and int2 then it will choose int1 to talk to A and int2 to
> > talk to C.
> >
> > Maybe it makes sense now....
> >
> > P.S. or maybe I'm just missing something
> >
> > > -----Original Message-----
> > > From: Predrag Balorda [mailto:pele@balorda.com]
> > > Sent: Friday, January 18, 2008 2:42 PM
> > > To: 'The list for a Better Approach To Mobile Ad-hoc Networking'
> > > Subject: Multiple wireless interfaces
> > >
> > > Ok. Here is something batman doesn't provision for - dual-interface
> > > setup where you want to create a duplex link (tx on one and rx on
> > > another). Duplex link to one other node is simple (and has to be done
> > > manually),
> >
> > but
> >
> > > how would we go about creating a duplex link to 2 or more nodes? Or one
> > > simplex link to downstream node and one simplex link to upstream node?
> > > Example:
> > >
> > > A = B   C duplex link (for example I need to talk from B to A fast and
> > > I use both interfaces to talk to A)
> > > A - B - C simplex links (I use one interface to talk to A and one to
> > > talk to B)
> > > A = B/B = C duplex links for all links (I talk to both A and C duplex,
> >
> > but
> >
> > > not at the same time of course)
> > >
> > > How do we do this with batman easily and dynamically (without having to
> > > manually mess around with routing tables etc)?
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


