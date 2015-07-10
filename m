Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 10 Jul 2015 16:18:52 +0800
Message-ID: <3207777.8ZijIqqf9V@voltaire>
In-Reply-To: <1435500966-2584-1-git-send-email-mareklindner@neomailbox.ch>
References: <1435500966-2584-1-git-send-email-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1974504.r7xHOY6ZvC";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: convert
	bat_priv->tt.req_list to hlist
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--nextPart1974504.r7xHOY6ZvC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, June 28, 2015 22:16:06 Marek Lindner wrote:
> Since the list's tail is never accessed using a double linked list head
> wastes memory.
> 
> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
> ---
>  net/batman-adv/main.c              |  2 +-
>  net/batman-adv/translation-table.c | 29 ++++++++++++++++-------------
>  net/batman-adv/types.h             |  4 ++--
>  3 files changed, 19 insertions(+), 16 deletions(-)

Applied in revision c5bcd65.

Regards,
Marek

--nextPart1974504.r7xHOY6ZvC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVn3/sAAoJEFNVTo/uthzAsi0IAIWkWQ90VBbcmP60weA+RoFj
bmwDewel1lVxWf4N9JN3jss/yu1yD+Hp4n0UZ5C9yhsU8joyGmcNNc8h8k4N8g7v
yc2TJY4jZjH5Wp1gD9J1PReIry6mwHStqjLOTsfwnFO/mcrLSMLxIC/h+tuaNKsn
rEMp/n8UvXerYBt8+NYCGjOrMfanonpHt9WOMqOgKJGTPwxBfGQi6FhWlH7kYHpN
XC0jBCLN5S4iedJrNQnuD9+ANlYNGHu5Fbza4TYZzDCM+0yw5DStQ7S19l4tiog1
flx3pRYNfhCre746ipn388Nh9+VsAMmbHJghykuceHnlE9F0OYUTTtQvqG7k7tg=
=jC/n
-----END PGP SIGNATURE-----

--nextPart1974504.r7xHOY6ZvC--

