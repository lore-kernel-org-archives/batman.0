Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 06 Sep 2015 16:24:02 +0800
Message-ID: <6359105.dcpfsGfnrT@voltaire>
In-Reply-To: <55E73C00.6070806@meshcoding.com>
References: <1441217396-18043-1-git-send-email-sw@simonwunderlich.de>
 <1441217396-18043-4-git-send-email-sw@simonwunderlich.de>
 <55E73C00.6070806@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1608682.MuBcjjfNez";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH-maintv3 3/3] batman-adv: detect local
	excess vlans in TT request
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


--nextPart1608682.MuBcjjfNez
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, September 02, 2015 20:12:16 Antonio Quartulli wrote:
> On 02/09/15 20:09, Simon Wunderlich wrote:
> > If the local representation of the global TT table of one originator has
> > more VLAN entries than the respective TT update, there is some
> > inconsistency present. By detecting and reporting this inconsistency,
> > the global table gets updated and the excess VLAN will get removed in
> > the process.
> >
> > Reported-by: Alessandro Bolletta <alessandro@mediaspot.net>
> > Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> 
> Acked-by: Antonio Quartulli <antonio@meshcoding.com>

Applied in revision 2dd1d9f.

Thanks,
Marek

--nextPart1608682.MuBcjjfNez
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJV6/giAAoJEFNVTo/uthzAZZEH/2SlkY9NVugu2MMJJSUXMlJp
lFe/L/Ydwj3OOf/UFLOYfkeKtwzITlugyq/1w0/PfghIOtDUNK1goJqVgtAlBDr/
kqipxGiOwPaD48Ju7sszNCBl/eq9/ipwp8cJK+Gke6NCFyQtk1K1We5npG85o2j/
0TuFEiRXPPH3trNs80HR9AUjcPziWf8BWwLs0vC9GJDAKK1y/CfGoh932KwTwK/1
qnB1AI44fUQZUOeEX55sDRk5tIqXR0PU1CMgZzgdlEmw1xqm29dEleyvbzn/Ye8V
LKohcfhFHBF2KrfcVkO0aUc+DYDStYhN3Oax0OLoq7JE4+16TMUPy73Ec6BXpX8=
=uA9d
-----END PGP SIGNATURE-----

--nextPart1608682.MuBcjjfNez--

