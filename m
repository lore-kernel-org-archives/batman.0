Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 20 May 2016 17:18 +0800
Message-ID: <1775550.188aGoLO2j@voltaire>
In-Reply-To: <1463303266-25979-6-git-send-email-sven@narfation.org>
References: <1463303266-25979-1-git-send-email-sven@narfation.org>
 <1463303266-25979-6-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart26148026.IQ5NBpBozH";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v3 6/6] batman-adv: Fix bat_(iv|v)
	function declaration header
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

--nextPart26148026.IQ5NBpBozH
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, May 15, 2016 11:07:46 Sven Eckelmann wrote:
> The bat_algo.h had some functions declared which were not part of the
> bat_algo.c file. These are instead stored in bat_v.c and bat_iv_ogm.c. The
> declaration should therefore be also in bat_v.h and bat_iv_ogm,h to make
> them easier to find.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v3:
>  - introduce this patch
> ---
>  net/batman-adv/bat_algo.h          | 26 ---------------------
>  net/batman-adv/bat_iv_ogm.c        |  3 ++-
>  net/batman-adv/bat_iv_ogm.h        | 25 ++++++++++++++++++++
>  net/batman-adv/bat_v.c             |  3 ++-
>  net/batman-adv/bat_v.h             | 47
> ++++++++++++++++++++++++++++++++++++++
> net/batman-adv/main.c              |  2 ++
>  net/batman-adv/routing.c           |  1 -
>  net/batman-adv/translation-table.c |  1 -
>  8 files changed, 78 insertions(+), 30 deletions(-)
>  create mode 100644 net/batman-adv/bat_iv_ogm.h
>  create mode 100644 net/batman-adv/bat_v.h

Applied in revision 1373a7e.

Thanks,
Marek

--nextPart26148026.IQ5NBpBozH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXPtZIAAoJEFNVTo/uthzAT6UIAKlUssF1DMdjiOZZGWbif5Wt
cnCa0Yn19mpo1Z80BMHC5QtCYxFkxCJ1UX0XFOZ+g/la/2AVSFDgJfoAWUgm9nUe
qFPZl3C6879QVSipwBsW1lUNnCDMu2atZUS9J9EGFACAk6XJS+cTxgvXpBjdgQEt
nSrvoXLRcy38ZCS02E/8bW0VXF4J9D0D45H3pQOXoT0XImRJvtOt3dwHshZjGtY5
kXOuWZLoxPZAY+CKvSEZLU5bHZgm1NmZGd9ZS7Vx0p9DDI48L/jEvnR8SQetMkX0
4NMpEFkuj+GuVsTmTGgN+7REH2o1AkH+9J8Z8+cQZ2h88ICjF8Z5Vg7TkT1GEKU=
=yuja
-----END PGP SIGNATURE-----

--nextPart26148026.IQ5NBpBozH--

