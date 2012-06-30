Return-Path: <ordex@autistici.org>
Date: Sat, 30 Jun 2012 14:12:19 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120630121219.GB2161@ritirata.org>
References: <1340785387-3821-1-git-send-email-ordex@autistici.org>
	<1340785387-3821-4-git-send-email-ordex@autistici.org>
	<201206301201.25953.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Content-Disposition: inline
In-Reply-To: <201206301201.25953.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 3/4] batman-adv: detect not yet
 announced clients
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


--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 30, 2012 at 12:01:25PM +0200, Marek Lindner wrote:
> On Wednesday, June 27, 2012 10:23:06 Antonio Quartulli wrote:
> > @@ -43,6 +43,10 @@
> >  #define BATADV_PURGE_TIMEOUT 200000 /* 200 seconds */
> >  #define BATADV_TT_LOCAL_TIMEOUT 3600000 /* in miliseconds */
> >  #define BATADV_TT_CLIENT_ROAM_TIMEOUT 600000 /* in miliseconds */
> > +/* Used to compute the timeout value for the entries marked with
> > TT_CLIENT_TEMP: + * temp_timeout_value =3D temp_timeout_fact * orig_int
> > + */
> > +#define BATADV_TT_CLIENT_TEMP_TIMEOUT_FACT 10UL
>=20
> You implictely assume that all nodes have the originator interval which m=
ight=20
> not be the case. As soon as they are different this will horribly fail.
>=20
> Why not using the originator sequence number instead ? It will give you a=
 time=20
> independent timeout. You could say if we haven't received a TT ADD 3 sequ=
ence=20
> numbers after we added the temporary client is gets merged.

That is a very good idea. The problem is that in a much more general scenar=
io we
have to keep in mind that the client could roam before being announced. At =
that
point, we will be waiting for an announcement coming from a wrong originato=
r.

Actually we have the same problem with the ROAM flag. Right now we simply w=
ait X
seconds: if nobody claims this guy within such amount of time we purge it. =
We
should probably do the same here...(we can reuse the same value we use for =
the
roam flag).

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk/u7SMACgkQpGgxIkP9cwdjWACghlf5qVVdAkitwzArrlKu5YnI
ufAAnjbMOMroqLaMj/F2clcFOS70ObIO
=knGf
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--
