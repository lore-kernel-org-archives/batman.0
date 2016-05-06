Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 06 May 2016 12:07:46 +0200
Message-ID: <2103263.6dd1XhfGn3@sven-edge>
In-Reply-To: <1462527819-11907-2-git-send-email-sven@narfation.org>
References: <1462527819-11907-1-git-send-email-sven@narfation.org>
 <1462527819-11907-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2269415.yJNdegdfIv";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 2/2] batman-adv: Fix refcnt leak in
	batadv_v_*
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

--nextPart2269415.yJNdegdfIv
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Maybe it is better to rename the patch slightly.

    batman-adv: Fix refcnt leak in batadv_v_neigh_*

But I will not resent the patch for only this change when not explicitly asked 
for it.

Kind regards,
	Sven
--nextPart2269415.yJNdegdfIv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXLGzyAAoJEF2HCgfBJntGqLsP/iOB7vNiBZI6MCdoNxeud2FM
zyMUVoHJU2MhbSEuVGutHnFkza0sAArFFNekwpq8vG2YjEDdqHeKGcHxwnMiJHzw
M8qAqKCR+8qM0cvzYuWDDj7/eKwjX7L+ijM9U+zxhU/AQ0aWRPlmVdB/qR9IMH7d
tai5bGgtxto+iN3IbRmqc86WAHOi47L3SdZ7WhjW399fVkTmjISPe6oBIjFQqu5C
8Q+s1geMKgEGn6sVSy9h9SARltolXnbG7S+rCD7UzVxAF/8UW1BMXKORB4EgkI1k
LK6HWqWOa+iLBwKzfWBmwU51n0cgBBqoBVsFwER5oZpoF5rI1vVzCmGG7XheSnyy
iIfd+YdgrIoZ94etbHS/sfpj/EdjqUNDc3HMOTV7KHp/uWFd9ye5Ick72hSQVf7D
CUI5/tfpjM11Ppo6oEuIm/8urxBwjYwYbVwGKapC3HsrCTwrY7oF6kyhs6qtp3Dc
kb6z2ZIgR5wE10GzPRJywsIrNkQlSc5DBJ82PzJ643ExjrlIUbORanFPa/s+cYio
7ZQAOIc8xktkB6dnAkmjRrxe36QwxH4b2y1ivJxeqlVaa58utFW9Qhr0TyRIoC8d
mlIRIPqGs6mkyus44pmw9QACvAb90XwO3ZnRCOaSsWN6OeVIdkhnkVtO7pd8eTq+
t6AU0/4OWQYf6sg7M/0g
=AM+8
-----END PGP SIGNATURE-----

--nextPart2269415.yJNdegdfIv--

