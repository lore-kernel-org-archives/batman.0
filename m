Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 1 Jun 2012 14:24:48 +0800
References: <1337896842-13154-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1337896842-13154-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201206011424.48795.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batman-adv: clear ADD+DEL (and
	viceversa) events in the same orig-interval
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

On Friday, May 25, 2012 06:00:42 Antonio Quartulli wrote:
> During an OGM-interval (time between two different OGM sendings) the same
> client could roam away and then roam back to us. In this case the node
> would add two events to the events list (that is going to be sent appended
> to the next OGM). A DEL one and an ADD one. Obviously they will only
> increase the overhead (either in the air and on the receiver side) and
> eventually trigger wrong states/events without producing any real effect.
> 
> For this reason we can safely delete any ADD event with its related DEL
> one.

Applied in revision 51ce62d.

Thanks,
Marek
