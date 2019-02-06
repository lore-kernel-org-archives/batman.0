Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 06 Feb 2019 19:14:16 +0100
Message-ID: <2382079.7bZRkTAdJY@sven-edge>
In-Reply-To: <015501d4be3c$d64ad290$82e077b0$@telegrid.com>
References: <015501d4be3c$d64ad290$82e077b0$@telegrid.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4156024.L26xFV0dVp";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Alfred problem reading other nodes
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
Cc: beth.flippo@telegrid.com, s.pinsky@telegrid.com

--nextPart4156024.L26xFV0dVp
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Wednesday, 6 February 2019 17.56.00 CET beth.flippo@telegrid.com wrote:
[...]
> I am having a problem getting alfred retrieve info from other nodes.  I am
> running openwrt and alfred 2018.0.

Which OpenWrt version should that be? There is no release with 2018.0 and t=
he=20
current version in master is also newer.

> I am able to start the alfred server with no errors both from boot and the
> command line.=20
>=20
> root@OpenWrt:~# /etc/init.d/alfred restart
> /etc/init.d/alfred: waiting 30 secs for br-lan address...
> /etc/init.d/alfred: starting alfred
> /etc/init.d/alfred: starting batadv-vis
>=20
> I can see it with ps
>=20
> 4290 root       816 S    /usr/sbin/alfred -i br-lan -m -b bat0
>=20
> I can issue a set and then a receive and I see the value I set but only
> locally.  It does not get any info from the other nodes in my network.  T=
hey
> are all running alfred servers as master.

Have you checked whether process_alfred_announce_master (recv.c) rejects th=
e=20
incoming packet for some reason and thus doesn't add it to the server list?

If not, have you checked whether sync_data (send.c) really sends out the da=
ta=20
via push_data to the remote server?

> I have added a firewall rule to open the port.
>=20
> If I have 2 nodes running alfred and I run =91tcpdump -i br-lan udp port
> 16962=92 - I see packets from the other node:
>=20
> 16:21:49.279086 IP6 fe80::2d0:12ff:fe00:f0c7.16962 > ip6-allnodes.16962:
> UDP, length 4
[...]
> I think these might be the master announcements but when I issue an alfred
> -r # - I do not see any new messages in the tcpdump.

If all daemons are in server mode then they will not create a request via=20
`alfred -r`. Instead, they regularly sync [1] their facts between each othe=
r=20
(same port but different packet type).

Kind regards,
	Sven

[1] https://www.open-mesh.org/projects/alfred/wiki/Alfred_architecture#Sync=
hronization
--nextPart4156024.L26xFV0dVp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlxbI/gACgkQXYcKB8Em
e0bz4RAAoV4mRgwX9Vlg1y42LOrOug4P6AXoNaEZEabI/V7wq9q3RYuLaG4K8sXO
mzb56Zt+PMJJy0CNt85l0hQGy+RNwGuWwgxDJcuqAdE7Rz4FLb0l8JZJN8W+DM9O
hQMk/He8nSt/f4fafwH0kyPe5SewihDha1Ce3R6tXEO0+sksJHl5V5PrOKn1dBo8
C032/xDA4sPwYtJTLltgt1BjNXo1iN59wgj0Ap79ijwG4tEBSp8c2+vH76Ig0cj7
XIIcN3PpJpCWzBfc7mQmSEG+K3IzodyOhMk28NaWL7cgDYKWVvtfog2FsW6yxa/K
BL71+xzF0162J1E6FMQ5vqYPzEuCKPhCRhr0kSQcwISlnYROOvV9OZNgaX+unP91
I2Z9Kbxp/Sq95hOovBty+Fhc0IBce2PVsiRk9/IKsJeIHxkHjQ2e24sbP8WX2+us
ow0Ht6ALOXy5iQteftMVGjOjjY5yvkcL4U7NigGPBqw6V3GAChNr2AuASrTr5gjy
wmMu/hnsrcihuDYG5M0K+yiTClpDY5mE8jw41PAbZLNkj3ZtfxGC9cDFstpdlK04
V1Y/bb6V6qe5qznTxTp1Qv8d3nHvbjfjsXbLc39N8cWEwjLf8XVdoLIk7ZHSzLHS
BaXAuiFWgfuBoGHdNTqhCr6+FHKMJm1H0T9yA+DWiXSJnqmsNnQ=
=HEbT
-----END PGP SIGNATURE-----

--nextPart4156024.L26xFV0dVp--



