Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 30 Jan 2016 12:17:35 +0800
Message-ID: <3030734.l0rD9cqonh@voltaire>
In-Reply-To: <1453312815-20752-1-git-send-email-sven@open-mesh.com>
References: <1453312815-20752-1-git-send-email-sven@open-mesh.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1814428.uAedzGneWt";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2] batman-adv: Add compat code for
	BUILD_BUG_ON_NOT_POWER_OF_2
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
Cc: Sven Eckelmann <sven@open-mesh.com>

--nextPart1814428.uAedzGneWt
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, January 20, 2016 19:00:15 Sven Eckelmann wrote:
> Fixes: 2c2fe0ba9ea5 ("batman-adv: ELP - creating neighbor structures")
> Signed-off-by: Sven Eckelmann <sven@open-mesh.com>
> ---
> v2:
>  - add missing include in average.h which is required to always defined
>    BUILD_BUG_ON_NOT_POWER_OF_2 correctly
> 
>  compat-include/linux/average.h |  2 ++
>  compat-include/linux/bug.h     | 13 +++++++++++++
>  2 files changed, 15 insertions(+)

Applied in revision a23e9a9.

Thanks,
Marek

--nextPart1814428.uAedzGneWt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWrDlfAAoJEFNVTo/uthzALz0IAKDEFmHPsUdc51crHpgYnu1I
bD2GGbMY/w5lycCbjuOl92Zmu2vjPCGMbnoUhYzUX9u2tzddX3gEJDGYU8SBkPlj
5yEWUCAQjkChdEVGrFfy2DikwVoFgwm2jqtd89pEiK4tB9T8OlsE1x5t2eJVlm/Z
3JVQCbS+T3ZgjW5P3w+742VeHAQLmCQZtdsgVmvvWYZV60GaXdvYVZpp23svivLb
XGYMqz2aUqXPtC3mnGzS0fiLz2rxHdW46eZo2YolwUPnjdiob9H89hABTQ03HHt5
ozf3xe8pYjhdRiTjRauRS/plWcdmsx/3zc+McIg0QPqORh/EeisBljYP1ioODdE=
=+FB6
-----END PGP SIGNATURE-----

--nextPart1814428.uAedzGneWt--

