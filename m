Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 22 Nov 2015 05:43:53 +0800
Message-ID: <39140191.IlFnkF2PZF@voltaire>
In-Reply-To: <1447082453-13117-3-git-send-email-sw@simonwunderlich.de>
References: <1447082453-13117-1-git-send-email-sw@simonwunderlich.de>
 <1447082453-13117-3-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1889272.i06Gt5aEyx";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: increase BLA wait
	periods to6
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
Cc: Simon Wunderlich <simon@open-mesh.com>

--nextPart1889272.i06Gt5aEyx
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, November 09, 2015 16:20:53 Simon Wunderlich wrote:
> From: Simon Wunderlich <simon@open-mesh.com>
> 
> If networks take a long time to come up, e.g. due to lossy links, then
> the bridge loop avoidance wait time to suppress broadcasts may not wait
> long enough and detect a backbone before the mesh is brought up.
> Increasing the wait period further to 60 seconds makes this scenario
> less likely.
> 
> Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
> ---
>  net/batman-adv/main.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied in revision c57af3a.

Thanks,
Marek

--nextPart1889272.i06Gt5aEyx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWUOWZAAoJEFNVTo/uthzAq1kH/3nuoMtdeqYCRTnsWQeUdHzY
MNx/5g0k4Byk03p2Eou7ISq3RVDGH6NGPfxyEty8rWIXbDoTaXVhguFZKSLCDpHd
BeYSllZmxihLlvnHgRz6ZiGRkDq4jfZt/9X7Nx6p77pCVqlk8EAk9q8qQBoF1BN7
R2xS8WcdxON6o073hHOBqzxj+hWXhOSxtmrCAXsGlWsqxOHmaVVVpybe/jyMiHKd
m/tiLLWZd7yTA2BhoR/nCvxUXBnvlOx8vcQHdK+D2YuDnYs1VX74W67YdQOgGaqh
27GfRXADLm4vcC5ehHzXSGin7Ga1QQsE2jlnhHs2xLNkjgzNOricWVIp4HHfupI=
=coM2
-----END PGP SIGNATURE-----

--nextPart1889272.i06Gt5aEyx--

