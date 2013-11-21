Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 21 Nov 2013 09:20:07 +0800
Message-ID: <3505653.Qt8n1aILax@diderot>
In-Reply-To: <1384845967-2497-1-git-send-email-antonio@meshcoding.com>
References: <1384845967-2497-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8319156.dig8S0yAAL";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: add compat code for kstrtou32
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
Cc: Antonio Quartulli <antonio@meshcoding.com>


--nextPart8319156.dig8S0yAAL
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 19 November 2013 08:26:07 Antonio Quartulli wrote:
> kstrtou32() does not exist before 2.6.39. Convert it to
> strict_strtoul() in that case.
> 
> Used-by: e29249b4483b91d7a590a16e9b5ffe9412ce7fde
> ("batman-adv: add isolation_mark sysfs attribute")
> 
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
>  compat.h | 2 ++
>  1 file changed, 2 insertions(+)

Applied in revision 28855a6.

Thanks,
Marek

--nextPart8319156.dig8S0yAAL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSjV/MAAoJEFNVTo/uthzAmhQH/0J0/6XpKUG4EYrzNGIQHajI
gy9CRucC6mSqlCp6SrMjzNWLSG5TJh4qzHTzf2k+oUnRbb8hPhbAbm2so9rB99B9
MMwV/RuEQLxf5ICKUFhU7/nF9sjwHmZy1CNJ0z2EDsTcxxd2MSUGCaPxSVBo8oy7
YWRTVR4gt0tDaUTz35k01J8P4eB+c34TT3RiWPY87Ll5lBcQOW6BeIKrLVZVPtzl
KFmCRzUBKivwXm6mrDZKxTILJLxq6Bn1mr4xdiHGOKbDmWCGYEZAQvcgulz7MvLr
Q60/EfvoEtlqk+AJWYAFlsbbpaOLwIzdAZm8TUmCF0aNCy4B6XDrdIskmOprGK4=
=YLJu
-----END PGP SIGNATURE-----

--nextPart8319156.dig8S0yAAL--

