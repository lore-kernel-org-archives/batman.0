Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 12 May 2016 23:21:14 +0800
Message-ID: <2545852.G7PSWjTTnL@voltaire>
In-Reply-To: <1462898487-9696-4-git-send-email-linus.luessing@c0d3.blue>
References: <1462898487-9696-1-git-send-email-linus.luessing@c0d3.blue>
 <1462898487-9696-4-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3659055.TkJ3ovunJZ";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv15 3/4] batman-adv: Adding logging of
	mcast flag changes
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

--nextPart3659055.TkJ3ovunJZ
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Tuesday, May 10, 2016 18:41:26 Linus L=FCssing wrote:
> With this patch changes relevant to a node's own multicast flags are
> printed to the 'mcast' log level.
>=20
> Tested-by: Simon Wunderlich <sw@simonwunderlich.de>
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> ---
>  net/batman-adv/main.h           |    4 +-
>  net/batman-adv/multicast.c      |  133
> ++++++++++++++++++++++++++++++++++++++- net/batman-adv/soft-interface=
.c
> |    4 ++
>  net/batman-adv/types.h          |    4 ++
>  4 files changed, 142 insertions(+), 3 deletions(-)

Applied in revision ffdce4f.

Thanks,
Marek

--nextPart3659055.TkJ3ovunJZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXNJ9qAAoJEFNVTo/uthzAsYYH/0n2L11Kyg+C2ag2TFEzbimE
wGiBRfonta2RKonYlHPrTt7650r+7fUWhpHVuarqJ313c26NyMci7X4oUKOctz9O
+xQCYsZHMSra9lf+70Hb6dU8zrPRa55NIYM7KlEK6M97r1EnAtecleohcgS5XMNF
WyPPkQoYI3y8Y9S7/aUKyCv1nXEtLrsz5gJYdpqsuAYEf0/kJVHynvP8F5FAVhqb
q+OefeF1wsgPOjZpwE1rO2gAlxQtfP5PSUeH7Fdgyts44u26UhqVCI8tqXJdHQ26
I2/YeBKezuvAOc9BVYU7PGIATB9VY9ucACVs0fa3heAOVpl2mziqsbHCVUNsCx8=
=5Wjf
-----END PGP SIGNATURE-----

--nextPart3659055.TkJ3ovunJZ--

