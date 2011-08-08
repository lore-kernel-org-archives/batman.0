Return-Path: <drwho@virtadpt.net>
Message-ID: <4E4035E2.9040206@virtadpt.net>
Date: Mon, 08 Aug 2011 15:15:46 -0400
From: The Doctor <drwho@virtadpt.net>
MIME-Version: 1.0
References: <alpine.DEB.2.02.1108060959150.9094@localhost6.localdomain6>
In-Reply-To: <alpine.DEB.2.02.1108060959150.9094@localhost6.localdomain6>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] "Distributed" DHCP vs gateway
Reply-To: drwho@virtadpt.net,
	The list for a Better Approach To Mobile Ad-hoc Networking
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
To: b.a.t.m.a.n@lists.open-mesh.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 08/06/2011 10:19 AM, Ryan Hughes wrote:

> I was thinking, though, that I'd rather have it so that every node could
> have the same firmware, and you'd just throw the node up and it'd
> negotiate everything for itself, including its IP address.

That is fairly easy to do.  A given mesh runs the risk of two colliding
IP addresses, but that is easy enough to evade if one picks a large
enough potential address space.

> So I was thinking:  What if each node in the network was using
> batman-adv, and ran a DHCP client and a DHCP server? It'd try to get an
> address thru DHCP.  If it failed, it'd choose an address at random from
> the network range.  Then, any time someone threw up a new node in range,
> the new node would try to get an address, and it would succeed in
> getting an address from the first node.

That would indeed work.  One could also write a small utility which
pseudo-randomly chose an IP address from one of the RFC-1918 ranges (for
example) and just configured itself with ifconfig.  This is what I have
been doing:

https://github.com/Sitwon/Byzantium/blob/master/control_panel/networkconfiguration.py#L321

> Multiple DHCP servers can serve the same, overlapping IP ranges. 
> However, this depends on the DHCPOFFER and DHCPREQUEST being broadcast
> to the network.  This is how we avoid having the same IP address
> assigned to multiple nodes -- DHCP servers overhear what was assigned to
> whom by other DHCP servers, and make a note to themselves not to assign
> that address themselves.

<makes a mental note>

I was unaware of this; I had assumed that, once a client had grabbed IP
configuration information, it would simply ignore any other DHCPOFFERs.

> So it seems that a "distributed" DHCP system could work.

For what it is worth, it seemed to work fairly well in small-scale
experiments.

> The problem is, doesn't Batman-adv munge the DHCP that flows though it,
> for its gateway logic?  So that the DHCPREQUESTs are unicast?  That's
> great for gateway logic.  But I also want nodes to have IP addresses for
> internal communication.

I have not seen it do that in operation.

> Is this idea just too crazy?  Why?

It does not sound too crazy, but slightly overcomplicated for what you
seem to want to use it for.

- -- 

The Doctor [412/724/301/703]

PGP: 0x807B17C1 / 7960 1CDC 85C9 0B63 8D9F  DD89 3BD8 FF2B 807B 17C1
WWW: http://drwho.virtadpt.net/

A little booty house is good for the soul.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5ANeIACgkQO9j/K4B7F8EQXwCg37mCXI/xCJtFiTvSa9TreR5w
C5oAn0aiHDrSNc5/Zvl/MMmRafP3Tx23
=GPyU
-----END PGP SIGNATURE-----
