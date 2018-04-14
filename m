Return-Path: <a@unstable.cc>
References: <20180413181618.24144-1-sven@narfation.org>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <78ec0422-9046-3db1-6a81-4c1c7d0c9968@unstable.cc>
Date: Sat, 14 Apr 2018 10:34:42 +0800
MIME-Version: 1.0
In-Reply-To: <20180413181618.24144-1-sven@narfation.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="I5ptApt2zuKSshGBTvnFjNL3m6bgDveXc"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: Validate translated mac addresses
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Sven Eckelmann <sven@narfation.org>
Cc: Andre Kasper <Andre.Kasper@gmx.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--I5ptApt2zuKSshGBTvnFjNL3m6bgDveXc
Content-Type: multipart/mixed; boundary="8M7rFmwabIgGyr5yZTpnnQBdaurEIRIWh";
 protected-headers="v1"
From: Antonio Quartulli <a@unstable.cc>
To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>, Sven Eckelmann <sven@narfation.org>
Cc: Andre Kasper <Andre.Kasper@gmx.de>
Message-ID: <78ec0422-9046-3db1-6a81-4c1c7d0c9968@unstable.cc>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: Validate translated mac addresses
References: <20180413181618.24144-1-sven@narfation.org>
In-Reply-To: <20180413181618.24144-1-sven@narfation.org>

--8M7rFmwabIgGyr5yZTpnnQBdaurEIRIWh
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 14/04/18 02:16, Sven Eckelmann wrote:
> The IP translation layer is using the neighbor table of the kernel to g=
et
> the unicast link layer (mac) address for IP(v4|v6) addresses. The kerne=
l
> can not only return unicast mac addresses to such an RTM_GETNEIGH reque=
st
> but also zero mac address. Such an address must be considered invalid
> because the global translation table may not only contain a unique clie=
nt
> mac address entry for it. The translation from client mac to originator=

> will therefore most likely return an unexpected originator.
>=20

We already handle the case of multiple originators handling the same MAC
address, no? In that case I think we pick the "best" originator.

This case sounds more like a validity check because "a zero MAC should
not be in the translation table", or am I wrong?


Cheers,

--=20
Antonio Quartulli


--8M7rFmwabIgGyr5yZTpnnQBdaurEIRIWh--

--I5ptApt2zuKSshGBTvnFjNL3m6bgDveXc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlrRaMIACgkQB6U8WA7y
zXTAJQ//cl82t6NOH5MTMJuWAyYRFQuQkxIJZtR1CZv+edKck7kMT1ctueMS7zqp
KiyMHAt6yZrxrHLo4YDqoARW/sE/Efw3By1pnQJMW5WDenSfu5VgwrS8SV3ChfZ1
Sz+/fkvYdZpXxOF04CvLT8lKjV6eaoLWUe65DdPzprWuxt41DEuGGnZuOurC0Cwz
qe8nc6lhDAMIc7ZZWkARoDaW0u8rzVxkE+Zqd4Dq+UU4+eQ746x906688O+5uA9n
FFU5hlztnZZXJCTvkN13aN481JlJEDwd2qmgaPnKSUldrgpjDJjt2HRhomBrGk7u
qQvD0jZI84Z9LO7xgHJVRPNpOHOsGh/VwVQw+k2Ksa5jQirodLVxQM6DoHPa8oKC
z+Yvo7BDWX8wzxahNMsMAXDvxbYbWYl+zaRVRbBC6ssFbDNU7SmG92a9lDMtworl
uHOGLHXAfpr2/SkTFhir6tZoz5cu2bLX2/HxOg3+2omxx7t0NSgFf93S8PgMt7yG
EGjyvqvatlhetmvkmtuMjeyyWTx2+LZdUtNSymKESeutPuGINBhLwXkcyqLGouev
7fQ0QRiz9fOPq98YXGz/5N6EqHmyRJkPEbEXXWuLy09/teYOWf/0mJJ74FLGqI7u
NX75NqNXUPhOwdHpL/fBgzUkdlEm2zmCfY8ol/uaW0kZzmN16Y8=
=MW4j
-----END PGP SIGNATURE-----

--I5ptApt2zuKSshGBTvnFjNL3m6bgDveXc--
