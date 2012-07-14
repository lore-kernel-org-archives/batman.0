Return-Path: <ordex@autistici.org>
Date: Sat, 14 Jul 2012 19:18:46 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120714171846.GM19461@ritirata.org>
References: <1342286144-24490-1-git-send-email-ordex@autistici.org>
	<1342286144-24490-2-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlxN1C6awaFNesUv"
Content-Disposition: inline
In-Reply-To: <1342286144-24490-2-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCHv10 1/8] batman-adv: add UNICAST_4ADDR
	packet type
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org


--UlxN1C6awaFNesUv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 14, 2012 at 07:15:37PM +0200, Antonio Quartulli wrote:
> =20
> +struct batadv_unicast_4addr_packet {
> +	struct batadv_unicast_packet u;
> +	uint8_t src[ETH_ALEN];
> +	uint8_t subtype;
> +} __packed;
> +

DAMN!
I added kernel doc everywhere but here.
Sorry for the noise people..will send v11. I hope it will be definitive..

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--UlxN1C6awaFNesUv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlABqfUACgkQpGgxIkP9cweR0ACeKCk6xr6D1JVIqA/1IO2yQuSk
RmgAniM5ZLhlUDnH3Al4Xh+iiphpkpif
=FUqE
-----END PGP SIGNATURE-----

--UlxN1C6awaFNesUv--
