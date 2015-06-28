Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 28 Jun 2015 21:58:07 +0800
Message-ID: <2296737.sKbHr8lXIe@voltaire>
In-Reply-To: <1435150220-25157-2-git-send-email-sw@simonwunderlich.de>
References: <1435150220-25157-1-git-send-email-sw@simonwunderlich.de>
 <1435150220-25157-2-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2712142.x2lC9UY5v1";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint 2/2] batman-adv: remove broadcast
	packets scheduled for purged outgoing if
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


--nextPart2712142.x2lC9UY5v1
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, June 24, 2015 14:50:20 Simon Wunderlich wrote:
> From: Simon Wunderlich <simon@open-mesh.com>
> 
> When an interface is purged, the broadcast packets scheduled for this
> interface should get purged as well.
> 
> Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
> ---
>  send.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied in revision 07bec2d.

Thanks,
Marek

--nextPart2712142.x2lC9UY5v1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVj/1vAAoJEFNVTo/uthzA4iIH/0nk+d2c2AuHUX6o3mSyO1RP
5Avh59IQPHu+Dok7cJ69pmtGWqf0jLKt9EePXFbZLhiKW91dH3JJwiuWiVaGFnBA
cJTj3VGeSuBEZb+VgJygk4WDMczTRYzczLO06ho6N0rDZes0axJICxtZ0kAZvzwH
qt1oGEkH7K0csqF2LxH0q7piUPYbcH7oIihQsU4SgGjy/GFn27m8WsmgBycM9w9F
hcgvoHqjuYa8fPuF7O+uwVSxY/rl+hpDhVxZJjhoKQw1rPaHbfuWbG85sLemPYMM
T0K73KuPm/8NoOdk0MkHpQ0geQyw3azNIL0lwIY7/P6iyID6VPiZuO0a/VHvcrw=
=Ac4u
-----END PGP SIGNATURE-----

--nextPart2712142.x2lC9UY5v1--

