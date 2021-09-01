Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Date: Wed, 1 Sep 2021 22:12:53 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: Re: Dynamic DHCP server assignment and spin-up on batman-adv mesh
 network
Message-ID: <YS/exTf/6NOMuH5N@sellars>
References: <20210831172841.1195.74688@diktynna.open-mesh.org>
 <YS/afIp1Lrc4JNvv@sellars>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YS/afIp1Lrc4JNvv@sellars>
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Wed, Sep 01, 2021 at 09:54:36PM +0200, Linus L=C3=BCssing wrote:
> On Tue, Aug 31, 2021 at 05:28:41PM -0000, tanner.perkins@cnftech.com wr=
ote:
> > If this is not the best place to ask questions regarding mesh network=
s utilizing the batman-adv kernel module, I apologies and please point me=
 to where I need to be.
> >=20
> > I'm looking to set up distributed mesh network using the batman-adv L=
inux kernel module. However, I don't want to have to statically assign IP=
 addresses to all my nodes therefore my first thought was to use DHCP. Th=
e problem arises in my scenario that any node could come and go in the me=
sh network as they move in and out range of the network. Therefore manual=
ly allocating a single or even a few DHCP servers isn't realistic as that=
 DHCP server may drop out of the network at anytime. Is there a dynamic w=
ay to reassign the DHCP server based on the nodes still within the networ=
k when the previous DHCP server drops from the network?
>=20
> Tricky question. DHCP was probably not designed with highly
> dynamic networks in mind back then.
>=20
> Typically people run a few DHCP servers on hosts with a high
> availability and not mesh nodes that might go offline at "random"
> times. And then use the batman-adv gateway feature to stear DHCP
> requests to the "best" one [0]. For some topologies people also
> make use of the batman-adv "Bridge Loop Avoidance" [1] feature
> and place the DHCP server(s) on a common LAN backbone to which
> multiple nodes are connected via cable, which can add some
> extra fault tolerance. And maybe set the lease interval to
> something faster then the usual defaults.
>=20
> Someone had also been writing DDHCP, a "Distributed DHCP Daemon" here
> [2] but I'm not sure if it is actually used by anyone at the moment.
> The original idea was to integrate it into the OpenWrt based
> mesh routing framework "Gluon" [3], so that every node would be a
> DHCP server for all its locally connected client devices and the
> DHCP requests from the client devices would be filtered from
> entering the mesh directly. And the DDHCP servers would
> organize leases among themselves. But there hasn't been a PR for
> Gluon yet. But it was tested (and developed) at Freifunk Kiel
> at some point. If you were to try it out, I'd be very interested to hea=
r
> what your experiences with it are.
>=20
> Next there is also AHCP [4] which was built for/with BABEL I
> think. But don't know how it actually works and if it could be
> useful on layer 2 at all or if it is only usable with a layer 3
> mesh routing protocol.
>=20
> Regards, Linus
>=20
> [0]: https://www.open-mesh.org/projects/batman-adv/wiki/Gateways
> [2]: https://github.com/sargon/ddhcpd
> [3]: https://www.open-mesh.org/projects/batman-adv/wiki/Bridge-loop-avo=
idance-II#Situation
> [4]: https://www.irif.fr/~jch/software/ahcp/

Sorry, links and numberings are off, should have been:

[0]: https://www.open-mesh.org/projects/batman-adv/wiki/Gateways
[1]: https://www.open-mesh.org/projects/batman-adv/wiki/Bridge-loop-avoid=
ance-II#Situation
[2]: https://github.com/sargon/ddhcpd
[3]: https://github.com/freifunk-gluon/gluon/
[4]: https://www.irif.fr/~jch/software/ahcp/
