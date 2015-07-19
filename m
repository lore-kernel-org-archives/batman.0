Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 19 Jul 2015 17:03:01 +0800
Message-ID: <71865943.pb9oMPmvuo@voltaire>
In-Reply-To: <1437144603-29020-1-git-send-email-mareklindner@neomailbox.ch>
References: <1437144603-29020-1-git-send-email-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2275317.fFqoMFslNS";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batctl: list supported and configured
	routing algorithms
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


--nextPart2275317.fFqoMFslNS
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, July 17, 2015 22:50:03 Marek Lindner wrote:
> With this patch, batctl is able to:
>  * list supported routing algorithms
>  * list batX interfaces with their configured routing algorithm
>  * view and alter the selected routing algorithm
> 
> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
> ---
> v2: man page entry added
> 
>  debug.c      | 14 ++++++++++
>  debug.h      |  2 ++
>  main.c       |  5 ++++
>  man/batctl.8 |  8 +++++-
>  sys.c        | 91
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> sys.h        |  3 ++
>  6 files changed, 122 insertions(+), 1 deletion(-)

Applied in revision 2c2cb26.

Regards,
Marek

--nextPart2275317.fFqoMFslNS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVq2fFAAoJEFNVTo/uthzAVNsIAI/T0rd/8kR5+j8p+xSvOYvG
zeKp4/NawrdX8zCiAmFsU6rigGKuJVmQy+EsvVh2TnKmJ5qEvEIU4c8VgyioWfWy
1ybfU8ml0NPM9K+ptOoThTsRDN2aRZLHoRXVZkm9R3dDHNeJcAr9CGfykXLuBFs6
cR9jjQ/RFibBNNUz3cbGiH3zN735qoHZaU5Q9jf8sjVZRcCXX+ahJsHKOCRIU3PH
PfMW/WqWWHenKPR7pKSkgMdjKmhJk1N43dgo/HXYPI11IJE5oyldEAyOqafhr+6j
izBXlXKIhbmWNixZcZKIQrjdL5tgzcTmsroh+kEqJd0nTaF+2/ZuCBjZSblR0FE=
=/0OK
-----END PGP SIGNATURE-----

--nextPart2275317.fFqoMFslNS--

