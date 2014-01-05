Return-Path: <antonio@meshcoding.com>
Message-ID: <52C9B37C.7030707@meshcoding.com>
Date: Sun, 05 Jan 2014 20:33:16 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1388912394-824-1-git-send-email-antonio@meshcoding.com>
 <1388912394-824-2-git-send-email-antonio@meshcoding.com>
 <2109637.jlPLNyN0nR@diderot>
In-Reply-To: <2109637.jlPLNyN0nR@diderot>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2WOR5pr85jOLj3FpGaQBIKAKIQXPIVVC2"
Subject: Re: [B.A.T.M.A.N.] [PATCH next 2/3] batctl: implement vlan-to-link
 helper functions
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2WOR5pr85jOLj3FpGaQBIKAKIQXPIVVC2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 05/01/14 20:07, Marek Lindner wrote:
> On Sunday 05 January 2014 09:59:53 Antonio Quartulli wrote:
>> +static int vlan_get_link_open(const char *ifname)
>> +{
>> +	struct {
>> +		struct nlmsghdr hdr;
>> +		struct ifinfomsg ifi;
>> +		/* attribute has to be NLMAG aligned */
>=20
> NLMSG aligned ?

Yes, you are right!

Thanks,


--=20
Antonio Quartulli


--2WOR5pr85jOLj3FpGaQBIKAKIQXPIVVC2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJSybOAAAoJEEKTMo6mOh1VIjwP/Rf/PvcqLT/C5gQQiKEdYw+e
jF40D6QGXBRKTCWy3O+falKF4RNEk+RSalevKdFWe37ITc5p3pEeTv1QMGWpgvnb
WKFnhlN1/FS+np3avmHW0TYFTbgqycrCMetAHElT0KNvlwsas7dXPGAfXWDjpBSP
TNVfCoKePLFwODIfTsZ8p7bQezSlaP4kzWt4SfnhFNwghveURj3OtAdX3mc9SlS9
eJRlPCXPAPUhcUrnQsteWJq8FinmdAlmFUTUtWCpcO0DT7UzfdUwpgGiIRtvBdy5
712cpLT8KKOzdBwBwjhNCxRYyQvDV9r5YtkQBjICAsTpjJT3AtlDgRX5dwzTqATo
w4Dgk3qF6uwfhsIZI7WcMsrSbufyTSwhJ0ByA6iVO5aob7HOaslUye/2Fe+hs/lv
AvQkkUbKv/fyjYffZMxUYjSqzwjFgV7igg6m5mi2QfSltjE6eUkl0Z7PSiiDAvqq
GzvuLb0Aao0sxtI5A/o40KveLJnZXJcN0j0T7wpaMf+f9isHKyrcOCYD9T1OJi37
iZLvLFaQXOTHvnsY92FkAS4t6zZaYfI2NQc6agIDS/24oxDzzva/oOHgdvF9l8Ke
qfqLJULNRifokKpZm6R0K11etqYHX1IQttIw4F6VWb0wP2xf/b3rqn1k/o1lmHuI
bW4xIxlc4SJxFt7ssumP
=HzO2
-----END PGP SIGNATURE-----

--2WOR5pr85jOLj3FpGaQBIKAKIQXPIVVC2--
