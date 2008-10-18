From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Problem with gateway-dhcp
Date: Sat, 18 Oct 2008 12:18:53 +0800
References: <200810161948.46530.lindner_marek@yahoo.de>
	<48F886F6.5030603@irt.de>
In-Reply-To: <48F886F6.5030603@irt.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200810181218.53935.lindner_marek@yahoo.de>
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

On Friday 17 October 2008 20:37:10 Tobias Gieseke wrote:
> Strange: When I'm setting up the Network without Batman (setting a fixed
> gateway on the client) I can ping the Gateway in the WAN. As soon as I
> start the batmand with -g on the Mesh-Gateway the ping stops. Besides,
> the ping does not end up in an error-message it just doesn't answer.

It sounds like your ping is going in the right direction but there is no route 
back (the host that wants to send an answer has no routing information to 
route the packet back to its origin). Usually, you can solve that by adding 
routes at the other end or via NAT. 

Its rather difficult to help you that way. I suggest you join our IRC channel on 
irc.freenode.org. You will find us in the #batman channel. There we can debug 
your problems interactively.  :-)

Regards,
Marek

