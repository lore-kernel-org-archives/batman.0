Return-Path: <linus.luessing@c0d3.blue>
Date: Wed, 31 May 2017 16:20:13 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20170531142013.GD29826@otheros>
References: <OF367AF97D.9569B75C-ONC1258131.00480417-C1258131.00491EA2@phoenixcontact.com>
 <13855542.45yYzsjnKj@prime>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <13855542.45yYzsjnKj@prime>
Subject: Re: [B.A.T.M.A.N.] MAC addresses of loop detect frames in global
 translation-table
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

On Wed, May 31, 2017 at 03:39:23PM +0200, Simon Wunderlich wrote:
> Hi Andreas,
> 
> yes, those are loop detection packets. Preventing these entries from the local 
> translation table has been implemented only recently. We can potentially do 
> the same for global addresses as well, it just hasn't been done so far ... at 
> least I don't see a reason prevening us from that. It is probably added by 
> "speedy join" in the first place.

This was the case at least for me. Andreas, do yours have the
temporary flag set, too?

I'm wondering why these packets end up in the mesh in the first
place. (Preventing things as late as in tt_gobal_add() / on
mesh receiving nodes seems like a workaround?)

Regards, Linus
