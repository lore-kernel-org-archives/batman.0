Return-Path: <antonio@meshcoding.com>
Message-ID: <52FDD2CB.70104@meshcoding.com>
Date: Fri, 14 Feb 2014 09:24:43 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
 <1392122903-805-19-git-send-email-antonio@meshcoding.com>
 <20140213105249.GH7193@lunn.ch> <52FCA639.9080204@meshcoding.com>
 <20140213114449.GI7193@lunn.ch>
In-Reply-To: <20140213114449.GI7193@lunn.ch>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="QqglgM05S6TduD6oQNdD6g2o5mQXQrKgN"
Subject: Re: [B.A.T.M.A.N.] [RFC 18/23] batman-adv: ELP - use phydev to
 determine link characteristics
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Andrew Lunn <andrew@lunn.ch>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QqglgM05S6TduD6oQNdD6g2o5mQXQrKgN
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 13/02/14 12:44, Andrew Lunn wrote:
>> it is invoked every time the interface is brought up. So if you
>> disconnect and then reconnect the cable (e.g. to connect the NIC to a
>> faster switch) this function is invoked again and the bandwidth is upd=
ated.
>>
>>> Are we sure that auto-negotiation has
>>> finished? It can take a few seconds to complete after the interface i=
s
>>> brought up. It would not be good to have batman use 10Mbps/Half Duple=
x
>>> on my gigabit links...
>>
>> So it can take up to "few" seconds? I did not expect such a delay!
>=20
> It varies a lot between devices. I have a NAS box which i use for
> kernel hacking. I TFTP boot the kernel, using u-boot configuration
> variables. I found that for a cold boot it works great, but a warm
> boot seems to be faster and the TFTP GET command is sent while the phy
> is still auto-negotiating, and it gets lost. This then triggers a bug
> in u-boot, it never re-transmits the GET command, and then whole TFTP
> boot times out eventually.
>=20
> So i'm just cautious about making assumptions here, especially
> assumptions which might be mostly true, but in some odd edge case turn
> out to be false.
>=20
>> However this function if invoked when the NETDEV_UP event is issued by=

>> the underlying system. I expect the event to be thrown when the
>> interface is ready to be used, not when the auto-negotiatin is still
>> going on. I will double check.
>=20
> I had a quick look at the code. It seems like NETDEV_UP is issued
> directly after the device is opened. There does not seem to be any
> waiting around for auto-neg.


Hi Andrew,

This morning I've been trying to dig into the tg3 Ethernet driver to get
an idea of what happens before the NETDEV_UP event is fired.

The network stack invokes the ndo_open() callback implemented by the
driver and, as far as I can see, this function does not return until
having set speed and half/full_duplex state.
Thus it looks like that when NETDEV_UP is fired the speed and the
full_duplex attribute have already a meaningful value.

Of course this may vary depending on the driver, so this may not be the
case everywhere.

I think that we can keep this approach for now and then perform some
tests on a couple of platforms before merging the code.
This way we should be "sure" about this particular behaviour.

I think that your NAS might also be a good testing platform, assuming
that the owner is willing to insmod batman-adv on that machine :-)



Cheers,

--=20
Antonio Quartulli


--QqglgM05S6TduD6oQNdD6g2o5mQXQrKgN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS/dLOAAoJEEKTMo6mOh1VMtkP/2+rD76JKzScWzR4wcxheHpt
YYgRwyX2KuMrZI+O7eFgntSTVy9E34n8DxBhnomSlJfMQV8U0777A8G1mpaa88Ra
CFR9LmMdpenWjh4wiM0YPSrFLHUk79uxR8k6LUOP50r6XVoTmlaAGXxMFhL04IcP
Bcv9bLQvT2IHfQxpSsAs0fZ1lyoZ79/ZC61WqwktepXyfRbrkp0rV+f9E/zB1SPM
z/7gb6tllGjVwhWzH+kvKL+DSH5rQeFL+MOJ68P+R6rd14Lq/IwUdi3wB2eOLudh
DLU0lSTUBll/obHfUIHae0G+RvTeGv05z5lQBv0udw9y1Ko+Q1bDoUSyeRXepdrc
rbhq9tbWsMka0oBkzxy7LI/+lIkFniL53WCIQe27dkHnDK3b0TgRqe2XQCv6j4Nz
HHet3OAeihm98iW5YTONTABQIejn9ico9lLQr3i9T5QSVQklOi/qDJkwRsVHymrJ
z1nUkw2V0V5XldUjNRKSS0jKwDe7G/c5c43RiZXbqdqY8QI7hOVZrOos/dl40GXj
lNUxwYHePxKbrQOhrhQJBe5mGmPgWbRJGPVfh3XujQwP/bfUCh471xDuHhHLUyws
WIYDCaU4RtmoYyb+wTxNjXAdQmqFz4ZgYMcz1mPx87EVJAFjZRCfIaHGc0pye1zF
+mrjmPA/BrmI62aIwOz4
=WRRA
-----END PGP SIGNATURE-----

--QqglgM05S6TduD6oQNdD6g2o5mQXQrKgN--
