Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 23 Jun 2016 12:53:35 +0200
Message-ID: <9404219.qzAPb65udo@bentobox>
In-Reply-To: <CAM3k=84yf5iiZqYrzTK2cSwJGM8cmRH4Vf9cJxthz4Lp3dowCg@mail.gmail.com>
References: <CAM3k=84krmoLaW2X59VujDb_ZxuMJW-6pwGDhDLx=0-HHG6O=Q@mail.gmail.com>
 <1556113.sacdk50hyr@bentobox>
 <CAM3k=84yf5iiZqYrzTK2cSwJGM8cmRH4Vf9cJxthz4Lp3dowCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2106704.84RSoyRpKn";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Adhoc0 Interface not showing up
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sailash Moirangthem <sailashm@gmail.com>, b.a.t.m.a.n@lists.open-mesh.org

--nextPart2106704.84RSoyRpKn
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

[Please don't remove b.a.t.m.a.n@lists.open-mesh.org without
giving a reason. I nearly only replied to you instead to
the mailing list]

On Thursday 23 June 2016 16:13:11 Sailash Moirangthem wrote:
> Please check the results of the commands.

"ip link" shows that the adhoc0 interface is down. Please make
sure that the interface goes up. This is now definitely an
OpenWrt+wifi driver question and not related to batman-adv.

The interface combination [1] is showing only
"#{ managed, AP, mesh point } <= 8,". So you can try to
deactivate your AP interface in /etc/config/wireless. Make
sure that you only see the adhoc0 interface in `iw dev`
after you've restarted the wifi.

Kind regards,
	Sven

[1] https://www.kernel.org/doc/htmldocs/80211/API-struct-ieee80211-iface-combination.html

--nextPart2106704.84RSoyRpKn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXa7+vAAoJEF2HCgfBJntGgUMP/14WSUSBJ5Gb5lgrQe3X/TSc
RQcjLwzkxVi8hfVCLf+ZqpcRYR1go/SPdYPz4cd0CETHeHkUaIVgVdSDJ526o2yx
sdzqahZDKLP+ixMAEeMC77yZBgzIXzsHSG3fNGZfL5hwsYumoCT+mUMou+yCUyNu
cmlZZFvryHTnn5nxOLj7Jlpzl+Uadz6nkTodwuM2F1+v6Ps+1Vef+SalRXc/7jf/
GpXnh9+tG5uvYu2RkhTf55cBAa2t7ivwzYV+zau9vJ/8t3+O2xVLYYB3JFHVTXaL
zJacVP1NnLNl8QxqQrckcbHgdra5tke3eiPTPk64EjKqZRBoXfbWfk3UcT8Rlg9G
YyfyYVwOLYjaHt+7Q9hG9krd5QJzyoKb7CzDU018t5sJ/iNfa41oh4aU08fpT7Qy
PqFQv5IdisAeTdat1rdpC27fnCMb1dkEvHDXw6LDgKUGcQZvOSs1rRXzEiW/iSca
9Nk9KT/7cgDkBFpQD840E36x+/iVas28K1Og+tJSZoVWcwqHSQbz+gjy3tfiMOoo
xBe8KeIEe1D3bFFJoT6lcP6dYu85IYw9TYHpEIGg3WY5MTdo6cVUdtAcVmiII5+g
H2dhxyw6hXHENya7RTSOwz8brJSviqZQzaUlPp5bF62o4Y3abdyOdoFT1zqVhi3I
8qSX1R8TpZbZeLIB7JtV
=tzSq
-----END PGP SIGNATURE-----

--nextPart2106704.84RSoyRpKn--

