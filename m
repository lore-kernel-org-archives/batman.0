Date: Tue, 3 Mar 2009 14:34:21 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20090303133421.GA17960@pandem0nium>
References: <278AF6CA06F13D4C9E9F69C7B9AB3B8302E8D236@MBX21.stu.nus.edu.sg>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <278AF6CA06F13D4C9E9F69C7B9AB3B8302E8D236@MBX21.stu.nus.edu.sg>
Subject: Re: [B.A.T.M.A.N.] Running Batman
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Kartik,

are you sure that ath0 is not already created before you run the
"wlanconfig ath0 create ..." command? If so, you should first destroy
it with:

$ wlanconfig ath0 destroy

You should be able to ping between the devices if they are in range,
even if batman is not running. I suggest you test this first, i.e.
running all the commands below, without starting batman.

best regards
	Simon

On Tue, Mar 03, 2009 at 11:16:03AM +0800, Kartik Muralidharan wrote:
> Hi All,
>=20
> I was able to compile/link batman statically and configure using the
> instructions given by Sven
>=20
> =20
> LDFLAGS=3D"-s -static" /usr/bin/make
> =20
> You can check it with `file batmand`. It should print something like
> batmand: ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV),
> statically=20
> linked, for GNU/Linux 2.6.8, stripped
>=20
> =20
>=20
> =20
>=20
> $ wlanconfig ath0 create wlandev wifi0 wlanmode adhoc
>=20
> $ iwconfig ath0 essid testnet
>=20
> $ iwconfig ath0 ap 02:00:de:ad:be:ef
>=20
> $ iwconfig ath0 channel 10
>=20
> $ ip addr add $IP brd $BRDCAST dev ath0
>=20
> $ ip link set ath0 up
>=20
> =20
>=20
> =20
>=20
> On running the command wlanconfig ath0 create wlandev wifi0 wlanmode
> adhoc I get the following output
>=20
> =20
>=20
> ath0: unable to register device
>=20
> ath0
>=20
> =20
>=20
> I currently have 2 devices and use the following IP address
> configuration
>=20
> =20
>=20
> IP :192.168.1.10 & 192.168.1.11
>=20
> BRDCAST: 192.168.1.255
>=20
> =20
>=20
> Finally I run ./batmand ath0
>=20
> =20
>=20
> This echos :Using interface ath0 with address IP and broadcast address
> BDCAST
>=20
> =20
>=20
> To test I tried pinging one device from the other, but it doesn't seem
> to work.  Have I missed out something or is my configuration just wrong.
> Also whats the best way to test if the configuration and devices are
> running correctly.
>=20
> =20
>=20
> Thanks
>=20
> Kartik
>=20
> =20
>=20
> =20
>=20
> =20
>=20
> =20
>=20

> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n


--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmtMd0ACgkQrzg/fFk7axZa3ACeKegg6I1OuyBoL0ba7xdh7+m7
Yr0AnR3BohXfOpJ1pwRGFueWTMkWW4tr
=ownH
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
