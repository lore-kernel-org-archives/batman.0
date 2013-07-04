Return-Path: <linus.luessing@web.de>
Date: Thu, 4 Jul 2013 07:06:50 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20130704050650.GA2156@Linus-Debian>
References: <1372889002-6767-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1372889002-6767-1-git-send-email-linus.luessing@web.de>
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

And the sysfs file 'mcast_group_awareness' got renamed to
'multicast_mode'. The missing ABI documentation for this file was
added, too.

On Thu, Jul 04, 2013 at 12:03:18AM +0200, Linus Lüssing wrote:
> This is the seventh revision of the basic multicast optimization patches.
> 
> It adds the style changes as suggested by Marek via eMail.
> 
> It also adds various suggestion from IRC (for instance adding kerneldoc for the
> functions touched in translation-table.c, making the counter an atomic
> one to be on the safe side for some "exotic" targets).
> 
> 
> PATCHv7 4/4 is a new one and the result of a longer discussion on IRC:
> Whether to add some support for some IPv4 addresses already for the cost of
> a slightly larger complexity both code and documentation wise
> - for a case which is uncommon for most mesh networks anyway: a mesh
> with no bridges on any node involved.
> 
> So the fourth patch is sort of an RFC patch one, too (although the consense/
> tendency on IRC so far was to add and support this case).
> 
> If everyone is fine with that concept, then I can also easily merge it
> into patches 2/4 and 3/4 (if that is desired).
> 
> Cheers, Linus
