Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 26 Nov 2012 13:39 +0100
Message-ID: <2262644.KoOtvs7upt@bentobox>
In-Reply-To: <20121126123002.GE22729@ritirata.org>
References: <1353867811-8452-1-git-send-email-sven@narfation.org>
 <2094937.nutMCHjP7e@bentobox> <20121126123002.GE22729@ritirata.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1598940.CUOGWGJ2Pk";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/5] batman-adv: Use common Jenkins Hash
	implementation
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
To: Antonio Quartulli <ordex@autistici.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--nextPart1598940.CUOGWGJ2Pk
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 26 November 2012 13:30:02 Antonio Quartulli wrote:
[...]
> > The in kernel implementation will create a different hash sum -> tt
> > entries
> > will end up in a different bucket -> CRC will be different (please correct
> > me about the last step... just had this problem in the back of my head).
> CRC computation does not rely on entries positions, because the real CRC16
> is computed on the client mac address only (and this is the same
> everywhere) then the results are XOR'd together. Since XOR is commutative
> we do not need to keep the same order network wide.

I've already wrote this two 2 1/2 hours ago.

> Instead, your reasoning is correct for DAT, but for the global DAT hash
> function only.
> The local one can be whatever we need, so we can also use jhash for this.

Please define global and local DAT hash function. Because you use the same 
function in both places.

Kind regards,
	Sven
--nextPart1598940.CUOGWGJ2Pk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQs2LkAAoJEF2HCgfBJntGnh0P/16a46HYgrQYjq+qcIL9uHky
ddlhpOnr2g+87vb5sEFsP/q4/5NbzmWRdhkB9h5WPYleIEDIlZBpDzTjKFbwvEIZ
LqvaATtgupUCvsdQ3qJBJTmOL082yLXiVaFtAeO1rr57yqfyxLDYJZhZ0dX/v63D
A5QQRGn6E0a/wsY6P0he9gbm5Vm7DJKhyB2jkRK5UtA4uxFGG5s3Yx4/HaLikPzS
9+6Uh7lg12tNVYZu69HoMyLPcax+Zk6+8+ym0tblbXMgEmcK4zLzLnJHLaGjCsXI
CmW3gCrsMov9q6NFH2XhGI7DaYiLNrSM/LI50IFYh/fzsT6DCCmbyGcvWXKr4b+1
Eo6wnUatqgw3/ji38A6En0BFNt3TXgOdq38B40ss4RgYSQxS0Y/Ej0PM07L190d7
6h9B2UYLoFwB9BY/iZGDAMe1HTD97xOw96NE5khr0YVc434ai89LQwqKcHGeg54j
XJWo394BADUi+CJY6SgqQjSEeahUtqGJbjW4e0yD3WraYLkSJLvDy6c1luPz2XPi
K7KpD6ZlydyBFsXtFTlkLC3cfoHP3PWdE5nWkBc7We64RgHay4lHCx2hRaEP+3Oa
i6CVL2rrga7Tr2O51Zbew0K/2aO1g2+Ysn/iryuNhSeI795QxIY4ReJBv0U/edNs
115a2bhwi8LydItG8ZvY
=VR/9
-----END PGP SIGNATURE-----

--nextPart1598940.CUOGWGJ2Pk--

