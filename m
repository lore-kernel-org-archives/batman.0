From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv-kernelland: Fix memory
	corruption bug
Date: Thu, 4 Dec 2008 10:30:03 +0800
References: <DFF8A357-1AF1-4F11-BE89-46DD131FA7FF@gmail.com>
In-Reply-To: <DFF8A357-1AF1-4F11-BE89-46DD131FA7FF@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200812041030.17606.lindner_marek@yahoo.de>
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


Hey,

> Turned out to be a simple typo, which I've fixed in the following
> patch. When resizing the packet_buff struct in batman_if, the new
> length was being updated but the old length was being used for the
> kmalloc(), causing something later to think it had more memory
> allocated to write to, hence writing past the end of the allocation.

wow - nice catch ! 
I happily applied your patch (revision 1173).  :-)

Regards,
Marek


