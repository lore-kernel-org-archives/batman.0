Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 10 Jun 2015 12:56:13 +0800
Message-ID: <2113790.7bCQ4UhSCp@voltaire>
In-Reply-To: <1433875849-32519-1-git-send-email-sven@narfation.org>
References: <1433875849-32519-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart10187017.TsUZvSN5p9";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2] batman-adv: Remove multiple
	assignment per line
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


--nextPart10187017.TsUZvSN5p9
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, June 09, 2015 20:50:49 Sven Eckelmann wrote:
> The Linux CodingStyle disallows multiple assignments in a single line.
> (see chapter 1)
> 
> Reported-by: Markus Pargmann <mpa@pengutronix.de>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v2: Rebased on top of current master
> 
>  net/batman-adv/bat_iv_ogm.c            |  6 ++++--
>  net/batman-adv/bridge_loop_avoidance.c |  6 ++++--
>  net/batman-adv/distributed-arp-table.c |  3 ++-
>  net/batman-adv/gateway_client.c        | 12 ++++++++----
>  net/batman-adv/gateway_common.c        |  5 ++++-
>  net/batman-adv/network-coding.c        |  3 ++-
>  net/batman-adv/translation-table.c     | 18 +++++++++++++-----
>  7 files changed, 37 insertions(+), 16 deletions(-)

Applied in revision c71c622.

Thanks,
Marek

--nextPart10187017.TsUZvSN5p9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVd8NtAAoJEFNVTo/uthzAjsIH/3YUKPNO6Ff/PWxVNWpeiWzk
dPI5f8j9Z9NoiIoUzs6EP5odXXfGo0Bg09APakV5VCutDhkJJ5+c8jKkQlEN/B1O
NmyQD6OOgxHRa1ZMYbC0b/Bi0iFKz3UBTzyT9FMzQBotX86EBNAfV8MGtGgGF1XN
XBxMdd9PB5xGI3eK8dZ9cbYt1d/B+G/7yLtwoFSfK+hCy61Mqm/nyMWbSbmHO1kT
64poSElSfX33hoPf5i2f5GTiei0uJrH8nRvcAbRsYNO9PsdZGzht+ixdQTZ/2vHo
P9YLnS413eODQ/1WlDxgL8TVX09TUwQS8KxcOb/VkRZOnb+03GqNsC4Brj7rYI8=
=6M42
-----END PGP SIGNATURE-----

--nextPart10187017.TsUZvSN5p9--

