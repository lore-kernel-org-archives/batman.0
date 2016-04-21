Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 21 Apr 2016 18:59:30 +0800
Message-ID: <2420713.kR2VLxGM4I@voltaire>
In-Reply-To: <1461236247-22642-1-git-send-email-sven@narfation.org>
References: <1461236247-22642-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1528340.rzZ7FPBex7";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v4] batman-adv: Create batman soft
	interfaces within correct netns.
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

--nextPart1528340.rzZ7FPBex7
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, April 21, 2016 12:57:27 Sven Eckelmann wrote:
> From: Andrew Lunn <andrew@lunn.ch>
> 
> When creating a soft interface, create it in the same netns as the
> hard interface. Replace all references to init_net with the correct
> name space for the interface being manipulated.
> 
> Suggested-by: Daniel Ehlers <danielehlers@mindeye.net>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Acked-by: Antonio Quartulli <a@unstable.cc>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v4: rebase on current master
> 
>  net/batman-adv/hard-interface.c    | 10 +++++-----
>  net/batman-adv/hard-interface.h    |  3 ++-
>  net/batman-adv/soft-interface.c    |  7 +++++--
>  net/batman-adv/soft-interface.h    |  3 ++-
>  net/batman-adv/sysfs.c             |  3 ++-
>  net/batman-adv/translation-table.c |  4 ++--
>  6 files changed, 18 insertions(+), 12 deletions(-)

Applied in revision ecfa261.

Thanks,
Marek

--nextPart1528340.rzZ7FPBex7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXGLKSAAoJEFNVTo/uthzAiB4IAINWDj7ZlnVvwZsiZLyzjAuJ
b2AjKSPypddaRpeIqAzZAfQiOUqYL+YJtiAkHYBg1GK0p39wvKI1EttOP4Iw5Vli
F+g6x/bjqFyjhMb5eZC7696XA6Rs8I5ltmFrlYQmG69ULBZGPMGik/f4TUahgl6r
TLUxf3dMTuYnGOIXGUw+VERH4YqjEaanHTKpYfuT/kVMQe1xsqxRzla2S5c3ND0E
6H74EY/9eW84Lnqfzwra5CHYCX6IaWDZTL/Re1CpOfzewXZRXcq6I5TpQTRbVe5s
WzY7gHytFtw3gX36sO3oK6Si9g6YhW541XP6lzMwSvHqIMOb7xXFtPreD4Ru68k=
=ICx4
-----END PGP SIGNATURE-----

--nextPart1528340.rzZ7FPBex7--

