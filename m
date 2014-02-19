Return-Path: <whangarei.hamburg.freifunk.net@gmx.de>
Message-Id: <4F5A043B-6BFB-46F0-9D14-BDF07F2533E0@gmx.de>
From: whangarei & opua <whangarei.hamburg.freifunk.net@gmx.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v936)
Date: Wed, 19 Feb 2014 21:56:35 +0100
Subject: [B.A.T.M.A.N.] Suggestion for routing improvement on poor links
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Hi all,

have running batman-adv 2013.4.0 on a hamburg.freifunk.net out-of-the- 
box router.
Have 3 uplinks over Wlan, with trees in the way and some rain at this  
time... So not perfect conditions...

Have seen via 'batctl o' 3 uplinks to the other side of the park.  
(logging was unfortunately not compiled in)
Of cause, one was the best link based on the metric (or what you  
called it) at this time.

But also seen that the metric was not changed during packet lost =>  
increased last-seen time on this best link :-(

So there was a entry with a last-seen of up to 180 sec while other  
links have had much better update times because of less packet lost,  
but not so good metric like the main link at his 'best time'.
So the 'old' best link was also active, at least by the metric shown  
by 'batctl o'. Expect the traffic will be sent to this way...

Is it maybe a good idea to decrease the metric after a last seen time  
of a links has increased 15 or 20 sec, step by step on the best link  
(or all links with increased last seen time) , so a more reliable link  
( at this time) has a chance to be activated? I only think about the  
local routing decision, not about to announce anything to a neighbor...

Sorry, have not much experiences with Wlan links, also be not familiar  
with programming, but with some layer 3 routing protocols... Hope you  
understand my issue anyway :)

By, Joe


