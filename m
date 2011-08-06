Return-Path: <ryan@iheartryan.com>
MIME-Version: 1.0
Date: Sat, 06 Aug 2011 10:20:01 -0700
From: Ryan Jud Hughes <ryan@iheartryan.com>
In-Reply-To: <20110806145555.GD20928@excalibur.hozed.org>
References: <alpine.DEB.2.02.1108060959150.9094@localhost6.localdomain6>
	<20110806145555.GD20928@excalibur.hozed.org>
Message-ID: <14d8e95b055e78a5fee934eb3192a2b8@pirateship.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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


> Why reinvent the wheel? I would argue that using IPv6 stateless
autoconfig
> 
>
http://en.wikipedia.org/wiki/IPv6#Stateless_address_autoconfiguration_.28SLAAC.29
> 
> and then working to provide a mechanism to support 'legacy' IPv4-only
> clients would be a beter solution than a lot of the hoops we have to
> jump through to support distributed dhcp cleanly.

I was looking into the idea of using IPv6-only on the inside of the
network, but the consensus seems to be that this is a hard and unsolved
problem.

Let's say that you are an IPv6-only client on the inside of the network. 
You want to view the website kittenwar.com.  You look it up on DNS.  Let's
say that kittenwar.com only has an A record and not an AAAA record.  If you
don't have an IPv4 address, this A record is useless to you.  The solution
is this trick called DNS64.  DNS64 is a proxy.  If it sees that a site has
only an A record, it will construct an AAAA record and return that for you,
using the standard transformations of IPv4 addresses to IPv6 addresses.

Then, how does your IPv6 traffic get over to kittenwar.com, which is only
listening on IPv4?  The solution is a trick called NAT64, which nats your
IPv6 traffic over to IPv4.

So the technology theoretically exists.  But as of the time I was last
doing the research, it was unstable and did not have a lot of development
effort behind it.

It's not as simple as the problem of getting your IPv4 traffic out to an
IPv6 address.

So, it's hoops either way.  I was hoping that the distributed-dhcp path
would be shorter.

But yeah, the problem is much simpler in IPv6-land, where there's
autoconfiguration, and you can have as many IPv6 addresses as you need.

--Ryan

