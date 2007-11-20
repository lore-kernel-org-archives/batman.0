From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] single IP for multiple interfaces
Date: Tue, 20 Nov 2007 13:31:27 +0100
References: <47426F09.9060605@absorb.it>
	<200711201232.11894.axel@open-mesh.net>
	<4742C76A.6050404@absorb.it>
In-Reply-To: <4742C76A.6050404@absorb.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200711201331.27288.axel@open-mesh.net>
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

On Dienstag 20 November 2007, rene wrote:
> Hi,
>
> Axel Neumann wrote:
> >>> There MUST be a different IP address for each BATMAN interface in the
> >>> network (also if a single BATMAN node has more than one interface).
> >>
> >> Is this implemented like this (where?)?
> >
> > Yes it is implemented/designed like this. It operates on layer three and
> > above. IP addresses are used to differentiate between different links to
> > the same neighbors. For example two nodes A and B, each with two wireless
> > interfaces 1 and 2. All interfaces operating in the same channel, bssid,
> > ... How could node A differentiate between the link A1<->B1 and A1<->B2
> > if it is not aware of any MAC addresses. But even if it is aware of MAC
> > addresses. How could it set up the routing table to ensure that a packet
> > to a distant node C should be routed via B1 (and NOT via B2)?
>
> just by setting the interface to the way the package has to leave the
> node? Just the same way olsr does, I'm not a protocol designer but don't
> see any main reason why Batman shouldn't be possible to do it similar.

IMO that does only work if the interfaces of a node are NOT connected to the 
same physical/logical link (e.g. B1 and B2 are operating on different 
channels or with different cell IDs,...). Otherwise specifying the outgoing 
interface is not enough. Even if node A has only one interface (A1). If there 
is a link A1<->B1 and a link A1<->B2 the problem remains:
> > How could it set up the routing table to ensure that a packet
> > to a distant node C should be routed via B1 (and NOT via B2)?
The outgoing interface of node A is A1, for both cases. Setting the outgoing 
interface to A1 has no effect. 

Maybe there is a way to configure the next-hop-mac address instead of the 
next-hop-ip address. But then you rather have layer 2 routing and not layer 
3.

/axel

>
> > Actually, I did not even know that this is possible - is such a
> > configuration proposed somewhere. I can imagine that this somehow works
> > but how shure are you that this does not introduce any negative side
> > effects?
>
> We are using this in Rostock since a while (on all WRAPs and on selected
> APs) and it works very well. Side effects? Maybe, you never know for
> sure, none recognized and I'm not deep enough into protocol designs to
> answer this from a theoretical point of view. But it's a great feature
> which makes Mesh networking much easier and the whole structure much
> cleaner.
>
> Regards,
> Rene
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


