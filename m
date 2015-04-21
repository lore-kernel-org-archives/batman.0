Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 21 Apr 2015 17:02:20 +0800
Message-ID: <1890391.Mx18l8ZYSq@voltaire>
In-Reply-To: <2563715.j7ulvOLMgA@sven-edge>
References: <1429292430-30883-1-git-send-email-sven@narfation.org>
 <1834679.g60VTMDq3l@voltaire> <2563715.j7ulvOLMgA@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5296715.iZmzNGav6M";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
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
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart5296715.iZmzNGav6M
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, April 21, 2015 08:19:56 Sven Eckelmann wrote:
> > > A different approach is to inject intermediate header files which add
> > > additional features. This allows to reduce the size of compat.h and only
> > > leaves the live patching part in it. The compat.h can then added
> > > automatically to each compile run before anything else is included.
> > > compat.h has therefore the control which headers must be included before
> > > the live patching of the batman-adv source can begin.
> > >
> > > 
> > >
> > > Signed-off-by: Sven Eckelmann <sven@narfation.org>
> >
> > Applied in revision 8746f0f.
> 
> The patch you've added is not the one I've send. All files in
> compat-include  are missing now in your commit.
> 
> Btw. I had prepared a patch v5 which fixed some merge conflicts with the
> state  of the next from yesterday.

I had seen that patch only after I had fought my way through the merge 
conflicts. Not without side effects it seems. Should be fixed now.

Cheers,
Marek

--nextPart5296715.iZmzNGav6M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVNhIcAAoJEFNVTo/uthzAf10H/3TLL7UKo2q9ZcsGJjbLhErf
XwDzcqin8Hy65+7jFgENYxKTFOBrENL8eojL3GqLBPh4PnNWDa10WTaowWW/krvV
sYhUwq2DnByst2qSPsQK95Hpvxm8TCymM0XLI4c6CSAECBh369l76XQosm+iwR0V
msQxDlMZ0dAd65joreOn/pO1Iw0QMk3fZUbkwp3t337gpF8ghxHFdT0eTnkBjL2w
4dv92Uo8VBpSmP9OgiiKlziC/bInXCCfY3AUFpEth94eCCfce6X68rNqnnhhGNt5
n+su43UpZrOk9XlaTbP8PF4H5T2oIkkLkt0iqCMu4VGIwDnpXrGhryA15upQL8E=
=I5cu
-----END PGP SIGNATURE-----

--nextPart5296715.iZmzNGav6M--

