Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 23 Feb 2011 11:20:03 +0100
References: <4D64BAFF.9050006@Radtke.eu>
In-Reply-To: <4D64BAFF.9050006@Radtke.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1686148.yqDU5WI1l1";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201102231120.08664.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] Problem after configuring a bridge
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
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart1686148.yqDU5WI1l1
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Wednesday 23 February 2011 08:45:03 Dr. Stefan Radtke wrote:
> Hello *,
>=20
> I set up batman-adv-2010  on OpenWRT (backfire 10.3.x). Mesh interface
> is wlan0 and another non-batman-LAN is connected to eth0. non-batman
> clients should connect via the eth0 interface. (Full description and
> network diagram here:
> https://forum.openwrt.org/viewtopic.php?pid=3D129226#p129226 ).

entX =3D=3D ethX? You should set the mtu of wlan0 to 1530 and all other mtu=
s (br0,=20
bat0, eth0, ...) to 1500. I would also recommend to update to batman-adv=20
v2011.0.0. None of the mentioned should fix you problem, but are recommende=
d=20
to fix other glitches.

You don't tell us what sending means in you initial description - which=20
card/node wants to sent to which other card/node. What he wants to send? Wh=
at=20
did your sensors (tcpdump, batctl td, ...) tell you how far those packets=20
travel through the mesh/lan? I would recommend to test the functionality of=
=20
layer two with a layer two protocol - or test application. A good idea is t=
o=20
use raw l2 sockets to send some packets from A to B and check if it arrives=
=20
[1].

> After setting up batman-adv 2010.x with
>=20
> batctl if add wlan0
> ifconfig wlan 0 0.0.0.0
> ifconfig bat0 192.168.10.2    (previous ip address of wlan0)
> ifconfig bat0 up
>=20
> I have to configure a bridge  (according to quick start guide
> http://www.open-mesh.org/wiki/batman-adv-quick-start-guide) because I
> want batman-adv to announce MAC-addresses connected to eth0 (see network
> diagram):
>=20
> brctl addbr mesh-bridge
> brctl addif mesh-bridge eth0
> brctl addif mesh-bridge bat0
> ifconfig eth0 up
> ifconfig bat0 up
> ifconfig mesh-bridge up

As Floh1111 already said, this IP setup cannot work. Here a little bit more=
=20
information about that:

You set an ip to bat0 and then add the bat0 to br0 - this cannot work. The=
=20
bridge will prevent packets from being received through bat0. All packets o=
f=20
attached interfaces will be received through br0. The tcp/ip stack will sim=
ply=20
drop the packet when the bridge isn't configured to receive for that ip. Th=
is=20
behavior can be changed slightly using ebtables broute - but I would strong=
ly=20
recommend not to mess with that stuff.

Best way is to either setup IP routing or use IPs only on br0 (and br0:0 fo=
r=20
the second IP). You should also check your routing table for invalid entrie=
s=20
after you replaced the IPs.=20

> Although the translation tables (global and local) seem fine in this
> moment, at the same momentof bringing up the bridge I cannot send any more
> packets through bat0 or ent0. Both don't even reply to a ping.
>=20
> Network setup and outputs of ifconfig
> onhttp://www.open-mesh.org/wiki/batman-adv-quick-start-guide
>=20
> Any hint is appreciated.

Please first try to bisect your setup on layer 2 for clients which have a=20
direct link (switched or switched over mesh, but not routed). Use tcpdump a=
nd=20
"batctl td" to detect where packets may get dropped. In case no problem was=
=20
found, please continue to do the same on l3. But keep in mind that eth0/bat=
0=20
will not received packets for the host directly - br0 is the interface you=
=20
want to use.

What exactly are you trying to achieve using the IP in the wrong physical=20
subnet thing? There are better tunneling protocols for that purpose and you=
=20
don't need use some weird bridging-routing-in-parallel-something-monster.

Best regards,
	Sven

[1] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2010-January/002234.h=
tml

--nextPart1686148.yqDU5WI1l1
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJNZN9VAAoJEF2HCgfBJntG2nkQANiol3D73aazToMtdQYZ+cIz
dNtUosH5mo5aL+fym83uwWnqHOMZVgqgxozdoGXnRT3wqWUH6D7e3o3O+bAAogAo
wMEuecMftP+yG76d6PtayxGoslEFe1LsXQhB0Zc+I08Oh2kwiqFnxNp3k25jYrEF
3AB+wFRrD5jx3Hyoh4IQleMcZ1kEwKDXKFQo1d3meaRqYPLOiGnBnvgqHHXL2Djs
n8J86m0cqvDuUzMqiIl3em0El9n89ZROBbsVBlxjM6AyfOVgHjIRW2PWUnCzN2UP
kfj0qqZ06y9bI8fWDHGhV6VX02hX8ruKyyhtC69KjVzcMk9EBhDmRV3IAOZbX/Vd
XWHJvLvptxzPQ0YV92MMlmPOYvMMJ9fc0KYLwKXRILfwj/omoOKDFqRwSGXt2lvh
6HNyq6MpX+A7Fr+byzhrb6f3F5kJ8ve66hS96vAyCYQXaSYclOVExGaHkcjykGa/
3BN9tskKqevIGEq+3AiFeldX33rXHUftBuGhZ2St8kkKvxJbU4PRG1Q3ohzT+dtb
a1OZ2ytcJh5oR9AzUGy3UHqtyOMZM824RGPkvdPI7nFkVTvyLwCLT/9YPp5WxkSn
c8XVQoF1uVwzj3/LwhByyThh3ROPDIZvFhAPGtJ6zmz0469O7TKAcY3AHIWCyk6w
l71Vy++Sx6RRODK6rs7T
=XdKm
-----END PGP SIGNATURE-----

--nextPart1686148.yqDU5WI1l1--
