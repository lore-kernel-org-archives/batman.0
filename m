Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Mon, 9 Sep 2013 19:20:47 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130909172047.GA12716@pandem0nium>
References: <1378741567-25152-1-git-send-email-sven@open-mesh.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <1378741567-25152-1-git-send-email-sven@open-mesh.com>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/7] alfred: Add missing includes and
 remove unused includes
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Mon, Sep 09, 2013 at 05:46:01PM +0200, Sven Eckelmann wrote:
> Signed-off-by: Sven Eckelmann <sven@open-mesh.com>
> ---
>  alfred.h       |  6 ++----
>  batadv_query.c | 13 +++++++++----
>  client.c       | 12 +++++-------
>  debugfs.c      | 10 ++++------
>  debugfs.h      |  3 ---
>  hash.c         |  5 +++--
>  main.c         | 11 ++++-------
>  netsock.c      | 14 ++++++++------
>  recv.c         | 21 ++++++++++++---------
>  send.c         | 17 ++++++-----------
>  server.c       | 10 ++++++----
>  unix_sock.c    | 14 +++++++++-----
>  util.c         |  6 ++++--
>  vis/vis.c      | 15 +++++++++++++++
>  vis/vis.h      | 20 +++-----------------
>  15 files changed, 90 insertions(+), 87 deletions(-)

Applied in revision 5599105.

Thanks,
	Simon

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlIuA28ACgkQrzg/fFk7axbxAwCfRh8Oq1h2dJ5omhV1E79LiD8T
tNYAn2ZnUn4QeC3TzLmBJRLPeKbPGstX
=LD8j
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
