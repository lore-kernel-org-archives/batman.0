Return-Path: <ordex@autistici.org>
Date: Wed, 27 Jun 2012 08:26:45 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120627062644.GB3290@ritirata.org>
References: <1340740822-4516-1-git-send-email-ordex@autistici.org>
	<1340740822-4516-2-git-send-email-ordex@autistici.org>
	<1403237.H233GFHdJC@sven-laptop.home.narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Content-Disposition: inline
In-Reply-To: <1403237.H233GFHdJC@sven-laptop.home.narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/5] batman-adv: add reference counting
 for type batadv_tt_orig_list_entry
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
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 26, 2012 at 11:14:27PM +0200, Sven Eckelmann wrote:
>    You can just invert the atomic_dec_and_test and use a return to avoid =
the
>    weird comment.

Right. Thank you!



--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk/qp6QACgkQpGgxIkP9cweLQACeKYEEPJh+QeFuO81M97SEQRM3
GoIAn0ozwyUdqH0HFTzcOmWA/BhIIXnS
=pV+O
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--
