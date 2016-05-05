Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 06 May 2016 01:38:57 +0800
Message-ID: <6956681.0eiG27MfpC@voltaire>
In-Reply-To: <1462464426-13014-4-git-send-email-linus.luessing@c0d3.blue>
References: <1462464426-13014-1-git-send-email-linus.luessing@c0d3.blue>
 <1462464426-13014-4-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1842276.EoH0HCiBHi";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv14 3/4] batman-adv: Adding logging of
	mcast flag changes
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

--nextPart1842276.EoH0HCiBHi
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Thursday, May 05, 2016 17:07:04 Linus L=FCssing wrote:
> +       querier4.exists =3D br_multicast_has_querier_anywhere(dev, ET=
H_P_IP);
> +       querier4.shadowing =3D br_multicast_has_querier_adjacent(dev,=

> ETH_P_IP); +
> +       querier6.exists =3D br_multicast_has_querier_anywhere(dev,
> ETH_P_IPV6); +       querier6.shadowing =3D
> br_multicast_has_querier_adjacent(dev, ETH_P_IPV6); +
>         mcast_data.flags |=3D BATADV_MCAST_WANT_ALL_UNSNOOPABLES;
> =20
>         /* 1) If no querier exists at all, then multicast listeners o=
n
> @@ -369,17 +494,26 @@ static bool batadv_mcast_mla_tvlv_update(struct=

> batadv_priv *bat_priv) * In both cases, we will signalize other batma=
n
> nodes that * we need all multicast traffic of the according protocol.=
 */
> -       if (!br_multicast_has_querier_anywhere(dev, ETH_P_IP) ||
> -           br_multicast_has_querier_adjacent(dev, ETH_P_IP))
> +       if (!querier4.exists || querier4.shadowing)
>                 mcast_data.flags |=3D BATADV_MCAST_WANT_ALL_IPV4;
> =20
> -       if (!br_multicast_has_querier_anywhere(dev, ETH_P_IPV6) ||
> -           br_multicast_has_querier_adjacent(dev, ETH_P_IPV6))
> +       if (!querier6.exists || querier6.shadowing)
>                 mcast_data.flags |=3D BATADV_MCAST_WANT_ALL_IPV6;

Please move these variable assignments into your previous patch that=20=

introduces this section.

Thanks,
Marek

--nextPart1842276.EoH0HCiBHi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXK4UyAAoJEFNVTo/uthzAYlIIAJWAqEpovBcZJdPE6XKjojzp
MIBHPLVpagblVOoIISAgevABk8ZF5vwVIQuKyfgjDOiQLQxPwWGFbgPJOTXnz3Ac
ApJaIbtsmukzliuetiLhSQUatqjUwSt0mnnHWlDMpCwIjCHXUPvYoMNnh6EqPBfY
PNWgNvfi/orDN4KXu4QsTvic5IIHVcyFCAQ4X8vE/nHt4bTHHqhczwxIv5awV33M
mbwzp/JIX8L5L+NLfZrdz1cqXaAGjCd8Z8Mjrh0bngFEJQQYaMGA3DBz1DVxhbxv
VnxuCkgV2FkYsFdiIJ1EEaGjFZnXII3V5qh5CIxUMXSE16D2itMGmydG1tXF/Z4=
=tUYo
-----END PGP SIGNATURE-----

--nextPart1842276.EoH0HCiBHi--

