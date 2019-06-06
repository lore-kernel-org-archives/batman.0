Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH v3 1/2] batman-adv: mcast: detect,
 distribute and maintain multicast router presence
Date: Thu, 06 Jun 2019 17:48:32 +0200
Message-ID: <3461137.lo7lFcuFkP@bentobox>
In-Reply-To: <20190526164829.4247-2-linus.luessing@c0d3.blue>
References: <20190526164829.4247-1-linus.luessing@c0d3.blue>
 <20190526164829.4247-2-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1647917.XAAxudkzKQ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
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

--nextPart1647917.XAAxudkzKQ
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sunday, 26 May 2019 18:48:28 CEST Linus L=FCssing wrote:
> If a multicast router is detected then this is signalized via the new
> BATADV_MCAST_WANT_ALL_RTR4 and BATADV_MCAST_WANT_ALL_RTR6
> multicast tvlv flags (which are sent flipped over the wire for backwards
> compatibility - so that old nodes will always have them "set").
[...]
> @@ -691,7 +868,12 @@ batadv_mcast_mla_flags_update(struct batadv_priv=20
*bat_priv,
>         batadv_mcast_bridge_log(bat_priv, flags);
>         batadv_mcast_flags_log(bat_priv, flags->tvlv_flags);
> =20
> +       /* toggle WANT_ALL_RTR flags as they are sent flipped on the
> +        * wire for backwards compatibility
> +        */
>         mcast_data.flags =3D flags->tvlv_flags;
> +       mcast_data.flags ^=3D BATADV_MCAST_WANT_ALL_RTR4;
> +       mcast_data.flags ^=3D BATADV_MCAST_WANT_ALL_RTR6;
>         memset(mcast_data.reserved, 0, sizeof(mcast_data.reserved));

Ehrm, this sounds like it is a good way to confuse people. Have a packet fi=
eld=20
which is called BATADV_MCAST_WANT_ALL_RTR4 but it actually means that it=20
doesn't have BATADV_MCAST_WANT_ALL_RTR4. So maybe we should call this=20
differently in batadv_packet.h's enum batadv_mcast_flags.=20
BATADV_MCAST_WANT_ALL_RTR4 -> BATADV_MCAST_WANT_NO_RTR4? And then switch th=
e=20
logic in batadv_mcast_mla_rtr_flags_softif_get_ipv*,=20
batadv_mcast_mla_rtr_flags_bridge_get, batadv_mcast_mla_rtr_flags_bridge_ge=
t,=20
batadv_mcast_mla_softif_get_ipv*, ....

Or is it really necessary to have this enabled for older nodes?

Kind regards,
	Sven
--nextPart1647917.XAAxudkzKQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlz5NdAACgkQXYcKB8Em
e0YSGhAAhIJsS4rjd6+a4p4i6mcBNNPBZQkHnzDfUjZe7iASmA/het2sAyfzvL2G
CEkLKeamdLuM4n0SNrSRMB2izZ3itxhxzs/a7D4JQ9DEFu4y7z6o/h4JDlm/fr9c
D3NIk6ZVY1ULcxTAuUfS0bOcd3KYi1Ff4GV9HSASxtgujkXS71EGS2Vg3m9tN6Ux
rI42rQ/3GUJJNL7YjUYS+Yry4fGEp1wu2iFpNyOBiugiXw1sbNacsIpAbJWjJOE+
d6kQm7rieDLKd48V/IjKK2siKAg6mUefG1u1xFOkKT8jQ3nElwVfB094RRPz4ppv
gxmm0/Tq+Uqe2LEU7ONDPoHqlhfZWJ8Snx505q4kSgqXdE9xR1GV0MGoWFbJCFCS
FWc6G44E48/YsBXpOcdyUjof4p9+lAxz8ZyGkSm5itJnWVcrWh3E9cDkg5E7pIE8
XVXSNUFpJ804/gSPElM632FfTm/srl7bnM1AwhhGpVhZsGqIFvsd4C8mImoW2f7d
DA22hFGQ+6CyAo58FmJhcGhv/KkOdZbpZ2onWiZu9lgCR0kD1+eWUQymPC0D+Ps/
CsKWw9M5+aZniLiTa5WhbC5QKk3cFymo+B1KZJtEuOm70+kc2NdvSOqr9y+6/wuY
oUlaNCxM5ajhZTB2Zw9+HWmNQWO3Q+GglVCuuzNP1MPTYK+aDlo=
=263C
-----END PGP SIGNATURE-----

--nextPart1647917.XAAxudkzKQ--



