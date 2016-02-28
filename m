Return-Path: <a@unstable.cc>
Date: Sun, 28 Feb 2016 17:02:27 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160228090227.GJ28478@prodigo>
References: <b.a.t.m.a.n@lists.open-mesh.org>
 <1456505773-1059-1-git-send-email-sven@narfation.org>
 <10633463.PgZ4eD0ZeI@voltaire> <2655547.V2kIYkZTyH@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="aYDVKSzuImP48n7V"
Content-Disposition: inline
In-Reply-To: <2655547.V2kIYkZTyH@sven-edge>
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Marek Lindner <mareklindner@neomailbox.ch>


--aYDVKSzuImP48n7V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 28, 2016 at 07:36:40AM +0100, Sven Eckelmann wrote:
> On Sunday 28 February 2016 08:49:02 Marek Lindner wrote:
> > On Friday, February 26, 2016 17:56:13 Sven Eckelmann wrote:
> >=20
> > In its current form that check is useless because
> > batadv_recv_unicast_packet() already calls batadv_check_unicast_packet()
> > which does the same
> > pskb_may_pull(skb, hdr_size). Am I overlooking something ?
>=20
> Looks like it also only checks the size of the batman-adv header and the=
=20
> content of the outer (not the encapsulated) ethernet header.

I think you are both right here :-) in batadv_check_unicast_packet() we
perform a may_pull with the same hdr_size, therefore it here once again
is not useful. It is not really related to this patch, but I think that
the removal of the useless pskb_may_pull() in interface_rx() could be
done here since you are cleaning up all the pulls in this function.

Cheers,

--=20
Antonio Quartulli

--aYDVKSzuImP48n7V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW0rejAAoJENpFlCjNi1MRav0P/2RoIKmWCbSK5zyxHLX5/GeE
ft9k4xX4TanN2Qpwb7OKnXG/QQXqclaLRx7RYs5VgOwXbfbNYjsZhs1V1R4oluHy
onrDLp1VT3Xb7nawVOOR0Wr8cYbJdQVw/Igc7N11bhCmE4YuchXco2uwAt8pLkXP
MphOVDb8oYLlHixKWDUJWY0tcTJ5/klLswcsJH9PmO9X97c13eGuyeZ9eSIQoOka
g5gethCLQ5nWwmnzJjsioI8pOo2q0GlhWikZTIlHu9ZaJzWKV604phydHHCqwTZw
eX3QM+ez5Mkn/zYlR10LmB49p/1nNToRBd76J7V70PVeNaBq7wCmrB2ZmtGTgJ1g
ZX95ND2DCp7l0J2hPkk2Vuk4fobdyPguHJfdMTGaFUZWXGQ94gEQhi/wjC1kwcQo
YfEe8n6tazqerDvfv9wCXqOZD6EBYuUjefgtO1gHH+YdRIVxUXskQ6JIUbbsPgm9
Wf69LsrRMbMmbDVBqNktvJfEuB1YVDpR2j9zkMzcPvHmn8lthSUsN0Io+bCSR3bt
EvxfEhAQr1AGdpNlow3el8FpTxCEoeYbG/RC+R7DmGt38XlPESz0FTWXkhYIW6LZ
2XbuGdQ+a+P1DDs1TbQE4NDyF8rUsCx5zvvESBR9nMO9YSWRufHEpkgpCROx+FsS
D8a9LHGXBkMcrS/qSsxS
=I4UX
-----END PGP SIGNATURE-----

--aYDVKSzuImP48n7V--
