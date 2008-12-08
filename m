From: Sven Eckelmann <sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Looking for batman-adv 0.1-alpha
Date: Mon, 8 Dec 2008 19:22:25 +0100
References: <4938F21D.2050907@irt.de> <20081205200414.GB27271@pandem0nium>
	<493CDAD8.10400@irt.de>
In-Reply-To: <493CDAD8.10400@irt.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2951874.Z4iq6vOQkB";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200812081922.29181.sven.eckelmann@gmx.de>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

--nextPart2951874.Z4iq6vOQkB
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 08 December 2008 09:29:12 Tobias Gieseke wrote:
> Sorry, but my question to open-wrt was not precise enough. I wanted to
> know if there is a chance to get batmand-adv running on open-wrt with
> broadcom wifi. AFAIK batmand-adv is only running on kernel 2.6 but with
> kernel 2.6 broadcom wifi is not running on open-wrt (according to the
> open-wrt homepage).  Maybe you know a trick to get batmand-adv running
> on the Linksys WRT54GL or the Buffalo WHR-HP-G54 WiFi-Router, with WiFi
> running of course.
It is correct that kamikaze 7.x doesn't support linux 2.6 with stable wifi =
but=20
the new kamikaze 8.09rc1 [1] uses the b43 driver[2] and should support the=
=20
integrated bcm43xx hardware inside the wgt54gl + adhoc mode. You should be=
=20
able to run batman-adv on these devices.
The hardware I have here is currently in productive use - so I cannot test=
=20
that it really works.

Best regards,
	Sven

[1] http://downloads.openwrt.org/kamikaze/8.09_RC1/release.txt
[2] http://linuxwireless.org/en/users/Drivers/b43

--nextPart2951874.Z4iq6vOQkB
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkk9ZeEACgkQqQGwKVlMoDsR0wCfbWJrGQgi5PfILZlZBYsmL8zW
ypEAnAxZKutVJ9n+SNIAtprUynNVLcGD
=LaJs
-----END PGP SIGNATURE-----

--nextPart2951874.Z4iq6vOQkB--
