Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 21 Apr 2015 08:19:56 +0200
Message-ID: <2563715.j7ulvOLMgA@sven-edge>
In-Reply-To: <1834679.g60VTMDq3l@voltaire>
References: <1429292430-30883-1-git-send-email-sven@narfation.org>
 <1834679.g60VTMDq3l@voltaire>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart64983403.MRGZrDqGeA";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 1/4] batman-adv: Remove explicit
	compat.h include and split compat.h
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
To: Marek Lindner <mareklindner@neomailbox.ch>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--nextPart64983403.MRGZrDqGeA
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 21 April 2015 11:41:48 Marek Lindner wrote:
> On Friday, April 17, 2015 19:40:27 Sven Eckelmann wrote:
> > The current approach for the compat layer is to include the compat.h file
> > at exactly the right time to provide additional functionality and to live
> > patch the batman-adv sources. This has the problem that the compat.h file
> > becomes harder to read over time. Also live patching and adding of
> > missing functionality partially conflict. This becomes obvious when the
> > include order in some files is different compared to the one the author
> > of an compat.h entry expected.
> > 
> > A different approach is to inject intermediate header files which add
> > additional features. This allows to reduce the size of compat.h and only
> > leaves the live patching part in it. The compat.h can then added
> > automatically to each compile run before anything else is included.
> > compat.h has therefore the control which headers must be included before
> > the live patching of the batman-adv source can begin.
> > 
> > Signed-off-by: Sven Eckelmann <sven@narfation.org>
> 
> Applied in revision 8746f0f.

The patch you've added is not the one I've send. All files in compat-include 
are missing now in your commit.

Btw. I had prepared a patch v5 which fixed some merge conflicts with the state 
of the next from yesterday.

Kind regards,
	Sven
--nextPart64983403.MRGZrDqGeA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJVNewQAAoJEF2HCgfBJntGYlEP/Rah2jnG0Ub15zZki0e52LAC
Qyo0b6aOROeYcXzCMnpOthGy/Twv8q2REIpbD+FElI7+6NJShKA/ZzOSI3z0g7l1
9eFw/fthItxH9q39UMQt5S6Uq4IV6FzJT/2A96O5jiDD5i+7tkxXbZiTps/45kus
87af1R5A5XzGwlclJDRGad/8DXZmHyVQXZoaCijr0DC3wBN22+290fAC9QfD5AI4
VatCVDw5kB9gjaNHBZmNfPPKT7V2cx0tdQZ5JbWq0/8snrWaTC081HQHuptcmICN
eP0wBSglA7JD2PnDIVRuNwErbevScQelmNw/8dTsHwKq+gActcgD1EIz2Br3y5MR
4XiEo14lsfg/eg09vtR0QpfhnxmcMMiexHWRjYPGuVieu3sKW5TgBT+fyK9V8iuq
PNxPV6Q1Y1EAALU2uQ1zfVkvIUwqk+beX+c4h2aw3fgQW48HhVVzGmgUp4uW1mHu
Xh1Tg3ZhbmRaC7fy61hPhWIM85wwNouYEY30Tp4VEaIaL5XXcYIVG7tdnjHiPdCJ
QeZJFSCxMIZO93kHKa51kTaNri+DayKLFITIeRS2/5ucz7VtWOasJ+J49w2Jbsa7
jBI8TsxiWynHvRafB1QqshDjAh3tdAtNSe721gMXs5f+sSpKiXuUPcF2AHSaH3mu
kuJ5crixGh1McFsm1S8+
=jMHi
-----END PGP SIGNATURE-----

--nextPart64983403.MRGZrDqGeA--

