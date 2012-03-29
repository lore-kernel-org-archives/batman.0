Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Thu, 29 Mar 2012 14:51:26 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20120329125126.GA22422@pandem0nium>
References: <CAHD-aqKv+7SDGC-07Or+xOZKiJATPmOy876SnDawJp_Zs0GZvg@mail.gmail.com>
	<201203261747.17373.lindner_marek@yahoo.de>
	<CAHD-aqLmGQwzK1u8vmgEwpbNTPMZuonJikjkT=uaOkcPedFptg@mail.gmail.com>
	<CAHD-aqLs8kr5Bwk4-5gBuNepQUmX78yeAHRxRjSLQJw10=fkyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <CAHD-aqLs8kr5Bwk4-5gBuNepQUmX78yeAHRxRjSLQJw10=fkyA@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] BW degradation on p2p links?
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


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Guido,

the problem using one radio is explained further here (from another
company, but this applies to any WiFi mesh technology)

http://revolutionwifi.blogspot.com/2012/02/mesh-network-performance-impact.=
html

Also, if you use two-radio nodes, make sure that you use one module
on 2.4 GHz and one 5 GHz - if you use two modules in the same=20
frequency band with omni antennas, even if you use separate channels
(like 1 and 11), they may interfere with each other if the antennas
are near to each other. There are quite a few ppl who can confirm this,
e.g. check this:

https://hackerspace.be/Wbm2009v2/TestInterferenceResults

Possible Solutions:
 * use different bands
 * use directional or sector antennas
 * have a reasonable distance between your omni antennas

Cheers,
	Simon

On Wed, Mar 28, 2012 at 07:41:05PM -0300, Guido Iribarren wrote:
> (this time i'll keep the mail short, insane details are attached as text =
:) )
>=20
> Well, luckily for batman-adv devs, but unfortunately for me, the
> problem is in fact related to relaying between wlan interfaces in
> mr3x20 hardware (at least)
>=20
> I understand this is not anymore batman related, but maybe someone has
> experience on this, or can point me into the right direction /
> maillist ?
> Given you have a good deal of equipments at the BattleMesh, maybe
> someone has already tried adding a wifi dongle and can confirm seeing
> this behaviour?
> (in a line of 2-radio nodes with static routing, packet throughput is
> halved on each hop)
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D
>=20
> I've repeated the iperf tests in a controlled environment, this time
> using different subnets on each interface and static routes built with
> "route add". iptables flushed with -F and policy -P FORWARD ACCEPT
> no batman at all.
>=20
> Packets coming in through wlan1 and out through wlan0 (or viceversa)
> experience (unexpected) "bandwidth degradation". Throughput drops from
> 30mbps to 15mbps (rough avg)
> The speed is closely comparable to using only 1 radio (packet comes in
> through wlan0, goes out through wlan0), so adding the dongle makes no
> net difference. (besides alternating the channel for transmission,
> throughput is halved over one hop anyway)
> 2 consecutive hops, alternating wifi radios, yield 1/3 throughput.
> (like it happens in a 1-radio mesh)
>=20
> this does not happen if the packet comes in through eth0 and goes out
> through wlanX (or viceversa) . Throughput is maintained high at
> 30mbps.
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> So the hardware (or kernel??) is uncapable of keeping up with the
> transfer speed *when two radios are involved*.
>=20
> Has anyone bumped into a similar case, or has experience with these
> equipments? Maybe (again!) i am doing something wrong?
>=20
> If this is confirmed, my only alternative to maintain good throughput
> along the mesh will be to install 2 x mr3220 on each node, connected
> back-to-back with ethernet cable. This will definitely work but the
> cost for each node owner evidently rises ;(
>=20
> Thanks a lot!
>=20
> Guido



--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk90Ws4ACgkQrzg/fFk7axbWggCg0XdKuBa8cCS47fQGm/XvpQse
cYkAoKFupxFLshD/nH0DGGqrqHFjm6yH
=ccSk
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
