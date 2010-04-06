Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Tue, 6 Apr 2010 19:58:09 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20100406175809.GA21016@pandem0nium>
References: <20100404220120.GA9171@pandem0nium>
	<20100406093331.GA24150@Sellars>
	<20100406104129.GA19923@pandem0nium>
	<20100406131105.GA28505@Sellars>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <20100406131105.GA28505@Sellars>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Reorganize sequence
	number	handling
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


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,=20

i've verified and can reproduce the problem. The queue limitation patch rem=
oves
the OOM problems, but the same packets are still broadcasted. It is always
the same sequence number which is sent many times - the same packet
should not be sent more than 3 times.

All nodes but the original sender flood the same packets on all interfaces =
=2E..

I'll look into this, thanks.
	Simon

On Tue, Apr 06, 2010 at 03:11:05PM +0200, Linus L=C3=BCssing wrote:
> On Tue, Apr 06, 2010 at 12:41:29PM +0200, Simon Wunderlich wrote:
> > Hi Linus,
> >=20
> > from the time where the messages come (the printk is removed in the sub=
mitted
> > version of the patch BTW), we can see that there is a 30 second period =
between
> > the protection time starts - as it is supposed to be.
> >=20
> > I guess you have stopped your broadcast ping after ~900 seconds, but st=
ill
> > receive packets some time later. Do you have some dumps or any analysis=
 data
> > for this?
> Ehm, no, I stopped after 1-2 seconds :). And well, "some" packets
> after? A is still receiving about 3000-4000 packets per second.
> I made some dumps, you can find them here:
> http://x-realis.dyndns.org/Freifunk/batman-log/mesh1.cap
> http://x-realis.dyndns.org/Freifunk/batman-log/mesh2.cap
> For the virtual machines, I've just been bridging their
> tap-interfaces on the host system, so no vde_switch/wirefilter
> involved. mesh1.cap is the capture from the bridge between A and
> B, mesh2.cap from the bridge between B and C.
> A's mac addr: XX:...:XX:X1
> B's mac addrs: XX:...:XX:X3
> C's mac addr: XX:...:XX:X2
> After some seconds, B and C also seem to relay the same packet all
> the time (in this dump 2702, but is a different seqno every time I
> restart the hole setup).
> >=20
> > I will try to rebuild your setup and turn the broadcast replies on late=
r.
> Ok. As said above, I've just connected the nodes via bridges.
> After all three nodes were connected and running, I did the
> following commands on node A:
> ---
> ifconfig bat0 up
> ifconfig bat0 192.168.123.1/24
> echo 0 > /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts
> ping -b -f 192.168.123.255 > /dev/null
> --> and stopped the ping command after 1 to 2 seconds.

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAku7djEACgkQrzg/fFk7axajogCglhNSkCbTBon0GJCGk+SsYMNJ
rwAAoI0h+io6O6ZpsDUYSyYkTh4RyrgI
=u9cc
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
