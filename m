Return-Path: <martin@hundeboll.net>
Message-ID: <52FA5DE6.8050005@hundeboll.net>
Date: Tue, 11 Feb 2014 18:29:10 +0100
From: =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>
MIME-Version: 1.0
References: <1391874306-15627-1-git-send-email-sw@simonwunderlich.de>
 <52FA5D35.6020809@meshcoding.com>
In-Reply-To: <52FA5D35.6020809@meshcoding.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="TSAGwCrCkuNhr9nsiqtPxcAF5TNajbTKl"
Subject: Re: [B.A.T.M.A.N.] [PATCH-maint] batman-adv: fix potential
 orig_node reference leak
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Simon Wunderlich <sw@simonwunderlich.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TSAGwCrCkuNhr9nsiqtPxcAF5TNajbTKl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2014-02-11 18:26, Antonio Quartulli wrote:
> On 08/02/14 16:45, Simon Wunderlich wrote:
>> Since batadv_orig_node_new() sets the refcount to two, assuming that
>> the calling function will use a reference for putting the orig_node in=
to
>> a hash or similar, both references must be freed if initialization of
>> the orig_node fails. Otherwise that object may be leaked in that error=

>> case.
>>
>> Reported-by: Antonio Quartulli <antonio@meshcoding.com>
>> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
>> ---
>>  bat_iv_ogm.c |    2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
>> index 6f4fcdc..6000337 100644
>> --- a/bat_iv_ogm.c
>> +++ b/bat_iv_ogm.c
>> @@ -256,6 +256,8 @@ batadv_iv_ogm_orig_get(struct batadv_priv *bat_pri=
v, const uint8_t *addr)
>>  free_bcast_own:
>>  	kfree(orig_node->bat_iv.bcast_own);
>>  free_orig_node:
>> +	/* free twice, as batadv_orig_node_new set refcount to 2 */
>> +	batadv_orig_node_free_ref(orig_node);
>>  	batadv_orig_node_free_ref(orig_node);
>=20
> Coudln't we just invoke kfree(orig_node) here ? I think that if we hit
> this point it is because the node has not added to the hash and
> therefore it i snot used in any other context. This way we avoid the
> double free_ref() and we don't trgger the whole RCU mechanism.
>=20
> Or am I missing something?

batadv_<type>_free_ref() might have side effect that are not handled by
kfree alone...

--=20
Kind Regards
Martin Hundeb=C3=B8ll
Frederiks All=C3=A9 99, 1.th
8000 Aarhus C
Denmark

+45 61 65 54 61
martin@hundeboll.net


--TSAGwCrCkuNhr9nsiqtPxcAF5TNajbTKl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCgAGBQJS+l3mAAoJEI7EM4tTnYEZkDYQAKaNjYg5xXa0hczhFU6SBtzK
eHSUyXeR7I/zkujkCGNxyzFqxcSfjw5SLeXv5FQix7y1Z77ktLLjN5V390fZXwcY
sgLwlSOHorauwYCuOw0b9inTVLrcr51O2/psppVkjkreh9Uy1NoYB6Ee/oYrBvHU
Qk/gUHZl8LGmsdtSgN3C1AsXHCusESRjbRsZfELbZrbbL0p22wVyB7LlEYL0I9Qu
rnye6/evtzEwzWtZjnUJnlRKCHLZt/jNrgvHydS/rn9kYwEsEif4xXritCmT/4PW
e3xaGLu+WibNAEy4+dprFJUx7CgreecDogwNxrsydDbQ8EoVkGvCfVcnm4VM0vaE
RnfztUYo8yxU1CLZ5ojOUgv5DaFIO3jxSljpbfMVWN4s1rB2P4Ep6YMDK+1TlFor
AzalFSjcNQRG0wnTIhgFXD7O54VQCIzkjlDC5fPIQEi5RGZgB/g/1J4StzOhhD2k
dgcCXZ4ywolkLQIHRjId2wMfMxraYvfnlLo6HjuT9adB1GRgMZYkyeSr+Kmye24a
rMl/V3iwq285dJo33e5f4vlfx/ZZ8KMm0QmS8M+CUAs6HYg3JvUY+rNPyLUKj2mL
Wkg4wbvlJt9pfmIB77LUilq5A1CxGeyy1PZ0Yvtol6dikH2ZjFz55pVkAhqTI3z2
KueSMAUQ4wMkZKeDniFj
=YXfs
-----END PGP SIGNATURE-----

--TSAGwCrCkuNhr9nsiqtPxcAF5TNajbTKl--
