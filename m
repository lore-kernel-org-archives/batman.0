Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 10 Mar 2016 20:41:53 +0100
Message-ID: <5227202.7FVSH1Kd65@bentobox>
In-Reply-To: <2c0e66fe07809e4069df34cbeba51583ad943c7a.1451317025.git.geliangtang@163.com>
References: <2c0e66fe07809e4069df34cbeba51583ad943c7a.1451317025.git.geliangtang@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart19437875.6Wmv8nMxkh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: use to_delayed_work
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
Cc: Geliang Tang <geliangtang@163.com>, Antonio Quartulli <a@unstable.cc>, Marek Lindner <mareklindner@neomailbox.ch>

--nextPart19437875.6Wmv8nMxkh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 28 December 2015 23:43:37 Geliang Tang wrote:
> Use to_delayed_work() instead of open-coding it.
> 
> Signed-off-by: Geliang Tang <geliangtang@163.com>
> ---
>  net/batman-adv/bridge_loop_avoidance.c | 2 +-
>  net/batman-adv/distributed-arp-table.c | 2 +-
>  net/batman-adv/network-coding.c        | 2 +-
>  net/batman-adv/originator.c            | 2 +-
>  net/batman-adv/send.c                  | 4 ++--
>  net/batman-adv/translation-table.c     | 2 +-
>  6 files changed, 7 insertions(+), 7 deletions(-)


Reviewed-by: Sven Eckelmann <sven@narfation.org>

@Marek, the compatibility code can be found at
https://git.open-mesh.org/batman-adv.git/patch/9122b42725c06a48dc222933722eb8b251335481


Kind regards,
	Sven
--nextPart19437875.6Wmv8nMxkh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW4c4BAAoJEF2HCgfBJntGJKEQAI7L9+GLtnGdrSK4S0NQGe2v
jKvT4k9n4IverAdc8WwsStpcH5qm/YpCsH83X0AM6jaq6fegC++sfJmWLv+91lhc
Z0Tbw1SAsqGovBkBv9ZIJ6//jN+C1vr2+pchPkLK3m3gpdq3V7Nzwq50XhBMENib
rqzYJkB/qvR77Jj2QvSXuGxky3mFJ/XSTpTIbSH3ibaM7FgHI+q8/DfzGKyIT44/
YcpgoicMmYv/c15K8UJNXTFQnQ9z9jS2MfrAaa3h5BCq0fCwChKEvpvJxtp04o5i
apBlH3zdfxVjm0/lU84u72vN3I15Se4o7zsjXtKcPoMfgiwYw2jBRa6/gjOiKdDS
CnCv/nNaKTwgpBx7hXWRoRwYfl+fn7XNuxcbMoIP1XkMoHQwT/751FjZp6YWHZug
N84t9oh4xaBB60Mvg3yWD7btniIWdtyh7bbjqoL1KvwHYGOTcT/B036KeKq7/fM8
OkQM//lvL82Cer3xYVadT6rPEKCJHxO38cxpNU2lTHq2JikHMS5CMqCqHp9cLS4a
BboSApn9kAnK9Xe8UeKWohn4OFjRfugrUKFuc485BQFQT3yayoFrtRTvDUeI+esu
5is+a6TMwUFciWTm1DMNU2d5PWXFh+5HE44irQFA2dCz0YKqyXfbW95CktT8OSPl
gDmp9ipkqFeqpxi/t7dO
=3uXm
-----END PGP SIGNATURE-----

--nextPart19437875.6Wmv8nMxkh--

