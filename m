Return-Path: <christof.schulze@gmx.net>
From: Christof Schulze <christof.schulze@gmx.net>
Date: Wed, 02 Jul 2014 19:25:59 +0200
Message-ID: <2115088.IOMlxmsL1n@lappi>
In-Reply-To: <20140701112142.3c8ab7cd16f81b51da706026@gmx.net>
References: <1543341.WcWe2c7VXj@lappi>
 <20140701112142.3c8ab7cd16f81b51da706026@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1637633.c0v29X6icj";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Fwd: Re:  increasing BATADV_FRAG_MAX_FRAGMENTS
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
To: elektra <onelektra@gmx.net>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--nextPart1637633.c0v29X6icj
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Hi=20

> > During an experiment it was found, that
> > BATADV_FRAG_MAX_FRAGMENTS=3D16 allows ~72 clients to be connected t=
o
> > one single access point.

> > would you mind sharing some details regarding the experiments you
> > performed ?  The reason for this question is that there is no 72
> > client limit we know of (unless fragmentation was disabled).

> you are very likely looking in the wrong direction. The number of
> clients allowed to connect to an AP is configurable and 72 is
> already way beyond what I would consider useful in real life =E2=80=93=
 if
> your clients are actually supposed to be able to communicate unicast
> traffic.

> Since you are probably using OpenWRT for your tests, look at the
> configuration parameter maxassoc:
> http://wiki.openwrt.org/doc/uci/wireless

> I don't know the default that OpenWRT uses if you don't set it
> explicitly.  But there is a default limit set somewhere (take a look
> at hostapd.conf) and you might have discovered that by pushing it to
> the limit. It might as well be the limitation of your WiFi driver /
> hardware, though.
Thank you for your response.

maybe it is indeed a little far-fetched to point at batman at first.
On the other hand - the investigation has to start somewhere.

From=20your feedback and from feedback on IRC I gathered the following
list of possible issues and things to look at:
* there might be an issue with not enough multicast-traffic being
  allowed - hypothesis: The client could associate with the AP but
  no IP was received.=20
* the bandwidth of the air (airtime) might be saturated.=20
* There might be a driver issue

If it is known that no more than 70 clients per device is sensible,
then we have to consider actually setting some limits and using
maxassoc.

Christof


=2D-=20
()  ascii ribbon campaign - against html e-mail
/\  against proprietary attachments

--nextPart1637633.c0v29X6icj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEABECAAYFAlO0QKsACgkQpZfyPAmdZJmIlACg+T0xab9riuatGSFN5ohWZvg9
AAkAoKuzFSFDhl0yDCPiYaNnP7WYqfPp
=xJoO
-----END PGP SIGNATURE-----

--nextPart1637633.c0v29X6icj--

