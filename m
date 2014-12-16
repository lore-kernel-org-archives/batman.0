Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 16 Dec 2014 12:42:40 +0100
Message-ID: <1485623.8G5yQQU2XS@prime>
In-Reply-To: <CAKL2rw57jqvPx2Xh5DEDH1bQWCPc43D6B54J9YqQEVeTMQADnQ@mail.gmail.com>
References: <CAKL2rw57jqvPx2Xh5DEDH1bQWCPc43D6B54J9YqQEVeTMQADnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart118230660.QRZ9HUZHp3";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Out-of-date batman-adv module in Linux Mint
	(Ubuntu)
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


--nextPart118230660.QRZ9HUZHp3
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi Melroy,

On Monday 15 December 2014 16:12:10 Melroy van den Berg wrote:
> Hi devs,
> 
> I found out that the batman-adv kernel modules is quite out-dated in
> Linux Mint (and probably also Ubuntu/Debian unstable).
> 
> Using 'lsmod batman-adv' it says: version 2013.5.0. But the current
> version is 2014.3.0.
> 
> Is it on the planning to update to the newest version? Or what could
> we / I do to update the package(s)?

The Debian/Ubuntu/Mint kernels are updated by their respective maintainers, 
independent from us. These kernels have the in-tree batman-adv versions 
included as they were released with the kernel. So just update your kernel to 
enjoy the new batman-adv.

If you want to use bleeding edge, you should go with our releases from the 
webpage, but those don't get packaged in the official distributions.

Cheers,
    Simon
--nextPart118230660.QRZ9HUZHp3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlSQGrMACgkQrzg/fFk7axbyxwCfSHBFLVcNs1St3K5m8NKY20f/
2rgAn3uca33RdxnkfcFj01jNbNnzrG0E
=C/vO
-----END PGP SIGNATURE-----

--nextPart118230660.QRZ9HUZHp3--

