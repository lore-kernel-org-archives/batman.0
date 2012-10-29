Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 29 Oct 2012 08:41:18 +0100
Message-ID: <28757325.XCegVK7bHO@bentobox>
In-Reply-To: <!&!AAAAAAAAAAAYAAAAAAAAAOJK0u4CH31Kl5v1RPAzyrZCgQAAEAAAAGJwzLps+6ZBjmHUmr3zOB8BAAAAAA==@gmail.com>
References: <!&!AAAAAAAAAAAYAAAAAAAAAOJK0u4CH31Kl5v1RPAzyrZCgQAAEAAAAGJwzLps+6ZBjmHUmr3zOB8BAAAAAA==@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart22527022.hXbmVY663V";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] batman for production
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
To: Walter Robert Ditzler <ditwal001@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--nextPart22527022.hXbmVY663V
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 28 October 2012 20:13:26 Walter Robert Ditzler wrote:
> hi sven,
> 
> first: sorry about replying that way - i have an account but somehow i
> couldn't post anything here!

There is no difference for the mailman when you reply or directly write. You 
only have to make sure you don't write html mails.

> second: i have a working test environment running, all works great, but i am
> not familiar with the update mechanism of batman. I don't want to replace
> any good version if the latest kernel has already the best possible version
> of batman.

We don't have an "update mechanism". We release a version after most stuff was 
merged for the next linux version (which would be 3.7 for 2012.4.0). Maybe we 
release a minor update (2012.3.1 for example) before the next release when 
something horrible broke. So it is ok to use the latest stable kernel when you 
don't need special features and are happy to compile everything from one 
source.

But some projects cannot use the latest kernel for different reasons, but want 
to use features from the latest batman-adv release.

> third: here are actually my doubts. to configure a mesh within batman you
> normally use batctl. so are those patches for batctl or for the batman-adv
> itself and how can I get the right batctl corresponding to the batman-adv
> version from kernel.org 3.6.3?
> 
> or is it even better to configure batman-adv via the sys classes (echo bat0
> 
> > /sys/class/net/eth0/batman_adv/mesh_iface)?

"Better" depends on your metric. But you usually check the download page or 
the output you see when you load the module to find a a version number. Just 
choose the version of batctl with the same version number.

And batctl only uses the sysfs and debugfs interface to configure it. But it 
has some nice extra feature which can assist you.

Kind regards,
	Sven
--nextPart22527022.hXbmVY663V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQjjMeAAoJEF2HCgfBJntGZS4QAKIzunrsHYv9LDFU8luZ9Tf+
CihS8Eeav5Ho+bqGtKxROO4NOcjkiQKR5lENXSzp6t+H0+vKIrH2Vl1NXDF9HIjq
WhShe0d7RlBB33EJfHbIiZKAdV55rCMOx1s/r+9nozpc1LcK9+NYvoackcNSbUpN
Fnn+uc6N7vsUWd+L9zu0bvozL/Cg7hMh+EcTqhD/PdVGhN/tyiMW0rjeYZIBh8iz
NRlNH/6WSkyH6AZRX8tFy5cPB/lU03Xv4Nuhln4/fCJfU2NxVvzFMzP76tl5W8VD
k3TDFacuWtyzr7CxmxSVKS9EB0frNnfZnnq4bn00WuAGz4JOwJFYqO80xPVwLlvC
EV0b2LiHT/d7XNx8NFGb8RCK6h4x72A7gKrN5uI8vbj4iLABPv/hlj2KH0EmvLQ6
g4m2AcKDX9lW2P/QwRa/KGEZyO7MA2Xmhba2NUvoooRm07HKGvQfmP1cVrLyrukJ
Ok+lfoSF0uQdiOp/59xvGunbYNi8ex0QEllhaPEWWN7coSKLm8E1vDQ2ewRte5zn
fLVGiV7L8EU3Q9DHpnnJEpqsuEzPndvhS6S+RardkGr1C5c0YMi7OBLjSif0bDAr
Ul+h34VLi0Zl57bvRbmUJejGlQSrue2jCWdK+Rs3f2KMqWutsIwXf7btYI650KkP
1N7Jbs/vEGawhnZM6inE
=/PP9
-----END PGP SIGNATURE-----

--nextPart22527022.hXbmVY663V--

