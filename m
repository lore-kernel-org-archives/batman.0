From: Atis <atis@mikrotik.com>
Date: Tue, 13 Mar 2007 11:45:07 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200703131145.07614.atis@mikrotik.com>
Subject: [B.A.T.M.A.N.] protocol performance
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
a bunch of questions about B.a.t.m.a.n. performance and your future plans.

After studying the source code, I understand that HNA information is included 
in every originator message. Isn't such excessive amount of routing 
information bad for typically limited-capacity wireless links? What are the 
results of real-world tests - there isn't much info in open-mesh.net about 
that. What is the largest network in which B.a.t.m.a.n. have been tested?
Is there some actual evidence that B.a.t.m.a.n. outperforms OLSR?

And if you concerned about its performance, too -  have you considered using 
Fish-eye to improve the algorithm? It could be either periodical TTL 
modifications or not including all HNA information in each originator message 
(i.e. include them in only, say, every 10-th). The second approach could work 
if there some kind of route-request message. Another approach I can think of 
would be to introduce some kind of delay in forwarding as the originator 
packet get farther away from its originator. Or introduce random probability 
of not forwarding it. 

Have you thought of adding some re-active components (like in Hazy Sighted 
Link State protocol)?

What about handling of asymmetrical links? Currently BATMAN appears to have an 
implicit assumption of symmetry.  Is there any plans to incorporate 
asymmetrical link support? 'Neighbor Link Quality' field perhaps? Or do you 
feel that this is something unnecessary for real world setups?

And, finally, what exactly is batman-experimental? A prototype for 
B.a.t.m.a.n.-IV implementation?

Thanks,
A.E.
