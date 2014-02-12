Return-Path: <antonio@open-mesh.com>
Message-ID: <52FB6525.7090001@open-mesh.com>
Date: Wed, 12 Feb 2014 13:12:21 +0100
From: Antonio Quartulli <antonio@open-mesh.com>
MIME-Version: 1.0
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
 <1392122903-805-16-git-send-email-antonio@meshcoding.com>
 <20140212091215.GI30814@lunn.ch>
In-Reply-To: <20140212091215.GI30814@lunn.ch>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="FGgXff6H6fKFS2FxQOLouPfEQvQKvMIvm"
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
To: Andrew Lunn <andrew@lunn.ch>, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Felix Fietkau <nbd@openwrt.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FGgXff6H6fKFS2FxQOLouPfEQvQKvMIvm
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/02/14 10:12, Andrew Lunn wrote:
> On Tue, Feb 11, 2014 at 01:48:15PM +0100, Antonio Quartulli wrote:
>> From: Antonio Quartulli <antonio@open-mesh.com>
>>
>> In case of a unused link, the throughput estimation will
>> get stuck to the last sampled value and therefore the
>> reported metric will becomes obsolete.
>>
>> Send unicast ELP packets to each neighbor to trigger throughput
>> sampling on unused links.
>=20
> Humm, i can understand the need for this, but i really think the rate
> control code should be sending the probes, not batman. What do the
> wifi people say about this? Have they tried submitting patches to
> them?

I am CC'ing Felix so that he can give his opinion.
But last time I checked Minstrel I realised that it uses data packets to
probe rates (there is not a specific probing packet), meaning that if
there is no data packet to send, then no probing is performed.

Sending this ELP packets (when there is no unicast traffic) is a way to
trigger this mechanism in Minstrel.


>=20
>>  	/* Instead of updating the metric each "received" ELP packet, it is
>>  	 * better to do it on each ELP sending. This way, if a node is dead =
and
>>  	 * does not send packets anymore, batman-adv is still able to timely=

>>  	 * react to its death.
>> +	 *
>> +	 * The metric is updated by following these steps:
>> +	 * 1) if the hard_iface if wifi =3D> send a unicast ELP for
>> +	 * probing/sampling to each neighbor
>> +	 * 2) update the metric value of each neighbor
>=20
> Might be worth pointing out here, that because of queuing, there is no
> guarantee the ELP packets have been send yet and the RC estimated
> bandwidth could be up to 100ms old.

OK, I'll make it explicit. Actually this routine is no meant to get a
"real time estimation", also because the routing algorithm would not be
that fast to react on time.


Cheers,


--=20
Antonio Quartulli


--FGgXff6H6fKFS2FxQOLouPfEQvQKvMIvm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS+2UpAAoJEEKTMo6mOh1VLucP/ig1Xwsm+Vgvu446RAEzbB5J
BbY2U0H+5+t3DCymECHdbNeLSlGs6fiCfcURzWPSpvJ6tv9qo6jbNHX4q5PJiqV/
xd3qNQeIqbewqnGDh7nqawhVv5B3cmB/gn+LZ5wo7xzsD2pxLwAIEYFzTBNb/W2V
2fhdCMnwVKY5jMfJLOQv/R7nNKBabphr6IMpayI5qoaadNHfAUsQtMPjOS488b5R
PgBwkkssOe00Khh4LBtVs3TnCB3S23R22IlZ3W1wJy3XXQzUgNpw+zSgCprHUMws
YG+v+jQcGo8X5xdjoAUkl/PVP4i/LcaRSyAc8O4neWtTGpo7Fwf0tkWy+9ZudABV
OeFg141e1zLJQZtQ1xJs9NMx4mG3AOp0auFgKNCb5svNHsNNxUDgjhNwX7CFO/Vk
rDBC+KZv/cf1l0eKt28Ofxgy1mDtm3W3XzfBcNiAO+NsXpg36q5rqBxOhhd3YUgj
F+GlS+dzmCIvxV69yOm07UZJFub3e8B4DmE3W/ZjcZ3jRX/6hBr+jRktBe4MLDjU
K2OCLp5Woh4bgKleVjcQ17pIGZipVq/VqDXjCkuO4bOUOtThpbrRqEPl0DMqrl+h
FKjibDuzhw/qgj7nV9NdzrcW8qd1j2AbSNIlCFmw3D7xZK0x+kMKAXVELuW4sL2b
ZIZZrRaX6RFY3E/A2c/Z
=tVCx
-----END PGP SIGNATURE-----

--FGgXff6H6fKFS2FxQOLouPfEQvQKvMIvm--
