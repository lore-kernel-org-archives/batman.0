Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 19 Jul 2016 16:07:17 +0800
Message-ID: <2161644.iKX9veY64H@voltaire>
In-Reply-To: <1468597173-25378-1-git-send-email-sven@narfation.org>
References: <1468597173-25378-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2624537.oaBcXKHBUr";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 01/18] batman-adv: Place kref_get for
	orig_node_vlan near use
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

--nextPart2624537.oaBcXKHBUr
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, July 15, 2016 17:39:16 Sven Eckelmann wrote:
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
>  net/batman-adv/originator.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied in revision 333d1de.

Thanks,
Marek

--nextPart2624537.oaBcXKHBUr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXjd+1AAoJEFNVTo/uthzAYeQH/2jqEzrm//G488QkIVWTsNAY
ikes5E0jUHeImi5+Ddrcp7Wr0UiHErBend0dDEE/YPMZ/9wVEOE1F31Rn6GGYy8V
AA7BvCsBZBr1ZfoFFJAmsKPeqME+/w9yBGXZQdkIbEB46j1C71jQNahW9yD4lo75
NAfgWbrtd5L3cbzB0fbtdTcLyNPyRd0Ca3qMZn/yAwO1r0WJGbgJ82Z8IfTa0Adl
06MnHHUmyNKc1NYELmNz53qN+YL1xJMq6tsPWwekBvFe1R53geB+E5qZbn/mNRYW
v50x3gA/UGDbMUdZpySooOW0wIELWO3jH8nczYChvOtx6jzPWXjuI1LkUo69A8M=
=7dWn
-----END PGP SIGNATURE-----

--nextPart2624537.oaBcXKHBUr--

