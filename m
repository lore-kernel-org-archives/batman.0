Return-Path: <gmazzurco89@gmail.com>
Sender: Gioacchino Mazzurco <gmazzurco89@gmail.com>
Message-ID: <50106102.1080406@eigenlab.org>
Date: Wed, 25 Jul 2012 23:11:30 +0200
From: Gioacchino Mazzurco <gio@eigenlab.org>
MIME-Version: 1.0
References: <CAHD-aqKaF4tfsMBQLnyrn4wkqDHQpPjsfCDjhXPzrCbkzM7tsg@mail.gmail.com>
 <20120708100956.GA10210@pandem0nium>
 <CAHD-aq+wSvBc56KGJ6RFDMgnP_sir5TXx83EYPw_WWh8=Geqag@mail.gmail.com>
 <20120725203425.GB11999@pandem0nium>
In-Reply-To: <20120725203425.GB11999@pandem0nium>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE6DC1435F46F3FF50FBE2B90"
Subject: Re: [B.A.T.M.A.N.] 2012.2 OGMs over ethernet issue?
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

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE6DC1435F46F3FF50FBE2B90
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I have not followed the whole thread but i got scared from this reply

I hope I misunderstood

if i do on newer version of batman

$batctl if add eth0

what happen batman will use this interface to do "mesh" or will simply
ignore it because it is ethernet?

On 07/25/12 22:34, Simon Wunderlich wrote:
> Hey Gui,
>=20
> On Mon, Jul 23, 2012 at 04:20:39AM -0300, Gui Iribarren wrote:
>> On Sun, Jul 8, 2012 at 7:09 AM, Simon Wunderlich
>> <simon.wunderlich@s2003.tu-chemnitz.de> wrote:
>> [..]
>>
>> When it doesn't work is when the ad-hoc connection is severed.
>> which makes the thing look like
>> http://www.open-mesh.org/attachments/download/128
>> that is, there are two gateways that can only talk to each other
>> through ethernet (although it's not "batctl if add"ed) don't get each
>> other OGMs
>> after careful re-reading of BLAII docs in the wiki, and extensive
>> chats with NicoEchaniz, i understood this is the planned behaviour (no=

>> OGMs on lan)
>>
>=20
> Yes, that is expected behaviour. We don't want OGMs on the LAN, there w=
ere
> issues with some more "intelligent" switches which regarded OGMs as thr=
eat
> to the network. :)
>=20
>=20
> OGMs are only sent on interfaces added with "batctl if add", and nowher=
e else.
>=20
>=20
>>>> now, node D and C, too far away from each other to communicate over
>>>> wlan, but connected by a "loooong eth cable" (mediated by a wds
>>>> transparent bridge) wouldn't find each other batman originator.
>>>> C originator table was empty, and D only showed P.
>>>> I thought the transparent bridge was misbehaving, so I tried in a
>>>> simpler setup using P and D, with the wifi off:
>>>> but after disabling wlan0 (batctl if del wlan0-2) and adding eth0
>>>> (batctl if add eth0) on both nodes, batman could not see each other
>>>> anymore :(
>>>> i thought i was doing something wrong, so i tried in different ways,=

>>>> but could not get it to work.
>>>> batctl td eth0 shows both outgoing OGMs from local , and incoming OG=
Ms
>>>> from remote,
>>>> but batctl l only reported outgoing OGMs.
>>>>
>>>> http://pastebin.com/7DDUaXu1
>>>
>>> Mhm, that's weird indeed. Is eth0 really not included in any other br=
idge?
>>> It looks like the incoming packets don't reach BATMAN for some reason=
=2E
>> Definitely not included in any bridge.
>> Funny thing is, the only workaround i found for the bug is to
>> *include* the interface in a bridge, and add that bridge to bat0
>> as in:
>> brctl delif br-lan eth0
>> batctl if add eth0
>> # doesn't work
>>
>> brctl delif br-lan eth0
>> brctl addbr blah
>> brctl addif blah eth0
>> batctl if add blah
>> # works fine, OGMs pass through perfectly
>>
>=20
> OK, so you say that it doesn't work when you simply add eth0 batctl, bu=
t it works
> with the bridge? What is the minimal setup which is not working, two ro=
uters
> and one cable?
>=20
> I'm sorry but you lost me somewhere, would be nice to get the smallest =
reproducable
> setup. :)
>=20
> Cheers and thanks,
> 	Simon


--------------enigE6DC1435F46F3FF50FBE2B90
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlAQYQcACgkQnwkeGL0UcCTgFQCaAmim7RKn5r2QAwCKrPUaXLer
tR8AnRax/GOZcwcf5swhzXUUYCyv9c7r
=NQVK
-----END PGP SIGNATURE-----

--------------enigE6DC1435F46F3FF50FBE2B90--
