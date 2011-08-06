Return-Path: <hozer@hozed.org>
Date: Sat, 6 Aug 2011 09:56:08 -0500
From: Troy Benjegerdes <hozer@hozed.org>
Message-ID: <20110806145555.GD20928@excalibur.hozed.org>
References: <alpine.DEB.2.02.1108060959150.9094@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1108060959150.9094@localhost6.localdomain6>
Subject: Re: [B.A.T.M.A.N.] "Distributed" DHCP vs gateway
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

On Sat, Aug 06, 2011 at 10:19:28AM -0400, Ryan Hughes wrote:
> So, I had a crazy idea the other day:
> 
> Normally, when I talk to people about mesh networks, they assume
> that there is some central authority assigning IP addresses to nodes
> intelligently.
> 
> I was thinking, though, that I'd rather have it so that every node
> could have the same firmware, and you'd just throw the node up and
> it'd negotiate everything for itself, including its IP address.

Why reinvent the wheel? I would argue that using IPv6 stateless autoconfig

http://en.wikipedia.org/wiki/IPv6#Stateless_address_autoconfiguration_.28SLAAC.29

and then working to provide a mechanism to support 'legacy' IPv4-only
clients would be a beter solution than a lot of the hoops we have to 
jump through to support distributed dhcp cleanly.


My thought is every node runs radvd (ipv6 equivalent of dhcpd), and any
ipv4 traffic will get tunneled over the v6 mesh network to the closest
exit node with upstream IPv4 net access, which is where the DHCP server
would run.


