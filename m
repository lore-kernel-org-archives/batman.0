Return-Path: <linus.luessing@c0d3.blue>
Date: Thu, 21 Jul 2016 23:53:51 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160721215351.GL10173@otheros>
References: <1469137112-24094-1-git-send-email-linus.luessing@c0d3.blue>
 <1469137112-24094-2-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1469137112-24094-2-git-send-email-linus.luessing@c0d3.blue>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Use own timer for
 multicast TT and TVLV updates
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

On Thu, Jul 21, 2016 at 11:38:32PM +0200, Linus Lüssing wrote:
> Instead of latching onto the OGM period, this patch introduces a worker
> dedicated to multicast TT and TVLV updates.
> 
> The reasoning is, that upon roaming especially the translation table
> should be updated timely to minimize connectivity issues.
> 
> With BATMAN V, the idea is to greatly increase the OGM interval to
> reduce overhead. Unfortunately, right now this could lead to
> a bad user experience if multicast traffic is involved.
> 
> Therefore this patch introduces a fixed 500ms update interval for
> multicast TT entries and the multicast TVLV.

PS: And as a side-effect, removes the funny locking dependency
with the TT commit lock. Had still been nagging me, this tight
coupling between MC and TT.
