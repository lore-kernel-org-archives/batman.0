Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 22 Jul 2016 17:00:35 +0800
Message-ID: <4665505.ycKxL6emWq@voltaire>
In-Reply-To: <1468836728-21890-4-git-send-email-sven@narfation.org>
References: <6098496.c9QsHxvAun@sven-edge>
 <1468836728-21890-4-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2127610.l5vASG3NdM";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v11 04/11] batctl: Use netlink to replace
	some of debugfs
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

--nextPart2127610.l5vASG3NdM
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, July 18, 2016 12:12:01 Sven Eckelmann wrote:
> From: Andrew Lunn <andrew@lunn.ch>
> 
> The kernel has gained support for exporting some information via
> netlink.  Use this when available, rather than debugfs.
> 
> If netlink is not available, or the information is not yet available
> via netlink, batctl will fall back to debugfs.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> [sven@narfation.org: Add missing local TTVN in transtable_global, add
> missing local group id to claim table, fix use-after-free of algo_name, fix
> alignment of the originator entries]
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> [sw@simonwunderlich.de: fix claimtable output format, fix name of mandatory
> claim table attributes, fix printing of VIDs]
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> ---
>  debug.c     |   22 +-
>  debug.h     |    4 +-
>  functions.c |   11 +
>  functions.h |    2 +
>  netlink.c   | 1069
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> netlink.h   |   18 +-
>  6 files changed, 1121 insertions(+), 5 deletions(-)

Applied in revision d8dd1ff.

Thanks,
Marek

--nextPart2127610.l5vASG3NdM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXkeCzAAoJEFNVTo/uthzAUxYH/1VsIqu4QW6rQkiKnp6YWmjD
Ch5e3dzk+hmN5D+jZtS0KnOyIuYLBzsRqcXX8PxRMYhHISMtPa5nkZG/H0cUkC90
bXOnPBbjJBMiQL8IJdWwNLxtpeZHTTypVqBC/nV0DqxTkqxCqxG2i6rEJFS8/vPh
junGbB0fSzFJsYOWfr/S8In9xdUnElnduJjc99vGCyjlFMOuBGxA1PbmKuEsiPI0
xZJBW0xZld7UNp3Y38BOfb4H+FOEVs4xev0dcTy7LiQcD4wbK9KY8gH09QATjTH3
PdBytkVNLMlvYD8BK5eZ59ao1IPmGngaI+M6lieS6340DM+YSxKV8sSjLyMUUco=
=mrws
-----END PGP SIGNATURE-----

--nextPart2127610.l5vASG3NdM--

