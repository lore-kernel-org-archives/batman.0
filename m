Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 06 May 2016 09:03:02 +0800
Message-ID: <10779195.S2JSqNmCvR@voltaire>
In-Reply-To: <1462474003-25279-1-git-send-email-a@unstable.cc>
References: <1462474003-25279-1-git-send-email-a@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart16835849.8QQqRJKqmr";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/7] batman-adv: remove useless inline
	attribute for sysfs helper function
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

--nextPart16835849.8QQqRJKqmr
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, May 06, 2016 02:46:37 Antonio Quartulli wrote:
> the compiler can optimize functions within the same C file and therefore
> there is no need to make it explicit.
> 
> Remove the useless inline attribute for __batadv_store_uint_attr()
> 
> Signed-off-by: Antonio Quartulli <a@unstable.cc>
> ---
>  net/batman-adv/sysfs.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Applied in revision 67bf881.

Thanks,
Marek

--nextPart16835849.8QQqRJKqmr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXK+1HAAoJEFNVTo/uthzAlSgIAIPX02vvk6/H4z8GHsJ6lLLc
84wI5/Niz+nxuYtFoEebnHDPPoC6KeqfFr0lbPUaq2kVPAHteJmQCXH9f3UJ3TxL
WM9234PvwSopX6rm0zFWWnhp7SFcBkRQSEdsBE7py6VjNvZFvBUv9y1IsbSBSOgK
Hg36v1OIYjoj16hCd1Zd/4cf6hpHVIDjR4zMZyxstYbXL/yVzG0svwlS0QLAujsR
3/SgBnihTeIx1sjrKn/k+FjHgY6QAhebW7spd5j+fbN+F9uWC3XGbwTf4TK6Cqdb
osoJ/NsTMnAcLyb1N8naOYcKSWEp3Qa4hwsQDX/TfCwccRhZf+U3PrDQuIfPd/w=
=QvV0
-----END PGP SIGNATURE-----

--nextPart16835849.8QQqRJKqmr--

