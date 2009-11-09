Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 9 Nov 2009 22:39:01 +0800
References: <200911082144.49637.lindner_marek@yahoo.de>
	<591bc9930911090043mf62cd17tac8033d316002a18@mail.gmail.com>
In-Reply-To: <591bc9930911090043mf62cd17tac8033d316002a18@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200911092239.01984.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv 0.2 released
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

On Monday 09 November 2009 16:43:33 Donald Gordon wrote:
> I have a feature request -- has there been any consideration to getting
> batman-adv to fragment ethernet frames, so as to get a 1500 byte MTU
> batman-adv network running on top of a 1500 byte MTU ethernet network? 
>  This would be a useful feature for people trying to reuse whatever random
>  ethernet networks happen to be nearby to extend their mesh, while not
>  requiring the mesh users to all configure a lower MTU.  And the support
>  you've announced for combining small ethernet frames into larger
>  batman-adv frames means that the overhead might not be too bad.

You will need quite some code to implement a good fragmentation but even if 
you find the time to do so it comes with a severe performance penalty. 
Imagine a payload packet comes in (1500 bytes), batman-adv adds its stuff (24 
bytes) and then we make 2 packets out of it: one 1500 Bytes and one 24 Bytes 
(probably a bit more for fragmentation handling). Now you have 2 packets 
instead of one! Wired networks tend to avoid it (which is why applications 
tried to determine the PMTU) - wireless networks should avoid it even more 
because if you loose one of the packets both need to be retransmitted. 

You can handle this issue elegantly by increasing the MTU of the mesh 
interfaces. Most wifi cards / drivers already accept MTUs greater than 1500 
bytes and most ethernet cards do as well.

Nevertheless, it might be neat to have fragmentation as a fallback mechanism. 
Be sure we review and submit your code as soon as it is available.  :)

Regards,
Marek
