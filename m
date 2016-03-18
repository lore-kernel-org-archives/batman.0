Return-Path: <mschiffer@universe-factory.net>
References: <cover.1458231707.git.mschiffer@universe-factory.net>
 <1648365.zDTnRIsh0N@bentobox>
From: Matthias Schiffer <mschiffer@universe-factory.net>
Message-ID: <56EBEDF6.50704@universe-factory.net>
Date: Fri, 18 Mar 2016 13:00:54 +0100
MIME-Version: 1.0
In-Reply-To: <1648365.zDTnRIsh0N@bentobox>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="10AnaItJ7b65WoxLkTL51tsEKNAvFPJTi"
Subject: Re: [B.A.T.M.A.N.] [RFC v2 0/5] batman-adv netlink query API
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
Cc: b.a.t.m.a.n@lists.open-mesh.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--10AnaItJ7b65WoxLkTL51tsEKNAvFPJTi
Content-Type: multipart/mixed; boundary="tJtiNEOI3I2f8SN8W9G2GKvOs5e8juqP3"
From: Matthias Schiffer <mschiffer@universe-factory.net>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Message-ID: <56EBEDF6.50704@universe-factory.net>
Subject: Re: [B.A.T.M.A.N.] [RFC v2 0/5] batman-adv netlink query API
References: <cover.1458231707.git.mschiffer@universe-factory.net>
 <1648365.zDTnRIsh0N@bentobox>
In-Reply-To: <1648365.zDTnRIsh0N@bentobox>

--tJtiNEOI3I2f8SN8W9G2GKvOs5e8juqP3
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 03/18/2016 12:23 PM, Sven Eckelmann wrote:
> On Thursday 17 March 2016 17:45:30 Matthias Schiffer wrote:
> [...]
>> At the moment, the following debugfs files have corresponding netlink =
APIs:
>>
>> * routing_algos
>> * neighbors
>> * originators
>> * transtable_global
>> * transtable_local
>> * (hardinterfaces for a softif can be queried)
>>
>> The following files are still missing:
>>
>> * gateways
>> * bla_claim_table
>> * bla_backbone_table
>> * dat_cache
>> * nc_nodes
>=20
> What about the "socket" file?
>=20
> Kind regards,
> 	Sven
>=20

Ah, I forgot about that one because it is very different from the others.=


I think it should be possible to convert "socket" as well by wrapping the=

BATADV_ICMP packets in netlink packets. Or maybe it would be possible to
drop that altogether and just do ping/traceroute in userspace with
AF_PACKET or similar?

Regards,
Matthias


--tJtiNEOI3I2f8SN8W9G2GKvOs5e8juqP3--

--10AnaItJ7b65WoxLkTL51tsEKNAvFPJTi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJW6+32AAoJEBbvP2TLIB2c1JwP/AqGfs5g0j1y2SO9eGpkQqr6
YOlQOK6dF5zAQjRhOl/Heg5bXciCqEjOJ2awPASupIo+mJ+3SUJxvKcVo/5k+7lF
JnLjxA+7Mn6WSpetv8UKBrIawse1Rd/6OKGY4utvWB0AqIEIuO1eAJse3/job6rI
WqOKs5Rk9O5LfogzV2mVi8+DTbmdswT0jCSyx3wrTGZAIdKe0kyZrw1UOgnITSUb
69NJ/TQO07tu/PYWbDvyCWMvQhnU7VHoaPchz9NwUsmGiUerxht2jcH8CGyO0+l+
45U5HDpWKwytr0VmCwFDS6DjwFQE6HCUT2HKIrtVaJR4uv/vktL698A1uzzjuyvs
yEW9cuqWDcyO2gQMFi3faWjkFeTAJXCJ7wALSlo9M0kmdsjLHkCWd6iFLp95QsyM
vdH4iBswipeTK4IsGBUyWElO7RwdLb2C2TZ2Pwht+T1a1PymcN4MwD4PGBUFuUOj
3iAMXhxbRRA0pfdXHKydunor1U/Psj7tMgNMJXXGLmnAQ+cMct9oSowdPrYEydKQ
gunsqB/yajy61Z9YUO33hMPUiHFKuoqKfLTRjqlPSSIY8OSsIjFPZkhFND7Pljfx
Ejg7njhVrSIuoR+kw943AXX8hQFllhgw3P5qoClcYbMEiSeWhlyHJ9PbMnREMs48
c1dxLN0EihomdjpOdj5T
=UJpd
-----END PGP SIGNATURE-----

--10AnaItJ7b65WoxLkTL51tsEKNAvFPJTi--
