Return-Path: <antonio@meshcoding.com>
Message-ID: <52DF1156.6000606@meshcoding.com>
Date: Wed, 22 Jan 2014 01:31:18 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <4577758.QFzZxb72dK@diderot> <52D5B47D.8090406@wirelesspt.net>
 <52D631FB.9070106@hundeboll.net> <52D66D45.4060301@wirelesspt.net>
 <52D66DE4.3050300@meshcoding.com> <52DED209.5000207@wirelesspt.net>
 <52DF0A14.3030705@meshcoding.com> <52DF0B77.3070106@meshcoding.com>
 <52DF0D4E.5070207@wirelesspt.net> <52DF0ECE.7000707@meshcoding.com>
 <52DF10D1.4080207@wirelesspt.net>
In-Reply-To: <52DF10D1.4080207@wirelesspt.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ObrGX9hfgK1826hq4d5WpOJqmw7Xq73m0"
Subject: Re: [B.A.T.M.A.N.] batman-adv 2014.0.0 released
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
To: cmsv@wirelesspt.net
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ObrGX9hfgK1826hq4d5WpOJqmw7Xq73m0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 22/01/14 01:29, cmsv wrote:
>=20
>=20
> On 01/21/2014 07:20 PM, Antonio Quartulli wrote:
>> On 22/01/14 01:14, cmsv wrote:
>>>
>>>
>>> On 01/21/2014 07:06 PM, Antonio Quartulli wrote:
>>>> On 22/01/14 01:00, Antonio Quartulli wrote:
>>>>> On 21/01/14 21:01, cmsv wrote:
>>>>>> Yes i understand that but it keeps on increasing.
>>>>>> [   28.600000] batman_adv: bat0: The MTU of interface adhoc0 is to=
o
>>>>>> small (1546) to handle the transport of batman-adv packets. Packet=
s
>>>>>> going over this interface will be fragmented on layer2 which could=

>>>>>> impact the performance. Setting the MTU to 1560 would solve the pr=
oblem.
>>>>>
>>>>> Have you tried applying this patch before testing it once again?
>>>>>
>>>>> http://git.open-mesh.org/batman-adv.git/commit/746d6436f88899a79c1c=
b3b27af0614510368bb7
>>>>>
>>>>
>>>> Actually this patch is already part of the batman-adv package in ope=
nwrt.
>>>> Therefore the question turns in: did you update the batman-adv packa=
ge
>>>> before performing your second test?
>>>
>>> the second test was done today and  yesterday's i updated bataman-adv=
=2E
>>
>> Yes but we are creating confusion.
> Maybe. Lets see.
>>
>> In the second test you *enabled* network coding, therefore it is norma=
l
>> that the overhead grew up. This happens because NC uses more bytes for=

>> its header.
>=20
>=20
> In both tests NC was enabled. I have NC enabled by default before and
> after the update.
> In fact is all tests NC is enabled by default and i undestand the
> increase to 1546 but to 1560 it surprised me.
> Should i still see the increase to 1560  or should it stayed at 1546
> which would be 1532 ?
>=20
>=20

[Please don't remove the batman-adv mailing list from the CC field.]


The first test you have performed was without the patch that fixes the
value reported in that message.



Now that the patch is applied you have to see 1560 when NC is enabled
and 1532 when it is disabled.


Can you confirm?


cheers,


--=20
Antonio Quartulli


--ObrGX9hfgK1826hq4d5WpOJqmw7Xq73m0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS3xFaAAoJEEKTMo6mOh1V4sgQAJuf5RKHoFBii2UCOzmR7knw
sKo/N0QhW3dPV+stbRHmWwypTX9VyodW2e6C/cfL7vLJV4rHm30/LhXdB01KXscf
HNi9njc+8A8CeApb7MKGwiPMYA0vn4y3FYIJxk9I5mtUKiR+lngLLoQMjgS6gb/p
d8TD4ZbIHFREHpA7FgvaMqAUX1uL2jEm0XTeNoLL++BGZO18S40+bTpO1as8oD9o
pAbPe4mY6pWV2TD0Vokc5Jx+os3dbyvbeboQ0kFTRAmngAMuL93WHoOShaSTukR+
JC22M2j40LxAgNDqFuej8PNmS71oJFJS+9BgRRrbRgjVsVR6zOxr7HP4iqBfDzbH
x0hjgoh01tPhrUvtYnP8Mh0Tr5OQKKXU8+kXH77MZ/uuSbPgS6V+xiBX9+a+Pkni
tmGN56Mns+Q6KuoNvdYiJz3j4JmjeW6T3Fprywzd4rqk+6b/bW/wunaX7irSqAo6
vJBTJTaYmcMRguFYOZRs8U30GmgCrtzAMh2vBNq7Lkt/MmMEUzmg6rmE4Rcbeb3j
sFe51wQA9WlAOAIJedmx5ERKydMno56RBf5BYfq57dLlnvhGxduoJYeze60xKmpq
ikbZM305jEkSzm4E23keGuoSA7T57DTIOQlDLsHPZfhcaN5QwtsddIMfcT8laVgX
H8Ify/xY1y3MhVz51EQh
=EAi7
-----END PGP SIGNATURE-----

--ObrGX9hfgK1826hq4d5WpOJqmw7Xq73m0--
