Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 27 Jul 2016 22:21:46 +0200
Message-ID: <2787199.qGkEMRto2N@sven-edge>
In-Reply-To: <1469649967.4790.17.camel@c00941>
References: <1469649967.4790.17.camel@c00941>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8648775.IszqdzAKZF";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Increase alfred synchronization frequency?
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org, Jonathan Haws <Jonathan.Haws@sdl.usu.edu>

--nextPart8648775.IszqdzAKZF
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Mittwoch, 27. Juli 2016 20:06:11 CEST Jonathan Haws wrote:
> Is there a way that I can increase the alfred sync frequency?  Right now
> it takes place every 10 seconds, however I have some data that I would
> like to push through alfred at a higher rate (i.e. possibly up to 5 or
> 10 Hz).  Can I reduce the synchronization interval?  I understand that
> this comes at the cost of additional overhead, but for my application
> that is okay.

Right now it is hardcoded. You can find an example what you need to change at

 https://github.com/freifunk-gluon/gluon/blob/7565839fc4761c65a153abae10f6a0370bd65751/patches/packages/routing/0001-alfred-adjust-intervals.patch

Kind regards,
	Sven

--nextPart8648775.IszqdzAKZF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXmRfaAAoJEF2HCgfBJntGf18P/R6e9sq83+RxIfkKTOp5xH/e
YD3v+80W7L/BnAlgpvixL56u7UMTfl1gO+KrGGwr23E8s83FVm+7TXMwDGzz18+n
A4ZXNtw6tSQwdRekxdsVD+s+aIsP0sklfmm18PZlz3o8Z3JnOimflCPAWpjNUK+e
ueYFoNBbj1ul7wazkkvKvWCM5N/tQZZgG0eW5C1lGL1xM68Ih7HvoiWxbVo2lK9H
FF0aT14Xb9YQfl4Qtws8oIZAHAjvrCXd1pW/ucXy61DQg6jYp8OVeksYEQAEmFyI
CCPph5jgM235Ey3qrYp/IGjHE6OUxC7tggAby3vPOj6YXiyKAUqcXN3rIn2CfISk
MNulnz2NMq+1fKGOKp0c8eOoL6bJbvDeKazylXedCX/003+C0TUvf+hwoXP3QqUy
X9/CkuMyKUykU077JGAIQAmaRW4iSfrxjIO4jN0Ou4NbWnx2gqxAzhrMfP99T/xm
gVV97kQTGYEkyqj9cHubeaQzimyfykZ33d380I5Rt4QW7MUvmdg5Kl/9+v4jpDSH
6a6h9ChidxGp1hSaGvQy7EHEqtvQYRlekKio1uELhDud97GBpG//HOl3DuxjdfNn
2Feo4z4F66KhvNI/IPI/F1PE+Ly+qTHEMfgCGbux4DDFoypngWu4uSs1e3XNsOqb
QlDjn4DSvdahNJ4Q9u1v
=hKQU
-----END PGP SIGNATURE-----

--nextPart8648775.IszqdzAKZF--

