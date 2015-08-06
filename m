Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 06 Aug 2015 20:46:56 +0800
Message-ID: <5338114.JDPsX0mrSU@voltaire>
In-Reply-To: <1438702304-26197-1-git-send-email-mareklindner@neomailbox.ch>
References: <1438702304-26197-1-git-send-email-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6237837.9eWhgS4eFh";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: turn batadv_neigh_node_get()
	into local function
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--nextPart6237837.9eWhgS4eFh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, August 04, 2015 23:31:44 Marek Lindner wrote:
> commit c214ebe1eb29 ("batman-adv: move neigh_node list add into
> batadv_neigh_node_new()") removed external calls to
> batadv_neigh_node_get().
> 
> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
> ---
>  net/batman-adv/originator.c | 72
> ++++++++++++++++++++++----------------------- net/batman-adv/originator.h
> |  4 ---
>  2 files changed, 36 insertions(+), 40 deletions(-)

Applied in revision c9bac8f.

Regards,
Marek

--nextPart6237837.9eWhgS4eFh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVw1dIAAoJEFNVTo/uthzA0MgIALkKs9zNUIdlp5qP8ALjb+nR
hDuGce6qi0WmUIZ5e6IsJZWdiS6KizVtnNOsTcEJBukQCY9q8MtEocruFjaUO1Gs
PLl9N3PkLUsnDUw4nbYXGrW0bP2FY5uNQjzb7Y/4P0jFRnI7GcWv2y5plCDeRv1l
fYS41mCyYulK84fbc8HmN7K+BuReidT5GOzvbqzF+d1KlglBfs1Sw+V2dHyi0fSn
pQYWNwqRnP7zjfHoKGRfEYRyEeGlWDrEuAsWt0hx/AEsbeiH7xhAM96Lsx4bZTfk
uj7cQv+BF5jEIt1+mC5WidGJpVr+iU9xvcktuBoYVIa14YPmZbugpq+BslxaEEw=
=mnps
-----END PGP SIGNATURE-----

--nextPart6237837.9eWhgS4eFh--

