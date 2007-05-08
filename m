From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] BSD port
Date: Tue, 8 May 2007 13:15:52 +0200
References: <E14D633A-4B9F-439F-BA19-A7EED7F004BF@gmx.ch>
In-Reply-To: <E14D633A-4B9F-439F-BA19-A7EED7F004BF@gmx.ch>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200705081315.52198.lindner_marek@yahoo.de>
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

> I looked into trunk/batman/bsd.c on WCW07 and began to work on it
> this weekend. I believe that i've fixed the routing code and that the
> tun stuff is working but i'm somehow to stupid to actually test the
> stuff. 

nice to hear.


> BUT: ifconfig -a does not show any tun device. Is this normal
> behavior? In my opinion the linux box should create a tun and point
> the default route to it. Am i wrong?

that would be the expected behaviour. Before that happens the gateway client 
tries to establish a TCP connection to the gateway on port 1967. May be you 
have to change your firewall settings accordingly. Use debug level 3 and / or 
4 to find out whats going on. You have to watch out for a message like this:

Adding default route to 105.131.131.1 (0,1,0)


Regards,
Marek

