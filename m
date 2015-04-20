Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 20 Apr 2015 23:23:09 +0800
Message-ID: <1442946.1AUKn4CUEG@voltaire>
In-Reply-To: <553507F1.1010606@meshcoding.com>
References: <1429288461-26260-5-git-send-email-sven@narfation.org>
 <1429291088-27181-1-git-send-email-sven@narfation.org>
 <553507F1.1010606@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8410953.Qq0nleNzmx";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH-nextv2 5/6] batman-adv: Revert "fix var
	name to keep compatibility with old kernels"
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Sven Eckelmann <sven@narfation.org>


--nextPart8410953.Qq0nleNzmx
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, April 20, 2015 16:06:41 Antonio Quartulli wrote:
> On 17/04/15 19:18, Sven Eckelmann wrote:
> > The original patch b53915310227cc9b029ba0fa5aae44e50a461f80 should not be
> > submitted to net-next. It can be better implemented using compat code.
> >
> > 
> >
> > Signed-off-by: Sven Eckelmann <sven@narfation.org>
> 
> Acked-by: Antonio Quartulli <antonio@meshcoding.com>

Applied in revision e78c16c.

Thanks,
Marek

--nextPart8410953.Qq0nleNzmx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVNRnhAAoJEFNVTo/uthzAtxgH/1luuNpJR/O+hiZqMfiqVad1
9vNBgV35jqr2dfX9Q0VwFR7x3KvQrwm9Zoj3q52kjr8dAwnDzZUJUtSwqfgBKyFj
C2tnI9y7TNSy0wKCKm8Q8kfinZbfx9GRcPG7ZY3lvo5FiLuFipisw6lbPa6AZ7Yt
3UJDnFLzWB6UQzL8ztNeohJQOrfax2u/UyCxKTSvFKugPIMsPvC1nXm58X0D2fbm
hootvB43vvllA2dsILa/SIh/CGBhb4vwaW1S5y+nNqRO3Tq+2Icb+w8SnKOvK7u0
F0mY0tieZYPTU0acJrmF/HqOQT2qUXNu3HL1Az4SdLgzKh7MSFO1ErcnbmmqWnA=
=YRQO
-----END PGP SIGNATURE-----

--nextPart8410953.Qq0nleNzmx--

