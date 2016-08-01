Return-Path: <linus.luessing@c0d3.blue>
Date: Mon, 1 Aug 2016 22:57:16 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160801205716.GB9200@otheros>
References: <1469137112-24094-1-git-send-email-linus.luessing@c0d3.blue>
 <1469137112-24094-2-git-send-email-linus.luessing@c0d3.blue>
 <3501664.k16G2TetvL@sven-edge> <6419172.04lP9a1mmf@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6419172.04lP9a1mmf@sven-edge>
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Fri, Jul 22, 2016 at 12:19:54AM +0200, Sven Eckelmann wrote:
> On Donnerstag, 21. Juli 2016 23:59:30 CEST Sven Eckelmann wrote:
> > On Donnerstag, 21. Juli 2016 23:38:32 CEST Linus Lüssing wrote:
> > > -       struct hlist_head mla_list;
> > > +       struct hlist_head mla_list; /* protected by mcast.work */
> > 
> > Protected by a workqueue item? How?
> 
> Looks like you wanted to say here that it is only modified inside the worker 
> queue (via the mcast.work delayed workqueue item) - unless it is not done this 
> way like in batadv_mcast_free after cancel_delayed_work_sync.

Exactly :). I tried to "summarize" that a little to make it fit as an
inline comment ;). (although there are some further kerneldoc remarks on
the functions using it)

Is it ok now or do you think I should add something like your
explanation somewhere else?
