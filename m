Return-Path: <ordex@autistici.org>
Date: Fri, 24 Aug 2012 18:26:53 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120824162653.GK27849@ritirata.org>
References: <1345825122-1601-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="j3olVFx0FsM75XyV"
Content-Disposition: inline
In-Reply-To: <1345825122-1601-1-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: print packets re-routing on
 DBG_TT and ratelimit it
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


--j3olVFx0FsM75XyV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 24, 2012 at 06:18:42PM +0200, Antonio Quartulli wrote:
> To simplify TranslationTable debugging it is better to print the packet
> rerouting message on the DBG_TT log level. In this way a developer intere=
sted in
> packets rerouting doesn't need to filter it out of the whole ROUTES log.
>=20
> Moreover, since this message will appear for each rerouted message, it is=
 now
> "ratelimited".
>=20
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>

Sorry, drop this patch, I should have used net_ratelimited_function, as I t=
old
to Martin.

Will send v2.

Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--j3olVFx0FsM75XyV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlA3q00ACgkQpGgxIkP9cwfd1gCdFhS5YUvwHqgL6K36IWj77MMA
9eAAn2Nvwk5s2n8oYCHmMEOKvUUHpd4g
=2em0
-----END PGP SIGNATURE-----

--j3olVFx0FsM75XyV--
