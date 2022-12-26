Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH v2 2/5] batman-adv: tvlv: prepare for tvlv enabled
 multicast packet type
Date: Mon, 26 Dec 2022 18:33:35 +0100
Message-ID: <8359211.T7Z3S40VBb@sven-l14>
In-Reply-To: <20221226161554.9657-3-linus.luessing@c0d3.blue>
References: <20221226161554.9657-1-linus.luessing@c0d3.blue>
 <20221226161554.9657-3-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart10398328.nUPlyArG6x";
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
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>, Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>

 
--nextPart10398328.nUPlyArG6x
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Date: Mon, 26 Dec 2022 18:33:35 +0100
Message-ID: <8359211.T7Z3S40VBb@sven-l14>
In-Reply-To: <20221226161554.9657-3-linus.luessing@c0d3.blue>
MIME-Version: 1.0

On Monday, 26 December 2022 17:15:51 CET Linus L=C3=BCssing wrote:
> Prepare TVLV infrastructure for more packet types, in particular the
> upcoming batman-adv multicast packet type.
>=20
> For that swap the OGM vs. unicast-tvlv packet boolean indicator to an
> explicit unsigned integer packet type variable. And provide the skb
> to a call to batadv_tvlv_containers_process(), as later the multicast
> packet's TVLV handler will need to have access not only to the TVLV but
> the full skb for forwarding. Forwarding will be invoked from the
> multicast packet's TVLVs' contents later.
>=20
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
> ---
>  include/uapi/linux/batadv_packet.h     |  2 +
>  net/batman-adv/bat_v_ogm.c             |  4 +-
>  net/batman-adv/distributed-arp-table.c |  2 +-
>  net/batman-adv/gateway_common.c        |  2 +-
>  net/batman-adv/multicast.c             |  2 +-
>  net/batman-adv/routing.c               |  7 ++-
>  net/batman-adv/translation-table.c     |  4 +-
>  net/batman-adv/tvlv.c                  | 71 ++++++++++++++++++--------
>  net/batman-adv/tvlv.h                  |  8 +--
>  net/batman-adv/types.h                 |  6 +++
>  10 files changed, 73 insertions(+), 35 deletions(-)

Name of failed tests
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

ecsv/pu
=2D------

 * headers
 * sparse linux-4.10 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=3Dy MCAS=
T=3Dn BATMAN_V=3Dy
 * sparse linux-4.10 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dy NC=3Dy MCAS=
T=3Dy BATMAN_V=3Dy
 * sparse linux-4.10 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3Dn MCAS=
T=3Dn BATMAN_V=3Dy
 * sparse linux-4.11 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dy MCAS=
T=3Dy BATMAN_V=3Dn
 * sparse linux-4.11 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=3Dn MCAS=
T=3Dy BATMAN_V=3Dn
 * sparse linux-4.12 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dn MCAS=
T=3Dn BATMAN_V=3Dy
 * sparse linux-4.12 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=3Dn MCAS=
T=3Dn BATMAN_V=3Dn
 * sparse linux-4.12 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=3Dy MCAS=
T=3Dn BATMAN_V=3Dy
 * sparse linux-4.12 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=3Dy MCAS=
T=3Dn BATMAN_V=3Dn
 * sparse linux-4.12 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=3Dy MCAS=
T=3Dn BATMAN_V=3Dy
 * sparse linux-4.13 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dn MCAS=
T=3Dy BATMAN_V=3Dn
 * sparse linux-4.13 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=3Dn MCAS=
T=3Dy BATMAN_V=3Dn
 * sparse linux-4.14 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=3Dn MCAS=
T=3Dy BATMAN_V=3Dy
 * sparse linux-4.14 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=3Dy MCAS=
T=3Dn BATMAN_V=3Dy
 * sparse linux-4.14 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3Dy MCAS=
T=3Dn BATMAN_V=3Dy
 * sparse linux-4.14 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dy MCAS=
T=3Dy BATMAN_V=3Dy
 * sparse linux-4.14.302 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=3Dn =
MCAST=3Dn BATMAN_V=3Dn
 * sparse linux-4.14.302 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dy =
MCAST=3Dn BATMAN_V=3Dn
 * sparse linux-4.14.302 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3Dn =
MCAST=3Dy BATMAN_V=3Dy
 * sparse linux-4.15 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dy NC=3Dy MCAS=
T=3Dy BATMAN_V=3Dn
 * sparse linux-4.15 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=3Dy MCAS=
T=3Dn BATMAN_V=3Dn
 * sparse linux-4.15 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=3Dy MCAS=
T=3Dy BATMAN_V=3Dn
 * sparse linux-4.16 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3Dn MCAS=
T=3Dn BATMAN_V=3Dy
 * sparse linux-4.16 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=3Dy MCAS=
T=3Dy BATMAN_V=3Dy
 * sparse linux-4.16 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=3Dn MCAS=
T=3Dn BATMAN_V=3Dn
 * sparse linux-4.16 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=3Dn MCAS=
T=3Dy BATMAN_V=3Dn
 * sparse linux-4.17 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3Dn MCAS=
T=3Dn BATMAN_V=3Dn
 * sparse linux-4.18 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dy NC=3Dy MCAS=
T=3Dn BATMAN_V=3Dy
 * sparse linux-4.18 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3Dn MCAS=
T=3Dy BATMAN_V=3Dy
 * sparse linux-4.18 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dn MCAS=
T=3Dn BATMAN_V=3Dn
 * sparse linux-4.18 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=3Dn MCAS=
T=3Dn BATMAN_V=3Dn
 * sparse linux-4.18 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=3Dy MCAS=
T=3Dn BATMAN_V=3Dy
 * sparse linux-4.18 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=3Dn MCAS=
T=3Dn BATMAN_V=3Dy
 * sparse linux-4.18 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dn MCAS=
T=3Dy BATMAN_V=3Dy
 * sparse linux-4.19 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=3Dn MCAS=
T=3Dy BATMAN_V=3Dn
 * sparse linux-4.19.269 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=3Dy =
MCAST=3Dn BATMAN_V=3Dn
 * sparse linux-4.19.269 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dn NC=3Dy =
MCAST=3Dy BATMAN_V=3Dn
 * sparse linux-4.19.269 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=3Dy =
MCAST=3Dn BATMAN_V=3Dy
 * sparse linux-4.19.269 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=3Dy =
MCAST=3Dn BATMAN_V=3Dn
 * sparse linux-4.9 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=3Dy MCAST=
=3Dn BATMAN_V=3Dn
 * sparse linux-4.9 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=3Dy MCAST=
=3Dy BATMAN_V=3Dy
 * sparse linux-4.9 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3Dy MCAST=
=3Dn BATMAN_V=3Dy
 * sparse linux-4.9 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=3Dy MCAST=
=3Dn BATMAN_V=3Dy
 * sparse linux-4.9 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dy MCAST=
=3Dn BATMAN_V=3Dn
 * sparse linux-4.9.336 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dy M=
CAST=3Dy BATMAN_V=3Dn
 * sparse linux-5.0 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dy MCAST=
=3Dn BATMAN_V=3Dn
 * sparse linux-5.0 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dy MCAST=
=3Dy BATMAN_V=3Dn
 * sparse linux-5.1 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=3Dy MCAST=
=3Dn BATMAN_V=3Dy
 * sparse linux-5.10 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dy NC=3Dy MCAS=
T=3Dy BATMAN_V=3Dn
 * sparse linux-5.10 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dn NC=3Dn MCAS=
T=3Dy BATMAN_V=3Dn
 * sparse linux-5.10 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dy MCAS=
T=3Dy BATMAN_V=3Dn
 * sparse linux-5.10 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=3Dn MCAS=
T=3Dn BATMAN_V=3Dn
 * sparse linux-5.10.159 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dy NC=3Dy =
MCAST=3Dy BATMAN_V=3Dy
 * sparse linux-5.10.159 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3Dn =
MCAST=3Dy BATMAN_V=3Dn
 * sparse linux-5.11 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3Dy MCAS=
T=3Dn BATMAN_V=3Dn
 * sparse linux-5.11 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dn NC=3Dn MCAS=
T=3Dy BATMAN_V=3Dy
 * sparse linux-5.12 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=3Dn MCAS=
T=3Dy BATMAN_V=3Dn
 * sparse linux-5.12 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dn MCAS=
T=3Dy BATMAN_V=3Dy
 * sparse linux-5.13 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=3Dn MCAS=
T=3Dy BATMAN_V=3Dy
 * sparse linux-5.13 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=3Dy MCAS=
T=3Dn BATMAN_V=3Dy
 * sparse linux-5.13 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=3Dy MCAS=
T=3Dy BATMAN_V=3Dy
 * sparse linux-5.13 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=3Dy MCAS=
T=3Dn BATMAN_V=3Dy
 * sparse linux-5.13 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dy MCAS=
T=3Dn BATMAN_V=3Dn
 * sparse linux-5.13 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=3Dy MCAS=
T=3Dy BATMAN_V=3Dy
 * sparse linux-5.13 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=3Dn MCAS=
T=3Dy BATMAN_V=3Dn
 * sparse linux-5.13 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3Dy MCAS=
T=3Dn BATMAN_V=3Dn
 * sparse linux-5.13 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=3Dy MCAS=
T=3Dy BATMAN_V=3Dn
 * sparse linux-5.14 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=3Dy MCAS=
T=3Dn BATMAN_V=3Dn
 * sparse linux-5.14 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=3Dy MCAS=
T=3Dn BATMAN_V=3Dy
 * sparse linux-5.14 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=3Dy MCAS=
T=3Dn BATMAN_V=3Dy
 * sparse linux-5.14 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dy MCAS=
T=3Dy BATMAN_V=3Dy
 * sparse linux-5.15 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3Dy MCAS=
T=3Dy BATMAN_V=3Dn
 * sparse linux-5.15 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3Dy MCAS=
T=3Dy BATMAN_V=3Dy
 * sparse linux-5.15.83 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=3Dy M=
CAST=3Dy BATMAN_V=3Dy
 * sparse linux-5.15.83 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=3Dy M=
CAST=3Dn BATMAN_V=3Dn
 * sparse linux-5.15.83 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=3Dy M=
CAST=3Dy BATMAN_V=3Dn
 * sparse linux-5.16 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=3Dn MCAS=
T=3Dy BATMAN_V=3Dy
 * sparse linux-5.16 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dn MCAS=
T=3Dn BATMAN_V=3Dy
 * sparse linux-5.16 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3Dy MCAS=
T=3Dn BATMAN_V=3Dn
 * sparse linux-5.16 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3Dy MCAS=
T=3Dy BATMAN_V=3Dy
 * sparse linux-5.16 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dn MCAS=
T=3Dy BATMAN_V=3Dn
 * sparse linux-5.17 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dy NC=3Dn MCAS=
T=3Dy BATMAN_V=3Dy
 * sparse linux-5.17 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dn NC=3Dn MCAS=
T=3Dy BATMAN_V=3Dn
 * sparse linux-5.18 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=3Dn MCAS=
T=3Dy BATMAN_V=3Dn
 * sparse linux-5.18 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dn NC=3Dn MCAS=
T=3Dy BATMAN_V=3Dy
 * sparse linux-5.18 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dn MCAS=
T=3Dy BATMAN_V=3Dn
 * sparse linux-5.19 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dy NC=3Dn MCAS=
T=3Dn BATMAN_V=3Dy
 * sparse linux-5.19 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dy NC=3Dy MCAS=
T=3Dy BATMAN_V=3Dy
 * sparse linux-5.19 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=3Dn MCAS=
T=3Dn BATMAN_V=3Dn
 * sparse linux-5.19 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dn NC=3Dy MCAS=
T=3Dn BATMAN_V=3Dn
 * sparse linux-5.2 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3Dn MCAST=
=3Dy BATMAN_V=3Dy
 * sparse linux-5.2 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=3Dy MCAST=
=3Dy BATMAN_V=3Dn
 * sparse linux-5.3 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dn NC=3Dy MCAST=
=3Dn BATMAN_V=3Dn
 * sparse linux-5.3 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dy MCAST=
=3Dn BATMAN_V=3Dy
 * sparse linux-5.4 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=3Dn MCAST=
=3Dn BATMAN_V=3Dn
 * sparse linux-5.4 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=3Dn MCAST=
=3Dn BATMAN_V=3Dn
 * sparse linux-5.4 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=3Dy MCAST=
=3Dn BATMAN_V=3Dy
 * sparse linux-5.4 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dn NC=3Dy MCAST=
=3Dn BATMAN_V=3Dy
 * sparse linux-5.4 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dn MCAST=
=3Dy BATMAN_V=3Dy
 * sparse linux-5.4 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=3Dn MCAST=
=3Dn BATMAN_V=3Dn
 * sparse linux-5.4 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dn NC=3Dy MCAST=
=3Dy BATMAN_V=3Dy
 * sparse linux-5.4.227 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=3Dn M=
CAST=3Dn BATMAN_V=3Dn
 * sparse linux-5.4.227 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=3Dy M=
CAST=3Dy BATMAN_V=3Dy
 * sparse linux-5.5 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=3Dy MCAST=
=3Dn BATMAN_V=3Dn
 * sparse linux-5.6 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=3Dy MCAST=
=3Dy BATMAN_V=3Dn
 * sparse linux-5.6 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dn NC=3Dy MCAST=
=3Dy BATMAN_V=3Dn
 * sparse linux-5.6 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=3Dn MCAST=
=3Dy BATMAN_V=3Dn
 * sparse linux-5.6 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dy MCAST=
=3Dn BATMAN_V=3Dy
 * sparse linux-5.7 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dy NC=3Dn MCAST=
=3Dy BATMAN_V=3Dn
 * sparse linux-5.7 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=3Dn MCAST=
=3Dy BATMAN_V=3Dn
 * sparse linux-5.7 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=3Dy MCAST=
=3Dy BATMAN_V=3Dy
 * sparse linux-5.8 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=3Dn MCAST=
=3Dn BATMAN_V=3Dy
 * sparse linux-5.8 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dy MCAST=
=3Dn BATMAN_V=3Dy
 * sparse linux-5.9 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=3Dn MCAST=
=3Dy BATMAN_V=3Dy
 * sparse linux-5.9 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3Dy MCAST=
=3Dn BATMAN_V=3Dn
 * sparse linux-5.9 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dn NC=3Dn MCAST=
=3Dy BATMAN_V=3Dn
 * sparse linux-5.9 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dy NC=3Dn MCAST=
=3Dn BATMAN_V=3Dy
 * sparse linux-6.0 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3Dn MCAST=
=3Dy BATMAN_V=3Dn
 * sparse linux-6.0 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dy MCAST=
=3Dn BATMAN_V=3Dy
 * sparse linux-6.0 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dy MCAST=
=3Dy BATMAN_V=3Dy
 * sparse linux-6.0.13 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=3Dn MC=
AST=3Dn BATMAN_V=3Dn
 * sparse linux-6.0.13 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=3Dy MC=
AST=3Dn BATMAN_V=3Dy
 * sparse linux-6.0.13 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dn NC=3Dn MC=
AST=3Dn BATMAN_V=3Dn
 * sparse linux-6.1 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=3Dy MCAST=
=3Dn BATMAN_V=3Dn
 * sparse linux-6.1 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dy MCAST=
=3Dn BATMAN_V=3Dn
 * unused_symbols linux-4.10 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=
=3Dy MCAST=3Dn BATMAN_V=3Dy
 * unused_symbols linux-4.10 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dy NC=
=3Dy MCAST=3Dy BATMAN_V=3Dy
 * unused_symbols linux-4.11 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=
=3Dy MCAST=3Dy BATMAN_V=3Dn
 * unused_symbols linux-4.12 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=
=3Dy MCAST=3Dn BATMAN_V=3Dy
 * unused_symbols linux-4.12 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=
=3Dy MCAST=3Dn BATMAN_V=3Dn
 * unused_symbols linux-4.12 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=
=3Dy MCAST=3Dn BATMAN_V=3Dy
 * unused_symbols linux-4.14 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=
=3Dy MCAST=3Dn BATMAN_V=3Dy
 * unused_symbols linux-4.14 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=
=3Dy MCAST=3Dn BATMAN_V=3Dy
 * unused_symbols linux-4.14 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=
=3Dy MCAST=3Dy BATMAN_V=3Dy
 * unused_symbols linux-4.14.302 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dy=
 NC=3Dy MCAST=3Dn BATMAN_V=3Dn
 * unused_symbols linux-4.15 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dy NC=
=3Dy MCAST=3Dy BATMAN_V=3Dn
 * unused_symbols linux-4.15 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=
=3Dy MCAST=3Dn BATMAN_V=3Dn
 * unused_symbols linux-4.15 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=
=3Dy MCAST=3Dy BATMAN_V=3Dn
 * unused_symbols linux-4.16 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=
=3Dy MCAST=3Dy BATMAN_V=3Dy
 * unused_symbols linux-4.18 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dy NC=
=3Dy MCAST=3Dn BATMAN_V=3Dy
 * unused_symbols linux-4.18 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=
=3Dy MCAST=3Dn BATMAN_V=3Dy
 * unused_symbols linux-4.19.269 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dn=
 NC=3Dy MCAST=3Dn BATMAN_V=3Dn
 * unused_symbols linux-4.19.269 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dn=
 NC=3Dy MCAST=3Dy BATMAN_V=3Dn
 * unused_symbols linux-4.19.269 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dn=
 NC=3Dy MCAST=3Dn BATMAN_V=3Dy
 * unused_symbols linux-4.19.269 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dy=
 NC=3Dy MCAST=3Dn BATMAN_V=3Dn
 * unused_symbols linux-4.9 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=
=3Dy MCAST=3Dn BATMAN_V=3Dn
 * unused_symbols linux-4.9 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=
=3Dy MCAST=3Dy BATMAN_V=3Dy
 * unused_symbols linux-4.9 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=
=3Dy MCAST=3Dn BATMAN_V=3Dy
 * unused_symbols linux-4.9 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=
=3Dy MCAST=3Dn BATMAN_V=3Dy
 * unused_symbols linux-4.9 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=
=3Dy MCAST=3Dn BATMAN_V=3Dn
 * unused_symbols linux-4.9.336 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dy =
NC=3Dy MCAST=3Dy BATMAN_V=3Dn
 * unused_symbols linux-5.0 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=
=3Dy MCAST=3Dn BATMAN_V=3Dn
 * unused_symbols linux-5.0 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=
=3Dy MCAST=3Dy BATMAN_V=3Dn
 * unused_symbols linux-5.1 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=
=3Dy MCAST=3Dn BATMAN_V=3Dy
 * unused_symbols linux-5.10 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dy NC=
=3Dy MCAST=3Dy BATMAN_V=3Dn
 * unused_symbols linux-5.10 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=
=3Dy MCAST=3Dy BATMAN_V=3Dn
 * unused_symbols linux-5.10.159 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dy=
 NC=3Dy MCAST=3Dy BATMAN_V=3Dy
 * unused_symbols linux-5.11 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=
=3Dy MCAST=3Dn BATMAN_V=3Dn
 * unused_symbols linux-5.13 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=
=3Dy MCAST=3Dn BATMAN_V=3Dy
 * unused_symbols linux-5.13 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=
=3Dy MCAST=3Dy BATMAN_V=3Dy
 * unused_symbols linux-5.13 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=
=3Dy MCAST=3Dn BATMAN_V=3Dy
 * unused_symbols linux-5.13 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=
=3Dy MCAST=3Dn BATMAN_V=3Dn
 * unused_symbols linux-5.13 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=
=3Dy MCAST=3Dy BATMAN_V=3Dy
 * unused_symbols linux-5.13 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=
=3Dy MCAST=3Dn BATMAN_V=3Dn
 * unused_symbols linux-5.13 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=
=3Dy MCAST=3Dy BATMAN_V=3Dn
 * unused_symbols linux-5.14 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=
=3Dy MCAST=3Dn BATMAN_V=3Dn
 * unused_symbols linux-5.14 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=
=3Dy MCAST=3Dn BATMAN_V=3Dy
 * unused_symbols linux-5.14 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=
=3Dy MCAST=3Dn BATMAN_V=3Dy
 * unused_symbols linux-5.14 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=
=3Dy MCAST=3Dy BATMAN_V=3Dy
 * unused_symbols linux-5.15 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=
=3Dy MCAST=3Dy BATMAN_V=3Dn
 * unused_symbols linux-5.15 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=
=3Dy MCAST=3Dy BATMAN_V=3Dy
 * unused_symbols linux-5.15.83 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dn =
NC=3Dy MCAST=3Dy BATMAN_V=3Dy
 * unused_symbols linux-5.15.83 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy =
NC=3Dy MCAST=3Dn BATMAN_V=3Dn
 * unused_symbols linux-5.15.83 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy =
NC=3Dy MCAST=3Dy BATMAN_V=3Dn
 * unused_symbols linux-5.16 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=
=3Dy MCAST=3Dn BATMAN_V=3Dn
 * unused_symbols linux-5.16 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=
=3Dy MCAST=3Dy BATMAN_V=3Dy
 * unused_symbols linux-5.19 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dy NC=
=3Dy MCAST=3Dy BATMAN_V=3Dy
 * unused_symbols linux-5.19 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dn NC=
=3Dy MCAST=3Dn BATMAN_V=3Dn
 * unused_symbols linux-5.2 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=
=3Dy MCAST=3Dy BATMAN_V=3Dn
 * unused_symbols linux-5.3 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dn NC=
=3Dy MCAST=3Dn BATMAN_V=3Dn
 * unused_symbols linux-5.3 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=
=3Dy MCAST=3Dn BATMAN_V=3Dy
 * unused_symbols linux-5.4 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=
=3Dy MCAST=3Dn BATMAN_V=3Dy
 * unused_symbols linux-5.4 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dn NC=
=3Dy MCAST=3Dn BATMAN_V=3Dy
 * unused_symbols linux-5.4 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dn NC=
=3Dy MCAST=3Dy BATMAN_V=3Dy
 * unused_symbols linux-5.4.227 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dn =
NC=3Dy MCAST=3Dy BATMAN_V=3Dy
 * unused_symbols linux-5.5 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=
=3Dy MCAST=3Dn BATMAN_V=3Dn
 * unused_symbols linux-5.6 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=
=3Dy MCAST=3Dy BATMAN_V=3Dn
 * unused_symbols linux-5.6 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dn NC=
=3Dy MCAST=3Dy BATMAN_V=3Dn
 * unused_symbols linux-5.6 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=
=3Dy MCAST=3Dn BATMAN_V=3Dy
 * unused_symbols linux-5.7 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=
=3Dy MCAST=3Dy BATMAN_V=3Dy
 * unused_symbols linux-5.8 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=
=3Dy MCAST=3Dn BATMAN_V=3Dy
 * unused_symbols linux-5.9 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=
=3Dy MCAST=3Dn BATMAN_V=3Dn
 * unused_symbols linux-6.0 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=
=3Dy MCAST=3Dn BATMAN_V=3Dy
 * unused_symbols linux-6.0 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=
=3Dy MCAST=3Dy BATMAN_V=3Dy
 * unused_symbols linux-6.0.13 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy N=
C=3Dy MCAST=3Dn BATMAN_V=3Dy
 * unused_symbols linux-6.1 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=
=3Dy MCAST=3Dn BATMAN_V=3Dn
 * unused_symbols linux-6.1 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=
=3Dy MCAST=3Dn BATMAN_V=3Dn


Output of different failed tests
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

ecsv/pu: headers
=2D---------------

    diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
    index cbf7ac9e..d541532b 100644
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
    diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-inte=
rface.c
    index c2fa0ef5..cd04ab27 100644
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

ecsv/pu: sparse linux-4.10 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dy NC=3D=
y MCAST=3Dy BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44: warning: incorrect type in argument 4 (different base types)
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44:    expected int ( *mptr )( ... )
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44:    got int
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:162:37: error: not enough arguments for function batadv_tvlv_handler_r=
egister
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:295: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:553: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1490: _module_/home/build_test/build_env/tmp.Oxs=
OqWL6gH] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-4.10 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3D=
n MCAST=3Dn BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:26:=
 error: Expected ; at end of statement
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:26:=
 error: got int
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:17:=
 error: undefined identifier 'u8'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:21:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:398:17:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:401:64:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:17:=
 error: undefined identifier 'unsigned'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:413:17:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:414:45:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:415:47:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    make[3]: *** [scripts/Makefile.build:295: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:553: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1490: _module_/home/build_test/build_env/tmp.Oxs=
OqWL6gH] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-4.11 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3D=
y MCAST=3Dy BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44: warning: incorrect type in argument 4 (different base types)
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44:    expected int ( *mptr )( ... )
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44:    got int
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:162:37: error: not enough arguments for function batadv_tvlv_handler_r=
egister
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:295: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:553: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1492: _module_/home/build_test/build_env/tmp.Oxs=
OqWL6gH] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-4.11 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=3D=
n MCAST=3Dy BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:26:=
 error: Expected ; at end of statement
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:26:=
 error: got int
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:17:=
 error: undefined identifier 'u8'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:21:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:398:17:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:401:64:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:17:=
 error: undefined identifier 'unsigned'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:413:17:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:414:45:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:415:47:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    make[3]: *** [scripts/Makefile.build:295: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:553: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1492: _module_/home/build_test/build_env/tmp.Oxs=
OqWL6gH] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-4.12 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=3D=
y MCAST=3Dn BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44: warning: incorrect type in argument 4 (different base types)
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44:    expected int ( *mptr )( ... )
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44:    got int
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:162:37: error: not enough arguments for function batadv_tvlv_handler_r=
egister
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:303: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:561: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1512: _module_/home/build_test/build_env/tmp.Oxs=
OqWL6gH] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-4.13 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=3D=
n MCAST=3Dy BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:26:=
 error: Expected ; at end of statement
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:26:=
 error: got int
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:17:=
 error: undefined identifier 'u8'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:21:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:398:17:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:401:64:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:17:=
 error: undefined identifier 'unsigned'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:413:17:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:414:45:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:415:47:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    make[3]: *** [scripts/Makefile.build:303: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:561: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1512: _module_/home/build_test/build_env/tmp.Oxs=
OqWL6gH] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-4.14 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=3D=
n MCAST=3Dy BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:26:=
 error: Expected ; at end of statement
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:26:=
 error: got int
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:17:=
 error: undefined identifier 'u8'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:21:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:398:17:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:401:64:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:17:=
 error: undefined identifier 'unsigned'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:413:17:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:414:45:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:415:47:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    make[3]: *** [scripts/Makefile.build:315: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:573: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1503: _module_/home/build_test/build_env/tmp.Oxs=
OqWL6gH] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-4.14 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3D=
y MCAST=3Dy BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44: warning: incorrect type in argument 4 (different base types)
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44:    expected int ( *mptr )( ... )
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44:    got int
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:162:37: error: not enough arguments for function batadv_tvlv_handler_r=
egister
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:315: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:573: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1503: _module_/home/build_test/build_env/tmp.Oxs=
OqWL6gH] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-4.14.302 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dy N=
C=3Dy MCAST=3Dn BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44: warning: incorrect type in argument 4 (different base types)
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44:    expected int ( *mptr )( ... )
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44:    got int
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:162:37: error: not enough arguments for function batadv_tvlv_handler_r=
egister
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:330: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:588: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1556: _module_/home/build_test/build_env/tmp.Oxs=
OqWL6gH] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-4.14.302 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dn N=
C=3Dn MCAST=3Dy BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:26:=
 error: Expected ; at end of statement
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:26:=
 error: got int
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:17:=
 error: undefined identifier 'u8'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:21:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:398:17:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:401:64:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:17:=
 error: undefined identifier 'unsigned'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:413:17:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:414:45:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:415:47:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    make[3]: *** [scripts/Makefile.build:330: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:588: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1556: _module_/home/build_test/build_env/tmp.Oxs=
OqWL6gH] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-4.15 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=3D=
y MCAST=3Dy BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44: warning: incorrect type in argument 4 (different base types)
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44:    expected int ( *mptr )( ... )
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44:    got int
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:162:37: error: not enough arguments for function batadv_tvlv_handler_r=
egister
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:317: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:575: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1508: _module_/home/build_test/build_env/tmp.Oxs=
OqWL6gH] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-4.16 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3D=
n MCAST=3Dn BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:26:=
 error: Expected ; at end of statement
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:26:=
 error: got int
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:17:=
 error: undefined identifier 'u8'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:21:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:398:17:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:401:64:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:17:=
 error: undefined identifier 'unsigned'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:413:17:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:414:45:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:415:47:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    make[3]: *** [scripts/Makefile.build:323: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:581: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1556: _module_/home/build_test/build_env/tmp.Oxs=
OqWL6gH] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-4.16 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=3D=
y MCAST=3Dy BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44: warning: incorrect type in argument 4 (different base types)
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44:    expected int ( *mptr )( ... )
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44:    got int
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:162:37: error: not enough arguments for function batadv_tvlv_handler_r=
egister
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:323: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:581: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1556: _module_/home/build_test/build_env/tmp.Oxs=
OqWL6gH] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-4.17 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3D=
n MCAST=3Dn BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:26:=
 error: Expected ; at end of statement
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:26:=
 error: got int
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:17:=
 error: undefined identifier 'u8'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:21:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:398:17:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:401:64:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:17:=
 error: undefined identifier 'unsigned'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:413:17:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:414:45:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:415:47:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    make[3]: *** [scripts/Makefile.build:313: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:559: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1571: _module_/home/build_test/build_env/tmp.Oxs=
OqWL6gH] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-4.18 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=3D=
y MCAST=3Dn BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44: warning: incorrect type in argument 4 (different base types)
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44:    expected int ( *mptr )( ... )
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44:    got int
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:162:37: error: not enough arguments for function batadv_tvlv_handler_r=
egister
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:318: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:558: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1500: _module_/home/build_test/build_env/tmp.Oxs=
OqWL6gH] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-4.18 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3D=
n MCAST=3Dy BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:26:=
 error: Expected ; at end of statement
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:26:=
 error: got int
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:17:=
 error: undefined identifier 'u8'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:21:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:398:17:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:401:64:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:17:=
 error: undefined identifier 'unsigned'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:413:17:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:414:45:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:415:47:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    make[3]: *** [scripts/Makefile.build:318: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:558: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1500: _module_/home/build_test/build_env/tmp.Oxs=
OqWL6gH] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-4.19 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=3D=
n MCAST=3Dy BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:26:=
 error: Expected ; at end of statement
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:26:=
 error: got int
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:17:=
 error: undefined identifier 'u8'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:21:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:398:17:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:401:64:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:17:=
 error: undefined identifier 'unsigned'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:413:17:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:414:45:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:415:47:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    make[3]: *** [scripts/Makefile.build:306: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:546: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1517: _module_/home/build_test/build_env/tmp.Oxs=
OqWL6gH] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-4.19.269 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dn N=
C=3Dy MCAST=3Dn BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44: warning: incorrect type in argument 4 (different base types)
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44:    expected int ( *mptr )( ... )
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44:    got int
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:162:37: error: not enough arguments for function batadv_tvlv_handler_r=
egister
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:304: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:544: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1551: _module_/home/build_test/build_env/tmp.Oxs=
OqWL6gH] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-4.9 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=3Dy=
 MCAST=3Dn BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44: warning: incorrect type in argument 4 (different base types)
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44:    expected int ( *mptr )( ... )
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44:    got int
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:162:37: error: not enough arguments for function batadv_tvlv_handler_r=
egister
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:294: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:544: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1490: _module_/home/build_test/build_env/tmp.Oxs=
OqWL6gH] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-4.9.336 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=
=3Dy MCAST=3Dy BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44: warning: incorrect type in argument 4 (different base types)
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44:    expected int ( *mptr )( ... )
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44:    got int
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:162:37: error: not enough arguments for function batadv_tvlv_handler_r=
egister
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:308: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:558: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1544: _module_/home/build_test/build_env/tmp.Oxs=
OqWL6gH] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.0 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dy=
 MCAST=3Dn BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44: warning: incorrect type in argument 4 (different base types)
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44:    expected int ( *mptr )( ... )
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44:    got int
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:162:37: error: not enough arguments for function batadv_tvlv_handler_r=
egister
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:277: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:492: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1553: _module_/home/build_test/build_env/tmp.Oxs=
OqWL6gH] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.1 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=3Dy=
 MCAST=3Dn BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44: warning: incorrect type in argument 4 (different base types)
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44:    expected int ( *mptr )( ... )
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44:    got int
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:162:37: error: not enough arguments for function batadv_tvlv_handler_r=
egister
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:276: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:486: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1571: _module_/home/build_test/build_env/tmp.Oxs=
OqWL6gH] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.10 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dn NC=3D=
n MCAST=3Dy BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:398:7: =
warning: this statement may fall through [-Wimplicit-fallthrough=3D]
       src =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->src;
       ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:404:2: =
note: here
      case BATADV_MCAST:
      ^~~~
    make[3]: *** [scripts/Makefile.build:279: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:496: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1805: /home/build_test/build_env/tmp.OxsOqWL6gH]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.10 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3D=
y MCAST=3Dy BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:279: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:496: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1805: /home/build_test/build_env/tmp.OxsOqWL6gH]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.10.159 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dy N=
C=3Dy MCAST=3Dy BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:286: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:503: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1837: /home/build_test/build_env/tmp.OxsOqWL6gH]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.10.159 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dn N=
C=3Dn MCAST=3Dy BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:398:7: =
warning: this statement may fall through [-Wimplicit-fallthrough=3D]
       src =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->src;
       ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:404:2: =
note: here
      case BATADV_MCAST:
      ^~~~
    make[3]: *** [scripts/Makefile.build:286: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:503: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1837: /home/build_test/build_env/tmp.OxsOqWL6gH]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.11 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3D=
y MCAST=3Dn BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:279: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:496: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1800: /home/build_test/build_env/tmp.OxsOqWL6gH]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.11 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dn NC=3D=
n MCAST=3Dy BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:398:7: =
warning: this statement may fall through [-Wimplicit-fallthrough=3D]
       src =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->src;
       ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:404:2: =
note: here
      case BATADV_MCAST:
      ^~~~
    make[3]: *** [scripts/Makefile.build:279: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:496: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1800: /home/build_test/build_env/tmp.OxsOqWL6gH]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.12 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=3D=
n MCAST=3Dy BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:398:7: =
warning: this statement may fall through [-Wimplicit-fallthrough=3D]
       src =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->src;
       ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:404:2: =
note: here
      case BATADV_MCAST:
      ^~~~
    make[3]: *** [scripts/Makefile.build:271: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:514: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1851: /home/build_test/build_env/tmp.OxsOqWL6gH]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.13 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=3D=
y MCAST=3Dy BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:272: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:515: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1847: /home/build_test/build_env/tmp.OxsOqWL6gH]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.13 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=3D=
n MCAST=3Dy BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:398:7: =
warning: this statement may fall through [-Wimplicit-fallthrough=3D]
       src =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->src;
       ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:404:2: =
note: here
      case BATADV_MCAST:
      ^~~~
    make[3]: *** [scripts/Makefile.build:272: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:515: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1847: /home/build_test/build_env/tmp.OxsOqWL6gH]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.14 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=3D=
y MCAST=3Dn BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:271: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:514: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1851: /home/build_test/build_env/tmp.OxsOqWL6gH]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.15 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3D=
y MCAST=3Dy BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:277: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:540: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1868: /home/build_test/build_env/tmp.OxsOqWL6gH]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.15.83 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=
=3Dy MCAST=3Dn BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:289: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:552: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1902: /home/build_test/build_env/tmp.OxsOqWL6gH]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.16 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3D=
y MCAST=3Dn BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:287: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:549: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1846: /home/build_test/build_env/tmp.OxsOqWL6gH]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.16 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3D=
n MCAST=3Dy BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:398:7: =
warning: this statement may fall through [-Wimplicit-fallthrough=3D]
       src =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->src;
       ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:404:2: =
note: here
      case BATADV_MCAST:
      ^~~~
    make[3]: *** [scripts/Makefile.build:287: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:549: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1846: /home/build_test/build_env/tmp.OxsOqWL6gH]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.17 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dy NC=3D=
n MCAST=3Dy BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:398:7: =
warning: this statement may fall through [-Wimplicit-fallthrough=3D]
       src =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->src;
       ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:404:2: =
note: here
      case BATADV_MCAST:
      ^~~~
    make[3]: *** [scripts/Makefile.build:288: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:550: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1831: /home/build_test/build_env/tmp.OxsOqWL6gH]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.18 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3D=
n MCAST=3Dy BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:398:7: =
warning: this statement may fall through [-Wimplicit-fallthrough=3D]
       src =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->src;
       ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:404:2: =
note: here
      case BATADV_MCAST:
      ^~~~
    make[3]: *** [scripts/Makefile.build:288: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:550: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1834: /home/build_test/build_env/tmp.OxsOqWL6gH]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.19 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=3Dy NC=3D=
n MCAST=3Dn BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:398:7: =
warning: this statement may fall through [-Wimplicit-fallthrough=3D]
       src =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->src;
       ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:404:2: =
note: here
      case BATADV_MCAST:
      ^~~~
    make[3]: *** [scripts/Makefile.build:249: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:466: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1843: /home/build_test/build_env/tmp.OxsOqWL6gH]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.19 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dn NC=3D=
y MCAST=3Dn BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:249: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:466: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1843: /home/build_test/build_env/tmp.OxsOqWL6gH]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.2 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3Dn=
 MCAST=3Dy BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:26:=
 error: Expected ; at end of statement
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:26:=
 error: got int
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:17:=
 error: undefined identifier 'u8'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:21:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:398:17:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:401:64:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:17:=
 error: undefined identifier 'unsigned'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:413:17:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:414:45:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:415:47:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    make[3]: *** [scripts/Makefile.build:279: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:489: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1595: _module_/home/build_test/build_env/tmp.Oxs=
OqWL6gH] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.2 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=3Dy=
 MCAST=3Dy BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44: warning: incorrect type in argument 4 (different base types)
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44:    expected int ( *mptr )( ... )
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44:    got int
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:162:37: error: not enough arguments for function batadv_tvlv_handler_r=
egister
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:279: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:489: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1595: _module_/home/build_test/build_env/tmp.Oxs=
OqWL6gH] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.3 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dy=
 MCAST=3Dn BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44: warning: incorrect type in argument 4 (different base types)
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44:    expected int ( *mptr )( ... )
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44:    got int
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:162:37: error: not enough arguments for function batadv_tvlv_handler_r=
egister
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:281: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:497: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1624: _module_/home/build_test/build_env/tmp.Oxs=
OqWL6gH] Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.4 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=3Dn=
 MCAST=3Dn BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:26:=
 error: Expected ; at end of statement
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:26:=
 error: got int
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:17:=
 error: undefined identifier 'u8'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:21:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:398:17:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:401:64:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:17:=
 error: undefined identifier 'unsigned'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:413:17:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:414:45:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:415:47:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:398:7: =
warning: this statement may fall through [-Wimplicit-fallthrough=3D]
       src =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->src;
       ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:404:2: =
note: here
      case BATADV_MCAST:
      ^~~~
    make[3]: *** [scripts/Makefile.build:266: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:509: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1652: /home/build_test/build_env/tmp.OxsOqWL6gH]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.4 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=3Dy=
 MCAST=3Dn BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44: warning: incorrect type in argument 4 (different base types)
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44:    expected int ( *mptr )( ... )
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44:    got int
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:162:37: error: not enough arguments for function batadv_tvlv_handler_r=
egister
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:266: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:509: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1652: /home/build_test/build_env/tmp.OxsOqWL6gH]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.4.227 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=
=3Dn MCAST=3Dn BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:398:7: =
warning: this statement may fall through [-Wimplicit-fallthrough=3D]
       src =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->src;
       ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:404:2: =
note: here
      case BATADV_MCAST:
      ^~~~
    make[3]: *** [scripts/Makefile.build:262: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:497: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1739: /home/build_test/build_env/tmp.OxsOqWL6gH]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.4.227 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dn NC=
=3Dy MCAST=3Dy BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:262: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:497: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1739: /home/build_test/build_env/tmp.OxsOqWL6gH]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.5 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=3Dy=
 MCAST=3Dn BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44: warning: incorrect type in argument 4 (different base types)
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44:    expected int ( *mptr )( ... )
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44:    got int
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:162:37: error: not enough arguments for function batadv_tvlv_handler_r=
egister
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:266: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:503: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1693: /home/build_test/build_env/tmp.OxsOqWL6gH]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.6 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=3Dn=
 MCAST=3Dy BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:26:=
 error: Expected ; at end of statement
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:26:=
 error: got int
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:17:=
 error: undefined identifier 'u8'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:21:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:398:17:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:401:64:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:17:=
 error: undefined identifier 'unsigned'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:413:17:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:414:45:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:415:47:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:398:7: =
warning: this statement may fall through [-Wimplicit-fallthrough=3D]
       src =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->src;
       ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:404:2: =
note: here
      case BATADV_MCAST:
      ^~~~
    make[3]: *** [scripts/Makefile.build:268: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:505: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1683: /home/build_test/build_env/tmp.OxsOqWL6gH]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.6 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dy=
 MCAST=3Dn BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44: warning: incorrect type in argument 4 (different base types)
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44:    expected int ( *mptr )( ... )
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44:    got int
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:162:37: error: not enough arguments for function batadv_tvlv_handler_r=
egister
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:268: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:505: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1683: /home/build_test/build_env/tmp.OxsOqWL6gH]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.7 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=3Dn=
 MCAST=3Dy BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:26:=
 error: Expected ; at end of statement
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:26:=
 error: got int
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:17:=
 error: undefined identifier 'u8'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:21:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:398:17:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:401:64:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:17:=
 error: undefined identifier 'unsigned'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:413:17:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:414:45:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:415:47:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:398:7: =
warning: this statement may fall through [-Wimplicit-fallthrough=3D]
       src =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->src;
       ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:404:2: =
note: here
      case BATADV_MCAST:
      ^~~~
    make[3]: *** [scripts/Makefile.build:267: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:488: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1729: /home/build_test/build_env/tmp.OxsOqWL6gH]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.7 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=3Dy NC=3Dy=
 MCAST=3Dy BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44: warning: incorrect type in argument 4 (different base types)
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44:    expected int ( *mptr )( ... )
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44:    got int
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:162:37: error: not enough arguments for function batadv_tvlv_handler_r=
egister
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:267: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:488: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1729: /home/build_test/build_env/tmp.OxsOqWL6gH]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.8 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3Dn NC=3Dn=
 MCAST=3Dn BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:17:=
 error: typename in expression
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:26:=
 error: Expected ; at end of statement
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:26:=
 error: got int
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:17:=
 error: undefined identifier 'u8'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:21:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:398:17:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:401:64:=
 error: undefined identifier 'src'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:17:=
 error: undefined identifier 'unsigned'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:413:17:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:414:45:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:415:47:=
 error: undefined identifier 'tvlv_offset'
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:398:7: =
warning: this statement may fall through [-Wimplicit-fallthrough=3D]
       src =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->src;
       ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:404:2: =
note: here
      case BATADV_MCAST:
      ^~~~
    make[3]: *** [scripts/Makefile.build:281: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:497: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1756: /home/build_test/build_env/tmp.OxsOqWL6gH]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.8 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dy=
 MCAST=3Dn BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44: warning: incorrect type in argument 4 (different base types)
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44:    expected int ( *mptr )( ... )
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:44:    got int
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:162:37: error: not enough arguments for function batadv_tvlv_handler_r=
egister
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:281: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:497: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1756: /home/build_test/build_env/tmp.OxsOqWL6gH]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.9 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3Dn NC=3Dy=
 MCAST=3Dn BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:283: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:500: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1784: /home/build_test/build_env/tmp.OxsOqWL6gH]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-5.9 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dn NC=3Dn=
 MCAST=3Dy BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:398:7: =
warning: this statement may fall through [-Wimplicit-fallthrough=3D]
       src =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->src;
       ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:404:2: =
note: here
      case BATADV_MCAST:
      ^~~~
    make[3]: *** [scripts/Makefile.build:283: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:500: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1784: /home/build_test/build_env/tmp.OxsOqWL6gH]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-6.0.13 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=3Dy NC=
=3Dy MCAST=3Dn BATMAN_V=3Dy
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:249: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:465: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1852: /home/build_test/build_env/tmp.OxsOqWL6gH]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-6.0.13 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=3Dn NC=
=3Dn MCAST=3Dn BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c: In fun=
ction =E2=80=98batadv_tvlv_call_handler=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:389:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       u8 *src;
       ^~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:390:3: =
error: expected expression before =E2=80=98u8=E2=80=99
       u8 *dst;
       ^~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:399:3: =
error: =E2=80=98dst=E2=80=99 undeclared (first use in this function)
       dst =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->dst;
       ^~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:399:3: =
note: each undeclared identifier is reported only once for each function it=
 appears in
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:405:3: =
error: a label can only be part of a statement and a declaration is not a s=
tatement
       unsigned int tvlv_offset;
       ^~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:398:7: =
warning: this statement may fall through [-Wimplicit-fallthrough=3D]
       src =3D ((struct batadv_unicast_tvlv_packet *)skb->data)->src;
       ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.c:404:2: =
note: here
      case BATADV_MCAST:
      ^~~~
    make[3]: *** [scripts/Makefile.build:249: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/tvlv.o] Error 1
    make[2]: *** [scripts/Makefile.build:465: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1852: /home/build_test/build_env/tmp.OxsOqWL6gH]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: sparse linux-6.1 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=3Dy NC=3Dy=
 MCAST=3Dn BATMAN_V=3Dn
=2D------------------------------------------------------------------------=
=2D-

    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec: In function =E2=80=98batadv_nc_mesh_init=E2=80=99:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:163:16: warning: passing argument 4 of =E2=80=98batadv_tvlv_handler_re=
gister=E2=80=99 makes pointer from integer without a cast [-Wint-conversion]
              NULL, BATADV_TVLV_NC, 1,
                    ^~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:37:13: =
note: expected =E2=80=98int (*)(struct batadv_priv *, struct sk_buff *)=E2=
=80=99 but argument is of type =E2=80=98int=E2=80=99
           int (*mptr)(struct batadv_priv *bat_priv,
           ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                struct sk_buff *skb),
                ~~~~~~~~~~~~~~~~~~~~
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/network-coding=
=2Ec:162:2: error: too few arguments to function =E2=80=98batadv_tvlv_handl=
er_register=E2=80=99
      batadv_tvlv_handler_register(bat_priv, batadv_nc_tvlv_ogm_handler_v1,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from /home/build_test/build_env/tmp.OxsOqWL6gH/net/bat=
man-adv/network-coding.c:45:
    /home/build_test/build_env/tmp.OxsOqWL6gH/net/batman-adv/tvlv.h:27:6: n=
ote: declared here
     void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
    make[3]: *** [scripts/Makefile.build:250: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv/network-coding.o] Error 1
    make[2]: *** [scripts/Makefile.build:500: /home/build_test/build_env/tm=
p.OxsOqWL6gH/net/batman-adv] Error 2
    make[1]: *** [Makefile:1992: /home/build_test/build_env/tmp.OxsOqWL6gH]=
 Error 2
    make: *** [Makefile:68: all] Error 2

ecsv/pu: unused_symbols linux-4.11 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dy TRACING=
=3Dy NC=3Dy MCAST=3Dy BATMAN_V=3Dn
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
    batadv_mcast_forw_mode
    batadv_mcast_forw_send
    batadv_mcast_purge_orig
    batadv_mesh_free
    batadv_mesh_init
    batadv_netlink_tpmeter_notify
    batadv_routing_algo
    batadv_skb_set_priority
    batadv_vlan_ap_isola_get

ecsv/pu: unused_symbols linux-4.12 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=
=3Dy NC=3Dy MCAST=3Dn BATMAN_V=3Dy
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

ecsv/pu: unused_symbols linux-4.14 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dy TRACING=
=3Dy NC=3Dy MCAST=3Dy BATMAN_V=3Dy
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

ecsv/pu: unused_symbols linux-4.15 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dn TRACING=
=3Dy NC=3Dy MCAST=3Dy BATMAN_V=3Dn
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
    batadv_is_my_mac
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

ecsv/pu: unused_symbols linux-4.15 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACING=
=3Dy NC=3Dy MCAST=3Dy BATMAN_V=3Dn
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
    batadv_hardif_no_broadcast
    batadv_is_my_mac
    batadv_mcast_forw_mode
    batadv_mcast_forw_send
    batadv_mcast_purge_orig
    batadv_mesh_free
    batadv_mesh_init
    batadv_netlink_tpmeter_notify
    batadv_routing_algo
    batadv_skb_set_priority
    batadv_vlan_ap_isola_get

ecsv/pu: unused_symbols linux-4.19.269 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACI=
NG=3Dn NC=3Dy MCAST=3Dn BATMAN_V=3Dn
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

ecsv/pu: unused_symbols linux-4.9 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=3D=
n NC=3Dy MCAST=3Dn BATMAN_V=3Dy
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

ecsv/pu: unused_symbols linux-5.13 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=
=3Dn NC=3Dy MCAST=3Dn BATMAN_V=3Dy
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

ecsv/pu: unused_symbols linux-5.13 cfg: BLA=3Dn DAT=3Dn DEBUG=3Dy TRACING=
=3Dy NC=3Dy MCAST=3Dy BATMAN_V=3Dy
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

ecsv/pu: unused_symbols linux-5.13 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dn TRACING=
=3Dn NC=3Dy MCAST=3Dy BATMAN_V=3Dy
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

ecsv/pu: unused_symbols linux-5.13 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=
=3Dn NC=3Dy MCAST=3Dn BATMAN_V=3Dn
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

ecsv/pu: unused_symbols linux-5.13 cfg: BLA=3Dy DAT=3Dy DEBUG=3Dn TRACING=
=3Dy NC=3Dy MCAST=3Dy BATMAN_V=3Dn
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
    batadv_is_my_mac
    batadv_mcast_forw_mode
    batadv_mcast_forw_send
    batadv_mcast_purge_orig
    batadv_mesh_free
    batadv_mesh_init
    batadv_netlink_tpmeter_notify
    batadv_routing_algo
    batadv_skb_set_priority
    batadv_vlan_ap_isola_get

ecsv/pu: unused_symbols linux-5.15 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=
=3Dn NC=3Dy MCAST=3Dy BATMAN_V=3Dy
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

ecsv/pu: unused_symbols linux-5.15.83 cfg: BLA=3Dy DAT=3Dn DEBUG=3Dy TRACIN=
G=3Dy NC=3Dy MCAST=3Dn BATMAN_V=3Dn
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

ecsv/pu: unused_symbols linux-5.4 cfg: BLA=3Dn DAT=3Dy DEBUG=3Dn TRACING=3D=
y NC=3Dy MCAST=3Dn BATMAN_V=3Dy
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


Statistics
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

ecsv/pu
=2D------

=46ailed tests:               198
Started build tests:        126
Tested Linux versions:       40
Tested configs:              81

--nextPart10398328.nUPlyArG6x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmOp2vAACgkQXYcKB8Em
e0ZpIA/9F2WqjqgHyxqwC+YA3qJ/N5cX25FjzFLqiPhMtF9dzovzGiNwXAA4io/W
9OSjwIa9vgMX7gtbxRN7QG1/0ObUAkKA2zcE/TU9QDk4X2B9SPXZ7089tqrQZKQJ
JWGNju8LuD12+BhSO7jEg766CxGbRsmbCX9EualOE62+GnDKE87n5lEpyssZCBq3
FogIRZVnXpqhPlO35HcGwgOxzu9momJ/5Tzuri16lYP8iH2IQaZZO0YWEVOFtfE3
7cPxi4d0N1IarbDxyumlgt92jcbi72Hsb/6ZVh5wdMY6Z/veWyU9mGlT5iMnXndh
Fnx6A50ejuepbSKupvvlelL+b6hl3xwHO7w3LmdE71KslNSAxx4xNnnbMrc8iREU
P6kBye+SouzSFVXpovnOxvukAC8MdCmel0QfFLSzU14SRScXAM8cFzSVEnisxjhU
jcvddruVnoUWL4TaAp2h7o7aVo09zxs/aJUCuUgSj8hu4/zYpvchCY4q5iqTUCLJ
OoN7KSYDSD69eugEPoJHpoQdZ/fO1hSB/kFnqrn/c9hgOF0ahOFWKW1hKkgwYeVw
OuKEx2EC6A6IiCL9ueG18zTyb1fvnKveLez8274vQirA7yOcrJvjFF/ryUIM1xU0
cK58G+1do4WWXd47NeZfLtI3WRieUcuBhahLxpxUfgtShsIju74=
=+xU+
-----END PGP SIGNATURE-----

--nextPart10398328.nUPlyArG6x--


