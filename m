Return-Path: <linus.luessing@web.de>
Date: Sat, 11 Oct 2014 12:32:22 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20141011103222.GD31424@odroid>
References: <1412975746-6856-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1412975746-6856-1-git-send-email-linus.luessing@web.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: fix counter for
 multicast supporting nodes
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

On Fri, Oct 10, 2014 at 11:15:46PM +0200, Linus Lüssing wrote:
> A miscounting of nodes having multicast optimizations enabled can lead
> to multicast packet loss in the following scenario:
> 
> If the first OGM a node receives from another one has no multicast
> optimizations support (no multicast tvlv) then we are missing to
> increase the counter. This potentially leads to the wrong assumption
> that we could safely use multicast optimizations.
> 
> Fixings this by increasing the counter if the initial OGM has the
> multicast TVLV unset, too.
> 
> Introduced by 77ec494490d60d89b42cd01d5dbf8dee04503623
> ("batman-adv: Announce new capability via multicast TVLV")
> 
> Signed-off-by: Linus Lüssing <linus.luessing@web.de>
> ---
>  multicast.c |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Reported-by: Tobias Hachmer <tobias@hachmer.de>
