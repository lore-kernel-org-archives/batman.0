Return-Path: <davem@davemloft.net>
Date: Tue, 10 Apr 2012 14:26:26 -0400 (EDT)
Message-Id: <20120410.142626.796731994824309878.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <4234545.h1xVgDKcJ2@bentobox>
References: <1333824598-27771-1-git-send-email-ordex@autistici.org>
	<20120410.122119.454371140692964064.davem@davemloft.net>
	<4234545.h1xVgDKcJ2@bentobox>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] pull request: batman-adv 2012-04-07
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
To: sven@narfation.org
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 10 Apr 2012 20:03:43 +0200

> On Tuesday, April 10, 2012 12:21:19 PM David Miller wrote:
>> From: Antonio Quartulli <ordex@autistici.org>
>> Date: Sat,  7 Apr 2012 20:49:42 +0200
>> 
>> > this is the updated and cleaned up version of our last pull request
>> > (sent on 2012-04-05).
>> 
>> You absolutely must base your tree off the correct tree, which is
>> net-next
>> 
>> You cannot use Linus's tree or my 'net' tree to base your work,
>> because otherwise when I pull I get all the damn crap that's in those
>> trees but not in net-next yet and that's never right.
> 
> Can you please tell us your "stable point" [1].

Please, just base your work on the current tip of net-next like the
rest of the networking developers do.  I haven't once ever had to
talk about "stable point" or anything like that, you just simply
work against the tip of my tree and that's the end of it.

