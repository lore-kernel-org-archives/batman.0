Date: Tue, 9 Jan 2007 12:45:42 +0100 (MET)
From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] path selection
References: <200701082002.31400.axel@notmail.org>
In-Reply-To: <200701082002.31400.axel@notmail.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200701091223.07813.lindner_marek@yahoo.de>
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

> However, in this case, that is not the best choice since every second
> packet send via A-c-D needs to be retransmitted on the link A-c, which
> would not be necessary if send via A-b-D .
> Don't know if you agree, ...is that reasonable? Also I don't have any
> simple approach in mind to solve this but it might be worth to reconsider.

I think you made a good point but I even would go a step further. Consider 
this: A downloads a file from D thus using D-b-A  (with 50% packet loss). But 
each packet has to be acknowledged and every second acknowledgement is also 
lost (via A-c-D) . That is why D will resend every second packet and the 
throughput will suffer even more.

I think we should find a solution here but up to now I don't have a clue how 
to do it.

Regards,
Marek
