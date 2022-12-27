Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH v3 4/5] batman-adv: mcast: implement multicast packet
 generation
Date: Tue, 27 Dec 2022 10:34:22 +0100
Message-ID: <2042273.CQOukoFCf9@sven-l14>
In-Reply-To: <20221226204237.10403-5-linus.luessing@c0d3.blue>
References: <20221226204237.10403-1-linus.luessing@c0d3.blue>
 <20221226204237.10403-5-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart23108683.6Emhk5qWAg";
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

 
--nextPart23108683.6Emhk5qWAg
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Date: Tue, 27 Dec 2022 10:34:22 +0100
Message-ID: <2042273.CQOukoFCf9@sven-l14>
In-Reply-To: <20221226204237.10403-5-linus.luessing@c0d3.blue>
MIME-Version: 1.0

On Monday, 26 December 2022 21:42:36 CET Linus L=FCssing wrote:
> Implement the preparation of a batman-adv multicast packet and use this
> under certain conditions.
>=20
> For one thing this implements the capability to push a complete
> batman-adv multicast packet header, including a tracker TVLV with all
> originator destinations that have signaled interest in it, onto a given
> ethernet frame with an IP multicast packet inside.
>=20
> For another checks are implemented to determine if encapsulating a
> multicast packet in this new batman-adv multicast packet type and using
> it is feasible. Those checks are:
>=20
> 1) Have all nodes signaled that they are capable of handling the new
>    batman-adv multicast packet type?
> 2) Do all active hard interfaces of all nodes, including us, have an MTU
>    of at least 1280 bytes?
> 3) Does a complete multicast packet header with all its destination
>    addresses fit onto the given multicast packet / ethernet frame and
>    does not exceed 1280 bytes?
>=20
> If all checks passed then the new batman-adv multicast packet type will
> be used for transmission and distribution. Otherwise we fall back to one =
or
> more batman-adv unicast packet transmissions, if possible. Or if not
> possible we will fall back to classic flooding through a batman-adv
> broadcast packet.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> ---
>  net/batman-adv/multicast.c      |  79 ++++-
>  net/batman-adv/multicast.h      |  24 +-
>  net/batman-adv/multicast_forw.c | 511 ++++++++++++++++++++++++++++++++
>  net/batman-adv/soft-interface.c |   6 +-
>  net/batman-adv/types.h          |   6 +
>  5 files changed, 618 insertions(+), 8 deletions(-)

ecsv/pu: checkpatch ./net/batman-adv/multicast_forw.c
=2D----------------------------------------------------

    CHECK: Macro argument reuse 'num_dests' - possible side-effects?
    #35: FILE: ./net/batman-adv/multicast_forw.c:35:
    +#define batadv_mcast_forw_tracker_for_each_dest(dest, num_dests) \
    +   for (; num_dests; num_dests--, (dest) +=3D ETH_ALEN)
   =20
    total: 0 errors, 0 warnings, 1 checks, 785 lines checked

ecsv/pu: headers
=2D---------------

    diff --git a/net/batman-adv/multicast.h b/net/batman-adv/multicast.h
    index 0f0d79c8..4393c3a2 100644
    --- a/net/batman-adv/multicast.h
    +++ b/net/batman-adv/multicast.h
    @@ -11,6 +11,7 @@
    =20
     #include <linux/netlink.h>
     #include <linux/skbuff.h>
    +#include <linux/types.h>
    =20
     /**
      * enum batadv_forw_mode - the way a packet should be forwarded as

ecsv/pu: kerneldoc ./net/batman-adv/multicast_forw.c
=2D---------------------------------------------------

    ./net/batman-adv/multicast_forw.c:83: warning: Function parameter or me=
mber 'bat_priv' not described in 'batadv_mcast_forw_push_dest'
    ./net/batman-adv/multicast_forw.c:398: warning: Function parameter or m=
ember 'bat_priv' not described in 'batadv_mcast_forw_push_tvlvs'

--nextPart23108683.6Emhk5qWAg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmOqvB8ACgkQXYcKB8Em
e0bsOg//bi0YrgxRcbWyIFZEghNkyaRg/jgHTQzxhd6mg230ZNJ2Ne2x80Y7qURM
Rw5THa5CF4j1coKFMITXS8V8Zy3QYGffPHqVeGthIaII8/aMZgryjdawnYgetnh6
WEqjFH/qmo7bkeidHvUakia2NzyqJQ6dNfm/So0PponZVQikO50DGr7ERmEHElYN
gN9iLN78ebAU5Bpfs2Nu3e7hLz/aYg4wchdeppTG1HMjPbTGYj7BjNl/qSLIGuHi
Q0KYU7SJ+ZpfJ4IljLntwpL3xbVf2rh5SjTZiXRlZdnI6Vopk1DLzQgiYAZkElxI
SDSr81988PK6pK3XCfDDFQnAzkhg4oqOetB4YzQShhFKNEpzTIM9ZLd4eSt3iUMS
6KSOdgjjQvMclheez7nQLN7Exma5rWK+xGn7iN55NYBV/RC7aPr1iSFyqwqVDvXN
conjR0Hwm7fXtNIm+tbjmPr8a3Zg4gJ7xYqLuW/IhvmSxBeOH/mWx0Aw/ntCJwCB
97h3PRyfbGBE25q2W8y0LTARx0K+Pfkqb4Z0bEmWFOSvQkZvLhX0aSnrBCmXZgI0
tboMs9Kp0D1WIhMcRbir6QegOYieie9uhF+q9079AdGI8eJM/jMsla5Q7B8OCJd8
ti4QtcJQja+/EmotpINr6TWczwHNayoT9mf2kP/xB2MyokIghXU=
=u7KQ
-----END PGP SIGNATURE-----

--nextPart23108683.6Emhk5qWAg--


