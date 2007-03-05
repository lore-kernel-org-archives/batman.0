Message-ID: <45EC5731.1020908@gmx.net>
Date: Mon, 05 Mar 2007 18:45:21 +0100
From: elektra <onelektra@gmx.net>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] How does BATMAN work?
References: <98187A60-42DA-440C-8DA7-8FCBD30A51D1@gmx.net>
In-Reply-To: <98187A60-42DA-440C-8DA7-8FCBD30A51D1@gmx.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

Hello Hendrik -

> 1. From open-mesh Docu: "Originators number their OGMs?, so other 
> nodes can decide whether they receive an originator-sequence-number 
> touple (OGSN) the first time or repeatedly"
>     What's the differens between in OGM and an OGSN? As far as I got 
> to know the protocol, there are just OGM-messages, aren't there?!?
You are right. Batman uses Originator messages, that contain at least a 
Originator address, a TTL and a Sequence Number. So to name it 
Originator Sequence Number tuple is somehow redundant and confusing. The 
term was introduced to describe what is going on in the daemon.

>
> 2. Does a Node somehow send back a message (what message?) to the 
> originator of an OGM when ist first gets the message (so that the 
> originator also can populate his Routingtable) or does the originator 
> has to wait for the other nodes to send their OGM?
Not in the way I guess you mean. Batman nodes never send routing 
information to others in the way that a message contains routing 
information about the topology - well, there is one special case when a 
node sends information about its local view to a visualisation server. 
But this has nothing to do with the routing algorithm as such, this is 
just to provide information necessary to build topology graphs. Batman 
nodes just rebroadcast Originator messages according to a set of rules.

A node rebroadcasts a Originator message, if:

a.) The Originator is a single hop neighbor. If the Originator is a 
bidirectional neighbor and the best ranking router to route traffic to 
itself the Originator message gets re-broadcasted after decreasing TTL by 1

b.) The Originator is a single hop neighbor. If the Originator is a 
bidirectional neighbor but not the best ranking router to route traffic 
to itself the Originator message is re-broadcasted with the 
unidirectional flag added and - you guessed it  - TTL decreased by 1.

c.) The Originator is a single hop neighbor. If the Originator is not a 
bidirectional neighbor the Originator message is re-broadcasted with the 
unidirectional flag added and - you know it - TTL decreased by 1.

d.) The Originator is not a single hop neighbor.  If we receive a 
re-broadcasted message from a single hop neighbor repeating a OGM from 
someone in the distance it gets repeated if our single hop neighbor is 
bidirectional and the best ranking neighbor on route to that Originator 
which created the message. And - of course - TTL decreased by 1.

In all other cases OGMs are not repeated.

A Originator will see others repeating its Originator messages if the 
radio conditions provide a bidirectional link. This is the only case 
when we send feedback to others - btw. we are not addressing them as 
such cause radio is a broadcast medium ;) Of course a OGM with 
unidirectional flag is only helpful for its Originator, to learn: Hey, 
this node has seen me and I have seen it. So we have a bidirectional link!

The strength of B.A.T.M.A.N. is it doesn't rely on other nodes 
opinions/informations about topology that would have to be synchronized. 
A process known to fail and create confusion in a wireless network...  
B.A.T.M.A.N. learns from the fact that broadcasts are received or 
missing, not from information about routing topology contained in 
broadcasts. The information who is the Originator is the only 
information in the package about topology as such...

I guess d.) is somehow what you wondered about. We won't send our 
knowledge back to the Originator in the distance. It will receive our 
OGMs containing only the information that we exist - if radio conditions 
/ topology allow it.

> 3. How can a node tell, that a route is broken? Is there some sort of 
> timeout in every entry in the routingtable or what?
Right, it is the timeout of the last valid OGM-message when we delete a 
route.

> 4. How does the algorithm for the best neighbor work? (I dont need 
> details here, just what factors are taken for computing)
Best ranking neighbor is the neighbor that gives us the Originator 
message with unknown sequence number more reliable and quicker than others.

HTH,

cu elektra
