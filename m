Return-Path: <ordex@autistici.org>
Date: Wed, 20 Jun 2012 17:34:03 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120620153402.GA17596@ritirata.org>
References: <1340205365-25052-1-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <1340205365-25052-1-git-send-email-lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: only drop packets of known
 wifi clients
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Marek Lindner <lindner_marek@yahoo.de>


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 20, 2012 at 05:16:05 +0200, Marek Lindner wrote:
> If the source or destination mac address of an ethernet packet
> could not be found in the translation table the packet was
> dropped if AP isolation was turned on. This behavior would
> make it impossible to send broadcast packets over the mesh as
> the broadcast address will never enter the translation table.
>=20
> Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>

Acked-by: Antonio Quartulli <ordex@autistici.org>


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk/h7WoACgkQpGgxIkP9cwfoxACfbB3Pbo8t0OmnfodBBSn/1s1h
PoYAoJXUME1D96J468miu5iUsYtJLVx9
=GBKU
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
