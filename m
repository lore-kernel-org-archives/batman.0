Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 12 Jun 2014 17:48:29 +0800
Message-ID: <2316167.xuFsC4suZi@diderot>
In-Reply-To: <538314FE.9020808@mindeye.net>
References: <538314FE.9020808@mindeye.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2911590.8bP3rU6bQe";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Init and use batman
	interface with correc netns.
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


--nextPart2911590.8bP3rU6bQe
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 26 May 2014 12:18:38 Daniel Ehlers wrote:
> Enables us to use batman-adv inside of network namespaces.
> Unfortunately it does not enable us to use multiple batX interfaces
> in different namespaces. This limitation results from using
> debugfs and its unawareness of namespaces.
> 
> Signed-off-by: Daniel Ehlers <danielehlers@mindeye.net>
> ---
>  hard-interface.c    | 10 ++++++----
>  hard-interface.h    |  2 +-
>  soft-interface.c    |  8 ++++++--
>  soft-interface.h    |  2 +-
>  sysfs.c             |  4 +++-
>  translation-table.c |  4 +++-
>  6 files changed, 20 insertions(+), 10 deletions(-)

Would you mind re-sending both patches while cc'ing the netdev list and 
specifically asking for reviews from the namespace people ? None of us has any 
experience with netns. As such a meaningful review is difficult for us.

Furthermore, your commit message should be more explicit about what the patch 
is trying to fix / improve. Things like 'issue #179' are too vague to be 
understandable by everyone.

Thanks,
Marek

--nextPart2911590.8bP3rU6bQe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJTmXdxAAoJEFNVTo/uthzAFUUIALCnhtBpBLd6QlqwIN3m81ws
jRKxf/TGmtSnCXlZm0K1bPsKRUhDDt2U7lOkRe8dbNxAPhavlqdm66MFuv5J9GQ2
T/Owxu5aCkAKWLW1QuJOrHRtGuavIyM3mczQbWSRMNUXf1jgornvcFMMgDAtBDKI
R7Gu20TKsV4f3eAl0I/JpaRfTeVPm9X0kJdVemKjO4cmYw7tiGJrSKjzPsdXM1DW
dbJxF1Dcbt3FOfU3r2tCxoqXuobStJEag9rLaSd0L3XJrL/Ri/VOMrsQc70y4q1a
rN/xlmKgDWr1+p+Dge66YLg1qZhvXXgNHeX6/BI9MIkzGrFigL013Wn5WcZ2bXA=
=1527
-----END PGP SIGNATURE-----

--nextPart2911590.8bP3rU6bQe--

