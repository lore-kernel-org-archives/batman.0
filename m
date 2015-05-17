Return-Path: <ruben@freifunk-nrw.de>
Date: Sun, 17 May 2015 11:16:59 +0200
From: Ruben Wisniewski <ruben@freifunk-nrw.de>
Message-ID: <20150517111659.492f52ef@i3.local>
In-Reply-To: <29831806.Occmqno74R@sven-edge>
References: <20150516220736.2d896b4b@i3.local> <1823317.pnFH07jJni@sven-edge>
 <29831806.Occmqno74R@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/G+rQYqxu9k1k/lhv3kAVCcH"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Patch to add mesh_no_rebroadcast
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

--Sig_/G+rQYqxu9k1k/lhv3kAVCcH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Sun, 17 May 2015 09:11:18 +0200
schrieb Sven Eckelmann <sven@narfation.org>:

> > Why are you sending a patch from Linus? And this patch doesn't
> > apply on current master or next.
>=20
> Just to make it more clear: I think it is not a problem to pick up
> some old patch from someone else when the original author has no
> problem with it. But taking a patch from someone else and then
> without any additional information claiming to be the author is a
> rather bad move.
It is a old patch which is fixed to apply to the latest stable version.

I talk to Simon yesterday, that it would be nice if the freifunker does
not need to ship this patch in any installation, since we start to setup
custom repos with this patch included and so on...

Else all freifunk-firmwares include this patch, this should be stable.

> It is even worse that the informative commit subject + message was
> dropped. There is also no information what you've changed before your
> signed-off-by (which is also missing).
Yes, I removed it, since the last patches I found on this mailinglist
does not have this information-part. So I thought this is the given
form for this mailinglist. (There is no information about that on the
mailinglist site).


> Btw. here is the original patch and the discussion
>  http://thread.gmane.org/gmane.org.freifunk.batman/10503

I know this patch and discussion, I've read it yesterday with Simon and
he asked me to send our version of the patch to the mailinglist.


Best regards


Ruben

--Sig_/G+rQYqxu9k1k/lhv3kAVCcH
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iKIEARMKAAYFAlVYXIsACgkQgB++GrevraTjDAIJAWChm9v4L0rfd5bcUp3VYkZJ
PoOWnNaSkup3dMc8mf9ZFyEzjYlQRhd+jUv8A4TXwrBA/Y+Rp89lZkv6i55lmQE7
AgkB6Cou5nnBfmz4BE++qXUqT79sIzZ/fgno/RWQZ8YscZ/AjlX2e5fjpyAkNFj7
t3ACOKFdFag9mVjxD5Wl6JGq4as=
=/zDc
-----END PGP SIGNATURE-----

--Sig_/G+rQYqxu9k1k/lhv3kAVCcH--
