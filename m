Return-Path: <antonio@meshcoding.com>
Message-ID: <52FA4F2F.3080304@meshcoding.com>
Date: Tue, 11 Feb 2014 17:26:23 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
 <20140211153224.GB24633@lunn.ch> <52FA4983.6070901@open-mesh.com>
 <201402111111.32918.lew.pitcher@digitalfreehold.ca>
In-Reply-To: <201402111111.32918.lew.pitcher@digitalfreehold.ca>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DkFc14aV730EGBwf0bu3I4ftuP5JGOFcu"
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
To: b.a.t.m.a.n@lists.open-mesh.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DkFc14aV730EGBwf0bu3I4ftuP5JGOFcu
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/02/14 17:11, Lew Pitcher wrote:
> On Tuesday 11 February 2014 11:02:11 Antonio Quartulli wrote:
>> On 11/02/14 16:32, Andrew Lunn wrote:
>>> On Tue, Feb 11, 2014 at 01:48:04PM +0100, Antonio Quartulli wrote:
>>>> From: Linus Luessing <linus.luessing@web.de>
>>>>
>>>> Initially developed by Linus during a 6 months trainee study
>>>> period in Ascom (Switzerland) AG.
>>>>
>>>> Signed-off-by: Linus Luessing <linus.luessing@web.de>
>>>> Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
>>>> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
>>>> ---
>>>>  bat_v.c     |  18 +++++-
>>>>  bat_v_elp.c | 204=20
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>>>  bat_v_elp.h |   6 ++
>>>>  main.h      |   2 +
>>>>  types.h     |  53 ++++++++++++++++
>>>>  5 files changed, 281 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/bat_v.c b/bat_v.c
>>>> index 7247d7f..bed5e00 100644
>>>> --- a/bat_v.c
>>>> +++ b/bat_v.c
>>>> @@ -61,5 +61,21 @@ static struct batadv_algo_ops batadv_batman_v=20
> __read_mostly =3D {
>>>> =20
>>>>  int __init batadv_v_init(void)
>>>>  {
>>>> -	return batadv_algo_register(&batadv_batman_v);
>>>> +	int ret;
>>>> +
>>>> +	/* batman v echo location protocol packet  */
>>>> +	ret =3D batadv_recv_handler_register(BATADV_ELP,
>>>> +					   batadv_v_elp_packet_recv);
>>>> +	if (ret < 0)
>>>> +		goto elp_unregister;
>>>> +
>>>> +	ret =3D batadv_algo_register(&batadv_batman_v);
>>>> +
>>>> +	return ret;
>>>> +
>>>> +elp_unregister:
>>>> +	if (ret < 0)
>>>> +		batadv_recv_handler_unregister(BATADV_ELP);
>>>
>>> No need to check ret here. If we are here, it has to be < 0.
>>>
>>> It also seems odd to me you are unregistering the handler when the
>>> registration of the handler fails!
>>>
>>> I suspect the first if (ret < 0) should be followed by a plain return=

>>> ret; and there should be a second test for the return value of
>>> batadv_algo_register() which should goto the label and unregister the=

>>> handler.
>>
>> I totally agree with what you said.
>> We should jump to elp_unregister if batadv_algo_register() fails.
>=20
> Sorry to break in here, but the (ex) professional programmer in me just=
 /has/=20
> to comment.

Everybody is welcome! :)

>=20
> Why not just
>   int __init batadv_v_init(void)
>   {
>  -	return batadv_algo_register(&batadv_batman_v);
>  +	int ret;
>  +
>  +	/* batman v echo location protocol packet  */
>  +	ret =3D batadv_recv_handler_register(BATADV_ELP,
>  +					   batadv_v_elp_packet_recv);
>  +
>  +	if (ret >=3D 0)
>  +	  ret =3D batadv_algo_register(&batadv_batman_v);
>  +	else
>  +	  batadv_recv_handler_unregister(BATADV_ELP);
>  +
>  +	return ret;
> ?
>=20


Actually I already fixed it like this:

 int __init batadv_v_init(void)
 {
-       return batadv_algo_register(&batadv_batman_v);
+       int ret;
+
+       /* batman v echo location protocol packet  */
+       ret =3D batadv_recv_handler_register(BATADV_ELP,
+                                          batadv_v_elp_packet_recv);
+       if (ret < 0)
+               return ret;
+
+       ret =3D batadv_algo_register(&batadv_batman_v);
+       if (ret < 0)
+               batadv_recv_handler_unregister(BATADV_ELP);
+
+       return ret;


I think it is easier to read, no?
Anyway, this chunk is changed later b patch 7/23 because we add the OGM2
registration.

Cheers,


--=20
Antonio Quartulli


--DkFc14aV730EGBwf0bu3I4ftuP5JGOFcu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS+k8zAAoJEEKTMo6mOh1VIDcP/2gJVYV4dJptE65j3xn6Y7n3
LxqlUKNaIyoC5zYJ25G4E3F5PnpbqArIL7RRerlnBJMA4+MQ9BQ/vh9ew41HbYG1
8RSd5hp8RY/5hwhVDDGI5e/JD8NJbQx+A2JHR5pAtrM3m9JBLVvJOg4QaxoPiSC+
ZEwjsxlUkOEz+w4Rq0iHAMcbV6r+Y7QLB3jka96dnSD7zwRBYvraULs1vEp4WQl2
SHmz1bPNP/LF4uwID4B+0MWfhtGgMDIRPScG5E1erRpTiGDMNap+gN2RO3fWl27l
wDRMripvDhpG71Q1qySK7Lr4veis7at4MsT9CFedFfqOeV1oED0BfixWt2XJzlZi
Pd/EY6ynqMh7VQyxAapDkjm2lxt0SCotHghgSAwxYInB2Z0UApU56qkW+BJd3de+
50w1D17FBikWs2hA24u9WPWMK8DipcYLkaoP7/UUx23shiCdGVL4WQnZC+mSUckY
jofyyHfhh6G30lZBPW8VUGSq4QnDUqw6sQ1uItani/NiOGqZd9GpvRxF+3mrkTZy
ClMRY2Tv7ZI/Cw2yB6YzueYZ74vpqKgeEXt+gz0dEYeph7hQJzm/y3bib3/LJq6u
sZd39GhQGPuUL1Z8/3wOj0CFcLnPwBruQSmfne0kPHNUDI14vQGJgxb6fDFeovXR
nt1SWsowlQDpEHy3Ksjw
=lulw
-----END PGP SIGNATURE-----

--DkFc14aV730EGBwf0bu3I4ftuP5JGOFcu--
