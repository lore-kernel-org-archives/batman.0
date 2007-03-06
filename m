Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Transfer-Encoding: 7bit
Message-Id: <67D9DF1D-1ACF-4ACF-A1A8-02795AA18027@gmx.net>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
From: Hendrik <cloughar@gmx.net>
Subject: Re: [B.A.T.M.A.N.] How does BATMAN work?
Date: Tue, 6 Mar 2007 10:14:57 +0100
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
first of all thanks for the quick and good help! It realy helped a  
lot (and gave me about 3 more pages to write about BATMAN ;oP)!
Now I got two more Question (hope I don't bother you too much)
1. What Fields are there in the OGM-Package/Header? As to this point  
I got:
	- TTL
	- Seq.No.
	- Orig.IP
	- Unidrectional Flag
   and as possible extension
	- "Reachable Subnets"
	- "Is willing to Serve as a gateway".
Are there any others?

2. Electra wrote:
"A Originator will see others repeating its Originator messages if  
the radio conditions provide a bidirectional link. This is the only  
case when we send feedback to others [..] Of course a OGM with  
unidirectional flag is only helpful for its Originator, to learn:  
Hey, this node has seen me and I have seen it. So we have a  
bidirectional link!" about retransmitting an OGM.
Can the Originator of an OGM use this Information to put his direct  
neighbor in his routingtable (since that is nessesary for knowing "So  
we have a bidirectional link" ;o) ), or does it has to wait for the  
OGM of his direct neighbor (neighbor is the originator) to arrive? (I  
guess waiting is the answer, I just want to be sure)

Thanks
Hendrik

