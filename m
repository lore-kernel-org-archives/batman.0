Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 25 Sep 2013 22:49:54 +0800
Message-ID: <6575869.FX9F3cA1N1@diderot>
In-Reply-To: <1379775907-19199-1-git-send-email-marco.dallato@gmail.com>
References: <1379775907-19199-1-git-send-email-marco.dallato@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3489020.fGMBEBrdBB";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batctl tcpdump: Fix reported
	length of TCP payload
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


--nextPart3489020.fGMBEBrdBB
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 21 September 2013 17:05:07 Marco Dalla Torre wrote:
> Fixes the erratic report of TCP payload length in 'batctl tcpdump'.
> Previously TCP header length size was considered fixed, while
> this is actually not the case given the variable length (or no
> presence at all) of the options field.
> 
> Signed-off-by: Marco Dalla Torre <marco.dallato@gmail.com>
> ---
>  tcpdump.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Applied in revision e374a3f.

Thanks,
Marek

--nextPart3489020.fGMBEBrdBB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQEcBAABAgAGBQJSQvgWAAoJEFNVTo/uthzAwKsIAJdqs5mbcoUGdXR4uIMtO+cH
Tr0u93xehU3rcK2LA389Royd8cQS8JeP+aYadySOUMdMpC5wCoudc9Ct3fAAuWb8
7WSR5e89svHxAA9wTQ2UoAOz+Atxt+Cov9FGorB9SIveWope6Qp3Hku9GAlggc9e
VqfVnwPxseiN2t2Pf8XJO4GJSqpS6x5pqnL83gXT5yn9GA32mSaWsY8dX8ksGkDW
JHV2qyYCxR+0j13tNMjkU12ID5AXxdRYnOwOkiXshp3z3RnQUYh5ps+XYMJrGqT0
KiUvfAWhxkXusKgrZx3X/SdgT9DccvGwyKA1GPUna+cXLaeHbBGJiIV5CRYWqLs=
=MvuS
-----END PGP SIGNATURE-----

--nextPart3489020.fGMBEBrdBB--

