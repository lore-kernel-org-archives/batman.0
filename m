Return-Path: <ordex@autistici.org>
Date: Mon, 26 Nov 2012 10:23:00 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20121126092300.GA22729@ritirata.org>
References: <1353886730-32477-1-git-send-email-ordex@autistici.org>
 <201211260917.31243.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
In-Reply-To: <201211260917.31243.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH next] batman-adv: use ETH_P_BATMAN
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 26, 2012 at 09:17:31AM +0800, Marek Lindner wrote:
> On Monday, November 26, 2012 07:38:50 Antonio Quartulli wrote:
> > The ETH_P_BATMAN ethertype is now defined kernel-wide. Use it instead
> > of the private BATADV_ETH_P_BATMAN define.
>=20
> How about batctl ?

Right, but of course, in a separate patch :-)
Thanks for the reminder


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlCzNPQACgkQpGgxIkP9cwfdLwCfUwXrTf2O52tldEea16JoCxUo
TGAAniSt44jkSRt1Ijoak8h0CyUgwSPM
=EoMH
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
