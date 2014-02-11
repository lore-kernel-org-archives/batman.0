Return-Path: <antonio@meshcoding.com>
Message-ID: <52FA5F12.5090406@meshcoding.com>
Date: Tue, 11 Feb 2014 18:34:10 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1391874306-15627-1-git-send-email-sw@simonwunderlich.de>
 <52FA5D35.6020809@meshcoding.com> <52FA5DE6.8050005@hundeboll.net>
In-Reply-To: <52FA5DE6.8050005@hundeboll.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ov33v7tadL4xk01IUP713lS6kbpllT6cg"
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
To: b.a.t.m.a.n@lists.open-mesh.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ov33v7tadL4xk01IUP713lS6kbpllT6cg
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/02/14 18:29, Martin Hundeb=C3=B8ll wrote:
> On 2014-02-11 18:26, Antonio Quartulli wrote:
>> On 08/02/14 16:45, Simon Wunderlich wrote:
>>> Since batadv_orig_node_new() sets the refcount to two, assuming that
>>> the calling function will use a reference for putting the orig_node i=
nto
>>> a hash or similar, both references must be freed if initialization of=

>>> the orig_node fails. Otherwise that object may be leaked in that erro=
r
>>> case.
>>>
>>> Reported-by: Antonio Quartulli <antonio@meshcoding.com>
>>> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
>>> ---
>>>  bat_iv_ogm.c |    2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
>>> index 6f4fcdc..6000337 100644
>>> --- a/bat_iv_ogm.c
>>> +++ b/bat_iv_ogm.c
>>> @@ -256,6 +256,8 @@ batadv_iv_ogm_orig_get(struct batadv_priv *bat_pr=
iv, const uint8_t *addr)
>>>  free_bcast_own:
>>>  	kfree(orig_node->bat_iv.bcast_own);
>>>  free_orig_node:
>>> +	/* free twice, as batadv_orig_node_new set refcount to 2 */
>>> +	batadv_orig_node_free_ref(orig_node);
>>>  	batadv_orig_node_free_ref(orig_node);
>>
>> Coudln't we just invoke kfree(orig_node) here ? I think that if we hit=

>> this point it is because the node has not added to the hash and
>> therefore it i snot used in any other context. This way we avoid the
>> double free_ref() and we don't trgger the whole RCU mechanism.
>>
>> Or am I missing something?
>=20
> batadv_<type>_free_ref() might have side effect that are not handled by=

> kfree alone...

true, but since the orig_node has not been returned yet there is no
other component in batman-adv which is using it.

Otherwise, we may want to define and invoke a free_now() version of this
function (like we have done for other objects). But I think kfree() is
safe here.


Cheers,



--=20
Antonio Quartulli


--ov33v7tadL4xk01IUP713lS6kbpllT6cg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS+l8VAAoJEEKTMo6mOh1VdWcQAIhF1OFj2o/I01hC3LxPGMdp
usWFWkRVRRiJuHIvOLjRabPzKokN5FI78OxMT7dkx7ITkcDc5P0BBsALjUgp8bKM
xeRKSJxxgnf13wzvZ1Y8vP0ZtQEpF+EnWS6M0TE2LYirV+/D3YSzRtH2yHHAwYMK
+xT/tsPt3iEXRf1lWry0asrmJv2Swb6pyqhFpmmlbLDEr0B+kNW8eru1DoT6NiTj
IX7whardAVxksAhpbVqI8v7otAOc+DN/jokFSIG7hcp6RxTtfuonZfZoYZGz2gSy
GX6R/ch9t45haLTct1sZvXkSiw2YskVbnxqMH41Slk2DbSo64QLGM6honD5daCtN
TImCpxyJr9KPCJ87ZJZcBH0A+l6JCmZAVidm/OEL0OJXxvHGB6h/UQzZWpHPY2WW
HIWh8hqgS4cca4Ih7ksri/PhIMZ1ZavR0k1NfML9vaxHVxNekQOPU861RWu970xk
gTAby4SOtIT15OurbghvRlUNhhDri4Y1Nf2aMwbfFDvmZOvmTPcq4mzp0EImyHGD
TyCEjWr2TBO0GLErjWZupAmZgt/Oiqup1mMzo0Wn07Njc/dVQQ1qkqGi9laIZEK+
0obSRgJcVQrZD8HvaKU9NQA21jMyBe/fd0ArktPkt1jHYEbACo2Q7Y/1H35VUxN7
CTuQN4BqdbH+K1i1MEXt
=AJRV
-----END PGP SIGNATURE-----

--ov33v7tadL4xk01IUP713lS6kbpllT6cg--
