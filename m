Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 11 Jul 2014 12:42:16 +0200
References: <1405043659-9086-1-git-send-email-linus.luessing@web.de>
In-Reply-To: <1405043659-9086-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3465980.n7SW8pkDN5";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201407111242.21030.sw@simonwunderlich.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batman-adv: Add multicast optimization
	support for bridged setups
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
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart3465980.n7SW8pkDN5
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


> So far, the recently added multicast optimizations did not support
> a configuration where a bridge is on top of the soft-interface (e.g.
> bat0).
>=20
> Now the Linux bridge code is able to provide us with the missing bits:
>=20
> Multicast Listeners: The bridge hands us a list of multicast listeners
> it has detected behind the bridge which we will announce through the
> mesh via the translation table, allowing other nodes to direct multicast
> packets to these clients behind the bridge even with enabled multicast
> optimizations.
>=20
> Queriers: The bridge informs us whether there is a selected IGMP or
> MLD querier behind the bridge or if there is no querier at all. In these
> cases we need all according IPv4 or IPv6 multicast traffic directed to us.
>=20
> These two parts together allow us to serve all multicast listeners with
> IPv6 link-local multicast packets even when bridges are involved and
> our multicast optimizations enabled.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@web.de>
> ---
> Changes in v3:
> * Removed "RFC" tag in title again: The stubs and new export are upstream
>   in net-next and therefore going to be included in 3.17
> * Added some debug output:
>   * Two warning messages:
>     -> Old kernel version or no bridge IGMP/MLD snooping compiled
>   * New batman-adv log-level "mcast":
>     -> Logging mcast flag changes
>   (a third debugging facility, a new table for debugfs for a global
>    mcast flag overview will be added in a separate patch later
>    as discussed with Simon)

I've tested the previous version (PATCH RFC v2), but since the changes are=
=20
minimal you can add for this patch:

Tested-by: Simon Wunderlich <sw@simonwunderlich.de>

The test included 3 hosts bridged together=20

host1 ---[LAN]--- host2 ---[Mesh]--- host 3

with the recent net-next kernel and patches as sent by Linus previously. I =
was=20
using his listener tool [1] which creates a multicast socket on the bridged=
=2Din=20
host 1, and enabled the multicast querier [2] on host2 or host3 (only one a=
t a=20
time). Then I could verify that the desired multicast MAC address showed up=
 in=20
batctl tl on host 2, so the announcement, snooping and list retrieval of=20
batman-adv for the multicast address worked correctly. Also the "bridge" to=
ol=20
of iproute2 proved useful, "bridge mdb show" gives us the list of snooped=20
multicast listeners on the bridge.

Linus, please don't forget the batctl patch since you've added a loglevel=20
here. I'm also looking forward to the debugfs files patch, which would make=
=20
monitoring the status of the multicast operation a lot easier. :)

Cheers,
    Simon

[1] https://github.com/T-X/sm-listener
[2] echo 1 > /sys/class/net/br0/bridge/multicast_querier

--nextPart3465980.n7SW8pkDN5
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlO/v4gACgkQrzg/fFk7axYIQwCfcbTDeBBm06h3Q8SIFj2uCKVo
9EQAn2Ney+7F0YSvmChcE3lxDlxjaD8O
=8IH4
-----END PGP SIGNATURE-----

--nextPart3465980.n7SW8pkDN5--
