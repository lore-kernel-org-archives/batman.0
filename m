Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 19 Oct 2016 11:23:26 +0200
Message-ID: <1486513.8IkNzE5oBK@bentobox>
In-Reply-To: <1470566059-3782-2-git-send-email-linus.luessing@c0d3.blue>
References: <1470566059-3782-2-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1971381.rzNsG5rk6f";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [v5,
	2/2] batman-adv: Simple (re)broadcast avoidance
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart1971381.rzNsG5rk6f
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sonntag, 7. August 2016 12:34:19 CEST Linus L=FCssing wrote:
> With this patch, (re)broadcasting on a specific interfaces is avoided:
>=20
> * No neighbor: There is no need to broadcast on an interface if there
>   is no node behind it.
>=20
> * Single neighbor is source: If there is just one neighbor on an
>   interface and if this neighbor is the one we actually got this
>   broadcast packet from, then we do not need to echo it back.
>=20
> * Single neighbor is originator: If there is just one neighbor on
>   an interface and if this neighbor is the originator of this
>   broadcast packet, then we do not need to echo it back.
>=20
> Goodies for BATMAN V:
>=20
> ("Upgrade your BATMAN IV network to V now to get these for free!")
>=20
> Thanks to the split of OGMv1 into two packet types, OGMv2 and ELP
> that is, we can now apply the same optimizations stated above to OGMv2
> packets, too.
>=20
> Furthermore, with BATMAN V, rebroadcasts can be reduced in certain
> multi interface cases, too, where BATMAN IV cannot. This is thanks to
> the removal of the "secondary interface originator" concept in BATMAN V.
>=20
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
> ---
>=20
> Changes in v5:
> * remove a skb_reset_inner_mac_header() call again which was
>   overlooked during the forw_packet->own switch in v4
>=20
> Changes in v4:
> * added @if_outgoing kerneldoc
> * removed "NULL if we originated" note for @orig_addr in kerneldoc again
> * added two @orig_node kerneldoc instances
> * substituted fancy skb_inner_mac_header stuff with boring forw_packet->o=
wn
> :)
>=20
> Changes in v3:
> * Replaced the new hardif_neigh_node's orig_node reference with a simple
>   copy of the originator's MAC address
>   -> avoids a potential dependancy cycle / memory leak (thanks Sven!)
> * style:
>   * Swapped order of arguments orig_addr/orig_neigh of new
>     batadv_hardif_no_broadcast()
>   * Added an else to avoid unnecessary, maybe confusing reassignments
>     in batadv_hardif_no_broadcast()
>=20
> Changes in v2:
> * Changed some "if"s to "switch"es (thanks Sven!)
> * Moved kref_get() closer to assignment in neigh_node_create() (thanks
> Sven!) * Added missing hardif_put() calls (urgh... thanks Sven!)
> * Added kerneldoc for new hardif_neigh_node->orig_node in types.h
> * Removed "###" in this commit message (seems like patchwork didn't like =
it)
>=20
>  net/batman-adv/bat_v_ogm.c      | 56
> +++++++++++++++++++++++++++++++++++++++++ net/batman-adv/hard-interface.c=
 |
> 52 ++++++++++++++++++++++++++++++++++++++ net/batman-adv/hard-interface.h=
 |
> 16 ++++++++++++
>  net/batman-adv/originator.c     | 13 +++++++---
>  net/batman-adv/routing.c        |  2 +-
>  net/batman-adv/send.c           | 55
> +++++++++++++++++++++++++++++++++++++++- net/batman-adv/send.h           =
|=20
> 3 ++-
>  net/batman-adv/soft-interface.c |  2 +-
>  net/batman-adv/types.h          |  2 ++
>  9 files changed, 193 insertions(+), 8 deletions(-)


Applied in a00797d8fa8fd1471e8be1ac23d506f76d866aaa [1]. I had to fix some
patch conflicts while applying it. Please check that no problems were
introduced by me.

Kind regards,
        Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/a00797d8fa8fd1471e8be1a=
c23d506f76d866aaa
--nextPart1971381.rzNsG5rk6f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYBzuOAAoJEF2HCgfBJntG8pUP/iVbQT9GF4mczghrf9iAZRf4
lrtiYFMBNFUXo4tQLqQzFoXrW36oa1EgyH742tFwvZzFvXrauG8edIujBkd0LrGm
zDe8JRT6yNcpMCkM3D2KrbKLoLNjd7fqv/Ou/OYbAcAFqgK8Fa/L6+QsyvvmayG7
EIo1dUaFtufm7tNjvlXiXeXhch64XYXgb+9/8vvLZgqQVUSlAb3auB11TeqwfQ04
Yi0/XllXiTcWn3w42B4RVqFVLZ9pBgUkRHsBkb85MPKdkZApYeoiB5kQGI+hqebL
v2r15AMsva77IL+IHBz2R3TAQhmPru3H03em9yzprITCEWnlNIn/op1Fb/cXoG2I
/pZVUfgWHvTul8/muYKsVox/NNsqX/OG797lbvJF6zWtnzMUMfHDuiicJXpPc7EN
ITq5PDBfUvciL49V7HRCNR0ZmUrP2wX/zmkAV0iHMyH0PgZODA2MGU5e0dVfkxtd
oTfsfGib/VTbjIib8tZlP3CjMJPABnE+4fgLx+lM9fM3txpWXX+lVLI7ddWKXIA4
j3o7k5yiDkBQ4dg9/2IeX5Avz8RquMbW0LK4OwjNis9pULEdYaxxyPXnzjsYmuBW
3Q8IVEqd1EKV6DmyDv0lc3Em/FoDAlHp6rMdypECGvIee+ycihYIbHwFxBSfbJWn
1H030MXgLNi7avHwNdPW
=6DxV
-----END PGP SIGNATURE-----

--nextPart1971381.rzNsG5rk6f--

