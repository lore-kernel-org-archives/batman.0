Return-Path: <linus.luessing@web.de>
Date: Thu, 15 Aug 2013 20:25:25 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20130815182525.GB8728@Linus-Debian>
References: <1376382240-30664-1-git-send-email-linus.luessing@web.de>
 <20130815135647.GB1982@pandem0nium>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20130815135647.GB1982@pandem0nium>
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Thu, Aug 15, 2013 at 03:56:47PM +0200, Simon Wunderlich wrote:
> Hey Linus,
> 
> I've tested the patchset, and it looks good from my testcases (testing
> multicast to IPv4 and IPv6 addresses). I've not tested the MLD stuff
> though, but from our discussions your implementation looks reasonable.
> Did you get to test it somehow?

Yes, I was testing it with the following patch from the branch
linus/multicast-bridge:

"debug: batman-adv: manual querier flag sysfs switch" (e947548bf)


> 
> From my perspective, if you fix the orig list stuff we could integrate
> your patchset. I'd like to ask others to review the patchset too. :)
> 
> Thanks,
> 	Simon


