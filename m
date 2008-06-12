Message-ID: <560c7c9a0806120143v1ac8c6f0u9ea4f0a73a3be731@mail.gmail.com>
Date: Thu, 12 Jun 2008 10:43:24 +0200
From: "Benjamin Henrion" <bh@udev.org>
Sender: zoobab@gmail.com
Subject: Re: [B.A.T.M.A.N.] Multiple radios to improve throughput
In-Reply-To: <30352.75.128.50.239.1213242809.squirrel@corp.changind.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <48448358.4070505@changind.com>
	<30352.75.128.50.239.1213242809.squirrel@corp.changind.com>
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

On Thu, Jun 12, 2008 at 5:53 AM, Shane Chao <schao@changind.com> wrote:
> Hi all,
>
> I ran another iperf test with the following scenario below:
>
> node 1          node 2          node 3
> ------          ------          ------
>  ath0 <--ch 1--> ath0
>                  ath1 <--ch 11-> ath0
>
> Both nodes 1 and 3 are still using WRAP board w/ 266MHz cpu with single
> radio inside but this time I replaced node 2 with a desktop PC w/ 1GHz cpu
> and 2 radios.  The PC is running Ubuntu Linux and Madwifi drivers.  The
> result of iperf from node 1 to 3 isn't any better than when node 2 was
> using WRAP w/ 2 radios.  I was expecting higher throughput from node 1 to
> 3 due to a faster cpu on node 2 to forward packets between the 2 radios
> inside but I am now confused.
>
> I am currently not running Batman and instead manually creating the route
> table in trying to isolate the throughput problem.
>
> Maybe there is some configuration parameters that need to be set on node
> 2?  Any advice would be appreciated.

Try to scan if you don't have any ap on the same channel or
overlapping channels in the neighborhood. Then, put the ch1 on 1 and
the ch2 on 14. That would maximise the separation.

And try this outdoor in order to avoid reflexions indoor.

--
Benjamin Henrion <bhenrion at ffii.org>
FFII Brussels - +32-484-566109 - +32-2-4148403
