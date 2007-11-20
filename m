Message-ID: <4742F59B.7000606@memespace.net>
Date: Tue, 20 Nov 2007 15:56:27 +0100
From: Sebastian Hagen <sebastian_hagen@memespace.net>
MIME-Version: 1.0
Subject: [B.A.T.M.A.N.] problem starting batmand (v799)
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
To: b.a.t.m.a.n@open-mesh.net

Hello *,

I'm the author of the mipip olsrd patch mentioned by rene. The olsrd code
was very close to doing the Right Thing (see below), my patch just fixed a
few minor internal API issues that prevented it from working out correctly.

I haven't seriously looked at the b.a.t.m.a.n. code, so I don't know exactly
why it's causing problems for rene.

Axel Neumann wrote:
> IMO that does only work if the interfaces of a node are NOT connected to the 
> same physical/logical link (e.g. B1 and B2 are operating on different 
> channels or with different cell IDs,...). Otherwise specifying the outgoing 
> interface is not enough. Even if node A has only one interface (A1). If there 
> is a link A1<->B1 and a link A1<->B2 the problem remains:
>> > How could it set up the routing table to ensure that a packet
>> > to a distant node C should be routed via B1 (and NOT via B2)?
> The outgoing interface of node A is A1, for both cases. Setting the outgoing 
> interface to A1 has no effect. 
> 
> Maybe there is a way to configure the next-hop-mac address instead of the 
> next-hop-ip address. But then you rather have layer 2 routing and not layer 
> 3.
This is an interesting case. You're correct that in this configuration, a l3
routing daemon on A can't make a deliberate choice of which interface of B
to send data to. This is obviously suboptimal, and should be avoided.

However, there are plenty of cases where this will predictably not occur.
For instance, in the opennet mesh network in Rostock, we have quite a lot of
nodes which have one wired interface and one wireless interface, both of
which are used for communication with other nodes in the mesh cloud.
Assigning separate IP addresses to the different interfaces on those nodes
would be wasteful of our address space.

Imo, the choice whether to assign different IP addresses to the different
interfaces on a specific meshnode should ideally lie with the (hopefully
competent) network admins, and routing daemons should decently support
either configuration, with the implicit understanding that having different
interfaces a) in the same broadcast domain AND b) with the same IP addresses
may lead to silent performance degradation.
That's what the newer versions of olsrd do.

Regards,
Sebastian Hagen
