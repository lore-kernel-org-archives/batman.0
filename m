From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv debian announcement
Date: Mon, 17 Nov 2008 01:11:32 +0800
References: <200811170004.23285.lindner_marek@yahoo.de>
	<5635aa0d0811160830r5521a8a4he0d5b22665664d7@mail.gmail.com>
	<20081116164831.GA21213@pandem0nium>
In-Reply-To: <20081116164831.GA21213@pandem0nium>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200811170111.32580.lindner_marek@yahoo.de>
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

On Monday 17 November 2008 00:48:31 Simon Wunderlich wrote:
> yep, bmxd/batman0.3 and batman-adv are both not compatible to each
> other.

Let me try to be clear at this point: You can run batman and batman-adv at the 
same time - no problem here. But you can't expect a batman node and a batman-
adv node to talk to each other. Batman is not aware of batman-adv and vice 
versa because they operate on different layers.

Regards,
Marek

