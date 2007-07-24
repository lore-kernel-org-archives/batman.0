Message-ID: <46A591C0.8090009@poelzi.org>
Date: Tue, 24 Jul 2007 07:44:32 +0200
From: Daniel Poelzleithner <poelzi@poelzi.org>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] Multiple connections / prioritiy
References: <20070723140744.ozvor890jy5cockg@webmail.ddmesh.de>
In-Reply-To: <20070723140744.ozvor890jy5cockg@webmail.ddmesh.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Freifunk Dresden wrote:

> If I have multiple connections between two nodes, is there a way to
> setup the quality or
> priority of those connection?

Same goes for Leipzig, we have our vpn[1,2].leipzig.freifunk.net nodes.
I thought about this problem a lot and the simplest solution would be to
simply drop like 9 of 10 batman packets on the outgoing vpn interface.
this is like a olsr multiplicator of 10 with the advantage that it saves
bandwith.

short anecdote about dropping olsr packets:
so, we now have this huge vpn that connects most edges of the mesh to
central olsr nodes. because this are just backup routes, we have to
increase the etx value, no problem with the olsr multiplier option. on
the vpn a packetloss of 0% ist relative normal, so you pump out 5kb/s of
olsr traffic just to say: mmhh, ok, very good connection but i think its
bad anyway. so, if olsr messures the packet loss rate, i could simply
drop 9 of 10 packets and with 0.5kb/s i would have the same effect. if
that is what olsr is supposed to do.

by the way, we have arround 400 GB per month olsr overhead alone, which
is just creazy for a routing protocol overhead.

i ran a couple of tests.
there is a iptables match called nth, so i tested to allow only every
tenth packet. i got a etx of 0.0
strange: i allowed 50% -> etx 0.0
stranger: i allowed 90% -> etx 0.0
there is a percent match. i combined them, i tried percent alone, etc.
olsr depends a lot about which packets get dropped.
you simply can't just drop packets without getting etx 0.0 for at least
periods of 20-30 seconds, which drives you nuts.

batman should work very well with that approach.

kindly regards
 Daniel
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: GnuPT 2.7.2
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGpZG/y/mkIQp7AD0RAtcUAKDPP/rKGgMt5doPyLdgxcDPm1cO/QCgsQ09
kXCustGVyorDABZKxXlutWk=
=BXOc
-----END PGP SIGNATURE-----
