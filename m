Return-Path: <clemens-john@gmx.de>
From: Clemens John <clemens-john@gmx.de>
Date: Fri, 28 Jan 2011 23:46:11 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5250009.33KLOnpqhp";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201101282346.16035.clemens-john@gmx.de>
Subject: [B.A.T.M.A.N.] Connecting through Batman advanced interface
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

--nextPart5250009.33KLOnpqhp
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I have a special question on confgurating our batman advanced setup.
We have a Tinc VPN on tap0, and behind this VPN is a dhcp server and an=20
internet gateway which is reachable trough the ip 10.18.0.1.
On the router I have ath1, an adhoc wlan device, on which batman advanced i=
s=20
sending packagets. Now bat0 and tap0 are brindged to br-mesh. Like you can =
see=20
in the configuration:

root@Floh:~# cat /etc/config/network=20
[...]
config 'interface' 'mesh'
        option 'type' 'bridge'
        option 'ifname' 'bat0 tap0'
        option 'stp'    '1'
[...]

root@Floh:~# cat /etc/config/batman-adv=20
config 'mesh' 'bat0'
        option 'interfaces' 'ath1'
        option 'orig_interval'
        option 'log_level'

                  [batman]     =20
[client]-->[adhoc ath1]-->[bat0][br-mesh][tap0]-->internet-->[gateway/dhcp]

Other nodes running the same configuration but not connecting trought vpn c=
an=20
connect to the dhcp server through batman advanced and the adhoc device.

If a client (laptop) without batman advanced tries to connect, it has no=20
success because it does not get an I address.

What can I do?
I can not open a second wifi device in ap mode and add it to mesh. I know t=
hat=20
this would be the best way but I=B4m trying this on an wrt54g and the b43 d=
river=20
does not support multi essid.

Regards
Clemens

--nextPart5250009.33KLOnpqhp
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk1DRzMACgkQZgdHbA22lqON1ACeNxa+RdUnl2lrXoDSSeTc1d5N
yKEAoK9WejHCbZppqU+ZTPxSSfkfzoKu
=DISp
-----END PGP SIGNATURE-----

--nextPart5250009.33KLOnpqhp--
