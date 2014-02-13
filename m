Return-Path: <antonio@meshcoding.com>
Message-ID: <52FC9493.7010302@meshcoding.com>
Date: Thu, 13 Feb 2014 10:46:59 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
 <1392122903-805-15-git-send-email-antonio@meshcoding.com>
 <20140212085812.GH30814@lunn.ch> <52FB68B2.80507@meshcoding.com>
 <52FB96D2.4080406@meshcoding.com> <20140213094516.GB7193@lunn.ch>
In-Reply-To: <20140213094516.GB7193@lunn.ch>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cxPEoKnWNXFPKshQ5m3CedFXjAcmlx7El"
Subject: Re: [B.A.T.M.A.N.] [RFC 14/23] batman-adv: ELP - compute the metric
 based on the estimated throughput
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
--cxPEoKnWNXFPKshQ5m3CedFXjAcmlx7El
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 13/02/14 10:45, Andrew Lunn wrote:
> On Wed, Feb 12, 2014 at 04:44:18PM +0100, Antonio Quartulli wrote:
>> On 12/02/14 13:27, Antonio Quartulli wrote:
>>> On 12/02/14 09:58, Andrew Lunn wrote:
>>>> On Tue, Feb 11, 2014 at 01:48:14PM +0100, Antonio Quartulli wrote:
>>>>> From: Antonio Quartulli <antonio@open-mesh.com>
>>>>>
>>>>> Implement a stub get_throughput() function which returns the
>>>>> estimated throughput towards a given neighbour.
>>>>> Its result is then used to compute the metric value.
>>>>>
>>>>> The metric is updated each time a new ELP packet is sent,
>>>>> this way it is possible to timely react to a metric
>>>>> variation which can imply (for example) a neighbour
>>>>> disconnection.
>>>>
>>>> It is very much a style issue, but i would probably split this into
>>>> two patches. Updating the metric at send time rather than receive
>>>> should have nothing to do with estimated bandwidth.
>>>
>>> Yes, to make it easier I will first move the reading at sending time =
and
>>> then I'll introduce the throughput estimation.
>>>
>>>
>>
>>
>> Andrew,
>>
>> I just rechecked the code and I realised that these "2 changes" are on=
e
>> only because there is no "second change".
>>
>> Before this patch ELP does not perform any metric estimation.
>>
>> This patch adds the estimation mechanism and in particular adds it alo=
ng
>> the ELP message sending path.
>>
>>
>> Maybe this was not clear? Maybe some previous patch gave you the
>> impression that a sort of metric estimation was already performed in t=
he
>> receiving routine?
>=20
> Ah, ok, it was this comment which confused me:
>=20
> +       /* Instead of updating the metric each "received" ELP packet, i=
t is
> +        * better to do it on each ELP sending. This way, if a node is =
dead and
> +        * does not send packets anymore, batman-adv is still able to t=
imely
> +        * react to its death.
>=20

Yeah...it is a refusal from a previous approach that has been changed
during the development phase, but of course I forgot to reword the commen=
t.

> The "instead of" suggests it was previously done differently. The
> BATMAN philosophy has been in the past to react on received packets,
> so i can understand where this came from. But i think this comment
> could be worded:
>=20
> /* The metric is updated on each sent packet.  This way, if a node is
> * dead and no longer sends packets, batman-adv is still able to=20
> * react timely to its death. */

Thanks for the suggestion!


Cheers,

--=20
Antonio Quartulli


--cxPEoKnWNXFPKshQ5m3CedFXjAcmlx7El
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS/JSXAAoJEEKTMo6mOh1V26QQAJm+CMVsEh7bOqyDmnP14Zvf
LAYLWT3aom3QuJnUvE/ecz22I7pjwBwS3VjfnwnSPUbmOOLmIrDf/pMSVKOotqwo
tjbGiKUKdAktnf1McgFpXqcy3OC8XQM8kKHxrX0iEbSiPQ3jDdye6AkUXxDOphh+
vQ2ynmfM/9KVKOC2CN7lKfr/022xFRPte8Sn+ibOkGzLsl2Cmih2GUoFpUKpGvjW
qnhjcfWoWwwtgfRJ1YVP+ZCCiljWnpKqOSATfYgeFs5KYuKiTYhrNEZ5r3ZwBn2N
UwrTBPc5v+PMSkQpwbalLIbXNyDoYa20TT4/tMsCy6U55tm4DApr3T9shed+kk+y
vYJD5p04qkA5c+LfGbQbItn5EnokStxgmFY1uHVaopnp0TRmlW67EAZ04U5eNmi/
vrB5wGxOmrA8Qhba/l+mtedHayRtYjkZbguXg5z8bEZMkoqnYZHIna0ISTWifZSX
hwElODfwiVQYpfz2CdqFyG61BlIxx8pAsryHnO0KF8Zke/nwtzgbRGfYqpqLJDRK
eFvTbH6Gj4RpnN0noOagyC02CkeKVazncWDFR3fKE/IjroaUjksEvgwgfNukIncw
pNuOQATdbBf0QKVF9P07Kt8DpLbpd3N5+SSoVtGFRz1O1AS7s0DjhqCCsMBuPD7C
yhRSg8iIk/kDNB8TR/xB
=sDkI
-----END PGP SIGNATURE-----

--cxPEoKnWNXFPKshQ5m3CedFXjAcmlx7El--
