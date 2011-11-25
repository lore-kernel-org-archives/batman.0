Return-Path: <andrew@lunn.ch>
Date: Fri, 25 Nov 2011 22:09:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20111125210911.GA23936@lunn.ch>
References: <1322173279-18338-1-git-send-email-ordex@autistici.org>
	<1322173279-18338-6-git-send-email-ordex@autistici.org>
	<20111125084556.GG6836@lunn.ch>
	<20111125111708.GC17321@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20111125111708.GC17321@autistici.org>
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

On Fri, Nov 25, 2011 at 12:17:08PM +0100, Antonio Quartulli wrote:
> On Fri, Nov 25, 2011 at 09:45:56AM +0100, Andrew Lunn wrote:
> > Hi Antonio
> > 
> > General question. In the Linux ARP decode code is:
> > 
> > /*
> >  *      Check for bad requests for 127.x.x.x and requests for multicast
> >  *      addresses.  If this is one such, delete it.
> >  */
> >         if (ipv4_is_loopback(tip) || ipv4_is_multicast(tip))
> >                 goto out;
> > 
> > I don't see the same filtering here. What would happen if you did
> > receiver and cached such a bad request?
> 
> atually there isnot such control over the arp message content. In case
> of, let's say, a malicious ARP message of this type, it is stored like
> any other one.

It might make sense to drop such messages, since they are
invalid. However, nothing obvious comes to mind which would go wrong
if you did cache them, other than somebody could DOS you by sending
lots of ARP entries for multicast addresses.

> > In a similar direction, how does duplicate address detection work?
> > i.e. i ARP my own address to see if somebody else is using it? 
 
> Don't think so. Actually I/we didn't think too much about this kind of
> cases. Well, a duplicate entry is simply overwritten: I mean, if we
> already have the entry [IPa,MACa] in the table, any other ARP reply containing
> [IPa,MACb] will update the older one and MACa will be lost.

The basic idea with duplicate address detection is to send out an ARP
request for your own address. If you get an answer, you know somebody
is using the address. I think Windoz then shuts the interface down, or
at least gives a warning. So in the case of duplicate address
detection, you want to fallback to broadcasting the ARP request and
see if anybody answers. You can detect if a node is performing
aduplicate detection, if the ARP requests source MAC address is the
same as the answer in the cache. If so, fall back to broadcasting
rather than answering from the cache.

Looking at RFC 3927 might also be interesting, since it uses ARP
messages in a different way.

Also, i know some dhcp servers try to ping an IP address before giving
it out, just to be sure it is not in use. Answering the ARP request
from what could be an out of date cache entry doesn't i think causes a
problem, so long as the ping that follows it does not get
answered. But maybe some DHCP servers just perform an ARP request?

Some things to think about...

	  Andrew	  

