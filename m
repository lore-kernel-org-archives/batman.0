Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 06 Feb 2019 19:20:25 +0100
Message-ID: <3348534.ntHJrxh9jc@sven-edge>
In-Reply-To: <20190205192409.GF777@otheros>
References: <20190119155626.6414-1-sven@narfation.org>
 <1895931.G10psR3j26@sven-edge> <20190205192409.GF777@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2533756.8eBEcCl513";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC v4 00/19] batman-adv: netlink restructuring, part 2
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
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>, netdev@vger.kernel.org, Jiri Pirko <jiri@mellanox.com>

--nextPart2533756.8eBEcCl513
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Tuesday, 5 February 2019 20.24.10 CET Linus L=FCssing wrote:
[...]
> Another thought, if all this is too vague for now...=20

Yes, it is to vague for the integration in netlink :D

> what about
> ommiting the BATADV_ATTR_MULTICAST_(MODE)_ENABLED for now and use
> a reverse logic instead? Like
> BATADV_ATTR_MULTICAST_FORCEFLOOD_ENABLED, defaulting to false.

Would be fine for me. But it is rather odd to map this to the batctl=20
multicast_mode. But the name is explaining quite well what it does
and you can later rewrite the batctl part.

Kind regards,
	Sven
--nextPart2533756.8eBEcCl513
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlxbJWkACgkQXYcKB8Em
e0Z68Q//WWhCBjCB6fIxnn7zF9ZURmfMBwUjOvLBAIUbWv7qmesdnZBzQCt5wt7n
9VXxDpc8720pHXzFIWHCEldRHUtLGwnKqEMd50V4P/IGTrJYdvp9keGUTcqWj118
gL+CiKokS/tCqkf+B63RwfCnsIaRLpQrfodpIxxegSENRnimsTowXZsvAFKbCi8v
7Kj3Zalqhe/8EaXFx7gOf/rMUI7sgvZ2SMV9QHlJaZgwdqVY8ws9HLs3/jaXueqw
UCW0IiiFuqW9Uo90ykXPBihYiyLxDD4kRPEwc5vnvVWScPSkKAcj+bvDftWnivwi
ChP56yH1EqbdJ+NFyVLGxim2JzfEBeJA8d60l4RMuO0+ACKP3VGLb8U1FW5rx3AN
a6eWKF+vh9pcGDTEAL/RIw7sfAFVgQHOwoPP9RXdUCMWGhGhSJLyF9mKyNlwBhqI
KAzcH53w4DKfhBpLBW5NzW736hf74xle97NYp6YU7IoxDGII73dSRtIW5dbHWN8P
Q/m+VdxjhUGhPzAKsaxCneTrEBAUqjLW3HYA+q/NGC6H+Ng8PYf52XqAhdFNxyeT
5uLZj7djPVZ3RboVOOrayQg7PnaEXetnMN1U0Q428Tt9Guv8lpQUxEn8kmhS/gNU
Dzn9Qpk2xQ+XBlSU/OoI9nBRihDxvPLgiEiUbxWJ/GeUYU9eKpw=
=2u8V
-----END PGP SIGNATURE-----

--nextPart2533756.8eBEcCl513--



