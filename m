Return-Path: <antonio@meshcoding.com>
Message-ID: <52FC981C.50309@meshcoding.com>
Date: Thu, 13 Feb 2014 11:02:04 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
 <1392122903-805-16-git-send-email-antonio@meshcoding.com>
 <20140212091215.GI30814@lunn.ch> <52FB6525.7090001@open-mesh.com>
 <52FB6F04.3000404@openwrt.org> <52FB6F75.6070802@meshcoding.com>
 <20140213095527.GC7193@lunn.ch>
In-Reply-To: <20140213095527.GC7193@lunn.ch>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mxiK0S67d7Llsf2pvwOHfgonNoEX8519R"
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Felix Fietkau <nbd@openwrt.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mxiK0S67d7Llsf2pvwOHfgonNoEX8519R
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 13/02/14 10:55, Andrew Lunn wrote:
>>> Right. If I remember correctly, if you send less than 1 packet per 10=
0
>>> ms, then all packets should end up being probing packets. If that
>>> doesn't work, we can change minstrel's probing pattern to allow thing=
s
>>> like batman to get a desirable amount of rate control probing simply =
by
>>> sending unicast packets.
>>
>> This is what I am trying to achieve here: if no unicast packets have
>> been sent for the last 100ms (at least) then send N probing packets in=
 a
>> row (with N =3D 2 at the moment - it is a define in main.h).
>=20
> Hi Antonio
>=20
> One minor thing to consider is that your statement is actually:
>=20
> if no _batman_ unicast packets have been sent for the last 100ms ...
>=20
> I've used batman in setups where it has not been the exclusive user of
> the hard interface. So there could be other traffic which is keeping
> the RC algorithm up to date. So maybe it would be better to use the
> hard interface statistic counters rather than last time batman sent a
> packet?

We can't use the hard_iface statistics because we need to know where
that traffic has been sent to.
The same interface might connected to several neighbours and the rates
are selected/probed on a per-peer base.

However, to go in the direction that you are suggesting, I could use the
same API I use to read the throughput (cfg80211_get_station()) to also
read when the last packet was sent to a given peer.
This information should be good for our purposes, but it means that we
probe the neighbours right after having read the throughput.

This should not be a problem because as we said in a previous email we
do not require real time throughput updates.


Cheers,


--=20
Antonio Quartulli


--mxiK0S67d7Llsf2pvwOHfgonNoEX8519R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS/JggAAoJEEKTMo6mOh1VdvgP/3aybRw8jS6q4eWy06p32RxH
dhrQZLzmEu043asYJppfL7pjBLKpdGbbIBbgKZyjPzffHE5ARVpHxWLEJa3QYITb
RHid2KHgw7BJ77AktmecV0FGfERefvQg8J2r2Xd0QCyZlI7dAy6aox+nNv9XRsLH
BEdeRCmb+EbAF4RBNmC6Y6sW46DuZZfWxCDE1wcKnQGJ/CCfneh5kpLvS1j0XGrJ
UX5BZhsjM3BIY5Sk4HVuA0qdgbWE0ZKZUOiUcpGqIRP7aZ3VCLEpcFbaSQeQYVdc
kKW7AjRkBAm6+OSOhMMnQTr6meetkc3RxznLtYgTtxmZSRa6eZP1H1Key8hEqUwm
R3dqDlPzNpAsSHDvU+KPhSsEFErU0SgcLuXpQ0fwbFSkopfe7oMYiLLiNcnMGwLM
k0CJ52tg+IimN2Yw8OKmVwg340GsgKMnz1By81AH2edZ2OJp8zUhHo5y8T50AVJx
mfM18492yqRSoybCJwWjZ9BTlw42a4jLMi2utUi3ec0L1ngVV3s9MJqEU3ywPj9E
z3NGWcS2OVHKC+GqD+50IUtTzukuJrMlJ4L/LsHdSk4WAQUL0AWh+6irQem0rrPD
+01hPWR7Wj4cBUetsE+/bsX98ShRHEHXJPttk554JvD1vxLqe8in1KIgqp++ZoAE
p09P3yBWiiEzRAsTLydI
=eu7a
-----END PGP SIGNATURE-----

--mxiK0S67d7Llsf2pvwOHfgonNoEX8519R--
