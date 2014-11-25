Return-Path: <philipp.psurek@gmail.com>
Message-ID: <1416950188.2605.3.camel@gmail.com>
From: Philipp Psurek <philipp.psurek@gmail.com>
Date: Tue, 25 Nov 2014 22:16:28 +0100
In-Reply-To: <5474CCF8.9030008@hundeboll.net>
References: <1416938767-29156-1-git-send-email-sven@narfation.org>
 <5474CCF8.9030008@hundeboll.net>
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature"; 
 boundary="=-pCKA5RbuN+0yzAxIENWd"
Mime-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Check size information when
 reassembling fragments
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
To: Martin =?ISO-8859-1?Q?Hundeb=F8ll?= <martin@hundeboll.net>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--=-pCKA5RbuN+0yzAxIENWd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Martin, hi Sven, hi all,

thanks for working on my bug.=20

Am Dienstag, den 25.11.2014, 19:39 +0100 schrieb Martin Hundeb=C3=B8ll:
> Can you please test this patch, and report back if it fixes your crash?

After I tweeted about this bug in my Community with link to my thread in
this ML telling there is no gateway for now and switching the VM to
3.17.4 8,5 hours from now; the VM didn't crush. It might be the attacker
is sleeping because there were no gateway announced through DHCP or some
changes in the new version prevent the kernel panic:
35e95fae72ddb67ef94395d99abc48589ce17875
dd8aaf1f380e008044857d7d2293e8e2824772b8
5a282822a9e472a41a7e2db71903a1c6654c634a

dmesg screams =E2=80=9CUDP: bad checksum.=E2=80=9D all the time, but it's t=
o soon to
tell.

I test this patch if the VM crashes again. If the VM didn't crash until
Sunday I do a kernel downgrade to 3.17.3 or 3.16.7 with your patch and
report. Or should I implement your patch immediately on the old kernel
to prove your work without waiting? It would be much convenient to
implement this during an actual attack and it would much more prove your
work.

I'll report soon. Thanks for your work and Batman-adv.

Best regards

Philipp

________________________
Freifunk Rheinland e. V.
=E2=80=93 Funkzelle Wuppertal =E2=80=93


--=-pCKA5RbuN+0yzAxIENWd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABAgAGBQJUdPGsAAoJENpWdD1eHU4J0jIP/i89UcPGxQCzEOjD8YDl7wsD
4aemk5bHzsG6NnGmf0XBGBMOlW7TECqqFNu2cL4TI+Yo5T1+gHcwqupKQMi1RkIY
6PETuFWz7uh7fXWOzEvL1cnF2oUmWbEm3IT6lPnNDIhLhrcjQbUgcA28u+tzr9bt
KZwP78JvBeXhXYqNblLjSD+Y9bF+i53FWY9SbqD3Zg60XSOyygNGkP+pwWZbm90z
Hi+CmussygCjGdzeejWR+mmp15NEYqoXRdXhVDX7xJU08pAq78jjYZkM2BhEQk1r
qdjFt7Llh871/H42+H2uWLQn8FNBfB4AAwdWJ0AyokjjT/Rg/TeGwIkkQ4xOHlnL
/kpa+hqNuKT71gS6saH6gNVSNsMC7GWTdRdHTx01tnxtDdX1m7OIKamybMuiF2uK
otHu8yodaLQhi9iVNZVSL05ESa0uwaRTEKh4xqC5AZbyNGicipeZLVQG+iFBU8i5
MGU5kdJKKBsIuqIVWhZlFUoqo/5BA7n4TnivftYMxZi2QHpzYuYA1r559kLZt9Ta
il7dl/fw/Of+7H0cGtWkQMNEEC9t9J1u/Fqy0sqa5pTAvHEmqDTcOy9GT36kqqtj
nGpp+047D7oHIYmTyLlMDyRMdnaG8cmfzLr8aYkgS9jfBKeHI/q9syiZ612+mHxD
eSQH4Uptw3DsTMNT2nbg
=hLEY
-----END PGP SIGNATURE-----

--=-pCKA5RbuN+0yzAxIENWd--

