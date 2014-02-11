Return-Path: <antonio@open-mesh.com>
Message-ID: <52FA4983.6070901@open-mesh.com>
Date: Tue, 11 Feb 2014 17:02:11 +0100
From: Antonio Quartulli <antonio@open-mesh.com>
MIME-Version: 1.0
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
 <1392122903-805-5-git-send-email-antonio@meshcoding.com>
 <20140211153224.GB24633@lunn.ch>
In-Reply-To: <20140211153224.GB24633@lunn.ch>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="iXj3Hvq6OOmSabLtEUkquIvf34pXSjIF4"
Subject: Re: [B.A.T.M.A.N.] [RFC 04/23] batman-adv: ELP - creating neighbor
 structures
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
To: Andrew Lunn <andrew@lunn.ch>, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Marek Lindner <lindner_marek@yahoo.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iXj3Hvq6OOmSabLtEUkquIvf34pXSjIF4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/02/14 16:32, Andrew Lunn wrote:
> On Tue, Feb 11, 2014 at 01:48:04PM +0100, Antonio Quartulli wrote:
>> From: Linus Luessing <linus.luessing@web.de>
>>
>> Initially developed by Linus during a 6 months trainee study
>> period in Ascom (Switzerland) AG.
>>
>> Signed-off-by: Linus Luessing <linus.luessing@web.de>
>> Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
>> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
>> ---
>>  bat_v.c     |  18 +++++-
>>  bat_v_elp.c | 204 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++-
>>  bat_v_elp.h |   6 ++
>>  main.h      |   2 +
>>  types.h     |  53 ++++++++++++++++
>>  5 files changed, 281 insertions(+), 2 deletions(-)
>>
>> diff --git a/bat_v.c b/bat_v.c
>> index 7247d7f..bed5e00 100644
>> --- a/bat_v.c
>> +++ b/bat_v.c
>> @@ -61,5 +61,21 @@ static struct batadv_algo_ops batadv_batman_v __rea=
d_mostly =3D {
>> =20
>>  int __init batadv_v_init(void)
>>  {
>> -	return batadv_algo_register(&batadv_batman_v);
>> +	int ret;
>> +
>> +	/* batman v echo location protocol packet  */
>> +	ret =3D batadv_recv_handler_register(BATADV_ELP,
>> +					   batadv_v_elp_packet_recv);
>> +	if (ret < 0)
>> +		goto elp_unregister;
>> +
>> +	ret =3D batadv_algo_register(&batadv_batman_v);
>> +
>> +	return ret;
>> +
>> +elp_unregister:
>> +	if (ret < 0)
>> +		batadv_recv_handler_unregister(BATADV_ELP);
>=20
> No need to check ret here. If we are here, it has to be < 0.
>=20
> It also seems odd to me you are unregistering the handler when the
> registration of the handler fails!
>=20
> I suspect the first if (ret < 0) should be followed by a plain return
> ret; and there should be a second test for the return value of
> batadv_algo_register() which should goto the label and unregister the
> handler.

I totally agree with what you said.
We should jump to elp_unregister if batadv_algo_register() fails.

Thanks!

--=20
Antonio Quartulli


--iXj3Hvq6OOmSabLtEUkquIvf34pXSjIF4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS+kmHAAoJEEKTMo6mOh1V1lkP/jgcQG5cV/J1oJHA8VLqRc8t
UrZ7TYtdChaVYqUFZzj4Bsx4EtkgrE3r/TmL2rWR3vFOYO74R8oJubh3QhdLXWZK
mGNjWeldPTIQYUKXmhYRMxiDK07DEajDVLjVzGgKHg4583jZvN0bTk9ICbuEmLgL
PekBUd4RUYkl4DykzhJxCNalVYbaLRH/nI2xvxu/npc2jCmqnGYnX9mt+KkWXrj6
iIy9akAQNqeECRMw+t5DXMzjkLxKYUT5Ug7KeOY1sFRqbx0i9R/R3VPc/bmDxCB3
ZBoxpuiI1NwuXN1WeP4A+lipNloQVNLZx47pz2G2l63E+PJNhyVp8Yl4OVZt2PFr
xMm2jrt5wmLs4QvtLZXX5qWd2WeKn8ufhQsoOac2VysSElbC531AqLUpaYpAhhhO
87JudAm+suz+Bg9881oCquYFoQmWDnzpA8uTfACzMTpSzxktZ4s3FKREY8Wz7orG
e04e50f+JuuPy0ArgfUSPyFZt7aZw5PPax0RhV4EFjIxIzMkR0eN75fQpERe1Vq+
Idu9IZOB5s7rzYdg05wJRm+7OvgQAsegt+eGQzMeSyOfK+FxSW4ie17CXLePMIbY
CHpNYzXCbw65ixVT/TnFJS/8vaIEb0Pjg+62crmJBArxGE8tle+5aSBrL2wO9dQu
uzegeN3sIDlsSlS3Wczo
=Jc1i
-----END PGP SIGNATURE-----

--iXj3Hvq6OOmSabLtEUkquIvf34pXSjIF4--
