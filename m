From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] originator timeout
Date: Sun, 8 Jul 2007 12:37:13 +0200
References: <2bda28cd0707072316p4dbbddbauaf1a1124b8542918@mail.gmail.com>
	<200707081043.31142.axel@open-mesh.net>
	<2bda28cd0707080231g763465b3la57e0dbbf1d966ab@mail.gmail.com>
In-Reply-To: <2bda28cd0707080231g763465b3la57e0dbbf1d966ab@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200707081237.14412.axel@open-mesh.net>
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

Hi,
thanks!

still
> > one observation according to your log files:
> > node2 (interface 10.1.1.1) never gets any of its own originator messages
> > back (rebroadcasted) from node6. Despite node2 receives OGMs from node6.
according to the log file node2 behaves correct (despite the thing that node2 
generates a route to node6 within the first two seconds). At some point in 
time node2 purges node6 from its routing table because it could never 
validate the link between interface 10.1.1.1 and 10.1.1.33 as a bidirectional 
link. Can you generate another set of log files at node2 and node6 
simultaneously? So that we can identify whether node2 simply does not hear or 
node6 never re-broadcasts any originator messages (OGMs) send by node2.

> > I assume that node6 simply can not hear node2 (and maybe also others) and
> > therefore node6 can not rebroadcast OGMs from node2 (which is necessary
> > for the bidirectional link check). One reason for that might be, that the
> > netmask and broadcast address of the (alias) interfaces batman is using
> > on node2 and node6 are not identical. can you check that?
>
> node2:
>   eth0.0  inet addr:10.0.1.3  Bcast:10.0.1.255  Mask:255.255.255.0
>   wl0 inet addr:10.1.1.1  Bcast:10.1.1.255  Mask:255.255.255.0

Hmm... actually another thing but:
I see that on node2 the netmask and broadcast addresses for the two interfaces 
used by batman are different. I've never tried nor considered it that way - 
might work - but it is (imho) not the intended setup. With batman you 
can/should use the same netmask (and broadcast addresses) for all interfaces 
participating in the batman mesh. Otherwise you can get topology 
fractionation with which the protocol can not deal with automatically.
Perhaps you can try to give ALL interfaces a 255.255.255.0 netmask and a 
10.255.255.255 broadcast address?

>
> node6:
>   wl0 inet addr:10.1.1.33  Bcast:10.1.1.255  Mask:255.255.255.0
>
> node2 and node6 speak very well in wireless channel

ciao,
axel

