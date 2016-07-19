Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 19 Jul 2016 16:46:58 +0800
Message-ID: <1837621.1vu7PgLI7x@voltaire>
In-Reply-To: <1468597173-25378-18-git-send-email-sven@narfation.org>
References: <1468597173-25378-1-git-send-email-sven@narfation.org>
 <1468597173-25378-18-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1550965.AYJX8pX26z";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 18/18] batman-adv: Place kref_get for
	tvlv_handler near use
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

--nextPart1550965.AYJX8pX26z
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, July 15, 2016 17:39:33 Sven Eckelmann wrote:
> It is hard to understand why the refcnt is increased when it isn't done
> near the actual place the new reference is used. So using kref_get right
> before the place which requires the reference and in the same function
> helps to avoid accidental problems causedy incorrect reference counting.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v2:
>  - split patch based on type
> 
>  net/batman-adv/tvlv.c | 4 ++++
>  1 file changed, 4 insertions(+)

Applied in revision 95136e0.

Thanks,
Marek

--nextPart1550965.AYJX8pX26z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXjekCAAoJEFNVTo/uthzAN08H/0SAQLF8CCuzKpfZehTyCgji
CNStpeZ25rvMmLha+sBhzUUZ01iijh32JrUnWW31OKB/SmGbn/QEJxWmU619/4I6
n0vSpXjkenyZDQZNMoEEDjQIIuqVEWoac6v5A0Z76XZYdyGGZ54SuX2Uoquo53Uw
DdgkZZdh+RSqvOQlnX60taYw7Cmv+5JsyAFqOddbm3r0xqrqFb2NXtu64ePCzP/z
3J6tCNa7BMiPl13FE6hThrsZfqL/O96B0tSNozfYQQrSGMVRFT4xnrwHcLxtcbtM
Ro0zFBCyAg4mVnbIs2vnfDDyeUlkvQzCIBuWb43i9xbl1f4IIM4QYI+rNtsBxYw=
=3p7+
-----END PGP SIGNATURE-----

--nextPart1550965.AYJX8pX26z--

