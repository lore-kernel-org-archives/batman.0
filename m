Return-Path: <andrew@lunn.ch>
Date: Thu, 28 Jan 2016 04:50:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20160128035011.GC28633@lunn.ch>
References: <1453312110-32683-1-git-send-email-andrew@lunn.ch>
 <20160128025934.GD22112@prodigo.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160128025934.GD22112@prodigo.lan>
Subject: Re: [B.A.T.M.A.N.] [PATCH 0/4] batman-adv: Add network name space
	support
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

> Andrew,
> 
> I guess that after this patchset gets applied we need to change batctl and
> provide some "netns" argument similar to ip ?

I have patches already. No new arguments needed. batctl and alfred
simply manipulate BATMAN in the current netns.

       Andrew
