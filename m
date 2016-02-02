Return-Path: <andrew@lunn.ch>
Date: Tue, 2 Feb 2016 03:11:40 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20160202021140.GA12673@lunn.ch>
References: <1453312110-32683-1-git-send-email-andrew@lunn.ch>
 <1453312110-32683-4-git-send-email-andrew@lunn.ch>
 <1988230.TvXLEl4ULW@bentobox> <20160201025755.GO22112@prodigo.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160201025755.GO22112@prodigo.lan>
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/4] batman-adv: Handle parent interfaces
 in a different netns
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Antonio Quartulli <a@unstable.cc>
Cc: b.a.t.m.a.n@lists.open-mesh.org

On Mon, Feb 01, 2016 at 10:57:55AM +0800, Antonio Quartulli wrote:
> On Wed, Jan 27, 2016 at 11:13:53AM +0100, Sven Eckelmann wrote:
> > On Wednesday 20 January 2016 18:48:29 Andrew Lunn wrote:
> > > nameplace, so also retrieve the parents name space when finding the
> > 
> > s/nameplace/namespace/ ?
> > 
> > > Additionally, veth devices come in pairs and they are each others
> > > parents. Don't infinitely recurse in this situation.
> > 
> > Can we have this part as extra patch so Antonio can ask David for a stable 
> > backport?
> 
> Andrew,
> 
> do you have any plan about resending this fix ?
> Sven also sent a pair of fixes and it would be nice I could send everything in
> on pull request.

Sorry, been in the wilderness the last few days.

I will try to resend tomorrow. If not, it will be Thursday.  If you
want it sooner, feel free to fix it up yourself and add your own
Signed-off by, next to mine.

	   Andrew
