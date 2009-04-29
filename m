MIME-Version: 1.0
In-Reply-To: <200904271701.54989.lindner_marek@yahoo.de>
References: <238a15490904202025u4ff40130ue2e57f63db9091d0@mail.gmail.com>
	<200904271701.54989.lindner_marek@yahoo.de>
Date: Wed, 29 Apr 2009 13:19:54 -0500
Message-ID: <238a15490904291119v191e153dj781872163056094b@mail.gmail.com>
From: Gargi Purohit <gaargie@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] vis server - global or local map?
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

Ok so once VIS Servers synchronize - do they get updated with each
other's information. i.e. do they collate all information it got from
other vis servers to get some kind of mega information?

Basically assuming i have all nodes in a network working as vis
servers - can querying one vis server at a given point in time
give me a map of the entire network?

On Mon, Apr 27, 2009 at 4:01 AM, Marek Lindner <lindner_marek@yahoo.de> wrote:
>
> Hi,
>
>> I wanted to know if the entire network map is made available to each
>> and every node OR the node has information only about its local
>> connectivity to its neighbors and max the neighbors immediate
>> connectivity.
>
> I'm not entirely sure about your question but I'll do my best to answer it.
> Once you enable the vis server the node will activate a flag in his originator
> messages indicating that you can send vis information. All nodes receiving
> this OGM will send their vis client data to this node.
> If you have several vis servers (due to out fo range problems) the nodes will
> send their information to the nearest vis server whereas the vis server
> themselves will sync with each other.
>
> Hope it helps clarifying the situation,
> Marek
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>
