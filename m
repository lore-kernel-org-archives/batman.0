Return-Path: <ordex@autistici.org>
Date: Tue, 1 Nov 2011 10:10:28 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20111101091027.GA20215@ritirata.org>
References: <1319964962-5092-1-git-send-email-ordex@autistici.org>
	<4EAEEE96.9040808@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4EAEEE96.9040808@gmail.com>
Subject: Re: [B.A.T.M.A.N.] [PATCH 0/6] DAT: Distributed ARP Table
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

On Mon, Oct 31, 2011 at 11:53:10 -0700, Gus Wirth wrote:
> On 10/30/2011 01:55 AM, Antonio Quartulli wrote:
> > Hello people,
> > as most of you may already know, last summer I've been working on the
> > B.A.T.M.A.N.-Adv GSoC project named "DAT: Distributed ARP Table". For who wants
> > to get deeper into the details of the project there are two links:
> > - The GSoC proposal [1]
> > - The DAT wikipage on open-mesh.org [2], with status and ideas description
> > 
> > Just to recap: DAT is a distributes hash table meant to store ARP entries for
> > fast lookup. In a normal scenario, whenever a node wants to communicate with
> > another one, it first needs to issue a broadcast ARP request in order to
> > retrieve its PHY/MAC address. In a sparse network a broadcast message could be
> > lost several times before reaching the real destination so creating high
> > latencies. With DAT, every ARP entries (a pair [IP addr, MAC addr]) is stored on
> > a "computed" set of nodes, therefore in case of ARP request theses nodes can
> > directly be contacted (in unicast) and the needed information can be quickly
> > fetched.
> > 
> > Cheers,
> > Antonio
> > 
> > [1] http://www.google-melange.com/gsoc/project/google/gsoc2011/ordex/4001
> > [2] http://www.open-mesh.org/wiki/batman-adv/DAT
> 
> The link to the Wiki page doesn't work.
> 
> The actual link:
> 
> http://www.open-mesh.org/wiki/batman-adv/DistributedArpTable
> 
> Except there is no information there :(
> 


Sorry for this, yesterday evening I was restructuring the documentation and I
moved [1] to [2] (I had in mind to write an email about this, but it was late..)

Later, [3] will become the official documenting page of DAT (W.I.P. now).

[1] http://www.open-mesh.org/wiki/batman-adv/DAT
[2] http://www.open-mesh.org/wiki/batman-adv/GSOC2011_DAT
[3] http://www.open-mesh.org/wiki/batman-adv/DistributedArpTable

Cheers,

-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
