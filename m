Return-Path: <andrew@lunn.ch>
Date: Wed, 5 Dec 2012 11:35:27 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20121205103527.GC26922@lunn.ch>
References: <1371478.oVHDQkQ7OX@sven-desktop.home.narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1371478.oVHDQkQ7OX@sven-desktop.home.narfation.org>
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi Sven

I've been working on Marvell SoC chips for the last few months, mostly
those used in NAS devices. Maybe a few comments from a different
corner of the kernel may be useful. But this corner is also quite
different, so not everything i say bellow may be relevant for BATMAN.
We are about the same size in terms of number of active developers,
but our methodology is quite different.

It seems like the biggest problem is the late feedback from David
S. Miller, et al, about patches. Getting this feedback earlier in the
life of a patchset would easy people lives.

For Marvell work, we post all our patches to the linux arm kernel
list, where the ARM maintainers will see the patches. All patches go
there, in all stages of their life, from early RFCs, to patches we
want the upstream maintainers to take in a following pull request.
Thus there is the possibility to get early feedback from the upstream
maintainers and avoid most last minutes surprises.

So maybe it would be good to stop using BATMAN mailing list for
patches and instead use netdev. Or at least CC: netdev.

We try, but often fail, to send pull requests early. The arm-soc
maintainers will accept pull requests at any time and queue them up in
there for-next tree. Sending pull request during -rc2 or -rc3 is not a
problem and if the maintainer decides to reject it, you have a few
weeks before -rc6/-rc7 and impending opening of the merge window.

We don't have anything like a master tree. Each developers work on his
own clone of linus's tree, generally on the last -rc tag. We have a
nominal lead maintainer, who builds trees for pull requests direction
arm-soc maintainers. This maintainer takes either patches from the
linux-arm-kernel mailing list, or pull request from other Marvell
developers, shapes up the tree in the form the arm-soc maintainer
likes, and sends pull-requests when ready. The tree is then throw
away.

The BATMAN master tree, if i understand correctly, is to allow
releases for older kernels? Maybe turn the process around? When Linus
makes a release, pull the mainline code into a branch, add in the
compat stuff and release a tarball from that? If any stable patch
touches the batman code, again, import it and make a new tarball.

We also make use of the -rc tags and the around 7 weeks before final
release for testing. Testing of these releases probably has more value
than testing of BATMAN master, or for-next, since any other changes in
the stack are included and issues because of changes outside of BATMAN
will be found. I've never had problems getting fixes into -rc
releases.

Just some ideas....

     Andrew
