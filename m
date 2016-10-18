Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 18 Oct 2016 14:45:16 +0200
Message-ID: <2346332.VUBNa2cukX@bentobox>
In-Reply-To: <1469400164-14302-1-git-send-email-sven@narfation.org>
References: <1469400164-14302-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6745568.5H5Q1fjp1y";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] batman-adv: Remove needless init of variables on
	stack
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

--nextPart6745568.5H5Q1fjp1y
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Montag, 25. Juli 2016 00:42:44 CEST Sven Eckelmann wrote:
> Some variables are overwritten immediatelly in a functions. These don't
> have to be initialized to a specific value on the stack because the value
> will be overwritten before they will be used anywhere.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/bat_v.c          | 2 +-
>  net/batman-adv/bat_v_ogm.c      | 4 ++--
>  net/batman-adv/gateway_client.c | 2 +-
>  net/batman-adv/originator.c     | 8 ++++----
>  net/batman-adv/send.c           | 2 +-
>  5 files changed, 9 insertions(+), 9 deletions(-)

Applied in c19f30162bec891ce2eefd405b8a71023c155fb4 [1].

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/c19f30162bec891ce2eefd405b8a71023c155fb4
--nextPart6745568.5H5Q1fjp1y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYBhlcAAoJEF2HCgfBJntG73kP/RAESD0kidzvUiH2h2aN3NCD
p004GD4wWO/j6U0q2ixvepxzO5IgtP5d+gXGIaF8u9YiqHnbs/03oKvHIu4yA3w7
53sC5x4/qyHuIfSNEKL7Ut4D4U9Hmk21w/yscIDsQEa0g0GEhXQ2k1EPXz3UpnSz
i9qFLHtnoCeq9wCmdd206r03C7jS5P4wgmyRNVyQ39lT5DLMraISy6nHH3aT0eb/
C0cfldzzS/yM2/xhis9bOP4v9fO3oq3XNskmWFEvb2stQWPNco/azKTVHx7Cj6tD
gNOhkrhLe3eLyYbwTD9sLKV19cX+MXKWvHDq6sGE1Vdjiv5XZYWyTeq8P7rieyrP
W0ATNPCrC39P8H9WNd2JuGiV5jObvNxe5WGT8N7RUmjMluadMDujz1cNnesvt4q4
Tj7P0LSgt6bbnCd8Rtp33TbHZGCIhNALO0TiLNGuNTIxUfBJspwdvLrMDw//fOIE
3cFVpmdHz4mLHxXwSazSTRbYt3rL0MhfrkKqfkweEHqDuyPRGENYp3S9pg9GiAkU
CpZMNm+0dZgyIqmCAXrLd3glDRqnsrwv9q8lb2e6cf/EKdsTyiXwGwL2f0qjD4rb
fv44rIutR1t3YeQ8DTBwJKVLSWYUFTGjcPg254GnhIpCgog5dWYDI46pGjdFD7DN
0SdaQO/SNsEYbiOH6T8d
=2hRV
-----END PGP SIGNATURE-----

--nextPart6745568.5H5Q1fjp1y--

