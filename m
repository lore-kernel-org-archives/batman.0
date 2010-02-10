Return-Path: <linus.luessing@web.de>
Date: Wed, 10 Feb 2010 03:43:21 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100210024321.GB2112@Linus-Debian>
References: <4B6F288E.8050406@muc.ccc.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
In-Reply-To: <4B6F288E.8050406@muc.ccc.de>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] batman-adv 0.2 on openwrt
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Okay, had a closer look at the 2.6.26-kernel issue. Could you
please try the patch I've posted here:
https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2010-February/002285.html
This should fix the freezing on your router with r1568-maintenance
at least.

Would be interesting to know, in case this patch works, if you are
still having this "protocol 4305 buggy" in the current batman-adv
version then (though I doubt that this issue might have vanished
there).

Cheers, Linus

On Sun, Feb 07, 2010 at 09:54:38PM +0100, x@muc.ccc.de wrote:
> hi!
>=20
> as openwrt 8.09.2 still ships with an old batman-adv 0.1 module, i tried =
to compile a batman-adv 0.2 module.
> the compile worked, the module loads, originators see each other, but on =
the openwrt box on bat0 tx packets stays 0 while tx dropped obviously incre=
ases with each packet to be transmitted.
>=20
> the setup:
> laptop debian squeeze amd64 2.6.31.12 batman-adv 0.2
> laptop debian sid x86 2.6.32 batman-adv 0.2
> ap openwrt 8.09.2 ixp4xx/armeb (cambria) 2.6.26.8 batman-adv 0.2
>=20
> the facts:
> all bridges and iptables switched off.
> with plain ip on the wlan interfaces, pinging between all nodes works fin=
e (when within reach).
> all three nodes have the respective two other nodes listed as originators=
, and if all are within reach of each other, with originator=3Dnexthop.
> pinging via bat0 works between the two laptops.
> pinging the laptops via bat0 from the ap results in no packets seen on th=
e laptops' bat0.
> pinging the ap via bat0 from a laptop results in incoming arp-requests an=
d outgoing arp-replies seen on the ap's bat0 - but again, the arp-replies a=
ren't seen on the laptops' bat0 (nor on the laptops' wlan interfaces).
> on the ap's bat0, the tx packets counter stays at 0, while the tx dropped=
 counter seems to increase with each packet that should be sent over it.
>=20
> i enabled all logging (15) on the ap and the laptops, but found no hint i=
n there...
>=20
> the only interesting messages seem to be in dmesg, saying:
> protocol 4305 is buggy, dev ath1
>=20
> so to me it seems like all tx packets on bat0 on the ap are dropped, whil=
e everything else seems to work as it's supposed to.
>=20
> i then tried to compile the current (r1568) version from svn for the ap. =
again, the compile worked, but the ap just freezes immediately when i try t=
o load it.
>=20
> i thought about trying a newer kernel for the ap, but from openwrt there'=
s a special cambria kernel and i haven't found its config and also don't kn=
ow what patches might have been applied, so i haven't had much hope for any=
 helpful result along this path...
>=20
> regards,
>=20
> 	Chris
>=20

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJLch1JAAoJEBKw7u43QNpfpfoQAMJy54puM+pi6kTl6J/Hboa3
L1bXJsQtfP7sSPOm5FZrIy4rHaUIUi/czFHWkHR0ba19hkbXbSDIJ0G8wFSA6vYu
v4VZF2GGV5PSDc9RE0uogEfhrc0hHGyRRdIFjXAI+vPbao6Su+MISXHUQytVLoaY
JfFYalW3+bVaqMktWOaYrRPSOpIADwBJc8lx3FAQLtSVRCuE21HX3sjKgbT8cH/S
dZLJwDIc3ougt76gpm5o3xWKvrdQ7kIUkuRt0Nl8CJJvm/oCjCe3talIUc7ADxjn
Xrr92J8pxrglYHW70YRnspgAzBEo+Fca6K+SfSwCq2synhKbHvl9RQ2xvVvlstcw
U0FGufbdbX79A9qSNRbD7UjrbZkDfiX6kBotcQXRZjBZLJwCmA0U6hvXDchm381/
zf+v36fPAIME8gMJE6GJnla/BY0OT1FOZmpvHgF1BCWCmNzVdOwrr0zRLR4wMZ+7
jb2qAdSYReuxIk3tCEeDJFOFb6R27Qi6Mh/7jxabXqVWlJTVNM6ypOL8XSF9vWob
DU9Txq+edsd4HrZQpXqecWaylyfUs8AJgbHYbxprSBN2rHbv65J47F4iXQlhFMBn
IVZk8gpKy+M8qWgljZfI+y1TdZ0bO9w45lppd+XXEVGAlDgjN0AqpN5iWYVmnFcO
AyE170amRcKpbyXUjma+
=IX9I
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
