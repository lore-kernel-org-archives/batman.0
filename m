Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 03 Nov 2015 13:44:17 +0100
Message-ID: <2098610.gvO9DYSuCg@prime>
In-Reply-To: <CAFJkCXrOyDam2BHpUbcW9Qcd8ZBxOSbTeU6_kORkw6R3qELfLQ@mail.gmail.com>
References: <CAFJkCXrOyDam2BHpUbcW9Qcd8ZBxOSbTeU6_kORkw6R3qELfLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1499622.NBW4KFsB6E";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Compiling for Beaglebone
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

--nextPart1499622.NBW4KFsB6E
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi Justin,



On Tuesday 03 November 2015 07:05:16 Justin Oursler wrote:
> Hello,
> 
> Can someone help get me started in cross-compiling batman-adv and
> batctl?  Specifically, I'm wanting to run it on a Beaglebone running
> Debian (http://beagleboard.org/project/debian/).  I already have the
> arm-gnueabihf toolchain.

if you are running a recent Debian then it should be part of your Linux kernel 
already, so you can just use it by loading the batman-adv module. You might 
also want to install the batctl package to control batman. No need to compile 
anything unless you want to upgrade to the latest version.

Cheers,
    Simon
--nextPart1499622.NBW4KFsB6E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlY4rCEACgkQrzg/fFk7axa9iwCgtljdo4pPcr/TLRfOOb8tcvRu
r9MAoIFDUlJu/5EJIhjSJsyH0xjelDYO
=okER
-----END PGP SIGNATURE-----

--nextPart1499622.NBW4KFsB6E--

