Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 20 May 2016 17:50:49 +0800
Message-ID: <6573732.RtTdeoGNuy@voltaire>
In-Reply-To: <1463564330-11178-3-git-send-email-sven.eckelmann@open-mesh.com>
References: <4816418.hDXNbSuFUQ@bentobox>
 <1463564330-11178-3-git-send-email-sven.eckelmann@open-mesh.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1578736.0ZLWpcHUL3";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v11] batctl: introduce throughput meter
	support
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
Cc: Sven Eckelmann <sven.eckelmann@open-mesh.com>

--nextPart1578736.0ZLWpcHUL3
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, May 18, 2016 11:38:50 Sven Eckelmann wrote:
> From: Antonio Quartulli <antonio.quartulli@open-mesh.com>
> 
> Add command to launch the throughput meter test. The throughput meter is a
> batman kernelspace tool for throughput measurements. The syntax is:
> 
>     batctl tp <MAC>
> 
> The test is interruptible with SIGINT or SIGTERM; if the test succeeds with
> no error the throughput and the elapsed time are printed to stdout,
> otherwise occurred an error message is displayed (on stdout) accordingly.
> 
> Based on a prototype from Edo Monticelli <montik@autistici.org>
> 
> Signed-off-by: Antonio Quartulli <antonio.quartulli@open-mesh.com>
> Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
> ---
> v11:
>  * introduce new attribute BATADV_ATTR_PAD used for u64 alignment
> v10:
>  * fix "a a" typo in batman_adv.h
> v9:
>  * rebase on top of current master
>  * added include guards to tp_meter.h
>  * imported newest batman_adv.h and packet.h from batman-adv
>  * move iw/genl.c functions into own file "genl.c"
>  * adjust result handling based on new BATADV_TP_REASON_* names
> v8:
>  * rebase on top of current master
> ---
>  Makefile     |   2 +
>  batman_adv.h |  43 +++++
>  genl.c       | 140 ++++++++++++++++
>  genl.h       |  31 ++++
>  main.c       |   6 +
>  main.h       |   2 +
>  man/batctl.8 |  24 ++-
>  netlink.c    |   8 +
>  packet.h     |  54 ++++++
>  tcpdump.c    |  14 +-
>  tp_meter.c   | 540
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> tp_meter.h   |  27 +++
>  12 files changed, 888 insertions(+), 3 deletions(-)
>  create mode 100644 genl.c
>  create mode 100644 genl.h
>  create mode 100644 tp_meter.c
>  create mode 100644 tp_meter.h

Applied in revision f109b34.

Thanks,
Marek

--nextPart1578736.0ZLWpcHUL3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXPt35AAoJEFNVTo/uthzA6WkH/A7BEktDJr2H0EGD4X9RaDLI
6cqsBjZokaEJjIyN6EmB3r3XU3Es3lcVrrAOTNN1FFoloEQPBdS6yjxLd3jPfYCG
XJ4Bv21eOJRAVPCBsQ/nx29hjpVDvqlCO4ygGuO7LpI8NDFbx8L1haQZwPw314Na
phSU0pt3a30jhD1K8E/HsXWLIhHtrPD99/rp8c5N5/Rwn2FJ3JzwoZ9kf5d9YINY
BAqxapafTvGl8tK/sZJis56E1/N6+2Kc1zKt16T9bhAhbsw2hL8++SGy04xtUJ3/
aAGmGxSxPGK2wX5ndnhqJ/meczg1h2CtFzvjzaTmtP7ALoCF1e7KPJSk4UyWZSw=
=hptZ
-----END PGP SIGNATURE-----

--nextPart1578736.0ZLWpcHUL3--

