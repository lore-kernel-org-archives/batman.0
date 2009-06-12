From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 13 Jun 2009 05:38:06 +0800
References: <5161afcd0906111040v1e2831ccv79c8ab6a5ca6cb58@mail.gmail.com>
	<200906130408.45362.lindner_marek@yahoo.de>
	<5161afcd0906121327m603d4c4ftc02458f30d39ff9c@mail.gmail.com>
In-Reply-To: <5161afcd0906121327m603d4c4ftc02458f30d39ff9c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200906130538.06620.lindner_marek@yahoo.de>
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

On Saturday 13 June 2009 04:27:44 Jacob Marble wrote:
> > This message indicates that this nodes already has one interface which is
> > not activate. Could you post "cat /proc/net/batman-adv/interfaces" after
> > you get this result ?
>
> "echo 'ath0' > interfaces"
> "cat interfaces"
> ath0
>
> [     97532] Adding interface: ath0
> [     97532] Can't activate module: the primary interface is not active
> [     97534] Adding route towards: 00:15:6d:a7:6a:14 (via
> 00:15:6d:a7:6a:14) [     97534] Creating new global hna entry:
> 00:ff:cf:5c:68:e0 (via 00:15:6d:a7:6a:14)

It looks like a bug that I fixed in revision 1254. What version are you using ?

Regards,
Marek

