Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 18 Mar 2015 20:17:26 +0100
Message-ID: <1970447.8TMetPNtZg@sven-edge>
In-Reply-To: <1426579875-28365-1-git-send-email-anatoliy.lapitskiy@gmail.com>
References: <1426579875-28365-1-git-send-email-anatoliy.lapitskiy@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart11891795.K8ncUhfoCt";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v5] alfred: Add "--update-command"
	parameter
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


--nextPart11891795.K8ncUhfoCt
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 17 March 2015 10:11:15 Anatoliy Lapitskiy wrote:
> The "--update-command" parameter is created for adding a hook to run when
> new information is received.
> 
> At the moment "alfred-facters" are run by cron once per every 5 minutes.
> For some tasks (like sharing dhcp leases) it can be too slow.
> 
> Signed-off-by: Anatoliy Lapitskiy <anatoliy.lapitskiy@gmail.com>
> ---
>  alfred.h     | 11 +++++++++
>  main.c       | 12 +++++++++-
>  man/alfred.8 |  4 ++++
>  recv.c       | 10 ++++++++
>  server.c     | 74
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 5 files
> changed, 110 insertions(+), 1 deletion(-)

Reviewed-by: Sven Eckelmann <sven@narfation.org>

Thanks for your contribution

Kind regards,
	Sven
--nextPart11891795.K8ncUhfoCt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJVCc9JAAoJEF2HCgfBJntGNkYP/1yVCxbwGbYaCevP6G01Q1yE
Qk3q1mBroEZJdPzIwVQH/OC75IK7k0gGCOcqMbHBPQEPQBnNA/Q0r8vQEeALZR+m
v8xxOZIk53L6xsoikJ96BhTebGNYzCvS9wNEH8CTL0qHIsR+OmI4ko5e6OXNB1zX
3tm44M4v1LX5uqlR72hrgqzgjy5bZLBICzvoqGKSIzbDfRWR+sbpaUTkRsxlnnPK
64hPDvXSCvpLo2p2foUFLnk16LQnyDddYa4vUGF0AfV/y9+HFmtHOv9TxUCrcQxG
pc6MQl5Ly1IsydO0a/vpttdtpT/jJC9l+XLBe964w9B1ngHSKZvTSgu30rvdMNyp
nkiaKQY0/Bcnn5LGyGu3r2VXXmBNjR62o4G5X3rNUy9VgHOke02ueStP8sWbmI25
b2IV2GI31/Zy0wp6RKlWLwBIhyqQjBLiXzI0VDRT5rB0VU0VmMgnqXe8mWik1OoZ
WuqNevEh+rPDLCGjMazZJNq4SLQnJgzFniZaweDqio4ST2tCCjGpXIAQJAv/e29A
0lMMH+Q1VQRnWanqrQ0E2aNhd+ul6Vlivyb+jzIFeffalMEuF7wzJroboxH3jKP1
UGHHYS618QbjF83zib1srhkrpa63RjPB/zaFpU5j2vrWptY2cckTOSUEwPIu9BJF
Ww8IPmChXOGh9wG9etau
=fMdn
-----END PGP SIGNATURE-----

--nextPart11891795.K8ncUhfoCt--

