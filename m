Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Subject: Re: Dynamic DHCP server assignment and spin-up on batman-adv mesh
 network
References: <20210831172841.1195.74688@diktynna.open-mesh.org>
From: Steve Newcomb <srn@coolheads.com>
Message-ID: <c323a80b-b663-05fa-33b2-9a545ff2676c@coolheads.com>
Date: Thu, 2 Sep 2021 09:02:31 -0400
MIME-Version: 1.0
In-Reply-To: <20210831172841.1195.74688@diktynna.open-mesh.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Reply-To: srn@coolheads.com,
 The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org



On 8/31/21 1:28 PM, tanner.perkins@cnftech.com wrote:
> I don't want to have to statically assign IP addresses to all my nodes =
therefore my first thought was to use DHCP. The problem arises in my scen=
ario that any node could come and go in the mesh network as they move in =
and out range of the network. Therefore manually allocating a single or e=
ven a few DHCP servers isn't realistic as that DHCP server may drop out o=
f the network at anytime. Is there a dynamic way to reassign the DHCP ser=
ver based on the nodes still within the network when the previous DHCP se=
rver drops from the network?
After trying everything to cope with reliability problems that ensued=20
when I attempted to assign MAC addresses to the mesh radios, I=20
ultimately found myself forced to adopt a hybrid (partly-static and=20
partly-dynamic) approach.=C2=A0 At last I have reliable performance, but =
I=20
was unable to avoid the bookkeeping involved in knowing the MAC address=20
of each batman radio, and the IP I had statically assigned to it.

(Aside: The native MAC address of a 5 GHz radio in an Archer A7 or C7 is=20
evidently an emergent property.=C2=A0 If you assign a different one, the =
mesh=20
will work for a while, and then die mysteriously. Perhaps this has to do=20
with the fact that the hardware in combination with the stock QCA=20
firmware is running an 802.11s network, and BATMAN is running on top of=20
that 802.11s network. Maybe if you just use the hardware's native MAC,=20
the two implementations don't clash over the question of what the MAC=20
address is.=C2=A0 That's a guess.=C2=A0 Anyway, it works quite well that =
way, but=20
not the other way.)

As annoying as the bookkeeping is, it's do-able, and one does have to=20
set the credentials of each node in any event; it's just another tiny=20
chore to configure each node.=C2=A0 I've now scripted whole configuration=
=20
issue in self-defense, because it takes too much mental energy to think=20
each node through individually and then debug it.

The dynamic part is that each 2.4 GHz radio can administer its own LAN,=20
providing its own independent DHCP server.=C2=A0 Originally I had a singl=
e=20
DHCP server for the whole mesh (actually for several meshes), but this=20
proved impractical over the long term.=C2=A0 More to the point, I had no=20
choice but to make each node's LAN self-sufficient, because only then=20
could I go near where a mysteriously offline node was, near some=20
building to which I had no access, and then reliably get into the node=20
and find out what happened via 2.4 GHz wifi in the normal way (which for=20
me is an ssh tunnel).

Steve Newcomb
