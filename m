From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] two-radio nodes and alternative next hop
Date: Tue, 22 Apr 2008 16:01:57 +0200
References: <20080421123928.GA3483@apoderado.ometepe.net>
	<560c7c9a0804210557v2c94a553w5a2c8dd2efb8eead@mail.gmail.com>
	<20080421203002.GA4490@apoderado.ometepe.net>
In-Reply-To: <20080421203002.GA4490@apoderado.ometepe.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Disposition: inline
Message-Id: <200804221601.57318.axel@open-mesh.net>
Content-Transfer-Encoding: 8bit
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Hi Jan,

On Montag 21 April 2008, Jan Hetges wrote:
> On Mon, Apr 21, 2008 at 02:57:44PM +0200, Benjamin Henrion wrote:
> > On Mon, Apr 21, 2008 at 2:39 PM, Jan Hetges <tran@ms20.net> wrote:
> > >  i'm running bmxd_rv972 for almost three months now, without
> > >  any mayor problems :-)... thanks.
> > >  what i recognized lately, on two nodes (the ones with more than
> > >  one bmx interface), show alternativeNextHops, which are *NO*
> > >  alternative. It seems there gets some 'information' lost between
> > >  the two IFs. I suppose that's a known issue ;-), 
It is NOT a known issue (at least not to me) and if its a bug it should be fixed.
> > >  fix/workaround ? iirc, i saw once or twice a node "on the other
> > >  interface" even listed as the bestNextHop.
> >
> > Can you describe a little more extensively your network configuration?
>
> sorry ;-):
>
>  
> x.x.0.0/24---x.x.0.1/x.x.3.1---x.x.3.0/24---x.x.3.160/x.x.4.1---x.x.4.0/24
One general questions: do all your interfaces operate on the same frequency?

Then, I am unsure about the netmasks you are using. The above line I 
understand that you are using x.x.3.0/24 and x.x.4.0/24 netmasks. 
Generally, It is strongly recommended to always use the same netmask 
on ALL batman interfaces !
In your case there is: x.x.3.160/24 for one interface on the 3.160 node 
which should result in a broadcast address of x.x.3.255. 
But according to the debug output there is a direct link to x.x.4.165/24 
(which I guess has broadcast address of x.x.4.255) and therefore the two 
interfaces should not see each other!!?? Can you verify that (note that the 
"ifconfig dev ip/netmask" command is buggy and does not always produce 
corresponding netmask and broadcast addresses and that the interfaces MUST be 
configured appropriately before the daemon is started. !!!)

> .0.1/.3.1 is one node with two radios, and .3.160/.4.1 the other one.
> and, .3.160/.4.1 lists .4.162 as alternativeNextHop to .3.128.
> where .3.1 and .3.137 can see .3.128, but .4.162 can not. 

An alternativeNextHop to a specific node must not necessarily be a direct neighbor of 
that node. For example in the following scenario:

A---B---D
|       |
+---E---+

From As' point of view B and E may both be potential next hops towards D. But only E 
can directly see D.

Is it possible to generate (almost simultaneously) -cbd8 logs from the involved 
nodes, especially 3.1, 3.160, 4.162, 3.128. 

> So, there is a 
> real alternativeNextHop to .3.128 ... .3.137, which is listed after .4.162
> on .3.160/.4.1. I attach the output of bmxd -cbd8.

The attached debug log shows:
172.19.3.128    wlan0:bmx       172.19.3.1  80 (  97  1:01:20:33 15813    0 100 1012  
18   2      1 )    172.19.4.162  67    172.19.3.140   2 

At least this line does not show 3.137 listed after .4.162 on .3.160/.4.1
Has it been truncated ??

Looking forward to solve this...
best regards,
axel



