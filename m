Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 06 Jan 2015 01:22:33 +0800
Message-ID: <2417501.hlFk6DQ6tc@diderot>
In-Reply-To: <54A9663F.9070008@meshcoding.com>
References: <1418509935-11849-1-git-send-email-linus.luessing@c0d3.blue>
 <54A964D7.5070107@meshcoding.com> <54A9663F.9070008@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1574787.ekj28pNach";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: fix potential TT
	client + orig-node memory leak
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


--nextPart1574787.ekj28pNach
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 04 January 2015 17:11:43 Antonio Quartulli wrote:
> On 04/01/15 17:05, Antonio Quartulli wrote:
> > Hi Linus and thanks for fixing this TT bug!
> > 
> > I agree with Marek about extending the commit message with a better
> > explanation of the actual bug, but at the same time I think it is good
> > to keep the commit message and ID of the other involved patches.
> > 
> > Moreover, please keep the commit ID of our batman-adv.git tree - I'll
> > then take care of converting them when sending the patches upstream.
> 
> I forgot..for the patch:
> 
> Acked-by: Antonio Quartulli <antonio@meshcoding.com>

Applied in revision 21fa264 with commit message beautifications.

Thanks,
Marek

--nextPart1574787.ekj28pNach
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJUqshkAAoJEFNVTo/uthzAc+kH/3Sk3CWOq6Ik/Qgj2E3es+Og
PzMS5I5osiIfKgNBgjwgNJfnVzGUEcKw4Fpgj0jxsT+pcmEEX7uv/Tt+q9vtec5S
LtWwi2H959jFqzv9jIJ3PMhjI4jYDRN9gEZ3v30ytFNG3gIUmTIaDJNmQDF4kyl7
Uu6PYf/Ma+0tW+MOMcHjp5aRkN0tFD676wwmDFD6Of0AKHaBhDheg8MgRksEjcwn
qUTwqB8f3+r8oMQCfAGCX8KMl9z9aF+ph6ZVlCug9yFJxmLx9tKoloqAOwvMYXCB
1cxGvlFiuzuA5B1r+6YsMFVSoAUxR1gjCXcUnlMKH5Hdj90EVXgo4t1jzeZqf0o=
=epz6
-----END PGP SIGNATURE-----

--nextPart1574787.ekj28pNach--

