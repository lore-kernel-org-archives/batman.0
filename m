Return-Path: <ordex@autistici.org>
Date: Fri, 25 Nov 2011 12:17:08 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20111125111708.GC17321@autistici.org>
References: <1322173279-18338-1-git-send-email-ordex@autistici.org>
	<1322173279-18338-6-git-send-email-ordex@autistici.org>
	<20111125084556.GG6836@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20111125084556.GG6836@lunn.ch>
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 5/7] batman-adv: Distributed ARP Table
 - add snooping functions for ARP messages
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Fri, Nov 25, 2011 at 09:45:56AM +0100, Andrew Lunn wrote:
> Hi Antonio
> 
> General question. In the Linux ARP decode code is:
> 
> /*
>  *      Check for bad requests for 127.x.x.x and requests for multicast
>  *      addresses.  If this is one such, delete it.
>  */
>         if (ipv4_is_loopback(tip) || ipv4_is_multicast(tip))
>                 goto out;
> 
> I don't see the same filtering here. What would happen if you did
> receiver and cached such a bad request?

atually there isnot such control over the arp message content. In case
of, let's say, a malicious ARP message of this type, it is stored like
any other one.

> 
> In a similar direction, how does duplicate address detection work?
> i.e. i ARP my own address to see if somebody else is using it? 
> 
> Or do i just need to RTFM your GSOC documentation :-)
> 

Don't think so. Actually I/we didn't think too much about this kind of
cases. Well, a duplicate entry is simply overwritten: I mean, if we
already have the entry [IPa,MACa] in the table, any other ARP reply containing
[IPa,MACb] will update the older one and MACa will be lost.

Do you expect a different behaviour? Can I do it better?

Cheers,

-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara ☭
