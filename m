Return-Path: <nicoechaniz@altermundi.net>
Message-ID: <5149BD24.20405@altermundi.net>
Date: Wed, 20 Mar 2013 10:44:04 -0300
From: =?ISO-8859-1?Q?NicoEch=E1niz?= <nicoechaniz@altermundi.net>
MIME-Version: 1.0
References: <5148D0CB.3090907@altermundi.net> <20130320113554.GB30638@lunn.ch>
In-Reply-To: <20130320113554.GB30638@lunn.ch>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Multiple border gateways between bat-networks
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On 03/20/2013 08:35 AM, Andrew Lunn wrote:
> On Tue, Mar 19, 2013 at 09:55:39PM +0100, Gui Iribarren wrote:
>> Hey folks!
>> today we bring you a riddle to start the week
>> /me grins...
>>
>> First, some clues:
>> http://comments.gmane.org/gmane.org.freifunk.batman/6603
>> http://www.open-mesh.org/projects/open-mesh/wiki/FAQ#How-do-I-announce-I=
P-subnets-using-batman-adv
>>
>> now, given the attached diagram .png
>>
>>  * the description given in the wiki still applies, i.e. A, B, C...
>> nodes run your favourite layer3 dynamic routing protocol, and all
>> nodes run batman, in segmented (colored) clouds =3D subnets.
>>  * i am one of the clients connected to F
>>  * in the blue cloud, there's one preferred gw_mode=3Dserver which is
>> D (or E for that matter, but certainly not F or G)
>>  * D gave me a DHCP OFFER and since then is my default gw, which i
>> use to access the internet. I have no other routes setup.
>>  * the violet link G <-> H although it looks "long" is in fact a
>> superb link, 0% packet loss, high bw. F <-> G also works great.
>>
>> Now, i want to send a file to H. Visibly, the optimal route would be
>> F -> G -> H.
>> BUT, i only have a default gw, which is D. I pass the packet to D.
>> Thanks to the layer3 routing protocol, D knows that both E and G
>> have access to the red network.  However, E is closer so it relays
>> the packet there,
>=20
> Hi Gui
>=20
> So D, E, G and H are L3 routers. I'm assuming they all know of each
> other in terms of L3 routing protocol. They are all speaking OSPF or
> something.
>=20
> At L3, there are two sensible routes F->E->H and F->G->H. Both are two
> L3 hops, so if you are going on plain number of hops, you have a 50/50
> chance of taking G->H.=20
>=20
> However, OSPF is not really hop based. You assign costs to each
> link. Higher bandwidth links have lower cost. OSPF will optimize the
> cost. So if the total cost of F-G->H is lower than F->E->H, it will
> take that route.
>=20
> Set the cost correct in the L3 routing protocol.

Hi andrew,

AFAIK, this cost you set at the L3 protocol level won't be accurate for
all members of the network. It's a matter of perspective. From the
perspective of the gw, one border gw might be better to get to another
segment (less real -wifi- hops involved), and this will be OK for
clients that are near this gw.
But if you are connecting to this gw from a distant node, the preferred
border gw will probably be a bad choice for you and you won't even get
the 50/50 chance because of the different cost assigned.

We found this to be a tricky problem and we are wondering how other
networks that implement batman-adv as their main dynamic routing
protocol are coping with it.

The provided graphic does not really stress the problem. With linear
segments "touching" at both ends it gets critical. A client connected
near one end might be sending traffic to the neighboring segment through
the other end, traversing all the network just because the wrong
decision is being made as to what's the best border gw for that
particular client to that destination. This could be a common scenario
in the DeltaLibre network, that is composed of many linear segments
along the rivers.


Cheers,
NicoEch=E1niz












