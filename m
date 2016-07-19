Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 19 Jul 2016 16:43:06 +0800
Message-ID: <2783515.TbxLZsGaPg@voltaire>
In-Reply-To: <1468597173-25378-15-git-send-email-sven@narfation.org>
References: <1468597173-25378-1-git-send-email-sven@narfation.org>
 <1468597173-25378-15-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart25327642.WMibeYAKyx";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 15/18] batman-adv: Place kref_get for
	nc_node near use
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

--nextPart25327642.WMibeYAKyx
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, July 15, 2016 17:39:30 Sven Eckelmann wrote:
> It is hard to understand why the refcnt is increased when it isn't done
> near the actual place the new reference is used. So using kref_get right
> before the place which requires the reference and in the same function
> helps to avoid accidental problems causedy incorrect reference counting.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v2:
>  - split patch based on type
> 
>  net/batman-adv/network-coding.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied in revision 9ba0625.

Thanks,
Marek

--nextPart25327642.WMibeYAKyx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXjegaAAoJEFNVTo/uthzAaXgH/36nuSt9s0o8T51ew6wYTSzP
GGHFZoXGWgw0lix8fv6PZg+eYQZaPiA0PrLtt+XbKOjmK0goIT8NN+8gp1eVQOCF
Cx/9xIdeFcnV/LECtLMOfrU65mV5wJICnk59i6QBYvWGlo3Tu6ggZ/Ehi1xk+kGm
0ziDRlK3PPxVO8l7aH/i+nfDML149bpwQqeh1oQO/hmnOdN++XyiZb3RZU/QGs5Y
REXQMK3obBXPe05cFCQwsEBESmoMHPw1vKT8UMPzv0vwzcz9kwsGxZp8Gk2QPYLY
HDBotcXxTin4/D4YXJZJAC1ciV+3s9+bd+dlFvfopCTicbMqCrGTUvlY9VDdX80=
=4ZG6
-----END PGP SIGNATURE-----

--nextPart25327642.WMibeYAKyx--

