Return-Path: <ilario.gelmetti@sns.it>
Message-ID: <53A43E1A.1060800@sns.it>
Date: Fri, 20 Jun 2014 15:58:50 +0200
From: Ilario Gelmetti <ilario.gelmetti@sns.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="k8eDc496uUoMVpjcl985RDvDlv4umKUan"
Subject: [B.A.T.M.A.N.] Bridge changing source mac address prevents
	batman-adv from connecting
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
To: b.a.t.m.a.n@lists.open-mesh.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--k8eDc496uUoMVpjcl985RDvDlv4umKUan
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi all!
I'm using batman-adv (2014.2.0) on two devices running OpenWrt
(LibreMesh) connected using a third device running a proprietary
firmware in bridge mode (AirOS), this is the topology:
http://i.imgur.com/ELMi5RC.png

mac3E80 OpenWrt batman----cable----macE3E7 AirOS station----wireless--
--macE434 AP OpenWrt batman

using tcpdump on the OpenWrt devices I can see batman packets flowing:
on mac3E80 I can see:
http://sprunge.us/iePM
while on macE434 I can see:
http://sprunge.us/DIAX
as you can see the problem is that macE434 sees packets from mac3E80
*approaching with the wrong mac address*, the mac address of macE3E7 so
I think it discards the packages when source mac address is different
from mac address specified inside the packet.
Is this only a security check?
How could I get things work?
Thanks,
Ilario


--=20
Ilario Gelmetti
iochesonome@gmail.com
ilario.gelmetti@sns.it


--k8eDc496uUoMVpjcl985RDvDlv4umKUan
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlOkPhoACgkQifrzB0y7qpbC/QCgmfLp30VIt7sa8AWIhO54teS7
Cr8AoIjl0IZ9GfBxXZR3s34+RLQa/6Uf
=oy1e
-----END PGP SIGNATURE-----

--k8eDc496uUoMVpjcl985RDvDlv4umKUan--
