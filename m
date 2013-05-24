Return-Path: <linus.luessing@web.de>
Date: Fri, 24 May 2013 11:00:50 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20130524090050.GA8944@Linus-Debian>
References: <1369382549-8787-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1369382549-8787-1-git-send-email-linus.luessing@web.de>
Subject: Re: [B.A.T.M.A.N.] Basic Multicast Optimizations
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

On Fri, May 24, 2013 at 10:02:25AM +0200, Linus Lüssing wrote:
> This is the second revision of the basic multicast optimization patches.
> It includes one functional fix and many style fixes, thanks to Antonios
> feedback.
> 
> Three things were not included from these suggestions:
> 
> * The default mcast TVLV flags were left as it is not as easy to
> switch. (see answer/explanation to [PATCH 2/3])
> * for_each_pmc_rcu() was not moved to a commen net header file,
> only a TODO was added. Will do that after this code might have
> landed in net.
* VLAN support was not added yet as this will be some more work. Any
vlan frames with a multicast destination will still get flooded
for now so at least these patches shouldn't introduce any
regressions for those. However I have to admit that I didn't think
of VLANs yet and Marek suggested to check how much extra work it
might create later compared to adding that right from the start.
I'll have a look at that.

> 
> 
> Additionally the limitation of 255 multicast listeners per originator
> was removed (it was more a relic of the pre-TT announcement mechanism
> and such limitations should be taken care of by the current TT
> infrastructure instead).
> 
> Cheers, Linus
