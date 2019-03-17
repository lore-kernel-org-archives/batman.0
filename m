Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 17 Mar 2019 11:13:51 +0100
Message-ID: <21873195.vkImI5SkMI@sven-edge>
In-Reply-To: <20190216215050.11542-1-linus.luessing@c0d3.blue>
References: <20190216215050.11542-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3392956.ZWvpkpjMSQ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v4] batman-adv: Add multicast-to-unicast
 support for multiple targets
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
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>, David Bauer <mail@david-bauer.net>

--nextPart3392956.ZWvpkpjMSQ
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Saturday, 16 February 2019 22:50:50 CET Linus L=FCssing wrote:
> + * batadv_mcast_forw_send() - send packet to any detected multicast recp=
ient
> + * @bat_priv: the bat priv with all the soft interface information
> + * @skb: the multicast packet to transmit
> + * @vid: the vlan identifier
> + * @limit: number of remaining, maximum transmissions
> + *
> + * Sends copies of a frame with multicast destination to any node that s=
ignaled
> + * interest in it, that is either via the translation table or the accor=
ding
> + * want-all flags. A transmission is performed via a batman-adv unicast =
packet
> + * for each such destination node.
> + *
> + * The given skb is consumed/freed.
> + *
> + * Return: NET_XMIT_DROP if limit was reached, on memory allocation fail=
ure
> + * or if the protocol family is neither IPv4 nor IPv6. NET_XMIT_SUCCESS
> + * otherwise.
> + */
> +int batadv_mcast_forw_send(struct batadv_priv *bat_priv, struct sk_buff =
*skb,
> +                          unsigned short vid)

This function doesn't have a limit parameter.

Kind regards,
	Sven

--nextPart3392956.ZWvpkpjMSQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlyOHd8ACgkQXYcKB8Em
e0bTkxAArNmzh0kESPfvHDZ0hJWs9dcpC5gbhNNNnBY8EUhb83IDvHjQf6p4S79F
I59tLhHREQamj253+3vA8jLS4IQmaUz04DU3E5FRXjapZ56Z4qfV+t+FOs99NS5m
KNh2MrasVihVwyCnkdEetMB2kjWdHYEdkhg1s4Fswi6e9AtB73CbOuJSJR5veslt
LP4xXZcz96o5b3AYv+cWzrJ6LoBU9zYuK/xs0JL6TWkeX6OzLhK4wrEqa1uk6BDD
G8xo4cXx5PWewMRJAFpJKjS+3bWgB3p0P/fDL+ibSvWUrXfjgjWSKJO8LWXohbKx
rNOs4Etne27iMktVPhIlm7HYwzkHeqzWpm3MYtwq0FKwlDrzFR0Yozt2dkssTIFu
pjWGm1lMzl4ODrrVRgsg6N2nuajNBIK0mYsbstzl0Av4dUewZeYWanzN1KAkuN8C
ID30GFFi2tfyxgf4mhhHAupmfJ4LND+eHPSi6GPATGIq+mWQioNEzqb729N3kW43
QJIarltfmLvk4DVJb74+sUTiGVuFf/hY2e0Q2xHtD2/acyCMUXohxM9jV2SDFbQG
p1I8I0m4Y7mQth72mIsuIxeZkqDqYey1caceTjnqr9DGKLx2tNx8O3ditOgXr2xe
DSrlUPktrow9J0MJn9FfY2RHTuMV6NjoGUtsftH+sGj6f3NmCIs=
=qWqt
-----END PGP SIGNATURE-----

--nextPart3392956.ZWvpkpjMSQ--



