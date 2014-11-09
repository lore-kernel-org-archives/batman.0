Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 09 Nov 2014 12:34:43 +0800
Message-ID: <3288757.dWnlOAcrMJ@diderot>
In-Reply-To: <1415052979-11108-1-git-send-email-sven@narfation.org>
References: <1415052979-11108-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8380302.UpVXcQpQCc";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix double fetch in RCU
	version of hlist_*entry*
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
Cc: Sven Eckelmann <sven@narfation.org>


--nextPart8380302.UpVXcQpQCc
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 03 November 2014 23:16:19 Sven Eckelmann wrote:
> The backported (<3.9) version of hlist_for_each_entry_rcu and
> hlist_for_each_entry_safe uses the new macro hlist_entry_safe. It is called
> with an ACCESS_ONCE parameter for the first parameter ptr. This disallows
> merging of the two loads which the current version of the macro uses.
> 
> This is problematic because this macro must only generate one load.
> Otherwise with two contexts (or CPUs) following could happen:
> 
> 1. context 1 fetches the ptr to the last entry in hlist_entry_safe() and
>    accepts this non-NULL ptr
> 
> 2. context 2 deletes the last entry and terminates the list with NULL
> 
> 3. context 1 re-fetches the pointer, doesn't check for zero, calculates the
>    entry based on a NULL pointer
> 
> 4. context 1 crashes because it tries to load/write data from/to the invalid
> address
> 
> Instead use a single load to a temporary variable and do the NULL-check and
> calculation based on that one.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  compat.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Great find! Applied in revision 1e4a96a.

Thanks,
Marek

--nextPart8380302.UpVXcQpQCc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJUXu7jAAoJEFNVTo/uthzAa0wIAI++blwntbBp6mQYPi9dYJdR
qYwe6sMsDirWN6vrynzTgi8Dnu2KGeiAsyd1rcMbUVWecVTsehORoOORLKqsFutO
+QEsS+9tSHm4mConLgcDU3joeO/R/C/FsNZMf7OuH0eeWRPoOX/BZXUgLBzGTJn2
qWlDfHHMzqE2h/o0tUt5BzczDEgdPSAJjIyV1poHKHlgmu8+LB/lkZVouoahIeH9
fxbkQ3KI2nb5nfYdxj5LERR8nuQoOYP5/LibFJLxKwmlj1pYQkFzPH/0NnakZD21
og1SBkuu8U74d6cMJ5BOwGtg8kOPhaMKLqi+2NHzaFp6fJ6/Jg/Blj7YGUwustg=
=bvtW
-----END PGP SIGNATURE-----

--nextPart8380302.UpVXcQpQCc--

