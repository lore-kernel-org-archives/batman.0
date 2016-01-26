Return-Path: <a@unstable.cc>
Date: Tue, 26 Jan 2016 13:55:07 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160126055507.GD9299@prodigo>
References: <1453312110-32683-1-git-send-email-andrew@lunn.ch>
 <1453312110-32683-3-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1453312110-32683-3-git-send-email-andrew@lunn.ch>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/4] batman-adv: Create batman soft
 interfaces within correct netns.
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

On Wed, Jan 20, 2016 at 06:48:28PM +0100, Andrew Lunn wrote:
> When creating a soft interface, create it in the same netns as the
> hard interface. Replace all references to init_net with the correct
> name space for the interface being manipulated.
> 
> Suggested-by: Daniel Ehlers <danielehlers@mindeye.net>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Acked-by: Antonio Quartulli <a@unstable.cc>

-- 
Antonio Quartulli
