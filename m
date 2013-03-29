Return-Path: <ordex@autistici.org>
Date: Fri, 29 Mar 2013 13:37:04 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130329123704.GA5519@ritirata.org>
References: <20130320175154.GT41481@l04.local>
 <3212285.GF4Btbehao@sven-desktop> <20130329114816.GR798@l04.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <20130329114816.GR798@l04.local>
Subject: Re: [B.A.T.M.A.N.] Bug#703540: Inconsistent use of _GNU_SOURCE
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
Cc: 703540@bugs.debian.org, Sven Eckelmann <sven@narfation.org>


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Fri, Mar 29, 2013 at 11:48:16AM +0000, Michael Tautschnig wrote:
> Hi Sven, hi all,
>=20
> [...]
> > > Either all or no file should #define _GNU_SOURCE.
> >=20
> > Please add information how to reproduce this the next time you are addi=
ng such=20
> > such a bug. Now I can just assume what you are writing is true (even wh=
en the=20
> > man page about sendto says otherwise). Not knowing how to reproduce it =
in the=20
> > best possible way just makes it harder for everyone to check the impact=
 of the=20
> > problem.
> >=20
>=20
> Just one question before I elaborate a bit: what information in the man p=
age are
> you referring to? I can't quite seem to see anything mentioning _GNU_SOUR=
CE?
>=20
> I fully understand your concerns and indeed it is a problem that I cannot=
 quite
> provide a concrete counterexample witnessing the problem. It may even be =
the
> cast that, at present, this is only a potential problem and not a real on=
e. It's
> much like a compiler warning: ok to be ignored if you are doing it intent=
ionally
> and you are 100% sure you know what you are doing. In all other cases, ho=
wever,
> it is likely worth fixing, as the problem can only ever be found by link-=
time
> type checking, which usual compilers can't do. Even if done, there is some
> non-trivial effort required to tracing back the type inconsistency to
> inconsistent order of #include or a missing #define.
>=20
> The most I can provide right now is all the scripts that suffice to repro=
duce
> the build results and error logs, to be found at
> https://github.com/tautschnig/cprover-debian
>=20
> > I've forwarded it to the upstream maintainer and attached the change fo=
r=20
> > Debian.
> >=20
> [...]
>=20
> Thanks!
>=20


Elektra provided a patch to fix this issue and it has been applied already.
The patch and the related "Applied!" message have been posted to the batman=
 ml,
maybe you are not subscribed and you did not get them?

Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRVYrwAAoJEADl0hg6qKeOIH0P/RkylaVjcvhs2dLzYmGo0i5C
I+3M+e4gRLLjk0PBEWZe8g2jW4zKVS/bNkic35yWA4ZSAz56pCR4j6nvqIVjBCvy
N2+Ie1h/G7uWEhHqqRwXX9Q4bfj6n3Ws9rptcPUCFoEfeMar9XMTtFh1kM9Ynh8h
a9ZLnnkYFARk0OuQuQ4jGVBd4hWfMs9xIDCr6j83vje240Uv8CvAoEng/oG9Szp8
51j0TpCHCrc2zAhTra/GsoLZSbmp0JwMRy9qZNAyBDf8hKDZfjdHGP6rcd2EhfSc
msJUNwuxoBr1iOw512eopKgcYIfXVHo7oZf6eXT+uEkCHVByyTl9kpihIcRTsWOp
ffKy5/dOI9r/AX6C2sEGc7qmZ8ZfDj516FVwjrZ/hcRtAbzOU2n1BBtZ9FZKIcla
R7LJwj7p9YH9lhrPLWeEggFWrnQPqRw91Kfi3Igwei/uR807S7iaYdTjsU2+/4to
fwnZuJDbyvArfCsouBPKmkQYBqqvgaYFEN5qrieXOfsv2wiaJZ+jp9DTqmdKvxdk
gdogPFI6YvhvfgW2GA0QIC6S4WFkrIh42PJSfDRJrpcB1gpr3DKDF15xU6fj4IKd
/BGoYBJlfpcwyOMrXL/SJ1bsQcPmaUlGPcVAgJsTYRGRP7YhegXe5SGrsSLjWsgr
2aG9/sUVE7eZNMvzoOKi
=NF8+
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
