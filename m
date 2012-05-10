Return-Path: <ordex@autistici.org>
Date: Thu, 10 May 2012 09:35:56 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120510073556.GB2204@ritirata.org>
References: <1336561976-16088-1-git-send-email-ordex@autistici.org>
	<1336561976-16088-12-git-send-email-ordex@autistici.org>
	<201205101249.16267.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9zSXsLTf0vkW971A"
Content-Disposition: inline
In-Reply-To: <201205101249.16267.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 11/14] batman-adv: Adding hard_iface
 specific sysfs wrapper macros for UINT
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


--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 10, 2012 at 12:49:15 +0800, Marek Lindner wrote:
> On Wednesday, May 09, 2012 19:12:53 Antonio Quartulli wrote:
> > From: Linus Luessing <linus.luessing@web.de>
> >=20
> > This allows us to easily add a sysfs parameter for an unsigned int
> > later, which is not for a batman mesh interface (e.g. bat0), but for a
> > common interface instead. It allows reading and writing an atomic_t in
> > hard_iface (instead of bat_priv compared to the mesh variant).
> >=20
> > Developed by Linus during a 6 months trainee study period in Ascom
> > (Switzerland) AG.
>=20
> Antonio, you merged 2 patches that are not to be merged. Any idea why you=
=20
> squashed 4e18e833bb5a06ab0462c3071f733dffb2a752ee and=20
> f76d019194e0a88c57371df169ecc979690a04c2 into a single patch ?

Yes, I misused the squash/fixup command while rebasing. I'll fix it before
sending the next pull request with the fixes proposed by David.

Thanks

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--9zSXsLTf0vkW971A
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJPq2/cAAoJEFMQTLzJFOZF8O8IAL9X8OIkLttIC8qqfMWblY+j
mMWj1rsd04fa4eU+cfl8PxIFyRfYlikLSLtwdyQZ8dB2+jatgYHViy59jrUrKIcn
37b0Cr+Eb0deRr7dbXF3dpwIoES4y3lp7OQ07/+eHubs7Yuhx0pyeaq/HS1sU4EN
776H3W8uzSjDKG0hnx3u7Wb3yGDKwndfxApC0CJoDXaVzm/WdHsb6Gz4p374Zn9B
g72HmCFhygYsqWuT0PAiTAcD/YT5gQrzuRDfItNEdNca/kLRerDtqv7/K8SRqL6F
oMyeQuTyNp5lIwLJBzQ1dnebvc8PMRwf8uklycQQ1WjA1bJH5UfDaiMAKOiqh6g=
=BoBC
-----END PGP SIGNATURE-----

--9zSXsLTf0vkW971A--
