Return-Path: <andrew@lunn.ch>
Date: Tue, 19 Jan 2016 15:40:03 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20160119144003.GH6554@lunn.ch>
References: <1447443981-28246-1-git-send-email-sven@narfation.org>
 <569D85AB.9080403@unstable.cc> <20160119012226.GE26877@lunn.ch>
 <569E2D72.4010304@unstable.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <569E2D72.4010304@unstable.cc>
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: Remove recursive bat-on-bat
 netdevice check
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
Cc: Jetmir Gigollai <jetmir_gigollaj@web.de>, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

> > One of the issues i had is in this piece of code and with veth. The
> > other end of the veth can be in a different name space. Hence you
> > cannot look it up using the ifindex in the current name space. So i
> > made the code just exit with an O.K. if the parent device cannot be
> > found.
> 
> Is this really ok ? Isn't it possible to create "loops" by jumping from
> one namespace to the other ?

Quite possible. I took the easy option:

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index a5ce58a..a7a92ae 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -104,8 +104,12 @@ static bool batadv_is_on_batman_iface(const struct net_device *net_dev)
 
        /* recurse over the parent device */
        parent_dev = __dev_get_by_index(net, dev_get_iflink(net_dev));
-       /* if we got a NULL parent_dev there is something broken.. */
-       if (WARN(!parent_dev, "Cannot find parent device"))
+       /* if we got a NULL parent_dev, it might mean the parent is in
+        * a different network namespace. Things then get really
+        * complex, so lets just assume the user knows what she is
+        * doing.
+        */
+       if (!parent_dev)
                return false;
 
        ret = batadv_is_on_batman_iface(parent_dev);

I didn't spend the time to think all the possible loop situations
though. It is not too bad in that the software interface cannot be
moved into a different netns. Also, all the hard interfaces have to be
in the same netns as the soft interface. If you move a hard interface
into a different netns, it will automatically be removed from the soft
interface using the notification mechanism.

There are some other restrictions which help avoid loops. You cannot
in general move 'soft interfaces' between netns. You cannot move
bridge interfaces, tunnel interfaces, team/bonding interfaces, etc.

> exactly my point above! :)
> So this means that an interface A might have A.iflink pointing to a
> device in another namespace ?

Partly correct. The current code for getting the parent is:

parent_dev = __dev_get_by_index(net, dev_get_iflink(net_dev));

This is actually totally broken, when used with veth. It possible can
return a completely different interface than the parent, since the
ifindex returned for a veth could be in a different namespace. ifindex
is only unique within a namespace, not across name spaces.

I need to look deeper into the code and see if there is a different
parenting mechanism that can be used.

	  Andrew
