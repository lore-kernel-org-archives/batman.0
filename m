Return-Path: <andrew@lunn.ch>
Date: Thu, 28 Apr 2016 22:46:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20160428204610.GA11920@lunn.ch>
References: <1461875848-11720-1-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1461875848-11720-1-git-send-email-andrew@lunn.ch>
Subject: Re: [B.A.T.M.A.N.] [PATCH 00/10] netns and netlink support
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.net>

On Thu, Apr 28, 2016 at 10:37:18PM +0200, Andrew Lunn wrote:
> This patchset completes netns support, by disabling debugfs entries
> when not in the default name space, and correctly handling interface
> stack loops when the parent is in a different name space.
> 
> It additionally adds netlink support for most of the information found
> in debugfs, and is netns awaire.
> 
> Note: BLA is untested, so best assume it is broken...

I forgot to add, no attempt has been made to compile this on older
kernels. So it probably does not...

	 Andrew
