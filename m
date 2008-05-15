From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] 0.3 final <-> quagga
Date: Thu, 15 May 2008 10:12:48 +0800
References: <51B22798-78A8-4425-BAEA-530297B1518A@cslab.ece.ntua.gr>
	<200805150252.45068.lindner_marek@yahoo.de>
	<CB6D3CEE-C8C6-4047-AED4-AAF9F90EB2CF@cslab.ece.ntua.gr>
In-Reply-To: <CB6D3CEE-C8C6-4047-AED4-AAF9F90EB2CF@cslab.ece.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200805151012.48270.lindner_marek@yahoo.de>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


Hi,

> This is because you use a "while true" loop.

I'm well aware of that. For you that might be enough but in general the 
solution is not really perfect. I will get flooded with questions why batman 
uses 100% cpu power.  ;-)
What about sending a special "EXIT" command to give the child the possibility 
to clean up. If the child is not dead after 10 seconds batman kills it.


> Even simpler... Much better.

Yeah - I like it simple. Thanks for the idea and thanks Simon for input.

Greetings,
Marek
