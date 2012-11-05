Return-Path: <ordex@autistici.org>
Date: Mon, 5 Nov 2012 17:05:42 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20121105160542.GA3534@ritirata.org>
References: <1352129674-11080-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
In-Reply-To: <1352129674-11080-1-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix ROAM flag de-selection
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 05, 2012 at 04:34:34PM +0100, Antonio Quartulli wrote:
> In tt_global_add() the ROAM flag is improperly unset. This makes the
> next check fail and so preventing emptying the old originator_list for
> the involved tt_global_entry
>=20
> This was introduced by ("batman-adv: roaming handling mechanism redesign")
>=20
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>

Ops, I just forgot:

Reported-by: Mike Burmeister-Brown <mike@open-mesh.com>


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlCX49YACgkQpGgxIkP9cwfi+QCeI1HBoztp3lShPMDSV+8Tl73l
/G0An0q0HAYR+rY9TieuVlGYnLFT54WB
=g3Ax
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
