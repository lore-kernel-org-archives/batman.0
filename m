Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 21 Apr 2015 11:46:51 +0800
Message-ID: <1595618.4CGjfVRuAA@voltaire>
In-Reply-To: <1429292430-30883-2-git-send-email-sven@narfation.org>
References: <1429292430-30883-1-git-send-email-sven@narfation.org>
 <1429292430-30883-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8217898.gWilCCNH7t";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 2/4] batman-adv: Add required to
	includes to all files
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


--nextPart8217898.gWilCCNH7t
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, April 17, 2015 19:40:28 Sven Eckelmann wrote:
> The header files could not be build indepdent from each other. This is
> happened because headers didn't include the files for things they've used.
> This was problematic because the success of a build depended on the
> knowledge about the right order of local includes.
> 
> Also source files were not including everything they've used explicitly.
> Instead they required that transitive includes are always stable. This is
> problematic because some transitive includes are not obvious, depend on
> config settings and may not be stable in the future.
> 
> The order for include blocks are:
> 
>  * primary headers (main.h and the *.h file of a *.c file)
>  * global linux headers
>  * required local headers
>  * extra forward declarations for pointers in function/struct declarations
> 
> The only exceptions are linux/bitops.h and linux/if_ether.h in packet.h.
> This header file is shared with userspace applications like batctl and must
> therefore build together with userspace applications. The header
> linux/bitops.h is not part of the uapi headers and linux/if_ether.h
> conflicts with the musl implementation of netinet/if_ether.h. The
> maintainers rejected the use of __KERNEL__ preprocessor checks and thus
> these two headers are only in main.h. All files using packet.h first have
> to include main.h to work correctly.
> 
> Reported-by: Markus Pargmann <mpa@pengutronix.de>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Applied in revision 960339d.

Thanks,
Marek

--nextPart8217898.gWilCCNH7t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVNcgrAAoJEFNVTo/uthzAa2cH/28bQfn5Dok/3qfpV/HEsFhm
ibze3ErWGp1bAgZqcQ7eLawgvxvvQ5CSSzabh96L5cCdGXwq6kPuZONXUtgE/Khp
sYehuxyJ5hhX0gy/SmAiIRfModBkZvEzvl980fF2X5jWDRdefqTUpfDiOQkighuZ
PeqCUvvYas7mkZ9Uke7kv7iw04peaJKoznbLeUMUzAKlg/y7OGJKgO5hEF9n7Qwz
1ABKx7HsrZIIPFGiQg58GKHnLFWnbZTKaspNQnlkCxY5wh4XQi3I25XKXtvS66DX
v4mpZtdiqTcAUj/nF49nKIohh2TvsPCpSPrdhhheAkbvBNL5i2f9jX7zzLGUNYc=
=ppHA
-----END PGP SIGNATURE-----

--nextPart8217898.gWilCCNH7t--

