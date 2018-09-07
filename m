Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 07 Sep 2018 13:17:44 +0200
Message-ID: <9913968.93eDA5pIIQ@sven-edge>
In-Reply-To: <20180906214555.12272-1-mareklindner@neomailbox.ch>
References: <20180906214555.12272-1-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2735896.mMySEnCET9";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint 1/2] batman-adv: fix backbone_gw
 refcount on queue_work() failure
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

--nextPart2735896.mMySEnCET9
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Donnerstag, 6. September 2018 23:45:54 CEST Marek Lindner wrote:
> The backbone_gw refcounter is to be decreased by the queued work and
> currently is never decreased if the queue_work() call fails.
> Fix by checking the queue_work() return value and decrease refcount
> if necessary.
> 
> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
> ---
>  net/batman-adv/bridge_loop_avoidance.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Added both patches as 24d83a50421c [1] and 85100b602c12 [2]

Thanks,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/24d83a50421c1c5d39cd9c015516a1a293ae8d0c
[2] https://git.open-mesh.org/batman-adv.git/commit/85100b602c127cecf1bcfd620d20eb867d685df2

--nextPart2735896.mMySEnCET9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAluSXlgACgkQXYcKB8Em
e0bJzxAAqXc6ivu3LnUxD7755/FAcnp1e2WYETY6YDiRxIIXEnRjjsY3CE8Am5Gb
RwGZ+wgaAUTAxlwK0vvppxNWTsiJ61leizWQE1RbBM+7KWDq9rxBPBFMP7CZCwVJ
A3Zk8ZfJY1VxU2b5wrfhRIpGb77hsXiZcRMmJAGBs2QfCH6hxmDCK5fxZpLhrzQQ
Fd4+acVVCzdJsbA9/HaELb9zBV6VEN3NCthxk7DiyBgdRfzfd3fHEXHxB+vD5qEu
cGvdt4HB07BT9HfYwcw0SHN8QNiNOQt8kkyVoBYxE61wQSN5KANiFRwvDH7FCLKm
q0Mr5uBhfSD2a0gLXoZOrIUyYI2v+lCIltAvHoXthY34X9mOuHBAgPCs1+7BCNcz
dvzWkOSMsgwilPg+QVcmcNsJ10+maM+BYy2k/AWDdOFxSfChhuIb8DnRTCb386c8
DAbfkY3HD0MbVbz0Fq37YTMaGf2xWbjacwRohC2oXNo4pXzq0RQvF6clwVaLFZpw
RZ4kF0u0O+gOAzcV4u2fKorv/rbV7LrEiKWxRdP3D3BI7KDdgkX3MFGjGepMPQzs
wDc/3Ek4JvfXNVZM9iRFcMvpMfZd3b9fJJOOu0zOpgSHqeZ9CN3xEqfstmmpMqOY
+fh6H/9QlMBfN4c6SJJ6Msw84cPzCJlBlpeWkhZBrX5f+nqnP8Q=
=tDoH
-----END PGP SIGNATURE-----

--nextPart2735896.mMySEnCET9--



