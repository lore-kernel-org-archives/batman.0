Return-Path: <alex.suykov@gmail.com>
Date: Mon, 6 Apr 2015 17:27:58 +0300
From: Alex Suykov <alex.suykov@gmail.com>
Message-ID: <20150406142758.GA16243@vostro>
References: <20150401171821.GA21008@vostro> <1834234.ImvpviMFU3@sven-edge>
 <20150401215302.GA25434@vostro> <4593170.BoRA6mpdPI@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4593170.BoRA6mpdPI@sven-edge>
Subject: Re: [B.A.T.M.A.N.] musl build fixes
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

Thu, Apr 02, 2015 at 08:39:32AM +0200, Sven Eckelmann wrote:

> > Moving linux/types.h to packet.h does make sense I think.
> > However, it also brings linux/if_ether.h there, which immediately
> > makes musl support difficult. Maybe even impractical.
> 
> The maintainers rejected the use of __KERNEL__ checks when Markus Pargmann
> wanted to use them [1]. So I may have to modify my patch to move bitops and
> if_ether.h back to main.h. Maybe you can try to modify your packet.h as seen
> in the new version of "[PATCHv3 2/4] batman-adv: Add required to includes to
> all files" which I will send in some minutes. Would be nice when this version
> + your linux/if_ether.h -> netinet/if_ether.h would work with musl.

Not only it works, it also turns out to be shortest musl-fixes patch so far.
With linux/types.h in packet.h, I only need to replace linux/if_ether.h
with netinet/if_ether.h to get a successful musl build.
