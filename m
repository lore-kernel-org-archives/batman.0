Return-Path: <a@unstable.cc>
Date: Sun, 28 Feb 2016 17:42:21 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160228094221.GL28478@prodigo>
References: <b.a.t.m.a.n@lists.open-mesh.org> <2655547.V2kIYkZTyH@sven-edge>
 <20160228090227.GJ28478@prodigo> <2289020.8mL0hEvS8q@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HuXIgs6JvY9hJs5C"
Content-Disposition: inline
In-Reply-To: <2289020.8mL0hEvS8q@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Check skb size before using
 encapsulated ETH+VLAN header
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Marek Lindner <mareklindner@neomailbox.ch>


--HuXIgs6JvY9hJs5C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 28, 2016 at 10:20:30AM +0100, Sven Eckelmann wrote:
> Ok, I misunderstood his comment. This one is not necessary when each path=
 to=20
> this function uses batadv_check_unicast_packet or does "if=20
> (!pskb_may_pull(skb, hdr_size))" directly. The only callers are=20
> batadv_recv_bcast_packet (does "if (unlikely(!pskb_may_pull(skb, hdr_size=
)))")=20
> and batadv_recv_unicast_packet (calls batadv_check_unicast_packet). I wou=
ld=20
> say that an extra patch for that can be introduced later to remove it. Bu=
t it=20
> should not be part of this patch because this fix should not contain clea=
nup=20
> stuff ("batman-adv header size check") which is not related to the=20
> encapsulated ethernet (vlan) header.

True.
Better to keep the fix small and address that in a later patch.

Cheers,

--=20
Antonio Quartulli

--HuXIgs6JvY9hJs5C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW0sD9AAoJENpFlCjNi1MRq7QQAJH1kMO0YRT8hNibXsZE2UGV
6GgAM3XOx7qnglTkERYGbF3SGaQJxz5WGBJMOJ2WR7Z1a5hL0HE4g0qijTPlQjFt
IDWRVnfYEhxuK2I7lgqx7FMXDIMa7Gm9GG6LV+LqjErqgqi2Cefgnayq6AFdTl8G
utMmuTdM0D7KLfpQmUqF6IORMiS2w9mH3IosAjwW39/Ahwmy/zhkoVarecOCsayq
1rjlHd9BncXpb9aZgMNTBpMCP2XsJcB59RmMhm9qhD0ZJQao4MbhT1ELVWksvvMQ
yYz8BjgNqu8iYrbiX8liKCO9OHLtdWZ3gvXG3s8SlZxlInJZT8Et6J4x76NOHppO
t9sH2QFoszUE30BiYY89QXkh9Bj43FVWM9r+Gf/ux4Q4Jls+zFh9wP911lupH2Ad
QcOqovVYgpmxh4sLVRRdHWFa7xdO8n0X9uvvonp51+K8Y45BrjFLdNno7Ek/tDmV
DWFyLTWS1Nn5DFlF0Tr8SdBZyzSDYbioBS8971ttw5V/hSyuJ1Ltt32KsM3xCQLS
g8qxbtVRp5//G1AEokXFD+g4nDpnh0a7nU5jdblbcOdKg5MLfyoxwURomvnef+vz
vHLfCKCdK7MMJ9tMgy7LZ0WNLy7C/QhSjFqSAo3anlrJv/eBj/P6w5gFKU6Qy2ar
hLqQBZFMm6adlSlpr4oT
=Vrmr
-----END PGP SIGNATURE-----

--HuXIgs6JvY9hJs5C--
