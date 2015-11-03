Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 03 Nov 2015 13:59:26 +0100
Message-ID: <6264428.4oiRdRIpY5@bentobox>
In-Reply-To: <CAFJkCXrOyDam2BHpUbcW9Qcd8ZBxOSbTeU6_kORkw6R3qELfLQ@mail.gmail.com>
References: <CAFJkCXrOyDam2BHpUbcW9Qcd8ZBxOSbTeU6_kORkw6R3qELfLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart241094877.6AlbJSbM8i";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
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

--nextPart241094877.6AlbJSbM8i
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 03 November 2015 07:05:16 Justin Oursler wrote:
> Hello,
> 
> Can someone help get me started in cross-compiling batman-adv and
> batctl?  Specifically, I'm wanting to run it on a Beaglebone running
> Debian (http://beagleboard.org/project/debian/).  I already have the
> arm-gnueabihf toolchain.

Why not compiling batctl and batman-adv on the beagleboard? This would make 
the whole procedure a looooo[...]ooot easier. Just install build-essential, 
libnl-3-dev, pkg-config and the linux-headers for your kernel.

I don't know what kernel you currently have installed and where it comes from. 
But one of the kernels for this board comes from paulliu [1] and he gives you 
the kernel headers for his kernel in the linux-headers package [2].

Otherwise you would need the same toolchain used to build the kernel, kernel 
headers, config, libraries, ... and a lot of time and nerves. And when kernel 
headers and toolchain is not provided for your kernel then you have to build 
your own kernel anyway and then you can build your module against it [3].

Kind regards,
	Sven

[1] https://wiki.debian.org/InstallingDebianOn/TI/BeagleBone
[2] https://people.debian.org/~paulliu/beaglebone/
[3] http://azkeller.com/blog/?p=129 (REMARK: KDIR is called KERNELPATH in
    batman-adv)

--nextPart241094877.6AlbJSbM8i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWOK+uAAoJEF2HCgfBJntGZu4P/1h+hh7IvXKMrSL2VpwyHBy2
SfayN1JjORLrq1tV01Ty942K4kLBXXaXLoQSzCKtFzoLJq7Iu8OI9HQCiSGZmD/x
njCKZcuXhKFQNRpLAECoBorfOG1WN2n+FiKuxRmvU/gEd2xtOsRzhkWqJFpPKQGd
LLRNR59K3uc/CtXkLV1aXtWrYZ+MHAtlFHn42I18sk3YrDlK87NxiyIHP6pxamcd
rkXrsEJtsEtem8Uor6ud/utHj6h5Qp8RK/VtZ3J4GaAUvFwt1jT/+PY5rx+sLfLo
DifvwkNgAaKr/uDOsvIYfT+DMusu97bXjH0O+ZnfSBrmC73PZPa5+SWhKd4bXeMf
uIpdwXd8YZCRC0aa3oIAXD6fcp+I8YDeoPQ1qHKraON7SrZfmBfI3MkLCIVtYUwS
dNfJ1qMANdGm0Ek450EBPwacsqNR+rhV0lRI8LZ08/GOgAOCl79y0t6IknO0yKWm
FFCFX6VzEr2XbKNn4JJ9kTJSoWpB6UHcV0XdhJ6kHI7UFTJYxech9BUaZ1RFCTVf
8sSUVCYcFbSnlojtwAYTFVqc8503ULmMho4su4Uta4GyXDCAof7Gi3acP4/bdhws
S6MBKKXHq9wFn0WMmY/bfsnCK83u5m6vwiSzyZQMr6XCf5HLr2tetYhcv+vjvvac
AtMZMKrIJNq9BWQ22iBx
=5IU1
-----END PGP SIGNATURE-----

--nextPart241094877.6AlbJSbM8i--

