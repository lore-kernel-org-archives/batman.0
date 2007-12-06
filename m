From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] strange batman aborting
Date: Thu, 6 Dec 2007 05:34:40 +0100
References: <20071206023407.GA4041@apoderado.ometepe.net>
In-Reply-To: <20071206023407.GA4041@apoderado.ometepe.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200712060534.40574.axel@open-mesh.net>
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

Hi jan,

just sitting here with lui and discussing your problem...
batman usually terminates itself when it finds a firewall blocking its own 
packets. Seems like your firewall starts to drop packets beause the maximum 
number of possible connection tracking has been exceeded. You can find more 
information about that (and also how to increase the limit) here:
http://www.fli4l.de/fileadmin/doc/deutsch/html/fli4l-3.1.3/node9.html

to see the currently tracked connection look at 
cat /proc/net/ip_conntrack

ciao,
lui, axel

On Donnerstag 06 Dezember 2007, Jan Hetges wrote:
> Hi All
> after two weeks uptime bmxd_rv804 just died! and not only that one,
> but on a neighbouring node (~5 days uptime) as well.
> So i restarted them, and about 26hrs later, they are both dead again.
> So i enabled Lui's watchout4batman, maybe i see at least, which one
> dies first. Only unnormal in the log:
>  user.warn kernel: nf_conntrack: table full, dropping packet.
> any ideas?
>
> cheers
>
>   --Jan
>
> p.s. both boxes run kamikaze 7.07 i386


