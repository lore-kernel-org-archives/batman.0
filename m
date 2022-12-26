Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH v2 3/5] batman-adv: mcast: implement multicast packet
 reception and forwarding
Date: Mon, 26 Dec 2022 19:00:40 +0100
Message-ID: <2115875.PYKUYFuaPT@sven-l14>
In-Reply-To: <20221226161554.9657-4-linus.luessing@c0d3.blue>
References: <20221226161554.9657-1-linus.luessing@c0d3.blue>
 <20221226161554.9657-4-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart21918037.EfDdHjke4D";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>

 
--nextPart21918037.EfDdHjke4D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Date: Mon, 26 Dec 2022 19:00:40 +0100
Message-ID: <2115875.PYKUYFuaPT@sven-l14>
In-Reply-To: <20221226161554.9657-4-linus.luessing@c0d3.blue>
MIME-Version: 1.0

On Monday, 26 December 2022 17:15:52 CET Linus L=C3=BCssing wrote:
> Implement functionality to receive and forward a new TVLV capable
> multicast packet type.
>=20
> The new batman-adv multicast packet type allows to contain several
> originator destination addresses within a TVLV. Routers on the way will
> potentially split the batman-adv multicast packet and adjust its tracker
> TVLV contents.
>=20
> Routing decisions are still based on the selected BATMAN IV or BATMAN V
> routing algorithm. So this new batman-adv multicast packet type retains
> the same loop-free properties.
>=20
> Also a new OGM multicast TVLV flag is introduced to signal to other
> nodes that we are capable of handling a batman-adv multicast packet and
> multicast tracker TVLV. And that all of our hard interfaces have an MTU
> of at least 1280 bytes (IPv6 minimum MTU), as a simple solution for now
> to avoid MTU issues while forwarding.
>=20
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
> ---
>  include/uapi/linux/batadv_packet.h |  48 +++++-
>  net/batman-adv/Makefile            |   1 +
>  net/batman-adv/main.c              |   2 +
>  net/batman-adv/multicast.c         |  48 +++++-
>  net/batman-adv/multicast.h         |   5 +
>  net/batman-adv/multicast_forw.c    | 268 +++++++++++++++++++++++++++++
>  net/batman-adv/originator.c        |   1 +
>  net/batman-adv/routing.c           |  69 ++++++++
>  net/batman-adv/routing.h           |  11 ++
>  net/batman-adv/soft-interface.c    |  12 ++
>  net/batman-adv/types.h             |  64 +++++++
>  11 files changed, 518 insertions(+), 11 deletions(-)
>  create mode 100644 net/batman-adv/multicast_forw.c

Name of failed tests
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

ecsv/pu
=2D------

 * checkpatch ./net/batman-adv/multicast_forw.c
 * headers
 * sparse linux-4.10 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=3Dy MCAS=
T=3Dy BATMAN_V=3Dy
 * sparse linux-4.10 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=3Dn MCAS=
T=3Dn BATMAN_V=3Dy
 * sparse linux-4.11 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dy NC=3Dy MCAS=
T=3Dy BATMAN_V=3Dn
 * sparse linux-4.11 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=3Dy MCAS=
T=3Dn BATMAN_V=3Dn
 * sparse linux-4.12 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3Dn MCAS=
T=3Dy BATMAN_V=3Dy
 * sparse linux-4.12 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3Dy MCAS=
T=3Dy BATMAN_V=3Dn
 * sparse linux-4.13 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=3Dn MCAS=
T=3Dy BATMAN_V=3Dy
 * sparse linux-4.13 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3Dy MCAS=
T=3Dn BATMAN_V=3Dy
 * sparse linux-4.13 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dn NC=3Dy MCAS=
T=3Dy BATMAN_V=3Dn
 * sparse linux-4.14 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=3Dn MCAS=
T=3Dy BATMAN_V=3Dn
 * sparse linux-4.14 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dy MCAS=
T=3Dn BATMAN_V=3Dn
 * sparse linux-4.14 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=3Dn MCAS=
T=3Dn BATMAN_V=3Dn
 * sparse linux-4.14 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=3Dn MCAS=
T=3Dy BATMAN_V=3Dy
 * sparse linux-4.14 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=3Dy MCAS=
T=3Dn BATMAN_V=3Dn
 * sparse linux-4.14.302 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3Dy =
MCAST=3Dy BATMAN_V=3Dy
 * sparse linux-4.14.302 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dn NC=3Dn =
MCAST=3Dn BATMAN_V=3Dy
 * sparse linux-4.14.302 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dy =
MCAST=3Dy BATMAN_V=3Dn
 * sparse linux-4.15 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=3Dn MCAS=
T=3Dn BATMAN_V=3Dy
 * sparse linux-4.15 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3Dn MCAS=
T=3Dy BATMAN_V=3Dy
 * sparse linux-4.15 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3Dy MCAS=
T=3Dy BATMAN_V=3Dn
 * sparse linux-4.15 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=3Dy MCAS=
T=3Dy BATMAN_V=3Dy
 * sparse linux-4.15 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=3Dy MCAS=
T=3Dn BATMAN_V=3Dy
 * sparse linux-4.15 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dy MCAS=
T=3Dy BATMAN_V=3Dy
 * sparse linux-4.17 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dn MCAS=
T=3Dn BATMAN_V=3Dn
 * sparse linux-4.18 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dy NC=3Dn MCAS=
T=3Dn BATMAN_V=3Dn
 * sparse linux-4.19 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=3Dy MCAS=
T=3Dn BATMAN_V=3Dy
 * sparse linux-4.19 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3Dn MCAS=
T=3Dn BATMAN_V=3Dy
 * sparse linux-4.19 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=3Dn MCAS=
T=3Dy BATMAN_V=3Dn
 * sparse linux-4.19.269 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=3Dy =
MCAST=3Dy BATMAN_V=3Dn
 * sparse linux-4.19.269 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dy NC=3Dy =
MCAST=3Dn BATMAN_V=3Dy
 * sparse linux-4.19.269 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dy =
MCAST=3Dn BATMAN_V=3Dy
 * sparse linux-4.20 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dn NC=3Dy MCAS=
T=3Dy BATMAN_V=3Dn
 * sparse linux-4.20 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dn NC=3Dn MCAS=
T=3Dy BATMAN_V=3Dy
 * sparse linux-4.20 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dn MCAS=
T=3Dn BATMAN_V=3Dy
 * sparse linux-4.9 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=3Dn MCAST=
=3Dy BATMAN_V=3Dy
 * sparse linux-4.9 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=3Dy MCAST=
=3Dn BATMAN_V=3Dy
 * sparse linux-4.9 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3Dn MCAST=
=3Dy BATMAN_V=3Dn
 * sparse linux-4.9.336 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dy M=
CAST=3Dn BATMAN_V=3Dy
 * sparse linux-5.0 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dn NC=3Dy MCAST=
=3Dy BATMAN_V=3Dn
 * sparse linux-5.0 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=3Dy MCAST=
=3Dy BATMAN_V=3Dy
 * sparse linux-5.0 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3Dn MCAST=
=3Dn BATMAN_V=3Dn
 * sparse linux-5.1 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dy MCAST=
=3Dn BATMAN_V=3Dn
 * sparse linux-5.1 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dn NC=3Dy MCAST=
=3Dy BATMAN_V=3Dy
 * sparse linux-5.10 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dn MCAS=
T=3Dn BATMAN_V=3Dy
 * sparse linux-5.10.159 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=3Dn =
MCAST=3Dy BATMAN_V=3Dn
 * sparse linux-5.10.159 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=3Dy =
MCAST=3Dy BATMAN_V=3Dn
 * sparse linux-5.10.159 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=3Dn =
MCAST=3Dy BATMAN_V=3Dy
 * sparse linux-5.10.159 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3Dn =
MCAST=3Dy BATMAN_V=3Dy
 * sparse linux-5.11 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dy NC=3Dn MCAS=
T=3Dn BATMAN_V=3Dn
 * sparse linux-5.12 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=3Dn MCAS=
T=3Dy BATMAN_V=3Dn
 * sparse linux-5.12 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=3Dy MCAS=
T=3Dn BATMAN_V=3Dn
 * sparse linux-5.12 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=3Dn MCAS=
T=3Dn BATMAN_V=3Dn
 * sparse linux-5.13 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=3Dn MCAS=
T=3Dy BATMAN_V=3Dn
 * sparse linux-5.13 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=3Dn MCAS=
T=3Dy BATMAN_V=3Dn
 * sparse linux-5.13 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=3Dn MCAS=
T=3Dy BATMAN_V=3Dy
 * sparse linux-5.13 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=3Dy MCAS=
T=3Dn BATMAN_V=3Dy
 * sparse linux-5.13 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=3Dn MCAS=
T=3Dn BATMAN_V=3Dy
 * sparse linux-5.13 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dn MCAS=
T=3Dn BATMAN_V=3Dn
 * sparse linux-5.14 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dy NC=3Dn MCAS=
T=3Dn BATMAN_V=3Dn
 * sparse linux-5.15 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=3Dn MCAS=
T=3Dn BATMAN_V=3Dy
 * sparse linux-5.15 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3Dn MCAS=
T=3Dy BATMAN_V=3Dy
 * sparse linux-5.15 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dy MCAS=
T=3Dy BATMAN_V=3Dy
 * sparse linux-5.15.83 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=3Dn M=
CAST=3Dy BATMAN_V=3Dy
 * sparse linux-5.15.83 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=3Dn M=
CAST=3Dn BATMAN_V=3Dy
 * sparse linux-5.15.83 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dn NC=3Dy M=
CAST=3Dn BATMAN_V=3Dn
 * sparse linux-5.16 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dn NC=3Dy MCAS=
T=3Dy BATMAN_V=3Dy
 * sparse linux-5.16 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dy NC=3Dn MCAS=
T=3Dn BATMAN_V=3Dy
 * sparse linux-5.16 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dn NC=3Dn MCAS=
T=3Dn BATMAN_V=3Dn
 * sparse linux-5.16 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dn MCAS=
T=3Dy BATMAN_V=3Dn
 * sparse linux-5.16 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dy MCAS=
T=3Dn BATMAN_V=3Dy
 * sparse linux-5.17 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=3Dn MCAS=
T=3Dy BATMAN_V=3Dn
 * sparse linux-5.17 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3Dy MCAS=
T=3Dn BATMAN_V=3Dn
 * sparse linux-5.18 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dn MCAS=
T=3Dy BATMAN_V=3Dy
 * sparse linux-5.19 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3Dn MCAS=
T=3Dy BATMAN_V=3Dy
 * sparse linux-5.2 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=3Dy MCAST=
=3Dn BATMAN_V=3Dn
 * sparse linux-5.2 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dy NC=3Dy MCAST=
=3Dn BATMAN_V=3Dn
 * sparse linux-5.2 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=3Dy MCAST=
=3Dn BATMAN_V=3Dy
 * sparse linux-5.2 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3Dn MCAST=
=3Dn BATMAN_V=3Dy
 * sparse linux-5.3 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=3Dy MCAST=
=3Dy BATMAN_V=3Dy
 * sparse linux-5.3 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=3Dy MCAST=
=3Dn BATMAN_V=3Dy
 * sparse linux-5.4 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=3Dy MCAST=
=3Dn BATMAN_V=3Dn
 * sparse linux-5.4 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dy MCAST=
=3Dn BATMAN_V=3Dy
 * sparse linux-5.4 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=3Dn MCAST=
=3Dy BATMAN_V=3Dy
 * sparse linux-5.4 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=3Dy MCAST=
=3Dn BATMAN_V=3Dn
 * sparse linux-5.4.227 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=3Dy M=
CAST=3Dn BATMAN_V=3Dn
 * sparse linux-5.4.227 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dy NC=3Dn M=
CAST=3Dy BATMAN_V=3Dn
 * sparse linux-5.4.227 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=3Dn M=
CAST=3Dn BATMAN_V=3Dy
 * sparse linux-5.4.227 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=3Dn M=
CAST=3Dy BATMAN_V=3Dy
 * sparse linux-5.5 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3Dn MCAST=
=3Dy BATMAN_V=3Dn
 * sparse linux-5.5 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dn MCAST=
=3Dy BATMAN_V=3Dn
 * sparse linux-5.6 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=3Dn MCAST=
=3Dn BATMAN_V=3Dy
 * sparse linux-5.6 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=3Dn MCAST=
=3Dy BATMAN_V=3Dn
 * sparse linux-5.6 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=3Dn MCAST=
=3Dy BATMAN_V=3Dy
 * sparse linux-5.6 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=3Dn MCAST=
=3Dy BATMAN_V=3Dn
 * sparse linux-5.6 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dn MCAST=
=3Dy BATMAN_V=3Dy
 * sparse linux-5.7 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=3Dy MCAST=
=3Dy BATMAN_V=3Dy
 * sparse linux-5.7 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=3Dy MCAST=
=3Dn BATMAN_V=3Dy
 * sparse linux-5.7 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dn MCAST=
=3Dn BATMAN_V=3Dy
 * sparse linux-5.7 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=3Dy MCAST=
=3Dn BATMAN_V=3Dy
 * sparse linux-5.7 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dn NC=3Dn MCAST=
=3Dn BATMAN_V=3Dy
 * sparse linux-5.8 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=3Dy MCAST=
=3Dy BATMAN_V=3Dy
 * sparse linux-5.8 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dn MCAST=
=3Dn BATMAN_V=3Dy
 * sparse linux-5.8 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=3Dn MCAST=
=3Dn BATMAN_V=3Dn
 * sparse linux-5.8 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=3Dy MCAST=
=3Dn BATMAN_V=3Dy
 * sparse linux-5.9 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dn NC=3Dn MCAST=
=3Dy BATMAN_V=3Dy
 * sparse linux-6.0 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=3Dy MCAST=
=3Dn BATMAN_V=3Dn
 * sparse linux-6.0 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=3Dn MCAST=
=3Dn BATMAN_V=3Dy
 * sparse linux-6.0.13 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=3Dn MC=
AST=3Dy BATMAN_V=3Dn
 * sparse linux-6.0.13 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dy NC=3Dn MC=
AST=3Dy BATMAN_V=3Dn
 * sparse linux-6.0.13 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3Dn MC=
AST=3Dy BATMAN_V=3Dy
 * sparse linux-6.1 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dy NC=3Dy MCAST=
=3Dn BATMAN_V=3Dn
 * sparse linux-6.1 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=3Dn MCAST=
=3Dn BATMAN_V=3Dn
 * sparse linux-6.1 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3Dy MCAST=
=3Dy BATMAN_V=3Dn
 * unused_symbols linux-4.10 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=
=3Dy MCAST=3Dy BATMAN_V=3Dy
 * unused_symbols linux-4.11 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dy NC=
=3Dy MCAST=3Dy BATMAN_V=3Dn
 * unused_symbols linux-4.11 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=
=3Dy MCAST=3Dn BATMAN_V=3Dn
 * unused_symbols linux-4.12 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=
=3Dy MCAST=3Dy BATMAN_V=3Dn
 * unused_symbols linux-4.13 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=
=3Dy MCAST=3Dn BATMAN_V=3Dy
 * unused_symbols linux-4.13 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dn NC=
=3Dy MCAST=3Dy BATMAN_V=3Dn
 * unused_symbols linux-4.14 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=
=3Dy MCAST=3Dn BATMAN_V=3Dn
 * unused_symbols linux-4.14 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=
=3Dy MCAST=3Dn BATMAN_V=3Dn
 * unused_symbols linux-4.14.302 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dn=
 NC=3Dy MCAST=3Dy BATMAN_V=3Dy
 * unused_symbols linux-4.14.302 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dy=
 NC=3Dy MCAST=3Dy BATMAN_V=3Dn
 * unused_symbols linux-4.15 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=
=3Dy MCAST=3Dy BATMAN_V=3Dn
 * unused_symbols linux-4.15 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=
=3Dy MCAST=3Dy BATMAN_V=3Dy
 * unused_symbols linux-4.15 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=
=3Dy MCAST=3Dn BATMAN_V=3Dy
 * unused_symbols linux-4.15 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=
=3Dy MCAST=3Dy BATMAN_V=3Dy
 * unused_symbols linux-4.19 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=
=3Dy MCAST=3Dn BATMAN_V=3Dy
 * unused_symbols linux-4.19.269 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dy=
 NC=3Dy MCAST=3Dy BATMAN_V=3Dn
 * unused_symbols linux-4.19.269 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dy=
 NC=3Dy MCAST=3Dn BATMAN_V=3Dy
 * unused_symbols linux-4.19.269 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dy=
 NC=3Dy MCAST=3Dn BATMAN_V=3Dy
 * unused_symbols linux-4.20 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dn NC=
=3Dy MCAST=3Dy BATMAN_V=3Dn
 * unused_symbols linux-4.9 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=
=3Dy MCAST=3Dn BATMAN_V=3Dy
 * unused_symbols linux-4.9.336 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dy =
NC=3Dy MCAST=3Dn BATMAN_V=3Dy
 * unused_symbols linux-5.0 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dn NC=
=3Dy MCAST=3Dy BATMAN_V=3Dn
 * unused_symbols linux-5.0 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=
=3Dy MCAST=3Dy BATMAN_V=3Dy
 * unused_symbols linux-5.1 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=
=3Dy MCAST=3Dn BATMAN_V=3Dn
 * unused_symbols linux-5.1 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dn NC=
=3Dy MCAST=3Dy BATMAN_V=3Dy
 * unused_symbols linux-5.10.159 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dn=
 NC=3Dy MCAST=3Dy BATMAN_V=3Dn
 * unused_symbols linux-5.12 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=
=3Dy MCAST=3Dn BATMAN_V=3Dn
 * unused_symbols linux-5.13 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=
=3Dy MCAST=3Dn BATMAN_V=3Dy
 * unused_symbols linux-5.15 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=
=3Dy MCAST=3Dy BATMAN_V=3Dy
 * unused_symbols linux-5.15.83 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dn =
NC=3Dy MCAST=3Dn BATMAN_V=3Dn
 * unused_symbols linux-5.16 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dn NC=
=3Dy MCAST=3Dy BATMAN_V=3Dy
 * unused_symbols linux-5.16 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=
=3Dy MCAST=3Dn BATMAN_V=3Dy
 * unused_symbols linux-5.17 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=
=3Dy MCAST=3Dn BATMAN_V=3Dn
 * unused_symbols linux-5.2 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=
=3Dy MCAST=3Dn BATMAN_V=3Dn
 * unused_symbols linux-5.2 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dy NC=
=3Dy MCAST=3Dn BATMAN_V=3Dn
 * unused_symbols linux-5.2 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=
=3Dy MCAST=3Dn BATMAN_V=3Dy
 * unused_symbols linux-5.3 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=
=3Dy MCAST=3Dy BATMAN_V=3Dy
 * unused_symbols linux-5.3 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=
=3Dy MCAST=3Dn BATMAN_V=3Dy
 * unused_symbols linux-5.4 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=
=3Dy MCAST=3Dn BATMAN_V=3Dn
 * unused_symbols linux-5.4 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=
=3Dy MCAST=3Dn BATMAN_V=3Dy
 * unused_symbols linux-5.4 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=
=3Dy MCAST=3Dn BATMAN_V=3Dn
 * unused_symbols linux-5.4.227 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dn =
NC=3Dy MCAST=3Dn BATMAN_V=3Dn
 * unused_symbols linux-5.7 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=
=3Dy MCAST=3Dy BATMAN_V=3Dy
 * unused_symbols linux-5.7 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=
=3Dy MCAST=3Dn BATMAN_V=3Dy
 * unused_symbols linux-5.7 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=
=3Dy MCAST=3Dn BATMAN_V=3Dy
 * unused_symbols linux-5.8 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=
=3Dy MCAST=3Dy BATMAN_V=3Dy
 * unused_symbols linux-5.8 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=
=3Dy MCAST=3Dn BATMAN_V=3Dy
 * unused_symbols linux-6.0 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=
=3Dy MCAST=3Dn BATMAN_V=3Dn
 * unused_symbols linux-6.1 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dy NC=
=3Dy MCAST=3Dn BATMAN_V=3Dn
 * unused_symbols linux-6.1 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=
=3Dy MCAST=3Dy BATMAN_V=3Dn


Output of different failed tests
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

ecsv/pu: checkpatch ./net/batman-adv/multicast_forw.c
=2D----------------------------------------------------

    CHECK: Macro argument reuse 'num_dests' - possible side-effects?
    #19: FILE: ./net/batman-adv/multicast_forw.c:19:
    +#define batadv_mcast_forw_tracker_for_each_dest(dest, num_dests) \
    +   for (; num_dests; num_dests--, (dest) +=3D ETH_ALEN)
   =20
    total: 0 errors, 0 warnings, 1 checks, 268 lines checked

ecsv/pu: headers
=2D---------------

    diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
    index 9db1c5d0..44ad5c38 100644
    --- a/net/batman-adv/multicast.c
    +++ b/net/batman-adv/multicast.c
    @@ -26,7 +26,6 @@
     #include <linux/ipv6.h>
     #include <linux/jiffies.h>
     #include <linux/kernel.h>
    -#include <linux/kref.h>
     #include <linux/list.h>
     #include <linux/lockdep.h>
     #include <linux/netdevice.h>
    diff --git a/net/batman-adv/multicast_forw.c b/net/batman-adv/multicast=
_forw.c
    index 291a5217..6be33781 100644
    --- a/net/batman-adv/multicast_forw.c
    +++ b/net/batman-adv/multicast_forw.c
    @@ -6,11 +6,16 @@
    =20
     #include "main.h" // IWYU pragma: keep
    =20
    +#include <linux/byteorder/generic.h>
    +#include <linux/errno.h>
     #include <linux/etherdevice.h>
    +#include <linux/gfp.h>
     #include <linux/if_ether.h>
     #include <linux/netdevice.h>
     #include <linux/skbuff.h>
    +#include <linux/stddef.h>
     #include <linux/types.h>
    +#include <uapi/linux/batadv_packet.h>
    =20
     #include "originator.h"
     #include "routing.h"
    diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
    index 0ecb86b3..eb905740 100644
    --- a/net/batman-adv/routing.c
    +++ b/net/batman-adv/routing.c
    @@ -30,7 +30,6 @@
     #include "fragmentation.h"
     #include "hard-interface.h"
     #include "log.h"
    -#include "multicast.h"
     #include "network-coding.h"
     #include "originator.h"
     #include "send.h"
    diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-inte=
rface.c
    index e94f2e6e..262ca19e 100644
    --- a/net/batman-adv/soft-interface.c
    +++ b/net/batman-adv/soft-interface.c
    @@ -48,7 +48,6 @@
     #include "hard-interface.h"
     #include "multicast.h"
     #include "network-coding.h"
    -#include "originator.h"
     #include "send.h"
     #include "translation-table.h"
    =20
    diff --git a/net/batman-adv/tvlv.h b/net/batman-adv/tvlv.h
    index d1c4e072..743688d1 100644
    --- a/net/batman-adv/tvlv.h
    +++ b/net/batman-adv/tvlv.h
    @@ -9,6 +9,7 @@
    =20
     #include "main.h" // IWYU pragma: keep
    =20
    +#include <linux/skbuff.h>
     #include <linux/types.h>
     #include <uapi/linux/batadv_packet.h>

ecsv/pu: sparse linux-4.10 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=3D=
y MCAST=3Dy BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/multicast_forw=
=2Ec:264:5: warning: symbol 'batadv_mcast_forw_tracker_tvlv_handler' was no=
t declared. Should it be static?
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44: warning: incorrect type in argument 4 (different base types)
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44:    expected int ( *mptr )( ... )
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44:    got int
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:37: error: not enough arguments for function batadv_tvlv_handler_r=
egister
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:295: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:553: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1490: _module_/home/build_test/build_env/tmp.LI6=
=46iYuwbR] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-4.10 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=3D=
n MCAST=3Dn BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:26:=
 error: Expected ; at end of statement
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:26:=
 error: got int
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:17:=
 error: undefined identifier 'u8'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:21:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:398:17:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:401:64:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:17:=
 error: undefined identifier 'unsigned'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:413:17:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:414:45:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:415:47:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    make[3]: *** [scripts/Makefile.build:295: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:553: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1490: _module_/home/build_test/build_env/tmp.LI6=
=46iYuwbR] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-4.11 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dy NC=3D=
y MCAST=3Dy BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/multicast_forw=
=2Ec:264:5: warning: symbol 'batadv_mcast_forw_tracker_tvlv_handler' was no=
t declared. Should it be static?
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44: warning: incorrect type in argument 4 (different base types)
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44:    expected int ( *mptr )( ... )
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44:    got int
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:37: error: not enough arguments for function batadv_tvlv_handler_r=
egister
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:295: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:553: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1492: _module_/home/build_test/build_env/tmp.LI6=
=46iYuwbR] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-4.11 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=3D=
y MCAST=3Dn BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44: warning: incorrect type in argument 4 (different base types)
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44:    expected int ( *mptr )( ... )
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44:    got int
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:37: error: not enough arguments for function batadv_tvlv_handler_r=
egister
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:295: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:553: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1492: _module_/home/build_test/build_env/tmp.LI6=
=46iYuwbR] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-4.12 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3D=
n MCAST=3Dy BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/multicast_forw=
=2Ec:264:5: warning: symbol 'batadv_mcast_forw_tracker_tvlv_handler' was no=
t declared. Should it be static?
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:26:=
 error: Expected ; at end of statement
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:26:=
 error: got int
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:17:=
 error: undefined identifier 'u8'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:21:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:398:17:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:401:64:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:17:=
 error: undefined identifier 'unsigned'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:413:17:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:414:45:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:415:47:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    make[3]: *** [scripts/Makefile.build:303: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:561: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1512: _module_/home/build_test/build_env/tmp.LI6=
=46iYuwbR] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-4.13 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3D=
y MCAST=3Dn BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44: warning: incorrect type in argument 4 (different base types)
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44:    expected int ( *mptr )( ... )
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44:    got int
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:37: error: not enough arguments for function batadv_tvlv_handler_r=
egister
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:303: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:561: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1512: _module_/home/build_test/build_env/tmp.LI6=
=46iYuwbR] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-4.13 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dn NC=3D=
y MCAST=3Dy BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/multicast_forw=
=2Ec:264:5: warning: symbol 'batadv_mcast_forw_tracker_tvlv_handler' was no=
t declared. Should it be static?
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44: warning: incorrect type in argument 4 (different base types)
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44:    expected int ( *mptr )( ... )
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44:    got int
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:37: error: not enough arguments for function batadv_tvlv_handler_r=
egister
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:303: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:561: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1512: _module_/home/build_test/build_env/tmp.LI6=
=46iYuwbR] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-4.14 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3D=
y MCAST=3Dn BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44: warning: incorrect type in argument 4 (different base types)
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44:    expected int ( *mptr )( ... )
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44:    got int
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:37: error: not enough arguments for function batadv_tvlv_handler_r=
egister
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:315: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:573: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1503: _module_/home/build_test/build_env/tmp.LI6=
=46iYuwbR] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-4.14 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=3D=
n MCAST=3Dn BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:26:=
 error: Expected ; at end of statement
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:26:=
 error: got int
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:17:=
 error: undefined identifier 'u8'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:21:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:398:17:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:401:64:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:17:=
 error: undefined identifier 'unsigned'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:413:17:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:414:45:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:415:47:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    make[3]: *** [scripts/Makefile.build:315: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:573: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1503: _module_/home/build_test/build_env/tmp.LI6=
=46iYuwbR] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-4.14 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=3D=
n MCAST=3Dy BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/multicast_forw=
=2Ec:264:5: warning: symbol 'batadv_mcast_forw_tracker_tvlv_handler' was no=
t declared. Should it be static?
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:26:=
 error: Expected ; at end of statement
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:26:=
 error: got int
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:17:=
 error: undefined identifier 'u8'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:21:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:398:17:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:401:64:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:17:=
 error: undefined identifier 'unsigned'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:413:17:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:414:45:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:415:47:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    make[3]: *** [scripts/Makefile.build:315: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:573: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1503: _module_/home/build_test/build_env/tmp.LI6=
=46iYuwbR] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-4.14.302 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dn N=
C=3Dn MCAST=3Dn BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:26:=
 error: Expected ; at end of statement
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:26:=
 error: got int
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:17:=
 error: undefined identifier 'u8'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:21:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:398:17:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:401:64:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:17:=
 error: undefined identifier 'unsigned'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:413:17:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:414:45:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:415:47:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    make[3]: *** [scripts/Makefile.build:330: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:588: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1556: _module_/home/build_test/build_env/tmp.LI6=
=46iYuwbR] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-4.14.302 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dy N=
C=3Dy MCAST=3Dy BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/multicast_forw=
=2Ec:264:5: warning: symbol 'batadv_mcast_forw_tracker_tvlv_handler' was no=
t declared. Should it be static?
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44: warning: incorrect type in argument 4 (different base types)
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44:    expected int ( *mptr )( ... )
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44:    got int
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:37: error: not enough arguments for function batadv_tvlv_handler_r=
egister
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:330: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:588: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1556: _module_/home/build_test/build_env/tmp.LI6=
=46iYuwbR] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-4.15 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=3D=
n MCAST=3Dn BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:26:=
 error: Expected ; at end of statement
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:26:=
 error: got int
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:17:=
 error: undefined identifier 'u8'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:21:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:398:17:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:401:64:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:17:=
 error: undefined identifier 'unsigned'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:413:17:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:414:45:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:415:47:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    make[3]: *** [scripts/Makefile.build:317: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:575: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1508: _module_/home/build_test/build_env/tmp.LI6=
=46iYuwbR] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-4.15 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3D=
n MCAST=3Dy BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/multicast_forw=
=2Ec:264:5: warning: symbol 'batadv_mcast_forw_tracker_tvlv_handler' was no=
t declared. Should it be static?
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:26:=
 error: Expected ; at end of statement
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:26:=
 error: got int
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:17:=
 error: undefined identifier 'u8'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:21:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:398:17:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:401:64:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:17:=
 error: undefined identifier 'unsigned'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:413:17:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:414:45:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:415:47:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    make[3]: *** [scripts/Makefile.build:317: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:575: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1508: _module_/home/build_test/build_env/tmp.LI6=
=46iYuwbR] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-4.15 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3D=
y MCAST=3Dy BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/multicast_forw=
=2Ec:264:5: warning: symbol 'batadv_mcast_forw_tracker_tvlv_handler' was no=
t declared. Should it be static?
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44: warning: incorrect type in argument 4 (different base types)
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44:    expected int ( *mptr )( ... )
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44:    got int
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:37: error: not enough arguments for function batadv_tvlv_handler_r=
egister
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:317: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:575: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1508: _module_/home/build_test/build_env/tmp.LI6=
=46iYuwbR] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-4.15 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=3D=
y MCAST=3Dn BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44: warning: incorrect type in argument 4 (different base types)
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44:    expected int ( *mptr )( ... )
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44:    got int
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:37: error: not enough arguments for function batadv_tvlv_handler_r=
egister
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:317: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:575: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1508: _module_/home/build_test/build_env/tmp.LI6=
=46iYuwbR] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-4.17 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3D=
n MCAST=3Dn BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:26:=
 error: Expected ; at end of statement
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:26:=
 error: got int
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:17:=
 error: undefined identifier 'u8'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:21:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:398:17:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:401:64:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:17:=
 error: undefined identifier 'unsigned'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:413:17:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:414:45:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:415:47:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    make[3]: *** [scripts/Makefile.build:313: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:559: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1571: _module_/home/build_test/build_env/tmp.LI6=
=46iYuwbR] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-4.18 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dy NC=3D=
n MCAST=3Dn BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:26:=
 error: Expected ; at end of statement
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:26:=
 error: got int
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:17:=
 error: undefined identifier 'u8'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:21:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:398:17:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:401:64:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:17:=
 error: undefined identifier 'unsigned'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:413:17:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:414:45:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:415:47:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    make[3]: *** [scripts/Makefile.build:318: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:558: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1500: _module_/home/build_test/build_env/tmp.LI6=
=46iYuwbR] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-4.19 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=3D=
y MCAST=3Dn BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44: warning: incorrect type in argument 4 (different base types)
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44:    expected int ( *mptr )( ... )
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44:    got int
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:37: error: not enough arguments for function batadv_tvlv_handler_r=
egister
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:306: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:546: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1517: _module_/home/build_test/build_env/tmp.LI6=
=46iYuwbR] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-4.19 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3D=
n MCAST=3Dn BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:26:=
 error: Expected ; at end of statement
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:26:=
 error: got int
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:17:=
 error: undefined identifier 'u8'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:21:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:398:17:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:401:64:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:17:=
 error: undefined identifier 'unsigned'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:413:17:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:414:45:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:415:47:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    make[3]: *** [scripts/Makefile.build:306: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:546: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1517: _module_/home/build_test/build_env/tmp.LI6=
=46iYuwbR] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-4.19 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=3D=
n MCAST=3Dy BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/multicast_forw=
=2Ec:264:5: warning: symbol 'batadv_mcast_forw_tracker_tvlv_handler' was no=
t declared. Should it be static?
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:26:=
 error: Expected ; at end of statement
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:26:=
 error: got int
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:17:=
 error: undefined identifier 'u8'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:21:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:398:17:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:401:64:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:17:=
 error: undefined identifier 'unsigned'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:413:17:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:414:45:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:415:47:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    make[3]: *** [scripts/Makefile.build:306: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:546: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1517: _module_/home/build_test/build_env/tmp.LI6=
=46iYuwbR] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-4.19.269 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dy N=
C=3Dy MCAST=3Dy BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/multicast_forw=
=2Ec:264:5: warning: symbol 'batadv_mcast_forw_tracker_tvlv_handler' was no=
t declared. Should it be static?
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44: warning: incorrect type in argument 4 (different base types)
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44:    expected int ( *mptr )( ... )
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44:    got int
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:37: error: not enough arguments for function batadv_tvlv_handler_r=
egister
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:304: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:544: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1551: _module_/home/build_test/build_env/tmp.LI6=
=46iYuwbR] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-4.19.269 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dy N=
C=3Dy MCAST=3Dn BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44: warning: incorrect type in argument 4 (different base types)
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44:    expected int ( *mptr )( ... )
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44:    got int
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:37: error: not enough arguments for function batadv_tvlv_handler_r=
egister
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:304: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:544: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1551: _module_/home/build_test/build_env/tmp.LI6=
=46iYuwbR] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-4.20 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dn NC=3D=
y MCAST=3Dy BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/multicast_forw=
=2Ec:264:5: warning: symbol 'batadv_mcast_forw_tracker_tvlv_handler' was no=
t declared. Should it be static?
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44: warning: incorrect type in argument 4 (different base types)
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44:    expected int ( *mptr )( ... )
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44:    got int
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:37: error: not enough arguments for function batadv_tvlv_handler_r=
egister
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:292: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:516: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1563: _module_/home/build_test/build_env/tmp.LI6=
=46iYuwbR] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-4.20 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dn NC=3D=
n MCAST=3Dy BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/multicast_forw=
=2Ec:264:5: warning: symbol 'batadv_mcast_forw_tracker_tvlv_handler' was no=
t declared. Should it be static?
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:26:=
 error: Expected ; at end of statement
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:26:=
 error: got int
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:17:=
 error: undefined identifier 'u8'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:21:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:398:17:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:401:64:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:17:=
 error: undefined identifier 'unsigned'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:413:17:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:414:45:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:415:47:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    make[3]: *** [scripts/Makefile.build:292: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:516: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1563: _module_/home/build_test/build_env/tmp.LI6=
=46iYuwbR] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-4.20 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3D=
n MCAST=3Dn BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:26:=
 error: Expected ; at end of statement
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:26:=
 error: got int
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:17:=
 error: undefined identifier 'u8'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:21:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:398:17:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:401:64:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:17:=
 error: undefined identifier 'unsigned'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:413:17:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:414:45:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:415:47:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    make[3]: *** [scripts/Makefile.build:292: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:516: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1563: _module_/home/build_test/build_env/tmp.LI6=
=46iYuwbR] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-4.9 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=3Dy=
 MCAST=3Dn BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44: warning: incorrect type in argument 4 (different base types)
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44:    expected int ( *mptr )( ... )
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44:    got int
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:37: error: not enough arguments for function batadv_tvlv_handler_r=
egister
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:294: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:544: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1490: _module_/home/build_test/build_env/tmp.LI6=
=46iYuwbR] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-4.9 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3Dn=
 MCAST=3Dy BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/multicast_forw=
=2Ec:264:5: warning: symbol 'batadv_mcast_forw_tracker_tvlv_handler' was no=
t declared. Should it be static?
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:26:=
 error: Expected ; at end of statement
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:26:=
 error: got int
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:17:=
 error: undefined identifier 'u8'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:21:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:398:17:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:401:64:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:17:=
 error: undefined identifier 'unsigned'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:413:17:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:414:45:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:415:47:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    make[3]: *** [scripts/Makefile.build:294: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:544: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1490: _module_/home/build_test/build_env/tmp.LI6=
=46iYuwbR] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-4.9.336 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=
=3Dy MCAST=3Dn BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44: warning: incorrect type in argument 4 (different base types)
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44:    expected int ( *mptr )( ... )
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44:    got int
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:37: error: not enough arguments for function batadv_tvlv_handler_r=
egister
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:308: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:558: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1544: _module_/home/build_test/build_env/tmp.LI6=
=46iYuwbR] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.0 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dn NC=3Dy=
 MCAST=3Dy BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/multicast_forw=
=2Ec:264:5: warning: symbol 'batadv_mcast_forw_tracker_tvlv_handler' was no=
t declared. Should it be static?
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44: warning: incorrect type in argument 4 (different base types)
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44:    expected int ( *mptr )( ... )
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44:    got int
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:37: error: not enough arguments for function batadv_tvlv_handler_r=
egister
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:277: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:492: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1553: _module_/home/build_test/build_env/tmp.LI6=
=46iYuwbR] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.0 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3Dn=
 MCAST=3Dn BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:26:=
 error: Expected ; at end of statement
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:26:=
 error: got int
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:17:=
 error: undefined identifier 'u8'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:21:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:398:17:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:401:64:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:17:=
 error: undefined identifier 'unsigned'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:413:17:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:414:45:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:415:47:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    make[3]: *** [scripts/Makefile.build:277: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:492: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1553: _module_/home/build_test/build_env/tmp.LI6=
=46iYuwbR] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.1 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dy=
 MCAST=3Dn BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44: warning: incorrect type in argument 4 (different base types)
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44:    expected int ( *mptr )( ... )
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44:    got int
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:37: error: not enough arguments for function batadv_tvlv_handler_r=
egister
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:276: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:486: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1571: _module_/home/build_test/build_env/tmp.LI6=
=46iYuwbR] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.1 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dn NC=3Dy=
 MCAST=3Dy BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/multicast_forw=
=2Ec:264:5: warning: symbol 'batadv_mcast_forw_tracker_tvlv_handler' was no=
t declared. Should it be static?
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44: warning: incorrect type in argument 4 (different base types)
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44:    expected int ( *mptr )( ... )
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44:    got int
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:37: error: not enough arguments for function batadv_tvlv_handler_r=
egister
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:276: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:486: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1571: _module_/home/build_test/build_env/tmp.LI6=
=46iYuwbR] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.10 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3D=
n MCAST=3Dn BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:398:7: =
warning: this statement may fall through [-Wimplicit-fallthrough=3D]
       src =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->src;
       ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:404:2: =
note: here
      case BATADV_MCAST:
      ^~~~
    make[3]: *** [scripts/Makefile.build:279: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:496: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1805: /home/build_test/build_env/tmp.LI6FiYuwbR]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.10.159 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dn N=
C=3Dn MCAST=3Dy BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/multicast_forw=
=2Ec:264:5: warning: symbol 'batadv_mcast_forw_tracker_tvlv_handler' was no=
t declared. Should it be static?
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:398:7: =
warning: this statement may fall through [-Wimplicit-fallthrough=3D]
       src =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->src;
       ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:404:2: =
note: here
      case BATADV_MCAST:
      ^~~~
    make[3]: *** [scripts/Makefile.build:286: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:503: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1837: /home/build_test/build_env/tmp.LI6FiYuwbR]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.10.159 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dn N=
C=3Dy MCAST=3Dy BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/multicast_forw=
=2Ec:264:5: warning: symbol 'batadv_mcast_forw_tracker_tvlv_handler' was no=
t declared. Should it be static?
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:286: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:503: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1837: /home/build_test/build_env/tmp.LI6FiYuwbR]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.11 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dy NC=3D=
n MCAST=3Dn BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:398:7: =
warning: this statement may fall through [-Wimplicit-fallthrough=3D]
       src =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->src;
       ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:404:2: =
note: here
      case BATADV_MCAST:
      ^~~~
    make[3]: *** [scripts/Makefile.build:279: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:496: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1800: /home/build_test/build_env/tmp.LI6FiYuwbR]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.12 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=3D=
n MCAST=3Dy BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/multicast_forw=
=2Ec:264:5: warning: symbol 'batadv_mcast_forw_tracker_tvlv_handler' was no=
t declared. Should it be static?
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:398:7: =
warning: this statement may fall through [-Wimplicit-fallthrough=3D]
       src =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->src;
       ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:404:2: =
note: here
      case BATADV_MCAST:
      ^~~~
    make[3]: *** [scripts/Makefile.build:271: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:514: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1851: /home/build_test/build_env/tmp.LI6FiYuwbR]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.12 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=3D=
y MCAST=3Dn BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:271: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:514: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1851: /home/build_test/build_env/tmp.LI6FiYuwbR]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.12 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=3D=
n MCAST=3Dn BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:398:7: =
warning: this statement may fall through [-Wimplicit-fallthrough=3D]
       src =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->src;
       ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:404:2: =
note: here
      case BATADV_MCAST:
      ^~~~
    make[3]: *** [scripts/Makefile.build:271: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:514: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1851: /home/build_test/build_env/tmp.LI6FiYuwbR]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.13 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=3D=
n MCAST=3Dy BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/multicast_forw=
=2Ec:264:5: warning: symbol 'batadv_mcast_forw_tracker_tvlv_handler' was no=
t declared. Should it be static?
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:398:7: =
warning: this statement may fall through [-Wimplicit-fallthrough=3D]
       src =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->src;
       ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:404:2: =
note: here
      case BATADV_MCAST:
      ^~~~
    make[3]: *** [scripts/Makefile.build:272: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:515: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1847: /home/build_test/build_env/tmp.LI6FiYuwbR]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.13 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=3D=
y MCAST=3Dn BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:272: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:515: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1847: /home/build_test/build_env/tmp.LI6FiYuwbR]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.13 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=3D=
n MCAST=3Dn BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:398:7: =
warning: this statement may fall through [-Wimplicit-fallthrough=3D]
       src =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->src;
       ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:404:2: =
note: here
      case BATADV_MCAST:
      ^~~~
    make[3]: *** [scripts/Makefile.build:272: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:515: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1847: /home/build_test/build_env/tmp.LI6FiYuwbR]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.15 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=3D=
n MCAST=3Dn BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:398:7: =
warning: this statement may fall through [-Wimplicit-fallthrough=3D]
       src =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->src;
       ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:404:2: =
note: here
      case BATADV_MCAST:
      ^~~~
    make[3]: *** [scripts/Makefile.build:277: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:540: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1868: /home/build_test/build_env/tmp.LI6FiYuwbR]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.15 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3D=
n MCAST=3Dy BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/multicast_forw=
=2Ec:264:5: warning: symbol 'batadv_mcast_forw_tracker_tvlv_handler' was no=
t declared. Should it be static?
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:398:7: =
warning: this statement may fall through [-Wimplicit-fallthrough=3D]
       src =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->src;
       ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:404:2: =
note: here
      case BATADV_MCAST:
      ^~~~
    make[3]: *** [scripts/Makefile.build:277: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:540: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1868: /home/build_test/build_env/tmp.LI6FiYuwbR]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.15 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3D=
y MCAST=3Dy BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/multicast_forw=
=2Ec:264:5: warning: symbol 'batadv_mcast_forw_tracker_tvlv_handler' was no=
t declared. Should it be static?
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:277: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:540: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1868: /home/build_test/build_env/tmp.LI6FiYuwbR]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.15.83 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=
=3Dn MCAST=3Dy BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/multicast_forw=
=2Ec:264:5: warning: symbol 'batadv_mcast_forw_tracker_tvlv_handler' was no=
t declared. Should it be static?
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:398:7: =
warning: this statement may fall through [-Wimplicit-fallthrough=3D]
       src =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->src;
       ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:404:2: =
note: here
      case BATADV_MCAST:
      ^~~~
    make[3]: *** [scripts/Makefile.build:289: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:552: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1902: /home/build_test/build_env/tmp.LI6FiYuwbR]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.15.83 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=
=3Dn MCAST=3Dn BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:398:7: =
warning: this statement may fall through [-Wimplicit-fallthrough=3D]
       src =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->src;
       ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:404:2: =
note: here
      case BATADV_MCAST:
      ^~~~
    make[3]: *** [scripts/Makefile.build:289: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:552: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1902: /home/build_test/build_env/tmp.LI6FiYuwbR]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.15.83 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dn NC=
=3Dy MCAST=3Dn BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:289: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:552: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1902: /home/build_test/build_env/tmp.LI6FiYuwbR]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.16 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dn NC=3D=
y MCAST=3Dy BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/multicast_forw=
=2Ec:264:5: warning: symbol 'batadv_mcast_forw_tracker_tvlv_handler' was no=
t declared. Should it be static?
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:287: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:549: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1846: /home/build_test/build_env/tmp.LI6FiYuwbR]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.16 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dy NC=3D=
n MCAST=3Dn BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:398:7: =
warning: this statement may fall through [-Wimplicit-fallthrough=3D]
       src =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->src;
       ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:404:2: =
note: here
      case BATADV_MCAST:
      ^~~~
    make[3]: *** [scripts/Makefile.build:287: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:549: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1846: /home/build_test/build_env/tmp.LI6FiYuwbR]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.16 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3D=
n MCAST=3Dy BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/multicast_forw=
=2Ec:264:5: warning: symbol 'batadv_mcast_forw_tracker_tvlv_handler' was no=
t declared. Should it be static?
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:398:7: =
warning: this statement may fall through [-Wimplicit-fallthrough=3D]
       src =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->src;
       ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:404:2: =
note: here
      case BATADV_MCAST:
      ^~~~
    make[3]: *** [scripts/Makefile.build:287: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:549: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1846: /home/build_test/build_env/tmp.LI6FiYuwbR]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.16 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3D=
y MCAST=3Dn BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:287: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:549: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1846: /home/build_test/build_env/tmp.LI6FiYuwbR]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.17 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=3D=
n MCAST=3Dy BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/multicast_forw=
=2Ec:264:5: warning: symbol 'batadv_mcast_forw_tracker_tvlv_handler' was no=
t declared. Should it be static?
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:398:7: =
warning: this statement may fall through [-Wimplicit-fallthrough=3D]
       src =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->src;
       ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:404:2: =
note: here
      case BATADV_MCAST:
      ^~~~
    make[3]: *** [scripts/Makefile.build:288: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:550: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1831: /home/build_test/build_env/tmp.LI6FiYuwbR]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.17 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3D=
y MCAST=3Dn BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:288: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:550: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1831: /home/build_test/build_env/tmp.LI6FiYuwbR]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.18 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3D=
n MCAST=3Dy BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/multicast_forw=
=2Ec:264:5: warning: symbol 'batadv_mcast_forw_tracker_tvlv_handler' was no=
t declared. Should it be static?
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:398:7: =
warning: this statement may fall through [-Wimplicit-fallthrough=3D]
       src =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->src;
       ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:404:2: =
note: here
      case BATADV_MCAST:
      ^~~~
    make[3]: *** [scripts/Makefile.build:288: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:550: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1834: /home/build_test/build_env/tmp.LI6FiYuwbR]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.19 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3D=
n MCAST=3Dy BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/multicast_forw=
=2Ec:264:5: warning: symbol 'batadv_mcast_forw_tracker_tvlv_handler' was no=
t declared. Should it be static?
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:398:7: =
warning: this statement may fall through [-Wimplicit-fallthrough=3D]
       src =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->src;
       ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:404:2: =
note: here
      case BATADV_MCAST:
      ^~~~
    make[3]: *** [scripts/Makefile.build:249: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:466: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1843: /home/build_test/build_env/tmp.LI6FiYuwbR]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.2 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dy NC=3Dy=
 MCAST=3Dn BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44: warning: incorrect type in argument 4 (different base types)
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44:    expected int ( *mptr )( ... )
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44:    got int
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:37: error: not enough arguments for function batadv_tvlv_handler_r=
egister
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:279: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:489: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1595: _module_/home/build_test/build_env/tmp.LI6=
=46iYuwbR] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.2 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3Dn=
 MCAST=3Dn BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:26:=
 error: Expected ; at end of statement
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:26:=
 error: got int
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:17:=
 error: undefined identifier 'u8'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:21:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:398:17:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:401:64:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:17:=
 error: undefined identifier 'unsigned'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:413:17:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:414:45:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:415:47:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    make[3]: *** [scripts/Makefile.build:279: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:489: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1595: _module_/home/build_test/build_env/tmp.LI6=
=46iYuwbR] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.3 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=3Dy=
 MCAST=3Dy BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/multicast_forw=
=2Ec:264:5: warning: symbol 'batadv_mcast_forw_tracker_tvlv_handler' was no=
t declared. Should it be static?
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44: warning: incorrect type in argument 4 (different base types)
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44:    expected int ( *mptr )( ... )
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44:    got int
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:37: error: not enough arguments for function batadv_tvlv_handler_r=
egister
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:281: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:497: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1624: _module_/home/build_test/build_env/tmp.LI6=
=46iYuwbR] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.3 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=3Dy=
 MCAST=3Dn BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44: warning: incorrect type in argument 4 (different base types)
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44:    expected int ( *mptr )( ... )
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44:    got int
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:37: error: not enough arguments for function batadv_tvlv_handler_r=
egister
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:281: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:497: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1624: _module_/home/build_test/build_env/tmp.LI6=
=46iYuwbR] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.4 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=3Dn=
 MCAST=3Dy BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/multicast_forw=
=2Ec:264:5: warning: symbol 'batadv_mcast_forw_tracker_tvlv_handler' was no=
t declared. Should it be static?
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:26:=
 error: Expected ; at end of statement
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:26:=
 error: got int
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:17:=
 error: undefined identifier 'u8'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:21:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:398:17:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:401:64:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:17:=
 error: undefined identifier 'unsigned'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:413:17:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:414:45:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:415:47:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:398:7: =
warning: this statement may fall through [-Wimplicit-fallthrough=3D]
       src =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->src;
       ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:404:2: =
note: here
      case BATADV_MCAST:
      ^~~~
    make[3]: *** [scripts/Makefile.build:266: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:509: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1652: /home/build_test/build_env/tmp.LI6FiYuwbR]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.4 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=3Dy=
 MCAST=3Dn BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44: warning: incorrect type in argument 4 (different base types)
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44:    expected int ( *mptr )( ... )
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44:    got int
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:37: error: not enough arguments for function batadv_tvlv_handler_r=
egister
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:266: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:509: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1652: /home/build_test/build_env/tmp.LI6FiYuwbR]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.4.227 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=
=3Dy MCAST=3Dn BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:262: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:497: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1739: /home/build_test/build_env/tmp.LI6FiYuwbR]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.4.227 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dy NC=
=3Dn MCAST=3Dy BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/multicast_forw=
=2Ec:264:5: warning: symbol 'batadv_mcast_forw_tracker_tvlv_handler' was no=
t declared. Should it be static?
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:398:7: =
warning: this statement may fall through [-Wimplicit-fallthrough=3D]
       src =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->src;
       ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:404:2: =
note: here
      case BATADV_MCAST:
      ^~~~
    make[3]: *** [scripts/Makefile.build:262: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:497: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1739: /home/build_test/build_env/tmp.LI6FiYuwbR]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.4.227 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=
=3Dn MCAST=3Dn BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:398:7: =
warning: this statement may fall through [-Wimplicit-fallthrough=3D]
       src =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->src;
       ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:404:2: =
note: here
      case BATADV_MCAST:
      ^~~~
    make[3]: *** [scripts/Makefile.build:262: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:497: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1739: /home/build_test/build_env/tmp.LI6FiYuwbR]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.5 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dn=
 MCAST=3Dy BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/multicast_forw=
=2Ec:264:5: warning: symbol 'batadv_mcast_forw_tracker_tvlv_handler' was no=
t declared. Should it be static?
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:26:=
 error: Expected ; at end of statement
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:26:=
 error: got int
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:17:=
 error: undefined identifier 'u8'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:21:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:398:17:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:401:64:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:17:=
 error: undefined identifier 'unsigned'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:413:17:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:414:45:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:415:47:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:398:7: =
warning: this statement may fall through [-Wimplicit-fallthrough=3D]
       src =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->src;
       ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:404:2: =
note: here
      case BATADV_MCAST:
      ^~~~
    make[3]: *** [scripts/Makefile.build:266: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:503: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1693: /home/build_test/build_env/tmp.LI6FiYuwbR]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.6 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=3Dn=
 MCAST=3Dn BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:26:=
 error: Expected ; at end of statement
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:26:=
 error: got int
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:17:=
 error: undefined identifier 'u8'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:21:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:398:17:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:401:64:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:17:=
 error: undefined identifier 'unsigned'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:413:17:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:414:45:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:415:47:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:398:7: =
warning: this statement may fall through [-Wimplicit-fallthrough=3D]
       src =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->src;
       ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:404:2: =
note: here
      case BATADV_MCAST:
      ^~~~
    make[3]: *** [scripts/Makefile.build:268: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:505: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1683: /home/build_test/build_env/tmp.LI6FiYuwbR]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.6 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=3Dn=
 MCAST=3Dy BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/multicast_forw=
=2Ec:264:5: warning: symbol 'batadv_mcast_forw_tracker_tvlv_handler' was no=
t declared. Should it be static?
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:26:=
 error: Expected ; at end of statement
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:26:=
 error: got int
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:17:=
 error: undefined identifier 'u8'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:21:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:398:17:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:401:64:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:17:=
 error: undefined identifier 'unsigned'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:413:17:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:414:45:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:415:47:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:398:7: =
warning: this statement may fall through [-Wimplicit-fallthrough=3D]
       src =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->src;
       ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:404:2: =
note: here
      case BATADV_MCAST:
      ^~~~
    make[3]: *** [scripts/Makefile.build:268: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:505: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1683: /home/build_test/build_env/tmp.LI6FiYuwbR]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.7 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=3Dy=
 MCAST=3Dy BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/multicast_forw=
=2Ec:264:5: warning: symbol 'batadv_mcast_forw_tracker_tvlv_handler' was no=
t declared. Should it be static?
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44: warning: incorrect type in argument 4 (different base types)
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44:    expected int ( *mptr )( ... )
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44:    got int
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:37: error: not enough arguments for function batadv_tvlv_handler_r=
egister
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:267: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:488: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1729: /home/build_test/build_env/tmp.LI6FiYuwbR]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.7 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=3Dy=
 MCAST=3Dn BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44: warning: incorrect type in argument 4 (different base types)
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44:    expected int ( *mptr )( ... )
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44:    got int
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:37: error: not enough arguments for function batadv_tvlv_handler_r=
egister
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:267: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:488: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1729: /home/build_test/build_env/tmp.LI6FiYuwbR]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.7 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dn=
 MCAST=3Dn BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:26:=
 error: Expected ; at end of statement
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:26:=
 error: got int
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:17:=
 error: undefined identifier 'u8'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:21:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:398:17:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:401:64:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:17:=
 error: undefined identifier 'unsigned'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:413:17:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:414:45:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:415:47:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:398:7: =
warning: this statement may fall through [-Wimplicit-fallthrough=3D]
       src =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->src;
       ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:404:2: =
note: here
      case BATADV_MCAST:
      ^~~~
    make[3]: *** [scripts/Makefile.build:267: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:488: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1729: /home/build_test/build_env/tmp.LI6FiYuwbR]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.8 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=3Dy=
 MCAST=3Dy BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/multicast_forw=
=2Ec:264:5: warning: symbol 'batadv_mcast_forw_tracker_tvlv_handler' was no=
t declared. Should it be static?
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44: warning: incorrect type in argument 4 (different base types)
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44:    expected int ( *mptr )( ... )
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44:    got int
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:37: error: not enough arguments for function batadv_tvlv_handler_r=
egister
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:281: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:497: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1756: /home/build_test/build_env/tmp.LI6FiYuwbR]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.8 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=3Dn=
 MCAST=3Dn BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:26:=
 error: Expected ; at end of statement
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:26:=
 error: got int
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:17:=
 error: undefined identifier 'u8'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:21:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:398:17:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:401:64:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:17:=
 error: undefined identifier 'unsigned'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:413:17:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:414:45:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:415:47:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:398:7: =
warning: this statement may fall through [-Wimplicit-fallthrough=3D]
       src =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->src;
       ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:404:2: =
note: here
      case BATADV_MCAST:
      ^~~~
    make[3]: *** [scripts/Makefile.build:281: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:497: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1756: /home/build_test/build_env/tmp.LI6FiYuwbR]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.8 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=3Dy=
 MCAST=3Dn BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44: warning: incorrect type in argument 4 (different base types)
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44:    expected int ( *mptr )( ... )
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:44:    got int
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:37: error: not enough arguments for function batadv_tvlv_handler_r=
egister
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:281: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:497: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1756: /home/build_test/build_env/tmp.LI6FiYuwbR]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.9 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dn NC=3Dn=
 MCAST=3Dy BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/multicast_forw=
=2Ec:264:5: warning: symbol 'batadv_mcast_forw_tracker_tvlv_handler' was no=
t declared. Should it be static?
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:398:7: =
warning: this statement may fall through [-Wimplicit-fallthrough=3D]
       src =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->src;
       ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:404:2: =
note: here
      case BATADV_MCAST:
      ^~~~
    make[3]: *** [scripts/Makefile.build:283: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:500: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1784: /home/build_test/build_env/tmp.LI6FiYuwbR]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-6.0 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=3Dy=
 MCAST=3Dn BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:249: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:465: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1852: /home/build_test/build_env/tmp.LI6FiYuwbR]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-6.0 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=3Dn=
 MCAST=3Dn BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:398:7: =
warning: this statement may fall through [-Wimplicit-fallthrough=3D]
       src =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->src;
       ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:404:2: =
note: here
      case BATADV_MCAST:
      ^~~~
    make[3]: *** [scripts/Makefile.build:249: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:465: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1852: /home/build_test/build_env/tmp.LI6FiYuwbR]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-6.0.13 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=
=3Dn MCAST=3Dy BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/multicast_forw=
=2Ec:264:5: warning: symbol 'batadv_mcast_forw_tracker_tvlv_handler' was no=
t declared. Should it be static?
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:398:7: =
warning: this statement may fall through [-Wimplicit-fallthrough=3D]
       src =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->src;
       ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:404:2: =
note: here
      case BATADV_MCAST:
      ^~~~
    make[3]: *** [scripts/Makefile.build:249: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:465: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1852: /home/build_test/build_env/tmp.LI6FiYuwbR]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-6.1 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dy NC=3Dy=
 MCAST=3Dn BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:250: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:500: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1992: /home/build_test/build_env/tmp.LI6FiYuwbR]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-6.1 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=3Dn=
 MCAST=3Dn BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:398:7: =
warning: this statement may fall through [-Wimplicit-fallthrough=3D]
       src =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->src;
       ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.c:404:2: =
note: here
      case BATADV_MCAST:
      ^~~~
    make[3]: *** [scripts/Makefile.build:250: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:500: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1992: /home/build_test/build_env/tmp.LI6FiYuwbR]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-6.1 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3Dy=
 MCAST=3Dy BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/multicast_forw=
=2Ec:264:5: warning: symbol 'batadv_mcast_forw_tracker_tvlv_handler' was no=
t declared. Should it be static?
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.LI6FiYuwbR/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.LI6FiYuwbR/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:250: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:500: /home/build_test/build_env/tm=
p.LI6FiYuwbR/net/batman-adv] Error 2
    make[1]: *** [Makefile:1992: /home/build_test/build_env/tmp.LI6FiYuwbR]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: unused_symbols linux-4.11 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=
=3Dy NC=3Dy MCAST=3Dn BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    batadv_algo_get
    batadv_algo_select
    batadv_broadcast_addr
    batadv_dat_drop_broadcast_packet
    batadv_dat_snoop_incoming_arp_reply
    batadv_dat_snoop_incoming_arp_request
    batadv_dat_snoop_incoming_dhcp_ack
    batadv_dat_snoop_outgoing_arp_reply
    batadv_dat_snoop_outgoing_arp_request
    batadv_dat_snoop_outgoing_dhcp_ack
    batadv_frag_purge_orig
    batadv_frag_send_packet
    batadv_frag_skb_buffer
    batadv_frag_skb_fwd
    batadv_gw_dhcp_recipient_get
    batadv_gw_election
    batadv_gw_get_selected_orig
    batadv_gw_node_delete
    batadv_gw_out_of_range
    batadv_hardif_disable_interface
    batadv_hardif_enable_interface
    batadv_hardif_min_mtu
    batadv_hardif_no_broadcast
    batadv_hash_set_lock_class
    batadv_is_my_mac
    batadv_mesh_free
    batadv_mesh_init
    batadv_netlink_tpmeter_notify
    batadv_routing_algo
    batadv_skb_set_priority
    batadv_vlan_ap_isola_get

ecsv/pu: unused_symbols linux-4.13 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=
=3Dn NC=3Dy MCAST=3Dn BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    batadv_algo_get
    batadv_algo_select
    batadv_bla_check_bcast_duplist
    batadv_bla_is_backbone_gw
    batadv_bla_is_backbone_gw_orig
    batadv_bla_rx
    batadv_bla_tx
    batadv_broadcast_addr
    batadv_dat_drop_broadcast_packet
    batadv_dat_snoop_incoming_arp_reply
    batadv_dat_snoop_incoming_arp_request
    batadv_dat_snoop_incoming_dhcp_ack
    batadv_dat_snoop_outgoing_arp_reply
    batadv_dat_snoop_outgoing_arp_request
    batadv_dat_snoop_outgoing_dhcp_ack
    batadv_frag_purge_orig
    batadv_frag_send_packet
    batadv_frag_skb_buffer
    batadv_frag_skb_fwd
    batadv_gw_dhcp_recipient_get
    batadv_gw_election
    batadv_gw_get_selected_orig
    batadv_gw_node_delete
    batadv_gw_out_of_range
    batadv_hardif_disable_interface
    batadv_hardif_enable_interface
    batadv_hardif_min_mtu
    batadv_mesh_free
    batadv_mesh_init
    batadv_netlink_tpmeter_notify
    batadv_routing_algo
    batadv_skb_set_priority
    batadv_vlan_ap_isola_get

ecsv/pu: unused_symbols linux-4.13 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=
=3Dn NC=3Dy MCAST=3Dy BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    batadv_algo_get
    batadv_algo_select
    batadv_bla_check_bcast_duplist
    batadv_bla_is_backbone_gw
    batadv_bla_rx
    batadv_bla_tx
    batadv_broadcast_addr
    batadv_dat_drop_broadcast_packet
    batadv_dat_snoop_incoming_arp_reply
    batadv_dat_snoop_incoming_arp_request
    batadv_dat_snoop_incoming_dhcp_ack
    batadv_dat_snoop_outgoing_arp_reply
    batadv_dat_snoop_outgoing_arp_request
    batadv_dat_snoop_outgoing_dhcp_ack
    batadv_frag_purge_orig
    batadv_frag_send_packet
    batadv_frag_skb_buffer
    batadv_frag_skb_fwd
    batadv_gw_dhcp_recipient_get
    batadv_gw_election
    batadv_gw_get_selected_orig
    batadv_gw_node_delete
    batadv_gw_out_of_range
    batadv_hardif_disable_interface
    batadv_hardif_enable_interface
    batadv_hardif_min_mtu
    batadv_hardif_no_broadcast
    batadv_mcast_forw_mode
    batadv_mcast_forw_send
    batadv_mcast_purge_orig
    batadv_mesh_free
    batadv_mesh_init
    batadv_netlink_tpmeter_notify
    batadv_routing_algo
    batadv_skb_set_priority
    batadv_vlan_ap_isola_get

ecsv/pu: unused_symbols linux-4.15 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=
=3Dn NC=3Dy MCAST=3Dy BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    batadv_algo_get
    batadv_algo_select
    batadv_broadcast_addr
    batadv_dat_drop_broadcast_packet
    batadv_dat_snoop_incoming_arp_reply
    batadv_dat_snoop_incoming_arp_request
    batadv_dat_snoop_incoming_dhcp_ack
    batadv_dat_snoop_outgoing_arp_reply
    batadv_dat_snoop_outgoing_arp_request
    batadv_dat_snoop_outgoing_dhcp_ack
    batadv_frag_purge_orig
    batadv_frag_send_packet
    batadv_frag_skb_buffer
    batadv_frag_skb_fwd
    batadv_gw_dhcp_recipient_get
    batadv_gw_election
    batadv_gw_get_selected_orig
    batadv_gw_node_delete
    batadv_gw_out_of_range
    batadv_hardif_disable_interface
    batadv_hardif_enable_interface
    batadv_hardif_min_mtu
    batadv_hardif_no_broadcast
    batadv_hash_set_lock_class
    batadv_mcast_forw_mode
    batadv_mcast_forw_send
    batadv_mcast_purge_orig
    batadv_mesh_free
    batadv_mesh_init
    batadv_netlink_tpmeter_notify
    batadv_routing_algo
    batadv_skb_set_priority
    batadv_vlan_ap_isola_get

ecsv/pu: unused_symbols linux-4.15 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=
=3Dy NC=3Dy MCAST=3Dy BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    batadv_algo_get
    batadv_algo_select
    batadv_broadcast_addr
    batadv_dat_drop_broadcast_packet
    batadv_dat_snoop_incoming_arp_reply
    batadv_dat_snoop_incoming_arp_request
    batadv_dat_snoop_incoming_dhcp_ack
    batadv_dat_snoop_outgoing_arp_reply
    batadv_dat_snoop_outgoing_arp_request
    batadv_dat_snoop_outgoing_dhcp_ack
    batadv_frag_purge_orig
    batadv_frag_send_packet
    batadv_frag_skb_buffer
    batadv_frag_skb_fwd
    batadv_gw_dhcp_recipient_get
    batadv_gw_election
    batadv_gw_get_selected_orig
    batadv_gw_node_delete
    batadv_gw_out_of_range
    batadv_hardif_disable_interface
    batadv_hardif_enable_interface
    batadv_hardif_min_mtu
    batadv_hash_set_lock_class
    batadv_mcast_forw_mode
    batadv_mcast_forw_send
    batadv_mcast_purge_orig
    batadv_mesh_free
    batadv_mesh_init
    batadv_netlink_tpmeter_notify
    batadv_routing_algo
    batadv_skb_set_priority
    batadv_vlan_ap_isola_get

ecsv/pu: unused_symbols linux-4.19 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=
=3Dy NC=3Dy MCAST=3Dn BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    batadv_algo_get
    batadv_algo_select
    batadv_broadcast_addr
    batadv_dat_drop_broadcast_packet
    batadv_dat_snoop_incoming_arp_reply
    batadv_dat_snoop_incoming_arp_request
    batadv_dat_snoop_incoming_dhcp_ack
    batadv_dat_snoop_outgoing_arp_reply
    batadv_dat_snoop_outgoing_arp_request
    batadv_dat_snoop_outgoing_dhcp_ack
    batadv_frag_purge_orig
    batadv_frag_send_packet
    batadv_frag_skb_buffer
    batadv_frag_skb_fwd
    batadv_gw_dhcp_recipient_get
    batadv_gw_election
    batadv_gw_get_selected_orig
    batadv_gw_node_delete
    batadv_gw_out_of_range
    batadv_hardif_disable_interface
    batadv_hardif_enable_interface
    batadv_hardif_min_mtu
    batadv_hash_set_lock_class
    batadv_mesh_free
    batadv_mesh_init
    batadv_netlink_tpmeter_notify
    batadv_routing_algo
    batadv_skb_set_priority
    batadv_vlan_ap_isola_get

ecsv/pu: unused_symbols linux-4.19.269 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACI=
NG=3Dy NC=3Dy MCAST=3Dy BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    batadv_algo_get
    batadv_algo_select
    batadv_broadcast_addr
    batadv_frag_purge_orig
    batadv_frag_send_packet
    batadv_frag_skb_buffer
    batadv_frag_skb_fwd
    batadv_gw_dhcp_recipient_get
    batadv_gw_election
    batadv_gw_get_selected_orig
    batadv_gw_node_delete
    batadv_gw_out_of_range
    batadv_hardif_disable_interface
    batadv_hardif_enable_interface
    batadv_hardif_min_mtu
    batadv_hardif_no_broadcast
    batadv_hash_destroy
    batadv_hash_new
    batadv_hash_set_lock_class
    batadv_mcast_forw_mode
    batadv_mcast_forw_send
    batadv_mcast_purge_orig
    batadv_mesh_free
    batadv_mesh_init
    batadv_netlink_tpmeter_notify
    batadv_routing_algo
    batadv_skb_set_priority
    batadv_vlan_ap_isola_get

ecsv/pu: unused_symbols linux-4.19.269 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACI=
NG=3Dy NC=3Dy MCAST=3Dn BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    batadv_algo_get
    batadv_algo_select
    batadv_bla_check_bcast_duplist
    batadv_bla_is_backbone_gw
    batadv_bla_is_backbone_gw_orig
    batadv_bla_rx
    batadv_bla_tx
    batadv_broadcast_addr
    batadv_frag_purge_orig
    batadv_frag_send_packet
    batadv_frag_skb_buffer
    batadv_frag_skb_fwd
    batadv_gw_dhcp_recipient_get
    batadv_gw_election
    batadv_gw_get_selected_orig
    batadv_gw_node_delete
    batadv_gw_out_of_range
    batadv_hardif_disable_interface
    batadv_hardif_enable_interface
    batadv_hardif_min_mtu
    batadv_mesh_free
    batadv_mesh_init
    batadv_netlink_tpmeter_notify
    batadv_routing_algo
    batadv_skb_set_priority
    batadv_vlan_ap_isola_get

ecsv/pu: unused_symbols linux-5.0 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3D=
y NC=3Dy MCAST=3Dy BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    batadv_algo_get
    batadv_algo_select
    batadv_bla_check_bcast_duplist
    batadv_bla_is_backbone_gw
    batadv_bla_rx
    batadv_bla_tx
    batadv_broadcast_addr
    batadv_frag_purge_orig
    batadv_frag_send_packet
    batadv_frag_skb_buffer
    batadv_frag_skb_fwd
    batadv_gw_dhcp_recipient_get
    batadv_gw_election
    batadv_gw_get_selected_orig
    batadv_gw_node_delete
    batadv_gw_out_of_range
    batadv_hardif_disable_interface
    batadv_hardif_enable_interface
    batadv_hardif_min_mtu
    batadv_mcast_forw_mode
    batadv_mcast_forw_send
    batadv_mcast_purge_orig
    batadv_mesh_free
    batadv_mesh_init
    batadv_netlink_tpmeter_notify
    batadv_routing_algo
    batadv_skb_set_priority
    batadv_vlan_ap_isola_get

ecsv/pu: unused_symbols linux-5.1 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3D=
n NC=3Dy MCAST=3Dy BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    batadv_algo_get
    batadv_algo_select
    batadv_bla_check_bcast_duplist
    batadv_bla_is_backbone_gw
    batadv_bla_rx
    batadv_bla_tx
    batadv_broadcast_addr
    batadv_dat_drop_broadcast_packet
    batadv_dat_snoop_incoming_arp_reply
    batadv_dat_snoop_incoming_arp_request
    batadv_dat_snoop_incoming_dhcp_ack
    batadv_dat_snoop_outgoing_arp_reply
    batadv_dat_snoop_outgoing_arp_request
    batadv_dat_snoop_outgoing_dhcp_ack
    batadv_frag_purge_orig
    batadv_frag_send_packet
    batadv_frag_skb_buffer
    batadv_frag_skb_fwd
    batadv_gw_dhcp_recipient_get
    batadv_gw_election
    batadv_gw_get_selected_orig
    batadv_gw_node_delete
    batadv_gw_out_of_range
    batadv_hardif_disable_interface
    batadv_hardif_enable_interface
    batadv_hardif_min_mtu
    batadv_mcast_forw_mode
    batadv_mcast_forw_send
    batadv_mcast_purge_orig
    batadv_mesh_free
    batadv_mesh_init
    batadv_netlink_tpmeter_notify
    batadv_routing_algo
    batadv_skb_set_priority
    batadv_vlan_ap_isola_get

ecsv/pu: unused_symbols linux-5.15.83 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACIN=
G=3Dn NC=3Dy MCAST=3Dn BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    batadv_algo_get
    batadv_algo_select
    batadv_bla_check_bcast_duplist
    batadv_bla_is_backbone_gw
    batadv_bla_is_backbone_gw_orig
    batadv_bla_rx
    batadv_bla_tx
    batadv_broadcast_addr
    batadv_dat_drop_broadcast_packet
    batadv_dat_snoop_incoming_arp_reply
    batadv_dat_snoop_incoming_arp_request
    batadv_dat_snoop_incoming_dhcp_ack
    batadv_dat_snoop_outgoing_arp_reply
    batadv_dat_snoop_outgoing_arp_request
    batadv_dat_snoop_outgoing_dhcp_ack
    batadv_frag_purge_orig
    batadv_frag_send_packet
    batadv_frag_skb_buffer
    batadv_frag_skb_fwd
    batadv_gw_dhcp_recipient_get
    batadv_gw_election
    batadv_gw_get_selected_orig
    batadv_gw_node_delete
    batadv_gw_out_of_range
    batadv_hardif_disable_interface
    batadv_hardif_enable_interface
    batadv_hardif_min_mtu
    batadv_hardif_no_broadcast
    batadv_is_my_mac
    batadv_mesh_free
    batadv_mesh_init
    batadv_netlink_tpmeter_notify
    batadv_routing_algo
    batadv_skb_set_priority
    batadv_vlan_ap_isola_get

ecsv/pu: unused_symbols linux-5.2 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3D=
y NC=3Dy MCAST=3Dn BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    batadv_algo_get
    batadv_algo_select
    batadv_broadcast_addr
    batadv_event_workqueue
    batadv_frag_purge_orig
    batadv_frag_send_packet
    batadv_frag_skb_buffer
    batadv_frag_skb_fwd
    batadv_gw_dhcp_recipient_get
    batadv_gw_election
    batadv_gw_get_selected_orig
    batadv_gw_node_delete
    batadv_gw_out_of_range
    batadv_hardif_disable_interface
    batadv_hardif_enable_interface
    batadv_hardif_min_mtu
    batadv_hardif_no_broadcast
    batadv_hash_destroy
    batadv_hash_new
    batadv_hash_set_lock_class
    batadv_is_my_mac
    batadv_mesh_free
    batadv_mesh_init
    batadv_netlink_tpmeter_notify
    batadv_routing_algo
    batadv_skb_set_priority
    batadv_vlan_ap_isola_get

ecsv/pu: unused_symbols linux-5.3 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3D=
n NC=3Dy MCAST=3Dy BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    batadv_algo_get
    batadv_algo_select
    batadv_broadcast_addr
    batadv_frag_purge_orig
    batadv_frag_send_packet
    batadv_frag_skb_buffer
    batadv_frag_skb_fwd
    batadv_gw_dhcp_recipient_get
    batadv_gw_election
    batadv_gw_get_selected_orig
    batadv_gw_node_delete
    batadv_gw_out_of_range
    batadv_hardif_disable_interface
    batadv_hardif_enable_interface
    batadv_hardif_min_mtu
    batadv_hash_destroy
    batadv_hash_new
    batadv_hash_set_lock_class
    batadv_mcast_forw_mode
    batadv_mcast_forw_send
    batadv_mcast_purge_orig
    batadv_mesh_free
    batadv_mesh_init
    batadv_netlink_tpmeter_notify
    batadv_routing_algo
    batadv_skb_set_priority
    batadv_vlan_ap_isola_get

ecsv/pu: unused_symbols linux-5.4 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3D=
n NC=3Dy MCAST=3Dn BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    batadv_algo_get
    batadv_algo_select
    batadv_bla_check_bcast_duplist
    batadv_bla_is_backbone_gw
    batadv_bla_is_backbone_gw_orig
    batadv_bla_rx
    batadv_bla_tx
    batadv_broadcast_addr
    batadv_frag_purge_orig
    batadv_frag_send_packet
    batadv_frag_skb_buffer
    batadv_frag_skb_fwd
    batadv_gw_dhcp_recipient_get
    batadv_gw_election
    batadv_gw_get_selected_orig
    batadv_gw_node_delete
    batadv_gw_out_of_range
    batadv_hardif_disable_interface
    batadv_hardif_enable_interface
    batadv_hardif_min_mtu
    batadv_hardif_no_broadcast
    batadv_is_my_mac
    batadv_mesh_free
    batadv_mesh_init
    batadv_netlink_tpmeter_notify
    batadv_routing_algo
    batadv_skb_set_priority
    batadv_vlan_ap_isola_get

ecsv/pu: unused_symbols linux-5.7 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3D=
n NC=3Dy MCAST=3Dn BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    batadv_algo_get
    batadv_algo_select
    batadv_broadcast_addr
    batadv_frag_purge_orig
    batadv_frag_send_packet
    batadv_frag_skb_buffer
    batadv_frag_skb_fwd
    batadv_gw_dhcp_recipient_get
    batadv_gw_election
    batadv_gw_get_selected_orig
    batadv_gw_node_delete
    batadv_gw_out_of_range
    batadv_hardif_disable_interface
    batadv_hardif_enable_interface
    batadv_hardif_min_mtu
    batadv_hash_destroy
    batadv_hash_new
    batadv_hash_set_lock_class
    batadv_mesh_free
    batadv_mesh_init
    batadv_netlink_tpmeter_notify
    batadv_routing_algo
    batadv_skb_set_priority
    batadv_vlan_ap_isola_get


Statistics
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

ecsv/pu
=2D------

=46ailed tests:               165
Started build tests:        113
Tested Linux versions:       40
Tested configs:              77
--nextPart21918037.EfDdHjke4D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmOp4UgACgkQXYcKB8Em
e0Z5MRAA0IOvSe1AQMz0lx309UznSCF3zg+RBBg8I4spx9Ob9KlbJv8zCx46F3Px
p+d04mydmYhDPDJFLvCtFVFWCetTP9sbg7q1z/ZdrtEPsZIGLuy0xbJ0eHlY0eEc
Yl2bEja5OpHakzfZqJkCimT0ZUyJAzLFTf24ReAH1A7aD6lNaMhNk2PbOKC+J+/q
mHso+F/W+68laOOAipkxaw97kh6oz0z7YIa0fMORTKZnPn+s7upVz1o+061Ei5x2
RZS0msIu5zPNcTR7tb6LFnC2cxlhkSH0qhrhssz4SoqIlU7fTM6+2rfIuwMFTfm/
SN86HNLOqOIpMK8xciRB2zz1MkfUqawmiiMYP8RmEWnzlPK/CbsCFWpYyxBh+OF2
7qLqN2hbSkAvMdDkiGXcOgWAVNeQmATIoJv++tGFGmTQumqcS6a2GOwztByCaich
YWxPeWVDK43daBDGV87RWeoXEhC3HQyTyg5Br3JBI8fRFgNEo5qG9b8FmdleijEs
/vCBQv7G/aJD+DELDYVJWN0fya5kaIXCHr/SwniNXRhpQQeJoGb36QInkrbHndDK
xcARln45jamEQoOv9f/UzrBFAKaKZugo4dkBtKhHDKNmPEcaTMyRxu3qf6zG/q6D
zvddC+PWtt6cPxnjlPk4s7vHJf6myLHKbrYvTCOC7P1WNCJMgWw=
=wFFo
-----END PGP SIGNATURE-----

--nextPart21918037.EfDdHjke4D--


