Return-Path: <ordex@autistici.org>
Date: Wed, 27 Jun 2012 08:58:19 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120627065818.GF3290@ritirata.org>
References: <1340740822-4516-1-git-send-email-ordex@autistici.org>
	<1340740822-4516-4-git-send-email-ordex@autistici.org>
	<3265215.erIRmWtS44@sven-laptop.home.narfation.org>
	<20120627063021.GC3290@ritirata.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5CUMAwwhRxlRszMD"
Content-Disposition: inline
In-Reply-To: <20120627063021.GC3290@ritirata.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/5] batman-adv: enable roaming packets
 to carry flags
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


--5CUMAwwhRxlRszMD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 27, 2012 at 08:30:22AM +0200, Antonio Quartulli wrote:
> On Tue, Jun 26, 2012 at 11:18:29PM +0200, Sven Eckelmann wrote:
> >    I am not 100% sure because I haven't checked the code, but couldn't =
it be
> >    the case that we send random bits inside reserved at the moment? At =
least
> >    I cannot remember the part of the code that initialized reserver to =
any
> >    specific value. That would make the change incompatible with older
> >    batman-adv version.
>=20
> Damn, that's true! It is not initialised anywhere....
> What if I append a new field to the roam_adv_packet struct? Old version w=
ill
> ignore it and there is no size check to drop packets longer than expected.

Ok, after discussing with Sven on irc I got to the point that it is simply
better to skip this patch. Appending a new field would make the new code mu=
ch
more complicated (and ugly) because we have to consider that we could recei=
ve
old packets with a smaller size (and they should not be dropped).

I think that the best solution is to remove this patch.

The idea in this code
was to send the new TT_CLIENT_TEMP flag within the roam_adv so that the rec=
eiver
node can eventually purge this entry if not claimed anymore. However this i=
s not
needed because a roaming client is already marked as ROAM on the receiver s=
ide and
so it will already be purged if not claimed within a fixed amount of time.

Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--5CUMAwwhRxlRszMD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk/qrwoACgkQpGgxIkP9cweu/QCdH3o91tRWLAoxOU1LQltXx5xp
bjcAn1CEKYrOCdvTH/kTcXplVy2tS/uu
=6aV1
-----END PGP SIGNATURE-----

--5CUMAwwhRxlRszMD--
