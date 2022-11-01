Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: Question about batman for ARM
Date: Tue, 01 Nov 2022 20:32:48 +0100
Message-ID: <2368065.5ID8ZXoMCK@ripper>
In-Reply-To: <01ba01d8ee22$bc00d6e0$340284a0$@creonexsystems.com>
References: 
 <CAKau_3_sEaG2w7M+rQ-nuVG3_5GWHEV3UxmdG1bM-WPY7S8WxA@mail.gmail.com>
 <20961862.b4RiU9qLUR@ripper>
 <01ba01d8ee22$bc00d6e0$340284a0$@creonexsystems.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2092444.bCxPy3x5Xm";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: cchien@creonexsystems.com
Cc: b.a.t.m.a.n@lists.open-mesh.org

 
--nextPart2092444.bCxPy3x5Xm
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: cchien@creonexsystems.com
Cc: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: Question about batman for ARM
Date: Tue, 01 Nov 2022 20:32:48 +0100
Message-ID: <2368065.5ID8ZXoMCK@ripper>
In-Reply-To: <01ba01d8ee22$bc00d6e0$340284a0$@creonexsystems.com>
References: <CAKau_3_sEaG2w7M+rQ-nuVG3_5GWHEV3UxmdG1bM-WPY7S8WxA@mail.gmail.com> <20961862.b4RiU9qLUR@ripper> <01ba01d8ee22$bc00d6e0$340284a0$@creonexsystems.com>

On Tuesday, 1 November 2022 19:49:54 CET cchien@creonexsystems.com wrote:
> We are now looking into getting BATMAN working on a Zynq-7000 Xilinx FPGA.
> This FPGA hosts dual-arm A9 cores. We have successfully loaded up Ubuntu on
> this platform and it is running
> Linux version 4.19.0-xilinx-v2019.2 (oe-user@oe-host) (gcc version 8.2.0
> (GCC))

I don't know what this should be. It is not an ubuntu kernel (more like an 
openembedded kernel). So you might have to get in contact with whoever 
provided you with this kernel and ask them how to build externel kernel 
modules against this kernel. They hopefully have some linux-headers package 
which you can install and then build some kernel modules against it.

And if it is openembedded (with yocto) then you can either try to update
these recipes (which are using ancient batman-adv versions):

https://github.com/jhaws1982/meta-batman

Or simply enable CONFIG_BATMAN_ADV (and related symbols) in your kernel 
configuration which you are using to build this kernel. It will not be
the most recent batman-adv version but better than nothing.

Kind regards,
	Sven

--nextPart2092444.bCxPy3x5Xm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmNhdGAACgkQXYcKB8Em
e0bRGxAAgTp8SS2FDvAhYkCZaNsGvf960QrzwzJlgi/QUU6hGIKMgC+2tgG/Rrjf
fBduDVbOnVOCz1r6XqMNuXn2pEVAaYyf2iSP/rmL23jGLHKle32pscsrAEJCRI7s
31SXA833tK22fAAAGTKwFBOJb1b7yByT0RZ31zA7tCts4lMxdLmAEwT12QgnNDLz
BX103w3eTPtXqQZ/GTpUZREfVq0FCt/UJJ+XTT8PWVypHwtVbEBfv9tJeZiwbw3i
qQcigcnIe/CpumJqowKRVyWMtmHlN7vIeHoeNDDYyYCBqfrX1KUJ36sFVli4UqFb
AG0uCIaXOi+EyuGE4Y9j36BewHckMmQgw6moTpm+ZGj+svLylDVqasiJbe69jO2+
SJX31LObWwpHneju1DKZtTdtAW2WdUjAoRH5PnGvtKFcK6cNgTFdlCAzuhLIJd1F
kmi2bPVV20rpH65s7MdPELiQ68YEpV+KRV22NVI1wqU/YZe3JrxGlOc+YO31xzB1
dq6452aTHqztRs0uNxxpTdF/s11dOjkD2uHwAm3ZY5ICo8qyEVkhVw9QL9NGmm6C
WG7ft2+nyUpTZO4c6ZLPxF0q4oQm7LStBVc9/JcO4KJhP9RgILUOMe8Lgc5jLipx
GAOCTbqsfrYJbsyZn6a121mBg4TsFuicq0j9yaIcoGWX1vnV3wA=
=+u7h
-----END PGP SIGNATURE-----

--nextPart2092444.bCxPy3x5Xm--


