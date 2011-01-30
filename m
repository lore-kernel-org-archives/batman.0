Return-Path: <linus.luessing@web.de>
Date: Sun, 30 Jan 2011 05:49:44 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20110130044944.GA7878@Sellars>
References: <1295659302-7171-1-git-send-email-linus.luessing@saxnet.de>
	<1295659302-7171-8-git-send-email-linus.luessing@saxnet.de>
	<20110122220050.GA11480@pandem0nium>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20110122220050.GA11480@pandem0nium>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] [PATCH 07/19] batman-adv: Prepare and send
	own	multicast tracker packets
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

> dest_entries[...].list should be initialized here too, shouldn't they?
> BTW, the names a re a little bit confusing (dest_entries_list vs. dest_entries),
> other names and an explanation would be helpful.
Nope, afaik I don't need to initialize list items which I'm not
using as a list's head - list_add() will set the next and prev
pointers anyway.
Hmm, for the names I couldn't come up with something much better
yet - renamed dest_entries_list to dest_entries_buckets though, to
make it clearer that dest_entries are some reserved items which
will be sorted into the right buckets later.

Hmm, there are actually two lines of explanation in
mcast_tracker_packet_prepare():
 480         /* one dest_entries_buckets[x] per multicast group,
 481          * they'll collect dest_entries[y] items */
 482         int num_mcast_entries, used_mcast_entries = 0;
 483         struct list_head *dest_entries_buckets;
 484         struct dest_entries_list *dest_entries, *dest, *tmp;

Or do you mean that the term "dest_entries" is ambiguous; not
being clear if 'dest' is refering to a nexthop or a final
destination?

Cheers, Linus
