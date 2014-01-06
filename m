Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 06 Jan 2014 16:40:34 +0800
Message-ID: <2502065.E5JWJGtyGY@diderot>
In-Reply-To: <1388960736-3873-1-git-send-email-antonio@meshcoding.com>
References: <1388960736-3873-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2296652.jsFVfGG7LN";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 next 1/3] batctl: introduce rtnl_open()
	helper function
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


--nextPart2296652.jsFVfGG7LN
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 05 January 2014 23:25:34 Antonio Quartulli wrote:
> Other part of batctl may require to open and send
> a message to RTNL. Extract this code and put it in
> a generic helper to simplify future uses.
> 
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
> 
> Changes from v2:
> - removed IFLA_NAME attribute from request (now we send the ifindex
> directly) - improved rtnl_open()
> 
> Changes from v1:
> - fixed typ0
> - removed len argument from rtnl_open() in 1/3
> - removed error messages in 2/3
> - avoided double free in 2/3
> - simplified 3/3
> 
> 
> 
>  functions.c | 51 +++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 35 insertions(+), 16 deletions(-)

Applied in revision 148ba1c.

Thanks,
Marek

--nextPart2296652.jsFVfGG7LN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSymwTAAoJEFNVTo/uthzAlc4H/28fJYJ0mA/cSSeWcNz3UXBq
tsQma77qKsnWNRTIBIAPVeDrll+4sSrQx4/o2h0LQrIVAX9nLYFTvRyKUwU95eKY
1x2qNs9iqQ4kzfv1LRntEuVSriOW2LnX8LNK1AE1R5mKvBRmpmhKj8qujNVTEDlQ
SG3Ib1WmEkXXY0GFtM1UAJGEy+vfwvQfbhiuyOdYn8j32GKYsLXMNWJpMRk2/TKr
eavwnYlhIT4OnWxd8Y1ubRMYkWF48F9I/eOfu36iEOflguZpL8tyWFqpluzd9UgJ
PDWm1Zerqh4sh67BMdo5zb9dAd+OG7sStHOkDuWxmtev6krzMscTqf7E+QbxTkA=
=2nJo
-----END PGP SIGNATURE-----

--nextPart2296652.jsFVfGG7LN--

