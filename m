Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 21 Apr 2015 11:52:16 +0800
Message-ID: <2239102.H9P5JOuLU8@voltaire>
In-Reply-To: <1429292430-30883-4-git-send-email-sven@narfation.org>
References: <1429292430-30883-1-git-send-email-sven@narfation.org>
 <1429292430-30883-4-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8562284.0zxEU9Ntl3";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 4/4] batman-adv: Automatically create
	nested kfree_rcu helper functions
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


--nextPart8562284.0zxEU9Ntl3
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, April 17, 2015 19:40:30 Sven Eckelmann wrote:
> The kfree_rcu compat helper for old kernels require a special function that
> knows how to calculate the offsets to the actual data pointer to call kfree.
> These can either be manually provided or the GCC extension for nested
> functions can be used to automatically create a local function using a
> macro.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v4:
>  * rebased on top of master with merged patches from 
>    https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2015-April/012985.html
> v3: no change
> v2: no change
> 
>  Makefile                        |   1 -
>  compat-include/linux/rcupdate.h |  15 +++++
>  compat.c                        | 120
> ----------------------------------------
> compat.h                        |  20 -------
>  4 files changed, 15 insertions(+), 141 deletions(-)
>  delete mode 100644 compat.c

Applied in revision 082c888.

Thanks,
Marek

--nextPart8562284.0zxEU9Ntl3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVNclwAAoJEFNVTo/uthzAolkH/jtfAd92T4znXvkxw1tKLN+/
z0B9vbCdWc0LX4Ge4u8GqjlxdhwJBhLccB22n+cXD4Bik/4v18JByZVROjsTIoz4
QZwHGkDFS18v7kgmQJD4xoLIb5yXXxmAXaIvJhCBf3DS2oNaYsgRWQ3AKAQi17e+
NP5BuXn3IUh8F9iJn51udJA48b3U9MldP2YfPPuJ7xr1DdUjmsuYSrFwc6Zgk4um
MsQSrs3lINavf1oRPLLOKO97cBEODyzYsdQwOlyIagISB1jKrPkRGdoWVaWoWkNs
ekuGNdDxXusMO2xr6GRwGjiRTAelZEIqq0dRSlva6jW0fNzcVTHw1c/MBM/Przk=
=8TCC
-----END PGP SIGNATURE-----

--nextPart8562284.0zxEU9Ntl3--

