Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 25 Sep 2013 22:08:55 +0800
Message-ID: <5851825.cAHVtlsesn@diderot>
In-Reply-To: <1379857507-3878-1-git-send-email-antonio@meshcoding.com>
References: <1379857507-3878-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3654973.WcVWGFVJZ7";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH next] batman-adv: remove accidentally
	re-introduced unicast.c file
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
Cc: Antonio Quartulli <antonio@meshcoding.com>


--nextPart3654973.WcVWGFVJZ7
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 22 September 2013 15:45:07 Antonio Quartulli wrote:
> During the Fragmentation redesign the unicast.c file has
> been removed, but it seems that it has been accidentally
> re-introduced during a merge operation.
> Remove it again.
> 
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
>  unicast.c | 491
> -------------------------------------------------------------- 1 file
> changed, 491 deletions(-)
>  delete mode 100644 unicast.c

Applied in revision 4e1f729.

Thanks,
Marek

--nextPart3654973.WcVWGFVJZ7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQEcBAABAgAGBQJSQu6EAAoJEFNVTo/uthzAho0H+gO1M4A1gs+ACTO9/tlBZQi6
gXvqdrUBJ18VwQ5T2tMeIWYy3qOLnB78G/y5qtwTQR1TGqoIacrtkoJyd0IClRcP
O0MX3+Xq1KOAHiASWvEaKKpDtcL3uAMTGfp+V4joan7MZU5dsVP4WR4dyI0hpFBw
HAQI5a7aUfepQHSaeEEwq0o6gCQWHmeHoNZQOEpf7Wz0TcWOP3HtN/9x033hnDs7
RRSm3kfdtKzT3iIpC5e4ABgBx00/2AuGnSnkTHNBUYpTBiFiBnNXGCCDQVo6fgJ9
OGIFZbVBLBaGaIRRTkOahYEKead0ciTFvvkAA7UfIbxcxHDCD8dAmCTMc95X26E=
=U02N
-----END PGP SIGNATURE-----

--nextPart3654973.WcVWGFVJZ7--

