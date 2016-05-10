Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 10 May 2016 02:30:48 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160510003048.GL5816@otheros>
References: <1462464426-13014-1-git-send-email-linus.luessing@c0d3.blue>
 <1811882.4NqUN7GsV2@sven-edge> <20160510000311.GJ5816@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160510000311.GJ5816@otheros>
Subject: Re: [B.A.T.M.A.N.] [PATCHv14 0/4] Multicast optimizations for
	bridges
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

On Tue, May 10, 2016 at 02:03:11AM +0200, Linus Lüssing wrote:
> On Thu, May 05, 2016 at 11:15:28PM +0200, Sven Eckelmann wrote:
> > On Thursday 05 May 2016 17:07:01 Linus Lüssing wrote:
> > > This patchset can be found in the current linus/multicast-bridge
> > > branch.
> > 
> > Please check the attached results of the daily build test scripts.

Is it possible for the scripts to tell why it wants an include for
linux/kernel.h? Currently can't find any function multicast.c
might want from it.
