Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 13 Mar 2014 03:26:53 +0800
Message-ID: <2462997.Puq7G52ro9@diderot>
In-Reply-To: <1394640288-1611-2-git-send-email-sw@simonwunderlich.de>
References: <1394640288-1611-1-git-send-email-sw@simonwunderlich.de>
 <1394640288-1611-2-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8830207.1n1JDWr7Wz";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH-next v3 2/2] batctl: add option for
	multiif orig table
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
Cc: Simon Wunderlich <simon@open-mesh.com>


--nextPart8830207.1n1JDWr7Wz
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 12 March 2014 17:04:48 Simon Wunderlich wrote:
> From: Simon Wunderlich <simon@open-mesh.com>
> 
> This patch adds batctl support for the recently introduced mesh wide
> multi interface optimization in batman-adv.
> 
> Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
> ---
> Changes to PATCHv1:
> 
>  * check if the supplied interface actually belongs to the interface
>  * add README and manpage descriptions
> ---
>  README       |   25 +++++++++++++++++++++++++
>  debug.c      |   32 ++++++++++++++++++++++++++------
>  man/batctl.8 |    4 +++-
>  sys.c        |   28 ++++++++++++++++++++++++++++
>  sys.h        |    1 +
>  5 files changed, 83 insertions(+), 7 deletions(-)

Applied in revision 62f87ce.

Thanks,
Marek

--nextPart8830207.1n1JDWr7Wz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTILT9AAoJEFNVTo/uthzAOu8H/iFvZc95L08MCzYeS7Y1WZC+
Z1/kvVN8p2fC9DLd0ycVPaXchJSdjlp+qou+ZWdVY18mpROwMwFvUB5m16LzH1dM
Y7nZS6yOgz3mBMKNB9s0A11JIkXSn6l9uk5qwAdF8NBz+TCAW/mwTP2pZhIQhrK4
DVoFSAEtAPeUAgGjC9nW2Y1TVlFwEurjMOMznRCXzMwBSu5YpfnYkeDUaezOFYTj
3lOAkdlsW29c6g1jaebej1WRy568nEslvPAhscluu0vpPMDuaOkvQeWDVHO+WdC5
u2+krOXgy07sQN6aHYiRROz8+ejJrcq7jpbyG6L9U2lsUVdBLqvxpwzBNkS1DNE=
=aT8o
-----END PGP SIGNATURE-----

--nextPart8830207.1n1JDWr7Wz--

