Return-Path: <a@unstable.cc>
References: <20180310235321.1324-1-linus.luessing@c0d3.blue>
 <2042233.hTAz9L1TrL@sven-edge>
 <8d6c7fcc-7681-721b-554d-9110574ed5b6@unstable.cc>
 <2162965.7E0QXh8GzM@bentobox>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <18a25277-37bb-82f8-924b-273bf6369270@unstable.cc>
Date: Tue, 13 Mar 2018 16:22:24 +0800
MIME-Version: 1.0
In-Reply-To: <2162965.7E0QXh8GzM@bentobox>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="iH6fYiKG0Yw6gVE5u7VnjAWf6KCmowt99"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 0/2] batman-adv: netlink support for
 DAT and MCAST
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iH6fYiKG0Yw6gVE5u7VnjAWf6KCmowt99
Content-Type: multipart/mixed; boundary="puf3ioqQxI8dv9z4GnaTVYxIZpTQl14U9";
 protected-headers="v1"
From: Antonio Quartulli <a@unstable.cc>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, =?UTF-8?Q?Linus_L=c3=bcssing?=
 <linus.luessing@c0d3.blue>
Message-ID: <18a25277-37bb-82f8-924b-273bf6369270@unstable.cc>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 0/2] batman-adv: netlink support for DAT
 and MCAST
References: <20180310235321.1324-1-linus.luessing@c0d3.blue>
 <2042233.hTAz9L1TrL@sven-edge>
 <8d6c7fcc-7681-721b-554d-9110574ed5b6@unstable.cc>
 <2162965.7E0QXh8GzM@bentobox>
In-Reply-To: <2162965.7E0QXh8GzM@bentobox>

--puf3ioqQxI8dv9z4GnaTVYxIZpTQl14U9
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 13/03/18 16:20, Sven Eckelmann wrote:
> On Dienstag, 13. M=E4rz 2018 16:02:34 CET Antonio Quartulli wrote:
> [...]
>> Another observation: do these attributes need to be DAT specific? or c=
an
>> we just define (or reuse) a generic HWADDRESS attribute that we might
>> already be using somewhere else (i.e. for TT)?
>=20
> I've asked myself the same but we have BLA_- and TT_ADDRESS and these a=
re=20
> named in a way which connects them to these specific subsystems. Using =
one of=20
> them for DAT seems to be a little bit odd.

Oh ok. In this case it makes sense to have DAT specific attrs.

(if we wanted to, we could still rename all the attrs pointing to the
very same data type and unify them, but I don't have a strong opinion
about it at this time).

Cheers,

--=20
Antonio Quartulli


--puf3ioqQxI8dv9z4GnaTVYxIZpTQl14U9--

--iH6fYiKG0Yw6gVE5u7VnjAWf6KCmowt99
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlqnikAACgkQB6U8WA7y
zXS7yBAAw2TDUnbOnFufDBbfVMgtciCO8hNE0LiENq51BrKaN8Xa09EKlWgJqVsR
Z5cehro7qtU1+emwS3LiyvgwgRdlnLavgiYOSM4SAqMPjIiZixIvyPDzrT+/l8iD
iORD8twloKIlHrxsTppMP12GlWXqjBhFZ0CZm9y8Gqm+tE5BHvA/kjfmjXfICUJN
50gvBJ6A58RmXepPc1P1moa8AyFyncbeILsiq/QOj8UC4iRGU4YeXLZynFVNO5kL
ypk8CliGOcN0GjPbSiCprKD9F8KN5aDGk0VJqRGi9NnPfgPVpJV41S9HH/i9TsBl
LqyW7E5wrvrb9QzOtf3jmYni4MfGIjMuXFlo6MDZJvKt9/GQKN+3Akc8gZ1bFXvF
q6oZDfUSRLU6QVXIvbY7jIw04/eEAvQUWKRhIk7bWuPa/5oPDnSwlAvxWreINlNy
QYO3+rhZJ/62yvo7DHQ5VfUF2tv9jQtvkJdAvmz/6JYbWTWLG+vOuj7EZOKogsKo
kvvH19H59SGamNqNPVw67soJAUuYGDXB2C2edftFQQSLIZDm0tBMcXHuf/x4Nmah
da4tRrYNInkMA8VGUcRFYvbwe+vIy1T+Y469vLFmSQcEp4AVYX4TPkvefdGIe36e
gFezhu/eJgwWTFP2d3mg5ccNxifa5BBYSLzTmfSYBhGzk8YoIG0=
=+n3B
-----END PGP SIGNATURE-----

--iH6fYiKG0Yw6gVE5u7VnjAWf6KCmowt99--
