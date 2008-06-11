From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] 0.3 final <-> quagga
Date: Wed, 11 Jun 2008 23:45:06 +0800
References: <51B22798-78A8-4425-BAEA-530297B1518A@cslab.ece.ntua.gr>
	<77182109-977E-4598-BD0B-ED38BCED2D68@cslab.ece.ntua.gr>
	<E2361084-04EE-46FD-A64C-631DE73E21AB@cslab.ece.ntua.gr>
In-Reply-To: <E2361084-04EE-46FD-A64C-631DE73E21AB@cslab.ece.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200806112345.06399.lindner_marek@yahoo.de>
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

On Wednesday, 14. May 2008 21:51:16 Antony Chazapis wrote:
> I think that waiting and then killing the process is not needed. If
> you just
> close the pipe, the other end should notice that there is an EOF at
> stdin and die.

Ok, I applied your idea to the trunk and changed the demo script accordingly. 
See revision 1080. Sending EXIT or something like that is even uglier ...

Greetings,
Marek


