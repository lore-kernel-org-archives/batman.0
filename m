From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 27 May 2009 17:33:45 +0800
References: <278AF6CA06F13D4C9E9F69C7B9AB3B8302E8D24B@MBX21.stu.nus.edu.sg>
In-Reply-To: <278AF6CA06F13D4C9E9F69C7B9AB3B8302E8D24B@MBX21.stu.nus.edu.sg>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200905271733.45276.lindner_marek@yahoo.de>
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


Hi,


> Further since our nodes have two radio we are looking at taking
> advantage of the same. Any pointers from a coding perspective to tackle
> this would be great as I am hoping to publish the same.

what do you mean ? You want to know where in the code batman handles multiple 
radio interfaces ?


> Also does Batman advanced operate in Monitor mode?

Unlike MIT roofnet the batman kernel module does not operate inside of the wifi 
driver. Batman does not care about the underlying driver / mode / etc - it can 
run on anything that transmits Ethernet packets. 

Regards,
Marek

