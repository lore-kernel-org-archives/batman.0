Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 13 Jun 2016 12:45:07 +0800
Message-ID: <1878939.EnT6oc3qcu@voltaire>
In-Reply-To: <1465592459-9474-1-git-send-email-sven@narfation.org>
References: <1465592459-9474-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2092688.Ep33JK9Ua6";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v4 1/5] batman-adv: Define module rtnl
	link name
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

--nextPart2092688.Ep33JK9Ua6
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, June 10, 2016 23:00:55 Sven Eckelmann wrote:
> The batman-adv module can automatically be loaded when operations over the
> rtnl link are triggered. This requires only the correct rtnl link name in
> the module header.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v4:
>  - rebase on top of current master
> v3:
>  - rebased on top of current master to fix conflicts with newest patches
> v2:
>  - rebased on top of current master to fix conflicts with newest patches
> ---
>  net/batman-adv/main.c | 1 +
>  1 file changed, 1 insertion(+)

Applied in revision c321b82.

Thanks,
Marek

--nextPart2092688.Ep33JK9Ua6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXXjpTAAoJEFNVTo/uthzAYFgH/2pPluIZMpgjH0W2OtUiQU6+
5rmIYOupo2n8KwfzIDDAGBH9VL6WiC0W0P7iKqNb4mtOmp0dSZ4EjKRfn2E6MV8A
/uflkFObJWgbDfTdwqCDeVPts02tx0ewefCl8mfKA7pUNWoMHlH0P/ZScsPMl7/j
nntVdw8+ZRPV1lMt+2lynPNPLpLTgEb8FXNwafTPyKeZGi7aeH1st4hDqcBjMqny
kmaGKjl8955jJEw+nD7vdK7ENbu3HjlWeIT/h05G9YBxE+pJDcQ99neOxBqTv+pW
dmQCBz9+M/drEXn06wVUQNbWILN32nYJroi2i7JrntLPevhVCfIBbWGZP7H2558=
=q6p0
-----END PGP SIGNATURE-----

--nextPart2092688.Ep33JK9Ua6--

