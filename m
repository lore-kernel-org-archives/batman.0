Return-Path: <a@unstable.cc>
Date: Mon, 9 May 2016 00:33:24 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160508163324.GC14515@prodigo>
References: <1462474003-25279-1-git-send-email-a@unstable.cc>
 <20160506023434.GA16484@prodigo.lan>
 <41788197.Cke9H3Q0EA@sven-edge> <38489328.JjMjPGWWVN@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jy6Sn24JjFx/iggw"
Content-Disposition: inline
In-Reply-To: <38489328.JjMjPGWWVN@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/7] batman-adv: remove useless inline
 attribute for sysfs helper function
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, mareklindner@neomailbox.ch


--jy6Sn24JjFx/iggw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 06, 2016 at 09:53:26AM +0200, Sven Eckelmann wrote:
> So you either have to add it to kernel-doc or do it differently.

Thanks for checking this. I will split the structure in real substructures =
with
their own definition and document the fields there.

About the result from IWUY: any easy way to run it locally ? I tried to run=
 it
by specifying the IWYU path via CC=3D, but I get way more noisy result that=
 what
you reported in your previous email. I'd like to learn this so that I can e=
asily
understand which patch requires which include.


On top of that, the results you posted says that I should include
<linux/stddef.h> in bat_v.c, but it already included in that file. no?


Cheers,



--=20
Antonio Quartulli

--jy6Sn24JjFx/iggw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXL2pUAAoJEJ4aZjxxc6bKCVYP+wXEWqFL06lH8dTlqUJNWSdv
zL9tIR9GHgxyOiGDUGKgPGvpPDCnH3SU6BBv4PU0ml/9OF3dJt///pgmOM1GTmg0
iSdbGZmV0czL+opb5B7SbpBprNHBMPuiVQ5P8nSTuPN8jVLGjl7pP4WWvGsOJMOn
kKCtDgFGTweonYzC/8jy9yQPLCP9qjHR9AFxAy7uOKK62TBkGloOwAAjRbSwhPkX
Jh+9P88nGGNfxbZAF3YJIM9VmMFGO0jffRGvWmoKIPGCm1pvSKIU/+lL+ronum5h
02688/A1VLyRp0ILomNpC7dGeRjHWnX1p88fFBxxRqUqB9wXNkEKqgmrBjemMHfR
DIIjftNxdvSsm6lnALqr+pUnEA2tg7Wv5cw5vTgs11SNeVFERI/mmTmc6cNYgnF5
sK58aK8UdUzXNqsoj217QrmIGj6vXNfZrv5MKwB+7DkT0Ubx8xAV3lVu2uCr8YrB
zM/FufI+6WnOMOFXszJ47z+Lcn/gWHpQ64JLnKkAUttTCjwWTqdS8uVmZAu3GXZ2
QyCTcCfiXj2ldqa3xxcJ9u72R6zRpL1IwmtXEk//CmkfngYcWuxDLxy1LFu58fvA
IDwDmF/ii0UXWYTougFqA6VXdOMvjn7Y9YrkB7E/LPq4bHYc4/ZH+hqmcZ9eYEGE
0aZ/NT8ihFB6inasJJ3E
=lRQd
-----END PGP SIGNATURE-----

--jy6Sn24JjFx/iggw--
