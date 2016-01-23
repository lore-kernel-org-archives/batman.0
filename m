Return-Path: <a@unstable.cc>
Date: Sat, 23 Jan 2016 10:06:37 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160123020637.GA32607@prodigo.lan>
References: <1453312110-32683-1-git-send-email-andrew@lunn.ch>
 <1453312110-32683-2-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1453312110-32683-2-git-send-email-andrew@lunn.ch>
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
To: Andrew Lunn <andrew@lunn.ch>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Wed, Jan 20, 2016 at 06:48:27PM +0100, Andrew Lunn wrote:
> The batX soft interface should not be moved between network name
> spaces. This is similar to bridges, bonds, tunnels, which are not
> allowed to move between network namespaces.
> 

Andrew,
I understand bridges and other similar interfaces do the same, but what
is the real reason for preventing a batman soft-interface from moving
between namespaces? I tried to figure this put myself, but I couldn't
find a real technical reason for that

(note - I am not a namespace expert as I am just learning now how they
work)

Cheers,

-- 
Antonio Quartulli
