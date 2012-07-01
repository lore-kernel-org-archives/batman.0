Return-Path: <ordex@autistici.org>
Date: Sun, 1 Jul 2012 14:19:37 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120701121937.GA2917@ritirata.org>
References: <1341144314-20995-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
In-Reply-To: <1341144314-20995-1-git-send-email-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: Split batadv_priv in
 sub-structures for features
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


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 01, 2012 at 02:05:14PM +0200, Sven Eckelmann wrote:
> The structure batadv_priv grows everytime a new feature is introduced. It=
 gets
> hard to find the parts of the struct that belongs to a specific feature. =
This
> becomes even harder by the fact that not every feature uses a prefix in t=
he
> member name.
>=20
> The variables for bridge loop avoidence, gateway handling, translation ta=
ble
> and visualization server are moved into separate structs that are include=
d in
> the bat_priv main struct.
>=20
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> Any other ideas for substructs?

Hello Sven,

first of all thank you for taking care of this.

For what concerns the TT substructure it is fine with me, I had some doubt =
about
the ranaming of certain fields (ttvn -> tt.vn, and tt_crc -> tt.crc), but I
think they are ok.


Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk/wQFkACgkQpGgxIkP9cweMVACfQi6BE1y4EEsW6n2A/8ij1Vbd
0rcAnirn9FlU1juIdwZqKdUoIaWxDkOl
=SKCZ
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
