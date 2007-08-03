Message-ID: <20070803111004.256txg3batj8ks0s@webmail.ddmesh.de>
Date: Fri, 03 Aug 2007 11:10:04 +0200
From: Freifunk Dresden <freifunk@ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] dynamic gateway
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
To: b.a.t.m.a.n@open-mesh.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Zitat von Lui <batman@schmudde.com>:

> Marek,
>
>> First of all, "-g" is just flooded through the network. We
>> also want some kind of "dyngw"-plugin but with a better approach:
>> By using tunnels to the gateway batman is in a far better situation
>> than OLSR. The "is internet really available" check can be done on
>> the client side and is therefore much more
>
> it's about the gateway himself (not a client-of-the-gateway).
> A gateway router (has to/)should check his default route and change
> his role to 'ordinary-client' => switch working state from -g to
> -r/-p Mode. May think about NATed LAN-clients, too...
>
> The "working-tunnel-check" is good tool against 'vandalism' or
> mis-configuration in the hand of a gateway-client, but it's no
> protection for the gateway against vandalism (i.e.) of his ISP...
>
> Lui
> (stucking just in the mentioned situation)
>
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>
Hi,

independet of the kind of the solution for the internet gateway, each
node that offers can do some vandalism. It only needs to use its own
firmware or compiled batmand version. So we should trust each node
client that it is not modified in such a bad way. If a tunnel is used
or other parts of the firmware run some tests and setup default routes
doesn't matter.
As you know dresden freifunk is very in the beginning and therefore I
like to take the opportunity to use badmand because of its clear usage
and functionality. but for our tests I have used policy routing and a
similar technic to check for all possible gateways a node may have.
this eliminates the following problem: A------B(HNA:
allinet)-----C(HNA:one Inet ip)
Node C only has a HNA for a specific internet server but does not
offer a verified internet gateway. If A access this ip  than Node B
did not use its verified offered gateway and forwards the request to
C. The problem is, that the  HNA of C may be brocken or missconfigured.
Policy routing allows to filter for all Internet addresses on Node B
and redirects the packets to the proofed gateway.

Please let me know if I didn't got anything right. For the first glace
I would prever standard routing without tunnel, which let me see where
the packet go to the internet and which way they use (inc.timings
traceroute). I now I can traceroute the gateway and the internet in
two step to get the same info.

Bye
  Stephan


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)

iD8DBQFGsjy2ZSvvlmZMBPIRAkTwAKDjQMXBafT9TLrVN5nI2GU1VBKGDACg4Vkz
Iz7AI++9jKcEF79KrY/7rG0=
=geXb
-----END PGP SIGNATURE-----




