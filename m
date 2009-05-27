From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 28 May 2009 02:42:12 +0800
References: <278AF6CA06F13D4C9E9F69C7B9AB3B8302E8D24B@MBX21.stu.nus.edu.sg>
	<200905272329.46313.lindner_marek@yahoo.de>
	<560c7c9a0905270839t768570bdo22a862ab31f8863c@mail.gmail.com>
In-Reply-To: <560c7c9a0905270839t768570bdo22a862ab31f8863c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200905280242.13316.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] MultiRadio Batman
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

On Wednesday 27 May 2009 23:39:37 Benjamin Henrion wrote:
> Let's say a packet comes from node A interface ath0 of node B, and
> there is a route on node B for the packet to go to node C, route which
> use the same interface ath0. In this case, you might want to add a
> cost to hop over the same wireless interface.

Ok, good idea. I quickly made a patch:
http://www.open-mesh.net/changeset/1276

Feel free to test it. :-)

Regards,
Marek

