Return-Path: <a@unstable.cc>
References: <CAA_JP8WFZPzDzFLAAOydhjuL7Ex26_RtbnH-pEhaCe4Fs70FEA@mail.gmail.com>
 <13544673.RylKELaqkV@sven-edge>
 <CAA_JP8WCg+FVRdwYrqh-LS4Z52_rNHV5NkZwjRwS7Rksns7h7g@mail.gmail.com>
 <2470987.7o5QObroCJ@bentobox>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <53ab8663-550b-442c-20ab-162414ca83ee@unstable.cc>
Date: Tue, 22 Aug 2017 15:01:08 +0800
MIME-Version: 1.0
In-Reply-To: <2470987.7o5QObroCJ@bentobox>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lnTBC7QFRPUau0u1V80bruwG6Rhxu3NHU"
Subject: Re: [B.A.T.M.A.N.] batman on top of vlan?
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>, dan <dandenson@gmail.com>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lnTBC7QFRPUau0u1V80bruwG6Rhxu3NHU
Content-Type: multipart/mixed; boundary="aJ0G6rRHnDgV83MaHDoOtnC9frbmXWcjC";
 protected-headers="v1"
From: Antonio Quartulli <a@unstable.cc>
To: Sven Eckelmann <sven@narfation.org>, dan <dandenson@gmail.com>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
Message-ID: <53ab8663-550b-442c-20ab-162414ca83ee@unstable.cc>
Subject: Re: [B.A.T.M.A.N.] batman on top of vlan?
References: <CAA_JP8WFZPzDzFLAAOydhjuL7Ex26_RtbnH-pEhaCe4Fs70FEA@mail.gmail.com>
 <13544673.RylKELaqkV@sven-edge>
 <CAA_JP8WCg+FVRdwYrqh-LS4Z52_rNHV5NkZwjRwS7Rksns7h7g@mail.gmail.com>
 <2470987.7o5QObroCJ@bentobox>
In-Reply-To: <2470987.7o5QObroCJ@bentobox>

--aJ0G6rRHnDgV83MaHDoOtnC9frbmXWcjC
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22/08/17 14:59, Sven Eckelmann wrote:
> On Sonntag, 20. August 2017 11:52:24 CEST dan wrote:
>> thanks.  Just to clarify, batman-adv 32 bytes, so to stack vlans qinq
>> I need 32+4+4 so 1540 yes?
>=20
> Seems to be right.
>=20
> But TT doesn't track QinQ clients with two VLANs (it only tracks the ou=
ter=20
> VLAN). Maybe Antonio already thought about possible consequences.

I haven't really thought this trough, but I think it should still work,
because batman-adv will just take care of delivering the packet to/from
where the outer encapsulation is applied/removed. What happens to the
inner payload should not be batman's business.  If I see this correctly.


Cheers,

--=20
Antonio Quartulli


--aJ0G6rRHnDgV83MaHDoOtnC9frbmXWcjC--

--lnTBC7QFRPUau0u1V80bruwG6Rhxu3NHU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEbd2mMhAXbmSCipS40+HICM1soFAFAlmb1rgACgkQ0+HICM1s
oFDb5w//R587+JbW2HmULoQEazAtsULbQEVjMSgG00d/pUmX1eGXJAVj8AX+g0ws
6xWgO0O8NqKq9n5JXyYvmlVhd+6/xEc0z9kUbvd2WeaJXiYBK56zb7qdNtnIhlFZ
t0x8/1AKHIs+ERvMzOePsqhupGOuI2UIsDt3HYvQNoC1Uc4CHFh3pvqGuQC8btSp
bGp10cEtK846gK1T46HnuyoCfejcyr/wNjP51cGh3islTPXAj51jgW//QWzmqYvK
3rUNVqvfqimRt/SzZdbQkyccquy2DjA4aMOCSHPVxPVOgjmISXITRTZEMpjUk/NZ
qlrnh5aXt8HuMthNpZIG/Kln60qej9u7dCbCzLbBQnd7Sz+dtGi2Z60TgPjHNxay
5GMae4fRP2EYmAXHMmC7PKaa/D8W1i+hmbtlpzLH9G0hx86IVWmikRsMyXlqW2Uz
pSZCacPxrmd+AbXvLb/XIumFl3BFFdPzXr/L0xCF4TFxJ5b+yyiHh9+DcTzX8uYR
Cls2hGrc6mlmEl95mw5SHJtKCastfGYbKYcXt1/8ynIu7kVyHh4SOvvpu5aV0Pts
fD+kctgQlW8ouua+TSl4LltxZSGH7fZjEphtttqjUTSlA6OhWGJ32ub16qK20T3E
Y936Syhyk0GUYBLEeWro2wic+WxgJuDs6PqnCEBhf85l4na4skg=
=OJmD
-----END PGP SIGNATURE-----

--lnTBC7QFRPUau0u1V80bruwG6Rhxu3NHU--
