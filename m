Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Tue, 15 Dec 2009 21:50:56 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20091215205056.GA9620@pandem0nium>
References: <200912151951.04568.lindner_marek@yahoo.de>
	<14202394.464551260869728978.JavaMail.coremail@bj126app27.126.com>
	<33324075.613801260897227505.JavaMail.coremail@bj126app103.126.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
In-Reply-To: <33324075.613801260897227505.JavaMail.coremail@bj126app103.126.com>
Subject: Re: [B.A.T.M.A.N.] Does batman-adv  support gateway ?
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Wu,

you can set an IP address on the bat0 interface, or include it in a bridge=
=20
with eth0 or other devices which are not used for the mesh. You might as we=
ll
use DHCP to provide addresses to your nodes (which is not possible with lay=
er 3
daemons, btw). You don't need to set IP addresses of the "base interfaces"=
=20
which are used by batman - just make sure they are up (ifconfig wlan0 up).
The bat0 interface can be used like any other ethernet-compatible network
interface - you can consider it as port to a virtual distributed switch.

best regards,
	Simon

On Wed, Dec 16, 2009 at 01:13:47AM +0800, wu xiaofei wrote:
> Thank you for your reply!
> I just used olsrd. I am a newbie for BATMAN. I want to try it.
>=20
> From open-mesh.net and your description I almost know batman-adv is on la=
yer 2 . But some applications need IP addresses,=20
> so use DHCP server to allocate IP address in the same network, or config =
manually?
> Could you give me a guide document about setting and config steps of a me=
sh network  (about 30 nodes) using batman-adv  in detail.=20
>=20
> in "README" :
> # insmod batman-adv.ko
> # echo wlan0 > /proc/net/batman-adv/interfaces
> The module will create a new interface 'bat0'
>=20
> What's the difference between 'wlan0' and 'bat0'?=20
> Should I bridge the non-batman interface (e.g. eth0 ...) with=20
> bat0 or wlan0 ?   config the IP address of wlan0 , bat0 separately ?
>=20
> --
> Wu

> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@lists.open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n


--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAksn9rAACgkQrzg/fFk7axbwhACdH74kRQFzCw8Ub85dUoC5wR6l
yWMAnjY5wumwnHGuvMZwCrQwslwhynQV
=yFQw
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
