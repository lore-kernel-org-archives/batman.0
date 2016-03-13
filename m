Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 13 Mar 2016 16:59:29 +0100
Message-ID: <14881482.2n7yHkSbWu@sven-edge>
In-Reply-To: <20160313153808.GC9674@lunn.ch>
References: <1456867148-31883-1-git-send-email-andrew@lunn.ch>
 <42883547.GmOm9E46Iz@sven-edge> <20160313153808.GC9674@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1816143.Ss09DpFtpG";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 3/4] batman-adv: Handle parent
	interfaces in a different netns
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>

--nextPart1816143.Ss09DpFtpG
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 13 March 2016 16:38:08 Andrew Lunn wrote:
[...]
> > My proposal is there to move this in an extra function [1] so adding
> > compat
> > code is easier [2].
[...] 
> Do you want to squash your compact changes in and add your own
> Signed-off-by?

You mean that I should finish the proposal [1] from Friday and resent it 
together with (slightly) polished versions of your patches?

Yes, I can do that. Not sure if I will do it tonight or tomorrow. But you 
should see the new patches (v3) soon on the mailing list.

Kind regards,
	Sven

[1] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2016-March/014661.html

--nextPart1816143.Ss09DpFtpG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW5Y5hAAoJEF2HCgfBJntGJpIP/iHc3gzWZNJ2WGwdvD6hLIui
xgiV4dvdsB0bwhlDr42xhNuAfewmHlY3rMW8TDzLqWXcaqxw/PTnuCqw+n3a8UXk
dr/N+ZUh17qVB3KTtu0IbfTCRFxlGpu0jIx+IHas7DdetLhVgwCXQCO1uhUOw9uV
5Nu8zWtcranU77HkIdQuPIzecjUiVCppSlvqRog7B32sUCO/2FWFdhqGjFwKaAEK
aK1SlMlkHs8qQOpS5znotpjRRhuNDUUidCmhMCYS5s4D+hRRSdeQhKosBDJB3H+w
TDXBOLYglYTUFK6kfpkHafHHC53IskcbtwaW2YYLRcky7khX96Ggw++nkP5wkMmz
up8OZcyUSPVpH1qmnBdFgTvy9pnkViUMi8M/U53PeudLE//1t2bgJi1lZYJoMZqD
l0PiS2i2zDXk/FXtKBBjtkf7Gd4zu6lT/n0mtPqB1PQJDlB3l50KdQzrOxsCYmIw
Mz8btwWxzvd+duhqH9V8NVmIcX7SUbO4ZYFBYXOCWhWJ6ZA2wnblGfiUmQTkPWWq
D/CpG5AuPWCnlffZeQRH+kEOZaX4zKiClDl2h0y+ZT9yOxe7yH3vxPruvMW+6CvZ
KbA5wd2nYMmPFWPMMeEioAgTgdAF0W9VX/ReYsnZ28iYOxkKB/STuAmLt5+CYl3A
PaCHpRt0Rh3Hvew6mDHy
=rVoi
-----END PGP SIGNATURE-----

--nextPart1816143.Ss09DpFtpG--

