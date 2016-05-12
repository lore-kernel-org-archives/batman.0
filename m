Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 12 May 2016 23:14:11 +0800
Message-ID: <2831303.pd8gzeADto@voltaire>
In-Reply-To: <1462898487-9696-2-git-send-email-linus.luessing@c0d3.blue>
References: <1462898487-9696-1-git-send-email-linus.luessing@c0d3.blue>
 <1462898487-9696-2-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1728739.fP9zRxqHPF";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv15 1/4] batman-adv: Always flood IGMP/MLD
	reports
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

--nextPart1728739.fP9zRxqHPF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Tuesday, May 10, 2016 18:41:24 Linus L=FCssing wrote:
> With this patch IGMP or MLD reports are always flooded. This is
> necessary for the upcoming bridge integration to function without
> multicast packet loss.
>=20
> With the report handling so far bridges might miss interested multica=
st
> listeners, leading to wrongly excluding ports from multicast packet
> forwarding.
>=20
> Currently we are treating IGMP/MLD reports, the messages bridges use =
to
> learn about interested multicast listeners, just as any other multica=
st
> packet: We try to send them to nodes matching its multicast destinati=
on.
>=20
> Unfortunately, the destination address of reports of the older
> IGMPv2/MLDv1 protocol families do not strictly adhere to their own
> protocol: More precisely, the interested receiver, an IGMPv2 or MLDv1=

> querier, itself usually does not listen to the multicast destination
> address of any reports.
>=20
> Therefore with this patch we are simply excluding IGMP/MLD reports fr=
om
> the multicast forwarding code path and keep flooding them. By that
> any bridge receives them and can properly learn about listeners.
>=20
> To avoid compatibility issues with older nodes not yet implementing t=
his
> report handling, we need to force them to flood reports: We do this b=
y
> bumping the multicast TVLV version to 2, effectively disabling their
> multicast optimization.
>=20
> Tested-by: Simon Wunderlich <sw@simonwunderlich.de>
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> ---
>  Makefile                              |    4 +
>  compat-include/linux/igmp.h           |   13 ++
>  compat-include/linux/skbuff.h         |   14 ++
>  compat-include/net/addrconf.h         |   13 ++
>  compat-include/net/ip6_checksum.h     |   18 +++
>  compat-include/net/ipv6.h             |   17 +++
>  compat-sources/Makefile               |    3 +
>  compat-sources/net/core/skbuff.c      |  212 +++++++++++++++++++++++=
++++++
>  compat-sources/net/ipv4/igmp.c        |  241
> +++++++++++++++++++++++++++++++++ compat-sources/net/ipv6/mcast_snoop=
.c
> |  216 +++++++++++++++++++++++++++++
> net/batman-adv/Kconfig                |    2 +-
>  net/batman-adv/multicast.c            |   85 ++++++++++--
>  12 files changed, 825 insertions(+), 13 deletions(-)
>  create mode 100644 compat-include/linux/igmp.h
>  create mode 100644 compat-include/net/addrconf.h
>  create mode 100644 compat-include/net/ip6_checksum.h
>  create mode 100644 compat-include/net/ipv6.h
>  create mode 100644 compat-sources/Makefile
>  create mode 100644 compat-sources/net/core/skbuff.c
>  create mode 100644 compat-sources/net/ipv4/igmp.c
>  create mode 100644 compat-sources/net/ipv6/mcast_snoop.c

Applied in revision 08bf4dc.

Thanks,
Marek

--nextPart1728739.fP9zRxqHPF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXNJ3DAAoJEFNVTo/uthzARzEIAINNjZqfi3IU640GDwf/Vgy8
t6Mae2WqaNR0YPdR/2RmDc/BAlooBPLLvjb53vO9pAIQ6yvX+9JYh0wxhgWdEUA6
yGpmi1WBEuoCyEgEFDIP7BFuxxK0VFrhrq5cWI7VHb9Z2WjlVeIn0raE6HhpoJAa
i568JPB1WIzv1+yB581LhLdfKoWw/YtPszjYSku8Sq+hp5+9PgT6n5jKr36Ey/c7
4JKT3YzoSqiezGr3wWWuWN4mb2n6aZwEyjXDxFpDyCxfgghdo79J+0eiSlbbcfzA
6GxGgUqjWamI1X6YkICMOIBdHCr0jr1EKuWatWvYAq9qwNX0WCa93N5Yhrixc3o=
=JXTu
-----END PGP SIGNATURE-----

--nextPart1728739.fP9zRxqHPF--

