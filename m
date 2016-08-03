Return-Path: <linus.luessing@c0d3.blue>
Date: Wed, 3 Aug 2016 23:25:53 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160803212552.GB16866@otheros>
References: <1470083926-6409-1-git-send-email-linus.luessing@c0d3.blue>
 <1470083926-6409-2-git-send-email-linus.luessing@c0d3.blue>
 <1883810.ghV8D0sdkC@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1883810.ghV8D0sdkC@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 2/2] batman-adv: Simple (re)broadcast
 avoidance
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

On Wed, Aug 03, 2016 at 09:59:27PM +0200, Sven Eckelmann wrote:
> Isn't this causing the reference counting cycle (aka really, really,
> really bad):

Hm, I see what you are getting at. Could indeed be a nasty bug...

But, actually, just tested in VMs, seems like I'm getting a call to
batadv_hardif_neigh_release() just fine. Which means it counted to
zero successfully o_O?

I don't understand why it seems to work right now :D. Will dig deeper.
