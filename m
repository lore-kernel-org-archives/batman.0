Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 07 Apr 2016 15:03:11 +0200
Message-ID: <4820570.LxUU2Z3eNS@prime>
In-Reply-To: <1458101205-26316-2-git-send-email-linus.luessing@c0d3.blue>
References: <1458101205-26316-1-git-send-email-linus.luessing@c0d3.blue>
 <1458101205-26316-2-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1795629.n6uB1eOEIG";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv12 1/4] batman-adv: Always flood IGMP/MLD
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

--nextPart1795629.n6uB1eOEIG
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Wednesday 16 March 2016 05:06:42 Linus L=C3=BCssing wrote:
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

It looks like you register two containers, one with version 1 and versi=
on 2,=20
both with the same content. Do we really need to have both containers?=20=

Wouldn't it be sufficient to register only version 2 and leave version =
1 out?

Other than that, I just found a minor style thing, see below.

>=20
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
> diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
> index 8caa2c7..19cc404 100644
> --- a/net/batman-adv/multicast.c
> +++ b/net/batman-adv/multicast.c
> @@ -320,6 +391,31 @@ static int batadv_mcast_forw_mode_check_ipv4(str=
uct
> batadv_priv *bat_priv, return 0;
>  }
>=20
> +#if IS_ENABLED(CONFIG_IPV6)
> +/**
> + * batadv_mcast_is_report_ipv6 -=E2=80=AFcheck for MLD reports

put a space after the dash?

Cheers,
     Simon
--nextPart1795629.n6uB1eOEIG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXBlqPAAoJEKEr45hCkp6hHGAQAMtjpj5G0ShnkCvcbNCBZRHh
z4idqMnjL/+3B5U9Pw4qnu8gMCKiqsQ4QlG9RKFI/SaPyJxAsMN//Rd5pllXj7dG
3mae62Dw/ITOuJ1PqomwlCtSnWqcLmk36CghWPyuDZouEWB0mkbp28qmyQ4baRix
SLErgj/PDiued9Rz7JMtCaCCfXXfkDK9KWng2MPQ9G+8oI/0KkAxpu+nhWOuhg3+
SfjaKNb+H6yXcUv7vK1ke9As5EUX75fRrFb1ehwwxS/6wexTYc8G4FodzwePSzqd
SIbsRHpttv1Tw3hOF3qEoh53GppEac2lMqTuMD+Sc8MGzIsEOo5PLV1whTzdXs3p
pL16nF5rdm+7zpA4xJ7Cs/NXBVJaw9FueVWwCZSl3APwcQaTiID1cExyfEZhD9p0
O9y4mUAj9Duu3Z+c/0Eqlt1NCZtOQeRZ/JA3sSb5sMgmFlXkhOUyJuRXWeQS8/GB
olwwxlKv/WLvP8HLiRPa/XvAS4W1ePPZPgFebtNS9zm7PQXZm6RCQPgaUiwpjyxm
gPybYBH3ToEYBBRnUZgrnhxuqqmO6NQxbnQdVQbNfMEfS8NqS90gD8bNvUgN9/eL
V95N0ihNHG8ktd+hRyihd4OQiEwzPj5EAum8+5VoY1ekxvAVFXgsYFqIcjnjotl8
M+Dz2v9fcjJNwHLwhG9o
=aB9Q
-----END PGP SIGNATURE-----

--nextPart1795629.n6uB1eOEIG--

