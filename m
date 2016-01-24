Return-Path: <andrew@lunn.ch>
Date: Sun, 24 Jan 2016 17:46:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20160124164611.GM3880@lunn.ch>
References: <1453312110-32683-1-git-send-email-andrew@lunn.ch>
 <1453312110-32683-2-git-send-email-andrew@lunn.ch>
 <20160123020637.GA32607@prodigo.lan>
 <20160123172006.GA3880@lunn.ch> <20160124061959.GC6148@prodigo.lan>
 <20160124104226.GA428@prodigo.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160124104226.GA428@prodigo.lan>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/4] batman-adv: NETIF_F_NETNS_LOCAL
 feature to prevent netns moves
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
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

> > This raises another question (maybe addressed by another of your patch?): what
> > happens if an hard-interface currently enslaved in bat0 changes namespace?
> > Will this result in an UNREGISTER event like when the interface gets destroyed?
> > If not, I am not sure how the whole situation can still be consistent.
> 
> It seems that an UNREGISTER event is broadcasted when an hardif goes to another
> namespace. At net/dev/core.c:4915
> 
> Therefore batman-adv will do the right thing :)

Correct. An interface is effectively hotplugged from one namespace to
another.

	Andrew
