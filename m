Return-Path: <andrew@lunn.ch>
Date: Sat, 23 Jan 2016 18:20:06 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20160123172006.GA3880@lunn.ch>
References: <1453312110-32683-1-git-send-email-andrew@lunn.ch>
 <1453312110-32683-2-git-send-email-andrew@lunn.ch>
 <20160123020637.GA32607@prodigo.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160123020637.GA32607@prodigo.lan>
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

On Sat, Jan 23, 2016 at 10:06:37AM +0800, Antonio Quartulli wrote:
> On Wed, Jan 20, 2016 at 06:48:27PM +0100, Andrew Lunn wrote:
> > The batX soft interface should not be moved between network name
> > spaces. This is similar to bridges, bonds, tunnels, which are not
> > allowed to move between network namespaces.
> > 
> 
> Andrew,
> I understand bridges and other similar interfaces do the same, but what
> is the real reason for preventing a batman soft-interface from moving
> between namespaces?

Humm, actually, a good question. I blindly copied this code without
thinking about it.

One clear answer is the notification mechanism, used by
batadv_hard_if_event(). As far as i can see, such events are only sent
within the interfaces namespace. So for example you hot unplug a hard
interface which the soft interface is using, you would not get the
NETDEV_DOWN event if the soft interface is in a different namespace.

Now that i think of it, there are a few other reasons. All the
interface management calls, and displaying of interface names would
have to contains the namespace. Otherwise you look at the output for
'batctl o' and have no idea which namespace that wlan0 interface is
from. Remember, interface names are only unique within a namespace,
not across namespaces.

namespaces are supposed to be as transparent as possible. Applications
are not supposed to know they are in a name space. That goes right out
the window as soon as you need to include a namespace into every
interface name.

	  Andrew
