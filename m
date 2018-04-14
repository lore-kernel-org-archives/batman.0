Return-Path: <a@unstable.cc>
References: <20180413181618.24144-1-sven@narfation.org>
 <1658833.3ZLkxubxK8@sven-edge>
 <af29c3fe-d25e-51d2-7ca1-47738f25ab7a@unstable.cc>
 <6325045.lEza1471pb@sven-edge>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <9baeefb2-74ea-f448-7d45-216b10494778@unstable.cc>
Date: Sat, 14 Apr 2018 17:35:24 +0800
MIME-Version: 1.0
In-Reply-To: <6325045.lEza1471pb@sven-edge>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rupHYRDFpg1B0m6sexuha8Pkb7SMQgzlw"
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
To: Sven Eckelmann <sven@narfation.org>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Andre Kasper <Andre.Kasper@gmx.de>, linus.luessing@c0d3.blue

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rupHYRDFpg1B0m6sexuha8Pkb7SMQgzlw
Content-Type: multipart/mixed; boundary="28V5Bsw5m00bU1LgWN3pqcipgONoVsrdv";
 protected-headers="v1"
From: Antonio Quartulli <a@unstable.cc>
To: Sven Eckelmann <sven@narfation.org>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>, Andre Kasper <Andre.Kasper@gmx.de>,
 linus.luessing@c0d3.blue
Message-ID: <9baeefb2-74ea-f448-7d45-216b10494778@unstable.cc>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: Validate translated mac addresses
References: <20180413181618.24144-1-sven@narfation.org>
 <1658833.3ZLkxubxK8@sven-edge>
 <af29c3fe-d25e-51d2-7ca1-47738f25ab7a@unstable.cc>
 <6325045.lEza1471pb@sven-edge>
In-Reply-To: <6325045.lEza1471pb@sven-edge>

--28V5Bsw5m00bU1LgWN3pqcipgONoVsrdv
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 14/04/18 17:20, Sven Eckelmann wrote:
> On Samstag, 14. April 2018 10:11:28 CEST Antonio Quartulli wrote:
>> An error message like like "returned invalid all-zero mac address" (or=

>> "multicast address") might help to distinguish similar "ambiguities" i=
n
>> the future. No?
>=20
> The current interface for the translation is "give me a string and I re=
turn=20
> NULL or a mac address". The resolving of the IPs for hostnames and the =
check=20
> of the neighbor table are done on an "I take what I get first" approach=
=2E Your=20
> suggestion would involve a change of this interface and parsing of addi=
tional=20
> information and tracking of states to make sure that the "best" result =
is=20
> returned (or a special error state). This is nothing which I will imple=
ment=20
> now.

Oh ok, I went through the code and now I better understand what you meant=
=2E

>=20
> Should I drop the patch for now?
>=20

I'd suggest to still consider it for merging.
Even if we can't be specific about the error, it is still better to stop
the translation rather than generating unexpected results.

Cheers,

--=20
Antonio Quartulli


--28V5Bsw5m00bU1LgWN3pqcipgONoVsrdv--

--rupHYRDFpg1B0m6sexuha8Pkb7SMQgzlw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlrRy1wACgkQB6U8WA7y
zXQveQ//Ql6tmb0sB6rUBDBV80FryeZjn4QI2V0URKHc3U0kIpSAm09glhHI+xtu
i70c/32utNbYFNxgfdffzRp7Q7JmmMt6ncbxHRrfdK5de6NDqD8HMlCEWl5GcLdO
t58yAmtZOK6n9Vf941Pdew9NcIhknX7BdDxTpxSnFMpMipOJ3u9+24X/9um2w8C9
JuonR/z5O2lP3mOfxqHj3kp68agD/jzVRYDYuuAj6gmtePwKdfdQUEPGDulkK2uT
ATaQJrbrxX/IVqnIgyobSdeFnRILjmsHw98gskwNEADtmIgmOTJcP8HLUW5OprVI
RBcerxfjDo75GALSwOyUXTIlOD2DyWkU2hQhfdOGYrSH/b93ajLSqVH+BGRQzHO3
LS2cvHC2ftzvwH9hEXoFbNiLGVGktFxdl1IjFE0ZXZRi5N/8XI/SNC/mA3dJNUnc
QoNebdanqQez9c6UzpY5inIov3eyu7ZL81k9DtBVxJdosmeD0+jrtwXsHKWNV6d1
J7J60gYknbp1nLW6HExU7oE0go3/UbK+PSOt7wqvaHFhRzTQrNIeRYgcl2ulv6AU
qJ1jgCsDwNxD332aB+6moTZMTx082/elQreJn/CusHubdJrJllMa/61zwJDYpie0
V9cuQjEfUkquXr8hHi09f1eoAWJPfsILVeP8idcM5zpIak+Vc9U=
=ZxlY
-----END PGP SIGNATURE-----

--rupHYRDFpg1B0m6sexuha8Pkb7SMQgzlw--
