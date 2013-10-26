Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 26 Oct 2013 22:06:44 +0800
Message-ID: <4107175.LlyvV8Jxg4@diderot>
In-Reply-To: <1381852869-2104-2-git-send-email-sven@narfation.org>
References: <1381852869-2104-1-git-send-email-sven@narfation.org>
 <1381852869-2104-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1694382.iIY6jvTkyV";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batctl: Finish resolving of mac
	address early
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
Cc: Sven Eckelmann <sven@narfation.org>


--nextPart1694382.iIY6jvTkyV
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 15 October 2013 18:01:09 Sven Eckelmann wrote:
> It is not necessary to check the remaining msg buffer coming from the kernel
> when already the correct mac address was found.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  functions.c | 1 +
>  1 file changed, 1 insertion(+)

Applied in revision 7cd9934.

Thanks,
Marek

--nextPart1694382.iIY6jvTkyV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSa8x0AAoJEFNVTo/uthzAyxUH/R4DQhuoSB32TfJ3yVLvYCnO
t7lxXSF75wmUPTbfuhH5VDWewcDS5KonD/hKwF4TZO7GzsuCBSux7l/23fQ4Lv6C
4quamgQdAqrsEebD6WbMsO7qmtKYwbk4q36oJjygWDNtPIc/zS61IVP6OuOxHE8e
JGw/88mLPnd6bSbSsPk28gVQGT2xUuUXjO9dJieIERyHnCpQp6e3nIGjbUdjTjFj
eR6I16KpfA2vnJ+e+YYtRpbm2JZqZ4jJjq4zMNz4J3osaICHmJVh8c2HNNs+TmWz
3ASmwaYN5BMELlWMNv0QDWxbJI/CfxdJRiaTMEjlo03DO6ZNhvpXcOl7vMWB2og=
=oV6V
-----END PGP SIGNATURE-----

--nextPart1694382.iIY6jvTkyV--

