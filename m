Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 20 May 2016 16:55:23 +0800
Message-ID: <6134298.8kT0GqNhfy@voltaire>
In-Reply-To: <1463303266-25979-2-git-send-email-sven@narfation.org>
References: <1463303266-25979-1-git-send-email-sven@narfation.org>
 <1463303266-25979-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3117602.gpjpfpRZbL";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v3 2/6] batman-adv: Keep includes ordered
	by filename
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

--nextPart3117602.gpjpfpRZbL
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, May 15, 2016 11:07:42 Sven Eckelmann wrote:
> It is easier to detect if a include is already there for a used
> functionality when the includes are ordered. Using an alphabetic order
> together with the grouping in commit 7df620092727 ("batman-adv: Add
> required includes to all files") makes includes better manageable.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v3:
>  - adjusted title
> v2:
>  - never existed
> ---
>  net/batman-adv/bat_iv_ogm.c     | 2 +-
>  net/batman-adv/gateway_common.c | 2 +-
>  net/batman-adv/hard-interface.c | 2 +-
>  net/batman-adv/main.h           | 6 +++---
>  net/batman-adv/multicast.c      | 2 +-
>  net/batman-adv/netlink.c        | 4 ++--
>  net/batman-adv/send.c           | 2 +-
>  net/batman-adv/sysfs.c          | 4 ++--
>  8 files changed, 12 insertions(+), 12 deletions(-)

Applied in revision b87df5f.

Thanks,
Marek

--nextPart3117602.gpjpfpRZbL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXPtD7AAoJEFNVTo/uthzAXhoH/1iOIht1UdaEqNgYMvCypWVZ
RyXlVFA+6N5Ga03wZVPo8eZCnppfv8QYoBG0VlUIfLa3Zxeis2YKnXoJRcKAMiHd
y8KvO6LbqbplXrIr3ztFVq591cdkH207OsRsAwJWrbHt2+mtZsahqXvw8VM44uq4
xcH7SgCd3XJ8jn4y0t7zxrX3zd4Tii58095iFUENciWvaWXYaug5fcEOCqKkW7Ug
hGgS1o6bgtDehcco37esAxpX6sDJL/SOlm/h4OPdBI6ESPoab0cUi8AL5TLEe4lu
WIeLkBCUknow2SApLutjct+LRYEOuCYlEeI13rsvJ5kjSYywlon86mw12h7sPXM=
=lfQL
-----END PGP SIGNATURE-----

--nextPart3117602.gpjpfpRZbL--

