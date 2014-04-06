Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 06 Apr 2014 21:52:29 +0800
Message-ID: <7868056.JTuzNk4An1@diderot>
In-Reply-To: <1396442402-13847-1-git-send-email-antonio@meshcoding.com>
References: <1396442402-13847-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2871504.C105i3cGzW";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH openwrt-routing-feed] batman-adv: add
	support for the isolation_mark option
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


--nextPart2871504.C105i3cGzW
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 02 April 2014 14:40:02 Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> With the introduction of the Extended Isolation component[1]
> a new option is required by batman-adv: the isolation_mark.
> This patch adds support for it in the configuration file
> 
> [1] http://www.open-mesh.org/projects/batman-adv/wiki/Extended-isolation
> 
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  batman-adv/files/lib/batman-adv/config.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied with minor modifications in revision 73764a0.

Thanks,
Marek

--nextPart2871504.C105i3cGzW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTQVwhAAoJEFNVTo/uthzAAtoIALwNl4KPeC3IHbBJDQLXzrdv
NhBczAUM+U0gplPzhIevkpDghitqSFqM2unjUcLWzuqm/PK+f66hu/BMzOcQqFB5
sENwMIOARm+ZNq8ogJGN1nyEXUbltBHOx3bkYFkgbLdeKGo6iIzEd7fIglT2gTr9
TwCNTJ5EfSpb+RHibvSuLPQlkE6oC6y4SY1AiWsiR5pkKOwo+espkJ0VUwWUzLzW
LiWAEpXOEX3buz1FluIFliJ8rjADpgGJNPoHafv4yOdBzvET5qsdxg+mvQH1om1/
fdRuICnOH6gwDVOQXRrQOy4CaVynt5P4n2vtyI3noqhg7xAtOCLmqpsmP//cHpA=
=5EFl
-----END PGP SIGNATURE-----

--nextPart2871504.C105i3cGzW--

