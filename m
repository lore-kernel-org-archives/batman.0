Return-Path: <linus.luessing@c0d3.blue>
Date: Fri, 22 Jul 2016 13:46:24 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160722114624.GM10173@otheros>
References: <201303071427.27817.lindner_marek@yahoo.de>
 <1748353.QbLSAN5R7v@bentobox> <208604983.u8J89n5yfl@sven-desktop>
 <3014248.mnDyo0UFh2@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3014248.mnDyo0UFh2@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/5] batman-adv: Fix a potential
 bcast/ogm queue purging race condition (1)
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

On Fri, Jul 22, 2016 at 12:27:04AM +0200, Sven Eckelmann wrote:
> On Samstag, 9. April 2016 18:23:56 CEST Sven Eckelmann wrote:
> > On Thursday 10 March 2016 18:00:58 Sven Eckelmann wrote:
> > [...]
> > 
> > > It looks like this patch and the other two don't apply anymore. Can you
> > > please resent them or mark them correctly in patchwork [1, 2, 3].
> > > 
> > > Thanks,
> > > 
> > > 	Sven
> > > 
> > > [1] https://patchwork.open-mesh.org/patch/2798/
> > > [2] https://patchwork.open-mesh.org/patch/2812/
> > > [3] https://patchwork.open-mesh.org/patch/2786/
> > 
> > What is the state here?
> 
> What is the state of these three patches?
> 
> Kind regards,
> 	Sven

Hi Sven,

Looks like I'm still having this issue from time to time, even on
the master branch. Will try to refresh and rephrase them later.

Regards, Linus
