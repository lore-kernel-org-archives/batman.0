From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 13 Jun 2009 04:08:45 +0800
References: <5161afcd0906111040v1e2831ccv79c8ab6a5ca6cb58@mail.gmail.com>
	<5161afcd0906120821w5698c18ag7b993869377e3d61@mail.gmail.com>
	<5161afcd0906121019w4ec402a2ged0c622013515ea6@mail.gmail.com>
In-Reply-To: <5161afcd0906121019w4ec402a2ged0c622013515ea6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200906130408.45362.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman advanced in openwrt
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

On Saturday 13 June 2009 01:19:51 Jacob Marble wrote:
> Some of my nodes cannot see each other...  For example, node 1 can
> battool ping node 2, but node 2 cannot battool ping node 1.  

That would be pretty strange as batman always has to make sure that the 
connection goes in both directions. Can you post the originators output plus 
the batping result ?


> "cat ath0 > /proc/net/batman-adv/interfaces"
> produces:
> "Can't activate module: the primary interface is not active"

This message indicates that this nodes already has one interface which is not 
activate. Could you post "cat /proc/net/batman-adv/interfaces" after you get 
this result ?


> The node that can ping out, but not be pinged gave the following before it
> died:
>
> "Could not read from deactivated interface <NULL>!"

Can you explain the exact steps to reproduce this behaviour ?

Regards,
Marek

