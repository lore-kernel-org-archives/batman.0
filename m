Return-Path: <ordex@autistici.org>
Date: Wed, 14 Aug 2013 12:33:06 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130814103306.GO849@ritirata.org>
References: <5209814D.3020506@wirelesspt.net> <520984DC.7040401@altermundi.net>
 <520AEFEF.8050403@wirelesspt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2EnvhqpWJq810sZn"
Content-Disposition: inline
In-Reply-To: <520AEFEF.8050403@wirelesspt.net>
Subject: Re: [B.A.T.M.A.N.] [OpenWrt-Devel] Kernel panic & Process batadv.sh
 - Fatal
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
To: cmsv@wirelesspt.net, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: OpenWrt Development List <openwrt-devel@lists.openwrt.org>


--2EnvhqpWJq810sZn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2013 at 10:48:15PM -0400, cmsv wrote:
> The problem has now been solved with the needed patch that was
> backported to AA. It is now available in r37768 and the images with
> batman-adv are not affected by this problem.
>=20
> Patch is at: target/linux/generic/patches-3.3/721-phy_packets.patch

Just to clarify: this patch existed before and the backported fix is
"changing the patch" to avoid the crash :-)

Thanks for raising the issue!

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--2EnvhqpWJq810sZn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSC1ziAAoJEADl0hg6qKeOo9EP/jTfQNR27Pp2k9TWX8cL6MWS
zLou+vaQbvvHSOF+e3K+UCI1QZyxuRTiP3rQozljDJjn6XB1aqb4eCO+e39V9d0w
nYSVr591bsUo0jgCD6fkzj/RGiLg5tvfZsLjPAVuChwyhfSZhgCrmyrlmF3xyISL
qtlTRFUkdAQneQM1JSxhxDHbIXK874YtfGL9wRhsh1dSlBRyVA/yzgcZOh+C6ILF
sPYYXrHMG9oe6kPGsmLIvWPiUp2qxpqZDPqndoszjdkV/OvlaO+syrq6u3syS4zU
CxZQY5xq8pAsw8ox1KFpDbkMvzdOn7qylVtA5THpXo1yJAyMIjNLbGun0LF08Ewj
IG5tcCsjesvEuIoAWSfsfJkArbGXvfE88Xm6yEKBtpOY1zupoP3VwYt/uqXdlyLq
5G3SN9LVxddvsjT8LB2udaCIpnzJ9IZY+1vWe1VH9NcBgM8YwWjgVUwhz25Dug8q
PiLL0SAGSJ9KUFCvKnh2LCbyCyOOBiDdUcrCCdbhvbuvWWIh/wdjBO+7lbDxbvgR
qvlm62wYQ3ica8GWJIdxzAcInK8hsoVU7k2f9hihQ7T8JmsdRPxoJlGTFO+wmmpe
5ReR86LFCU9jJKGLQ9qhAPx7B7VT+za6VIJxRuA+VLghJ6ejm60xkjNyy3JkPXrl
2L6HEqlFr6bZvXwk/elk
=Ru92
-----END PGP SIGNATURE-----

--2EnvhqpWJq810sZn--
