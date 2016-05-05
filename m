Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 05 May 2016 22:57:41 +0800
Message-ID: <1774898.aRJ2jFsdb6@voltaire>
In-Reply-To: <1462444519-26509-1-git-send-email-sven.eckelmann@open-mesh.com>
References: <1462444519-26509-1-git-send-email-sven.eckelmann@open-mesh.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart13693396.IKqldZKaSt";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Remove unused
	work_struct forward declaration
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
Cc: Sven Eckelmann <sven.eckelmann@open-mesh.com>

--nextPart13693396.IKqldZKaSt
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, May 05, 2016 12:35:18 Sven Eckelmann wrote:
> The only function declaration using the "struct work_struct" was removed
> and thus this forward declaration should also be removed.
> 
> Fixes: 0d8468553c3c ("batman-adv: remove ogm_emit and ogm_schedule API
> calls") Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
> ---
> Problem was found by
> https://lists.open-mesh.org/pipermail/linux-merge/2016-May/003146.html
> 
>  net/batman-adv/send.h | 1 -
>  1 file changed, 1 deletion(-)

Applied in revision 2ceab95.

Thanks,
Marek

--nextPart13693396.IKqldZKaSt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXK19lAAoJEFNVTo/uthzA7g0H/2rOHB4buNSI927vpYuPy3fI
kWhsAlIZspb8O/3swqqW4UNIMVP3ZUWRQv3KNyw0jnu21MJqL1C25MgP6eKsj9Z6
wlJ+y4vsqwdii0ZWoaJhLHn4LaWx+SB3AY8pirAp42Pg2FvPChD+ghl1SBupIi1O
fenYvZ8l7zW6kBh6HaQlMiSQBsdq0Bs86fmRpkNPRUp7jk2Ix4DgVFdakLN30lJg
joikoKRQGY5Z9soSB0EURG6/evV/3EZ5zxog5tyDwc4bRqjzE/rgCsr0ZKgY2djQ
z1OZu7U/UwRmqF5oMF1PtplE5ZPr1FnVScAwN5mJkIr34S0etzR38qSJV/AbWsU=
=d8JW
-----END PGP SIGNATURE-----

--nextPart13693396.IKqldZKaSt--

