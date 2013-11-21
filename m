Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 21 Nov 2013 09:25:39 +0800
Message-ID: <1421928.sru6gkyA66@diderot>
In-Reply-To: <1384366492-27310-3-git-send-email-sw@simonwunderlich.de>
References: <1384366492-27310-1-git-send-email-sw@simonwunderlich.de>
 <1384366492-27310-3-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4972180.b1Cf0T1HsU";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 2/8] batman-adv: split tq information
	in neigh_node struct
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
Cc: Simon Wunderlich <simon@open-mesh.com>


--nextPart4972180.b1Cf0T1HsU
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 13 November 2013 19:14:46 Simon Wunderlich wrote:
> From: Simon Wunderlich <simon@open-mesh.com>
> 
> For the network wide multi interface optimization it is required to save
> metrics per outgoing interface in one neighbor. Therefore a new type is
> introduced to keep interface-specific information. This also requires
> some changes in access and list management.
> 
> The compare and equiv_or_better API calls are changed to take the
> outgoing interface into consideration.
> 
> Signed-off-by: Simon Wunderlich <simon@open-mesh.com>

Applied in revision 9bb33b8.

Thanks,
Marek

--nextPart4972180.b1Cf0T1HsU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSjWEUAAoJEFNVTo/uthzAcD0H/joQbJhaloiQtX6Sr2L/5NFI
fHlDEqLuQduKhZ5strDwsS5G80o+caCQDAaHlB5Y6jXfTCiVBvIXvyajjnJSriip
CuMAoMac1jIQC+n4hOQ1rmL63HMzivWy/I0zI84zeLB/yneBHhvuU9FmdXMglFB7
wfoNpQk+myP1ruebh7s/hUwKSj7aFzkW0TizJwF8RxkTOmO8i5SDYVUxGLlWMZ2G
/+kM7wrV36qa2IEyHvTBK9YyJRG6+mjhzQofK37vzqNlTifBRhYrJmUFbOocqRow
bQ72l8uORb2U60wdIPuXhY2yyjj3qJ6HYzxuBjCsVnsZuzLtNc7j3xgmsRqUbLw=
=axVH
-----END PGP SIGNATURE-----

--nextPart4972180.b1Cf0T1HsU--

