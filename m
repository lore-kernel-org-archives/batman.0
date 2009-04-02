From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 3 Apr 2009 01:48:34 +0800
References: <1238682192-25240-1-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1238682192-25240-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200904030148.34765.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] Don't access random memory after
	forwarding broadcast
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

On Thursday 02 April 2009 22:23:12 Sven Eckelmann wrote:
> B.A.T.M.A.N. advanced iterates over every known interface when receiving
> data and tries to forward as much as possible data from the same
> interface as possible using a while-loop inside the outer loop.
> When it receives a broadcast ethernet frame which needs to be forwarded
> again it will try to send it to every known interface again. This loop
> is inside the first one and used the same pos variable as the outer
> loop. After the inner loop has finished it will point to a memory
> location which is not part of the interface list, but the while loop
> starts again and tries to access this memory region without knowing what
> it is and to what it belongs. This could lead to a kernel oops or any
> kind of other unspecified behavior of the kernel.
> The inner loop should use a seperate position variable to iterate over
> all interfaces for the broadcast.

Great catch !

Regards,
Marek

