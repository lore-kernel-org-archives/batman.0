Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 14 Oct 2013 19:07:57 +0800
Message-ID: <1821487.crxj1At65v@diderot>
In-Reply-To: <1381625420-4062-2-git-send-email-antonio@meshcoding.com>
References: <1381625420-4062-1-git-send-email-antonio@meshcoding.com>
 <1381625420-4062-2-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1492350.bfCbHeJpPh";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 1/4] batman-adv: don't switch byte
	order too often if not needed
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
Cc: Antonio Quartulli <antonio@open-mesh.com>, Antonio Quartulli <antonio@meshcoding.com>


--nextPart1492350.bfCbHeJpPh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 13 October 2013 02:50:17 Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> If possible, operations like ntohs/ntohl should not be
> performed too often. Use a variable to locally store the
> converted value and then use it.
> 
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  routing.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Applied in revision 60087ff (master branch).

Thanks,
Marek

--nextPart1492350.bfCbHeJpPh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSW9CNAAoJEFNVTo/uthzAXwcH/1W1PzpPX9aYrem7OlvUn8zT
qKOUUrUS0pg8G+nMiC0fqihB02lcuaMOfJTkopkzCI8kt1KVaBZ7Ro8NtSZdDher
tzD7SVdJYeeGSLdO8eR4YTZZEppFtIi7J6x59Uf7SxOYeDteUTN9Gn2i6jRXe1Wq
5vIug5kswHQakLOiG0V+344uOWCQXF/irKam7wez4y7ms0UqouMcO5h74z+8a5Md
uz6Ibtp0hDUD+SgMEwkYEAYWDlrf9iOTeDhJpolSJYkvEHv/3r909Vh7TkB7bWfy
41mwYBtyjiYcSnP3nryXr6QsjjbBKEija1Ioi3YMHxoYIg7u+lBvhLVFPxuNY2A=
=xOrP
-----END PGP SIGNATURE-----

--nextPart1492350.bfCbHeJpPh--

