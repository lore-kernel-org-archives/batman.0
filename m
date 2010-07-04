Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sun, 4 Jul 2010 23:57:41 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20100704215741.GA28501@pandem0nium>
References: <20100630205846.230b2112@rechenknecht>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <20100630205846.230b2112@rechenknecht>
Subject: Re: [B.A.T.M.A.N.] batman adv unicast fragmentation
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


--huq684BweRXVnRxX
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Andreas,

thank you very much for your patch. I've tested the patchset in my KVM setu=
p.
The fragmentation seems to work fine over one or multiple hops if i use the
same MTUs on all hosts, but some corner cases might not bet handled yet.=20

For example:

Host 1 has one interface with MTU 1500 to host 2.
Host 2 has two interfaces, one with MTU 1500 (to host 1) and one interface
with MTU 1470 (to host 3), which might be a VPN connection.
Host 3 has one interface with MTU 1470 to host 2.

Now i can send packets with size 1470 or 1440 from host 1 to host 3 without=
=20
problems, but packets with size 1450 fail. The reason for this might be tha=
t=20
host 1 sends the packet as is without fragmentation, but host 2 can not=20
forward it because the MTU (1470) is too low, but does not fragment it.=20
The packets therefore get dropped.=20
(note: when i say packets of size xxxx i do: ping -M do -s xxxx)

I've also tried to do a similar setup with MTUs 1530 and 1500 instead
of 1500 and 1470, which should simulate a wifi network connected to a=20
fast ethernet network, but unfortunately my KVM crashed with high MTUs,
so i could not verify this setup yet.

However, i think that scenarios like these, a high MTU medium connected
to a low MTU medium are quite common. Linus has interconnected WiFi
networks with VPN, and i've also used some WiFi network interconnected
with fast Ethernet. If forwarding hosts could fragment packets on their
own, this problem could be solved, right? What do you (or others) think?

Just as a minor comment, the copyright year in your new files should just
be 2010, not 2007 - 2010.

best regards,
	Simon

On Wed, Jun 30, 2010 at 08:58:46PM +0200, Andreas Langer wrote:
> Hi,
>=20
> things that changed since the last patch:
> - with fragmentation enabled the mtu of batX is always ETH_DATA_LEN
> - fragment if mtu of the outgoing interface is smaller the needed size
> - add a new packet type for fragmentation
> - new recv function for fragmented packets
> - new route unicast packet function to share routing code
> - increase compat number to 12
>=20
>=20
> regards,
> andreas
>=20

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkwxA9UACgkQrzg/fFk7axbZagCgupP6/b6fQU1H00oAKxNBg9mh
Kq4AoOIT2lAQP7Hx/diIyG2kU+MHhzRM
=CKb/
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
