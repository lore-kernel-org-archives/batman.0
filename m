Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed, 4 Jul 2012 12:21:55 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20120704102155.GA10503@pandem0nium>
References: <CAGpqJgoJ2V5TNcr5j+c=y88Vj4ipE0ke=y9ZDKqOvsaci+u54A@mail.gmail.com>
	<20120704092052.GB10142@pandem0nium>
	<CAGpqJgoZz+m9d41L2rVtOUzenzue_BjCt+YQ8h_TSEi7QbxwoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <CAGpqJgoZz+m9d41L2rVtOUzenzue_BjCt+YQ8h_TSEi7QbxwoQ@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] [B.A.T.M.A.N] OGM problem and documentation
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


--huq684BweRXVnRxX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Arthur,

On Wed, Jul 04, 2012 at 12:00:09PM +0200, Arthur Lambert wrote:
> Hello,
>=20
> thanks for your answer,
>=20
> This is what I thought.. Its probably a mistake in my script to
> measure signaling. I will check that.
> I have already read the document that you give to me. This document
> discribes most of the features
> of Batman and some interesting stuffs. But I am looking for
> information about global architecture, how
> the protocol handles threads. An example of usefull draw  :
> http://imgur.com/3ecCY. Its not always easy
> to study or understand a complex project like Batman when you does not
> know how a ad-hoc protocol works.
>=20
> I am trying for example to follow the execution of the module with
> tools like LTTNG to see how works
> the implementation of workqueue or using GCOV to follow the data path.

That's pretty interesting! I don't know if we have something like
an architecture illustration (but haven't see any recently).  If you get
anything interesting out of that (illustration, performance insights,
etc), please tell us.

>=20
> And I interconnect my vm with special way. Its a king of bridge but
> the tool that
> I use simulate network topology so it more complicated than that.

Ah ok. Is it a self-written tool or something public? We usually use
vde/wirefilter to build up different topologies, see:

http://www.open-mesh.org/wiki/open-mesh/Emulation

Would be interesting if there are other possibilities :)

>=20
> I will come back problably later to ask questions, but at this moment,
> I have to many questions,
> I need first to continue reading the code and twiki, running my tests,
> ... again and again.

Good luck!

Cheers
	Simon

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk/0GUMACgkQrzg/fFk7axbFcwCdFocGULEefZT9ZY5UgdOtTYKL
GK8AoKaInEeynwAs9oKmNd17kA7I64YS
=Cj9K
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
