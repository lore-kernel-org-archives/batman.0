Return-Path: <andrew@lunn.ch>
Date: Wed, 5 Dec 2012 12:39:27 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20121205113927.GF26922@lunn.ch>
References: <1371478.oVHDQkQ7OX@sven-desktop.home.narfation.org>
 <20121205103527.GC26922@lunn.ch> <6578542.D9nnFXgRvc@bentobox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6578542.D9nnFXgRvc@bentobox>
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
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

> The biggest different is the "lets install a whole kernel to test this change" 
> methodology ;)

Yes, i generally do that, test a whole kernel, not a module. But...

> Usually (please correct me) batman-adv is developed outside the kernel because 
> it is easier to test stuff and it worked till now. No one of us wants to port 
> the latest OpenWrt to the -rc kernel to test stuff ;)

Do you actually need to port to OpenWrt?

How i work is build a kernel, with everything i need built in. No
modules. Then tftpboot the kernel, and use the rootfs from the
disk. Why not do the same with OpenWrt?

> > It seems like the biggest problem is the late feedback from David
> > S. Miller, et al, about patches. Getting this feedback earlier in the
> > life of a patchset would easy people lives.
> 
> Partly, David switches horses relative often. So an early feedback is not as 
> valuable as it sounds.

O.K. I've not paid enough attention to his comments to know this.

> > For Marvell work, we post all our patches to the linux arm kernel
> > list, where the ARM maintainers will see the patches. All patches go
> > there, in all stages of their life, from early RFCs, to patches we
> > want the upstream maintainers to take in a following pull request.
> > Thus there is the possibility to get early feedback from the upstream
> > maintainers and avoid most last minutes surprises.
> > 
> > So maybe it would be good to stop using BATMAN mailing list for
> > patches and instead use netdev. Or at least CC: netdev.
> 
> I'll tried it in the netdev_alloc/standard interface patchset but I got only a 
> surprised "where is the pull request?" reply.

Humm, interesting. Is that maybe because BATMAN only ever sends pull
requests to the list?

	 Andrew
