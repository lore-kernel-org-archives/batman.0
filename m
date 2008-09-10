From: Sven Eckelmann <sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Batman gateway lock ups
Date: Wed, 10 Sep 2008 11:50:36 +0200
References: <5635aa0d0809050801k1c5f0bd5wa366574efedd910f@mail.gmail.com>
	<20080909112647.GA747@pandem0nium>
	<200809100045.18090.sven.eckelmann@gmx.de>
In-Reply-To: <200809100045.18090.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1626090.ljWvD4krvN";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200809101150.41328.sven.eckelmann@gmx.de>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

--nextPart1626090.ljWvD4krvN
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 10 September 2008 00:45:07 Sven Eckelmann wrote:
> [...]
>     /* v0 and v1 holds pointer to new allocated struct */
>     /* a3 holds "zero" - like t0 */
>     9a8: sw	s1,8(v0) /* store pointer to client_data in new data buffer */
>     9ac: lw	v0,36(a3) /* v0 gets free_client_list.next -> lets call it
>                            next_element */
>     /* shouldn't be another instruction between load and usage of the
>        register? - like a nop */
>     9b0: sw	v0,0(v1) /* store next_element in tmp_entry.list.next */
>     9b4: sw	v1,4(v0) /* store pointer to tmp_entry next_element.prev */
>     9b8: sw	v1,36(a3) /* store pointer to tmp_entry in freeclient_list.ne=
xt
> */
>     9bc: j	9d4 <cleanup_module+0x524>
>     9c0: sw	t0,4(v1) /* saves freeclient_list in tmp_entry.prev << if this
>                           would not be executed in parallel, we would get
>                           wrong data here, but because we are using mips =
it
>                           must be executed */
> [...]
Ok, searched inside the official mips32 instruction set reference and both=
=20
questionable instructions are defined in a hard way without any unpredictab=
le=20
or undefined remarks. So they should be working fine.

Best regards
	Sven Eckelmann

--nextPart1626090.ljWvD4krvN
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkjHmG0ACgkQqQGwKVlMoDsjewCg54XhC/Rvdc4QRGrqXhsBvDb5
aPoAn3INhxJfUAHeFwQeTYDVsWbgxu0R
=Eb5J
-----END PGP SIGNATURE-----

--nextPart1626090.ljWvD4krvN--
