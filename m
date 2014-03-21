Return-Path: <linus.luessing@web.de>
Date: Fri, 21 Mar 2014 11:12:06 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20140321101205.GA6008@Linus-Debian>
References: <1629001.Cx5dbnsKCT@lappi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1629001.Cx5dbnsKCT@lappi>
Subject: Re: [B.A.T.M.A.N.] Batman-adv  + lxc
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

Hi Christof,

On Thu, Mar 20, 2014 at 07:59:16PM +0100, Christof Schulze wrote:
> Hello,
> 
> This is my first post to this list. I would like to run batman-adv
> inside an lxc-container just as described in [1]. I do not want to do it
> to simulate a network having multiple nodes but to separate duties of
> different "virtual machines" - linux containers in my case and to be
> able to easily migrate the configuration to a differen machine lateron.

lxc-container support has not been properly implemented in
batman-adv yet. So things are not always working "naturely" and can
even make your system crash (e.g. rebooting an lxc-container makes
your system crash [0]).

> 
> I started by loading batman-adv on the host and bridging it into the
> container.  After adding the interfaces inside the container where
> meshing should happen I cannot add a gateway because batctl complains
> that /sys/class/net/bat0/mesh does not exist. Indeed, in the container
> it does not exist.
> 
> How can batman-adv be used from an lxc-container?
> 

What I usually did was configuring batman-adv properly on the host
via batctl. And only in the end adding it to the lxc-container.
That seemed to work for me (except the reboot crash noted above).

Cheers, Linus

[0]: http://www.open-mesh.org/issues/179
