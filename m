Return-Path: <ordex@autistici.org>
Date: Sat, 26 Nov 2011 10:09:17 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20111126090916.GA17206@ritirata.org>
References: <1322173279-18338-1-git-send-email-ordex@autistici.org>
	<1322173279-18338-6-git-send-email-ordex@autistici.org>
	<20111125084556.GG6836@lunn.ch>
	<20111125111708.GC17321@autistici.org>
	<20111125210911.GA23936@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20111125210911.GA23936@lunn.ch>
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 5/7] batman-adv: Distributed ARP Table
 - add snooping functions for ARP messages
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

On Fri, Nov 25, 2011 at 10:09:11 +0100, Andrew Lunn wrote:
> It might make sense to drop such messages, since they are
> invalid. However, nothing obvious comes to mind which would go wrong
> if you did cache them, other than somebody could DOS you by sending
> lots of ARP entries for multicast addresses.

Yes, I was thinking the same. A DOS is the major threat we could face without
this validity check. However, since we use the kernel function to add such
entries into the table it might be that the kernel already does this checks for
us. I'll look towards it

> 
> > > In a similar direction, how does duplicate address detection work?
> > > i.e. i ARP my own address to see if somebody else is using it? 
>  
> > Don't think so. Actually I/we didn't think too much about this kind of
> > cases. Well, a duplicate entry is simply overwritten: I mean, if we
> > already have the entry [IPa,MACa] in the table, any other ARP reply containing
> > [IPa,MACb] will update the older one and MACa will be lost.
> 
> The basic idea with duplicate address detection is to send out an ARP
> request for your own address. If you get an answer, you know somebody
> is using the address. I think Windoz then shuts the interface down, or
> at least gives a warning. So in the case of duplicate address
> detection, you want to fallback to broadcasting the ARP request and
> see if anybody answers. You can detect if a node is performing
> aduplicate detection, if the ARP requests source MAC address is the
> same as the answer in the cache. If so, fall back to broadcasting
> rather than answering from the cache.
> 
> Looking at RFC 3927 might also be interesting, since it uses ARP
> messages in a different way.
> 
> Also, i know some dhcp servers try to ping an IP address before giving
> it out, just to be sure it is not in use. Answering the ARP request
> from what could be an out of date cache entry doesn't i think causes a
> problem, so long as the ping that follows it does not get
> answered. But maybe some DHCP servers just perform an ARP request?
> 

Mh...but I think this behaviour is somehow left untouched. The mechanisms you
are describing are higher-level matters. Since we only limit to fill tables and
get answer, all the other mechanisms/procedures which use the tables should
still continue to work as they are. If a windows client will issue an ARP req to
see is someone else is using the same IP, DAT will simply answer as a normal
table would do. Therefore I think that this kind of worries are not matter of
DAT.

I hope I clearly explained my thought.

Then we could always add more feature in order to "facilitate" such mechanisms,
but up to now I think that DAT simply provides the same behaviour a normal table
would do.

Thank you for your comments!
Cheers,

-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
