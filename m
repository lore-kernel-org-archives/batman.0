Return-Path: <linus.luessing@web.de>
Date: Thu, 4 Mar 2010 17:01:25 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100304160125.GA11797@Linus-Debian>
References: <20100303233946.GA24284@Linus-Debian>
	<20100304090355.GB29010@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <20100304090355.GB29010@lunn.ch>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] vis packet format
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


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Ah, okay, that makes sense. I was wondering about how the
compatibility version would have to bedone anyway in such a case
:D. So it should probably also be a general thing to better not
change the compat-version during one merge window, right?

I'll try to make too patches now then, that's fine.

Cheers, Linus

On Thu, Mar 04, 2010 at 10:03:55AM +0100, Andrew Lunn wrote:
> On Thu, Mar 04, 2010 at 12:39:46AM +0100, Linus L??ssing wrote:
> > Hi,
> >=20
> > Marek and I have been chatting a little about the buggy vis raw
> > output yesterday. And there was either the option to sort the
> > mixed list on the receiving vis server or on the sender already.
> > For the second option there was also the idea of changing the vis
> > packet format accordingly to also save some more overhead.
>=20
> A comment about the mainline development process. Changes which are
> clearly bug fixes we should be able to get merged into the -rc kernels
> at any time. Changes which look like development work have to wait
> until the next merge window.
>=20
> This vis problem about it showing the wrong interface will be in
> -rc1. It would be nice to get it fixed. We are more likely to get such
> a fix accepted if it is small and looks like a bug fix. I expect it
> will get rejected if it is big and looks like development work.
>=20
> So can we develop two fixes? Something small and simple for -rc1 and
> an optimizing fix which will go into linux-next and then into mainline
> during the next merge window?
>=20
>        Andrew
>=20

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJLj9lVAAoJEBKw7u43QNpfVroP/0c71zB1A+63GGDi4H91qmba
vsfpLqLDDluKIc+xfeQDhOeTwj5svf9M5BeGA5i9+S3Z5qv8tcAL1wpPjGgvnjTR
jt5bFw1XlPDQBgT76ZfvJznc5yVGOdCZdoMj8jAipaFtalIOvYakdQKP07Ll3qbT
vNZFEXDVZQ5i7flDBiyN9hKIWCaBAsp/5MDjkvKtKRaYn7++0HpXHavbp38qyALx
va24hnmQrz9rEIpN3o14RXKLXdt8LoyqJpOAjNwqdn5QS1w8YQ2g0pWnSq/PIpeH
MtABYkN9NTw3gzomxKgBIwbs4kd8ZljEoGM5VwcSH6mwX+D8WGLiJRaZ+9jVLbGy
ccF6Lt6A+29xxWNUcUXpB3tEBYK92shgcU17OPHGxFW3th2ytBwx4HLlHbQrMO44
hP4kQzqGuUrNyKf3cVWPUAm5q9d/HIL/AhLMJDHoIp/jjJfiLrEeRnHIE4zyXCcy
POet/XVrA9II7NGMjndlpFtjBBjD0fP2ahchC0dMjzKtc/6L/McGdHnitUve1IpU
BKX9joZoZ5tRBH4MiYIjj3vcv/UX0JyIReEOyLo7mEdeD69CUQ8oeqCc2PtrOSV4
pIAaHGZzxhb6+OXU38Gruf4X86eOU4wCZg6UTY2VgO5HgAeRtpZdJIe99Tut6HGc
1EfKggvmUk8Sdd0ogRfc
=N+7J
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
