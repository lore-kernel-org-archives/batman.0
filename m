Return-Path: <antonio@meshcoding.com>
Message-ID: <52DF6939.4080909@meshcoding.com>
Date: Wed, 22 Jan 2014 07:46:17 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <4577758.QFzZxb72dK@diderot> <52D5B47D.8090406@wirelesspt.net>
 <52D631FB.9070106@hundeboll.net> <52D66D45.4060301@wirelesspt.net>
 <52D66DE4.3050300@meshcoding.com> <52DED209.5000207@wirelesspt.net>
 <52DF0A14.3030705@meshcoding.com> <52DF0B77.3070106@meshcoding.com>
 <52DF0D4E.5070207@wirelesspt.net> <52DF0ECE.7000707@meshcoding.com>
 <52DF10D1.4080207@wirelesspt.net> <52DF1156.6000606@meshcoding.com>
 <52DF166A.7080309@wirelesspt.net>
In-Reply-To: <52DF166A.7080309@wirelesspt.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="heO0o661v6w9LdJD7XrC9psTNsvxt1Adk"
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
--heO0o661v6w9LdJD7XrC9psTNsvxt1Adk
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 22/01/14 01:52, cmsv wrote:
> inline:
>=20
> On 01/21/2014 07:31 PM, Antonio Quartulli wrote:
>> On 22/01/14 01:29, cmsv wrote:
>>>
>>>
>>> On 01/21/2014 07:20 PM, Antonio Quartulli wrote:
>>>> On 22/01/14 01:14, cmsv wrote:
>>>>>
>>>>>
>>>>> On 01/21/2014 07:06 PM, Antonio Quartulli wrote:
>>>>>> On 22/01/14 01:00, Antonio Quartulli wrote:
>>>>>>> On 21/01/14 21:01, cmsv wrote:
>>>>>>>> Yes i understand that but it keeps on increasing.
>>>>>>>> [   28.600000] batman_adv: bat0: The MTU of interface adhoc0 is =
too
>>>>>>>> small (1546) to handle the transport of batman-adv packets. Pack=
ets
>>>>>>>> going over this interface will be fragmented on layer2 which cou=
ld
>>>>>>>> impact the performance. Setting the MTU to 1560 would solve the =
problem.
>>>>>>>
>>>>>>> Have you tried applying this patch before testing it once again?
>>>>>>>
>>>>>>> http://git.open-mesh.org/batman-adv.git/commit/746d6436f88899a79c=
1cb3b27af0614510368bb7
>>>>>>>
>>>>>>
>>>>>> Actually this patch is already part of the batman-adv package in o=
penwrt.
>>>>>> Therefore the question turns in: did you update the batman-adv pac=
kage
>>>>>> before performing your second test?
>>>>>
>>>>> the second test was done today and  yesterday's i updated bataman-a=
dv.
>>>>
>>>> Yes but we are creating confusion.
>>> Maybe. Lets see.
>>>>
>>>> In the second test you *enabled* network coding, therefore it is nor=
mal
>>>> that the overhead grew up. This happens because NC uses more bytes f=
or
>>>> its header.
>>>
>>>
>>> In both tests NC was enabled. I have NC enabled by default before and=

>>> after the update.
>>> In fact is all tests NC is enabled by default and i undestand the
>>> increase to 1546 but to 1560 it surprised me.
>>> Should i still see the increase to 1560  or should it stayed at 1546
>>> which would be 1532 ?
>>>
>>>
>>
>> [Please don't remove the batman-adv mailing list from the CC field.]
>>
> unintentional mistake of too many buttons around :P
>=20
>>
>> The first test you have performed was without the patch that fixes the=

>> value reported in that message.
>>
>>
>>
>> Now that the patch is applied you have to see 1560 when NC is enabled
>> and 1532 when it is disabled.
>=20
> Doing some tests and with NC disabled:
>=20
>  uci show batman-adv | grep network_coding
> batman-adv.bat0.network_coding=3D0
>=20
> after reboot:
>=20
> # dmesg | grep MTU
> [   28.030000] batman_adv: bat0: The MTU of interface adhoc0 is too
> small (1546) to handle the transport of batman-adv packets. Packets
> going over this interface will be fragmented on layer2 which could
> impact the performance. Setting the MTU to 1560 would solve the problem=
=2E
>=20
>  uci show network | grep mtu
> network.mesh0.mtu=3D1546
>=20
> changing the mtu to 1560 when NC is disabled:
>=20
> # uci show batman-adv | grep network_coding
> batman-adv.bat0.network_coding=3D0
>=20
> # dmesg | grep MTU
> no output/result
>=20
> # ifconfig | grep MTU
>           UP BROADCAST RUNNING MULTICAST  MTU:1560  Metric:1
>           UP BROADCAST RUNNING MULTICAST  MTU:1440  Metric:1
>           UP BROADCAST RUNNING MULTICAST  MTU:1440  Metric:1
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           UP LOOPBACK RUNNING  MTU:16436  Metric:1
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>=20
> Frist result if the adhoc interface with 1560
>=20
> correct me if i am mistaken but according to you it should be 1532 ?
>=20
> Changing it to 1532 still keeping network coding disabled.
>=20
> uci set network.mesh0.mtu=3D1532
> uci commit network
> reboot
>=20
>  uci show network| grep mtu
> network.mesh0.mtu=3D1532
>=20
>  uci show batman-adv | grep network_coding
> batman-adv.bat0.network_coding=3D0

No, the MTU value changes only when NC is disabled at compile time.


--=20
Antonio Quartulli


--heO0o661v6w9LdJD7XrC9psTNsvxt1Adk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS32k+AAoJEEKTMo6mOh1VcpgP/0oGFqKfZkDlcPUaNuOXlmzB
tIELMRt7VRwec7ILjm5oq3npgUEUIxQErFWCw9T2JEjNz1IJYj2dhQNHE6pTQK86
uM037N9QX9jFN4ijbBfFuLWpaAiGmTKa3fPLib0Pd6SG2pwV4NAa55q4YwkTHWYC
kRczzxVdPS5MGGg+f2S8f+DoZFaNY3CXrIvdgvPl82gLvoWeEXOpacd3NrtSg3Jq
bViKnpGRO//jj6iA21pXm5ogwbDFWwCSK4JZE+sOXoXYDBYAZi+4FdoHneos6yAx
3svY2h+KPKNL7xKmq4W5E3O9gMfAhHGyHRpw4wfsrPyyL+Sar+Y9V5TiY9rifb0N
82zBlUOtRp5MMu7uR7QZl9QqaLHfgoXmNhCzQom/3gWjXLiNKzZJ/YfllpIQxPnW
hRCwwYXefKB2atWfJKwlDOvBvYp6CokKmzaPS32UY51RKaxVX3CAh9Fk92V+1fTD
sNikJDx0Z5LBWvsVvrKek6vKhDcBVO6cc6MTuvgMRiGe9HeNGGNZXzkHYpPmCKbr
NnJriJuXlTy9h1egSRJ+VxiNGwHrd+JaG7j2DOXodWCcMNQxp5JoXDRjQ3Qa0M5X
gO+ePIyhcrBwSc6vwPk15/R+lhk7UiitoTNzjmKzIYxhdzF5+D4PvIBQ28G4+vnH
4ENjB36mbbezR1iGWteC
=M1jm
-----END PGP SIGNATURE-----

--heO0o661v6w9LdJD7XrC9psTNsvxt1Adk--
