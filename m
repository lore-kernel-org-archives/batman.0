Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 03 Feb 2018 08:41:24 +0100
Message-ID: <1871109.rBcZyFIX0N@sven-edge>
In-Reply-To: <2280205.kRTqscCMRg@bentobox>
References: <98a77a75-ac8e-455a-6060-343b9020cd27@viisauksena.de>
 <4799954.f95c8XAbim@sven-edge> <2280205.kRTqscCMRg@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2817755.XncDFrWVSs";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] limit of if per batman
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: jens@viisauksena.de
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart2817755.XncDFrWVSs
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Dienstag, 23. Januar 2018 13:33:01 CET Sven Eckelmann wrote:
> On Dienstag, 26. Dezember 2017 15:19:41 CET Sven Eckelmann wrote:
> > On Mittwoch, 25. Januar 2017 08:15:52 CET Sven Eckelmann wrote:
> > [...]
> > > > this made me curious , and i modified your script a bit - turns out
> > > > after the 127. IF you add to batman-adv you get an Error -
> > > > all 510 gretap links was succesfully build ...
> > > > # ifconfig |grep gre| wc -l
> > > > 515
> > > > # batctl if|sort|wc -l
> > > > 127
> > > > the error is mainly
> > > > *Error - can't write to file
> > > > '/sys/class/net/gre128/batman_adv/mesh_iface': Cannot allocate memory
> > > [...]
> > [...]
> > > I would guess that your system mostly fails becauseit  cannot handle the
> > > allocation of the "large" arrays which store:
> > [...]
> > 
> > Looks like their could also be a different problem when your test system uses 
> > signed characters by default. Please try the patch [1] which changes the type 
> > from char/s16 to unsigned int.
> [...]
> > [1] https://patchwork.open-mesh.org/patch/17247/
> 
> Were you able to run some tests?

Would be good to have this tested because we already missed the Linux 4.15 
release.

Kind regards,
	Sven


--nextPart2817755.XncDFrWVSs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlp1Z6QACgkQXYcKB8Em
e0bkpw//Tr7E30NwmSMhibnw3HKKkwLhEHjZgvWR8jZF5FlExRNxBl4qd77w196T
rZkMR8oa9VXKR7/8bzsAgZT9KVc6LrCCkY3RQWUidWAx9nOE5dW/wYZlvuBtVve4
VPRA7+sLeRVkqKFf90zVKgCUK4kvB7/uXY3gxnIhLXswwQF22wOiw0jvJz5G7KOs
cmAf8A+uiHSfEqz60kT+1u1s58kN+bnXnRToyR8TCmNJM+rck/kmOruH8f/ktFs6
ujeK8cWkgRXAnjY1G/bUcm6NQ8jl5Fixrl8MY5t1c0r0O5lInQhP8+YL3dF27EJ2
BSeW0rDJd5c1F0thItveSMBJxZlkfHyXeU18g+G6wFvsLvXDl+mDcw0YmU95Lj91
AbBxuwqlL7nkGh4w5dMlOeEjHLUvbnVzPhuN/mwftf6TRVOfYB6dv4kMaLDTZU7C
xt3f4INqwVTSqtSLFxqGsnuTOSXUAbI2Q/B/ltMI4TVqSCKMXPbE+eLnVsxT93nO
SNE+X+7BpyWlKomgvSkW678PoGCGh1aJ0rdHwl/dc3CHqvvEit6PJq/aD2Zfftql
60wCNPmji6WLUuZaN4MGa/cx0zfLuPwrBkaSO26KzgFTwk5oKMggK8Yf5I9yRLDN
Acq9BNvl28qOBdm/XcvnnLFPTbeVJvsq18R/Vvb4x26y9LMED40=
=FDA7
-----END PGP SIGNATURE-----

--nextPart2817755.XncDFrWVSs--

