Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 06 Sep 2015 16:34:27 +0800
Message-ID: <8907086.vdkCaJlVYT@voltaire>
In-Reply-To: <a5a54ef64dc492631dfeb9e933dd6875@viisauksena.de>
References: <a5a54ef64dc492631dfeb9e933dd6875@viisauksena.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1762447.nvEdMfTKE2";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] question: batman on rootet android
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


--nextPart1762447.nvEdMfTKE2
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, September 02, 2015 17:55:57 Jens Viisauksena wrote:
> while i can log in to a shell on my android phone and there is bash 
> shell and so on, i wonder if can do insmod batman.ko and go on with 
> alfred and fastd .. so i can write a skript for having a freifunk node 
> on my android phone.
> is it possible in general?
> how would i become a batman.ko for 3.4 Kernel on armv7l?
> 
> uname -a
> Linux localhost 3.4.0-g546857a #1 SMP PREEMPT Sat Dec 6 03:57:42 CET 
> 2014 armv7l GNU/Linux
> 
> this would be also awesome, as i have some huawei y300 where display / 
> or gprs modem is broken, the rest seems to be in very good condition.

Have you checked whether batman-adv is already part of the kernel modules 
coming with this kernel ?

If not, you will need the kernel sources matching the kernel you are running 
and compile your own module. Note that you will need the exact sources with 
all patches applied or it won't work. simply downloading Linux 3.4 from 
kernel.org is not going to get you any satisfaction.

Cheers,
Marek

--nextPart1762447.nvEdMfTKE2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJV6/qTAAoJEFNVTo/uthzAOwcH/j+fOvgH78Rf+5g/NvjZLamN
S48dF7852Ozs2HnM/NH5s4+94q+EHl3EwVoCaxwVYj/ovCdJWx0MDmfM2o5SBcQk
cQqZs4Zl+PTVD4C2Vx1/bv1aQtGv5Hd7wdGpQIEDK/HqgPsdkTLElKVaNO2fiqh3
o19WWt6auuxbRWpcubts5bd86hbfABCJH+pR+xWNOGCHW9xIn+0ZLg9UdeJsDkNe
UUtd9pIgkLEGbsiHRP1iD1imzPtLZvdroSJvyNsz/X2SokSN/EgLGVHUQylUUXpe
kggh5+0+6hv5LfHt1X9bktichLVhacawVdpja2Mzhsj8GfMLQ2/xJbsuHqzNohM=
=zJRY
-----END PGP SIGNATURE-----

--nextPart1762447.nvEdMfTKE2--

