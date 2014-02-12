Return-Path: <antonio@meshcoding.com>
Message-ID: <52FB70CC.8040208@meshcoding.com>
Date: Wed, 12 Feb 2014 14:02:04 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
 <1392122903-805-16-git-send-email-antonio@meshcoding.com>
 <20140212091215.GI30814@lunn.ch> <52FB6525.7090001@open-mesh.com>
 <52FB6F04.3000404@openwrt.org> <52FB6F75.6070802@meshcoding.com>
In-Reply-To: <52FB6F75.6070802@meshcoding.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vQcbH4LQ9XEMV1Jqi5FoT1c9fFbOI3eJG"
Subject: Re: [B.A.T.M.A.N.] [RFC 15/23] batman-adv: ELP - send unicast ELP
 packets for throughput sampling
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
To: b.a.t.m.a.n@lists.open-mesh.org, Felix Fietkau <nbd@openwrt.org>, Andrew Lunn <andrew@lunn.ch>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vQcbH4LQ9XEMV1Jqi5FoT1c9fFbOI3eJG
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/02/14 13:56, Antonio Quartulli wrote:
> On 12/02/14 13:54, Felix Fietkau wrote:
>> On 2014-02-12 13:12, Antonio Quartulli wrote:
>>> On 12/02/14 10:12, Andrew Lunn wrote:
>>>> On Tue, Feb 11, 2014 at 01:48:15PM +0100, Antonio Quartulli wrote:
>>>>> From: Antonio Quartulli <antonio@open-mesh.com>
>>>>>
>>>>> In case of a unused link, the throughput estimation will
>>>>> get stuck to the last sampled value and therefore the
>>>>> reported metric will becomes obsolete.
>>>>>
>>>>> Send unicast ELP packets to each neighbor to trigger throughput
>>>>> sampling on unused links.
>>>>
>>>> Humm, i can understand the need for this, but i really think the rat=
e
>>>> control code should be sending the probes, not batman. What do the
>>>> wifi people say about this? Have they tried submitting patches to
>>>> them?
>>>
>>> I am CC'ing Felix so that he can give his opinion.
>>> But last time I checked Minstrel I realised that it uses data packets=
 to
>>> probe rates (there is not a specific probing packet), meaning that if=

>>> there is no data packet to send, then no probing is performed.
>> Correct. Minstrel never sends dedicated probing packets. Changing
>> minstrel to send active probing packets to serve the needs of batman
>> would be a very bad idea, because pretty much all regular users do not=

>> have any need for extra probing.
>>
>>> Sending this ELP packets (when there is no unicast traffic) is a way =
to
>>> trigger this mechanism in Minstrel.
>> Right. If I remember correctly, if you send less than 1 packet per 100=

>> ms, then all packets should end up being probing packets. If that
>> doesn't work, we can change minstrel's probing pattern to allow things=

>> like batman to get a desirable amount of rate control probing simply b=
y
>> sending unicast packets.
>=20
> This is what I am trying to achieve here: if no unicast packets have
> been sent for the last 100ms (at least) then send N probing packets in =
a
> row (with N =3D 2 at the moment - it is a define in main.h).
>=20

However, from the experiments performed so far it looked like Minstrel
was behaving properly under these batman probing packets.


As soon as we move on with this project I am sure we will get some more
feedback from other users (perhaps this is something we can test at the
WBM? - this code should be ready and usable by then - cross fingers)


Cheers,


--=20
Antonio Quartulli


--vQcbH4LQ9XEMV1Jqi5FoT1c9fFbOI3eJG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS+3DQAAoJEEKTMo6mOh1ViVsP/2d3qa9TbGP0BoOWyMADNrIQ
H357mA37NCHJxIg/QoE9uAJkC8TRa0xy0T0KX+cgqZmSYTIMy2v1874kvScfRPYz
4wuenF98Bqv4lfTBuKF1o/+DdAeXgLzkhMPlXvTgDRetgEhAGdjkvaMKmYojx6A5
hMiVA0TMKvTQCWBwGrXmqu7OFk9X72Zu3e0nXNa+14D/rOKWeiRrDLdlz4wuYfMz
MrTf/rlfyMBwneDS1hrX+3cH6oB3Zw9CiAhzUpJtPXAWBUj51a2I/P4pLjPQSRr5
w3yiE9oYtQrKPc+GgQceYu+7Wq/bVq9bFo6tZ+IJUsUcFqv/KJ9QeNHiGDi73mvw
hKt+enN6fNkZ78KaTmZ1XqH0F1EW2DtDLIZ0mDWtQQXXibw6Dj0UgTLGi/J0Kaby
cBFtd4guVhIDH5sHRYL9RXM+rgHTEmjoAByyAf7XyZSBH6xccK84W2HYrtpThIhu
Wn7aj7AmGTZ3tGAHcnDdvYsbGD2APAlxRd3OmOCb+kAjfHALHB8js6c0KUXlO7hQ
eKB5y4uraOaTmZ2GRf03J0VXLHtqoVSO0Z8U0MzoBLJrFXVbCG9yNWnemb8q1qhx
clrsSw4+PhmDYpgb7iUP5xwipzL6EJzg7SERMkkfeOrOUvk2sL6rEAlqWDkY6mA6
/MUFDsjwZp5sAmcS9rDl
=Qvgd
-----END PGP SIGNATURE-----

--vQcbH4LQ9XEMV1Jqi5FoT1c9fFbOI3eJG--
