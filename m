Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 26 Nov 2013 01:51:13 +0800
Message-ID: <4090496.CKZxZ93Xi7@diderot>
In-Reply-To: <1385298345-13746-3-git-send-email-sw@simonwunderlich.de>
References: <1385298345-13746-1-git-send-email-sw@simonwunderlich.de>
 <1385298345-13746-3-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2202815.FOS2Rdz5mY";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: fix rcu pointer
	comparison problem
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


--nextPart2202815.FOS2Rdz5mY
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 24 November 2013 14:05:45 Simon Wunderlich wrote:
> From: Simon Wunderlich <simon@open-mesh.com>
> 
> sparse complained about:
> 
> routing.c:482:64: error: incompatible types in comparison expression
> (different address spaces)
> 
> This was due to comparing a __rcu pointer with a regular one. Fix that
> by adding the missing rcu_dereference call. A temporary variable is used
> to comply with the line length limit, use the opportunity to beautify a
> few other places.
> 
> This problem was introduced in commit
> 797edd9e87ac838711e03498a4ae795b600191af ("batman-adv: add bonding
> again")
> 
> Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
> ---
>  routing.c |   16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)

Applied in revision f2a1300.

Thanks,
Marek

--nextPart2202815.FOS2Rdz5mY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSk44RAAoJEFNVTo/uthzAaQ0H/1XP/kqR7ZGQV23ejZqLJiGm
bLZAfkfPLIKUv2sVvMOW8bHqhBHtHdff08yzfhSEaFPDw0IvR5I+tg+54jZJEeNu
XYtmdUQc/ejEJMidQtzNosItJlKxI1ZdjOhltXrURXVAi3RV7zIQqeHIQzt7xuwA
QJQ4F+wdz6+OAzLHKnT3wdtv+dMUXIw2C2KcTQyBZ6LwEvBUn9Tx+qiHke+azsi/
kulDO2arhiMeg74qCu2+JbjFc+MmJIVQz9ZzOizOX6d1PERmNUiFswNpDpRUHN8P
fLzOkoq/euYXf+B1HsVH5Twt+kAp+r2F8ELM7TZ09rRwnG9h8WjBPbnFElCtoDc=
=396W
-----END PGP SIGNATURE-----

--nextPart2202815.FOS2Rdz5mY--

