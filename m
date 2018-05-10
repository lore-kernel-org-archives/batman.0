Return-Path: <a@unstable.cc>
References: <20180510152946.7802-1-a@unstable.cc>
 <1595147.f5nhRcq9z3@sven-edge>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <2de68c5c-8fad-5bc0-68c7-e560ad6de526@unstable.cc>
Date: Thu, 10 May 2018 23:35:02 +0800
MIME-Version: 1.0
In-Reply-To: <1595147.f5nhRcq9z3@sven-edge>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hKhhpzQIz5rxeXIbT1F63N19AxBOOsb6Y"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix argument name in
 kernel-doc
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hKhhpzQIz5rxeXIbT1F63N19AxBOOsb6Y
Content-Type: multipart/mixed; boundary="3I38d84lYnjXUPrOcuZltsvdQVnlR41sc";
 protected-headers="v1"
From: Antonio Quartulli <a@unstable.cc>
To: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org
Message-ID: <2de68c5c-8fad-5bc0-68c7-e560ad6de526@unstable.cc>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix argument name in
 kernel-doc
References: <20180510152946.7802-1-a@unstable.cc>
 <1595147.f5nhRcq9z3@sven-edge>
In-Reply-To: <1595147.f5nhRcq9z3@sven-edge>

--3I38d84lYnjXUPrOcuZltsvdQVnlR41sc
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 10/05/18 23:33, Sven Eckelmann wrote:
> On Donnerstag, 10. Mai 2018 17:29:46 CEST Antonio Quartulli wrote:
>> Signed-off-by: Antonio Quartulli <a@unstable.cc>
>> ---
>>  net/batman-adv/tp_meter.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
>> index 11520de9..55d8e4c1 100644
>> --- a/net/batman-adv/tp_meter.c
>> +++ b/net/batman-adv/tp_meter.c
>> @@ -808,7 +808,7 @@ static int batadv_tp_wait_available(struct batadv_=
tp_vars *tp_vars, size_t plen)
>> =20
>>  /**
>>   * batadv_tp_send() - main sending thread of a tp meter session
>> - * @arg: address of the related tp_vars
>> + * @work: address of the related tp_vars
>>   *
>>   * Return: nothing, this function never returns
>>   */
>>
>=20
> Just checked the master branch and the argument is still called arg the=
re:
>=20
>     /**
>      * batadv_tp_send() - main sending thread of a tp meter session
>      * @arg: address of the related tp_vars
>      *
>      * Return: nothing, this function never returns
>      */
>     static int batadv_tp_send(void *arg)
>     {
>=20
> So I will reject this patch.

Agreed and sorry for the mistake. This must be coming from another new
branch we are currently working on.

Cheers,

--=20
Antonio Quartulli


--3I38d84lYnjXUPrOcuZltsvdQVnlR41sc--

--hKhhpzQIz5rxeXIbT1F63N19AxBOOsb6Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlr0ZqYACgkQB6U8WA7y
zXTmZxAAoKT24Nietwb2hj3xwQJ/TWRE69K0GHyrtsFfhyK3ZXeqqS/UKM05fbaL
Xzh2ZXJJWedsbu5gDoRICHSeKExb0fipaNrgViEr1THosl0jkNng3VCRLInbe5yh
BL6aNxedG8gFM7TwXxPzqjoZDYVC0m1VsUlNHDJnfGeu2gN49qhKwowLcazwEz/c
UckEvQcxHXYUUCrBsxIua13etVMBlV6snyH9BiK/9lRu13bFT2C9/waw2iNb2636
jK2IN9x2DezvBPD1IpZdifxg3pccKolYXxdhi2iTZ1XwKsy718gRvRZfH+rPRgpo
isTAxnzrO9qkxFRUs4skFjqzAC5YJra8uat4N/zr/tkYkavaMQHUG2oMCDMZ1Cq7
BmWiPynkkoURl1na3osSUoAJ1B6tMu2W54xznTTS+tRzT7CF5NkdBRAV5Kedlbbd
Xo6LzDqw2/odd/Gp/nlr6T2lbRc59EnRDCnLH2mCZWCs5wr/cOpvvgdF/OxhZ8lJ
5qCu5eUIIfr9g/xgRweOEgLqoEXZ26nzYkotOyMf31m3Br3Kqm18y3v+m7sTNps/
CbNBlhcNb9eaKm5Do8SZzPvsLZShV7qnMDlKQohVlsc3HJ5YGedlYDs9bqgKHr/1
Lh1q/p1h+ktb3cxUR5hgNMkvk7Taf5KUp1rNnrPW+Mzt95vO0vk=
=y9rj
-----END PGP SIGNATURE-----

--hKhhpzQIz5rxeXIbT1F63N19AxBOOsb6Y--
