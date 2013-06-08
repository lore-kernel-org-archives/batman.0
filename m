Return-Path: <ordex@autistici.org>
Date: Sat, 8 Jun 2013 14:29:39 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130608122939.GR1789@ritirata.org>
References: <20130606182954.GI1789@ritirata.org> <51B0DD43.6090500@inti.gob.ar>
 <20130606191823.GJ1789@ritirata.org> <51B1E4D6.5000900@inti.gob.ar>
 <20130607135713.GL1789@ritirata.org> <51B1F062.3060101@inti.gob.ar>
 <20130607144019.GM1789@ritirata.org> <51B214AE.2090603@inti.gob.ar>
 <20130607172734.GO1789@ritirata.org> <51B22D19.7080807@inti.gob.ar>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="RyOXVFQXzAE23HDB"
Content-Disposition: inline
In-Reply-To: <51B22D19.7080807@inti.gob.ar>
Subject: Re: [B.A.T.M.A.N.] batctl bw performance
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--RyOXVFQXzAE23HDB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Gabriel,

On Fri, Jun 07, 2013 at 03:57:29PM -0300, Gabriel Tol=C3=B3n wrote:
>=20
> Yes, that's strange, that's why I asked if you had tested the same. It=20
> couldn't be due to hardware differences? Just in case WDR3500 have=20
> AR9344 SoC.
>=20

I guess it's the same:

system type		: Atheros AR9344 rev 2

and this is one test I just performed:

# batctl bw a6:86:74:00:0f:12
Bandwidth meter called towards a6:86:74:00:0f:12
Test over in 10030ms.
Sent 187528500 Bytes.
Throughput: 17.83 MB/s (149.57 Mbps)

There must be something different in our setup that is probably triggering =
a bug
in the bw_meter (I guess).

Here you have more results from tests performed a couple of weeks ago.


Maybe I find a couple of WDR3500 on which I can remotely try to debug the
problem....


Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--RyOXVFQXzAE23HDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRsyOzAAoJEADl0hg6qKeOSgMQAJhem4EnEO28FtBAMGuevfHL
8BHqTjpzdtvFdaXaHGSq4CVX0A0De6Q6gVmbFPMkqHI+nA/55b+2heNdPJpIQpUi
3xxfaXypOx5Ko4drnbbF31mQ3VEKtalWk8oSHedXn4PndO2LhIjwFjqlxy80NGs9
tqHeEdO60ppVnUU1YU8sjSdCtJ9GSiFyF51tlMijhMzf55ZqMWffQlsHRWP33iYR
ZVGR6CgvRcBuNorvL7wnL02dqIwBMuoTqbZUWq4ztsqkfRKYJrwVSYANGzGKU+SM
exRQCAAF/thESfSJhkfKtS5s+849yX0ukonk/wUfyvRKVmtGxP4cDmPQgwv9M3ku
vshxb9reYxIjpwQELpWak4p/JACb5HxnJE/JcoSgkkJoor67+ncSc7425BcWnTrQ
pzuj7Cada4YONvGl7fcuq/jsiDmiM3pU39jZykVn4TX7Ad0dCQTELDC3b1nnd1kv
JQ+Xj9gbDvpIP5ThUYZkgbr0kr8US/6emRdQ2Gifl7J8bj17lFiwHY/8I/o5UJkO
uDBuebxDoY/vXczVXSVoN+PIrlSGhjSJAXMs9RGrbKQYVd/lVIwTsnHiNo8vl5rG
40QV5wbLFUjEV8DT2ASg3I69tb5EPcrX03/tZjIYmoini8Y+zm8Ol8LScFkI6+xZ
PB/fR/nBkQ15nBBhTnZv
=i/Re
-----END PGP SIGNATURE-----

--RyOXVFQXzAE23HDB--
