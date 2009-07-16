Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 16 Jul 2009 19:00:54 +0800
References: <1739bfe0907150649l61d6b0dga6825e84dc45832d@mail.gmail.com>
	<200907160936.25169.sven.eckelmann@gmx.de>
	<9B01495A-3D13-463A-B4FC-3C5E129D32EF@7degrees.co.za>
In-Reply-To: <9B01495A-3D13-463A-B4FC-3C5E129D32EF@7degrees.co.za>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200907161900.54293.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [vis] fixed partial json output
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

On Thursday 16 July 2009 15:45:19 Antoine van Gelder wrote:
> But that is a choopchick and not really important one way or another,
> I think we both agree that switching to blocking sockets is a
> promising idea.
>
> Does anyone with insights into the gooey innards of vis.c have any
> thoughts about this strategy?

I did some little research and noticed that the non-blocking clients were 
introduced by me in revision 491. After reading the commit message I roughly 
remember the reason for the change to non blocking: We were working on the 3D 
visualization tool s3d and could bring the vis server to a standstill by 
running the TCP client (meshs3d) in gdb and stopping its execution. The TCP 
client was not killed but the client would not read from the socket, hence the 
TCP connection was still open but the TCP write call would not come back 
either and hang forever. This solution was a quick fix which probably is far 
from being perfect.

While searching for some info on that topic I found an interesting page which 
might prove helpful: http://blog.netherlabs.nl/articles/2009/01/18/the-
ultimate-so_linger-page-or-why-is-my-tcp-not-reliable

Regards,
Marek


