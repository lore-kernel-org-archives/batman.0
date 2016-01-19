Return-Path: <andrew@lunn.ch>
Date: Tue, 19 Jan 2016 02:22:26 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20160119012226.GE26877@lunn.ch>
References: <1447443981-28246-1-git-send-email-sven@narfation.org>
 <569D85AB.9080403@unstable.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <569D85AB.9080403@unstable.cc>
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Jetmir Gigollai <jetmir_gigollaj@web.de>

On Tue, Jan 19, 2016 at 08:39:07AM +0800, Antonio Quartulli wrote:
> Hi Sven and thanks for this RFC. Sorry for taking soo long to comment.
> 
> 
> 
> On 14/11/15 03:46, Sven Eckelmann wrote:
> > batman-adv checks in different situation if a new device is already on top
> > of a different batman-adv device. This is done by getting the iflink of a
> > device and all its parent. It assumes that this iflink is always a parent
> > device in an acyclic graph. But this assumption is broken by devices like
> > veth which are actually a pair of two devices linked to each other. The
> > recursive check would therefore get veth0 when calling dev_get_iflink on
> > veth1. And it gets veth0 when calling dev_get_iflink with veth1.
> > 
> 
> I agree that this check implemented this way represents a problem.
> However I also believe that we should still have some kind of prevention
> against this particular scenario (chain of batman interfaces), because
> if ignored it could lead to troubles.
> 
> Unfortunately I don't know how to implement this check in an elegant and
> extendible manner.
> 
> First of all we should add a check that follows the master interface,
> but at the same time we should still follow the iflink, otherwise we
> can't check relationships like VLAN_DEV->REAL_DEV. But how to implement
> the latter without hitting the cyclic case is not clear to me ..
> 
> An option is to add a specific check for veth and break the recursion,
> but this is not really nice, because the next time a cyclic interface
> type will be introduced our check will become troublesome again.
> 
> Suggestions?

Hi Antonio

I've got a set of patches i went to send out as soon, once net-next
reopens. They add support for network name spaces.

One of the issues i had is in this piece of code and with veth. The
other end of the veth can be in a different name space. Hence you
cannot look it up using the ifindex in the current name space. So i
made the code just exit with an O.K. if the parent device cannot be
found.
 
Something to think about when redesigning this code. The parent could
be in a different network stack!

You probably can handle veth and both ends in the same namespace. It
should not be too difficult to detect two interfaces which are the
parent of each other. You just need to keep a bit more state when
doing the recursion. It does however get more complex when there are
more than two devices in a parent loop. But can that happen?

   Andrew
