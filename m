Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 06 Sep 2015 16:21:38 +0800
Message-ID: <2275315.EbeBhc3YPY@voltaire>
In-Reply-To: <55E73BB5.7050702@meshcoding.com>
References: <1441217396-18043-1-git-send-email-sw@simonwunderlich.de>
 <1441217396-18043-3-git-send-email-sw@simonwunderlich.de>
 <55E73BB5.7050702@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1587654.y78jb1fg0V";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH-maintv3 2/3] batman-adv: avoid keeping
	false temporary entry
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


--nextPart1587654.y78jb1fg0V
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, September 02, 2015 20:11:01 Antonio Quartulli wrote:
> On 02/09/15 20:09, Simon Wunderlich wrote:
> > In the case when a temporary entry is added first and a proper tt entry
> > is added after that, the temporary tt entry is kept in the orig list.
> > However the temporary flag is removed at this point, and therefore the
> > purge function can not find this temporary entry anymore.
> >
> > Therefore, remove the previous temp entry before adding the new proper
> > one.
> >
> > This case can happen if a client behind a given originator moves before
> > the TT announcement is sent out. Other than that, this case can also be
> > created by bogus or malicious payload frames for VLANs which are not
> > existent on the sending originator.
> >
> > Reported-by: Alessandro Bolletta <alessandro@mediaspot.net>
> > Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> 
> Acked-by: Antonio Quartulli <antonio@meshcoding.com>

Applied in revision 4a73d74.

Thanks,
Marek

--nextPart1587654.y78jb1fg0V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJV6/eSAAoJEFNVTo/uthzAm4QIAJ5aeKQeDKuE9/LYyep35+wQ
Un8odDKq3/PWCZwolWfQEmK0DfqY0dO5uR4ud2A7Ddm0EfsNQq4hSc51ynw6hNAl
eOolbHSW3hhCCGrg5FuQJX5uXhV3vSqv+6xxXzRHOscLdaAts7cPRSD5q6uNZAB2
4bulRhqkRhNnZ9NqzXKyhzuaIw9KpxblZf7bSkPZJswC/wf6AoVW8rGH73J1xTOu
rUAPbI5g1FPQoTdWMeHzGJj7L/oiXBbpO2fhtYggA6j62d0ALbUTkgRnJHRsdJJr
X44O10z4615H94Z53QS0pjWNxvRMlMdiOLNeUfoKdEbCzehSXuFsouT8EejxaDk=
=nMEd
-----END PGP SIGNATURE-----

--nextPart1587654.y78jb1fg0V--

