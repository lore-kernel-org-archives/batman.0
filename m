Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 28 Jun 2015 22:40:23 +0800
Message-ID: <1620431.oACbZJ0Fvs@voltaire>
In-Reply-To: <1434890572-3199-1-git-send-email-sven@narfation.org>
References: <1434890572-3199-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2821771.cdC87Irp3u";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 1/4] batman-adv: Return EINVAL on
	invalid gw_bandwidth change
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


--nextPart2821771.cdC87Irp3u
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, June 21, 2015 14:42:49 Sven Eckelmann wrote:
> Invalid speed settings by the user are currently acknowledged as correct
> but not stored. Instead the return of the store operation of the file
> "gw_bandwidth" should indicate that the given value is not acceptable.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v2:
>  * rebased on current master
>  * add missing header linux/errno.h
> 
>  net/batman-adv/gateway_common.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied in revision aa203f7.

Thanks,
Marek

--nextPart2821771.cdC87Irp3u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVkAdaAAoJEFNVTo/uthzA+T0H/AwVgpsnaV5bPXCAUgwiG6ye
aft6F6UjiBOrIIYrioObq481lqykCfH4Wplr8F2alrFh/gQgWsWYQv53uJM6RdkX
2ZRAyWpZ2eIBxt+op7kOhqjnRDE2afjUomE7Lm0cEzrFls2OOu6mUoIiQK/hhxkp
ssFrGixUYLGh6LROquPamrdffKNRy7yKweUFI90k0zrg2GwM67llIzG+lDlSLY1+
TTTq2fh1azXRy+THS7veTwGsWDy7nFDSwm6J9j0yH71F5MAti6WLgDMDb/YWelvG
VJgTO3D43pMccNO92Np7znvy6pqL348Bs5RUUhzr0TRO1zACf2hCK1JtUejdyTg=
=LtQC
-----END PGP SIGNATURE-----

--nextPart2821771.cdC87Irp3u--

