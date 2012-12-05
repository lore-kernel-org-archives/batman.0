Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 05 Dec 2012 12:23:02 +0100
Message-ID: <6578542.D9nnFXgRvc@bentobox>
In-Reply-To: <20121205103527.GC26922@lunn.ch>
References: <1371478.oVHDQkQ7OX@sven-desktop.home.narfation.org>
 <20121205103527.GC26922@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1362444.mgbqeNkG1g";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] RFC: Removing one indirection layer for patches
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


--nextPart1362444.mgbqeNkG1g
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

thanks a lot about this mail. I'll add some extra comments without any 
judgements. Your mail mostly talks about other things which are orthogonal to 
the "anti-thesis"

On Wednesday 05 December 2012 11:35:27 Andrew Lunn wrote:
> I've been working on Marvell SoC chips for the last few months, mostly
> those used in NAS devices. Maybe a few comments from a different
> corner of the kernel may be useful. But this corner is also quite
> different, so not everything i say bellow may be relevant for BATMAN.
> We are about the same size in terms of number of active developers,
> but our methodology is quite different.

The biggest different is the "lets install a whole kernel to test this change" 
methodology ;)

Usually (please correct me) batman-adv is developed outside the kernel because 
it is easier to test stuff and it worked till now. No one of us wants to port 
the latest OpenWrt to the -rc kernel to test stuff ;)

> It seems like the biggest problem is the late feedback from David
> S. Miller, et al, about patches. Getting this feedback earlier in the
> life of a patchset would easy people lives.

Partly, David switches horses relative often. So an early feedback is not as 
valuable as it sounds.

> For Marvell work, we post all our patches to the linux arm kernel
> list, where the ARM maintainers will see the patches. All patches go
> there, in all stages of their life, from early RFCs, to patches we
> want the upstream maintainers to take in a following pull request.
> Thus there is the possibility to get early feedback from the upstream
> maintainers and avoid most last minutes surprises.
> 
> So maybe it would be good to stop using BATMAN mailing list for
> patches and instead use netdev. Or at least CC: netdev.

I'll tried it in the netdev_alloc/standard interface patchset but I got only a 
surprised "where is the pull request?" reply.

> We try, but often fail, to send pull requests early. The arm-soc
> maintainers will accept pull requests at any time and queue them up in
> there for-next tree. Sending pull request during -rc2 or -rc3 is not a
> problem and if the maintainer decides to reject it, you have a few
> weeks before -rc6/-rc7 and impending opening of the merge window.

We also don't have this problem of getting patches accepted in -rc2 and -rc3. 
But it is funny that David's net-next/net tree hasn't catched the fresh air of 
the last -rc1.

[...]

> The BATMAN master tree, if i understand correctly, is to allow
> releases for older kernels? Maybe turn the process around? When Linus
> makes a release, pull the mainline code into a branch, add in the
> compat stuff and release a tarball from that? If any stable patch
> touches the batman code, again, import it and make a new tarball.

So the compat-driver style. I'll played around with the idea for a while but 
never came up with a working solution without a lot of extra hassle.

Kind regards,
	Sven
--nextPart1362444.mgbqeNkG1g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIbBAABCgAGBQJQvy6WAAoJEF2HCgfBJntGJ5kP+IU8dUTbqHyvigXOFqpO4jnh
XlwDVFJ0BRR5MmwzAXW0EYPH5kf4UmBdergcW1r6TdmN4lh+usObN7ENLE9eJyw3
ErFCXmxV6Kfsd3zWEO1bFWPO0q2D2Rr9lxdkXeL5VO+62kfeiJTg7xoM5t9C99lB
8Nt38oahOVFMHvO5XmGlWhRZeeZmfQtslFKUNlhuQBM53MIDrJOtyhehVKvKMpD1
8TfRR7n0v21EbKf0H7NbA11KkueEXlxzjeuOiyqyHTEfSZp4IVCPeDvd2bW4TyWX
ttuI7LlcZ/zKVkeyU28WVJOQUI19Vcoc438IrkmMuGur+PZbXEbWfFP2uu895dE6
8aRKY9WKdmaOewRE2cLUagmW4XGISJGji0l8Se3aKd2r6nonn3w0B3J62B7zVn0/
ePpLDEZWcj5qjTFValJP4vwJMQolFcPqmhau/7JEhse0ezVzzx3K9GHLMC39PYEr
Jbd3iNMw5LSadgW7CCiVUHOf9rNj775UsHmkrOp7huxguF7I2emPOFxL/xUN+ZOq
DYPE78z2Augy8gbcxp9ntjJB2b23qf/7BbXJNzQeWDLJgk/wa7QzAIsRPuNriCSt
lAsck7WnKufl5FC8JtO4gnnRxM7smgr3J5iPf8TRK700g54EAnm7tGGunsvnFuxR
hRbMgKH165qQiKGJaRg=
=Z4Lz
-----END PGP SIGNATURE-----

--nextPart1362444.mgbqeNkG1g--

