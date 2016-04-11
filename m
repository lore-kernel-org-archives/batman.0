Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 12 Apr 2016 00:04:06 +0800
Message-ID: <2831615.2xmdSus33c@voltaire>
In-Reply-To: <1457775018-16546-1-git-send-email-sven@narfation.org>
References: <1457775018-16546-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart52158209.sr77xQc4Tj";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v3] batman-adv: use static string for
	table headers
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
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart52158209.sr77xQc4Tj
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, March 12, 2016 10:30:18 Sven Eckelmann wrote:
> From: Antonio Quartulli <a@unstable.cc>
> 
> Use a static string when showing table headers rather then
> a nonsense parametric one with fixed arguments.
> 
> It is easier to grep and it does not need to be recomputed
> at runtime each time.
> 
> Reported-by: Joe Perches <joe@perches.com>
> Signed-off-by: Antonio Quartulli <a@unstable.cc>
> [sven@narfation.org: fix conflicts with current version]
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v3:
>  - workaround checkpatch error (over 80 chars) caused by __stringify
> v2:
>  - rebased patch
>  - added new static strings in bat_v.c and bat_iv_ogm.c
> 
> Patch was resurrected from https://patchwork.open-mesh.org/patch/3599/
> 
> I've requested an rebased version at
> https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2016-March/014637.html
> but done it myself because it was rather trivial.
> ---
>  net/batman-adv/bat_iv_ogm.c            | 8 +++-----
>  net/batman-adv/bat_v.c                 | 9 ++++-----
>  net/batman-adv/bridge_loop_avoidance.c | 7 +++----
>  net/batman-adv/distributed-arp-table.c | 4 ++--
>  net/batman-adv/translation-table.c     | 9 ++++-----
>  5 files changed, 16 insertions(+), 21 deletions(-)

Applied in revision f7be1df.

Thanks,
Marek

--nextPart52158209.sr77xQc4Tj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXC8r2AAoJEFNVTo/uthzAvY8H/0YnvtmYy6NPWYTQBx0HxEqO
DpSXU4DwFiKK+574R+0SmBuv8KUWNAwjJD6CIGaewkHJa2g4v1gYGKyzRmiNEYBY
JGrCL1oMsoHShQ6be/+z+unIdnFd3R5f1/uVee09YyRnHrGk4Z4WjTfjEcogdWnj
gWfXJT4IJBXQjt8Kxe9yxCFQv9VM2QTLnp7w5hlduw8ASRv8PooAexQUOJo8zEDy
qoML+pLffHseeiETDsE8GFQgEVtaSY0YZZ5K9hQXwTiXel7IlYKN6g64c+spMn1I
G6Ff++pYXIuub/bBr8cX6ohfLc5MGkXPwjh5itTYQLkLpmkQPKfh9hW5Nk0oVQs=
=NgK6
-----END PGP SIGNATURE-----

--nextPart52158209.sr77xQc4Tj--

