Return-Path: <antonio@meshcoding.com>
Message-ID: <52FE5662.7000108@meshcoding.com>
Date: Fri, 14 Feb 2014 18:46:10 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
 <1392122903-805-19-git-send-email-antonio@meshcoding.com>
 <20140213105249.GH7193@lunn.ch> <52FCA639.9080204@meshcoding.com>
 <20140213114449.GI7193@lunn.ch> <52FDD2CB.70104@meshcoding.com>
 <20140214173841.GH17451@lunn.ch>
In-Reply-To: <20140214173841.GH17451@lunn.ch>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DCQuUaSNTFrRqdMg2vKOjRGcJXfJFdgAB"
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
To: Andrew Lunn <andrew@lunn.ch>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DCQuUaSNTFrRqdMg2vKOjRGcJXfJFdgAB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 14/02/14 18:38, Andrew Lunn wrote:
>> Hi Andrew,
>>
>> This morning I've been trying to dig into the tg3 Ethernet driver to g=
et
>> an idea of what happens before the NETDEV_UP event is fired.
>>
>> The network stack invokes the ndo_open() callback implemented by the
>> driver and, as far as I can see, this function does not return until
>> having set speed and half/full_duplex state.
>> Thus it looks like that when NETDEV_UP is fired the speed and the
>> full_duplex attribute have already a meaningful value.
>>
>> Of course this may vary depending on the driver, so this may not be th=
e
>> case everywhere.
>=20
> Hi Antonio
>=20

Hi Andrew,

> I just looked at mv643xx_eth.c, the ethernet driver for my NAS box.
> Its ndo_open() function calls phy_start(), but does not wait around
> for the auto-negotiation to complete.

oh ok..then it seems we really need to get some kind of notification for
this..


>=20
> I hacked together a quick test.
>=20
> #!/bin/bash
> ifconfig eth0 down
> sleep 2
> ifconfig eth0 up
> cat /sys/class/net/eth0/duplex
> cat /sys/class/net/eth0/speed
> sleep 0.5
> cat /sys/class/net/eth0/duplex
> cat /sys/class/net/eth0/speed
> sleep 0.5
> cat /sys/class/net/eth0/duplex
> cat /sys/class/net/eth0/speed
> sleep 0.5
> cat /sys/class/net/eth0/duplex
> cat /sys/class/net/eth0/speed
> sleep 0.5
> cat /sys/class/net/eth0/duplex
> cat /sys/class/net/eth0/speed
> sleep 0.5
> cat /sys/class/net/eth0/duplex
> cat /sys/class/net/eth0/speed
> sleep 0.5
> cat /sys/class/net/eth0/duplex
> cat /sys/class/net/eth0/speed
>=20
> Which when run gives:
>=20
> half
> 1000
> half
> 1000
> half
> 1000
> half
> 1000
> half
> 1000
> half
> 1000
> full
> 1000
>=20
> So it is taking 3 seconds after ifconfig returns before it has the
> right duplex mode.

Are you 100% sure that the NETDEV_UP event was sent within those 3
seconds and not after?
If you use a serial console you should see the kernel output mixed with
your test. (just to be 100% sure..)



>=20
>> I think that your NAS might also be a good testing platform, assuming
>> that the owner is willing to insmod batman-adv on that machine :-)
>=20
> I've no problems with batman on this NAS box. It is a box dedicated to
> kernel hacking and experienced many an opps. I currently have 3.13-rc1
> on it, which happens to break the ethernet PHY on reboot :-(
>=20

you shoul dmove to 3.13.3 ;)

Cheers,

--=20
Antonio Quartulli


--DCQuUaSNTFrRqdMg2vKOjRGcJXfJFdgAB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS/lZnAAoJEEKTMo6mOh1VMVYP/2RLERLkWiemu76bdt1MGeKa
0sQjJnSLoaTF7WFjoNM6Fob0cWmXK9yXM0oqN6CON+x0/ur4AqPmtPEt7+ig3QWJ
OHxi+plrOJvKfL4CTVcI4qNdUMCrncyIblfymQerpm6E50UJyxJQhBn9IqG8vlIk
LQNOkWDjADUuVvrNmn6ZWVQXtu88UGLailw22vUf3oLB2HClyRjTcNJpTfkTdN1e
6D/tEUIu/y2mxTyLr63wwsFlJOt91mCNJuZGoEGM+jVanU2mulOWKmyfmWQy4YWV
gC16xnDPcpQr8m2nmbcNNWHpqOOfiZGFXuZKcqA7yLJF07uEQ/Sxi3HZvu7/N+r2
IAnyv+q54sPDYaprtLmeK2do8GghP4ZIAEF+LYMAThYzGX0iv+9AttIv2OV9S8YO
5HOTckAsNV77OQxW+rgJjGK7pTJhkqj/jFhKxn1/088cecKx6fV8UaUN9AvbrvJE
+3eZoecAYdO+ksT565Zwiccn4Dpjr4ktCwdxjWeuXlNkOxi820zfsI5YFR4DQ4Ka
HWcnptOjEQ9fbCR0lVg6z008gm9CeW4X6bwwvWuuitozpGJlVk98LWoKgG6rIxhV
MrJSm1v+ZGMGFRQYOi/eC2Kmu8iVqzLnIanzD0C1SPZz+NBZCD9avVH9GhbL9zi6
gV+OPMX9lihdqIIZHM8d
=EpGO
-----END PGP SIGNATURE-----

--DCQuUaSNTFrRqdMg2vKOjRGcJXfJFdgAB--
