Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Transfer-Encoding: 7bit
Message-Id: <98187A60-42DA-440C-8DA7-8FCBD30A51D1@gmx.net>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
From: Hendrik <cloughar@gmx.net>
Date: Mon, 5 Mar 2007 16:18:13 +0100
Subject: [B.A.T.M.A.N.] How does BATMAN work?
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

Hi,
I'm currently writing my Masterthesis (Performance of MANET  
Protocols)  and I want to write a little bit about BATMAN. Now I'm  
running into some Problems, since it's not very well documented :(.
I got the informations from https://www.open-mesh.net/batman/ 
documentation/ and the man-page from last Newsletter and figured some  
stuff about how to populate the routingtable.
But a few points are still missing and I would be happy on getting an  
answer on them ;oP (Or is there an even better page to find some  
informations on BATMAN?)

1. From open-mesh Docu: "Originators number their OGMs?, so other  
nodes can decide whether they receive an originator-sequence-number  
touple (OGSN) the first time or repeatedly"
	What's the differens between in OGM and an OGSN? As far as I got to  
know the protocol, there are just OGM-messages, aren't there?!?
2. Does a Node somehow send back a message (what message?) to the  
originator of an OGM when ist first gets the message (so that the  
originator also can populate his Routingtable) or does the originator  
has to wait for the other nodes to send their OGM?
3. How can a node tell, that a route is broken? Is there some sort of  
timeout in every entry in the routingtable or what?
4. How does the algorithm for the best neighbor work? (I dont need  
details here, just what factors are taken for computing)

Thanks!

Greetz
Hendrik



