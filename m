Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 12 May 2016 23:19:40 +0800
Message-ID: <7001706.kMMYfbOu1X@voltaire>
In-Reply-To: <1462898487-9696-3-git-send-email-linus.luessing@c0d3.blue>
References: <1462898487-9696-1-git-send-email-linus.luessing@c0d3.blue>
 <1462898487-9696-3-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart22861801.Suuzka3NrZ";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv15 2/4] batman-adv: Add multicast
	optimization support for bridged setups
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

--nextPart22861801.Suuzka3NrZ
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Tuesday, May 10, 2016 18:41:25 Linus L=FCssing wrote:
> With this patch we are finally able to support multicast optimization=
s
> in bridged setups, too. So far, if a bridge was added on top of a
> soft-interface (e.g. bat0) the batman-adv multicast optimizations
> needed to be disabled to avoid packetloss.
>=20
> Current Linux bridge implementations and API can now provide us
> with the so far missing information about interested but "remote"
> multicast receivers behind bridge ports.
>=20
> The Linux bridge performs the detection of remote participants
> interested in multicast packets with its own and mature so
> called IGMP and MLD snooping code and stores that in its
> database. With the new API provided by the bridge batman-adv can
> now simply hook into this database.
>=20
> We then reliably announce the gathered multicast listeners to
> other nodes through the batman-adv translation table.
>=20
> Additionally, the Linux bridge provides us with the information about=

> whether an IGMP/MLD querier exists. If there is none then we need to
> disable multicast optimizations as we cannot learn about multicast
> listeners on external, bridged-in host then.
>=20
> Tested-by: Simon Wunderlich <sw@simonwunderlich.de>
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> ---
>  compat-include/linux/etherdevice.h |    9 ++
>  compat-include/linux/if_bridge.h   |   68 ++++++++++++++
>  net/batman-adv/multicast.c         |  181
> ++++++++++++++++++++++++++++++++----
> net/batman-adv/types.h             |   13 +++
>  4 files changed, 253 insertions(+), 18 deletions(-)
>  create mode 100644 compat-include/linux/if_bridge.h

Applied in revision 391b59c.

Thanks,
Marek

--nextPart22861801.Suuzka3NrZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXNJ8MAAoJEFNVTo/uthzABN4IALJFq23PCIFmi2zr8BxjuRgX
CCPMs5IZR12mE40yWjSVLWCN3B+Mc6rV8TQwD7XHbxwpnql+IpDSgBtWkSNo+zHZ
xIEx7GXGE3LSAoEraUs6/WBJiQlaJQPQlqX0Xf0D4h+/MXrxXxVsze1hsTLlcHqk
sojPWxBFHpSSePfLwH0g1FI9d1EMm0thx7fOVaKF0eVHRdiapIuRa8IfZJUkT4CW
NOmIuQSQSV3noqA1jnfG3CMf72MvmFGR8yolzj0j5f0fofsLev3us13H3Fm+Tzqi
dgUrF37FgLz2zzUMx+Wd2sVTos53L3nDdUrL9pgLhse3o6WG+IG/Go38aYOV3Zo=
=tZxv
-----END PGP SIGNATURE-----

--nextPart22861801.Suuzka3NrZ--

