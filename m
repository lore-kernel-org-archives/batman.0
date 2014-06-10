Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 10 Jun 2014 22:58:09 +0800
Message-ID: <1540170.akMPSsn7dY@diderot>
In-Reply-To: <1400933804-9661-5-git-send-email-sven@narfation.org>
References: <1400933804-9661-1-git-send-email-sven@narfation.org>
 <1400933804-9661-5-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5463026.OSVjB2Z2DK";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 5/6] batctl: Initialize complete ping
	packet before write
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


--nextPart5463026.OSVjB2Z2DK
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 24 May 2014 14:16:43 Sven Eckelmann wrote:
> The data structure for ping packets is not completely initialized by the
> userspace because the kernel sets the originator address of the packet. This
> is not only a bad practice but also irritate tools like valgrind.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  ping.c       | 1 +
>  traceroute.c | 1 +
>  2 files changed, 2 insertions(+)

Applied in revision 7e53633.

Thanks,
Marek

--nextPart5463026.OSVjB2Z2DK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTlx0BAAoJEFNVTo/uthzAA5sIALveSeINAMxtLRg+nwdVAUsz
VF933blA+oDNEv0i9YRBcu8dixjph3Y4vSzO/NJ03GH95fTRhmwM4WxBEtCvUDlJ
V7VWQS0zR1NP1GKjMEcVm8hQGu+dMgvKR7PWTWgpgG3KKSBkCCr8CuS3Flpwq5Db
HumET2u9eNsbYCzz9FR3bs7BWFjNw4RYlfwHtx98JQmW2ycW2GZavh0MYaT/z2BH
WJAuN5bwyIu6Tf0AMZKo4wOcxCzF6vkT+wqrOZWd+0AVfhhHPhzK1dNSxgucWLUX
I67TRmwwV03buUvUXl7qwHXNbTl05fbCMexWs/lJJmpHsHEku2mmNY+DsPp/ydE=
=CSRQ
-----END PGP SIGNATURE-----

--nextPart5463026.OSVjB2Z2DK--

