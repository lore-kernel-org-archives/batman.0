Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 11 Mar 2014 17:38:38 +0800
Message-ID: <2399069.dtMmaET4A5@diderot>
In-Reply-To: <1393336784-1094-1-git-send-email-antonio@meshcoding.com>
References: <1393336784-1094-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2383045.0qFQFSGVjb";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batctl: add isolation_mark support
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
Cc: Antonio Quartulli <antonio@open-mesh.com>, Antonio Quartulli <antonio@meshcoding.com>


--nextPart2383045.0qFQFSGVjb
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 25 February 2014 14:59:44 Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> With this patch it is now possible to set/unset the value
> of the isolation_mark used by the Extended Isolation feature
> in batman-adv.
> 
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
> 
> Change from v2:
> - added section in README
> 
> Change from v1:
> - added section in man page
> 
> 
>  README       | 13 +++++++++++++
>  man/batctl.8 | 20 ++++++++++++++++++++
>  sys.c        |  9 +++++++--
>  sys.h        |  1 +
>  4 files changed, 41 insertions(+), 2 deletions(-)

Applied in revision 6b36552.

Thanks,
Marek

--nextPart2383045.0qFQFSGVjb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTHtmiAAoJEFNVTo/uthzAV1AH/0jGwac+2D2Rg6mCyYYpe5j5
GPzyXgnjG23wnwp3h+B7v8h8xjN5hiz02BBB7lnKNiPwnB0PYatyJkVbhyDyNAhk
NnOSlBhxdVTqwMfeyhQoZgpB2ukpk2F1gSyCjtfPAEfL3JQnnfXma5fOiIH0+8N1
7XvDCyUpcZZXdj1+ldWeDuzPhHI2wHa/T3Fhp15f4ftRqG3Hu8f7x1S7VdfBG8Mv
r0QWPSfms0KkyPkHT8RX01Ta3EKztAiYGwBA+Mx+/iWkMwMucs/z4Da6+CF9EuPg
GiW9E6y4MSIzLAyQJAyqCZZX/SzhVK9+R0YLbw4vZyyxGzUEArSSkR7CXX1t4S4=
=Uq8s
-----END PGP SIGNATURE-----

--nextPart2383045.0qFQFSGVjb--

