Return-Path: <antonio@meshcoding.com>
Message-ID: <52FC9AD9.5020704@meshcoding.com>
Date: Thu, 13 Feb 2014 11:13:45 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
 <1392122903-805-16-git-send-email-antonio@meshcoding.com>
 <20140212091215.GI30814@lunn.ch> <52FB6525.7090001@open-mesh.com>
 <52FB6F04.3000404@openwrt.org> <52FB6F75.6070802@meshcoding.com>
 <20140213095527.GC7193@lunn.ch> <52FC981C.50309@meshcoding.com>
 <20140213100954.GE7193@lunn.ch>
In-Reply-To: <20140213100954.GE7193@lunn.ch>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="31QjTKpRm0kv2okRrV4XV5g8LL1CRqPSE"
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
To: Andrew Lunn <andrew@lunn.ch>
Cc: Felix Fietkau <nbd@openwrt.org>, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--31QjTKpRm0kv2okRrV4XV5g8LL1CRqPSE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 13/02/14 11:09, Andrew Lunn wrote:
>> We can't use the hard_iface statistics because we need to know where
>> that traffic has been sent to.
>=20
> Oh, yes, my error.
>=20
>> However, to go in the direction that you are suggesting, I could use t=
he
>> same API I use to read the throughput (cfg80211_get_station()) to also=

>> read when the last packet was sent to a given peer.
>> This information should be good for our purposes, but it means that we=

>> probe the neighbours right after having read the throughput.
>=20
> My guess is, there are not many use cases where the hard interface is
> used for other traffic as well as BATMAN. So i don't see it as being a
> big issue. Maybe put it onto a TODO list once the code has been
> merged, to swap to using statistics from lower down in the stack.
>=20

Yes, note taken ;)

Thanks!


--=20
Antonio Quartulli


--31QjTKpRm0kv2okRrV4XV5g8LL1CRqPSE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS/JrcAAoJEEKTMo6mOh1VeOsP/jI0w+ETGGJsO6vdnNzzN67o
gJOrTBvPFivIQMe5nA6lZs9GusuTaC7D4uF7ZKz7pIhsbvSBHQ9k3+CFNEUArUUI
AVjP+9Jq+VvAmlT2ndDkRo1I73yuP95a7dRfTswTBQLnhCzHaRQNa3dC4iayjPXI
4VR3uDkiirQeIzyYkFg674IRmOjXVzsCS6gGhknn8V3086Gp0KVAqpvRkH0accPV
6OuPN0eLrYNiRzdCBkmjyQ5nDVRn3UkTBqaOdhCz6+NP4ycxwatt8AYQMYRwa7m3
gVLXM+E21E+ZgHVf8c4J1dDe+tpnNNGfrdY2aQLiW1uuT34+P6Kl4D8tUhBJZ2XT
Ulvc7NkYhHZz5rQPBeAt0c1WzJcWZ/LwlvUKVV7ank9nN0f7Niwmw/UMNRgCUqZF
gaKYq7e2FfH1i+YwyCDwA6dfmzGkTBhovObFYuC9ji1qXAhd/iH54gRTrP/6ZtCk
0wBHNqhwOdpXjNJ4kBg8uxwsSNOIIYNZpXiJTtNl12rHCmciXV9R+F4769XU99VN
HrZfA3c1w2Q12Ef3eAzUOZhQVk7Krv0z+3kZAz3p6gOWuwpYDPMkOOiVgxz+Yzsh
eiy5aeIkB1gcATzeY3WndQutbBIdCFm0KUecEePfk0VbXm9twacnVGsGNBv9oLp+
OCK/B2zb23ymJ7ZPzL0F
=/ESN
-----END PGP SIGNATURE-----

--31QjTKpRm0kv2okRrV4XV5g8LL1CRqPSE--
