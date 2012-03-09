Return-Path: <ordex@autistici.org>
Date: Fri, 9 Mar 2012 14:25:25 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120309132525.GD436@ritirata.org>
References: <20120307144709.GA19891@ritirata.org>
	<7ieht4mnnp.fsf@lanthane.pps.jussieu.fr>
	<20120307171751.GC1389@ritirata.org>
	<20120307221847.GR12778@kerneis.info>
	<20120309085636.GA9018@pandem0nium>
	<CANjd3nd5+8n2frV_FVLbONyAj4An8Rcq=mOu-pVk-3nzp8Kk_w@mail.gmail.com>
	<20120309105921.GD15059@kerneis.info>
	<7ik42u9f5x.fsf_-_@lanthane.pps.jussieu.fr>
	<74A4488FAEEC56408507A6FECA6909910122181F@SC000647.CHASCOM.INT>
	<7ieht1diol.fsf@lanthane.pps.jussieu.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h56sxpGKRmy85csR"
Content-Disposition: inline
In-Reply-To: <7ieht1diol.fsf@lanthane.pps.jussieu.fr>
Subject: Re: [B.A.T.M.A.N.] [Battlemesh] Diversity in BATMAN
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
Cc: Battle of the Mesh Mailing List <battlemesh@ml.ninux.org>


--h56sxpGKRmy85csR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 09, 2012 at 02:10:02PM +0100, Juliusz Chroboczek wrote:
> > The metric is simply based on TQ. C=3DS will probably have a better
> > local TQ than C'-S because of the load balancing over the two links,
>=20
> Sorry for the confusion, I used =C2=AB =3D =C2=BB to mark a different fre=
quency than
> =C2=AB - =C2=BB.  There's only the one link between C and S, it's just us=
ing
> a different (non-interfering) frequency.

Then the route over the =3D link will probably have a better TQ due to less=
 packet
loss (as it doesn't interfere with any neighbouring link). But there is no
explicit coding of this "better freq" in the metric.

Cheers,

>=20
> -- Juliusz

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--h56sxpGKRmy85csR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJPWgTFAAoJEFMQTLzJFOZFsPcH/13HE1wL52iwsgvlqZZ3cxvt
NTj48DcKs7ZDFmHF8g3ImZpNaYQFVjE/MDjX3herGpigXKr66CLku+X54OneAzl8
RbGrw4m6QVhtUTmOGf5xJcGPVBoR5ZEcxP13sk6b9a2f3d+juaHJnr601zmn0VRK
OU0yVYOqul9kP1q5YGD6fqmvOsCJ7E3v1btvJG8syfWr1vNmCw6h2tuuu7UHdjHw
uBFYkoUCkmDTdq924OmzTQhdeEH1rsJE6tGgKXfEGpdJg+KM8UQy8WnzhRjIVIhH
HWD30CTCjaegbB1kecOuqaBvxfsAJwN2LD9Js0rGQDjCY8/4nSmF4CaqivbNf34=
=BIGH
-----END PGP SIGNATURE-----

--h56sxpGKRmy85csR--
