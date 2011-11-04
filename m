Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Fri, 4 Nov 2011 16:00:36 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20111104150035.GA12338@pandem0nium>
References: <1320001741-18351-1-git-send-email-ordex@autistici.org>
	<20111031004201.GH10726@pandem0nium>
	<20111101134348.GH20215@ritirata.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <20111101134348.GH20215@ritirata.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: generalise
 tt_local_reset_flags()
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


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey there,

On Tue, Nov 01, 2011 at 02:43:49PM +0100, Antonio Quartulli wrote:
> On Mon, Oct 31, 2011 at 01:42:01AM +0100, Simon Wunderlich wrote:
> > Hey Antonio,
> >=20
> > I don't quite understand what this patch is good for - it generalises t=
he function,
> > but does not use the function at another point. So what it is good for =
(next to
> > add more complexity to batman ;] ).
> >=20
> > Furthermore it counts the changes and adds it to num_local_tt, is there=
 a bug fix
> > hidden in this patch somewhere? :)
>=20
> No hidden bug-fix here :)
> This patch aims to generalise the tt_local_reset_flags() function only. A=
s I
> discussed with Sven on IRC, this function could be quite confusing, becau=
se its
> name suggests that it can be used either for other purposes, but this is =
not
> true: it can only be used as it is now in the code.
>=20
> Therefore this patch wants to generalise it enough in order to be eventua=
lly
> used elsewhere.

OK

>=20
> The increment of tt_local_num is actually done inside the function and it=
 is
> useful only for the use case proposed in the current code. To generalise =
the
> function I had to move the increment outside (somebody else could want to=
 flip a
> certain flag without affecting the local counter :-) ).

Ah okay, I missed that it was already done within the function previously -=
 sorry,
my fault. No hidden bug fix :D

>=20
> IMHO this patch is not strictly needed, but it would clean the code up (U=
ntil
> it doesn't add any complexity :P)

I think thats okay. I reviewed it a second time and it does what its suppos=
ed to
do as far as i can tell.

The only thing I found a little bit confusing was the variable name "new_va=
lue",
as it turns out it is only a switch (0 - switch all flags from the flags va=
riable
off, 1 - switch these flags on). But maybe thats just me. ;)

Otherwise,

Acked-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

Cheers,
	Simon

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk6z/hMACgkQrzg/fFk7axY+FQCfbYBqlM3GBNLkpyClOLDfS6/Q
T9sAnRrTGay7P08N60ritVinJahbC4qP
=tSp3
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
