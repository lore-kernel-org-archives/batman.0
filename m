From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 30 Apr 2009 11:17:30 +0800
References: <4313f3060904281042l39d51140we6440d1cff0b74c7@mail.gmail.com>
	<200904291114.21272.lindner_marek@yahoo.de>
	<4313f3060904290709pa110250id52cf0c176e977f8@mail.gmail.com>
In-Reply-To: <4313f3060904290709pa110250id52cf0c176e977f8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200904301117.31036.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Gateway on multiple interfaces
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

On Wednesday 29 April 2009 22:09:45 Nathan Wharton wrote:
> Yes.  It occurs if the interfaces through which the gateway and client
> can communicate are not the interfaces listed first on the command
> line.

I just cooked a patch that should ignore these IP inconsistencies. Please try 
revision 1255 and let us know if it helped.


> Will it still be in effect if it is no longer the gateway, and the
> gateway moves to another node in the mesh?  All the nodes start with
> -r 2, and a batmand -c -g is issued on a node that finds an uplink.
> If it loses the uplink, batmand -c -r 2 is issued, and
> --disable-client-nat should still be on.

Ok, you are right. In your setup it makes sense.

Regards,
Marek

